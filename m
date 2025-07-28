Return-Path: <linux-fsdevel+bounces-56187-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A2B2B14340
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 22:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5581D17B8FD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 20:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47EF4285C81;
	Mon, 28 Jul 2025 20:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PHUI6vCJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106CA279DC0
	for <linux-fsdevel@vger.kernel.org>; Mon, 28 Jul 2025 20:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753734717; cv=none; b=T7GnR/7CUosmwKkdDM/71yy2+bimPChbXCssELn7FuYYueA5XDOZnw0SwS7aEI8M7wbvDT7WUKo9O3Z6zHX4ReihJBIz1f4t1NSAGbQh3wOvVlLpPMf262xfIzw1jLx1SFarN6wEa9Ac1LRGMjkA+mArgdBVBVAsdZWgWeTZaGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753734717; c=relaxed/simple;
	bh=Y5rQ/uxMw3nTbMV8zWBthNRQ4J1L1jCEVXhH/CQJ7Bk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=mSIot8jf8z2uUl+dt8yP1aeC4N/aC8bEyvE8WX+HaViXvdUXTnVvGHOA6pKrv8xXafaXq+9/fItLZkgdm4pWToS1QB0E9UIcNlNjgnnZ+j7f4Gqr8acexvUNcPmdh0Rk8UgKyyvZrsvkOlSWv5BlVmuX4/P7cW5SvSyN+HXt0Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PHUI6vCJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753734713;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z3sjYPp7zGBcepDCn4j2vk3k4XzrI0S0AJoJ8Pw84iw=;
	b=PHUI6vCJO2d+Fr6RJE+15pop2e6kPMtGhwlIXjmkB/jdNnox7/qaNzn1fKPKMt/SVAij3A
	dGHQUovcOGMbEJgiLtVCVJWLTv30mrFrrNmcZAs78EzWkK09iMj/FHt2GdUwgwi7Jh2vTb
	LyjFOSL6gnq2jY4Li2Ho1L3q4a5ZMp4=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-284-AwrDI4zmN-Khq4Rhg9QKvw-1; Mon, 28 Jul 2025 16:31:52 -0400
X-MC-Unique: AwrDI4zmN-Khq4Rhg9QKvw-1
X-Mimecast-MFC-AGG-ID: AwrDI4zmN-Khq4Rhg9QKvw_1753734710
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-ae708b158f2so436374166b.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Jul 2025 13:31:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753734707; x=1754339507;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z3sjYPp7zGBcepDCn4j2vk3k4XzrI0S0AJoJ8Pw84iw=;
        b=pPPnr0wzP2I1X1n57wfqYcxhVmhK5s4KnUzndjSu3j54hg+5lC2TjLi4AuMff7BUWf
         cDSAgiSMedmndlbJNroEySsXvHGPxpVj1uRsVGxi4Bxg6wT1V9aacFQuAmT/mTw+ItE/
         W77fKsNIiw3a7T79qGpedvWM28dV5j9ZGK3m9WAmTGIHEraaZ3f8D3L4+Tn1uHfCebsv
         E1lTYMTTmEzQ8XmTsjvUx7+K5o22D+4K7kTCoF1ddMeVpVyrA7CWMrQro6kszBANRwH2
         Nnr4501M+2hhuN2r2RLocPijaVq1ukNzp0EQoNNXMPUNu/NKwUzGmKpZvN9VVRajN/Pp
         ajBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtubMybbq+NYqxdusAAUZMD1yAekeCc6YhhrK1hHbXuXZ4pw3VjAFJZZGD1VV/1JRAoRWSsACdrmN3pun+@vger.kernel.org
X-Gm-Message-State: AOJu0YzQSCgZBn1Vs8IqVl5VKZASFLAVJusDhZKKrhjKImxtgvBrgJpi
	AfK2VpsBC4YvGjxlwpDRCSmm83lMryZHIVaWBGSy4JmuchCXP7gHquxSTiFjo8Lp+bUXzl4nrE0
	8hKwPYuM5tLt1si0IjuUwWMrZq6swe3lGJcHXg5oA4i6JacwzF2c8OnqeRxDcYVJnQcUctzHHzb
	0pocSuWntf36k/tPxf2P9Xl9HbebIyRorIVhbYklembDcCdivygQ==
