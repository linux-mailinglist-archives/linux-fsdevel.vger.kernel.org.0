Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA38694ED0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Feb 2023 19:07:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbjBMSHP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Feb 2023 13:07:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbjBMSHN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Feb 2023 13:07:13 -0500
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B95FE069;
        Mon, 13 Feb 2023 10:06:49 -0800 (PST)
Received: by mail-oo1-xc34.google.com with SMTP id y81-20020a4a4554000000b0051a7cd153ddso1272755ooa.10;
        Mon, 13 Feb 2023 10:06:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=14w9OdERKGDj4MxTMXPUUWwKGv7ijojrnNeGVnnrTXs=;
        b=PuQIq42hvolNpGoj2RkGM4V3ZIH6tya4wCcaQ81oE3nMHGjuXX3FG1357OhuPV/y6A
         /HWVAteZjMyCG6cwnENyHe5IaivKyXmUqZStvDGUJ7OrkmgHDect1+uINikj4U6VOjvD
         ZlkfTimvFPgNx4tM/Z5793FaertP9TDjCndVJiBnm3tgWcocmSK++1RpPBIUiIfEKnKH
         oWvthw1ecJ1VoZhAOxjyilpJ0AHBNorqYOENhpGXcvmiDNmManV5+gWKl2GlH89Z36g+
         gKpsXTQ7/akjGd5xpLZrxZ04QayNNLyoL0suBBxBR9tLFCL1uXhhIehkm7sKSB529bZQ
         BcrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=14w9OdERKGDj4MxTMXPUUWwKGv7ijojrnNeGVnnrTXs=;
        b=5/NlS2rsnXGT/MNmmogptbFcNhxQ2b38LF23FcGa4timC8cDlvtS/63bQyXNqCD7SA
         4jkJmqMrpU40fcEpPj1XNlDwTAErRq4RekEQ3tTUE5k7bihpr4QhT8RpJzS8RKTPS1tD
         jvKcvJVQWuEauE6KEWWARsJI8Np5o/kFICVnygGGsSAxGL9w+508h39IgMNdpeSApB3f
         HrbrHcFwMr0WT0V24mniN/w+1N2Y/gRAQR5aTF9mmFdk6sW0BGkUFepbcw7DVwi0Be/b
         EyltneQ6SaLlPZYzMAwKYVaVUzXuJL7lrSAhm8X7YFLQSaWzeW/CKTeaivSSaHyl22eH
         DK5A==
X-Gm-Message-State: AO0yUKWHOL7WiqbzbOoUHk7vCq+C5qt1naEwlsyM/Mg1P/xQrSbR/J81
        IJMJMA4Q/e5JZIbsZZa80MU=
X-Google-Smtp-Source: AK7set/zQV96RU5wiPlPKPC6pe+s5ftwIWDf5f1AJLH45fqf+GA7+RzqPILJrTgzun4OP8Vcn8HRNw==
X-Received: by 2002:a4a:c610:0:b0:4f2:b25b:574 with SMTP id l16-20020a4ac610000000b004f2b25b0574mr10758347ooq.2.1676311594319;
        Mon, 13 Feb 2023 10:06:34 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w12-20020a4ac18c000000b0051a6cb524b6sm5122012oop.2.2023.02.13.10.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 10:06:33 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 13 Feb 2023 10:06:32 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     David Howells <dhowells@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v13 03/12] splice: Do splice read from a buffered file
 without using ITER_PIPE
Message-ID: <20230213180632.GA368628@roeck-us.net>
References: <20230209102954.528942-1-dhowells@redhat.com>
 <20230209102954.528942-4-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230209102954.528942-4-dhowells@redhat.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On Thu, Feb 09, 2023 at 10:29:45AM +0000, David Howells wrote:
> Provide a function to do splice read from a buffered file, pulling the
> folios out of the pagecache directly by calling filemap_get_pages() to do
> any required reading and then pasting the returned folios into the pipe.
> 
> A helper function is provided to do the actual folio pasting and will
> handle multipage folios by splicing as many of the relevant subpages as
> will fit into the pipe.
> 
> The ITER_BVEC-based splicing previously added is then only used for
> splicing from O_DIRECT files.
> 
> The code is loosely based on filemap_read() and might belong in
> mm/filemap.c with that as it needs to use filemap_get_pages().
> 
> With this, ITER_PIPE is no longer used.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>

