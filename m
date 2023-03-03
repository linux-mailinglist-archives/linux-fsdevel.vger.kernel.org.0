Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E48976A8F08
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Mar 2023 02:59:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjCCB7H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Mar 2023 20:59:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjCCB7F (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Mar 2023 20:59:05 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8722516AE4;
        Thu,  2 Mar 2023 17:59:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id EC310CE2021;
        Fri,  3 Mar 2023 01:59:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2059C433D2;
        Fri,  3 Mar 2023 01:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677808741;
        bh=wWK0TKtrXgkBt+vb5U8Z0HtNKqKXOfcAjYxIxt05B5Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M4iWUGhO7pAc7f2BcIx9ymL2rpZiYt4cEkOBPC2iYi8hTEXRZyWxa/dQVXKoFYFMo
         hP0Jp8MBFg1JyKYc7J+/ood93fuB78xi4LyDek+yiYQCZOPgZmAias3x+F0hT826d/
         LTO68YZk7TcvaFNMs8t6war/kvntEvGjXC3tkP9oM7S/QgTKeRh68KNDhHu6JGT1EX
         Tsn3ZxLgYIVS/hWpWkNvEJkM7/JQ0aWBiH8G7gMeuhqMHCHvpM+uVjI8o5NB1C6Pbu
         7bMhXY9n0BSIjoxXSuvxHZXyX6NGaIiR9hpQxMZmgnK/vfqdzBawnRuoulR8/gkpvC
         QYOdJVZiQWlDA==
Date:   Thu, 2 Mar 2023 18:58:58 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-block@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] Cloud storage optimizations
Message-ID: <ZAFUYqAcPmRPLjET@kbusch-mbp.dhcp.thefacebook.com>
References: <Y/7L74P6jSWwOvWt@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y/7L74P6jSWwOvWt@mit.edu>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 28, 2023 at 10:52:15PM -0500, Theodore Ts'o wrote:
> Emulated block devices offered by cloud VM’s can provide functionality
> to guest kernels and applications that traditionally have not been
> available to users of consumer-grade HDD and SSD’s.  For example,
> today it’s possible to create a block device in Google’s Persistent
> Disk with a 16k physical sector size, which promises that aligned 16k
> writes will be atomically.  With NVMe, it is possible for a storage
> device to promise this without requiring read-modify-write updates for
> sub-16k writes. 

I'm not sure it does. NVMe spec doesn't say AWUN writes are never a RMW
operation. NVMe suggests aligning to NPWA is the best way to avoid RMW, but
doesn't guarantee that, nor does it require this limit aligns to atomic
boundaries. NVMe provides a lot of hints, but stops short of promises. Vendors
can promise whatever they want, but that's outside spec.

> All that is necessary are some changes in the block
> layer so that the kernel does not inadvertently tear a write request
> when splitting a bio because it is too large (perhaps because it got
> merged with some other request, and then it gets split at an
> inconvenient boundary).

All the limits needed to optimally split on phyiscal boundaries exist, so I
hope we're using them correctly via get_max_io_size().

That said, I was hoping you were going to suggest supporting 16k logical block
sizes. Not a problem on some arch's, but still problematic when PAGE_SIZE is
4k. :)
