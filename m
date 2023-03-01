Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36CD06A73F3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Mar 2023 20:02:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbjCATCs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Mar 2023 14:02:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjCATCq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Mar 2023 14:02:46 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E033497CE;
        Wed,  1 Mar 2023 11:02:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 009E0CE1DED;
        Wed,  1 Mar 2023 19:02:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16AAEC433D2;
        Wed,  1 Mar 2023 19:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677697362;
        bh=avy+R5ETeyQpbqcg7PcpMnPq76z3pQZJwJ1DmPY39xg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SQ+/Eb4Uy3c8s3cmt+E/31fydZrvRCInfPkQ5N8Q6Utop3W9Z411wHaGwneRCc0oH
         nFGX2a4huLC4W6u0bPb4h83+Pu5sHzIUPe0zMGO7VUObNsZwemM3gQtGvdOLw662Vq
         n/0I6L+pDEAotASMy1TkzFMDOTtKCd0fjAUQzM+T3DWV+g15MVeXp4za1e5EWO5q3G
         jww3jXLGQB9tb9hfYbolY4+FIH+pfwWe2VZy0rKdsoQYaI2KWBBg3if8KPoFCR39vM
         cisrlVGiQRuuYnRVzJaNYLDIUa32RN3cNPmItQ1rxtBerVay+0XzD1ohvZi6NrUxwO
         3JG5CQAAbKdNg==
Date:   Wed, 1 Mar 2023 19:02:30 +0000
From:   Eric Biggers <ebiggers@kernel.org>
To:     syzbot <syzbot+3a3b5221ffafba7d5204@syzkaller.appspotmail.com>
Cc:     jaegeuk@kernel.org, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
Subject: Re: [syzbot] [fscrypt?] possible deadlock in fscrypt_initialize (2)
Message-ID: <Y/+hRpwYSk4FT/oG@gmail.com>
References: <0000000000002f1a6205f5d8096b@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000002f1a6205f5d8096b@google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 01, 2023 at 07:04:59AM -0800, syzbot wrote:
> -> #1 (fs_reclaim){+.+.}-{0:0}:
>        __fs_reclaim_acquire mm/page_alloc.c:4716 [inline]
>        fs_reclaim_acquire+0x11d/0x160 mm/page_alloc.c:4730
>        might_alloc include/linux/sched/mm.h:271 [inline]
>        slab_pre_alloc_hook mm/slab.h:728 [inline]
>        slab_alloc_node mm/slub.c:3434 [inline]
>        __kmem_cache_alloc_node+0x41/0x330 mm/slub.c:3491
>        kmalloc_node_trace+0x21/0x60 mm/slab_common.c:1074
>        kmalloc_node include/linux/slab.h:606 [inline]
>        kzalloc_node include/linux/slab.h:731 [inline]
>        mempool_create_node mm/mempool.c:272 [inline]
>        mempool_create+0x52/0xc0 mm/mempool.c:261
>        mempool_create_page_pool include/linux/mempool.h:112 [inline]
>        fscrypt_initialize+0x8a/0xa0 fs/crypto/crypto.c:332
>        fscrypt_setup_encryption_info+0xef/0xeb0 fs/crypto/keysetup.c:563
>        fscrypt_get_encryption_info+0x375/0x450 fs/crypto/keysetup.c:668
>        fscrypt_setup_filename+0x23c/0xec0 fs/crypto/fname.c:458
>        ext4_fname_setup_filename+0x8c/0x110 fs/ext4/crypto.c:28
>        ext4_find_entry+0x8c/0x140 fs/ext4/namei.c:1725
>        ext4_rename+0x51d/0x26d0 fs/ext4/namei.c:3829
>        ext4_rename2+0x1c7/0x270 fs/ext4/namei.c:4193
>        vfs_rename+0xef6/0x17a0 fs/namei.c:4772
>        do_renameat2+0xb62/0xc90 fs/namei.c:4923
>        __do_sys_renameat2 fs/namei.c:4956 [inline]
>        __se_sys_renameat2 fs/namei.c:4953 [inline]
>        __ia32_sys_renameat2+0xe8/0x120 fs/namei.c:4953
>        do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
>        __do_fast_syscall_32+0x65/0xf0 arch/x86/entry/common.c:178
>        do_fast_syscall_32+0x33/0x70 arch/x86/entry/common.c:203
>        entry_SYSENTER_compat_after_hwframe+0x70/0x82

#syz dup: possible deadlock in start_this_handle (4)

- Eric
