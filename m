Return-Path: <linux-fsdevel+bounces-77858-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UL5oFYXjmWkRXQMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77858-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Feb 2026 17:55:33 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C0B16D559
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Feb 2026 17:55:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D615230495FA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Feb 2026 16:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70410353EF6;
	Sat, 21 Feb 2026 16:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IF9kzaBh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799DC43AA6
	for <linux-fsdevel@vger.kernel.org>; Sat, 21 Feb 2026 16:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771692929; cv=none; b=tTIaQCj3ApzlIrleVbigj60ubJHjc8ulfPwmTCCrFRNKUUvjZ314zcXCOwG7r0ilgVa02CkPy52Bu68BegxGhclrYPPDSRUOgOee6C6BT1Ft1Y2ggK8F6VC00JfAqAjm42xyPm/5rP16wQCHPytMd8SjRigk+QfdKWauV7D057o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771692929; c=relaxed/simple;
	bh=U57Xqi41GmcO0x6P9Zx3BaCcGSfhRtmMSS7Uf1PuLxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dfrZg1b9h/5rAIYMPblG4SlWNVHhEwpaJCIT0xap1nwPFSKybVIpVqsApSkbrB1XTe/BTOqRiK8+u6diQT1YcgNHj6AcQCe/qUqhJerJW63I3PRP6fKvAFx0DtE4sZnZH3n7ro4tmt1tXrbVtNFXOgqvvqZw8t5IEB3gYZjnbtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IF9kzaBh; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8c70b5594f4so345820885a.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 21 Feb 2026 08:55:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771692926; x=1772297726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+im6HE0V+UhU/UpPycv1gj885b94imjLQRZ7n5HPX5c=;
        b=IF9kzaBhln7WqPPhoSKNBAZ4Q/tKVblBn+aT+t0DvHc5q8/Ubmp3bmH1fdC0DRf3BQ
         DF9qed4Q6OhlnQLHAaFG3Acs/ZO5ZB+xYeDHVFo9OswNKpfWoHNbNToPM3XeoGDJc5lB
         QjxyzJlFhQYhAd9DtZSMYeTdMfWU7JAaNXAfHEjUI3zxObaAGfCWiAJoMjrk0TJxLid/
         oXDOUEK4Tlm9aP0hXspDYNfQFwnQMifqnQgnhdWipcZ96eGwHTzPQdxc+kpENKh40SsY
         QFNIdJlAk6FmnFIuO/xaFOR1EecSe3SLlAISguB0S4Nzk6Qwsv2LUxA8Y3r0oJ3/3Il/
         Vmlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771692926; x=1772297726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+im6HE0V+UhU/UpPycv1gj885b94imjLQRZ7n5HPX5c=;
        b=dCmAPGuhHq2LrjVhaNFh2I5npPqZiInBjmoeAdJLq7CzMitiUBshjSsw6KrSdV/vMx
         nRJO5PxJWSbOUMnekV2yZtQyUl6P49LCnF7IMwdMWu4TTANQkv1DwlfmF//YBrU0ymtJ
         sG02Zhg3yC01DYPBy75a0CI+hll1dNAQN7oIlvH11IwnLgYFR03LN5NGiaw11ogo0cUt
         dgxEQhfANo0LAfAKkVq/ed6xzCGBqp9dGlYIODAnmD7C+NgS8kcj1ZfiVCuMwaIfg1jB
         8c81wdSTdYCtEEZBG7fgocYdvQX9Abh8a6Ek37AUjwoPgzb3F5+99+IGZIZ0YxqdXPKe
         c59A==
X-Gm-Message-State: AOJu0YyMpurEl+k68Mygknl84Sqw4t5K5LMzyBBUnjMpiiDvUemG56kR
	Tv7v2R8I9fA7IK2rMF/g786PX/4s1ozTzobGKc1jrSv1/xTjDz9iM+9qF7NU9g==
X-Gm-Gg: AZuq6aLNtEKoJam6VA3k/KwR2q278skjmaMEi1XyvLZcNkwiF7xmO4aVt3YmW7/96qA
	mVcItdz4Z/Qtk/utmrhaRhcNBtpEIN9lcsWIFa707q4F34f9zhj82CU33TmEWshSS79XAoOswZ+
	QenSnyKfwBQcNo1Dekuow09dCVIdEUdU4NMvoTuabTwtBp+6MZTIGTZCdsb0YgbBcf/VosGjr2r
	Fn38bfFJOfsat8TJNKq0+CbOxW5T68nGUT0rpMXYYOgAIMMqLAUw6DWr9zzMI/+Lad0hRnk39fR
	pwk710pNGYuXyIa5dIXNGkqwC9aXAMF431fc4gmlTcvMIIWeDkikYSv719xj65UouqQmdv3apHP
	28cJ8sl8WUnS2oroLcbMjhtEd65TJAc5ljPQx7nWcFezuZmzdIwelko/H6z1a0ZLSSKCmY3nt1G
	kFso4IeBylP5NlI8wwbJv2TtL24PSkhy717BTTGdsb1pF0PAt9YPPmmIM=
