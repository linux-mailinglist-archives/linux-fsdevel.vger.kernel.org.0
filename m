Return-Path: <linux-fsdevel+bounces-35704-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB33C9D7678
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 18:15:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45CBDB41DEF
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 15:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A83B1B4155;
	Sun, 24 Nov 2024 14:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="DEqmScsT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B15166F29;
	Sun, 24 Nov 2024 14:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732459486; cv=none; b=FfNWpetinFnDLd+2ato3d7eVcozAtn9n/Fkn22cXUo4GDhaX6JIn9wiSJfT0CrBOxiZBTOTUEymm7Pu4N8dvcRlEuTA2No6O2xHn8saG/SfpyktHjrKqgQO4nKfUwUtRfH2GRcZWfTI7lnzV4V+4bWd1hHqFeKkLAu4EGSIA9sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732459486; c=relaxed/simple;
	bh=SBT877sysOB5nCoT5PtcJ+amBSQmM1Wym1uX25i0nx8=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=CvCVR2GrazQfVdo+FAkhQAc1go+jVvUGisIxbKyvlJY0P37EUmritG1oL2qe8z4m+GtVBkzi67LtZJ/ZjypD9rUexs2vdFwKMQDHIk0i9EejoQ2oD/9C1b1iuJGVEfsEYPXZBqlOi8+JpwaDP8Bw/3h322Mii05zvJDFpsIYjWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=DEqmScsT; arc=none smtp.client-ip=162.62.57.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1732459472; bh=kzliihW7TCT7EISzfPmE7vGcz+iHYH5K3+0oKdnx48c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DEqmScsTtc2cOFnihiAUEWjUm8wLtbEX6U2otKJ3kLp1Rvhtf0ObmRY/JAPpMqQM3
	 ZaQJ0r6IwIJmr+Mu2+B1msWUHhwaSwbctUDXk1e33jB89RObjFud0noqLau9wd2N+Q
	 w5VEymbaqxAYU+3sk4G3RDXBlc3y8ijdZFpUUedg=
Received: from pek-lxu-l1.wrs.com ([111.198.227.254])
	by newxmesmtplogicsvrszc13-0.qq.com (NewEsmtp) with SMTP
	id 99733027; Sun, 24 Nov 2024 22:38:23 +0800
X-QQ-mid: xmsmtpt1732459103tv60k1anm
Message-ID: <tencent_C2474B031BD225AABA42BB7D33FC9E861B08@qq.com>
X-QQ-XMAILINFO: ORyUpQViyxxVhF799lH637scji7S0JvY8LvKQNIqdxrEJX7eksFZNH6H4pzbDS
	 iJGMJIDqq+XH9MJf6gvRhAq/SuPf+THk3Sn5ESGwObV/b2//+80qwaDLrHyaxhz2LWoKJch2oQai
	 XnIfpTTDxBt/zdECj9Vt7Ool/pjFXNMKGeeXaDczk0f8JyeYBJUidk2HODs+UCtILe7wQd7c9zBW
	 XrJWHmMl8BB7sy4gGcPDFVOad5Me2YFV9NHWebpHUGIH4+oGnULO6unhZ1c1Np1HybY34kTjP6Ce
	 KiYt+EximC/rKwhah4iVAKdae/RYBmqhVsz8J2ABkA1JVs+jB6nV9iwq/ZGLFaCFVAjenaLvaIxG
	 4fID669Woe3Uk4T2ema60204RyJGNYOpmN0KSpfwnw1/OdK7wcpRzj6Zyvt/OGgkR/A+pmDAu7ln
	 vJVFRZ8pqjhVCkWRTXvXWfnMre0kN9jI1ZW/56mNIrCXMzxSR8/cpdyfZ4MBumU14MAibY+q9rtW
	 nxWZ/aanmJc5npzpOAyMlt7nXVD8RLTzMVDfbY4iThbXCszLzC82wy1vjL0nJyLy6f3C3pQzUmXG
	 9Vj7cnljNrRcOqsa0LFqgUJhTf+cgRD9bfmym/0p+SZE1BhJ2EVUp5zR14rXnJRJ+v6q86C/Zy6d
	 g4V3ECqN3SXW6Ok1GAMkLzgGMlIXSJu3voQGfimfYUR5I1huAnTk2xk1zM3sy5INE4OEoEM+64tQ
	 yf5Mhpi0eTK34eyXbcBz068d+DAphTNDORpHS/nHTjOBc+sFVSzo5PTWOvlxujDhBLGU65Nih2C6
	 62qPpVMuKIneQ/S4lZZBkvNAgSdtGUMW/linAx4bamJkzbhPvCQMI66BlB8y4I+/873CJN3F98Dq
	 Vi/PuZOUOp
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+028180f480a74961919c@syzkaller.appspotmail.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [hfs?] WARNING in hfsplus_unlink
Date: Sun, 24 Nov 2024 22:38:23 +0800
X-OQ-MSGID: <20241124143822.3696326-2-eadavis@qq.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <674305a3.050a0220.1cc393.003b.GAE@google.com>
References: <674305a3.050a0220.1cc393.003b.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After the rename syscall fails, the unlink syscall triggers a warning in
drop_nlink() because the i_nlink value is 0.

When unlink succeeds but rename_cat fails in rename, the i_nlink and flags
values of the inode of the new dentry should be restored.

#syz test

diff --git a/fs/hfsplus/dir.c b/fs/hfsplus/dir.c
index f5c4b3e31a1c..b489d22409e7 100644
--- a/fs/hfsplus/dir.c
+++ b/fs/hfsplus/dir.c
@@ -534,7 +534,7 @@ static int hfsplus_rename(struct mnt_idmap *idmap,
 			  struct inode *new_dir, struct dentry *new_dentry,
 			  unsigned int flags)
 {
-	int res;
+	int res, unlinked_new = 0;
 
 	if (flags & ~RENAME_NOREPLACE)
 		return -EINVAL;
@@ -543,8 +543,10 @@ static int hfsplus_rename(struct mnt_idmap *idmap,
 	if (d_really_is_positive(new_dentry)) {
 		if (d_is_dir(new_dentry))
 			res = hfsplus_rmdir(new_dir, new_dentry);
-		else
+		else {
 			res = hfsplus_unlink(new_dir, new_dentry);
+			unlinked_new = res == 0 && d_inode(new_dentry)->i_flags & S_DEAD;
+		}
 		if (res)
 			return res;
 	}
@@ -554,6 +556,12 @@ static int hfsplus_rename(struct mnt_idmap *idmap,
 				 new_dir, &new_dentry->d_name);
 	if (!res)
 		new_dentry->d_fsdata = old_dentry->d_fsdata;
+	else if (unlinked_new) {
+		struct inode *inode = d_inode(new_dentry);
+		set_nlink(inode, inode->i_nlink + 1);
+		inode->i_flags &= ~S_DEAD;
+	}
+
 	return res;
 }
 


