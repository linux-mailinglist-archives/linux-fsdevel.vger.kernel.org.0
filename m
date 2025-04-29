Return-Path: <linux-fsdevel+bounces-47571-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6729AA07B2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 11:48:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A2F2844DC6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 09:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFEFD2BE7B4;
	Tue, 29 Apr 2025 09:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="eYAveLgE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7340429E059
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Apr 2025 09:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745920012; cv=none; b=V5W+ZlVgjovL8yz//m2p8XvLqs8n5LxUK0tECuMSQDv6Xb/P+8WIPTPDEWPbwTakOCM/tnVhWUSDDNVTTGOuuTf68DkRklZnE6tffsUa+cpbdY1s/G8fWdqgcG70szLJMf9XzY7GGc+WuSN1P7Np3tl8rnRhBPBbkSrSXBDU7fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745920012; c=relaxed/simple;
	bh=AeKWSJmiN8iAK+uVu2ieF+hO9jl5x9VDzPNaYAevQao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OHCu5++Vyp5FMHhp3seB5mwYw7zyVqu8DLBWcWiLoMOKoXSi5IaxUkF/Yv5Fz/SphpEVyUKowAwcsdrskZu1WyoKT9GzPHg3N4wREjt1r+rTy9b2YXhlcOZuYDLqMvaOkwZ9of3ycfd9XNGWH3CSY/ObboXx5JV9wlVUpS+76x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=eYAveLgE; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43cf848528aso41049125e9.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Apr 2025 02:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1745920008; x=1746524808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FWtEW0Fw6mMrZWVIgF9jffmLWBhDa/XPlG8gKYF8LLg=;
        b=eYAveLgEtJPIFF28dtcXtf1nSdm8+ebWDuGnc0Na1M5IVH+shsCia8yRTYahrqcKaK
         tNkkhloEAbiV+lfYFr69WwQNq+uX/HBww8/t8l2InAPB8tzalczgYljlXNWBmq/XEIyW
         FHmpXNyEkWDT+xgtzFgMCXGsTSO8+6saS1ZlBGNBq6c6dr53J/lpl/zwn5gFrdy6SsrQ
         u2eZHxOoOV4fE2r0od9niCDD6E30KDcxc2L02cI4faaKbkjkuL3bOuvItMhBxOT1JOmr
         zGxR2IISXzvX60rdbYDGHyQRdPQisVOM93iMVDbbd+97AOqHkxg/IP1hy07MiVP8tB5q
         5x8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745920008; x=1746524808;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FWtEW0Fw6mMrZWVIgF9jffmLWBhDa/XPlG8gKYF8LLg=;
        b=BqJjf/PyYrFA/AqtIPlY1UE6NHwD5EEnLMKqhVEN0aCEb+eAkH9pD5RqACWCVR2mMJ
         X1GkEtP2EVzmt8Qt2RRRuJxsGTIzP+JnS/98hAvhMP4Koc2wKnPK0CE4xwn0nNGN0q3a
         dJISgLhVHLXx6FdPX91S61JIfss2AiLaxDHCPf68yhD+pXtVM7DhP478uRZiOYhktlQB
         5AQcMLZ7kO4QI/ThgmknBQyjc/xn7r1qgzrxhc+zlj+EHkWJrSnDII2nJXAQmnofMDFI
         c1ikXiVSF4TSz5bGzEgwE14a2r9QmALQPxsQMybKEuUKjsfROb5fdRl6EvLw8oj14Hk7
         VTXw==
X-Forwarded-Encrypted: i=1; AJvYcCV9HLSE3azAvXA7NibTFeUSmkyjTikxtHR6EZKv2bbuWrU+6FrOOJUQk8ddSd8vOHmRj4j0Qd+i0pLMs81T@vger.kernel.org
X-Gm-Message-State: AOJu0YyMnQRLkoStyQjNSVe9LdSAhB8GoPhaG2mnu+hZFQgNBkw6Mszp
	l8v2w0UmLa3iPn3TbEt17pn2jr6FmtMZDTURW5jotsvcbqFj2YjOwcDJkQkrjf4=
