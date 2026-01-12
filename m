Return-Path: <linux-fsdevel+bounces-73262-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AC192D13840
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 16:13:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CAC703077609
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 14:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BEFA2D5C8E;
	Mon, 12 Jan 2026 14:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C/m9W5pE";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="b4v30Tzm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CED71E4AF
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jan 2026 14:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768229540; cv=none; b=b+rmvCCBBqYIcDcUSMa6sAZG8/AjnXGokCMfLtmUqjCGvptAr2vMZF/yUe7fQ3RIzXBzKZb5TWKwJX48AEM+qg6D+XMqYCbDXhBChzsmGDYgYBEOKjpuK8BzNG8LtyjbWgwcp9BCH1jXq+Cey7JdDnLe/vfJMvosokSvk7ER5NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768229540; c=relaxed/simple;
	bh=DqGbPHihgvouI+HlmdtnScxnStrH4+HE2WznQSyP4j4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FCWrak91gNiSCck62EolbgYGK+K7SpDWDt8wP9WnLijo3kgjwXgkL0epErsc1X+wOLac6Q/bS+StIe3vOx6UIuok1WiIAGVfJZh8aas0KYuWVA1BWgFhQ7gfj3qQceeNKVzjQg8n8RiZzPDoX/uVkE1gX5zlpRWvNgr8Q67gcss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C/m9W5pE; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=b4v30Tzm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768229538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xPYPAB6be13BNA+rNTQIlJZgdC6UYp82gudM/SKVgcg=;
	b=C/m9W5pEEnnH0L32ifitZAlVJ8nI0B4CMsgkfNnbQTM6jp6wbyP6gi7WTvOxBWxTcrRmJG
	Q6oVpLtdJG+OCYMfW1vVpo9vuqaoK+OwayFHdny+6M4ur5isXD5TM5Uynl2kWSodOUOHSH
	5ZFvRCPqQg/ReEdwqU3G2Ko+jWPXsiA=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-_EO7_JCeMZGXYkWve66mBQ-1; Mon, 12 Jan 2026 09:52:17 -0500
X-MC-Unique: _EO7_JCeMZGXYkWve66mBQ-1
X-Mimecast-MFC-AGG-ID: _EO7_JCeMZGXYkWve66mBQ_1768229536
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b7a29e6f9a0so646377766b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jan 2026 06:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768229536; x=1768834336; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xPYPAB6be13BNA+rNTQIlJZgdC6UYp82gudM/SKVgcg=;
        b=b4v30TzmZAiJn9WiNu5L73uSDOfZ8yG/XQDvq4YGLnx58I2mO9hW4/h0lyYlpAa6WV
         PtEtHKpmF9nKzCOGvUjunvMp0dsTUhOppjIwAqf6GwyTbg5MhKpeYrLjT/XyeuWNKOSg
         ybexhQQ3A3V1xsDi6QR0LaS3gZpE9qMwBNfj1tBHYg1CSQYbf60oYW5HPw6XmsygnFU1
         sgpXaait7Xy+s+b52HCSX8NOq8GHYoUEBQsj1KsDbdeqHqL0AdkJGIPenH3/gQX1rtLR
         lxlaw6/Bc86cihJPxWwzDTlBrGHpD0ujVejNiU7GQb8ZV5U0Uqm2UIqxOBe54FAW0N5a
         7N2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768229536; x=1768834336;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xPYPAB6be13BNA+rNTQIlJZgdC6UYp82gudM/SKVgcg=;
        b=FbR1cO63T0MVearf0OozCPSKxT95rQytXgLUD4o8z2943FH7/bZKw5fG6mZTiQ70qk
         4Vs44YZVFc2CVulQGhsKkYUsfwSFMv+Zl4s7Y17eZqfYE48Z39WFld2gJD83JceIXBAL
         zVRxIDm5/nJqRhEFzGyAFkLP9k1vEPNMCgZ+8NSwxmVsBee2loQE8uiej/T06UEbV7Hw
         2Bvj4b6bFP6ZSMcbxX2H3XGROGbcgORuJJ2mbaidr8aRImSjfxzMTd9xHjNtt15j/G+d
         mUrvQI7rNwSlSetWULsJMbwlDN3EEpULu998XfWTPy1xtY4OWrkZ1zyvsu8J5clDMZ/P
         ka2w==
