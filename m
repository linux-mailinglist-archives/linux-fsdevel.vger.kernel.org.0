Return-Path: <linux-fsdevel+bounces-13524-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 333C3870A3E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 20:13:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86572B23940
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 19:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4587A156;
	Mon,  4 Mar 2024 19:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f91mTuqr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A770078B70
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Mar 2024 19:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709579540; cv=none; b=EcfzIePWBaLLq31jv4Pwg5kOcTcWiBM8raeJpjPHoeNokzG2HfaDbIXUC31Cvw6Hs9KFKSVPasiIY9xc8PnVDkTpq4CVgzcweGDkg0eidy7VNBxd3Zi383Nzyd6nAFsyMI7vWOis4RIGf0S5/Q4pHbwa+2uJbgMHvwH+7lpzZYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709579540; c=relaxed/simple;
	bh=Vy6aKow/W1afzQTgEIlDGAfiO3Pdvi5QJY/f+z2nhzM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zj4CBqU7KqiqWA6tNWAbUVncQ33ws80pFlddKK/VzL9i9O/xWt0nLiRyLzNJyBerk5seH+mcx13KF9i7tqGkOnMFjn+xI5Pu2h8d8/TPmghp5sa5BQEcUlCgSzyuP4xvEGDqDfLZvHtVsdApw1mvSQ0JktQneLvZYqTI3my0dp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f91mTuqr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709579535;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nqqw4mVotq0OBveNn7Z3piHTecgeWnPUkNTctKlIj/8=;
	b=f91mTuqrLsN/4WQe0mHJ7/Yy0K0tOWEZctFBiKMIen0XnmuwFR8Z7RveBf6dLu03awt1up
	4ntTEcHy1xYP4gVZGYHOYj8N1vcZeYqpIAcWyqq0GS8lWWteT/ShB74rT3/b07zd5/rnJ7
	/lDg/6ChkbjS7JKRJris1lUE9Pb4jz8=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-301-v59M_Lv8MOaLqSz7_r--6w-1; Mon, 04 Mar 2024 14:12:14 -0500
X-MC-Unique: v59M_Lv8MOaLqSz7_r--6w-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a45095f33fdso185600166b.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 Mar 2024 11:12:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709579533; x=1710184333;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nqqw4mVotq0OBveNn7Z3piHTecgeWnPUkNTctKlIj/8=;
        b=HcIREBYjMR4ZezTMv+ZXYKktFbzotLyXByfF9w1IJV2YLiASRnSBFzBvaqtm556abj
         0AsNfipOSZwFXm5niUSWCTT+kSbkSssDQylpgPXnZ1VVy/9QM5Qh7sBn6AhGESDPBDnF
         ecy14WvsKBUEQoESJWE5wtLzPJ7DdHCov9EncnR3gKKkDmYGw/wxLC2yIpMUM0hPTcrh
         hJf5Ui1kHYKXNLIi1yYRnHABGFbOg3BJqACI1zM72hUU8UZwpvneWOTw7FwZlyv6LTZ1
         C1eNDozJ+1uL2viSA0VbR/URWGLnAr77VD42IbpkRMxum8Omx4qoJAIhMiY85t9lpmlm
         ZC/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXzyuI7WN2/rRwetMky7pToB7Xffc0AktBDMDajKW08XDOuUnoLDHtn4+OvIcq2yolPkIws+RFqgH3+Npa5Vg+6JbwpggX4Xy0MMC1x8w==
X-Gm-Message-State: AOJu0YzvYZSZ80KXKOiYOBCdFNhgVFgsaZXEINtlROJGfjC6koXzxuZy
	0/bnLpOYQb2SbAj3uPHP+CsbvLfq4I6GAcfZzaLikKBa9SHzrk/gxctETpjEZxXRYNGE4S2/ztL
	fEl1tucRkxLSd8AlnPYr2vUeI82TFpy5pAC4f0HiMmJ8ECXngol+z+YFGjhsSXQ==
X-Received: by 2002:a17:906:7208:b0:a44:9483:33c1 with SMTP id m8-20020a170906720800b00a44948333c1mr454998ejk.20.1709579532847;
        Mon, 04 Mar 2024 11:12:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHriVFD5H05LTiKf6J8/M+ZPcD1k3KsigVNhXSp46qw4DNjzzgpyPjO7C93xuGAbGnaCVQYNQ==
X-Received: by 2002:a17:906:7208:b0:a44:9483:33c1 with SMTP id m8-20020a170906720800b00a44948333c1mr454957ejk.20.1709579532348;
        Mon, 04 Mar 2024 11:12:12 -0800 (PST)
Received: from thinky.redhat.com ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id a11-20020a1709064a4b00b00a44a04aa3cfsm3783319ejv.225.2024.03.04.11.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 11:12:11 -0800 (PST)
From: Andrey Albershteyn <aalbersh@redhat.com>
To: fsverity@lists.linux.dev,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	chandan.babu@oracle.com,
	djwong@kernel.org,
	ebiggers@kernel.org
Cc: Allison Henderson <allison.henderson@oracle.com>,
	Mark Tinguely <tinguely@sgi.com>,
	Dave Chinner <dchinner@redhat.com>
Subject: [PATCH v5 02/24] xfs: add parent pointer support to attribute code
Date: Mon,  4 Mar 2024 20:10:25 +0100
Message-ID: <20240304191046.157464-4-aalbersh@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240304191046.157464-2-aalbersh@redhat.com>
References: <20240304191046.157464-2-aalbersh@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Allison Henderson <allison.henderson@oracle.com>

