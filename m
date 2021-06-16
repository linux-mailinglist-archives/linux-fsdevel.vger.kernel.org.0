Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBD7A3AA196
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jun 2021 18:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbhFPQm5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Jun 2021 12:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbhFPQmz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Jun 2021 12:42:55 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AB87C0617AE
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Jun 2021 09:40:48 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id i34so2440192pgl.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Jun 2021 09:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZbeP6cm14CZUAAE88Br6wxap9iGbpSZd/EkXccR0A3U=;
        b=bnktMkJeEMXaq2naBXQHHiPU9Nqu8YkQpUHyvp9e4ZqX1uHSnZ//7SWNXqUK8RVZlo
         MKblS1DawG8i0m4NFZwI88IgtFu737O+iLXY/3rBDEdGotZ20KiE6ydO7YdIYhh5OLaK
         GxQd2fJKgIpqWyi2tKPWBnNYkZlfjadHowhEY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZbeP6cm14CZUAAE88Br6wxap9iGbpSZd/EkXccR0A3U=;
        b=ufDAl2Rdsj1SVNDs//fUpgX2S4izG5QiF5Pz5qpz5MeP2WGyRWkuodd4Gq5fsbpwd+
         8BQhw2/dn47jjMGvetup7mY57m46yqnO2a89UdqAtUHOtBWep3wtZoJYNpDDPdY0V623
         vrAWRqzWki+FU0AIwOQg9FA4WHRpgjageoeme0OtYpjoPoxgwJ7UYY6+3Kw1qiEU7BJu
         9WVlBCS56rO1GCYI1HNfGv4G6xnbOHMOJePYHGfZTuBNaujKgtHhA68jKhSh6xdxlIFU
         E+qFO986VXxbvFH5Hz17iQmk67NHr6jp56EsGuDJ0Nz9Cj1Y7V5lMyrVexcitiovlAjf
         ct5A==
X-Gm-Message-State: AOAM531+F+AY6FwWhTAkQpGeLXgyy+BCmcYbPRFboy0IR/FvkgNNMfvK
        ezjU4SJZ8eI2rBvaUPIrJ/SoVA==
X-Google-Smtp-Source: ABdhPJyoO9kfQlkov8l5Uxc1pFtGZKisJjo0wbmfUm+U2ZAPtFP25C9NSbVOCG4UMmZIEZmP/R5SqQ==
X-Received: by 2002:a62:e102:0:b029:2e9:fc9f:1199 with SMTP id q2-20020a62e1020000b02902e9fc9f1199mr574719pfh.33.1623861647624;
        Wed, 16 Jun 2021 09:40:47 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u23sm3285017pgk.38.2021.06.16.09.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 09:40:46 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>, Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>, gmpy.liaowx@gmail.com,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-doc@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 2/5] pstore/blk: Move verify_size() macro out of function
Date:   Wed, 16 Jun 2021 09:40:40 -0700
Message-Id: <20210616164043.1221861-3-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210616164043.1221861-1-keescook@chromium.org>
References: <20210616164043.1221861-1-keescook@chromium.org>
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; g=2653a11ba7eb96c6cd268cbd6402b18f7e12a7e7; i=tdzQEUdv9hbSbxK6tngoJDCwzHdNjm/mAUD5mY/vv0A=; m=nTfn6wzbaP76t31hQfkeekCpmWlwPPU/REYfq9FPMqk=; p=Fkn949fV8jhBHEnW9OWz/kDi3+x9elYT1NBMFnskfo8=
X-Patch-Sig: m=pgp; i=keescook@chromium.org; s=0x0x8972F4DFDC6DC026; b=iQIzBAABCgAdFiEEpcP2jyKd1g9yPm4TiXL039xtwCYFAmDKKYkACgkQiXL039xtwCaNfQ//boE CcbVOKKdTErDuY+Q1oZgZCVMTLGpgfxWvFwMHLm8JG62YgnCM4UcRTaSri2g5rdP5aDylHS8Drftp gEelBGBUllciu6qRaKpKqwmCb+UB8HXEilK/hYzvt6u1GbezR6wzymXXYqT7+1ZODwfVPllpATV4I aIHs7Vf/pujpeOeBC386D+i3AOhJtIBmaschpq1MKNZn86MhA3+yqTL4g0RVC8+Ckm2yKeYNz5veV M9L/Z4OngJDUmmoyPY7SeeqgyPy1meyfPKnoSuzYphJcZEiFwGeVxl6nV6EaaqEaf3y3An8PILvQ3 R34qDfPazTH+AZFr+xPumv5JwIn9rUyDzAToJMCS5Ypk+xuaZ2loAQheXgMHbjw6eWDVdZN1usoB3 2NvJ9iahs+UGZLZE0jLaOv24fm8/MQMtp7qQTA7KrOcLnJECuQhBYyepQAy4Ov/ajbLPVXSI8pxZd G6qyB/dUYs07g22BU/as0XBt3iV1L5t9tM8fERcEzRo+WXu6J7yRWXyj56Dbxxq+pW1sUuVRZnR22 kIUQUTvmyQLFWoy/mbQFNysVTnf8kaBLIPwiJpKYG3KeJ5qgEh07sBvoCYAzmVK2tntraw0xGxc16 geVilcpUOr4MyH8UpGhSqsRZj3BOsEJWJSZ6jKAlU8MPEQOgtP9l9+KTIIaIg6as=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There's no good reason for the verify_size macro to live inside the
function. Move it up with the check_size() macro and fix indenting.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/pstore/blk.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/fs/pstore/blk.c b/fs/pstore/blk.c
index eca83820fb5d..7d8e5a1ddd5b 100644
--- a/fs/pstore/blk.c
+++ b/fs/pstore/blk.c
@@ -108,6 +108,17 @@ struct bdev_info {
 	_##name_;						\
 })
 
+#define verify_size(name, alignsize, enabled) {			\
+	long _##name_;						\
+	if (enabled)						\
+		_##name_ = check_size(name, alignsize);		\
+	else							\
+		_##name_ = 0;					\
+	/* Synchronize module parameters with resuls. */	\
+	name = _##name_ / 1024;					\
+	pstore_zone_info->name = _##name_;			\
+}
+
 static int __register_pstore_device(struct pstore_device_info *dev)
 {
 	int ret;
@@ -143,21 +154,10 @@ static int __register_pstore_device(struct pstore_device_info *dev)
 	if (!dev->flags)
 		dev->flags = UINT_MAX;
 
-#define verify_size(name, alignsize, enabled) {				\
-		long _##name_;						\
-		if (enabled)						\
-			_##name_ = check_size(name, alignsize);		\
-		else							\
-			_##name_ = 0;					\
-		name = _##name_ / 1024;					\
-		pstore_zone_info->name = _##name_;			\
-	}
-
 	verify_size(kmsg_size, 4096, dev->flags & PSTORE_FLAGS_DMESG);
 	verify_size(pmsg_size, 4096, dev->flags & PSTORE_FLAGS_PMSG);
 	verify_size(console_size, 4096, dev->flags & PSTORE_FLAGS_CONSOLE);
 	verify_size(ftrace_size, 4096, dev->flags & PSTORE_FLAGS_FTRACE);
-#undef verify_size
 
 	pstore_zone_info->total_size = dev->total_size;
 	pstore_zone_info->max_reason = max_reason;
-- 
2.25.1