X-Forwarded-Encrypted: i=1; AJvYcCWuTsg2HlOaQ8y3ZQZgFaL27s4qAkWo17ey5YKv6R55vM/Bs/IMfQL3/GrBW/cjt8m2jL3bvok7w+QkHTGu@vger.kernel.org
X-Gm-Message-State: AOJu0YwQYDjY3Sap8V8Uu2HPbIFg+XJIyNzdw6PQs3dkI59/LH+uGpmV
	fi/wdOjyje42hoXJDtQ5i5n8xtj3QMEtf+wNGyQi4onLVZuagM7ZGDeNxVJ/XDDchflSH4m6/9A
	bEjRd6cBA3/gMUV3XnIwecLRQuh5frlrblEFLCG7bWMTVKv7VDb41O+UllSooDxq3Gw==
X-Gm-Gg: AY/fxX5vZzlvT3Is/LBjqehVPPmAStRBP6dx9aEkAkp0Po0Hvi4fO4vfDlhbIQuMLK5
	UCjp/W/cpdLa3kniCy9LCx7v007C4QPyNVP8+QK4dpkh4OR4O2KGwSLLWQGVfT7Ze8sCFkx84Jb
	u00AptQSWcJ3QIxdjvno203yuYeizHE/Scvkg9OLD0zJN5S7DyhTPcBCmdCf6qhW7BlAbRTP9No
	s8EhJEqPdYrSOSI7YkQVM595ggNIsBB3BJ+SO70Zfy+XA96BUhxBNAvn2Z7kfvP3C9rn3fpbfF5
	L6sghWKNbGAMPhhUBuIvQOh87Rq+4M30vO2rgvDy1GSFiokbZNKxGdFkKEqGF8kXtBj4UWEC
X-Received: by 2002:a17:907:841:b0:b83:9767:c8ba with SMTP id a640c23a62f3a-b84451b5d1dmr1635823766b.17.1768229535750;
        Mon, 12 Jan 2026 06:52:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH+AXG1fXAqNi7crMM7QiDNAwZR8bNUqqDvj5BznuxA4nKTk8GLk6KKY85CmsHuZWbeWD797w==
X-Received: by 2002:a17:907:841:b0:b83:9767:c8ba with SMTP id a640c23a62f3a-b84451b5d1dmr1635820866b.17.1768229535247;
        Mon, 12 Jan 2026 06:52:15 -0800 (PST)
Received: from thinky ([217.30.74.39])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8429fdf4e7sm1985599466b.0.2026.01.12.06.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 06:52:14 -0800 (PST)
From: "Darrick J. Wong" <aalbersh@redhat.com>
X-Google-Original-From: "Darrick J. Wong" <djwong@kernel.org>
Date: Mon, 12 Jan 2026 15:52:13 +0100
To: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org, 
	ebiggers@kernel.org, linux-fsdevel@vger.kernel.org, aalbersh@kernel.org, 
	aalbersh@redhat.com, djwong@kernel.org
Cc: djwong@kernel.org, david@fromorbit.com, hch@lst.de
Subject: [PATCH v2 20/22] xfs: report verity failures through the health
 system
Message-ID: <i4tsa4dqqhjfutocdlk6mqm6ovvzea7ki2w32j6mcew66aegay@tsllwgeogm3f>
References: <cover.1768229271.patch-series@thinky>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1768229271.patch-series@thinky>

Record verity failures and report them through the health system.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Andrey Albershteyn <aalbersh@redhat.com>
Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
 fs/xfs/libxfs/xfs_fs.h     |  1 +
 fs/xfs/libxfs/xfs_health.h |  4 +++-
 fs/xfs/xfs_fsverity.c      | 11 +++++++++++
 fs/xfs/xfs_health.c        |  1 +
 4 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/libxfs/xfs_fs.h b/fs/xfs/libxfs/xfs_fs.h
