Return-Path: <linux-fsdevel+bounces-73259-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 811DED136F6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 16:05:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8BE2730312D2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 14:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F6442DC763;
	Mon, 12 Jan 2026 14:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YmsXyU5l";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zw5/yZqJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4232DA75C
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jan 2026 14:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768229526; cv=none; b=LjHY/Pw8rKHOO811r5vSieuwhwEsxvoRfffpckWgCgYN0KyRh4/R9wVyCDGP+/peS8h4YuKlwC1YSMqxRWwifLQrEjQuYUuXHpE2z1KHnsvfUNutctmMOyJjwfdUH3e64KmjUoBRjRqoApP5TMRi5Y/djXMIqr+hMlhO2ZTKL6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768229526; c=relaxed/simple;
	bh=juaXjaWCdJhgUxdxDnPo/I5g1bovOuzvfAho0L4f/bA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pr1YymQktlyYAwecJOnT6TYLNOxUl6iZIWuuHwg+jIo6Kjx1dbrsR/X2fA0c1h76xLWxOoNtBlT9ETOuW3Npd3Tkf+YhFLsLPCrIFqHhJHnI8RX+19xcHsH1O0eouWhShmD3/tIiSGZg5o5R1tI81YDzte7pAtbnCTVBlFefBeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YmsXyU5l; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zw5/yZqJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768229524;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R3lmcg/cu75BB25Wlh2Ox4/Pwg0aDpFEC5S3Bq4BJXs=;
	b=YmsXyU5l4o9LXlKlwW9aX7dpaEHPr6HHLJd1khbdk6KbEZPO0vOt81YSE9v3SLwbsP8VWN
	sfnDvOTNUwd3pFYLoVKyGrUH8LRtuHUBBJmZzDyVNchLoLghKu40U2nEx3YJ3uOYrPXXhT
	jmJ6gLNPidz3mAWhYus+VDaKRUuEklo=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-439-e3wPOXrIPxywrvCZuf1i9A-1; Mon, 12 Jan 2026 09:51:06 -0500
X-MC-Unique: e3wPOXrIPxywrvCZuf1i9A-1
X-Mimecast-MFC-AGG-ID: e3wPOXrIPxywrvCZuf1i9A_1768229466
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b871ea8299dso86988066b.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jan 2026 06:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768229465; x=1768834265; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R3lmcg/cu75BB25Wlh2Ox4/Pwg0aDpFEC5S3Bq4BJXs=;
        b=Zw5/yZqJV6SWH00XOaeO9z7owSXnVvfeKug3ZcsVFdocEo6uaiP8ZrS6J5XDVLG3iH
         yTQ2X4fpP2mcj97MR+Z6MnbQyKnuEpw94NK1rny3PGF57qJig+yc9CI3SXoig+o2wekp
         lW3YesRxdz40OLJP6iypgOZYEnv+NEsk3vP+gg5XKe3usE9eP1l78Ydrqehq75HASuot
         Djf4KXh/fb70FVTH6+4VJiJsIY9lsBIQJu4DvH9MFVddkzS8SEfITcPLFhSG1uYxHjWm
         H60S2W81NMuF4/x5ukCqD7SNUligxHEWqNxuh7dkR4jNzKq0VVU7C26sCo3Zw5X0SQje
         +ZUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768229465; x=1768834265;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R3lmcg/cu75BB25Wlh2Ox4/Pwg0aDpFEC5S3Bq4BJXs=;
        b=GovDyhQfR3UZzkX8iFGCdVBwbtQFSRYRNUjICI0AM0YdLJK718qK4dUaQm6ePyYZWI
         wCzL6TLmVgWAOrfOQpVQi8eCOF9Q0YsoTYOzGqsMCQqT2uQSnz65ova4Es6fGSdP9ucW
         RPgUAWBjjmTWwoTMsTqMxPbZmvGDF2rC6cmvYTIjMhrD1RirDj9ShUrPjBP2Bvf4ESG/
         7BimRxgchcp8PWTImFiG/sH7M+tke44vBTAQGFlheuKOTH3sDsxTeX/vBBlps8BIssDh
         N9RdpvQMBXrWZiRROZFgOgjH5S5d1YbF0UvgMVqZKmYa9KhFLCD0LO09q2YY7Nk6nYog
         ZLKw==
