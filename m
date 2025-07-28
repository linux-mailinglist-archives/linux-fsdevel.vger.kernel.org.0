Return-Path: <linux-fsdevel+bounces-56178-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E20B1432D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 22:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E8F218C2D1C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 20:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF8B283C9D;
	Mon, 28 Jul 2025 20:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LSoZkg46"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD37128313D
	for <linux-fsdevel@vger.kernel.org>; Mon, 28 Jul 2025 20:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753734707; cv=none; b=DOBp/8y3mossotJheKmeJq/nJWLNvvBwLb9UO9HPj5Yog4F2IEbOe8JEGTWQHfHDNQDHy7xohC1lt5lq5K1s8HH8lWQ1Kg7qpbO3u2b4KsPOo6E5z2AmI2bAT3urznj02uAYXD0RzfCdT1BcY5e4SmhJPPAMIohm6glS0rkvAKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753734707; c=relaxed/simple;
	bh=9p3je7ovaq0B8RD2/pr9rtueolxe1jVdbp+fSNss1tA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o/bZPh5jV2acXLuHH1DJlT74pCIKzSgMNJNL2Y8qj27DwpV7E0weMzVzBD/x7uN3dH3Kje+JgVeMDkjDpD9F/EnRTE0rf72M90FWh7+R0amYzxWK59bwaW7iPDkXfvL6bjFjcVePu759y5pSa94+pjecU3/2YPICKF8FGiDDXQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LSoZkg46; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753734704;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QtQJvCPxeTpstVyjgZAbXZc0G2YxyuH7YAlXrLlQnu0=;
	b=LSoZkg46J91hKY01A7NmOzaGruYz3RcvKn1VvndTcStR3E+bEjGMiGOTJtOkSb0/rAZRkN
	dzyx8+GqLLwVqYuTfMp66EVHLLpyPfBG7aqXmISwlBrnahfrlnjeev76fW74uI6PWzSsNG
	f3hsm0IDUnHxgPCHQ5yIuWphMg3+Z6I=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-331-Xk5vWnoeOJ2AgSktNLhY7w-1; Mon, 28 Jul 2025 16:31:41 -0400
X-MC-Unique: Xk5vWnoeOJ2AgSktNLhY7w-1
X-Mimecast-MFC-AGG-ID: Xk5vWnoeOJ2AgSktNLhY7w_1753734701
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-612b23a8064so5278454a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Jul 2025 13:31:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753734700; x=1754339500;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QtQJvCPxeTpstVyjgZAbXZc0G2YxyuH7YAlXrLlQnu0=;
        b=B2ZrcNW5MhsAEXXN+R8aicJezw+agUC9NaUBnU8dfZizfhEp9c2oWeMo6eu45AoTdd
         4fmMPsjvFGGJpgAAIwc3owGsRT9SU9vZc2CPy3+88nvGXRjlv4++g6/xFXLXpdxSzipi
         yK5CYiEju2yWP5Vv18v72Wp+6HwcWRIhrNQvadcKMyrRlbp0G5OLdd07Q0O18DQdaSpU
         QkHGTKf6czUpZYLREDdVncQTCiVNNOge0u7Hu2LILdK5rYSChjsyxizJHlwEusctDN/v
         P88geSAh8i09/GSpDe0G75KI1DOfyW+FMpnrSDxf6YqFqynV6NXKFWjhXQcXun9IpjMD
         EbVA==
X-Forwarded-Encrypted: i=1; AJvYcCXDzKUAWPpQfYN7Clr1HzvohfzZMSvtmU2z1M3dshb7VHbeSt1vU8C6G+USBI4qCxPq3oZSrZw038SCFL9K@vger.kernel.org
X-Gm-Message-State: AOJu0YxURbkG9Ssgfhop49sqZH2TPMsryc8ES7Xe1Apzsq7diD5VRgpB
	LJYSJ8jAKaQrPbZKf5WbYnw9pGDNLq4thPvGbwBAJYrlN78ZKLOts6Yx13XAJwKDfhF3P6bWOKk
	I7zTSY6hsN9MWpiPfA1RcfYxFHH+8k1uuncMNFRaeNUihW/w8YoIPvLIwoPZoqGWL0A==
