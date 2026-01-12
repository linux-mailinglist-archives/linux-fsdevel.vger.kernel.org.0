Return-Path: <linux-fsdevel+bounces-73258-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FDECD135C3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 15:58:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 904E130F84A3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 14:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 596B82C0272;
	Mon, 12 Jan 2026 14:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F4wTl+KW";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="g9pc0QRh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922282701CB
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jan 2026 14:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768229518; cv=none; b=aB/V+HYYVbIJJPvDzPa0dBK39hAJPUb86J7kl9pEEpoNkjM0mxB7M8hxHz1gb5wUFd7WsILIOBFE9hKpUw3IMEz0TGltdIYWBQpgakK3HtFxPC5JwMj6nL9kd+sQNJSV5nlGfnd7FPDLc+lqN7tc9FExODRZwsJAN6U0n+Sd47s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768229518; c=relaxed/simple;
	bh=IdS1PwWWIbUYnlpXP3SRI6nzxO4Ju/UrhGGqho3KZ74=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ek/uYH4k4Uq/B9HoFZvkz2PFmzrWgsqsnQpdz1x3Ay5OLeRae3CywEZi1X52FbAiLm0FhtjRoUmSXWHAtTjNMgkHBZhiPDsfH1xRkrwN8m7wfynWWr4ne0HLY3c9imhf2O5xECvpVPzmVrlEg85dXPgJOMbUgU5woo0gnDkI5ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F4wTl+KW; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=g9pc0QRh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768229515;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2hRRWYJKC2OgUTczWLcM4Cu6uVK2A3Bp7WXnQxkC11Q=;
	b=F4wTl+KW+M3ASH3Z9Jm+oIMcJz8lfz3JGXXkCt4TgxTzDdRQxHIIh/VbColoSMSOBtuimn
	dvZPRU2Jbx7eXJO6utr/QjQsEf9+cxnxYy+RaUDOonXN9gwKa4LASAvI7LEJ8I6KIzoEc/
	AW0wK2tVBODuPn+uFhrIj4BQgBvt1QQ=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-56-0LqeucO3OX6kjvMYklE8kw-1; Mon, 12 Jan 2026 09:51:52 -0500
X-MC-Unique: 0LqeucO3OX6kjvMYklE8kw-1
X-Mimecast-MFC-AGG-ID: 0LqeucO3OX6kjvMYklE8kw_1768229511
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b8711b467f3so160892266b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jan 2026 06:51:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768229511; x=1768834311; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2hRRWYJKC2OgUTczWLcM4Cu6uVK2A3Bp7WXnQxkC11Q=;
        b=g9pc0QRhv2Z2rEdmaX7ydfRThxlQvfWpWEGtVhtUYXPcUtY3qe2le3k9/9/SmBSnPM
         Udv3BGVtQSl29xM/J50xU0JTzpI+cGAuHXD2YR5HPplG42QNL48+3efBUPu2MFJ6ps+O
         qZdpIBGNFpA5tt4jf5mdDNupxY2cKOp43cCzGPXv4olWGKhuQC1vhnhEktnIhi57dUw+
         BZfKvv4zJVHsu/A3Rn47/FbMdRcBMe50EG1nt4DquK4Yw+sT4xqM3+jYuNw0pVW/Rr3r
         i0XYPe07Y0LyWzBY2ssVJ5+H1I32uZsIr/e1bCLzX5jaCmjfMM3HTQxo2Hrz556vkfmr
         YefQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768229511; x=1768834311;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2hRRWYJKC2OgUTczWLcM4Cu6uVK2A3Bp7WXnQxkC11Q=;
        b=F7Km96DfW+CTfmIJKu+cEfP5uxoMgLfDTgIBTUd10L0WLeqwVoqdWx9jS0VNRJfeZZ
         BSnQkNL4LVb1FzA0aP6STXWWHESZS/lJPhU2I7uamtr4iYoywNGcQFohsgw71HgyEhjF
         UliIw1CbPHxQsGL9c5fFvXgCauiaQEAI4lDcHIKxnOmtqSiTtmFSkwS7ET/5+VFOFxiV
         tSuY5zw8F8tl+Q9y+0SF1ypYiAYvoFVDEpthl2og/MUe8nrWB4XE1Ou2qhh3eMg0S7h/
         kpPxntkxwtj0OxgkBQr+DyfWuVA+w/MNSATtVrniKwhjtp7XMVCZviD2WXDZgw2zwPFm
         th9w==
