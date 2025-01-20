Return-Path: <linux-fsdevel+bounces-39704-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D8F5A17135
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 18:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B3D51887167
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 17:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE041AF0A4;
	Mon, 20 Jan 2025 17:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ccLg0N9d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E46E17E4;
	Mon, 20 Jan 2025 17:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737393624; cv=none; b=IWFPc3RhPB/5PC44Pghrn69kjilvueBKG0qOLCLrWqhVAvlf0nrr0eXWu01uwkXEZVmfcsF+ubozXW474Y+KNdO1/XZnhcmXqDQR+M6kQTaF8C21TJdvPdaS2UDCDnZW042vscvEIX5EK9+JAExD5OLh8DZPQHsYA06Et163hf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737393624; c=relaxed/simple;
	bh=YmNOImJMW44nOI1mrUv40N8RDQOd3IK+LKDNVg3cDGU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OcIBsTlx91UgYBwcAUI0JjlX/JUBOB5F8+g045YLpjt/5lQGsyCeJSEQHVPD/8/6MVdMl9Rp5q/CeSflc13/G3s1Sjn8NNl4/k2LZ5CraDp+1e1vX3MsOcqCpxovQUA7nIwGOY/eSFJpjfCtvGypW+nh1q71RqEoaDTx/0l23Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ccLg0N9d; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4362bae4d7dso34059235e9.1;
        Mon, 20 Jan 2025 09:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737393621; x=1737998421; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6eym3f06tjGimIT8VwM5vM+A0hCcYV8o7Ee4Frx1+bA=;
        b=ccLg0N9dKU0fOqxrBAmUhuHKz7WoaqFXTb6nPoR3LYNVeRHBKnuHZ1j69VptpQLVnH
         0i4zSsM5+suSb9v6mYevCOxEGihLJmOgpV9ODVmd+c9cZyg6WN7YLIWAgrH+nvU9GyGu
         cHdpF99fmcbsDeFcRc36Kw12JZCmTo4xKksfZDApOS2xRCkUoZJQw1maz+Y2aQRi5edv
         SkE+GhqGJew6f1HcPt4fTVDcCTO/Z9Qf/PhdtY6piB11Aq7TWYTmdpmkfSCkygDLik4Q
         2TK1UuOgcPJnejrstlCPPz42N/EOU5qco3xLG/CN0ZFehj+RBb/GMK6wvBTT0JMdP8bt
         jXXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737393621; x=1737998421;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6eym3f06tjGimIT8VwM5vM+A0hCcYV8o7Ee4Frx1+bA=;
        b=erZuLW31wQT7i+ezEFqx3RRwXXhLwjDWVcErhSO6rdmtCySHaLusmM/Ba92CHQCwVP
         ivnhWXkijT4KiJwz715qohN+ZZXOsEjnHFLAGNsG+smeWUvkLbMhUY59WrKx80VKdo6G
         vciSoGEg1DvvN9Me1ZV4NE/ift33sOPul5Zi9rAqbvgJ/E8wWGejfkkDig8NgrVENYZI
         GAlwREfcFipVYCWTWpJS2rGixCzyo6qqBIMYuf5BNYABAmX9ixWVA2Y/+Bbd7XoGE7Hm
         Orz+Wf55SE/npT7bOLqNKcmQvHBjtyPP+csLdepPOp3TET7w57D8ZhALkfY6Hiyngplg
         l58g==
X-Forwarded-Encrypted: i=1; AJvYcCUpq62at/m521TYhPU5LXpKl/5PaKejZgxP4fiH4Jxe3t4KJwLnx1CwceWoybOubwMFtvoUnKuszN3mArIX@vger.kernel.org, AJvYcCVgfO7m+bZHRwqP+9mYz4wQbwvNIgFSDWD/Kw4bUHVPseDb4F/u2lPP5Q8x37hxHDvdscrwFo5H1qxs@vger.kernel.org
X-Gm-Message-State: AOJu0YzVmOXg0I6l4AbVUwEbAklCHYz6riqIzQPqU3rhBeERXEhfl5v1
	m2+MKNBFSrh3OpVF/SVn/y34eZbPdKBVaWhrropefipCs27mePCW
X-Gm-Gg: ASbGnctOw5WTrCkNIMbosNZF6dQXMQEfxWfhbQ2fcsfbdWdAgUGmmua1U1xL2bGwF1W
	zgG4Cu2u4RPiN8ql0I/kumEeQS3nZeo9c1oGWXHk6urrWMq29k6sZTJb201jj0RS59wgbiimoMO
	DRIkvig6u7eEvY5j7kHJIr7AG2A5/f8fEsa5MiaHqUzr3Wlr7YEWqNFMNJ4Y510R2uWSS3QE7mH
	VAl0wm1cL2MiyhdQDN2b3lS7cUhq368RbxsnNjzPiDQTsoGz5qy5mflEUMJeCMcZAzrRAzyL3Yp
	LFzNXoCIlIhB1MCogn6PUzgJMOCtnsW1OEpX4qFnbTqK3iT/eEkkdwzYzxpCUe60Mqw=
X-Google-Smtp-Source: AGHT+IFZaJJhMaheNcRMA4nRMIbFHI8Zzypf9JsNebayS9KX4iwMXHs7kQVJWg0xS0joEQrQJJEZ7A==
X-Received: by 2002:a05:6000:18ab:b0:38a:88a0:2234 with SMTP id ffacd0b85a97d-38bf5655328mr10793980f8f.4.1737393620976;
        Mon, 20 Jan 2025 09:20:20 -0800 (PST)
Received: from amir-ThinkPad-T480.arnhem.chello.nl (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf328864esm11242813f8f.99.2025.01.20.09.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 09:20:20 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Jeff Layton <jlayton@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH] nfsd: map EBUSY for all operations
Date: Mon, 20 Jan 2025 18:20:16 +0100
Message-Id: <20250120172016.397916-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v4 client maps NFS4ERR_FILE_OPEN => EBUSY for all operations.

v4 server only maps EBUSY => NFS4ERR_FILE_OPEN for rmdir()/unlink()
although it is also possible to get EBUSY from rename() for the same
reason (victim is a local mount point).

Filesystems could return EBUSY for other operations, so just map it
in server for all operations.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Chuck,

I ran into this error with a FUSE filesystem and returns -EBUSY on open,
but I noticed that vfs can also return EBUSY at least for rename().

Thanks,
Amir.

 fs/nfsd/vfs.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 29cb7b812d713..a61f99c081894 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -100,6 +100,7 @@ nfserrno (int errno)
 		{ nfserr_perm, -ENOKEY },
 		{ nfserr_no_grace, -ENOGRACE},
 		{ nfserr_io, -EBADMSG },
+		{ nfserr_file_open, -EBUSY},
 	};
 	int	i;
 
@@ -2006,14 +2007,7 @@ nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh *fhp, int type,
 out_drop_write:
 	fh_drop_write(fhp);
 out_nfserr:
-	if (host_err == -EBUSY) {
-		/* name is mounted-on. There is no perfect
-		 * error status.
-		 */
-		err = nfserr_file_open;
-	} else {
-		err = nfserrno(host_err);
-	}
+	err = nfserrno(host_err);
 out:
 	return err;
 out_unlock:
-- 
2.34.1