With this patch in the tree, the "collie" and "mps2" qemu emulations
crash for me. Crash logs are attached. I also attached the bisect log
for "collie".

Unfortunately I can not revert the patch to confirm because the revert
results in compile failures.

Guenter
---
bisect log

# bad: [09e41676e35ab06e4bce8870ea3bf1f191c3cb90] Add linux-next specific files for 20230213
# good: [4ec5183ec48656cec489c49f989c508b68b518e3] Linux 6.2-rc7
git bisect start 'HEAD' 'v6.2-rc7'
# good: [8b065aee8dfbecc978324b204fc897168c9adcd0] Merge branch 'master' of git://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git
git bisect good 8b065aee8dfbecc978324b204fc897168c9adcd0
# bad: [72655d7bf4966cc46ac85ef74b26eb74e251ae4a] Merge branch 'rcu/next' of git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
git bisect bad 72655d7bf4966cc46ac85ef74b26eb74e251ae4a
# good: [55461ffd2b7ee0a8fe4a1f98ae6f4a33771e8193] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
git bisect good 55461ffd2b7ee0a8fe4a1f98ae6f4a33771e8193
# bad: [0f1bf464790dad200077e97d35cd8bb9dd7b8341] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git
git bisect bad 0f1bf464790dad200077e97d35cd8bb9dd7b8341
# good: [c72ebd41e0737e1f1d30dc6eb3d167e8d16dcc3a] Merge branch 'next' of git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git
git bisect good c72ebd41e0737e1f1d30dc6eb3d167e8d16dcc3a
# bad: [501053535caca01f20a9323d3c8dec9ecb7a06b1] Merge branch 'for-6.3/iov-extract' into for-next
git bisect bad 501053535caca01f20a9323d3c8dec9ecb7a06b1
# good: [efde918ac66958c568926120841e7692b1e9bd9d] rxrpc: use bvec_set_page to initialize a bvec
git bisect good efde918ac66958c568926120841e7692b1e9bd9d
# good: [6938b812a638d9f02d3eb4fd07c7aab4fd44076d] Merge branch 'for-6.3/io_uring' into for-next
git bisect good 6938b812a638d9f02d3eb4fd07c7aab4fd44076d
# good: [1972d038a5401781377d3ce2d901bf7763a43589] ublk: pass NULL to blk_mq_alloc_disk() as queuedata
git bisect good 1972d038a5401781377d3ce2d901bf7763a43589
# good: [f37bf75ca73d523ebaa7ceb44c45d8ecd05374fe] block, bfq: cleanup 'bfqg->online'
git bisect good f37bf75ca73d523ebaa7ceb44c45d8ecd05374fe
# bad: [34c5b3634708864d5845cbadad03833c30051e0b] iomap: Don't get an reference on ZERO_PAGE for direct I/O block zeroing
git bisect bad 34c5b3634708864d5845cbadad03833c30051e0b
# bad: [d9722a47571104f7fa1eeb5ec59044d3607c6070] splice: Do splice read from a buffered file without using ITER_PIPE
git bisect bad d9722a47571104f7fa1eeb5ec59044d3607c6070
# good: [cd119d2fa647945d63941d3fd64f4acc9f6eec24] mm: Pass info, not iter, into filemap_get_pages() and unstatic it
git bisect good cd119d2fa647945d63941d3fd64f4acc9f6eec24
# first bad commit: [d9722a47571104f7fa1eeb5ec59044d3607c6070] splice: Do splice read from a buffered file without using ITER_PIPE

---
arm:collie crash