X-Gm-Gg: ASbGnct+QNvgRxW76sE62q90Z5KXVXT1J1p/GLfPT2BnYfPnXwb8M+q7Hxc9G1E1vRx
	x8wMqtu7dm96u54S65t1RZglMR38Aw1A/IeGfiSvONviVSKUwrI+60J9y5AuJ9c4fU8t8f22O0I
	mW3my5ezb6hXP3to4KpnOd2N3o3lQZn+zdK44GjH49EQ1y2UScA37dyeGgTpq9fbEvfBouUgP/4
	gmDp1Ue3NbT7FTVTze85ZXxsk5Q2yu5J/YqCPU625KMSMVZsW4dQE+5F4TEnUjpOQsu3yD0V1eY
	tWNHJizx9zO89EdrKdlpHJs2FBXVnEhUJ7uJZv4rKdYVGRb50p0DrK/8LArzcWrejST7yvADcTL
	5NMlbvFdS6UMrn1sYciGfge/3LBpR+0Ft34UtOfOq
X-Google-Smtp-Source: AGHT+IFPQLVLxetlM4rzijSZkUU29HGx2KZApNaKDjXu/t7Gi8I8MVg4pmVAhpsVpd8uGH3w5LKWiw==
X-Received: by 2002:a05:600c:1c0a:b0:43d:49eb:9675 with SMTP id 5b1f17b1804b1-441ad4e7dbemr11535915e9.22.1745920007763;
        Tue, 29 Apr 2025 02:46:47 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f46c100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f46:c100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-440a0692a22sm169766855e9.2.2025.04.29.02.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 02:46:47 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH 2/2] fs: make several inode lock operations killable
Date: Tue, 29 Apr 2025 11:46:44 +0200
Message-ID: <20250429094644.3501450-2-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250429094644.3501450-1-max.kellermann@ionos.com>
References: <20250429094644.3501450-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allows killing processes that are waiting for the inode lock.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/open.c       | 14 +++++++++++---
 fs/read_write.c |  4 +++-
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/fs/open.c b/fs/open.c
index a9063cca9911..7828234a7caa 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -60,7 +60,10 @@ int do_truncate(struct mnt_idmap *idmap, struct dentry *dentry,
 	if (ret)
 		newattrs.ia_valid |= ret | ATTR_FORCE;
 
-	inode_lock(dentry->d_inode);
+	ret = inode_lock_killable(dentry->d_inode);
+	if (ret)
+		return ret;
+
 	/* Note any delegations or leases have already been broken: */
 	ret = notify_change(idmap, dentry, &newattrs, NULL);
 	inode_unlock(dentry->d_inode);
@@ -635,7 +638,9 @@ int chmod_common(const struct path *path, umode_t mode)
 	if (error)
 		return error;
 retry_deleg:
-	inode_lock(inode);
+	error = inode_lock_killable(inode);
+	if (error)
+		goto out_mnt_unlock;
 	error = security_path_chmod(path, mode);
 	if (error)
 		goto out_unlock;
@@ -650,6 +655,7 @@ int chmod_common(const struct path *path, umode_t mode)
 		if (!error)
 			goto retry_deleg;
 	}
+out_mnt_unlock:
 	mnt_drop_write(path->mnt);
 	return error;
 }
@@ -769,7 +775,9 @@ int chown_common(const struct path *path, uid_t user, gid_t group)
 		return -EINVAL;
 	if ((group != (gid_t)-1) && !setattr_vfsgid(&newattrs, gid))
 		return -EINVAL;
-	inode_lock(inode);
+	error = inode_lock_killable(inode);
+	if (error)
+		return error;
 	if (!S_ISDIR(inode->i_mode))
 		newattrs.ia_valid |= ATTR_KILL_SUID | ATTR_KILL_PRIV |
 				     setattr_should_drop_sgid(idmap, inode);
diff --git a/fs/read_write.c b/fs/read_write.c
index bb0ed26a0b3a..0ef70e128c4a 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -332,7 +332,9 @@ loff_t default_llseek(struct file *file, loff_t offset, int whence)
 	struct inode *inode = file_inode(file);
 	loff_t retval;
 
-	inode_lock(inode);
+	retval = inode_lock_killable(inode);
+	if (retval)
+		return retval;
 	switch (whence) {
 		case SEEK_END:
 			offset += i_size_read(inode);
-- 
2.47.2


