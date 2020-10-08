Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2EA287C77
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Oct 2020 21:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728109AbgJHT0u (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Oct 2020 15:26:50 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:36632 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbgJHT0u (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Oct 2020 15:26:50 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id EB80529DAB8
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        Daniel Rosenberg <drosen@google.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        syzbot+05139c4039d0679e19ff@syzkaller.appspotmail.com
Subject: Re: [PATCH] f2fs: reject CASEFOLD inode flag without casefold feature
Organization: Collabora
References: <00000000000085be6f05b12a1366@google.com>
        <20201008191522.1948889-1-ebiggers@kernel.org>
Date:   Thu, 08 Oct 2020 15:26:45 -0400
In-Reply-To: <20201008191522.1948889-1-ebiggers@kernel.org> (Eric Biggers's
        message of "Thu, 8 Oct 2020 12:15:22 -0700")
Message-ID: <87ft6oldsa.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Eric Biggers <ebiggers@kernel.org> writes:

> From: Eric Biggers <ebiggers@google.com>
>
> syzbot reported:
>
>     general protection fault, probably for non-canonical address 0xdffffc0000000001: 0000 [#1] PREEMPT SMP KASAN
>     KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
>     CPU: 0 PID: 6860 Comm: syz-executor835 Not tainted 5.9.0-rc8-syzkaller #0
>     Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
>     RIP: 0010:utf8_casefold+0x43/0x1b0 fs/unicode/utf8-core.c:107
>     [...]
>     Call Trace:
>      f2fs_init_casefolded_name fs/f2fs/dir.c:85 [inline]
>      __f2fs_setup_filename fs/f2fs/dir.c:118 [inline]
>      f2fs_prepare_lookup+0x3bf/0x640 fs/f2fs/dir.c:163
>      f2fs_lookup+0x10d/0x920 fs/f2fs/namei.c:494
>      __lookup_hash+0x115/0x240 fs/namei.c:1445
>      filename_create+0x14b/0x630 fs/namei.c:3467
>      user_path_create fs/namei.c:3524 [inline]
>      do_mkdirat+0x56/0x310 fs/namei.c:3664
>      do_syscall_64+0x31/0x70 arch/x86/entry/common.c:46
>      entry_SYSCALL_64_after_hwframe+0x44/0xa9
>     [...]
>
> The problem is that an inode has F2FS_CASEFOLD_FL set, but the
> filesystem doesn't have the casefold feature flag set, and therefore
> super_block::s_encoding is NULL.
>
> Fix this by making sanity_check_inode() reject inodes that have
> F2FS_CASEFOLD_FL when the filesystem doesn't have the casefold feature.
>
> Reported-by: syzbot+05139c4039d0679e19ff@syzkaller.appspotmail.com
> Fixes: 2c2eb7a300cd ("f2fs: Support case-insensitive file name lookups")
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Looks good.  For the record, this is fixed on ext4 already.

Reviewed-by: Gabriel Krisman Bertazi <krisman@collabora.com>

-- 
Gabriel Krisman Bertazi
