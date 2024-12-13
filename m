Return-Path: <linux-fsdevel+bounces-37382-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 214359F190A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 23:27:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D71EE164278
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 22:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C101E1EE7A5;
	Fri, 13 Dec 2024 22:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ieq/zqEi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECD01ADFF7
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2024 22:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734128592; cv=none; b=YyGZJM3B76jX/2CnMH4tg+lxg5fY39cyVaDBiB6pk6cVvc5jWPOIunUIOlSW8RcAT8grsuHYkGEGw8xeIh1JMS/OKz3ZJJRiz3YcErIcUX9uDLfa60GpK/+oK7WoP97rkBC4x6GkLoaCkfr+240FdAgEWr/rZXxoFi0D6t/N9R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734128592; c=relaxed/simple;
	bh=mk6rCrx59q7vBC5Vo888Mxa+Mr84iiyM0j9B/0t9j04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h89SUr/LpDbVInu+drMU2DpVllmE85rlXVGRTFRrIHqfaMV5R+EN5m1FfdBXwah9lofNxCs9KfBXC1SE6jGK+Va92LfoAGeNsacOc5c6Hont1Mq4+vd/CTGtLasgqQfMTh1vOkJJI9NOEr0o3Oox4Yr69PG710vlJSAT+mBpe3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ieq/zqEi; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6efeb120f4dso17700067b3.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2024 14:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734128590; x=1734733390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=feYkz8bm7s5B1BPB1BvqWGwK7+Xa4Julj9CPdiMmpt0=;
        b=Ieq/zqEiRzJqpXddfy+14PuZVQgPXToAi/7LjKARHcQ9Tmuhq2vlWnEoMJft3kmrGy
         suQjkwadjqG3hN5yEeYKDjpXrkItjut4r5xPI247zTTu1OqKss5GGd6G7J/eQtG/lbr3
         vpBW7o0pwJRA/S82eBakKBzspsX9LMogiR0qDG40YpI+5zyZsFYUwXwdipAwaV2e2fEd
         Ie2yE2vPv4N1Kj3CHg8ynlVIOTxGl1QBYTjx8sKyl/7ZjHxywC64K7zcVZk4tHBrU382
         hyiaKpUBVGh3KKNxrmzX+sCDeNGqGSD8y4gHUbb1M4LbO34hIibwNyZFBDnP4n6u08QU
         8D2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734128590; x=1734733390;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=feYkz8bm7s5B1BPB1BvqWGwK7+Xa4Julj9CPdiMmpt0=;
        b=gh74/5JAwEcCmo/MAJwUHZGxtKEWws/Ers1fLhQul5SEPlgbYYT9hg9Qs3mE3fspfv
         yiCizpNmcfhSC/lT4Sn8Mn2E/iy4lzLwvDSMyuCiNVnrSht2zJF76vhbBTquERUyHkN8
         lHWazoFD0845ETjqNEhi0si4t7/IxAuVuFdHhn5zc5QzOYjIt3CMhyFhleSEZhGvx+lL
         2mYNWMRYnheYqSHA4I7Mw8KgY+O2lXcMM9Y00/LMMG09xc8TVmY9OrgoqRgqNsyAitLh
         89B0OjolJz4stgjhuSHGFzqq862InwOfbfb1T2BPphtNWs7Ke7aZdZlI/tIwIb409+oN
         OmTg==
X-Forwarded-Encrypted: i=1; AJvYcCU4WiSmIbwiHkyRIehf9qd2OE3uc2IMulT5pfu7VXCFTWiqoUgCm4RmzZdiU1nWY+k85NbZXzg94jWlFGll@vger.kernel.org
X-Gm-Message-State: AOJu0YySKzhORQr+HJVtV2cu8oKbJ4X/dl1me5iH4ywoijgRtjvf2smg
	W6Yj4m0cs23fE61xREaC4DSI7YZZUzf9SV74Qeo+QScso0OwGI9+
