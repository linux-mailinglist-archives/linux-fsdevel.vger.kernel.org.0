Return-Path: <linux-fsdevel+bounces-71073-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B94CB3E39
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Dec 2025 20:45:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 76029305E36A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Dec 2025 19:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 575D332A3C2;
	Wed, 10 Dec 2025 19:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iB8O9N89"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF4926C3BE
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Dec 2025 19:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765395868; cv=none; b=cJAzscSr2YLMOeKyOV/MVI8k2LfAtEGHTLlg0/W6AIsIkoUOt3MG/ANgnCXv8gbAqCDOotgBIBt8A7FlCWMlOwqWpKmzdvj6owkiuWU4h5WoGuq8extndLcy5Go6pcmsvgOp2XdX666vGTYFzGCd4pt5ctyjgxJGgIbr2J5hZ1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765395868; c=relaxed/simple;
	bh=BM5U+ur8+kuwJUHAcEm6G04NmyxtWiuOzK70jRwbkjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IZTWLJNldTpMJkvhf5lnUKbpxZxtU8Oy2m+RTwP+/ZSLm18K5GRToljN/qR7az0PKOdqUN057hWj5kyLrgoqn5lNMiV/hrq5mPgF1OTDM/pKvZryHnR88+wa0/TzwCdNoaAjqawDbAeaga8xvN7mZQjWH//8k0ooCju3foFP9rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iB8O9N89; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b7697e8b01aso23376866b.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Dec 2025 11:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765395865; x=1766000665; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AH3EyuDOOrGQUL8UyQ9msmnt00BT3pZvjBZ/byMHlXg=;
        b=iB8O9N89NXDBw1P8y/n3EHAqV8OEbgsm8tmz7zPg+fj80aILcgoxKuoYlsQ9zh4rE6
         7fJ6LiphaG+OdyhWhqmRhJJlV51E+khwlA7y0TU6Vni5py1x4a/DItJMELNTxRXVFIeO
         SOHUstzBmOz5FtucOaMBd7mgzHMfcW8F1HOMNvd2oHRwAnqfJIe1nxuCH07lE7c4XU6r
         R7feFdu4YF0wRFYUDT0NcgRsVi9+zuQFak3rL4QTabq4CRzS0uAhPW3qXVPaAfRrRB1Q
         GQ0MagtOlCaPbe9jiHt7qFJ1lUbYSmTKCqBwUUhpGFSiL1OimwHBJ17Y2vPps8D+M7AF
         kN4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765395865; x=1766000665;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AH3EyuDOOrGQUL8UyQ9msmnt00BT3pZvjBZ/byMHlXg=;
        b=g8Q47uPbyE19Diq1b/whVCnPcFGgFpPMsDIdZ3YrItnw5MxtbNcjqmHh7Hirizx8cU
         eHArh53Q/bLWRUEDNjPhMm2UKFyM5yJZgEytT4RZmyM50WvS7iXHqX0+Bpxu7AooEvVp
         EzGz/S0jhu82ZIzeMqYc9kl2f40u4Ioj4wcb9uu1xZ2oEf/iSvZ00Xae0fTLhpTCBAd9
         M33/JpUud56+xAMxU9pltTtV73zEZ4Cng+1I1jm9bIFH4KrG2YRvIJrLsbcLcCBHLv/V
         Q+UjoqpxJWXl/K7sVSTHLZFJWYGz6PhH0Kd0xdETVIYp7gbNEz2tcR7zLHIuKUu6yPGY
         ceTA==
X-Forwarded-Encrypted: i=1; AJvYcCV9T6gjSxYOWheMuyrg0n965+McNPUkUohSc9FXjvHhVaEqBTtem8rv8Kp3Rpy4NJnf5ihPsvRxaoM/DmPP@vger.kernel.org
X-Gm-Message-State: AOJu0YykLo0BoBuuEMAtcu8gQo49udleYBS7aTesEj9SZZxzy9w5+Zql
	2V38WT93FOMnT0S/G2slotWqR06cn8i0ztXp1/hjIswQxPcFXo6vKNbG
X-Gm-Gg: ASbGncvEXrjHYjnxbwJgLCfMW0VN/iY/xYnKmOuZvdJL/X9pd2HU+jt3v4QfJwncdC+
	oL1FbIfu6c8Ht4stj+sXroukmBvBhRXE+VYCmVICMLXmG8LD1MCzAjlhxJs6ql+1o+pEJ5VzsXK
	afnAytVDrbZj/EAnUHZeGBowmxiYFDGxGJ4BEx8GhMXqPNC4a39tv/XBFUSWm5t0oKFLyP1HYY3
	IN1tiWgL4IP7mVn4nBozjiuilRrrj/0bSQhD6LEZiDx6qsHCionplmpIfpT/L6DtVD8R36FxWqY
	/Q00XH2NVNxzq2XoSbbUZCQ6acMntBwvim5VMunJRIUlHZtWMPGvZ6vwEBvij+6hXy3wo/rWrWP
	I6U5DR1/cBrJw5+r0BUmEf0nCd3j/cDCClq5E/UIAkMfoU0LxO1V9QIE3Im93Vq4e/cF4xZcHfY
	VPLBapPM46gzPv8YUxGcpOqTjsNHvGJ+vFCSoOpYbgPEIJEFAaY1/S9c28z24FgMbCF8mgWA==