X-Forwarded-Encrypted: i=1; AJvYcCUdYy1xr9o99U9DoL6VMe4VPoi/UJjpFiEsXFrQQYtubynoSbjCqctaDiqkf2VhsXrr+GIEohcAkGtNSOoj@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg1d/z2TFOkgiHZcqM6dHFmp7t9UhlLlYzrDcxOnCwYR51FwnA
	kK76ffQLa3ACp4a4bKAbxOuGQg4zTRPxNEFq3jb4cVYYSsyHKkgM1IeZAPrbuNulVsaEfSvOjpU
	LZlbIjgI6ri5dpk1uWigaK+bS8ziiYrTd1PI6VLdbFlah9gCJJ0uEnm1b3yzXyZ0b2w==
X-Gm-Gg: AY/fxX5pnwTFZ1ThLrfqczr98F5lX2Qs/EWUCQZAqsIp5BY1IA+yzz5KsWvOr54ikd5
	Z9XsFfhabFLAKkRpBiB8OQ2rxZaVa7KOvpTuosFt5pZfcmi2c1KC4xy3NmO++4Epq04RTKyB/PU
	suINahG5Yen4MgOWYlfdLw+FrneE6E8fbGwUgFlbTMxgPJMwlJyGriqklc4GVYUakN1ijqOwjwC
	kE2V2iYt6zOCG1YPW+3fmy8p2bmeosK0sjt+YnUUi6Kly1yaR+hGUadAg095qfDS+PzS4rCT94M
	MuxXbWZawq74c4NioxhkiM1pO5o8ZHNAFU4BFlqQawjVTJakVGB0QZJ6u/qCXRHy4DLjWEJ7Hgk
	=
X-Received: by 2002:a17:907:c04:b0:b87:191f:4fab with SMTP id a640c23a62f3a-b87191f52a1mr368289366b.26.1768229511329;
        Mon, 12 Jan 2026 06:51:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGBJU3+0OUhT73HxEYbdA8zvcwaYMtAwM44w7eMExzMrFyUpX/1W3ti3CNeNrDDtWZWpx+S8g==
X-Received: by 2002:a17:907:c04:b0:b87:191f:4fab with SMTP id a640c23a62f3a-b87191f52a1mr368286366b.26.1768229510855;
        Mon, 12 Jan 2026 06:51:50 -0800 (PST)
Received: from thinky ([217.30.74.39])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b870813a9efsm505866766b.38.2026.01.12.06.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 06:51:50 -0800 (PST)
From: Andrey Albershteyn <aalbersh@redhat.com>
X-Google-Original-From: Andrey Albershteyn <aalbersh@kernel.org>
Date: Mon, 12 Jan 2026 15:51:49 +0100
To: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org, 
	ebiggers@kernel.org, linux-fsdevel@vger.kernel.org, aalbersh@kernel.org, 
	aalbersh@redhat.com, djwong@kernel.org
Cc: djwong@kernel.org, david@fromorbit.com, hch@lst.de
Subject: [PATCH v2 17/22] xfs: add fs-verity ioctls
Message-ID: <j2sexom3szsvxqwtlzhk7hywzjp3sd3du4sycr6aglv73otodn@ydtl3rqh62xi>
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

Add fs-verity ioctls to enable, dump metadata (descriptor and Merkle
tree pages) and obtain file's digest.

[djwong: remove unnecessary casting]
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
 fs/xfs/xfs_ioctl.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+), 0 deletions(-)

diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index 59eaad7743..d343af6aa0 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -44,6 +44,7 @@
 
 #include <linux/mount.h>
 #include <linux/fileattr.h>
+#include <linux/fsverity.h>
 
 /* Return 0 on success or positive error */
 int
@@ -1419,6 +1420,21 @@
 	case XFS_IOC_COMMIT_RANGE:
 		return xfs_ioc_commit_range(filp, arg);
 
+	case FS_IOC_ENABLE_VERITY:
+		if (!xfs_has_verity(mp))
+			return -EOPNOTSUPP;
+		return fsverity_ioctl_enable(filp, arg);
+
+	case FS_IOC_MEASURE_VERITY:
+		if (!xfs_has_verity(mp))
+			return -EOPNOTSUPP;
+		return fsverity_ioctl_measure(filp, arg);
+
+	case FS_IOC_READ_VERITY_METADATA:
+		if (!xfs_has_verity(mp))
+			return -EOPNOTSUPP;
+		return fsverity_ioctl_read_metadata(filp, arg);
+
 	default:
 		return -ENOTTY;
 	}

-- 
- Andrey