X-Gm-Gg: ASbGncsbLI+j2HOy1lxY2U+6MAXE8qn6KE4DGn0dHL0QJKbvWFVmFoueG0+udiR9ZMo
	jox4pEispqyPjTAtNo18KQjoHB4mKO+B1YN7vJ5A0H5krO8fqkMKtHgShTc4pyQJqemJilYSPwQ
	3gKtZgsbN1rsI7zTHDaIGBMdSaAfRaJ3Jp+TV0HCPlhbgo+x8L77GswqkoXmYDXow4qkbUN2Q/Q
	cAm0GmVRUS1ZQjIWUyn0dU8gjCSAUkSpDY9/V2mh/mAr1Oa9sUDSYAVtnzncBoelKEQt24H/ERH
	AfDFCk5y9ttsJIMfB9WFSQ2O4ncRYTUTybK0xZo+9gI4fw==
X-Received: by 2002:a05:6402:84e:b0:607:f082:5fbf with SMTP id 4fb4d7f45d1cf-614f1bc4e08mr12085052a12.12.1753734700505;
        Mon, 28 Jul 2025 13:31:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFEm3mB3ElwGqIqkRyBhO2Z5hZvB74PuXLKq9UDjvFTGDUQy/f5zCpnhAQLNFtZgZRIeyuyWA==
X-Received: by 2002:a05:6402:84e:b0:607:f082:5fbf with SMTP id 4fb4d7f45d1cf-614f1bc4e08mr12085030a12.12.1753734700033;
        Mon, 28 Jul 2025 13:31:40 -0700 (PDT)
Received: from [127.0.0.2] (ip-217-030-074-039.aim-net.cz. [217.30.74.39])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615226558d3sm2730656a12.45.2025.07.28.13.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 13:31:39 -0700 (PDT)
From: Andrey Albershteyn <aalbersh@redhat.com>
X-Google-Original-From: Andrey Albershteyn <aalbersh@kernel.org>
Date: Mon, 28 Jul 2025 22:30:23 +0200
Subject: [PATCH RFC 19/29] xfs: disable direct read path for fs-verity
 files
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250728-fsverity-v1-19-9e5443af0e34@kernel.org>
References: <20250728-fsverity-v1-0-9e5443af0e34@kernel.org>
In-Reply-To: <20250728-fsverity-v1-0-9e5443af0e34@kernel.org>
To: fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
 linux-xfs@vger.kernel.org, david@fromorbit.com, djwong@kernel.org, 
 ebiggers@kernel.org, hch@lst.de
Cc: Andrey Albershteyn <aalbersh@redhat.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1542; i=aalbersh@kernel.org;
 h=from:subject:message-id; bh=pMZQbXtMrVBz6SrzAXMqrLN3V7mq4bHJ3sncK2j8+2g=;
 b=owJ4nJvAy8zAJea2/JXEGuOHHIyn1ZIYMtrvSXxXVRT749GyXdn3V8Wy/1NWLajpunhedsr8p
 PdVBb+qMxk7SlkYxLgYZMUUWdZJa01NKpLKP2JQIw8zh5UJZAgDF6cATOTfKYZ/JpG5x6ae+WG9
 UHzu0bbHp/l1zJR3r2a6/kn4xPYVObVntBj+GeYfWnr/wBwvvidTpB3bFZ1ZZxxvVNr0zeXOi8w
 JTWfd2ACym0xK
X-Developer-Key: i=aalbersh@kernel.org; a=openpgp;
 fpr=AE1B2A9562721A6FC4307C1F46A7EA18AC33E108

From: Andrey Albershteyn <aalbersh@redhat.com>

The direct path is not supported on verity files. Attempts to use direct
I/O path on such files should fall back to buffered I/O path.

Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
[djwong: fix braces]
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/xfs_file.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index da13162925d9..9680c97ee40f 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -259,7 +259,8 @@ xfs_file_dax_read(
 	struct kiocb		*iocb,
 	struct iov_iter		*to)
 {
-	struct xfs_inode	*ip = XFS_I(iocb->ki_filp->f_mapping->host);
+	struct inode		*inode = iocb->ki_filp->f_mapping->host;
+	struct xfs_inode	*ip = XFS_I(inode);
 	ssize_t			ret = 0;
 
 	trace_xfs_file_dax_read(iocb, to);
@@ -312,10 +313,18 @@ xfs_file_read_iter(
 
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
2.50.0


