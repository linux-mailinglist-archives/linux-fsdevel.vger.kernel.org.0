Return-Path: <linux-fsdevel+bounces-56182-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1AFB14336
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 22:33:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1BDE18C2BF4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 20:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C008285048;
	Mon, 28 Jul 2025 20:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MBJ/8QSL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6146E284682
	for <linux-fsdevel@vger.kernel.org>; Mon, 28 Jul 2025 20:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753734710; cv=none; b=o6sHQoJlR0E854qIVFrwAkZfuN9zl93Q+3qLj0hdL1bVb4i8K0n2IEVwQD4iuJxltlYP6h1mQ5feMUMZYkcec5sa8cyWZf4vI99Q6jDyNA6iJLENDIzmGvjrhtzmD72ed/iwzZ2WkWgA0tHBMAE3dw40JbBvaRKVbZiSDrf0d9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753734710; c=relaxed/simple;
	bh=oXrYk89O0Um5P8PkyP0aN/fzstJe93VqP0YI02ddnhE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ILWQYEY4jvDTt9aH0Y+CIcr6hKFR/aNU1Ot66sIzV6fcXA33IHu1hkD7Kh6eGp0GmiwmplPAWU2c1akYYKURVAn1WijbNWqslPuoNKDjOBuziT0v72r1MPs85RJRKbO8yHLqiUJtzTDhITTNkXJAOpI3qQitVuLco2XSXWWUGyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MBJ/8QSL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753734708;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/UHpX8nvBBvaUQO36ZKMY1wOJRmJ65rli9NZbFUt5AA=;
	b=MBJ/8QSLSl8tL77VtH3dojIsqAqBEajvER8eEQRZSRXbCaG/3YOHlGYAWa+92Lz7Bc42XY
	v5VgkDRZmlp8kIUWmtJd8P+NM3gwLttjchySwbgf2QDua5ULKs6GX9OnCo3wbaOKYci+Hh
	Bq3jDXA81SND7bNx969UmaOogd9Mvv4=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-272-ZNNUl3uENLSnS719eXSi7A-1; Mon, 28 Jul 2025 16:31:46 -0400
X-MC-Unique: ZNNUl3uENLSnS719eXSi7A-1
X-Mimecast-MFC-AGG-ID: ZNNUl3uENLSnS719eXSi7A_1753734705
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-60c9d8a169cso5354454a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Jul 2025 13:31:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753734705; x=1754339505;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/UHpX8nvBBvaUQO36ZKMY1wOJRmJ65rli9NZbFUt5AA=;
        b=hy/wgeO2CAkNIv3GvGdFOMIN6rPH22415+3jNJzNpQKwTai2HHhNFOhAIjJ7ZruNWg
         p1bTAu74jkrrCbYZwjU86wKrrY5+6OVthe+Sptw8/2OB3wmnPaRH2zZzgBCvHaDwL+Um
         LtLHHIrk/2T/z1h67LjTWX5qSllbqPijWw5RTx2YbEzIF2pPfUTaNspuO4Z/glWjuUQ5
         96f+UM4P5Qpzakk8ky/sUbn8jW4PhougKkue7BrUmDtuVAQrZKTeGcwWxfeKeH+3zS5u
         McLgrhdOi6OfCiTbIBIScMXX3MlyKiu0Uxb+Z8Icn473THi2Jk9EBXkQh0AQsE3TQJxz
         O3Ew==
X-Forwarded-Encrypted: i=1; AJvYcCVt+3vbjijc5uWXlZaL1I7XX4aGgPQKA47iiYxCITtiMUk0D/ugjehCzUa7MeWPa9cuStP1s2rxNq2FFQT+@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8C7cLG5fCQdO7P77HRBM7Irk4BMeDQWgrkTJ7Xezgx6ixo10m
	TuKJEXxQozMsXWWQLyFn9JAuxtPdDwVThkNPls4NtKPijyXbc3O2rInafpqGJUAnzH8MJjvd97R
	M8ZHreqK5cZVK+uamMOimn57oJCq/Zo2QAhs6nEqYf2wZvjhhJrzeXSx00KCitLDbWw==
