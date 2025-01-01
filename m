Return-Path: <linux-fsdevel+bounces-38309-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B3559FF2B1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Jan 2025 02:35:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CE0E161B8A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Jan 2025 01:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C67D2FF;
	Wed,  1 Jan 2025 01:35:14 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail115-76.sinamail.sina.com.cn (mail115-76.sinamail.sina.com.cn [218.30.115.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A2A8F58
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Jan 2025 01:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735695313; cv=none; b=P1c/WvBFITTNMhDBLdANHyHlb5uT+Zo35LzNiDkfTVH2cJLyTjj92FE3ksDVMXKQi5okasur0Ey3ZVM8NhKnASj1IcQDT+B9Zik9Np2aGCepNlXe05K5y4d+k+2ycbB3JOT3RJxGFaNx9S9xzTBNzQO4zJZwWHIKN40kl/c6WeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735695313; c=relaxed/simple;
	bh=FJul1WVUCbfV6vXIU9s4BmYaLflVqyC1D7Pq+6h2+7c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SKeWvaESL0lO8bGAdFU1ADFYzEidhJkmAEvGO/Oj6C0kQ0U+xC2MFNzEB9RvsZ2wzFatYWCKl6NsAVECzz8XVfhs0AalhagXHqa9LO2b1GepDaLm8ctl+Q1+uBiLQIbKZVkIC74lPH64Obpc+2iFFy3MPM9vo40kqwd2svEIDrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.24.8.141])
	by sina.com (10.185.250.22) with ESMTP
	id 67749BC2000007D8; Wed, 1 Jan 2025 09:35:00 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 8501317602654
X-SMAIL-UIID: 5638F13C13384F98B880BB1692705BAC-20250101-093500-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+6a3aa63412255587b21b@syzkaller.appspotmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	Al Viro <viro@zeniv.linux.org.uk>
Cc: Eric Dumazet <eric.dumazet@gmail.com>
Subject: Re: [syzbot] [fs?] KASAN: slab-out-of-bounds Write in __put_unused_fd
Date: Wed,  1 Jan 2025 09:34:58 +0800
Message-ID: <20250101013503.1189-1-hdanton@sina.com>
In-Reply-To: <6773f137.050a0220.2f3838.04e2.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 12/31/24 2:27 PM, syzbot wrote:
> syzbot found the following issue on:
>
> HEAD commit:    8155b4ef3466 Add linux-next specific files for 20241220
> git tree:       linux-next
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13f42ac4580000

Test Eric's patch.

#syz test

--- x/fs/notify/fanotify/fanotify_user.c
+++ y/fs/notify/fanotify/fanotify_user.c
@@ -1624,8 +1624,8 @@ SYSCALL_DEFINE2(fanotify_init, unsigned
 	file = anon_inode_getfile_fmode("[fanotify]", &fanotify_fops, group,
 					f_flags, FMODE_NONOTIFY);
 	if (IS_ERR(file)) {
-		fd = PTR_ERR(file);
 		put_unused_fd(fd);
+		fd = PTR_ERR(file);
 		goto out_destroy_group;
 	}
 	fd_install(fd, file);
--

