Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCC256A642C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Mar 2023 01:19:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjCAATg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Feb 2023 19:19:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjCAATf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Feb 2023 19:19:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0458937B49;
        Tue, 28 Feb 2023 16:19:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ACD9FB80EE4;
        Wed,  1 Mar 2023 00:19:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36193C433EF;
        Wed,  1 Mar 2023 00:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677629968;
        bh=Dp6YGll9fEq0i6/pi+lpCFF50nvydZGLY0lYQFlc3q8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KYYbEtIhVA3RWaS2xg2q0EfXodh4GOmNY4tvxi0H4nLyzYrhWFpOdD72CH8RSx/Fs
         xo7oO1X6WU4IaJbbLF9mpPXsZu+uepDR7eZ9E/xOHQk6DduUX8NJD0LyPybDASGdD2
         ZmHMwXFi3S0pfxzs27uWkvqVjDBKt5gIS93lfERCan2xoJndgBoXHTnXu0O3q6ZIqf
         TLb8FfdJDyvbO+P7Qk4BDTTUMD9QMeQgjfcUeeptUmdVhOOmjdovvnLFJOVyrO+DRm
         AvmmtMsDV1wJS+CJ+ESkqcokj8RzBbfrTr8zz0egPiFT7is9BVQjLWjH0qdqv2mB16
         Tn7QJS4XudfSw==
Date:   Tue, 28 Feb 2023 16:19:26 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     syzbot <syzbot+cf0b4280f19be4031cf2@syzkaller.appspotmail.com>
Cc:     jack@suse.com, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu,
        linux-fscrypt@vger.kernel.org
Subject: Re: [syzbot] [ext4?] possible deadlock in start_this_handle (4)
Message-ID: <Y/6aDmrx8Q9ob+Zi@sol.localdomain>
References: <00000000000009d6c905f5cb6e07@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000009d6c905f5cb6e07@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 28, 2023 at 04:02:36PM -0800, syzbot wrote:
> -> #1 (fscrypt_init_mutex){+.+.}-{3:3}:
>        __mutex_lock_common kernel/locking/mutex.c:603 [inline]
>        __mutex_lock+0x12f/0x1350 kernel/locking/mutex.c:747
>        fscrypt_initialize+0x40/0xa0 fs/crypto/crypto.c:326
>        fscrypt_setup_encryption_info+0xef/0xeb0 fs/crypto/keysetup.c:563
>        fscrypt_get_encryption_info+0x375/0x450 fs/crypto/keysetup.c:668
>        fscrypt_setup_filename+0x23c/0xec0 fs/crypto/fname.c:458
>        ext4_fname_setup_filename+0x8c/0x110 fs/ext4/crypto.c:28
>        ext4_add_entry+0x3aa/0xe30 fs/ext4/namei.c:2380
>        ext4_rename+0x1979/0x2620 fs/ext4/namei.c:3904
>        ext4_rename2+0x1c7/0x270 fs/ext4/namei.c:4184
>        vfs_rename+0xef6/0x17a0 fs/namei.c:4772
>        do_renameat2+0xb62/0xc90 fs/namei.c:4923
>        __do_sys_renameat2 fs/namei.c:4956 [inline]
>        __se_sys_renameat2 fs/namei.c:4953 [inline]
>        __ia32_sys_renameat2+0xe8/0x120 fs/namei.c:4953
>        do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
>        __do_fast_syscall_32+0x65/0xf0 arch/x86/entry/common.c:178
>        do_fast_syscall_32+0x33/0x70 arch/x86/entry/common.c:203
>        entry_SYSENTER_compat_after_hwframe+0x70/0x82

Interesting.  The above call stack is not supposed to be possible.  It says that
the target directory's encryption key is being set up in the middle of
ext4_rename().  But, fscrypt_prepare_rename() is supposed to return an error if
either the source or target directory's key isn't set up already.

> Unfortunately, I don't have any reproducer for this issue yet.

That's quite unfortunate :-(

- Eric
