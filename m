Return-Path: <linux-fsdevel+bounces-29133-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2408975E7D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 03:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C1721F23325
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 01:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA3B2A1D3;
	Thu, 12 Sep 2024 01:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nmcfUz2y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DAC2209B;
	Thu, 12 Sep 2024 01:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726104481; cv=none; b=WLUBIXqeiNCgaotwr4oJxdeplUGy3FNixUTnBs0ACnon0erie4hJHqG2E24TDH9QdnWpKroFzOpuSVCJfeHdw/W31Lo3L13vj2DbDBfbYm3J4Htoxbz4W6hQl3HLl937N7Hz30d+DO9AylsHjeA7aCFqtpaumI3HwBfbD49g2Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726104481; c=relaxed/simple;
	bh=LnnSKYc2m+WkeoNBRLKr0nQho3GZx9CIG8/4QlzRX54=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Te7syyWUAthEiXsLkPdDivZhdVTXWcIt35uPseQgxaY+rNhW64OoyqBewncvoA1ZE0OobWwbHSUMv6lDEIO4wp+ag0LN4N0MST5Yslf8HaY+Np9V63Epvcw8kWprB5ATVQnDS3dl4QwVusWoH8RV/7C4BX9UIdi2vD1hOX0HVc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nmcfUz2y; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6c3603292abso3989336d6.1;
        Wed, 11 Sep 2024 18:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726104478; x=1726709278; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uxvlmWpHHF/4iIZjIKJfqtc9ShKcPmj8i6+oHT5mO60=;
        b=nmcfUz2y23jMqRdVFNpcZSrJHdmrHnAAyQv1p49zKER5iOEy2UcEbkv862cF79HP0k
         stNk1ihNaWR8UIbaSsVT7W7LBcg8zMh5dNXRWR1Eaqc1xqrwxSMmZaoXH2CSAQHmH5EW
         b2thabChP6HnSzQ+HEOKEKWfcNK1+Z0aE1rom/JPKdXWHPrWzhNEuK2CiEfit5OiQNIJ
         BBMiVM+ZMUi7TrJ4Mc8xblQ2kXi7mN2phI2DahXt9GwsDj8YM24ii6Vk7mDFu1f6Ce4H
         b0EmuG8eYna+4fHJUDWUnpCloLm3gfvHMce1o4GTk5HRP5hon2BPfuczRc6tBZfFVNpi
         KMKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726104478; x=1726709278;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uxvlmWpHHF/4iIZjIKJfqtc9ShKcPmj8i6+oHT5mO60=;
        b=nmmNwXHsUPbACDoPvcLAbaTd4LV/wNQliUdKCqzg5Mh5KM/E/6A4b2ZNG2btGvCx0v
         iutZ7EqTLs7oghiDRitE3WNJLSZlfP/v8RoZ9WvgyP/hmz/5iScYQpHgNQEjrawdpgFb
         RHSu5n74DuFfoZ3FypcMmjTbtk56BmPmNW0/ny8yg6bJgZHvPGaMks7/pNobqBGhuTQr
         prjjxiz5fkkkrcmHeWirr2wwIB7G2BBMCD83pDe90rPqBsf+hi3hU3DmeUoKIXKWMMxJ
         CCX6R+ipFhtyeYW6n0ZO1dbdi9VN4KNgJcKxURiij4QgBOmg6YMpZz0UQPJLf04jEuNV
         CtrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdjDSJ6iUmxK5lcxjWBlbshrnJnyDPVJBDZlIbtSGnHUwgKLnhKwkWsyv0dNGEBz6tWBrrSw2oXnd9d0cQ@vger.kernel.org, AJvYcCWZHGTjJzpwCzRoyHmx7cCKND/nYlfoEUpGbbWmem98GEih7qwbdD9dGD/O9H2Nh+IYyYXvvFxudk8=@vger.kernel.org, AJvYcCXI5Urq6tLB66SZOJkGZ8NY9wE4wkyKPYiI6bF2XBsg81Rp8tjCb0MO6KA1kX2Nevi7iAZAqbzMsJL8l5A/2Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzOJHim0S3QtIVuM5Ru0ZKyBQAO7uB97RPS9vAs5x8I3uOJBrai
	3QlnYOT0Y0M/g4phr5+grcT6Fq1KB4JPI9/YZbiJcdb9JZKzlliX
X-Google-Smtp-Source: AGHT+IHoHzzjeziPJcHDiK8w5Pq233wdQWa6xsGvXYWmafUPotT+cxLFnpSKH97ZV6G/H/HsYTfEUA==
X-Received: by 2002:a05:6214:469a:b0:6b7:4712:c878 with SMTP id 6a1803df08f44-6c573582536mr19814406d6.41.1726104478357;
        Wed, 11 Sep 2024 18:27:58 -0700 (PDT)
Received: from localhost.localdomain (d24-150-189-55.home.cgocable.net. [24.150.189.55])
        by smtp.googlemail.com with ESMTPSA id 6a1803df08f44-6c53474d8e2sm47898186d6.87.2024.09.11.18.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 18:27:58 -0700 (PDT)
From: Dennis Lam <dennis.lamerice@gmail.com>
To: dhowells@redhat.com,
	jlayton@kernel.org,
	corbet@lwn.net
Cc: netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dennis Lam <dennis.lamerice@gmail.com>
Subject: [PATCH] docs: filesystems: corrected grammar of netfs page
Date: Wed, 11 Sep 2024 21:25:51 -0400
Message-ID: <20240912012550.13748-2-dennis.lamerice@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixed the word "aren't" to "isn't" based on singular word "bufferage".

Signed-off-by: Dennis Lam <dennis.lamerice@gmail.com>
---
 Documentation/filesystems/netfs_library.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/filesystems/netfs_library.rst b/Documentation/filesystems/netfs_library.rst
index 4cc657d743f7..f0d2cb257bb8 100644
--- a/Documentation/filesystems/netfs_library.rst
+++ b/Documentation/filesystems/netfs_library.rst
@@ -116,7 +116,7 @@ The following services are provided:
  * Handle local caching, allowing cached data and server-read data to be
    interleaved for a single request.
 
- * Handle clearing of bufferage that aren't on the server.
+ * Handle clearing of bufferage that isn't on the server.
 
  * Handle retrying of reads that failed, switching reads from the cache to the
    server as necessary.
-- 
2.46.0