X-Gm-Gg: ASbGnculbzoXJoz1RKaM6UOLtNhTUv0m/zy6A2EVMwabjnh7acvHF94FFw9IJ/QfwaJ
	N4rkJ2czYR92S0BWh15RgbsfsmC+dpm0sGtsvOoTuZqDzKSNKnGrvFMdatl7Js159g/iAQuv2l5
	Vs/G0811JfcIAQG0bKfSAM9HV3nTr8/0DKtuVnywXXTdAiEQ4QteI3T8sE3zWxRE0gVeKaRMTSE
	pioHU5hqQnINzCB+5NeBR1RJb509bT7as0WJHg8N/YeufFv59gocodJc/bmUHDsL4zR515bhjcO
	a3PZHsvp/wlj
X-Google-Smtp-Source: AGHT+IEMraPr7m+mgt4PJBsBxatnFSii2/ZbpnEXUgc6Lnzi1upSsrchAUrcxPELq8Y6VDWX7Yn6Qg==
X-Received: by 2002:a05:690c:4513:b0:6ef:5973:8273 with SMTP id 00721157ae682-6f279b88522mr43779617b3.34.1734128589690;
        Fri, 13 Dec 2024 14:23:09 -0800 (PST)
Received: from localhost (fwdproxy-nha-000.fbsv.net. [2a03:2880:25ff::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f288ff2ea9sm1230087b3.42.2024.12.13.14.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 14:23:09 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	willy@infradead.org,
	jefflexu@linux.alibaba.com,
	shakeel.butt@linux.dev,
	jlayton@kernel.org,
	kernel-team@meta.com
Subject: [PATCH v3 03/12] fuse: refactor fuse_fill_write_pages()
Date: Fri, 13 Dec 2024 14:18:09 -0800
Message-ID: <20241213221818.322371-4-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241213221818.322371-1-joannelkoong@gmail.com>
References: <20241213221818.322371-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor the logic in fuse_fill_write_pages() for copying out write
data. This will make the future change for supporting large folios for
writes easier. No functional changes.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/fuse/file.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 49cb9e84bd2e..c041bb328203 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1138,21 +1138,21 @@ static ssize_t fuse_fill_write_pages(struct fuse_io_args *ia,
 	struct fuse_args_pages *ap = &ia->ap;
 	struct fuse_conn *fc = get_fuse_conn(mapping->host);
 	unsigned offset = pos & (PAGE_SIZE - 1);
-	unsigned int nr_pages = 0;
 	size_t count = 0;
+	unsigned int num;
 	int err;
 
+	num = min(iov_iter_count(ii), fc->max_write);
+	num = min(num, max_pages << PAGE_SHIFT);
+
 	ap->args.in_pages = true;
 	ap->descs[0].offset = offset;
 
-	do {
+	while (num) {
 		size_t tmp;
 		struct folio *folio;
 		pgoff_t index = pos >> PAGE_SHIFT;
-		size_t bytes = min_t(size_t, PAGE_SIZE - offset,
-				     iov_iter_count(ii));
-
-		bytes = min_t(size_t, bytes, fc->max_write - count);
+		unsigned int bytes = min(PAGE_SIZE - offset, num);
 
  again:
 		err = -EFAULT;
@@ -1182,10 +1182,10 @@ static ssize_t fuse_fill_write_pages(struct fuse_io_args *ia,
 		ap->folios[ap->num_folios] = folio;
 		ap->descs[ap->num_folios].length = tmp;
 		ap->num_folios++;
-		nr_pages++;
 
 		count += tmp;
 		pos += tmp;
+		num -= tmp;
 		offset += tmp;
 		if (offset == PAGE_SIZE)
 			offset = 0;
@@ -1202,8 +1202,9 @@ static ssize_t fuse_fill_write_pages(struct fuse_io_args *ia,
 		}
 		if (!fc->big_writes)
 			break;
-	} while (iov_iter_count(ii) && count < fc->max_write &&
-		 nr_pages < max_pages && offset == 0);
+		if (offset != 0)
+			break;
+	}
 
 	return count > 0 ? count : err;
 }
-- 
2.43.5


