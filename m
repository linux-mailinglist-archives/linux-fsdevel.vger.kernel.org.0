Return-Path: <linux-fsdevel+bounces-12785-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C4D867399
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 12:42:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F914B296CF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 10:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0329B1CFBB;
	Mon, 26 Feb 2024 10:56:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail115-63.sinamail.sina.com.cn (mail115-63.sinamail.sina.com.cn [218.30.115.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8077A1C6B5
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Feb 2024 10:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.63
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708944963; cv=none; b=aWOo4gWA8aAWgMhXX4Qnr7h/dheGoJQxVhbwTqwEUHsn7odiPyxT6BQFMstyzKOUp3tfTstcNaklQkvPLnkxXU32DPoet5MMWvdqxXp+/dK1jRefTikDF7XVEvIJQRPNo3T4CbV/OnK+aJU2LJ38KLtsV8kB2O2bmyyq4wxxsg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708944963; c=relaxed/simple;
	bh=Hp2oMV39/LFmyfumxS6WCc8rlgTTMUsnMRb84o1Z+ks=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rf9Xnotiq5M2iKlAX9eRIM7cgC0aBL6GnEaqVOG372NlShZBdyt9dkm2IQSFD8XTpDgIWaWGCD5ygQhkgKDvS7P4Enkt5Baui2omFDk5LOCkH/UT/aUQYjV40esmM4mrbXyAHeRle0DKDtlf+FvkdajO93YJOfSbrSgDlzPRyn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.50.169])
	by sina.com (10.75.12.45) with ESMTP
	id 65DC6E1400005AA5; Mon, 26 Feb 2024 18:55:19 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 3718231457759
X-SMAIL-UIID: C180C45CB92344D9A4E456E3C4AA5979-20240226-185519-1
From: Hillf Danton <hdanton@sina.com>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: syzbot <syzbot+c2ada45c23d98d646118@syzkaller.appspotmail.com>,
	almaz.alexandrovich@paragon-software.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ntfs3@lists.linux.dev,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [ntfs3?] possible deadlock in ntfs_set_state (2)
Date: Mon, 26 Feb 2024 18:55:06 +0800
Message-Id: <20240226105506.1398-1-hdanton@sina.com>
In-Reply-To: <ZdwSXCaTrzq7mm7Z@boqun-archlinux>
References: <000000000000998cff06113e1d91@google.com> <20240213114151.982-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 25 Feb 2024 20:23:56 -0800 Boqun Feng wrote:
> On Tue, Feb 13, 2024 at 07:41:50PM +0800, Hillf Danton wrote:
> > On Mon, 12 Feb 2024 23:12:22 -0800
> > > HEAD commit:    716f4aaa7b48 Merge tag 'vfs-6.8-rc5.fixes' of git://git.ke..
> > > git tree:       upstream
> > > console+strace: https://syzkaller.appspot.com/x/log.txt?x=100fd062180000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=1d7c92dd8d5c7a1e
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=c2ada45c23d98d646118
> > > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11fcbd48180000
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17f6e642180000
> > > 
> > > ============================================
> > > WARNING: possible recursive locking detected
> > > 6.8.0-rc4-syzkaller-00003-g716f4aaa7b48 #0 Not tainted
> > > --------------------------------------------
> > > syz-executor354/5071 is trying to acquire lock:
> > > ffff888070ee0100 (&ni->ni_lock#3){+.+.}-{3:3}, at: ntfs_set_state+0x1ff/0x6c0 fs/ntfs3/fsntfs.c:947
> 
> this is a mutex_lock_nested() with a subkey 0.
> 
> > > 
> > > but task is already holding lock:
> > > ffff888070de3c00 (&ni->ni_lock#3){+.+.}-{3:3}, at: ni_trylock fs/ntfs3/ntfs_fs.h:1141 [inline]
> > > ffff888070de3c00 (&ni->ni_lock#3){+.+.}-{3:3}, at: ni_write_inode+0x1bc/0x1010 fs/ntfs3/frecord.c:3265
> 
> These two are try locks.
> 
> > > 
> > This report looks false positive but raises the question -- what made lockedp
> 
> This is not a false positive by lockdep locking rules, basically it
> reported deadlock cases as the follow:
> 
> 	mutex_trylock(A1);
> 	mutex_trylock(A2);
> 	mutex_lock(A1 /* or A2 */);
> 
> Two things to notice here: 1) these two trylock()s not resulting in
> real deadlock cases must be because they are on different lock
> instances, 2) deadlock detectors work on lock classes, so although the
> mutex_lock() above may be on a different instance (say A3), currently
> there is no way for lockdep to tell that. In this case, users need to
> use subkeys to tell lockdep mutex_lock() and mutex_trylock() are on
> different sets of instannces (i.e. sub classes). Note that subkey == 0
> means the main class.

Test non-zero subkey.

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  716f4aaa7b48

--- x/fs/ntfs3/fsntfs.c
+++ y/fs/ntfs3/fsntfs.c
@@ -944,7 +944,7 @@ int ntfs_set_state(struct ntfs_sb_info *
 	if (!ni)
 		return -EINVAL;
 
-	mutex_lock_nested(&ni->ni_lock, NTFS_INODE_MUTEX_DIRTY);
+	mutex_lock_nested(&ni->ni_lock, NTFS_INODE_MUTEX_NORMAL);
 
 	attr = ni_find_attr(ni, NULL, NULL, ATTR_VOL_INFO, NULL, 0, NULL, &mi);
 	if (!attr) {
--

