Return-Path: <linux-fsdevel+bounces-11162-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E6B851A84
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 18:02:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BA8F1C21D93
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 17:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F2841233;
	Mon, 12 Feb 2024 17:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U38CzaPy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9900B3DB91
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Feb 2024 17:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707757226; cv=none; b=jo2deFrtx6bDDfKVVp8Fndrvh8MgrhFszRAD0nRKRZUUdfWzgNbS20lL9jr3taeuhVVaux/u8bOfVkmCa7rb+MyXCe5o0kzIOmNX35vX19LTfdIJENlTXGqQz8Qo44yvmy03TFKQkf06Pxq4HQWuFZhDH30mzb2xuqPurNwbxM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707757226; c=relaxed/simple;
	bh=L31YpI5cHGwgxPGXiju5BCSchrSCFM+W/kdnKuUSicg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rBgtau5mipipYk7gojz7yAL0Q9EPVdfWIDfiCJCJMS2Yq2yRtXOZSMzhW6sCRPeHvwGCpmeKIkrvf79ZjiNZ6hMQJlev8CIn2oEWwasrMScsXxdNre/CRHfYjGPeOVeG3CKD7yKM3ks4mWFYmIj1epsW7Ns9Uo00QsHL95213Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U38CzaPy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707757222;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v8DMtYJWCVCHSCEWBZfbGi3INfqAeJCCNzs6AgTs1hw=;
	b=U38CzaPyeDIwJtItbOyawBJRVkORuEAeEWBtLpGOBQNRnqHv49RdXCHOMkgOtr2wvnOzUK
	a9Mz6LNHWHoU/TrmmbrFuckqumkCL2/VQlm5JULg2BQ6O82replHvU1VTLJCniu6rrSVfG
	SvAk6WKlInVgEJxQJ+TY9WxzrIJ+4kU=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-103-oSHmDZ3wOcC4lsSPMTBwvQ-1; Mon, 12 Feb 2024 12:00:21 -0500
X-MC-Unique: oSHmDZ3wOcC4lsSPMTBwvQ-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5601e5ed21aso13091a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Feb 2024 09:00:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707757220; x=1708362020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v8DMtYJWCVCHSCEWBZfbGi3INfqAeJCCNzs6AgTs1hw=;
        b=Gox/FxQx9dZFsciRrkPCnthIb9pXgX+toXrj6GKRemnRvpSQt+LtNYNEV+K54XWSZW
         0KCVTzxwmmTYCPLQPVBT7E1/cGUP2ZCaMQF/UijlTCYZ2y+5JvuUrsG8Q+GeJjVozN3T
         L6kMK3VuSxNgRsB5at3kHRDaLKQ8Ace6WnB2Yw+ea+CMhT9UEXIMcL4tmh5X363/GAGr
         SSx/4Ye6X7czQzeIAXWqDNwdXejo7BlRqplw4WXB2ygfYrSGdolGlxTJNd0zkrAmazxO
         SKv/bL5Qscan3IVrBN9Rg+wSzNssu6a7zIHw770CqmBT+dT2MnxdId2RfHWMy8++tfMG
         OE/A==
X-Gm-Message-State: AOJu0YyT4+oQ8NOITsGJt2y1FgMfRyrOIUpveqaBaM7Cap+T7+/Jxzx6
	6iqDhLn24po2/sZyNEVPOwbZrTxwfZj0hkkR3fCwifAiQKnuHzd2vjmyTEgGK4Q+sVrkO4jwVKh
	zhueAUjDHef55DARVJROBW7zx3vCg1U8nhLu2MxJPSBjgn+UWagqtgkVJeOSFGy1wr7v7NA==
X-Received: by 2002:aa7:c71a:0:b0:560:4e6:c442 with SMTP id i26-20020aa7c71a000000b0056004e6c442mr4968907edq.1.1707757219861;
        Mon, 12 Feb 2024 09:00:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHdqLzEkltOhv90/mdAnBYzqC7IUdmnma0K+szge3JGNVz0tYyEgI2sp8chHtI9P5lmUmCjVA==
X-Received: by 2002:aa7:c71a:0:b0:560:4e6:c442 with SMTP id i26-20020aa7c71a000000b0056004e6c442mr4968893edq.1.1707757219573;
        Mon, 12 Feb 2024 09:00:19 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV3N3pdtpy2jDzzn9qjG81jBQ/X5sQeRIfOLG26RPUaUSSngS8BpTycQ3WIoFOMcO1xf9fGHYsQ94U8TsvWWVkCU0bbz6k8resLyTmPIDI5OyfbJpA2iDbStA3VZbVuuwCWj0Pl2k/t2JENFurvj357mNiz0AQE7dVAMsSi0pfW6BEUDkievBaQHTIkytdug4eYIOID5DxYHpZ/cNdPZgzsTnz9sQ8Gv1PX
Received: from thinky.redhat.com ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id 14-20020a0564021f4e00b0056176e95a88sm2620261edz.32.2024.02.12.09.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 09:00:18 -0800 (PST)
From: Andrey Albershteyn <aalbersh@redhat.com>
To: fsverity@lists.linux.dev,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	chandan.babu@oracle.com,
	djwong@kernel.org,
	ebiggers@kernel.org
Cc: Andrey Albershteyn <aalbersh@redhat.com>
Subject: [PATCH v4 21/25] xfs: disable direct read path for fs-verity files
Date: Mon, 12 Feb 2024 17:58:18 +0100
Message-Id: <20240212165821.1901300-22-aalbersh@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240212165821.1901300-1-aalbersh@redhat.com>
References: <20240212165821.1901300-1-aalbersh@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The direct path is not supported on verity files. Attempts to use direct
I/O path on such files should fall back to buffered I/O path.

Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
---
 fs/xfs/xfs_file.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index ed36cd088926..011c311efe22 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -281,7 +281,8 @@ xfs_file_dax_read(
 	struct kiocb		*iocb,
 	struct iov_iter		*to)
 {
-	struct xfs_inode	*ip = XFS_I(iocb->ki_filp->f_mapping->host);
+	struct inode		*inode = iocb->ki_filp->f_mapping->host;
+	struct xfs_inode	*ip = XFS_I(inode);
 	ssize_t			ret = 0;
 
 	trace_xfs_file_dax_read(iocb, to);
@@ -334,10 +335,18 @@ xfs_file_read_iter(
 
 	if (IS_DAX(inode))
 		ret = xfs_file_dax_read(iocb, to);
-	else if (iocb->ki_flags & IOCB_DIRECT)
+	else if (iocb->ki_flags & IOCB_DIRECT && !fsverity_active(inode))
 		ret = xfs_file_dio_read(iocb, to);
-	else
+	else {
+		/*
+		 * In case fs-verity is enabled, we also fallback to the
+		 * buffered read from the direct read path. Therefore,
+		 * IOCB_DIRECT is set and need to be cleared (see
+		 * generic_file_read_iter())
+		 */
+		iocb->ki_flags &= ~IOCB_DIRECT;
 		ret = xfs_file_buffered_read(iocb, to);
+	}
 
 	if (ret > 0)
 		XFS_STATS_ADD(mp, xs_read_bytes, ret);
-- 
2.42.0