X-Google-Smtp-Source: AGHT+IGGmaJskMrczwvREm0lrYOhNSY1gkqqtq5Hr2CDTE4maS/m0w6W08TOf7XoqXekv+k+DhfmTA==
X-Received: by 2002:a17:907:6e94:b0:b79:e99d:913d with SMTP id a640c23a62f3a-b7ce84a901dmr342173766b.42.1765395864453;
        Wed, 10 Dec 2025 11:44:24 -0800 (PST)
Received: from f (cst-prg-23-145.cust.vodafone.cz. [46.135.23.145])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7cfa56c152sm39047466b.56.2025.12.10.11.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 11:44:23 -0800 (PST)
Date: Wed, 10 Dec 2025 20:44:08 +0100
From: Mateusz Guzik <mjguzik@gmail.com>
To: syzbot <syzbot+d222f4b7129379c3d5bc@syzkaller.appspotmail.com>
Cc: brauner@kernel.org, jack@suse.cz, jlbec@evilplan.org, 
	joseph.qi@linux.alibaba.com, linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mark@fasheh.com, ocfs2-devel@lists.linux.dev, 
	sj1557.seo@samsung.com, syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [exfat?] [ocfs2?] kernel BUG in link_path_walk
Message-ID: <ff7k3zlpiueyyykotdpfcaoxn2tukceoqcbmfdwjfolndy4sen@3f5r362sg67g>
References: <6930d0bf.a70a0220.2ea503.00d4.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6930d0bf.a70a0220.2ea503.00d4.GAE@google.com>

Justin Case suggested the following:

#syz test

diff --git a/fs/bad_inode.c b/fs/bad_inode.c
index 0ef9bcb744dd..8e9127d4dcc1 100644
--- a/fs/bad_inode.c
+++ b/fs/bad_inode.c
@@ -207,11 +207,17 @@ void make_bad_inode(struct inode *inode)
 {
 	remove_inode_hash(inode);
 
+	/*
+	 * Taking the spinlock is a temporary hack to let lookup assert on the state,
+	 * see lookup_inode_permission_may_exec().
+	 */
+	spin_lock(&inode->i_lock);
 	inode->i_mode = S_IFREG;
 	simple_inode_init_ts(inode);
 	inode->i_op = &bad_inode_ops;	
 	inode->i_opflags &= ~IOP_XATTR;
 	inode->i_fop = &bad_file_ops;	
+	spin_unlock(&inode->i_lock);
 }
 EXPORT_SYMBOL(make_bad_inode);
 
diff --git a/fs/namei.c b/fs/namei.c
index bf0f66f0e9b9..79cc14d635b5 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -626,12 +626,31 @@ EXPORT_SYMBOL(inode_permission);
 static __always_inline int lookup_inode_permission_may_exec(struct mnt_idmap *idmap,
 	struct inode *inode, int mask)
 {
-	/* Lookup already checked this to return -ENOTDIR */
-	VFS_BUG_ON_INODE(!S_ISDIR(inode->i_mode), inode);
 	VFS_BUG_ON((mask & ~MAY_NOT_BLOCK) != 0);
+#ifdef CONFIG_DEBUG_VFS
+	/*
+	 * We skip the type check on the assumption this is a directory, which was
+	 * checked for by our caller.
+	 *
+	 * However, there are bogus consumers of make_bad_inode() which can mess this up,
+	 * to be fixed soon(tm).
+	 *
+	 * In the meantime make sure we are dealing with the expected state before tripping
+	 * over. If this *is* a "bad inode", the resulting state is bug-compatible with
+	 * historical behavior. See the previous remark about sorting this out.
+	 */
+	if (!S_ISDIR(inode->i_mode)) {
+		spin_lock(&inode->i_lock);
+		if (!is_bad_inode(inode))
+			VFS_BUG_ON_INODE(!S_ISDIR(inode->i_mode), inode);
+		spin_unlock(&inode->i_lock);
+	}
+#endif
 
 	mask |= MAY_EXEC;
 
+	return inode_permission(idmap, inode, mask);
+#if 0
 	if (unlikely(!(inode->i_opflags & (IOP_FASTPERM | IOP_FASTPERM_MAY_EXEC))))
 		return inode_permission(idmap, inode, mask);
 
@@ -639,6 +658,7 @@ static __always_inline int lookup_inode_permission_may_exec(struct mnt_idmap *id
 		return inode_permission(idmap, inode, mask);
 
 	return security_inode_permission(inode, mask);
+#endif
 }
 
 /**

