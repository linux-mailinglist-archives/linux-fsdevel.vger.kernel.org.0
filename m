Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69AC6789B44
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Aug 2023 05:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbjH0Dq2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 26 Aug 2023 23:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbjH0Dpy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 26 Aug 2023 23:45:54 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9E88131;
        Sat, 26 Aug 2023 20:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=VNKySBcBtgRUWUvinnikTDnBGhT+X/ZTvI6YzOLk/ew=; b=GK0DH9dlNOYtWoGFiq9LLQCjlZ
        RFQy/iog1VW11LrdjAxaxvy/vmAx3xOJzQ+MyUwAIGqmWXM8FwsIFDjOw4mW+E4zlXrEM66BjJRfA
        oo/vi94oac7dm7dhvpvH/HwaUGqmEQ0NkH64prISTc92hDRKN9oK8PDmztwvQEmWWy4drDZR5iw+R
        KqmHR+PU4dy0UdLryWx0ysKyIjoNa2Xj0pkI880t1R3+Y7R3YluqoX5PeQSz2/XhzVwIsk9gFCxMh
        HaNgtQ5mEhk9+HnNDAgcVikYSlsEEIwi2iPWQp/sAlee9H+T7ASDo6C6TctNfcpDRtPRywynvX6C/
        FAjTzenw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qa6id-009RaN-HK; Sun, 27 Aug 2023 03:45:43 +0000
Date:   Sun, 27 Aug 2023 04:45:43 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, dianlujitao@gmail.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux btrfs <linux-btrfs@vger.kernel.org>,
        Linux Filesystem Development <linux-fsdevel@vger.kernel.org>
Subject: Re: Fwd: kernel bug when performing heavy IO operations
Message-ID: <ZOrG5698LPKTp5xM@casper.infradead.org>
References: <f847bc14-8f53-0547-9082-bb3d1df9ae96@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f847bc14-8f53-0547-9082-bb3d1df9ae96@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Aug 27, 2023 at 10:20:51AM +0700, Bagas Sanjaya wrote:
> > When the IO load is heavy (compiling AOSP in my case), there's a chance to crash the kernel, the only way to recover is to perform a hard reset. Logs look like follows:
> > 
> > 8月 25 13:52:23 arch-pc kernel: BUG: Bad page map in process tmux: client  pte:8000000462500025 pmd:b99c98067
> > 8月 25 13:52:23 arch-pc kernel: page:00000000460fa108 refcount:4 mapcount:-256 mapping:00000000612a1864 index:0x16 pfn:0x462500
> > 8月 25 13:52:23 arch-pc kernel: memcg:ffff8a1056ed0000
> > 8月 25 13:52:23 arch-pc kernel: aops:btrfs_aops [btrfs] ino:9c4635 dentry name:"locale-archive"
> > 8月 25 13:52:23 arch-pc kernel: flags: 0x2ffff5800002056(referenced|uptodate|lru|workingset|private|node=0|zone=2|lastcpupid=0xffff)
> > 8月 25 13:52:23 arch-pc kernel: page_type: 0xfffffeff(offline)

This is interesting.  PG_offline is set.

$ git grep SetPageOffline
arch/powerpc/platforms/powernv/memtrace.c:              __SetPageOffline(pfn_to_page(pfn));
drivers/hv/hv_balloon.c:                        __SetPageOffline(pg);
drivers/hv/hv_balloon.c:                        __SetPageOffline(pg + j);
drivers/misc/vmw_balloon.c:             __SetPageOffline(page + i);
drivers/virtio/virtio_mem.c:            __SetPageOffline(page);
drivers/xen/balloon.c:  __SetPageOffline(page);
include/linux/balloon_compaction.h:     __SetPageOffline(page);
include/linux/balloon_compaction.h:     __SetPageOffline(page);

But there's no indication that this kernel is running under a
hypervisor:

> > 8月 25 13:52:23 arch-pc kernel: Hardware name: JGINYUE X99-8D3/2.5G Server/X99-8D3/2.5G Server, BIOS 5.11 06/30/2022

So I'd agree with Artem, this looks like bad RAM.

> IMO, this looks like it is introduced by page cache (folio) feature.

... because the string "folio" appears in the crash report?  Come on,
Bagas, you can do better than that.
