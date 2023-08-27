Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00E00789DBA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Aug 2023 13:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbjH0Lz1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 27 Aug 2023 07:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjH0LzF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 27 Aug 2023 07:55:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F8F713E;
        Sun, 27 Aug 2023 04:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=lRX3XcY7QZhlnMmis+AtWCcFQ1ER+dbenUbYjT1H8Bw=; b=oy8ciNpaP7G3VnJYSU4pe0vef0
        4wnwFaobTQcFhQXV6XFwQzQXV1WwdyowU4EuHTH6QQ77K6dFQkdZQ21cu/+YbdMGug1WHOZVamIMG
        mUWZWP3M8ryUg5Kp8uP+Ryh8iYpYuEUJUkto4GQbWQ75iyto9oQjeldsAsLRNhHPTPrnrz1kh70co
        U5Ehg0u/NbzRf3ZeysjbcLBrKo7Q/lZN3Gn7jDgbbLfpbJJDaC+tTmfeV50Ns6Oe/pi65fZkVj+Tf
        ulVcAbfDynZ0Z8Sd9MVtq6QnsfirPnvLQjiWAO9Wb60/1fDfdLiaVEZafJICAUzAcgIgz1IflqJ0g
        XiSuSoog==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qaEM4-00BUYj-0B; Sun, 27 Aug 2023 11:54:56 +0000
Date:   Sun, 27 Aug 2023 12:54:55 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     dianlujitao <dianlujitao@gmail.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux btrfs <linux-btrfs@vger.kernel.org>,
        Linux Filesystem Development <linux-fsdevel@vger.kernel.org>
Subject: Re: Fwd: kernel bug when performing heavy IO operations
Message-ID: <ZOs5j93aAmZhrA/G@casper.infradead.org>
References: <f847bc14-8f53-0547-9082-bb3d1df9ae96@gmail.com>
 <ZOrG5698LPKTp5xM@casper.infradead.org>
 <7d8b4679-5cd5-4ba1-9996-1a239f7cb1c5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7d8b4679-5cd5-4ba1-9996-1a239f7cb1c5@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Aug 27, 2023 at 12:34:54PM +0800, dianlujitao wrote:
> 
> 在 2023/8/27 11:45, Matthew Wilcox 写道:
> > On Sun, Aug 27, 2023 at 10:20:51AM +0700, Bagas Sanjaya wrote:
> > > > When the IO load is heavy (compiling AOSP in my case), there's a chance to crash the kernel, the only way to recover is to perform a hard reset. Logs look like follows:
> > > > 
> > > > 8月 25 13:52:23 arch-pc kernel: BUG: Bad page map in process tmux: client  pte:8000000462500025 pmd:b99c98067
> > > > 8月 25 13:52:23 arch-pc kernel: page:00000000460fa108 refcount:4 mapcount:-256 mapping:00000000612a1864 index:0x16 pfn:0x462500
> > > > 8月 25 13:52:23 arch-pc kernel: memcg:ffff8a1056ed0000
> > > > 8月 25 13:52:23 arch-pc kernel: aops:btrfs_aops [btrfs] ino:9c4635 dentry name:"locale-archive"
> > > > 8月 25 13:52:23 arch-pc kernel: flags: 0x2ffff5800002056(referenced|uptodate|lru|workingset|private|node=0|zone=2|lastcpupid=0xffff)
> > > > 8月 25 13:52:23 arch-pc kernel: page_type: 0xfffffeff(offline)
> > This is interesting.  PG_offline is set.
> > 
> > $ git grep SetPageOffline
> > arch/powerpc/platforms/powernv/memtrace.c:              __SetPageOffline(pfn_to_page(pfn));
> > drivers/hv/hv_balloon.c:                        __SetPageOffline(pg);
> > drivers/hv/hv_balloon.c:                        __SetPageOffline(pg + j);
> > drivers/misc/vmw_balloon.c:             __SetPageOffline(page + i);
> > drivers/virtio/virtio_mem.c:            __SetPageOffline(page);
> > drivers/xen/balloon.c:  __SetPageOffline(page);
> > include/linux/balloon_compaction.h:     __SetPageOffline(page);
> > include/linux/balloon_compaction.h:     __SetPageOffline(page);
> > 
> > But there's no indication that this kernel is running under a
> > hypervisor:
> > 
> > > > 8月 25 13:52:23 arch-pc kernel: Hardware name: JGINYUE X99-8D3/2.5G Server/X99-8D3/2.5G Server, BIOS 5.11 06/30/2022
> Yes, I'm running on bare metal hardware.
> > So I'd agree with Artem, this looks like bad RAM.
> > 
> I ran memtest86+ 6.20 for a cycle and it passed. However, could an OOM
> trigger the bug? e.g., kernel bug fired before the OOM killer has a
> chance to start? Just a guess because the last log entry in journalctl
> before "BUG" is an hour earlier.

The problem is that OOM doesn't SetPageOffline.  The only things that
do are hypervisor guest drivers.  So we've got a random bit being
cleared, and either that's a stray write which happens to land in
the struct page in question, or it's bad hardware.  Since it's a
single bit that's being cleared, bad hardware is the most likely
explanation, but it's not impossible for there to be a bug that's
doing this.  The problem is that it could be almost anything ...
