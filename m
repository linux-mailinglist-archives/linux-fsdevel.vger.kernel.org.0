Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43EC26785A4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jan 2023 20:00:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbjAWTAK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Jan 2023 14:00:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232144AbjAWS7y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Jan 2023 13:59:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7129D468A;
        Mon, 23 Jan 2023 10:59:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 10265B80E3E;
        Mon, 23 Jan 2023 18:59:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2369BC433EF;
        Mon, 23 Jan 2023 18:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1674500386;
        bh=2yFoKdoKKqEamhYFBDRoT6KlUCqYPuttTvyUAJee7i0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PTA9WnWXDRVRH3BYoeH6vvai2HfaIdW2CBrUAdXzNrMN+mQ6RDUPJgRmyTIsDPmZ6
         B3BxtiZviM/Q8578OmBqKx+w5fWGwikIveFpV7Rd57D0slJAyWYh3D1yH/kKio6EbJ
         bcJvq1bWpOCmWp11HPjaAOnEhbqlmyHoUsKLr4Y0=
Date:   Mon, 23 Jan 2023 10:59:45 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>, linux-afs@lists.infradead.org,
        linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        cluster-devel@redhat.com, linux-mm@kvack.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-nilfs@vger.kernel.org
Subject: Re: return an ERR_PTR from __filemap_get_folio v2
Message-Id: <20230123105945.958075d46b0a05ffd545e276@linux-foundation.org>
In-Reply-To: <20230122072006.GA3654@lst.de>
References: <20230121065755.1140136-1-hch@lst.de>
        <20230121170641.121f4224a0e8304765bb4738@linux-foundation.org>
        <20230122072006.GA3654@lst.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, 22 Jan 2023 08:20:06 +0100 Christoph Hellwig <hch@lst.de> wrote:

> On Sat, Jan 21, 2023 at 05:06:41PM -0800, Andrew Morton wrote:
> > This patchset doesn't apply to fs/btrfs/ because linux-next contains
> > this 6+ month-old commit:
> 
> Hmm.  It was literally written against linux-next as of last morning,
> which does not have that commit.

Confused.  According to 
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/fs/btrfs/disk-io.c#n4023

it's there today.  wait_dev_supers() has been foliofied.
