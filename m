Return-Path: <linux-fsdevel+bounces-56176-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D76BB14325
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 22:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5BF41634A0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 20:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D772281526;
	Mon, 28 Jul 2025 20:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NjbbL8Mg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232E01C8631
	for <linux-fsdevel@vger.kernel.org>; Mon, 28 Jul 2025 20:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753734703; cv=none; b=NwyCWJmQ/yYnpCfm9xxiso13SW72fRyTmieizjj3FutkAtFG5rUnVLlOHHhaxtP1tLuwBntDeMJ9A8GaehHM+Sf6Lf77U7jBbAPeSQk3Weiki5QxW4lOJsN8fg8WdLxsFruc20JjPrSswrFT7ywcHdBukLCjjSdKuTfdLeablQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753734703; c=relaxed/simple;
	bh=FmQY0utR3EJKnbdnl2kWXdJsHs06S3lSSo5C32WL97Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=Ov6hQqwLMa2i2mYP2axFKfKY78LhV9bUXeonxa3WMSkNjhdyyacrG47Av3jozPtJ701LtWV0FnHeByEpo/srxBuS+Jh/EFEixTZ5FJcWrbS0Wqt2y18+YylIECsZayVQ+SmBvHw6GhO8DHmJo7yFB6Z5AB0ElnVBa/syLGx8Ey4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NjbbL8Mg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753734701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nJrJhTiKWZWizCb5vgJDR1e4Y3d90lblUc5COXR2wnU=;
	b=NjbbL8MgBD829HBlI1Z7CbdVLGVxfk47+O22aoHmy/thBhwSTYoUv5i45Vcd30KRmOHA7P
	DtfAuiCqa51sxCVxJ/86Vvn6HKCjbVm49uXXLqibBRck+OgITGa+VHPHmKoUPT71UUyLMf
	s6gO7iGxll6sWq8yfBzbEzAssYj+I+I=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-zLtMeIUTMZ-89HSDtxauww-1; Mon, 28 Jul 2025 16:31:34 -0400
X-MC-Unique: zLtMeIUTMZ-89HSDtxauww-1
X-Mimecast-MFC-AGG-ID: zLtMeIUTMZ-89HSDtxauww_1753734694
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-60c776678edso271270a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Jul 2025 13:31:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753734693; x=1754339493;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nJrJhTiKWZWizCb5vgJDR1e4Y3d90lblUc5COXR2wnU=;
        b=hE/h0xvyEnANokzmjScX8WhoK/Y1FVqZngXCCtlCbgu/WcViFsIgy3GfPHYacXq1en
         +G+YHsRCi4nrNWsZyh+WGyASXo3usHdZLeWDaH90DAZxEMo+eqU5VzWusu9zgIUjNbH0
         +TRlOmuJYyy1YuZzmMTfhIO1lJZzxtOgG5OgbSV0u2201H3I6h81savf1EzYled91QqA
         Z8iZKMstSIveqaxKLBY1SMzEqOm0jB/wjFjRLy4XT0UCpv/ByPqQqr3yF3ASU1l7pxr1
         QZj8P8sUW2lfH2oi0sxgqZ+zJr+BpnZG4cuA9HIRC2YFk/VAkSHjBTT5uLHdY73V8Ch3
         SmDA==
X-Forwarded-Encrypted: i=1; AJvYcCUFGDy4+6m9dRYkwONX1eSkSuw2725Sz4BqEIXiJ8XlRnA2vsUnZlE/ewESXaOF1vNIZG/yrqj8oOC20+1H@vger.kernel.org
X-Gm-Message-State: AOJu0YxPFuCtX+gmIyUw5VISw4w0CI71HBmLwuWzoC0OPIK+c+bUmkrY
	9dTvSY0YPkCx9oXNsRy6pHW+G1pfarQ5MGgHxAY5sjhQts4G/sBUpknRJgv7M9BpH+EJf/8h37f
	7ODF2ZWpMXDkHL4m/RFw7agraj+nZUSyZtyEz8Ym/uOw2Cw+SiAu/d+MnfsQfNDszc+pGrAmglx
	MYdPz+cQkWKWMgrSk1R6bjm/PRzHDlQ8Fd7lALpG6EY/dAc3iGMA==
X-Gm-Gg: ASbGncsWMnDXG5J4gzY6u3jPcEPySlSm7Mfd0V0sjuEIfPgD6fOP08DDYgvoFGE6xWc
	+XCDX6MRtJO3EqNJ9tWlqPOD9Zs49VNRIvDJNcQYPQ2k6DhqWXop4wudpQhuPUIO8DxzoDlGb+Z
	NAgCFqw/pDCFr5YCFlCK5+GfnOaYu1EsokZ4RL6KUGNKhLlLYhae9/WVYkw/7fwV7fN++Kcav+h
	UhYeAukPD5uRlh2n747UiY/Pyq9eBJZd9MDtc6x6vJ79bz6vy5/7DSTbfxqZ6obfzfVSBMW9s9T
	/UCM3MMjtI2uCR/omFFS/ivjo7CGgR9IQfd5AM+mAHYccw==
X-Received: by 2002:a05:6402:26d2:b0:607:35d:9fb4 with SMTP id 4fb4d7f45d1cf-61564414146mr767660a12.15.1753734693265;
        Mon, 28 Jul 2025 13:31:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEA5UBDZv2tek/WX1R6Rvm8MNzw4SMmyDGLfo9kmuBsv5oxLO/xwY0iTeJo5s1xCMBhuaSJhg==
