Return-Path: <linux-fsdevel+bounces-53830-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D7EAF80A4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 20:52:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB5524E6106
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 18:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D032F50AD;
	Thu,  3 Jul 2025 18:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EyMzbUpe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4642F271A;
	Thu,  3 Jul 2025 18:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751568662; cv=none; b=mBiyGVhoqJA7m3TqYl6/qh8p16YJWzKS6Mo+HowCJ4OTELFtZ3dhl6biUbp0VWZuFkTIweAoo8031YzAVmPJp4UVrqhJnQDYDwAgijd/NPeAo/5irgetK6+eslXoEpfgqLJO5Xla/cofJ07WCsNXXZD7jP/PJEPvOiBq32+NYdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751568662; c=relaxed/simple;
	bh=i2RCOjAti+UF5LQ1PHdINLhvfnaWKUaVeHHuyTJYyzc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SlND5VbbWuGOyiX2UNyG9hLU0NtTCJmApwOdipa+unUtwZwky4nTRwJ4Pmrnj4Hm6iK8Hifo1lNMVXzCIDJfsfuTUSrCVpwC//YzCmnMNTh9joIwwQj5cyx2S+pN4B4l3RSAczuh66znWsxfn7iJlA2fIziwVE6pL7BT6CuGIiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EyMzbUpe; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-2ea58f008e9so278691fac.0;
        Thu, 03 Jul 2025 11:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751568660; x=1752173460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s2xZpjaui5XzSxxh0Gj0eCk++fJOkriDnBX6FJshI1g=;
        b=EyMzbUpeuNlVa0TWNpunez4Re03nlVbjXKe/0CzftYiPEF4ZDyD2t8OyUKPfXzgORD
         vQ6wxJT8T7Ci399Ss+hPFFuT9YDrpaRuRVRggCrfF/sfLPMf8QiU9XLekZAMRJoRaJnW
         kZz7riQ9JTuv9qBxCTQgfdgBQBA8Hd79Jg2bDVjsPXjdxsE25mPTgBeELG5mFvxOAp7c
         iXEKaG1f+VS5SYzvm+q4rZ7SPI2QHrzrkLtitSNR1f9mRH6oqD1BradSnQgiyrFCEI+G
         I1WbkRDLuio8yxMRPs6XaVPwKCeYKHasEVJ5nOWA3Ck4nmdy7J2jeCVHikjKOeyJtmAS
         L9GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751568660; x=1752173460;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s2xZpjaui5XzSxxh0Gj0eCk++fJOkriDnBX6FJshI1g=;
        b=AxBApliwSIAkwNpYGFTmULck+nKW4OPppvjQnA/nMWl84uNGIJ2q8zVQbuz+BV+9YQ
         6fz6vfdgm0lILT/Ei1f0kf9AiWq8ho5+0lXbUcOvRp9zR7TEunvtrWJ4iB10ssWbsUAx
         yP8W7P1062zOA3+C9S0fS/jDfJLF1ppNAX3OKAj5FeavMAA4HnG2hu5QZfiekLqCtl1D
         9REcGcJ2OTLLDRGL52Ao70tUVPkXXg/AZYHCN6lIDvErxPKoPyNy2Caj3TDVugW/ca+A
         WCG3px7aLvhZ8dU9IDUZFvTFJ7ibiCB5q1w6mgcLj4TPg1lLUR5lKO8h8L92lplyFQio
         xSKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEywq2IuB0c3tF/FNNQR+uyArQX5WmjSdKh12lJhS+yXGuHwLxdk0pHTEPa3uEHPy+oRY46Dz7MHQ=@vger.kernel.org, AJvYcCV1TJZ3x1dvAboRKOsPZ4XHsaZrjluEFHG2jn3xRXC//TnGYOcqNrGrbIovrg7klNiUDsa7t1e3V4jSfpYc@vger.kernel.org, AJvYcCWK3WY+2cEPGj0pTEPWGk1o00hdOkVzLRliQ57d7e2GV0ZCy4bYc8HvA6KpHUpaZzzrX7aYZFIKtCLY@vger.kernel.org, AJvYcCXbrV2dRGLJfMEO/cmM0sz8lcsbyzumNDrnj1yWVaNq2r2UVJYCVfCrjADNsm4CYdEccqqN/wxPEnpbNuDwXw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzSjW25+P0OM9C3P8CiutWYvbwTayr1Ep4SUL+Jued7c7S2Hd4f
	83zZhaBtyyfyUGbXIKO5JK4rC+Nfmrh/Q6vD6UX8G0wlcKNGgrZ2Ruaa