X-Received: by 2002:a17:902:d48c:b0:2aa:f5b4:9a2e with SMTP id d9443c01a7336-2ad5f7349eemr96972465ad.11.1771685998012;
        Sat, 21 Feb 2026 06:59:58 -0800 (PST)
Received: from toolbx ([103.230.182.3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad7503f4a4sm23730205ad.79.2026.02.21.06.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Feb 2026 06:59:57 -0800 (PST)
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-nfs@vger.kernel.org,
	linux-cifs@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	jlayton@kernel.org,
	chuck.lever@oracle.com,
	alex.aring@gmail.com,
	arnd@arndb.de,
	adilger@dilger.ca,
	mjguzik@gmail.com,
	smfrench@gmail.com,
	richard.henderson@linaro.org,
	mattst88@gmail.com,
	linmag7@gmail.com,
	tsbogend@alpha.franken.de,
	James.Bottomley@HansenPartnership.com,
	deller@gmx.de,
	davem@davemloft.net,
	andreas@gaisler.com,
	idryomov@gmail.com,
	amarkuze@redhat.com,
	slava@dubeyko.com,
	agruenba@redhat.com,
	trondmy@kernel.org,
	anna@kernel.org,
	sfrench@samba.org,
	pc@manguebit.org,
	ronniesahlberg@gmail.com,
	sprasad@microsoft.com,
	tom@talpey.com,
	bharathsm@microsoft.com,
	shuah@kernel.org,
	miklos@szeredi.hu,
	hansg@kernel.org
Subject: [PATCH v4 1/4] openat2: new OPENAT2_REGULAR flag support
Date: Sat, 21 Feb 2026 20:45:43 +0600
Message-ID: <20260221145915.81749-2-dorjoychy111@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260221145915.81749-1-dorjoychy111@gmail.com>
References: <20260221145915.81749-1-dorjoychy111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[41];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,zeniv.linux.org.uk,kernel.org,suse.cz,oracle.com,gmail.com,arndb.de,dilger.ca,linaro.org,alpha.franken.de,HansenPartnership.com,gmx.de,davemloft.net,gaisler.com,redhat.com,dubeyko.com,samba.org,manguebit.org,microsoft.com,talpey.com,szeredi.hu];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77858-lists,linux-fsdevel=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dorjoychy111@gmail.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,uapi-group.org:url]
X-Rspamd-Queue-Id: A9C0B16D559
X-Rspamd-Action: no action

This flag indicates the path should be opened if it's a regular file.
This is useful to write secure programs that want to avoid being
tricked into opening device nodes with special semantics while thinking
they operate on regular files. This is a requested feature from the
uapi-group[1].

A corresponding error code EFTYPE has been introduced. For example, if
openat2 is called on path /dev/null with OPENAT2_REGULAR in the flag
param, it will return -EFTYPE.

When used in combination with O_CREAT, either the regular file is
created, or if the path already exists, it is opened if it's a regular
file. Otherwise, -EFTYPE is returned.

When OPENAT2_REGULAR is combined with O_DIRECTORY, -EINVAL is returned
as it doesn't make sense to open a path that is both a directory and a
regular file.

[1]: https://uapi-group.org/kernel-features/#ability-to-only-open-regular-files

Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
---
 arch/alpha/include/uapi/asm/errno.h        |  2 ++
 arch/alpha/include/uapi/asm/fcntl.h        |  1 +
 arch/mips/include/uapi/asm/errno.h         |  2 ++
 arch/parisc/include/uapi/asm/errno.h       |  2 ++
 arch/parisc/include/uapi/asm/fcntl.h       |  1 +
 arch/sparc/include/uapi/asm/errno.h        |  2 ++
 arch/sparc/include/uapi/asm/fcntl.h        |  1 +
 fs/ceph/file.c                             |  4 ++++
 fs/gfs2/inode.c                            |  2 ++
 fs/namei.c                                 |  4 ++++
 fs/nfs/dir.c                               |  4 +++-
 fs/open.c                                  |  4 +++-
 fs/smb/client/dir.c                        | 11 ++++++++++-
 include/linux/fcntl.h                      |  2 ++
 include/uapi/asm-generic/errno.h           |  2 ++
 include/uapi/asm-generic/fcntl.h           |  4 ++++
 tools/arch/alpha/include/uapi/asm/errno.h  |  2 ++
 tools/arch/mips/include/uapi/asm/errno.h   |  2 ++
 tools/arch/parisc/include/uapi/asm/errno.h |  2 ++
 tools/arch/sparc/include/uapi/asm/errno.h  |  2 ++
 tools/include/uapi/asm-generic/errno.h     |  2 ++
 21 files changed, 55 insertions(+), 3 deletions(-)

