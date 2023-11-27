Return-Path: <linux-fsdevel+bounces-3999-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18CAE7FAD31
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 23:16:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BD71B213EB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 22:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF73648CCA;
	Mon, 27 Nov 2023 22:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W7/5u7od"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416A146543;
	Mon, 27 Nov 2023 22:16:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 698ABC433C7;
	Mon, 27 Nov 2023 22:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701123367;
	bh=KbzJsoazLxCd2BbBFJe0yrPuXWbbj41CPsXDmVkbnlI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W7/5u7odSgDcr2BZlmpNy1S21R3etVUBzXNDTaHq4Dk2PTruYFrXj0A2hW1KAk71o
	 edP+r0uMmfj1SgZEYaOWDiUoQHgBstwrK6FVcab3oBYGpjIy/4B/STG1uMLLWcxyjl
	 evZ24DVTpGyPSivLlskhsN+5QpXLPX80OM60qy+2gW8vWLSDzqiXGVdYh3qBKjxba2
	 hnvT4qOGhzErqNg5+8CoK6Z2peD6BkNQM84GsSZBkNfI3hOWfIvsXxmu9DpXiiEvSB
	 XshUMntkc0rk4ouzy0J+Z0k99QL3H/0Ly/U6vHXezlIczWrfs9YXRYzrNP88N5b9jZ
	 tGS9nsOHBr5xg==
Date: Mon, 27 Nov 2023 14:16:05 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: syzbot <syzbot+9d04b061c581795e18ce@syzkaller.appspotmail.com>
Cc: jaegeuk@kernel.org, linux-fscrypt@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com, tytso@mit.edu
Subject: Re: [syzbot] [fscrypt?] possible deadlock in
 find_and_lock_process_key
Message-ID: <20231127221605.GB1463@sol.localdomain>
References: <0000000000002aa189060b147268@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000002aa189060b147268@google.com>

On Sun, Nov 26, 2023 at 12:58:22PM -0800, syzbot wrote:
> -> #3 (&type->lock_class#5){++++}-{3:3}:
>        down_read+0x9a/0x330 kernel/locking/rwsem.c:1526
>        find_and_lock_process_key+0x97/0x390 fs/crypto/keysetup_v1.c:112
>        fscrypt_setup_v1_file_key_via_subscribed_keyrings+0x115/0x2d0 fs/crypto/keysetup_v1.c:310
>        setup_file_encryption_key fs/crypto/keysetup.c:485 [inline]
>        fscrypt_setup_encryption_info+0xb69/0x1080 fs/crypto/keysetup.c:590
>        fscrypt_get_encryption_info+0x3d1/0x4b0 fs/crypto/keysetup.c:675
>        fscrypt_setup_filename+0x238/0xd80 fs/crypto/fname.c:458
>        ext4_fname_setup_filename+0xa3/0x250 fs/ext4/crypto.c:28
>        ext4_add_entry+0x32b/0xe40 fs/ext4/namei.c:2403
>        ext4_rename+0x165e/0x2880 fs/ext4/namei.c:3932
>        ext4_rename2+0x1bc/0x270 fs/ext4/namei.c:4212
>        vfs_rename+0x13e0/0x1c30 fs/namei.c:4844
>        do_renameat2+0xc3c/0xdc0 fs/namei.c:4996
>        __do_sys_renameat fs/namei.c:5036 [inline]
>        __se_sys_renameat fs/namei.c:5033 [inline]
>        __x64_sys_renameat+0xc6/0x100 fs/namei.c:5033
>        do_syscall_x64 arch/x86/entry/common.c:51 [inline]
>        do_syscall_64+0x40/0x110 arch/x86/entry/common.c:82
>        entry_SYSCALL_64_after_hwframe+0x63/0x6b

#syz dup: possible deadlock in start_this_handle (4)

See https://lore.kernel.org/linux-fscrypt/Y%2F6aDmrx8Q9ob+Zi@sol.localdomain/

- Eric

