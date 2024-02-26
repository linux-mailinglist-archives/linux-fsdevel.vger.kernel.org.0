Return-Path: <linux-fsdevel+bounces-12793-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D3505867458
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 13:07:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBC24B22546
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 12:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49BEC5FDBB;
	Mon, 26 Feb 2024 12:07:25 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail78-36.sinamail.sina.com.cn (mail78-36.sinamail.sina.com.cn [219.142.78.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B591CD36
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Feb 2024 12:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=219.142.78.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708949244; cv=none; b=c/LTzxCKKepx46T4QOxH4MsXm251mqJe/cUGruul4MJgMQAkFPlLaSg+S1Qo2fdLSQ1k3QBkDiinXuzRFrCRr8L3fU/R4UTCIm1I8E+tQUwMXsV20sc71+rjZnOoJTtjsE/5czdAjYVX2gKGucj/BF3AnRXro7Qttc0vfFNKYJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708949244; c=relaxed/simple;
	bh=pLt7uW/tLWOix+u8T0EY+yCzxoIKPC5tGiwPgZA82wQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RR0t82LMiHHjYh7mQkRtGFHxcDae3kx4uBSjIWtq2ZM0Vlz8AnbSIDVTNryjK9SL6FAM3q8GKroqgkyliPnaIq9ow9uVKgerAPLgJEqRyq+4yA/5+mHRVLldsTilfQhVddmJDMhq6HuDOP1u6t083EzKOB23I5GW6iTLZcmx0aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=219.142.78.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.50.169])
	by sina.com (172.16.235.25) with ESMTP
	id 65DC7EC900006951; Mon, 26 Feb 2024 20:06:35 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 74897934210316
X-SMAIL-UIID: B7F26EFD82E247E782670C81FCE0147F-20240226-200635-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+c2ada45c23d98d646118@syzkaller.appspotmail.com>
Cc: almaz.alexandrovich@paragon-software.com,
	boqun.feng@gmail.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ntfs3@lists.linux.dev,
	penguin-kernel@i-love.sakura.ne.jp,
	syzkaller-bugs@googlegroups.com,
	torvalds@linux-foundation.org
Subject: Re: [syzbot] [ntfs3?] possible deadlock in ntfs_set_state (2)
Date: Mon, 26 Feb 2024 20:06:23 +0800
Message-Id: <20240226120623.1464-1-hdanton@sina.com>
In-Reply-To: <00000000000044c2da06124774f7@google.com> (raw)
References: 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test non-zero subkey against the mainline tree.

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  master

--- x/fs/ntfs3/fsntfs.c
+++ y/fs/ntfs3/fsntfs.c
@@ -944,7 +944,7 @@ int ntfs_set_state(struct ntfs_sb_info *
 	if (!ni)
 		return -EINVAL;
 
-	mutex_lock_nested(&ni->ni_lock, NTFS_INODE_MUTEX_DIRTY);
+	mutex_lock_nested(&ni->ni_lock, (1 + NTFS_INODE_MUTEX_PARENT2));
 
 	attr = ni_find_attr(ni, NULL, NULL, ATTR_VOL_INFO, NULL, 0, NULL, &mi);
 	if (!attr) {
--