diff --git a/arch/alpha/include/uapi/asm/errno.h b/arch/alpha/include/uapi/asm/errno.h
index 6791f6508632..1a99f38813c7 100644
--- a/arch/alpha/include/uapi/asm/errno.h
+++ b/arch/alpha/include/uapi/asm/errno.h
@@ -127,4 +127,6 @@
 
 #define EHWPOISON	139	/* Memory page has hardware error */
 
+#define EFTYPE		140	/* Wrong file type for the intended operation */
+
 #endif
diff --git a/arch/alpha/include/uapi/asm/fcntl.h b/arch/alpha/include/uapi/asm/fcntl.h
index 50bdc8e8a271..fe488bf7c18e 100644
--- a/arch/alpha/include/uapi/asm/fcntl.h
+++ b/arch/alpha/include/uapi/asm/fcntl.h
@@ -34,6 +34,7 @@
 
 #define O_PATH		040000000
 #define __O_TMPFILE	0100000000
+#define OPENAT2_REGULAR	0200000000
 
 #define F_GETLK		7
 #define F_SETLK		8
diff --git a/arch/mips/include/uapi/asm/errno.h b/arch/mips/include/uapi/asm/errno.h
index c01ed91b1ef4..1835a50b69ce 100644
--- a/arch/mips/include/uapi/asm/errno.h
+++ b/arch/mips/include/uapi/asm/errno.h
@@ -126,6 +126,8 @@
 
 #define EHWPOISON	168	/* Memory page has hardware error */
 
+#define EFTYPE		169	/* Wrong file type for the intended operation */
+
 #define EDQUOT		1133	/* Quota exceeded */
 
 
diff --git a/arch/parisc/include/uapi/asm/errno.h b/arch/parisc/include/uapi/asm/errno.h
index 8cbc07c1903e..93194fbb0a80 100644
--- a/arch/parisc/include/uapi/asm/errno.h
+++ b/arch/parisc/include/uapi/asm/errno.h
@@ -124,4 +124,6 @@
 
 #define EHWPOISON	257	/* Memory page has hardware error */
 
+#define EFTYPE		258	/* Wrong file type for the intended operation */
+
 #endif
diff --git a/arch/parisc/include/uapi/asm/fcntl.h b/arch/parisc/include/uapi/asm/fcntl.h
index 03dee816cb13..d46812f2f0f4 100644
--- a/arch/parisc/include/uapi/asm/fcntl.h
+++ b/arch/parisc/include/uapi/asm/fcntl.h
@@ -19,6 +19,7 @@
 
 #define O_PATH		020000000
 #define __O_TMPFILE	040000000
+#define OPENAT2_REGULAR	0100000000
 
 #define F_GETLK64	8
 #define F_SETLK64	9
diff --git a/arch/sparc/include/uapi/asm/errno.h b/arch/sparc/include/uapi/asm/errno.h
index 4a41e7835fd5..71940ec9130b 100644
--- a/arch/sparc/include/uapi/asm/errno.h
+++ b/arch/sparc/include/uapi/asm/errno.h
@@ -117,4 +117,6 @@
 
 #define EHWPOISON	135	/* Memory page has hardware error */
 
+#define EFTYPE		136	/* Wrong file type for the intended operation */
+
 #endif
diff --git a/arch/sparc/include/uapi/asm/fcntl.h b/arch/sparc/include/uapi/asm/fcntl.h
index 67dae75e5274..bb6e9fa94bc9 100644
--- a/arch/sparc/include/uapi/asm/fcntl.h
+++ b/arch/sparc/include/uapi/asm/fcntl.h
@@ -37,6 +37,7 @@
 
 #define O_PATH		0x1000000
 #define __O_TMPFILE	0x2000000
