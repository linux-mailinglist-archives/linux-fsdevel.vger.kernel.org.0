Return-Path: <linux-fsdevel+bounces-53321-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66284AED9B9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 12:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE8A3178082
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 10:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6020C2586C8;
	Mon, 30 Jun 2025 10:22:18 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7101554918;
	Mon, 30 Jun 2025 10:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751278938; cv=none; b=MP6wyQD5H3TsDL0hQ+NTjVjTjetOv+W4P9TrwQGXroqQnxs+5i8xEn1gJQB6Ff1m+ms25QBVxc4y7a8wgSNtV7DRNWAUZwFnynZlM+lm00Oy8BQ1DYciBoUAYXAgMAbmEczNwsjJegPab7yRZyr4ngGBYcoIBipoBoWaInzKi7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751278938; c=relaxed/simple;
	bh=c0imhKHbJkUS2T2103cRnQw57MXF9vmxeRzMctCDrmA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=m5HtUlTLe9bf6hjhvY9eaXf9dFktOdXWcObizjQSOVL2EmSBMhqTW+M3Uu8c3AYrDlY96N8cGoSUbsfJZmqR0hx9LiVOb/42Jij4rCMseZmmeUqybdlLx71VXtyN759rCCerxPabZRznW3NFpTxjgaJSLHpwsftbX5AzycMEqr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 55UALWld048042;
	Mon, 30 Jun 2025 19:21:32 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 55UALVLY048038
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 30 Jun 2025 19:21:32 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <da5be67d-2a0b-4b93-85d6-42f3b7440135@I-love.SAKURA.ne.jp>
Date: Mon, 30 Jun 2025 19:21:31 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v3] ocfs2: update d_splice_alias() return code checking
To: Joseph Qi <joseph.qi@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <d689279f-03ed-4f9b-8fde-713b2431f303@I-love.SAKURA.ne.jp>
 <20250626033411.GU1880847@ZenIV>
 <d84dc916-2982-45dc-a9a5-a6255cbc62bd@I-love.SAKURA.ne.jp>
 <973af6b9-e4c7-4519-99af-9c82dc6ca98f@linux.alibaba.com>
Content-Language: en-US
Cc: Al Viro <viro@zeniv.linux.org.uk>, Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>, Richard Weinberger <richard@nod.at>,
        ocfs2-devel@lists.linux.dev,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <973af6b9-e4c7-4519-99af-9c82dc6ca98f@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav203.rs.sakura.ne.jp
X-Virus-Status: clean

When commit d3556babd7fa ("ocfs2: fix d_splice_alias() return code
checking") was merged into v3.18-rc3, d_splice_alias() was returning
one of a valid dentry, NULL or an ERR_PTR.

When commit b5ae6b15bd73 ("merge d_materialise_unique() into
d_splice_alias()") was merged into v3.19-rc1, d_splice_alias() started
returning -ELOOP as one of ERR_PTR values.

Now, when syzkaller mounts a crafted ocfs2 filesystem image that hits
d_splice_alias() == -ELOOP case from ocfs2_lookup(), ocfs2_lookup() fails
to handle -ELOOP case and generic_shutdown_super() hits "VFS: Busy inodes
after unmount" message.

Instead of calling ocfs2_dentry_attach_lock() or ocfs2_dentry_attach_gen()
when d_splice_alias() returned an ERR_PTR value, change ocfs2_lookup() to
bail out immediately.

Also, ocfs2_lookup() needs to call dupt() when ocfs2_dentry_attach_lock()
returned an ERR_PTR value.

Reported-by: syzbot <syzbot+1134d3a5b062e9665a7a@syzkaller.appspotmail.com>
Closes: https://syzkaller.appspot.com/bug?extid=1134d3a5b062e9665a7a
Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 fs/ocfs2/namei.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/ocfs2/namei.c b/fs/ocfs2/namei.c
index 99278c8f0e24..721580dfce3a 100644
--- a/fs/ocfs2/namei.c
+++ b/fs/ocfs2/namei.c
@@ -142,6 +142,8 @@ static struct dentry *ocfs2_lookup(struct inode *dir, struct dentry *dentry,
 
 bail_add:
 	ret = d_splice_alias(inode, dentry);
+	if (IS_ERR(ret))
+		goto bail_unlock;
 
 	if (inode) {
 		/*
@@ -154,15 +156,16 @@ static struct dentry *ocfs2_lookup(struct inode *dir, struct dentry *dentry,
 		 * NOTE: This dentry already has ->d_op set from
 		 * ocfs2_get_parent() and ocfs2_get_dentry()
 		 */
-		if (!IS_ERR_OR_NULL(ret))
+		if (ret)
 			dentry = ret;
 
 		status = ocfs2_dentry_attach_lock(dentry, inode,
 						  OCFS2_I(dir)->ip_blkno);
 		if (status) {
 			mlog_errno(status);
+			if (ret)
+				dput(ret);
 			ret = ERR_PTR(status);
-			goto bail_unlock;
 		}
 	} else
 		ocfs2_dentry_attach_gen(dentry);
-- 
2.47.1