X-Received: by 2002:a05:6402:26d2:b0:607:35d:9fb4 with SMTP id 4fb4d7f45d1cf-61564414146mr767638a12.15.1753734692828;
        Mon, 28 Jul 2025 13:31:32 -0700 (PDT)
Received: from [127.0.0.2] (ip-217-030-074-039.aim-net.cz. [217.30.74.39])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615226558d3sm2730656a12.45.2025.07.28.13.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 13:31:31 -0700 (PDT)
From: Andrey Albershteyn <aalbersh@redhat.com>
X-Google-Original-From: Andrey Albershteyn <aalbersh@kernel.org>
Date: Mon, 28 Jul 2025 22:30:16 +0200
Subject: [PATCH RFC 12/29] fsverity: expose merkle tree geometry to callers
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250728-fsverity-v1-12-9e5443af0e34@kernel.org>
References: <20250728-fsverity-v1-0-9e5443af0e34@kernel.org>
In-Reply-To: <20250728-fsverity-v1-0-9e5443af0e34@kernel.org>
To: fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
 linux-xfs@vger.kernel.org, david@fromorbit.com, djwong@kernel.org, 
 ebiggers@kernel.org, hch@lst.de
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2959; i=aalbersh@kernel.org;
 h=from:subject:message-id; bh=hpvpUPXPy1PD+AbFvGEt6YZjB0rOC9HnWhC0HEKd4jM=;
 b=owJ4nJvAy8zAJea2/JXEGuOHHIyn1ZIYMtrvSeh1ljJs/hUucvPQjYw7y/pYvD9w7BOeNivVZ
 W1r1cRtoUs7SlkYxLgYZMUUWdZJa01NKpLKP2JQIw8zh5UJZAgDF6cATGT1CkaGWffPnqz4d8dV
 vzNez2FCk5DZrOt6922Dg3I6piqL/onkYvhfF7HsvMK6c2w3+ENMc8pjl1TlKaw89TilxlL+d1G
 wEhsjAHAWRkA=
X-Developer-Key: i=aalbersh@kernel.org; a=openpgp;
 fpr=AE1B2A9562721A6FC4307C1F46A7EA18AC33E108

From: "Darrick J. Wong" <djwong@kernel.org>

Create a function that will return selected information about the
geometry of the merkle tree.  Online fsck for XFS will need this piece
to perform basic checks of the merkle tree.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/verity/open.c         | 37 +++++++++++++++++++++++++++++++++++++
 include/linux/fsverity.h | 11 +++++++++++
 2 files changed, 48 insertions(+)

diff --git a/fs/verity/open.c b/fs/verity/open.c
index fdeb95eca3af..de1d0bd6e703 100644
--- a/fs/verity/open.c
+++ b/fs/verity/open.c
@@ -407,6 +407,43 @@ void __fsverity_cleanup_inode(struct inode *inode)
 }
 EXPORT_SYMBOL_GPL(__fsverity_cleanup_inode);
 
+/**
+ * fsverity_merkle_tree_geometry() - return Merkle tree geometry
+ * @inode: the inode to query
+ * @block_size: will be set to the log2 of the size of a merkle tree block
+ * @block_size: will be set to the size of a merkle tree block, in bytes
+ * @tree_size: will be set to the size of the merkle tree, in bytes
+ *
+ * Callers are not required to have opened the file.
+ *
+ * Return: 0 for success, -ENODATA if verity is not enabled, or any of the
+ * error codes that can result from loading verity information while opening a
+ * file.
+ */
+int fsverity_merkle_tree_geometry(struct inode *inode, u8 *log_blocksize,
+				  unsigned int *block_size, u64 *tree_size)
+{
+	struct fsverity_info *vi;
+	int error;
+
+	if (!IS_VERITY(inode))
+		return -ENODATA;
+
+	error = ensure_verity_info(inode);
+	if (error)
+		return error;
+
+	vi = inode->i_verity_info;
+	if (log_blocksize)
+		*log_blocksize = vi->tree_params.log_blocksize;
+	if (block_size)
+		*block_size = vi->tree_params.block_size;
+	if (tree_size)
+		*tree_size = vi->tree_params.tree_size;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(fsverity_merkle_tree_geometry);
+
 void __init fsverity_init_info_cache(void)
 {
 	fsverity_info_cachep = KMEM_CACHE_USERCOPY(
diff --git a/include/linux/fsverity.h b/include/linux/fsverity.h
index 8155407a7e4c..f10e9493ffa7 100644
--- a/include/linux/fsverity.h
+++ b/include/linux/fsverity.h
@@ -166,6 +166,9 @@ int __fsverity_file_open(struct inode *inode, struct file *filp);
 int __fsverity_prepare_setattr(struct dentry *dentry, struct iattr *attr);
 void __fsverity_cleanup_inode(struct inode *inode);
 
+int fsverity_merkle_tree_geometry(struct inode *inode, u8 *log_blocksize,
+				  unsigned int *block_size, u64 *tree_size);
+
 /**
  * fsverity_cleanup_inode() - free the inode's verity info, if present
  * @inode: an inode being evicted
@@ -250,6 +253,14 @@ static inline void fsverity_cleanup_inode(struct inode *inode)
 {
 }
 
+static inline int fsverity_merkle_tree_geometry(struct inode *inode,
+						u8 *log_blocksize,
+						unsigned int *block_size,
+						u64 *tree_size)
+{
+	return -EOPNOTSUPP;
+}
+
 /* read_metadata.c */
 
 static inline int fsverity_ioctl_read_metadata(struct file *filp,

-- 
2.50.0