X-Gm-Gg: ASbGncuU71kWIOKi5z9u/bF8f2hWxkN6ln4r0cYEOaZFDfXXGBOr7sRgpKrvg5+vL0Q
	140mT4YQAmEzzVgAToT2exApFuRdGQFRMFkO8/KNNH0eYfH6q3IZudtkTsEBIE7WtoyxwLdqXTu
	4CRtxxo8G4BSMvUzLzWP07u7uNqgBvrduGdENcuisR0LRw+ZHraHVrLisgLRdhiMzv8oNoNSKmM
	0WvNSwLDoOWs2pBfLPsOOys7Fgsd3jdb4+057BptQB1XdSovtHojaBg9xyoN3YZzq1Z259hDg5s
	JddbgjY56SkzHj1/l9MI9LeCftOFdji7lsUFJXhthTUZmSFAFQZCgrzPH72i0eecph/NpgP7WNt
	A0j1Hk3eusEG6hQ==
X-Google-Smtp-Source: AGHT+IFWojQvKP3cIpPU0Ex4gOP0RyReOaJ9oJ//8+DQ1D2UxOY6HF2XKVzeow4Q9s0j3FT7ZnZiXw==
X-Received: by 2002:a05:6870:b201:b0:2f3:e087:6b08 with SMTP id 586e51a60fabf-2f5a8b9022bmr6076525fac.24.1751568659637;
        Thu, 03 Jul 2025 11:50:59 -0700 (PDT)
Received: from localhost.localdomain ([2603:8080:1500:3d89:cd4:2776:8c4a:3597])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73c9f90d1ccsm68195a34.44.2025.07.03.11.50.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 03 Jul 2025 11:50:59 -0700 (PDT)
Sender: John Groves <grovesaustin@gmail.com>
From: John Groves <John@Groves.net>
X-Google-Original-From: John Groves <john@groves.net>
To: John Groves <John@Groves.net>,
	Dan Williams <dan.j.williams@intel.com>,
	Miklos Szeredi <miklos@szeredb.hu>,
	Bernd Schubert <bschubert@ddn.com>
Cc: John Groves <jgroves@micron.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jeff Layton <jlayton@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Amir Goldstein <amir73il@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Stefan Hajnoczi <shajnocz@redhat.com>,
	Joanne Koong <joannelkoong@gmail.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Aravind Ramesh <arramesh@micron.com>,
	Ajay Joshi <ajayjoshi@micron.com>,
	John Groves <john@groves.net>
Subject: [RFC V2 07/18] famfs_fuse: magic.h: Add famfs magic numbers
Date: Thu,  3 Jul 2025 13:50:21 -0500
Message-Id: <20250703185032.46568-8-john@groves.net>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250703185032.46568-1-john@groves.net>
References: <20250703185032.46568-1-john@groves.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Famfs distinguishes between its on-media and in-memory superblocks

Signed-off-by: John Groves <john@groves.net>
---
 include/uapi/linux/magic.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/uapi/linux/magic.h b/include/uapi/linux/magic.h
index bb575f3ab45e..ee497665d8d7 100644
--- a/include/uapi/linux/magic.h
+++ b/include/uapi/linux/magic.h
@@ -38,6 +38,8 @@
 #define OVERLAYFS_SUPER_MAGIC	0x794c7630
 #define FUSE_SUPER_MAGIC	0x65735546
 #define BCACHEFS_SUPER_MAGIC	0xca451a4e
+#define FAMFS_SUPER_MAGIC	0x87b282ff
+#define FAMFS_STATFS_MAGIC      0x87b282fd
 
 #define MINIX_SUPER_MAGIC	0x137F		/* minix v1 fs, 14 char names */
 #define MINIX_SUPER_MAGIC2	0x138F		/* minix v1 fs, 30 char names */
-- 
2.49.0