X-Gm-Gg: ASbGncvrs1/xGvj+B1B8bhVXg3n0FKQmc78rFVevM8LBdNI2TcufzkBoG49mkapPy9D
	pfZMiOeVFIlfrr9pmDAA/N3Uf2SIzi5JbhQWSrbhfp3C4rbbNfj0KkxAzvKE+TM1xC0GGiAmZbq
	t9R5CQdmOj7W/thTuAjV6NCwKA4f5VWDfQgAhF9X3b6dfaLTP5nnwbz4JEVbHH7FInjKLfBTxd5
	npNC44TRa3oXnyv9KZHqcfs+FJxpBaUKfWBGueIoJ5YfSTtBjjf75XpdpMrbwxAgxqND0sU6Fdk
	hXvOSPmi8oQCRVS0/hAcau6Ltqul6ORg97wVgcHzmDAqAg==
X-Received: by 2002:a05:6402:1ec5:b0:612:a77e:1843 with SMTP id 4fb4d7f45d1cf-614f1bd4bc1mr12230478a12.5.1753734705274;
        Mon, 28 Jul 2025 13:31:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFoDTzvEORt+zYj5p5DTj1JYCh8sm3pEhkMIx1xgTWgVgB7tdbLlFlIksa68FpKbUDf1D8onw==
X-Received: by 2002:a05:6402:1ec5:b0:612:a77e:1843 with SMTP id 4fb4d7f45d1cf-614f1bd4bc1mr12230456a12.5.1753734704844;
        Mon, 28 Jul 2025 13:31:44 -0700 (PDT)
Received: from [127.0.0.2] (ip-217-030-074-039.aim-net.cz. [217.30.74.39])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615226558d3sm2730656a12.45.2025.07.28.13.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 13:31:42 -0700 (PDT)
From: Andrey Albershteyn <aalbersh@redhat.com>
X-Google-Original-From: Andrey Albershteyn <aalbersh@kernel.org>
Date: Mon, 28 Jul 2025 22:30:27 +0200
Subject: [PATCH RFC 23/29] xfs: add fs-verity ioctls
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250728-fsverity-v1-23-9e5443af0e34@kernel.org>
References: <20250728-fsverity-v1-0-9e5443af0e34@kernel.org>
In-Reply-To: <20250728-fsverity-v1-0-9e5443af0e34@kernel.org>
To: fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
 linux-xfs@vger.kernel.org, david@fromorbit.com, djwong@kernel.org, 
 ebiggers@kernel.org, hch@lst.de
Cc: Andrey Albershteyn <aalbersh@redhat.com>, 
 Andrey Albershteyn <aalbersh@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1235; i=aalbersh@kernel.org;
 h=from:subject:message-id; bh=1zT9nrTCecXTInwM9izpme0zk/YxcLuwcyE7K7v4l/w=;
 b=owJ4nJvAy8zAJea2/JXEGuOHHIyn1ZIYMtrvSUgKGS+eNzO21U7T/oLpxbM/FOT+TbixuChou
 0JdzLdShpMdpSwMYlwMsmKKLOuktaYmFUnlHzGokYeZw8oEMoSBi1MAJlLey/A/ecr87Tt4lXv3
 TFp3aaKx/Mw/YmbHXa3ZXkxgr4ngmW6oxchwVew9d6SIbvOkjAPRH83lblz88svzXlqExAw+WSa
 H+Yo8AM5/RB4=
X-Developer-Key: i=aalbersh@kernel.org; a=openpgp;
 fpr=AE1B2A9562721A6FC4307C1F46A7EA18AC33E108

From: Andrey Albershteyn <aalbersh@redhat.com>

Add fs-verity ioctls to enable, dump metadata (descriptor and Merkle
tree pages) and obtain file's digest.

[djwong: remove unnecessary casting]
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
 fs/xfs/xfs_ioctl.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index d250f7f74e3b..589c36ee4e7f 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -44,6 +44,7 @@
 
 #include <linux/mount.h>
 #include <linux/fileattr.h>
+#include <linux/fsverity.h>
 
 /* Return 0 on success or positive error */
 int
@@ -1428,6 +1429,21 @@ xfs_file_ioctl(
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
2.50.0