X-Gm-Gg: ASbGncv2qGuz8mei6MmvUdE6s37woMRZo8FhChWt6950vNReZ9MxtXUpGuiqNICeBaU
	UkE3gecMar+v4zlHFcSIsDVO+4/WvQzAfAW8qii+VYiVvkcpfi029nH5QJ6i3IdFeLnTjcooouk
	hh6Fn/nADN7XbIJPnSyloVYD1JLfOa03Pe7uN59c27DY0QCm22dwe16hzLfM7Xw4H87/kJUoc+l
	/E9xqejlfEsaT5b+qpFL+zGExmuyAcpgjXTFtbniVL9BE0ABr/Pk+vbgtgic9EFBgIG2rb/4tWi
	12ebtjG2LjruvHwvZP7haPokFLHZfRvnPE/TpakU36eYcg==
X-Received: by 2002:a17:907:7295:b0:ae3:502f:cdea with SMTP id a640c23a62f3a-af619c0ca43mr1116578666b.60.1753734707233;
        Mon, 28 Jul 2025 13:31:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHu5PQdC6f+qKZkGwqn0CAIZGHLd30eOzDyno2NqYdNQcNDREYynXXb1tKKbC+cBG3JjwEnLw==
X-Received: by 2002:a17:907:7295:b0:ae3:502f:cdea with SMTP id a640c23a62f3a-af619c0ca43mr1116574166b.60.1753734706359;
        Mon, 28 Jul 2025 13:31:46 -0700 (PDT)
Received: from [127.0.0.2] (ip-217-030-074-039.aim-net.cz. [217.30.74.39])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615226558d3sm2730656a12.45.2025.07.28.13.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 13:31:45 -0700 (PDT)
From: Andrey Albershteyn <aalbersh@redhat.com>
X-Google-Original-From: Andrey Albershteyn <aalbersh@kernel.org>
Date: Mon, 28 Jul 2025 22:30:29 +0200
Subject: [PATCH RFC 25/29] xfs: check and repair the verity inode flag
 state
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250728-fsverity-v1-25-9e5443af0e34@kernel.org>
References: <20250728-fsverity-v1-0-9e5443af0e34@kernel.org>
In-Reply-To: <20250728-fsverity-v1-0-9e5443af0e34@kernel.org>
To: fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
 linux-xfs@vger.kernel.org, david@fromorbit.com, djwong@kernel.org, 
 ebiggers@kernel.org, hch@lst.de
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=6831; i=aalbersh@kernel.org;
 h=from:subject:message-id; bh=XdTVDqZuJU1JOSoziNbUXLExJ1Kh7yXvR7qsSHvaQ/4=;
 b=owJ4nJvAy8zAJea2/JXEGuOHHIyn1ZIYMtrvSby/JZdr8id910TZvfdDSnoUDt6rTywquqH77
 4vqT0aOYx4dpSwMYlwMsmKKLOuktaYmFUnlHzGokYeZw8oEMoSBi1MAJiK3lpHhKfPblqsaNttk
 hURaxS7/eP9aLO5W+fVHyxiqi3c6CtQ0M/wVWVdlpN6opnk2/E6joP3OjTMfpvQfTFn89OAJI4V
 5G4N5AdyhSQA=
X-Developer-Key: i=aalbersh@kernel.org; a=openpgp;
 fpr=AE1B2A9562721A6FC4307C1F46A7EA18AC33E108

From: "Darrick J. Wong" <djwong@kernel.org>

If an inode has the incore verity iflag set, make sure that we can
actually activate fsverity on that inode.  If activation fails due to
a fsverity metadata validation error, clear the flag.  The usage model
for fsverity requires that any program that cares about verity state is
required to call statx/getflags to check that the flag is set after
opening the file, so clearing the flag will not compromise that model.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/scrub/attr.c         |  7 +++++
 fs/xfs/scrub/common.c       | 74 +++++++++++++++++++++++++++++++++++++++++++++
 fs/xfs/scrub/common.h       |  3 ++
 fs/xfs/scrub/inode.c        |  7 +++++
 fs/xfs/scrub/inode_repair.c | 36 ++++++++++++++++++++++
 5 files changed, 127 insertions(+)