Add the new parent attribute type. XFS_ATTR_PARENT is used only for parent pointer
entries; it uses reserved blocks like XFS_ATTR_ROOT.

Signed-off-by: Mark Tinguely <tinguely@sgi.com>
Signed-off-by: Dave Chinner <dchinner@redhat.com>
Signed-off-by: Allison Henderson <allison.henderson@oracle.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/libxfs/xfs_attr.c       | 3 ++-
 fs/xfs/libxfs/xfs_da_format.h  | 5 ++++-
 fs/xfs/libxfs/xfs_log_format.h | 1 +
 fs/xfs/scrub/attr.c            | 2 +-
 fs/xfs/xfs_trace.h             | 3 ++-
 5 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_attr.c b/fs/xfs/libxfs/xfs_attr.c
index 673a4b6d2e8d..ff67a684a452 100644
--- a/fs/xfs/libxfs/xfs_attr.c
+++ b/fs/xfs/libxfs/xfs_attr.c
@@ -925,7 +925,8 @@ xfs_attr_set(
 	struct xfs_inode	*dp = args->dp;
 	struct xfs_mount	*mp = dp->i_mount;
 	struct xfs_trans_res	tres;
-	bool			rsvd = (args->attr_filter & XFS_ATTR_ROOT);
+	bool			rsvd = (args->attr_filter & (XFS_ATTR_ROOT |
+							     XFS_ATTR_PARENT));
 	int			error, local;
 	int			rmt_blks = 0;
 	unsigned int		total;
diff --git a/fs/xfs/libxfs/xfs_da_format.h b/fs/xfs/libxfs/xfs_da_format.h
index 060e5c96b70f..5434d4d5b551 100644
--- a/fs/xfs/libxfs/xfs_da_format.h
+++ b/fs/xfs/libxfs/xfs_da_format.h
@@ -714,12 +714,15 @@ struct xfs_attr3_leafblock {
 #define	XFS_ATTR_LOCAL_BIT	0	/* attr is stored locally */
 #define	XFS_ATTR_ROOT_BIT	1	/* limit access to trusted attrs */
 #define	XFS_ATTR_SECURE_BIT	2	/* limit access to secure attrs */
+#define	XFS_ATTR_PARENT_BIT	3	/* parent pointer attrs */
 #define	XFS_ATTR_INCOMPLETE_BIT	7	/* attr in middle of create/delete */
 #define XFS_ATTR_LOCAL		(1u << XFS_ATTR_LOCAL_BIT)
 #define XFS_ATTR_ROOT		(1u << XFS_ATTR_ROOT_BIT)
 #define XFS_ATTR_SECURE		(1u << XFS_ATTR_SECURE_BIT)
+#define XFS_ATTR_PARENT		(1u << XFS_ATTR_PARENT_BIT)
 #define XFS_ATTR_INCOMPLETE	(1u << XFS_ATTR_INCOMPLETE_BIT)
-#define XFS_ATTR_NSP_ONDISK_MASK	(XFS_ATTR_ROOT | XFS_ATTR_SECURE)
+#define XFS_ATTR_NSP_ONDISK_MASK \
+			(XFS_ATTR_ROOT | XFS_ATTR_SECURE | XFS_ATTR_PARENT)
 
 /*
  * Alignment for namelist and valuelist entries (since they are mixed
diff --git a/fs/xfs/libxfs/xfs_log_format.h b/fs/xfs/libxfs/xfs_log_format.h
index 16872972e1e9..9cbcba4bd363 100644
--- a/fs/xfs/libxfs/xfs_log_format.h
+++ b/fs/xfs/libxfs/xfs_log_format.h
@@ -974,6 +974,7 @@ struct xfs_icreate_log {
  */
 #define XFS_ATTRI_FILTER_MASK		(XFS_ATTR_ROOT | \
 					 XFS_ATTR_SECURE | \
+					 XFS_ATTR_PARENT | \
 					 XFS_ATTR_INCOMPLETE)
 
 /*
diff --git a/fs/xfs/scrub/attr.c b/fs/xfs/scrub/attr.c
index 83c7feb38714..49f91cc85a65 100644
--- a/fs/xfs/scrub/attr.c
+++ b/fs/xfs/scrub/attr.c
@@ -494,7 +494,7 @@ xchk_xattr_rec(
 	/* Retrieve the entry and check it. */
 	hash = be32_to_cpu(ent->hashval);
 	badflags = ~(XFS_ATTR_LOCAL | XFS_ATTR_ROOT | XFS_ATTR_SECURE |
-			XFS_ATTR_INCOMPLETE);
+			XFS_ATTR_INCOMPLETE | XFS_ATTR_PARENT);
 	if ((ent->flags & badflags) != 0)
 		xchk_da_set_corrupt(ds, level);
 	if (ent->flags & XFS_ATTR_LOCAL) {
diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
index 56b07d8ed431..d4f1b2da21e7 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -86,7 +86,8 @@ struct xfs_bmap_intent;
 #define XFS_ATTR_FILTER_FLAGS \
 	{ XFS_ATTR_ROOT,	"ROOT" }, \
 	{ XFS_ATTR_SECURE,	"SECURE" }, \
-	{ XFS_ATTR_INCOMPLETE,	"INCOMPLETE" }
+	{ XFS_ATTR_INCOMPLETE,	"INCOMPLETE" }, \
+	{ XFS_ATTR_PARENT,	"PARENT" }
 
 DECLARE_EVENT_CLASS(xfs_attr_list_class,
 	TP_PROTO(struct xfs_attr_list_context *ctx),
-- 
2.42.0