+#define OPENAT2_REGULAR	0x4000000
 
 #define F_GETOWN	5	/*  for sockets. */
 #define F_SETOWN	6	/*  for sockets. */
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 31b691b2aea2..0a4220f72ada 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -977,6 +977,10 @@ int ceph_atomic_open(struct inode *dir, struct dentry *dentry,
 			ceph_init_inode_acls(newino, &as_ctx);
 			file->f_mode |= FMODE_CREATED;
 		}
+		if ((flags & OPENAT2_REGULAR) && !d_is_reg(dentry)) {
+			err = -EFTYPE;
+			goto out_req;
+		}
 		err = finish_open(file, dentry, ceph_open);
 	}
 out_req:
diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index 8344040ecaf7..0dc3e4240d9e 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -749,6 +749,8 @@ static int gfs2_create_inode(struct inode *dir, struct dentry *dentry,
 		if (file) {
 			if (S_ISREG(inode->i_mode))
 				error = finish_open(file, dentry, gfs2_open_common);
+			else if (file->f_flags & OPENAT2_REGULAR)
+				error = -EFTYPE;
 			else
 				error = finish_no_open(file, NULL);
 		}
diff --git a/fs/namei.c b/fs/namei.c
index 5fe6cac48df8..aa5fb2672881 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4651,6 +4651,10 @@ static int do_open(struct nameidata *nd,
 		if (unlikely(error))
 			return error;
 	}
+
+	if ((open_flag & OPENAT2_REGULAR) && !d_is_reg(nd->path.dentry))
+		return -EFTYPE;
+
 	if ((nd->flags & LOOKUP_DIRECTORY) && !d_can_lookup(nd->path.dentry))
 		return -ENOTDIR;
 
diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index b3f5c9461204..ef61db67d06e 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -2195,7 +2195,9 @@ int nfs_atomic_open(struct inode *dir, struct dentry *dentry,
 			break;
 		case -EISDIR:
 		case -ENOTDIR:
-			goto no_open;
+			if (!(open_flags & OPENAT2_REGULAR))
+				goto no_open;
+			break;
 		case -ELOOP:
 			if (!(open_flags & O_NOFOLLOW))
 				goto no_open;
diff --git a/fs/open.c b/fs/open.c
index 91f1139591ab..1524f52a1773 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1198,7 +1198,7 @@ inline int build_open_flags(const struct open_how *how, struct open_flags *op)
 	 * values before calling build_open_flags(), but openat2(2) checks all
 	 * of its arguments.
 	 */
-	if (flags & ~VALID_OPEN_FLAGS)
+	if (flags & ~VALID_OPENAT2_FLAGS)
 		return -EINVAL;
 	if (how->resolve & ~VALID_RESOLVE_FLAGS)
 		return -EINVAL;
@@ -1237,6 +1237,8 @@ inline int build_open_flags(const struct open_how *how, struct open_flags *op)
 			return -EINVAL;
 		if (!(acc_mode & MAY_WRITE))
 			return -EINVAL;
+	} else if ((flags & O_DIRECTORY) && (flags & OPENAT2_REGULAR)) {
+		return -EINVAL;
 	}
 	if (flags & O_PATH) {
 		/* O_PATH only permits certain other flags to be set. */
diff --git a/fs/smb/client/dir.c b/fs/smb/client/dir.c
index cb10088197d2..d12ed0c87599 100644
--- a/fs/smb/client/dir.c
+++ b/fs/smb/client/dir.c
@@ -236,6 +236,11 @@ static int cifs_do_create(struct inode *inode, struct dentry *direntry, unsigned
 				 * lookup.
 				 */
 				CIFSSMBClose(xid, tcon, fid->netfid);
+				if (oflags & OPENAT2_REGULAR) {
+					iput(newinode);
+					rc = -EFTYPE;
+					goto out;
+				}
 				goto cifs_create_get_file_info;
 			}
 			/* success, no need to query */
@@ -433,11 +438,15 @@ static int cifs_do_create(struct inode *inode, struct dentry *direntry, unsigned
 		goto out_err;
 	}
 
-	if (newinode)
+	if (newinode) {
 		if (S_ISDIR(newinode->i_mode)) {
 			rc = -EISDIR;
 			goto out_err;
+		} else if ((oflags & OPENAT2_REGULAR) && !S_ISREG(newinode->i_mode)) {
+			rc = -EFTYPE;
+			goto out_err;
 		}
+	}
 
 	d_drop(direntry);
 	d_add(direntry, newinode);
diff --git a/include/linux/fcntl.h b/include/linux/fcntl.h
index a332e79b3207..a80026718217 100644
--- a/include/linux/fcntl.h
+++ b/include/linux/fcntl.h
@@ -12,6 +12,8 @@
 	 FASYNC	| O_DIRECT | O_LARGEFILE | O_DIRECTORY | O_NOFOLLOW | \
 	 O_NOATIME | O_CLOEXEC | O_PATH | __O_TMPFILE)
 
+#define VALID_OPENAT2_FLAGS (VALID_OPEN_FLAGS | OPENAT2_REGULAR)
+
 /* List of all valid flags for the how->resolve argument: */
 #define VALID_RESOLVE_FLAGS \
 	(RESOLVE_NO_XDEV | RESOLVE_NO_MAGICLINKS | RESOLVE_NO_SYMLINKS | \
diff --git a/include/uapi/asm-generic/errno.h b/include/uapi/asm-generic/errno.h
index 92e7ae493ee3..bd78e69e0a43 100644
--- a/include/uapi/asm-generic/errno.h
+++ b/include/uapi/asm-generic/errno.h
@@ -122,4 +122,6 @@
 
 #define EHWPOISON	133	/* Memory page has hardware error */
 
+#define EFTYPE		134	/* Wrong file type for the intended operation */
+
 #endif
diff --git a/include/uapi/asm-generic/fcntl.h b/include/uapi/asm-generic/fcntl.h
index 613475285643..b2c2ddd0edc0 100644
--- a/include/uapi/asm-generic/fcntl.h
+++ b/include/uapi/asm-generic/fcntl.h
@@ -88,6 +88,10 @@
 #define __O_TMPFILE	020000000
 #endif
 
+#ifndef OPENAT2_REGULAR
+#define OPENAT2_REGULAR	040000000
+#endif
+
 /* a horrid kludge trying to make sure that this will fail on old kernels */
 #define O_TMPFILE (__O_TMPFILE | O_DIRECTORY)
 
diff --git a/tools/arch/alpha/include/uapi/asm/errno.h b/tools/arch/alpha/include/uapi/asm/errno.h
index 6791f6508632..1a99f38813c7 100644
--- a/tools/arch/alpha/include/uapi/asm/errno.h
+++ b/tools/arch/alpha/include/uapi/asm/errno.h
@@ -127,4 +127,6 @@
 
 #define EHWPOISON	139	/* Memory page has hardware error */
 
+#define EFTYPE		140	/* Wrong file type for the intended operation */
+
 #endif
diff --git a/tools/arch/mips/include/uapi/asm/errno.h b/tools/arch/mips/include/uapi/asm/errno.h
index c01ed91b1ef4..1835a50b69ce 100644
--- a/tools/arch/mips/include/uapi/asm/errno.h
+++ b/tools/arch/mips/include/uapi/asm/errno.h
@@ -126,6 +126,8 @@
 
 #define EHWPOISON	168	/* Memory page has hardware error */
 
+#define EFTYPE		169	/* Wrong file type for the intended operation */
+
 #define EDQUOT		1133	/* Quota exceeded */
 
 
diff --git a/tools/arch/parisc/include/uapi/asm/errno.h b/tools/arch/parisc/include/uapi/asm/errno.h
index 8cbc07c1903e..93194fbb0a80 100644
--- a/tools/arch/parisc/include/uapi/asm/errno.h
+++ b/tools/arch/parisc/include/uapi/asm/errno.h
@@ -124,4 +124,6 @@
 
 #define EHWPOISON	257	/* Memory page has hardware error */
 
+#define EFTYPE		258	/* Wrong file type for the intended operation */
+
 #endif
diff --git a/tools/arch/sparc/include/uapi/asm/errno.h b/tools/arch/sparc/include/uapi/asm/errno.h
index 4a41e7835fd5..71940ec9130b 100644
--- a/tools/arch/sparc/include/uapi/asm/errno.h
+++ b/tools/arch/sparc/include/uapi/asm/errno.h
@@ -117,4 +117,6 @@
 
 #define EHWPOISON	135	/* Memory page has hardware error */
 
+#define EFTYPE		136	/* Wrong file type for the intended operation */
+
 #endif
diff --git a/tools/include/uapi/asm-generic/errno.h b/tools/include/uapi/asm-generic/errno.h
index 92e7ae493ee3..bd78e69e0a43 100644
--- a/tools/include/uapi/asm-generic/errno.h
+++ b/tools/include/uapi/asm-generic/errno.h
@@ -122,4 +122,6 @@
 
 #define EHWPOISON	133	/* Memory page has hardware error */
 
+#define EFTYPE		134	/* Wrong file type for the intended operation */
+
 #endif
-- 
2.53.0


