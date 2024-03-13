Return-Path: <linux-fsdevel+bounces-14287-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1BCB87A81A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 14:12:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D39C61C20ECD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 13:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B53E3FE55;
	Wed, 13 Mar 2024 13:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="Qhza5gW+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CD4225AD;
	Wed, 13 Mar 2024 13:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710335556; cv=none; b=ZnZT9wlyFD4kMzg0pLEDqgh+klesV71azUVIEzJ3mUsjcbBX2rWMyfB1FK3htx21iqpvyxdutXoTJzUtiLXx7jydddyn4WkBLdGimVr+ihYtTHu36i6TVFT6AxS33u8DUAvf+ChteB9cuvQoeDEb10DfWpQ8EwzBcQTzAfugysU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710335556; c=relaxed/simple;
	bh=EIddhXL/hBKW+RNALtuYnMmsP6DjsCPpVs48fZbzdJc=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=PsfCAjEdTcZrumNrjHxVN0S/iT1iIo4oHbW4SIUorx9fHcAiVs8jUkzbeTlWIP9Whr0KmnmN+Y4QH7IX10+YawyTT9E9T47MEqketnAUbJVUfSOgKzsPzAXSMtUHOQEf2EvDPtekSqJRE4G1kwRrkEgry9p0b+Y/UVog0ruefoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=Qhza5gW+; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1710335231; bh=RxP83Uir+gh2fkaF4ZBO/T3Fp1vZ98pgi+n34nEkhLA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Qhza5gW+BA1RHn7e4AZJoeT1gvAVNUNhuOBYca5Gl6/ODtZt4n80xVFWzzS6Qb934
	 hb2WH1ZQhX0djNSu7s0dqN86NqSOeeSUSxYb7M+4YWYozNi5zjhefEx/8w53iwGAsc
	 gonrtXLJGjN+CAxnovbM0oibQHSIcVvxwSOS2+w4=
Received: from pek-lxu-l1.wrs.com ([2408:8409:ce0:12a0:a032:4bf1:303d:acae])
	by newxmesmtplogicsvrszc5-1.qq.com (NewEsmtp) with SMTP
	id 1C02DA4B; Wed, 13 Mar 2024 21:07:00 +0800
X-QQ-mid: xmsmtpt1710335220t7y7fak82
Message-ID: <tencent_938637BC4BA674C576F366443D5336109609@qq.com>
X-QQ-XMAILINFO: NY/MPejODIJVt9wmOCP3xvkfrWcMJLkYT8gKu08MBlRe0mNe0uhXafEkyPldnd
	 GQTtqyKiUna8/LnsnoteWmoOX94MOUhnS/3R9QPPfBn5nlVLMfIc+6QTlM7wA1Pfv0z3WpOb0Yiy
	 FuacueNFL2uIBd15V0jpe9FA/5iDElNlgcsQgFZHDJOMhgVLEwa12l2sQ2PMAxm9R0PvatuRuJS/
	 52SRFMVC9OyrXyR9QXjVEBgaLksQ96PeyfpifzFhQnLnRDEQOjDyaJZD/hythMxUENSobt84DWp7
	 TDXParTfw4YftWL9zanyo+fHFSaERrNymhQ5P6C86C0+ayZNk8D0Tv88y1/At1GHqjc4W1WyIMZd
	 xd/3WyuxqLg1TIwLmDEMIkipJSItxU9Lr8xuFrbVPstaWLwK1uUQsffxcRjRJ1aBUTscQF8o85lp
	 bLCZiAmSDSwZsLmVjuYr+tOGpVu3ukCWeySolvO7jzB7EkGrQvIwRA1ra0WvQx/0KBX4yA9yI3Ne
	 M78BibzWtkhaIdhOlYMlYeB0pLfffpRIKgTnXkOrWQOLaAKGo6o+q7NiJkDP+u1lkC2aREB0nyi1
	 Wu9cyXW1NqfCosp31Sb/v50bj7L/FIF8pXOGWthC6Kf1fI0x0m9HuuF0dBySPxcZ83KAkQzKrEtH
	 pbI2LyQC/HowEtlMoJmy///ImQqfSPBmlHDuNwuqsZ1ujpR6wAjO7FDBbQDS4ZRqRqUxvDJaFmdU
	 SuK7vHNYOA+KjEhmAdUEK7/qhS58dNO1E82nWDbDZn0EkAbqHAflBKCXokEXp9gAW5a05lHkHrgT
	 ACh2Ycz/uYFKt64r1kMzKanqcxcYeXpAF1eG1zkChIqoSD42ECzPjMyWAZxfzTtIywQiirCmHQL3
	 PttSrfA+dwcyixrL8M8cUcfe3Lsq5YE6DcnzD1thbngm2BkVT0RjxGbB/L6IVCwQ==
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+9b5ec5ccf7234cc6cb86@syzkaller.appspotmail.com
Cc: brauner@kernel.org,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	viro@zeniv.linux.org.uk
Subject: [PATCH] libfs: fix warning in stashed_dentry_prune
Date: Wed, 13 Mar 2024 21:07:00 +0800
X-OQ-MSGID: <20240313130659.392488-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0000000000003ea6ba0613882a96@google.com>
References: <0000000000003ea6ba0613882a96@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Initialize d_fsdata in advance to avoid warnings when recycling dentry due to
inode allocation failures.

Fixes: 2558e3b23112 ("libfs: add stashed_dentry_prune()")
Reported-and-tested-by: syzbot+9b5ec5ccf7234cc6cb86@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 fs/libfs.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index 0d14ae808fcf..67dc503272eb 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -2013,6 +2013,8 @@ static struct dentry *prepare_anon_dentry(struct dentry **stashed,
 	if (!dentry)
 		return ERR_PTR(-ENOMEM);
 
+	/* Store address of location where dentry's supposed to be stashed. */
+	dentry->d_fsdata = stashed;
 	inode = new_inode_pseudo(sb);
 	if (!inode) {
 		dput(dentry);
@@ -2029,9 +2031,6 @@ static struct dentry *prepare_anon_dentry(struct dentry **stashed,
 	WARN_ON_ONCE(!S_ISREG(inode->i_mode));
 	WARN_ON_ONCE(!IS_IMMUTABLE(inode));
 
-	/* Store address of location where dentry's supposed to be stashed. */
-	dentry->d_fsdata = stashed;
-
 	/* @data is now owned by the fs */
 	d_instantiate(dentry, inode);
 	return dentry;
-- 
2.43.0