diff --git a/fs/xfs/scrub/attr.c b/fs/xfs/scrub/attr.c
index 708334f9b2bd..b1448832ae6b 100644
--- a/fs/xfs/scrub/attr.c
+++ b/fs/xfs/scrub/attr.c
@@ -646,6 +646,13 @@ xchk_xattr(
 	if (!xfs_inode_hasattr(sc->ip))
 		return -ENOENT;
 
+	/*
+	 * If this is a verity file that won't activate, we cannot check the
+	 * merkle tree geometry.
+	 */
+	if (xchk_inode_verity_broken(sc->ip))
+		xchk_set_incomplete(sc);
+
 	/* Allocate memory for xattr checking. */
 	error = xchk_setup_xattr_buf(sc, 0);
 	if (error == -ENOMEM)
diff --git a/fs/xfs/scrub/common.c b/fs/xfs/scrub/common.c
index 28ad341df8ee..df031f831bba 100644
--- a/fs/xfs/scrub/common.c
+++ b/fs/xfs/scrub/common.c
@@ -45,6 +45,8 @@
 #include "scrub/health.h"
 #include "scrub/tempfile.h"
 
+#include <linux/fsverity.h>
+
 /* Common code for the metadata scrubbers. */
 
 /*
@@ -1735,3 +1737,75 @@ xchk_inode_count_blocks(
 	return xfs_bmap_count_blocks(sc->tp, sc->ip, whichfork, nextents,
 			count);
 }
+
+/*
+ * If this inode has S_VERITY set on it, read the merkle tree geometry, which
+ * will activate the incore fsverity context for this file.  If the activation
+ * fails with anything other than ENOMEM, the file is corrupt, which we can
+ * detect later with fsverity_active.
+ *
+ * Callers must hold the IOLOCK and must not hold the ILOCK of sc->ip because
+ * activation reads xattrs.  @blocksize and @treesize will be filled out with
+ * merkle tree geometry if they are not NULL pointers.
+ */
+int
+xchk_inode_setup_verity(
+	struct xfs_scrub	*sc,
+	u8			*log_blocksize,
+	unsigned int		*blocksize,
+	u64			*treesize)
+{
+	u8			lbs;
+	unsigned int		bs;
+	u64			ts;
+	int			error;
+
+	if (!IS_VERITY(VFS_I(sc->ip)))
+		return 0;
+
+	error = fsverity_merkle_tree_geometry(VFS_I(sc->ip), &lbs, &bs, &ts);
+	switch (error) {
+	case 0:
+		/* fsverity is active; return tree geometry. */
+		if (log_blocksize)
+			*log_blocksize = lbs;
+		if (blocksize)
+			*blocksize = bs;
+		if (treesize)
+			*treesize = ts;
+		break;
+	case -ENODATA:
+	case -EMSGSIZE:
+	case -EINVAL:
+	case -EFSCORRUPTED:
+	case -EFBIG:
+		/*
+		 * The nonzero errno codes above are the error codes that can
+		 * be returned from fsverity on metadata validation errors.
+		 * Set the geometry to zero.
+		 */
+		if (log_blocksize)
+			*log_blocksize = 0;
+		if (blocksize)
+			*blocksize = 0;
+		if (treesize)
+			*treesize = 0;
+		return 0;
+	default:
+		/* runtime errors */
+		return error;
+	}
+
+	return 0;
+}
+
+/*
+ * Is this a verity file that failed to activate?  Callers must have tried to
+ * activate fsverity via xchk_inode_setup_verity.
+ */
+bool
+xchk_inode_verity_broken(
+	struct xfs_inode	*ip)
+{
+	return IS_VERITY(VFS_I(ip)) && !fsverity_active(VFS_I(ip));
+}
diff --git a/fs/xfs/scrub/common.h b/fs/xfs/scrub/common.h
index 19877d99f255..c6ec7b0cc68a 100644
--- a/fs/xfs/scrub/common.h
+++ b/fs/xfs/scrub/common.h
@@ -289,6 +289,9 @@ int xchk_inode_is_allocated(struct xfs_scrub *sc, xfs_agino_t agino,
 		bool *inuse);
 int xchk_inode_count_blocks(struct xfs_scrub *sc, int whichfork,
 		xfs_extnum_t *nextents, xfs_filblks_t *count);
+int xchk_inode_setup_verity(struct xfs_scrub *sc, u8 *log_blocksize,
+		unsigned int *blocksize, u64 *treesize);
+bool xchk_inode_verity_broken(struct xfs_inode *ip);
 
 bool xchk_inode_is_dirtree_root(const struct xfs_inode *ip);
 bool xchk_inode_is_sb_rooted(const struct xfs_inode *ip);
diff --git a/fs/xfs/scrub/inode.c b/fs/xfs/scrub/inode.c
index bb3f475b6353..f173d1fea6bd 100644
--- a/fs/xfs/scrub/inode.c
+++ b/fs/xfs/scrub/inode.c
@@ -36,6 +36,10 @@ xchk_prepare_iscrub(
 
 	xchk_ilock(sc, XFS_IOLOCK_EXCL);
 
+	error = xchk_inode_setup_verity(sc, NULL, NULL, NULL);
+	if (error)
+		return error;
+
 	error = xchk_trans_alloc(sc, 0);
 	if (error)
 		return error;
@@ -833,6 +837,9 @@ xchk_inode(
 	if (S_ISREG(VFS_I(sc->ip)->i_mode))
 		xchk_inode_check_reflink_iflag(sc, sc->ip->i_ino);
 
+	if (xchk_inode_verity_broken(sc->ip))
+		xchk_ino_set_corrupt(sc, sc->sm->sm_ino);
+
 	xchk_inode_check_unlinked(sc);
 
 	xchk_inode_xref(sc, sc->ip->i_ino, &di);
diff --git a/fs/xfs/scrub/inode_repair.c b/fs/xfs/scrub/inode_repair.c
index a90a011c7e5f..e5dd39759f7a 100644
--- a/fs/xfs/scrub/inode_repair.c
+++ b/fs/xfs/scrub/inode_repair.c
@@ -573,6 +573,8 @@ xrep_dinode_flags(
 		dip->di_nrext64_pad = 0;
 	else if (dip->di_version >= 3)
 		dip->di_v3_pad = 0;
+	if (!xfs_has_verity(mp) || !S_ISREG(mode))
+		flags2 &= ~XFS_DIFLAG2_VERITY;
 
 	if (flags2 & XFS_DIFLAG2_METADATA) {
 		xfs_failaddr_t	fa;
@@ -1613,6 +1615,10 @@ xrep_dinode_core(
 	if (iget_error)
 		return iget_error;
 
+	error = xchk_inode_setup_verity(sc, NULL, NULL, NULL);
+	if (error)
+		return error;
+
 	error = xchk_trans_alloc(sc, 0);
 	if (error)
 		return error;
@@ -2032,6 +2038,27 @@ xrep_inode_unlinked(
 	return 0;
 }
 
+/*
+ * If this file is a fsverity file, xchk_prepare_iscrub or xrep_dinode_core
+ * should have activated it.  If it's still not active, then there's something
+ * wrong with the verity descriptor and we should turn it off.
+ */
+STATIC int
+xrep_inode_verity(
+	struct xfs_scrub	*sc)
+{
+	struct inode		*inode = VFS_I(sc->ip);
+
+	if (xchk_inode_verity_broken(sc->ip)) {
+		sc->ip->i_diflags2 &= ~XFS_DIFLAG2_VERITY;
+		inode->i_flags &= ~S_VERITY;
+
+		xfs_trans_log_inode(sc->tp, sc->ip, XFS_ILOG_CORE);
+	}
+
+	return 0;
+}
+
 /* Repair an inode's fields. */
 int
 xrep_inode(
@@ -2081,6 +2108,15 @@ xrep_inode(
 			return error;
 	}
 
+	/*
+	 * Disable fsverity if it cannot be activated.  Activation failure
+	 * prohibits the file from being opened, so there cannot be another
+	 * program with an open fd to what it thinks is a verity file.
+	 */
+	error = xrep_inode_verity(sc);
+	if (error)
+		return error;
+
 	/* Reconnect incore unlinked list */
 	error = xrep_inode_unlinked(sc);
 	if (error)

-- 
2.50.0