X-Forwarded-Encrypted: i=1; AJvYcCWDpK3aE6zsFUPfzGL0u3ULZ5PQYDschT0A5puWGfgVn8sEpEaPFKrN3qdRyFquD1AUayNg+1IJgUZaVgSc@vger.kernel.org
X-Gm-Message-State: AOJu0YzneYQJ8Vov8QF62O5brJ/UOr0gl5w+UuKGHHGYDu5B5mcE8scN
	bucgZ4VmzqfZ1HzL32Enp78p/2UrJni+aGLpaDVw5SgPbkCmeXM9Oo6yPWLGMHMo1yHTkup1yIc
	eJtvaYJ/dPxhi3PZEJxlyR0tWqzRYqlCqPltHQzv+ofwmdA6//9QJNojAzZUaLk3+Z7RvOogFCw
	==
X-Gm-Gg: AY/fxX57ZYxHZfi3No0WE24ldUR1k30B7BApNjsz0NdqX/TMajwbP53SEzPMyeURVwO
	q4AsxJCgZQbMTGyeofgU6G+Z575Zp/5N5FIQPi2UMzzwJbsk9N6xgKUZ2Trt2VwMboo9ffBaTvK
	eqXIDCl2+zVqupcddxixGZ3+GLhC5dr4QUJ3Xe7XyHbibW7mmWjxlGhbX8KFRou2OFQ6q4vUMDm
	bGBIdVvZG+T4QNDY4dmYr8go7TuzcLnogVcSpJzehUVm5r4G9djdTNbl+b+cMNvreiV7IS2eXcu
	TJ4XgrZNWntKrEmgfNOBWU8jaOWDa8qm9A0paaavuPNpcdABMUYrS6xEgdXhCzbhLOep+RRFEyk
	=
X-Received: by 2002:a17:907:968b:b0:b87:15a7:85e0 with SMTP id a640c23a62f3a-b8715a78b2cmr338221066b.26.1768229465047;
        Mon, 12 Jan 2026 06:51:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IET2nU/xS7rTGGJI9aaTqCSFphZHua3LUHkxfJzBhZsDQMy1yw4maDpAej9bQDC3iRtIDmAUg==
X-Received: by 2002:a17:907:968b:b0:b87:15a7:85e0 with SMTP id a640c23a62f3a-b8715a78b2cmr338218666b.26.1768229464502;
        Mon, 12 Jan 2026 06:51:04 -0800 (PST)
Received: from thinky ([217.30.74.39])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b870776b642sm529509066b.21.2026.01.12.06.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 06:51:04 -0800 (PST)
From: Andrey Albershteyn <aalbersh@redhat.com>
X-Google-Original-From: Andrey Albershteyn <aalbersh@kernel.org>
Date: Mon, 12 Jan 2026 15:51:03 +0100
To: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org, 
	ebiggers@kernel.org, linux-fsdevel@vger.kernel.org, aalbersh@kernel.org, 
	aalbersh@redhat.com, djwong@kernel.org
Cc: djwong@kernel.org, david@fromorbit.com, hch@lst.de
Subject: [PATCH v2 10/22] xfs: disable direct read path for fs-verity files
Message-ID: <6rsqoybslyv6cguyk4usq5k2noetozrj3k67ygv5ko5fc57lvn@zv67vcnds7ts>
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

The direct path is not supported on verity files. Attempts to use direct
I/O path on such files should fall back to buffered I/O path.

Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
[djwong: fix braces]
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/xfs_file.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 0c234ab449..87a96b81f0 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -254,7 +254,8 @@
 	struct kiocb		*iocb,
 	struct iov_iter		*to)
 {
-	struct xfs_inode	*ip = XFS_I(iocb->ki_filp->f_mapping->host);
+	struct inode		*inode = iocb->ki_filp->f_mapping->host;
+	struct xfs_inode	*ip = XFS_I(inode);
 	ssize_t			ret = 0;
 
 	trace_xfs_file_dax_read(iocb, to);
@@ -307,10 +308,18 @@
 
 	if (IS_DAX(inode))
 		ret = xfs_file_dax_read(iocb, to);
-	else if (iocb->ki_flags & IOCB_DIRECT)
+	else if ((iocb->ki_flags & IOCB_DIRECT) && !fsverity_active(inode))
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
- Andrey


