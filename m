Return-Path: <linux-fsdevel+bounces-41447-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5872CA2F94A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 20:46:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DA0C169526
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 19:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD7924C68D;
	Mon, 10 Feb 2025 19:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="exTWMI3J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3399524C67E
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Feb 2025 19:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739216720; cv=none; b=rnFMIMnKLTXK4MZ1kSKZC3Tb+RUD3pc/zsBO7DarZA8KB6kWuD2ZuBdxRguX3lenAkJC0IPoTU8N3cdSLw8SW9K84iy6wAbZRsYG44r3cA/LXD1iz1zZ1UubmLQgV+LOMZJ2/2WacMMnTjLwm6rgPUute02Xo7s0IQkcFgcis4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739216720; c=relaxed/simple;
	bh=uRat+cUyQajKEyuB4dBz6csHrUX7Fiqv34ihZIzWhBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q6nFuJVujC2JR6qsRQ+ujhNxCGWoz8tg8jF1NM7kRR0RkfNB0K6n9gojodTZkpvaouC6iptMDFiJFhGfG8EOjWBC3cMzuAVKnRhwDIT55VNtZEf+wW00oA4vyamT7G/n/OBKPfSWQX6RM+zSrz9+q2wsWElKE3Nr6rb1yk7gGf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=exTWMI3J; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739216718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4UE9EuMWS8G/WY3PW4PUElfvLYYRRN8pOZXqxaL6Pog=;
	b=exTWMI3JfYNtDV3DNOpF3nsIlyjUI2Du9tv55ZzqRUTq/LF4fKRYnS7fbm7E+RIF3HgWHl
	UOHZGMVAJ12uO5Kf7jNELA2Ib1X1DRZy3xHqT5/TTm+h611z8ZQPxy7MDw3Uqy5JYVCkhL
	Cyzv170H3dri44G217cIu/SN6LaXYZQ=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-XglucPsPNjKKw2Pl2jMW_Q-1; Mon, 10 Feb 2025 14:45:16 -0500
X-MC-Unique: XglucPsPNjKKw2Pl2jMW_Q-1
X-Mimecast-MFC-AGG-ID: XglucPsPNjKKw2Pl2jMW_Q
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-ab7cae13359so153392966b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Feb 2025 11:45:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739216715; x=1739821515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4UE9EuMWS8G/WY3PW4PUElfvLYYRRN8pOZXqxaL6Pog=;
        b=GQY2bWaKZkpBQYDLMsJ0L8Tko4PeYYpGIgT5pN3eyxAUY4tRQpkyHzbT+Z/s91UR6W
         z8Vpi6lbXt4t5QHBO4+8RtMYtj04+P/cspv3ZWVDYKMR9YTEFhXyhAA/s2fzj1ctH1Rh
         CuiJfdm28JS0rCCVwNlAR+eeP4uRABV8NYrrm2q8VLsVc2tR/iHPV8016moF+4Qwt6hp
         qPclyd+Fvx1hhaa4w4p+qn+BUMZMW6QPKzt3H/RfdhQo2HaM2KbZepfikBtwVbAdKb3A
         F993NDsaXSK85T6VdvTkNIKqtpVaXWqs2sCzCbwi8p8KlpQ2aaVkDIzrE+4HAhJ/L/ey
         ctNw==
X-Forwarded-Encrypted: i=1; AJvYcCVIm9s1WiDWuckzs260pB/r1xFHuY49r+XDMGDqdL5AbB4c/qGpL30MBoxYc0ZcMM1F4z95AGKt5QMldE0h@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5sA2v7Wxc3fiVenqpPRztcU1zLaaIihGfHDHAf5S9LgMtvYKI
	uI4hmNnf35CB/AM/JZVG5eFCkoQEWSg7OPCn012C5e6Cuji5ehnYFFi+wL2m1kVg25GWbHwBEVy
	/Xo3Y84L0g1yFB4LVxZO/kWTeoGsZkrJFCK6HPGN6aU2rD+EaU+U53J1Tdd8l/QU=
X-Gm-Gg: ASbGnct41KMjC1dS5sfhd5+3dd0IkNca+LxIZRQHmBqwZ5qhm/0xD1j8PbCFyDLbSbt
	BvKdAZCmkrLPlK9RsZy354oe5LnYiWZ0kOgJT4dQs6NUw5pT9oc9JpFA/SdL04rw92oyDeUqX7v
	7buY098EWJ3bv37Ze5j47kbW8AcP2XI5XPmTFIyyzXzOO088jSIRRz+kuF0lG/uvu/yyN/HxKj/
	L/QQlAckFNhpDECyxuNQW3Y4dtbvQz0a8MG5R7G2606ML0cuFQKBva7a4CA6o+ISCGd1pHspa1C
	1cW71kGvtQpaSmx6p/EOHHR2+ExSaYCpj3kkFCAMKXzE34ngJhomOg==
X-Received: by 2002:a17:907:3f09:b0:ab2:f6e5:3f1 with SMTP id a640c23a62f3a-ab7daf31198mr53789466b.8.1739216715458;
        Mon, 10 Feb 2025 11:45:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFrs+omVoA5InHSI5b+I9wMwwSULuAuTHHS9tgGKk5Q3H8nhwHvO0O/ryPvBgmiLaperNlrlQ==
X-Received: by 2002:a17:907:3f09:b0:ab2:f6e5:3f1 with SMTP id a640c23a62f3a-ab7daf31198mr53787766b.8.1739216715077;
        Mon, 10 Feb 2025 11:45:15 -0800 (PST)
Received: from maszat.piliscsaba.szeredi.hu (84-236-3-29.pool.digikabel.hu. [84.236.3.29])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7922efbb7sm702006666b.2.2025.02.10.11.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 11:45:14 -0800 (PST)
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-unionfs@vger.kernel.org
Cc: Giuseppe Scrivano <gscrivan@redhat.com>,
	Amir Goldstein <amir73il@gmail.com>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/5] ovl: remove unused forward declaration
Date: Mon, 10 Feb 2025 20:45:06 +0100
Message-ID: <20250210194512.417339-2-mszeredi@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250210194512.417339-1-mszeredi@redhat.com>
References: <20250210194512.417339-1-mszeredi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Giuseppe Scrivano <gscrivan@redhat.com>

The ovl_get_verity_xattr() function was never added only its declaration.

Signed-off-by: Giuseppe Scrivano <gscrivan@redhat.com>
Fixes: 184996e92e86 ("ovl: Validate verity xattr when resolving lowerdata")
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/overlayfs/overlayfs.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 0021e2025020..be86d2ed71d6 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -540,8 +540,6 @@ int ovl_set_metacopy_xattr(struct ovl_fs *ofs, struct dentry *d,
 bool ovl_is_metacopy_dentry(struct dentry *dentry);
 char *ovl_get_redirect_xattr(struct ovl_fs *ofs, const struct path *path, int padding);
 int ovl_ensure_verity_loaded(struct path *path);
-int ovl_get_verity_xattr(struct ovl_fs *ofs, const struct path *path,
-			 u8 *digest_buf, int *buf_length);
 int ovl_validate_verity(struct ovl_fs *ofs,
 			struct path *metapath,
 			struct path *datapath);
-- 
2.48.1


