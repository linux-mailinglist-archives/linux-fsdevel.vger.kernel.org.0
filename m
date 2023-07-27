Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 360F5764454
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jul 2023 05:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbjG0D2C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jul 2023 23:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbjG0D1x (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jul 2023 23:27:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D7F9270E;
        Wed, 26 Jul 2023 20:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fp+wJTtODdQviWNbDKsTcWXH24BvKRTQECYoB+a8a8I=; b=OvbCbZ+mEpxhD6FxPvz86JTX5Z
        rhWIstal6sF1DRGwiVUAwEhIc/ust0Wtj8bo8phyZ5kwIkpf8lNrzyvPptL8ZMBeX5FfVkrpzWzO9
        59xXCPMfWazBy8oeXoMyEgs2M+mkYWXDnXuD2iu+7+KoKGrVMfxv2maqUBzXdukC3RO/KVAdEVFFJ
        zYQZYFIuH90afF7jwbrve8o0SHmgKUhuG2v4Pa61W097dCDu/0nZjDn3ugjZLca/mmkE5GjfO9MBG
        yE4P1KfdYLE9ufD2KGbUXfRc+pzRcJxmagKROJTvhwgdzgD6bRqXOzv7QQhKBrhvMkJo5pP8Fxo2C
        kk2uHUeQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qOrfA-0076Dy-L5; Thu, 27 Jul 2023 03:27:40 +0000
Date:   Thu, 27 Jul 2023 04:27:40 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Daniel Dao <dqminh@cloudflare.com>
Cc:     linux-fsdevel@vger.kernel.org, Dave Chinner <david@fromorbit.com>,
        kernel-team <kernel-team@cloudflare.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, djwong@kernel.org
Subject: Re: Kernel NULL pointer deref and data corruptions with xfs on 6.1
Message-ID: <ZMHkLA+r2K6hKsr5@casper.infradead.org>
References: <CA+wXwBRGab3UqbLqsr8xG=ZL2u9bgyDNNea4RGfTDjqB=J3geQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+wXwBRGab3UqbLqsr8xG=ZL2u9bgyDNNea4RGfTDjqB=J3geQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 21, 2023 at 11:49:04AM +0100, Daniel Dao wrote:
> We do not have a reproducer yet, but we now have more debugging data
> which hopefully
> should help narrow this down. Details as followed:
> 
> 1. Kernel NULL pointer deferencences in __filemap_get_folio
> 
> This happened on a few different hosts, with a few different repeated addresses.
> The addresses are 0000000000000036, 0000000000000076,
> 00000000000000f6. This looks
> like the xarray is corrupted and we were trying to do some work on a
> sibling entry.

I think I have a fix for this one.  Please try the attached.

> 2. Kernel NULL pointer deferencences in xfs_read_iomap_begin
> 
>     BUG: unable to handle page fault for address: 0000000000034668
>     #PF: supervisor read access in kernel mode
>     #PF: error_code(0x0000) - not-present page
>     PGD 11cfd37067 P4D 11cfd37067 PUD b88086067 PMD 0
>     Oops: 0000 [#1] PREEMPT SMP NOPTI
>     CPU: 124 PID: 3831226 Comm: rocksdb:low Kdump: loaded Tainted: G
>      W  O L     6.1.27-cloudflare-2023.5.0 #1
>     Hardware name: HYVE EDGE-METAL-GEN11/HS1811D_Lite, BIOS V0.11-sig 12/23/2022
>     RIP: 0010:xfs_read_iomap_begin (fs/xfs/xfs_iomap.c:1200)
>     Code: 0f 1f 44 00 00 41 57 41 56 41 55 41 54 55 53 48 83 ec 50 48
> 89 14 24 4c 89 44 24 08 65 48 8b 04 25 28 00 00 00 48 89 44 24 48 <48>
> 8b 87 >
>     All code
>     ========
>       0:   0f 1f 44 00 00          nopl   0x0(%rax,%rax,1)
>       5:   41 57                   push   %r15
>       7:   41 56                   push   %r14
>       9:   41 55                   push   %r13
>       b:   41 54                   push   %r12
>       d:   55                      push   %rbp
>       e:   53                      push   %rbx
>       f:   48 83 ec 50             sub    $0x50,%rsp
>       13:   48 89 14 24             mov    %rdx,(%rsp)
>       17:   4c 89 44 24 08          mov    %r8,0x8(%rsp)
>       1c:   65 48 8b 04 25 28 00    mov    %gs:0x28,%rax
>       23:   00 00
>       25:   48 89 44 24 48          mov    %rax,0x48(%rsp)
>       2a:*  48                      rex.W           <-- trapping instruction
>       2b:   8b                      .byte 0x8b
>       2c:   87 00                   xchg   %eax,(%rax)
> 
>     Code starting with the faulting instruction
>     ===========================================
>       0:   48                      rex.W
>       1:   8b                      .byte 0x8b
>       2:   87 00                   xchg   %eax,(%rax)

This one is hard to understand because the decoding of the instruction
got cut off.  But ...

>     RSP: 0018:ffffa63810733a70 EFLAGS: 00010282
>     RAX: 78ac714f0997e100 RBX: ffffa63810733b40 RCX: 0000000000000000
>     RDX: 0000000000004000 RSI: 0000000000000000 RDI: 00000000000347a0

RDI is kind of close to the fault address ... RDI is used as the first
argument in the x86-64 SYSV ABI, and the first parameter to
xfs_read_iomap_begin() is supposed to be a struct inode pointer.

I don't think this is related.

> We also have a deadlock reading a very specific file on this host. We managed to
> do a kdump on this host and extracted out the state of the mapping.

This is almost certainly a different bug, but alos XArray related, so
I'll keep looking at this one.
