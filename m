Return-Path: <linux-fsdevel+bounces-3997-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE7B7FACC2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 22:45:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74922281B6E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 21:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FD7446539;
	Mon, 27 Nov 2023 21:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kUiXEgIZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75672F51;
	Mon, 27 Nov 2023 21:45:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFD74C433C8;
	Mon, 27 Nov 2023 21:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701121525;
	bh=v18PiaiEjKMB6O0c6WVfzv26Yhzu0ATLF8LUD+Mc3eI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kUiXEgIZH34RrmOEyeP6RGujMJu1FHOUstkRzYXxApzFDUnkeKf4LzA/n499QsxbG
	 cW/3bwe8V4W2gzsWsoiPy38lRufiN3hW+kmvsxVcDYXUfJpdwczBzdDZDHnL4lNKXA
	 rRHzLImKsp0g1gpmQKNET2tzFOqGcW3wopfp5stWp3KZEAMfac/O0cKEMcbFXFKPrz
	 TODq1qrteXLD39/AyVSikaReJwkGo0gyKU6ee4kgOnB8heguGQLX7Q7KcYRfoyPLB9
	 2HzbPiRBIkPg8B2XOuAusNYtEHVgTkK18R1iYh4BBpDk/pjJnCzbKB9XhI5pgWikTU
	 kktxjuSJNjocA==
Date: Mon, 27 Nov 2023 13:45:22 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: syzbot <syzbot+3a3b5221ffafba7d5204@syzkaller.appspotmail.com>
Cc: jaegeuk@kernel.org, linux-fscrypt@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com, tytso@mit.edu
Subject: Re: [syzbot] [fscrypt?] possible deadlock in fscrypt_initialize (2)
Message-ID: <20231127214522.GA1463@sol.localdomain>
References: <0000000000002f1a6205f5d8096b@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000002f1a6205f5d8096b@google.com>

On Wed, Mar 01, 2023 at 07:04:59AM -0800, syzbot wrote:
> -> #0 (fscrypt_init_mutex){+.+.}-{3:3}:
>        check_prev_add kernel/locking/lockdep.c:3098 [inline]
>        check_prevs_add kernel/locking/lockdep.c:3217 [inline]
>        validate_chain kernel/locking/lockdep.c:3832 [inline]
>        __lock_acquire+0x2ec7/0x5d40 kernel/locking/lockdep.c:5056
>        lock_acquire kernel/locking/lockdep.c:5669 [inline]
>        lock_acquire+0x1e3/0x670 kernel/locking/lockdep.c:5634
>        __mutex_lock_common kernel/locking/mutex.c:603 [inline]
>        __mutex_lock+0x12f/0x1350 kernel/locking/mutex.c:747
>        fscrypt_initialize+0x40/0xa0 fs/crypto/crypto.c:326
>        fscrypt_setup_encryption_info+0xef/0xeb0 fs/crypto/keysetup.c:563
>        fscrypt_get_encryption_info+0x375/0x450 fs/crypto/keysetup.c:668
>        fscrypt_setup_filename+0x23c/0xec0 fs/crypto/fname.c:458
>        ext4_fname_setup_filename+0x8c/0x110 fs/ext4/crypto.c:28
>        ext4_add_entry+0x3aa/0xe30 fs/ext4/namei.c:2380
>        ext4_rename+0x19ff/0x26d0 fs/ext4/namei.c:3911
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

See https://lore.kernel.org/linux-fscrypt/Y%2F6aDmrx8Q9ob+Zi@sol.localdomain/

- Eric

