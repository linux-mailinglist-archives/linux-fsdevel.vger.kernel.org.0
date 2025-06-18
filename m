Return-Path: <linux-fsdevel+bounces-51996-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E30ADE1A9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 05:31:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC0EB189A921
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 03:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B44EB1D7E42;
	Wed, 18 Jun 2025 03:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="ukTRbp3N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out203-205-221-239.mail.qq.com (out203-205-221-239.mail.qq.com [203.205.221.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B33199E94;
	Wed, 18 Jun 2025 03:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750217475; cv=none; b=kxIeSQ/PUEwfuxrCejuAmXh1vIaj28sZL1aVGP5dsjzWPH3VdR7CZijQRuPqA76IUXFjfGh4BC0Bk5e98qKVhpsa1sSpnab0VmBNC3L4jADxDq77iYLnmQHdNdG1Nl/oQpSTN9XiiS+oxBBWox38Wp+/4yvFe31dV10m+Eg8zh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750217475; c=relaxed/simple;
	bh=cuaANZaoz2FHYgtAxqEoNZNsN25Tybf3+eWwehn1+zI=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=HlvS1UTSHUKWQOFYt09hekKw7SrCGlvS6kT65mvUaFBQBDRJKOK2YV7RA/91CJ8513q5I4TPJ4m9SyKrWXTXniQ0ikqYoNLG3Xl/SXRvhyldYoDo92Vt9MZhe5Zn2fJhmqLTU2ss057gUlzd47gUBlIpZmaxmaBuu5G39sjK4Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=ukTRbp3N; arc=none smtp.client-ip=203.205.221.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1750217470; bh=eHk3hR68qYNaDZ54UaA20pIxk2xTJX8697byy1PHsaQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ukTRbp3NrjxggMDloDM1EVLSf5qV4N/SL8qh3/MqAf69gnv8L3RStvxeH0i9Q4X8v
	 1EzBGacZ9y9nH3DK0XQUamhNdU7h5Xee10EEgad3TFQOF+qi7QMmqdA7nD+Gh7vgV1
	 H7pr/yymRDv6ob2fdO1j0l64gZ8uxR29uQhwr3Ws=
Received: from pek-lxu-l1.corp.ad.wrs.com ([111.198.228.63])
	by newxmesmtplogicsvrszgpua8-0.qq.com (NewEsmtp) with SMTP
	id 7AFA5CCB; Wed, 18 Jun 2025 11:30:47 +0800
X-QQ-mid: xmsmtpt1750217447tq8nygmwl
Message-ID: <tencent_7FB38DB725848DA99213DDB35DBF195FCF07@qq.com>
X-QQ-XMAILINFO: MFdGPHhuqhNo8bsXqtmbMYZi9ZBEoVICJhjWKXsQoew/9a32Uz4zhZ3v9rUtG7
	 i4RQQOMqHBPD17kZDxp6xQ15SdwqW1qHc5MtKLMiTA0Is9TqYs08ch9rCJNxIx519OZuHSguQ+PW
	 UfsAZNQrUBRFlhAUyV/qb5JxXYR7NQENiPTQfhD2EPnOb3tCgJqowWbYbL/Jqbv7L6GhzEErTdEl
	 sSKw2Z+mG0DfI2chSUx7KyFF9qr1o41osO3lF3HhIfogQSK5GW16CSDt91yvMo4/vtf0pdepRmA3
	 SujkOEWQx+HhvoLeXXatRb4KhdY5zdkyIZhfk8Hg5PY7Solx6ME9W1FI5ItjA5RGSEF68O0U0qhl
	 x04GJNemilaLv5aQZdIo2yPrp9lSyGs2DsxkGuGaxgRYFbTjD00ijVr38PhcZ/IfqHjvsBZCmy0L
	 jdo2BR7+qwQgX/fYVoMuJeMESA3N6wkvQH0EQxofEl3H9F9NIjoas+hF7Mk6xetMaA+M7bbZlg3I
	 h70cIaDDVRzf5Jse79AmfvRfVRMmPVzc1lYcc8oSOZfZGLd2liShXv84ts8efVVAbsbuWex61ZM2
	 oBm22T+/524dViYmfcvRf/1qkW5He30YnuIDpOQtT392BQWqO/RWXY+PPWexoCeQs/CgYTyaBUrU
	 SIjXhpdc9DIAeAw5gkwfp2oMtwohX5BRSkfz+Oxq0kXPQYZTOOxnZqR/6VncC+ItdILsR9+0DKpA
	 o8WZ5vRzySTtYB6CZrcN5D5/SUajIRTtsFlwh2sRPMW5zkXGdJZ6xwr4B0158gsWHIwfOVKwAHYa
	 89RkuXOqKzxcdwP3MaoGwV1Df8YWqdWLia+DFvteYxIq8F+J7H1AVvUTfRAb0BvxpqjFk6fBuBYf
	 Bd+eJfQKVUYH1KbBInUkFM9qYa7UiEd4kVvf4RGwS61ctpEdZLRySHQ9ieaiSdg5U1GzTYzNSJXO
	 T62d7eg7WaQZpIRFzwpapFBV6m5xiZ
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+1aa90f0eb1fc3e77d969@syzkaller.appspotmail.com
Cc: almaz.alexandrovich@paragon-software.com,
	brauner@kernel.org,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ntfs3@lists.linux.dev,
	syzkaller-bugs@googlegroups.com,
	viro@zeniv.linux.org.uk
Subject: [PATCH] fs: Prevent non-symlinks from entering pick link
Date: Wed, 18 Jun 2025 11:30:48 +0800
X-OQ-MSGID: <20250618033047.1137158-2-eadavis@qq.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <685120d8.a70a0220.395abc.0204.GAE@google.com>
References: <685120d8.a70a0220.395abc.0204.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The reproducer uses a file0 on a ntfs3 file system with a corrupted i_link.
When renaming, the file0's inode is marked as a bad inode because the file
name cannot be deleted. However, before renaming, file0 is a directory.
After the renaming fails, it is marked as a bad inode, which makes it a
regular file. In any case, when opening it after creating a hard link,
pick_link() should not be entered because it is not a symbolic link from
beginning to end.

Add a check on the symbolic link before entering pick_link() to avoid
triggering unknown exceptions when performing the i_link acquisition
operation on other types of files.

Reported-by: syzbot+1aa90f0eb1fc3e77d969@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=1aa90f0eb1fc3e77d969
Tested-by: syzbot+1aa90f0eb1fc3e77d969@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 fs/namei.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/namei.c b/fs/namei.c
index 4bb889fc980b..1524a5359d46 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2005,6 +2005,10 @@ static const char *step_into(struct nameidata *nd, int flags,
 		if (path.mnt == nd->path.mnt)
 			mntget(path.mnt);
 	}
+
+	if (inode && !S_ISLNK(inode->i_mode))
+		return NULL;
+
 	return pick_link(nd, &path, inode, flags);
 }
 
-- 
2.43.0


