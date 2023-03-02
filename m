Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9466C6A7A25
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Mar 2023 04:50:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjCBDud (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Mar 2023 22:50:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjCBDuc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Mar 2023 22:50:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 941B41EFCA;
        Wed,  1 Mar 2023 19:50:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 70E85B81035;
        Thu,  2 Mar 2023 03:50:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DD36C433D2;
        Thu,  2 Mar 2023 03:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677729028;
        bh=gX6kt3+5lfprjA67P4c0hJG42XWIpdAERPk/U9u9xJI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dJWANL6fOjDnDK2WTU1fWA4MqapEuhfddjcndYuVRPrY2OTCWm7zNBsgWO/Cx4c8u
         ajDGVmhK/KMkqoKaEBw3lvSWkV/KqQ27bdtl1j+iL8dYYl6o1v6Ffqgj4BcW5EVMWZ
         JrMffy7qG8DW39NW7QWj0z2i8zA1ll/Tj7wN7AuRCJIXMuZpShNjtJJKiVjM049Cul
         H7SdrbMBY1RO+/PYBER7yKzgy7bgle0KPF4asvDHEkiGpVGptxkCBevZqfBAcZyGM2
         4mIcOEHpfo0jsRxqvgBuZdsUIDV0yxSwtEm9EQ4r9CEzuc/vBQngDZtzuJPvX6bDna
         2WEehCQl7JCBA==
Date:   Wed, 1 Mar 2023 19:50:27 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-block@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] Cloud storage optimizations
Message-ID: <ZAAdA5UG+qrJLRmY@magnolia>
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
> sub-16k writes.  All that is necessary are some changes in the block
> layer so that the kernel does not inadvertently tear a write request
> when splitting a bio because it is too large (perhaps because it got
> merged with some other request, and then it gets split at an
> inconvenient boundary).

Now that we've flung ourselves into the wild world of Software Defined
Secure Storage as a Service*, I was thinking --

T10 PI gives the kernel a means to associate its own checksums (and a
goofy u16 tag) with LBAs on disk.  There haven't been that many actual
SCSI devices that implement it, but I wonder how hard it would be for
clod storage backends to export things like that?  The storage nodes
often have a bit more CPU power, too.

Though admittedly the advent of customer-managed FDE in the cloud and
might make that less useful?

Just my random 2c late at night,

--D

* SDSSAAS: what you get from banging head on keyboard in frustration

> There are also more interesting, advanced optimizations that might be
> possible.  For example, Jens had observed the passing hints that
> journaling writes (either from file systems or databases) could be
> potentially useful.  Unfortunately most common storage devices have
> not supported write hints, and support for write hints were ripped out
> last year.  That can be easily reversed, but there are some other
> interesting related subjects that are very much suited for LSF/MM.
> 
> For example, most cloud storage devices are doing read-ahead to try to
> anticipate read requests from the VM.  This can interfere with the
> read-ahead being done by the guest kernel.  So being able to tell
> cloud storage device whether a particular read request is stemming
> from a read-ahead or not.  At the moment, as Matthew Wilcox has
> pointed out, we currently use the read-ahead code path for synchronous
> buffered reads.  So plumbing this information so it can passed through
> multiple levels of the mm, fs, and block layers will probably be
> needed.