8<--- cut here ---
Unable to handle kernel NULL pointer dereference at virtual address 00000000 when execute
[00000000] *pgd=c14b4831c14b4831, *pte=c14b4000, *ppte=e09b5a14
8<--- cut here ---
Unhandled fault: page domain fault (0x01b) at 0x00000000
[00000000] *pgd=c14b4831, *pte=00000000, *ppte=00000000
Internal error: : 1b [#1] ARM
CPU: 0 PID: 58 Comm: cat Not tainted 6.2.0-rc7-next-20230213 #1
Hardware name: Sharp-Collie
PC is at copy_from_kernel_nofault+0x124/0x23c
LR is at 0xe09b5a84
pc : [<c009d894>]    lr : [<e09b5a84>]    psr: 20000193
sp : e09b5a4c  ip : e09b5a84  fp : e09b5a80
r10: 00000214  r9 : 60000113  r8 : 00000004
r7 : c08b91fc  r6 : e09b5a84  r5 : 00000004  r4 : 00000000
r3 : 00000001  r2 : c14a6ca0  r1 : 00000000  r0 : 00000001
Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment none
Control: 0000717f  Table: c14d4000  DAC: 00000051
Register r0 information: non-paged memory
Register r1 information: NULL pointer
Register r2 information: slab task_struct start c14a6ca0 pointer offset 0 size 3232
Register r3 information: non-paged memory
Register r4 information: NULL pointer
Register r5 information: non-paged memory
Register r6 information: 2-page vmalloc region starting at 0xe09b4000 allocated at kernel_clone+0x78/0x474
Register r7 information: non-slab/vmalloc memory
Register r8 information: non-paged memory
Register r9 information: non-paged memory
Register r10 information: non-paged memory
Register r11 information: 2-page vmalloc region starting at 0xe09b4000 allocated at kernel_clone+0x78/0x474
Register r12 information: 2-page vmalloc region starting at 0xe09b4000 allocated at kernel_clone+0x78/0x474
Process cat (pid: 58, stack limit = 0xfabdb807)
Stack: (0xe09b5a4c to 0xe09b6000)
5a40:                            e09b5a70 e09b5a5c c005a4e4 c087b82c e09b5c14
5a60: e09b5c14 00000000 c08b91fc 80000005 60000113 e09b5a98 e09b5a84 c000cfa8
5a80: c009d77c e09b5ab0 c087b82c e09b5ac0 e09b5a9c c06b8020 c000cf84 c149a840
5aa0: c07df1e0 e09b5c14 c07df1c8 c087f3e4 c08b91fc e09b5b40 e09b5ac4 c000cc28
5ac0: c06b8010 e09b5af0 e09b5ad4 c005e7a4 c005d0b8 e09b5af8 e09b5ae4 c005d0d4
5ae0: c14b4000 e09b5b08 e09b5af4 c06de218 c005e72c e09b5b10 c087b82c e09b5b40
5b00: e09b5b1c c06dcba8 c06de1f4 c07ded54 c087b82c 00000000 80000005 00000000
5b20: c149a840 c07df1e0 c149a8b8 00000004 00000214 e09b5b58 e09b5b44 c000dcec
5b40: c000cb98 80000005 e09b5c14 e09b5b80 e09b5b5c c000dd78 c000dc84 e09b5c14
5b60: e09b5b6c e09b5c14 80000005 00000000 c149a840 e09b5bc0 e09b5b84 c000df6c
5b80: c000dd2c 00000000 c087ba8c c14a6ca0 00010000 c08bacc0 00000005 e09b5c14
5ba0: c087f688 c000e184 00000000 c14a6ca0 c149f158 e09b5bd8 e09b5bc4 c000e22c
5bc0: c000ddc0 00000005 e09b5c14 e09b5c10 e09b5bdc c000e33c c000e190 c14a6ca0
5be0: c00526a4 c14a6ca0 c088607c 60000013 00000000 20000013 ffffffff e09b5c48
5c00: dfb10900 e09b5cb4 e09b5c14 c0008e10 c000e304 c14b3a20 dfb10900 dfb10900
5c20: 60000093 dfb10900 00000000 c14b3a20 60000013 dfb10900 00000000 c149f158
5c40: e09b5cb4 e09b5cb8 e09b5c60 c0093a7c 00000000 20000013 ffffffff 00000051
5c60: c00a5a88 00000cc0 dfb10900 00000000 00000cc0 c149f128 e09b5cb4 e09b5c88
5c80: c009507c c087b82c e09b5c90 e09b5d94 e09b5d68 00000000 c149f128 dfb10900
5ca0: 00000000 c149f158 e09b5d3c e09b5cb8 c0099714 c0093a20 dfff1d14 c14a7258
5cc0: c00e28bc 00000002 e09b5d1c e09b5cd8 00010000 00000001 c14b3af0 c14b3a20
5ce0: c14a6ca0 00000010 00000001 c14b3a20 c149f128 c14b3af0 00000000 00000000
5d00: 00000000 00000000 00000000 c087b82c 80000113 00000000 00000000 e09b5f18
5d20: 00010000 c14b5600 00000000 00010000 e09b5e04 e09b5d40 c013019c c0099324
5d40: 60000113 00000000 c14a6ca0 c14a6ca0 e09b5d84 c14b3a20 c087ba8c c14a6ca0
5d60: 00000000 00000000 c14b3a20 00000000 00000000 00000000 00000000 00000000
5d80: 00000000 00000000 00000000 00000000 fffffffe ffff0000 000001a9 00000000
5da0: c832b34f c088607c 60000013 00000000 e09b5f18 c0a90ec8 01000000 c14b5600
5dc0: e09b5e04 e09b5dd0 c0055788 c0054dec 00000000 c087b82c c0102d90 c14b5600
5de0: 00000000 e09b5f18 e09b5f18 c14b3a20 00000000 00010000 e09b5e94 e09b5e08
5e00: c0130ec0 c01300d0 00000001 00000000 c0102d90 c14b5600 e09b5e9c e09b5e28
5e20: c06ef2a8 c005582c 00000001 00000000 c0102d90 e09b5e40 c0055f60 c0052e4c
5e40: e09b5e5c e09b5e50 c14b5634 00000001 00000001 00000002 c000f22c c149a894
5e60: 00000000 c087b82c c14d1e00 00010000 c14b3a20 c14b5600 e09b5f18 c0130e48
5e80: 01000000 00000001 e09b5ec4 e09b5e98 c012fee0 c0130e54 00000000 c06ef210
5ea0: c0102d90 00000000 c14b5600 c14b3a20 e09b5f18 00000000 e09b5ef4 e09b5ec8
5ec0: c0131d94 c012fe50 00000000 c0052e4c c14b3a20 00000000 00000000 01000000
5ee0: c14b3a20 c0c2aa20 e09b5f5c e09b5ef8 c00f72d8 c0131d28 00000000 c149a8b8
5f00: 00000002 00000255 c14b5600 00000000 c0c2aa20 c00f8f4c 00000000 00000000
5f20: 00000000 00000000 e09b5f74 c087b82c c000df18 00000000 00000000 00000003
5f40: 000000ef c0008420 c14a6ca0 01000000 e09b5fa4 e09b5f60 c00f8f4c c00f7170
5f60: 7fffffff 00000000 e09b5fac e09b5f78 c000e278 c087b82c befeee88 01000000
5f80: 00000000 01000000 000000ef c0008420 c14a6ca0 00000000 00000000 e09b5fa8
5fa0: c0008260 c00f8e38 01000000 00000000 00000001 00000003 00000000 01000000
5fc0: 01000000 00000000 01000000 000000ef 00000001 00000001 00000000 00000000
5fe0: b6e485d0 befedc74 00019764 b6e485dc 60000010 00000001 00000000 00000000
Backtrace:
 copy_from_kernel_nofault from is_valid_bugaddr+0x30/0x7c
 r9:60000113 r8:80000005 r7:c08b91fc r6:00000000 r5:e09b5c14 r4:e09b5c14
 is_valid_bugaddr from report_bug+0x1c/0x114
 report_bug from die+0x9c/0x398
 r7:c08b91fc r6:c087f3e4 r5:c07df1c8 r4:e09b5c14
 die from die_kernel_fault+0x74/0xa8
 r10:00000214 r9:00000004 r8:c149a8b8 r7:c07df1e0 r6:c149a840 r5:00000000
 r4:80000005
 die_kernel_fault from __do_kernel_fault.part.0+0x58/0x94
 r7:e09b5c14 r4:80000005
 __do_kernel_fault.part.0 from do_page_fault+0x1b8/0x338
 r7:c149a840 r6:00000000 r5:80000005 r4:e09b5c14
 do_page_fault from do_translation_fault+0xa8/0xb0
 r10:c149f158 r9:c14a6ca0 r8:00000000 r7:c000e184 r6:c087f688 r5:e09b5c14
 r4:00000005
 do_translation_fault from do_PrefetchAbort+0x44/0x98
 r5:e09b5c14 r4:00000005
 do_PrefetchAbort from __pabt_svc+0x50/0x80
Exception stack(0xe09b5c14 to 0xe09b5c5c)
5c00:                                              c14b3a20 dfb10900 dfb10900
5c20: 60000093 dfb10900 00000000 c14b3a20 60000013 dfb10900 00000000 c149f158
5c40: e09b5cb4 e09b5cb8 e09b5c60 c0093a7c 00000000 20000013 ffffffff
 r8:dfb10900 r7:e09b5c48 r6:ffffffff r5:20000013 r4:00000000
 filemap_read_folio from filemap_get_pages+0x3fc/0x7a4
 r10:c149f158 r9:00000000 r8:dfb10900 r7:c149f128 r6:00000000 r5:e09b5d68
 r4:e09b5d94
 filemap_get_pages from generic_file_buffered_splice_read.constprop.0+0xd8/0x400
 r10:00010000 r9:00000000 r8:c14b5600 r7:00010000 r6:e09b5f18 r5:00000000
 r4:00000000
 generic_file_buffered_splice_read.constprop.0 from generic_file_splice_read+0x78/0x310
 r10:00010000 r9:00000000 r8:c14b3a20 r7:e09b5f18 r6:e09b5f18 r5:00000000
 r4:c14b5600
 generic_file_splice_read from do_splice_to+0x9c/0xbc
 r10:00000001 r9:01000000 r8:c0130e48 r7:e09b5f18 r6:c14b5600 r5:c14b3a20
 r4:00010000
 do_splice_to from splice_file_to_pipe+0x78/0x80
 r8:00000000 r7:e09b5f18 r6:c14b3a20 r5:c14b5600 r4:00000000
 splice_file_to_pipe from do_sendfile+0x174/0x59c
 r9:c0c2aa20 r8:c14b3a20 r7:01000000 r6:00000000 r5:00000000 r4:c14b3a20
 do_sendfile from sys_sendfile64+0x120/0x148
 r10:01000000 r9:c14a6ca0 r8:c0008420 r7:000000ef r6:00000003 r5:00000000
 r4:00000000
 sys_sendfile64 from ret_fast_syscall+0x0/0x44
Exception stack(0xe09b5fa8 to 0xe09b5ff0)
5fa0:                   01000000 00000000 00000001 00000003 00000000 01000000
5fc0: 01000000 00000000 01000000 000000ef 00000001 00000001 00000000 00000000
5fe0: b6e485d0 befedc74 00019764 b6e485dc
 r10:00000000 r9:c14a6ca0 r8:c0008420 r7:000000ef r6:01000000 r5:00000000
 r4:01000000
Code: e21e1003 1a000011 e3550003 9a00000f (e4943000)
---[ end trace 0000000000000000 ]---

---
arm:mps2

[    4.659693]
[    4.659693] Unhandled exception: IPSR = 00000006 LR = fffffff1
[    4.659888] CPU: 0 PID: 155 Comm: cat Tainted: G                 N 6.2.0-rc7-next-20230213 #1
[    4.660030] Hardware name: Generic DT based system
[    4.660118] PC is at 0x0
[    4.660248] LR is at filemap_read_folio+0x17/0x4e
[    4.660468] pc : [<00000000>]    lr : [<21044c97>]    psr: 0000000b
[    4.660534] sp : 2185bd10  ip : 2185bcd0  fp : 00080001
[    4.660591] r10: 21757b40  r9 : 2175eea4  r8 : 2185bdf4
[    4.660649] r7 : 2175ee88  r6 : 21757b40  r5 : 21fecb40  r4 : 00000000
[    4.660718] r3 : 00000001  r2 : 00000001  r1 : 21fecb40  r0 : 21757b40
[    4.660785] xPSR: 0000000b
[    4.661126]  filemap_read_folio from filemap_get_pages+0x127/0x36e
[    4.661247]  filemap_get_pages from generic_file_buffered_splice_read.constprop.5+0x85/0x244
[    4.661342]  generic_file_buffered_splice_read.constprop.5 from generic_file_splice_read+0x1c3/0x1e2
[    4.661436]  generic_file_splice_read from splice_file_to_pipe+0x2f/0x48
[    4.661509]  splice_file_to_pipe from do_sendfile+0x193/0x1b8
[    4.661573]  do_sendfile from sys_sendfile64+0x63/0x70
[    4.661653]  sys_sendfile64 from ret_fast_syscall+0x1/0x4c
[    4.661740] Exception stack(0x2185bfa8 to 0x2185bff0)
[    4.661854] bfa0:                   000000ef 00000000 00000001 00000003 00000000 01000000
[    4.661944] bfc0: 000000ef 00000000 21b56e48 000000ef 00000001 00000001 00000000 21b51770
[    4.662023] bfe0: 21b4e791 21b56e48 21b174c9 21b0265e