index 3db9beb579..b82fef9a1f 100644
--- a/fs/xfs/libxfs/xfs_fs.h
+++ b/fs/xfs/libxfs/xfs_fs.h
@@ -422,6 +422,7 @@
 #define XFS_BS_SICK_SYMLINK	(1 << 6)  /* symbolic link remote target */
 #define XFS_BS_SICK_PARENT	(1 << 7)  /* parent pointers */
 #define XFS_BS_SICK_DIRTREE	(1 << 8)  /* directory tree structure */
+#define XFS_BS_SICK_DATA	(1 << 9)  /* file data */
 
 /*
  * Project quota id helpers (previously projid was 16bit only
diff --git a/fs/xfs/libxfs/xfs_health.h b/fs/xfs/libxfs/xfs_health.h
index b31000f719..fa91916ad0 100644
--- a/fs/xfs/libxfs/xfs_health.h
+++ b/fs/xfs/libxfs/xfs_health.h
@@ -104,6 +104,7 @@
 /* Don't propagate sick status to ag health summary during inactivation */
 #define XFS_SICK_INO_FORGET	(1 << 12)
 #define XFS_SICK_INO_DIRTREE	(1 << 13)  /* directory tree structure */
+#define XFS_SICK_INO_DATA	(1 << 14)  /* file data */
 
 /* Primary evidence of health problems in a given group. */
 #define XFS_SICK_FS_PRIMARY	(XFS_SICK_FS_COUNTERS | \
@@ -140,7 +141,8 @@
 				 XFS_SICK_INO_XATTR | \
 				 XFS_SICK_INO_SYMLINK | \
 				 XFS_SICK_INO_PARENT | \
-				 XFS_SICK_INO_DIRTREE)
+				 XFS_SICK_INO_DIRTREE | \
+				 XFS_SICK_INO_DATA)
 
 #define XFS_SICK_INO_ZAPPED	(XFS_SICK_INO_BMBTD_ZAPPED | \
 				 XFS_SICK_INO_BMBTA_ZAPPED | \
diff --git a/fs/xfs/xfs_fsverity.c b/fs/xfs/xfs_fsverity.c
index 691dc60778..f53a404578 100644
--- a/fs/xfs/xfs_fsverity.c
+++ b/fs/xfs/xfs_fsverity.c
@@ -18,6 +18,7 @@
 #include "xfs_quota.h"
 #include "xfs_fsverity.h"
 #include "xfs_iomap.h"
+#include "xfs_health.h"
 #include <linux/fsverity.h>
 #include <linux/pagemap.h>
 
@@ -363,6 +364,15 @@
 	return xfs_fsverity_write(ip, position, size, buf);
 }
 
+static void
+xfs_fsverity_file_corrupt(
+	struct inode		*inode,
+	loff_t			pos,
+	size_t			len)
+{
+	xfs_inode_mark_sick(XFS_I(inode), XFS_SICK_INO_DATA);
+}
+
 const ptrdiff_t info_offs = (int)offsetof(struct xfs_inode, i_verity_info) -
 			    (int)offsetof(struct xfs_inode, i_vnode);
 
@@ -373,4 +383,5 @@
 	.get_verity_descriptor		= xfs_fsverity_get_descriptor,
 	.read_merkle_tree_page		= xfs_fsverity_read_merkle,
 	.write_merkle_tree_block	= xfs_fsverity_write_merkle,
+	.file_corrupt			= xfs_fsverity_file_corrupt,
 };
diff --git a/fs/xfs/xfs_health.c b/fs/xfs/xfs_health.c
index 3c1557fb1c..b851651c02 100644
--- a/fs/xfs/xfs_health.c
+++ b/fs/xfs/xfs_health.c
@@ -487,6 +487,7 @@
 	{ XFS_SICK_INO_DIR_ZAPPED,	XFS_BS_SICK_DIR },
 	{ XFS_SICK_INO_SYMLINK_ZAPPED,	XFS_BS_SICK_SYMLINK },
 	{ XFS_SICK_INO_DIRTREE,	XFS_BS_SICK_DIRTREE },
+	{ XFS_SICK_INO_DATA,	XFS_BS_SICK_DATA },
 };
 
 /* Fill out bulkstat health info. */

-- 
- Andrey


