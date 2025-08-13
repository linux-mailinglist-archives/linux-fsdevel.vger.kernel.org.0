Return-Path: <linux-fsdevel+bounces-57728-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D65EFB24D14
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 17:18:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B5AC3A3780
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 15:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 798D42FE570;
	Wed, 13 Aug 2025 15:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ESxWolqu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564B02E54C3
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Aug 2025 15:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755097874; cv=none; b=Pvc7btT20lNcnXgKXH/CxOSMphjoZpgIRbMvChbqjpI3gQdsMIuuKF/Yn7mff0iu71ug517q2O5cuPT+WxR0D304LC3pboVE9CuS6UkhD13K3gcbC89JRwSVpmdQcfCpd2LiMVhv8kPrs18otovhbngfQX8RNf9uMrcWTRfdH/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755097874; c=relaxed/simple;
	bh=2ZFIVa8twcI7ToqfmZL40umYhQFdgOl6yRZ+QDVdjs4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HHBXCNb44x/2qVwLDEcy8zH6uSF2uvr2n8o7K1+jArzXfuFjXUJZV9/jVr7uq1KIuIT7TLwmbtdrMpuVPZkKzCRss2ZbZnaVw/3jX6GC4BB1kI83n0c0F7PY2SmSJQYZfnX12XlerZ2mZ05nVRMYpuZQOD2LDKEWZ+Qag0C6lAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ESxWolqu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755097872;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qcQDQ61lYJRH6LrmFdXQY4WYkrDuHUsnPo5PBD0oNE0=;
	b=ESxWolqufK1z7TuRFVdsPXjUdmXiVCwfS44buBq/9E1PE+8RLys4fXDzaFuEE2kxIukn5R
	U/ghvb0xWec3WQHxWAg7oX+7tw6dFde3ag6oN/7cM31zhevNdqmSFRN+n/o33qz6Ct4DBy
	XoyrAYEVDocO89g0yetfOKQWANSEdeE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-79-MMjsOpHvPrKa3uMUM1g_Vw-1; Wed, 13 Aug 2025 11:11:10 -0400
X-MC-Unique: MMjsOpHvPrKa3uMUM1g_Vw-1
X-Mimecast-MFC-AGG-ID: MMjsOpHvPrKa3uMUM1g_Vw_1755097869
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3b7886bfc16so4312760f8f.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Aug 2025 08:11:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755097869; x=1755702669;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qcQDQ61lYJRH6LrmFdXQY4WYkrDuHUsnPo5PBD0oNE0=;
        b=OMDIQ/y+oc0yV/7pu03isIyMEU9y8113M3GFhkRMIZytXCGp+dmph/dpt191aVkl1C
         R+k1cy+bcXGOhiDL4+uJPr3YMBjTYfMThlIWn7DtyMoCYRPr7TwGlKKW/Kwi6HxeXPmI
         gfhk/ydVvh1qcwGN7k1xXA4g51YfwjpYGqELiE+iimno6oH6f1kqQwYyzq2R4xJXJk9A
         CZc/jUsEZ8Pq5ST29rqHPh7nMhUBHjQ+JC9P/bql2af+5qDYH31J0dp/T6il+O85QlEo
         u1NvsWxMYWXePcHtRSFEViVTmHAg5qBDqU67ivj0Fh9uAyqbziI15ZjTNhaKQ/Dithn5
         jMZg==
X-Gm-Message-State: AOJu0YwqEK/cOMo0AkgokCp66slAMFVawFC/ENMo9s+4PfOXUVZ6vm3b
	COziN5U7iuoOI2zig94tMallfUdTHfpNwmtlHKWATSbawo+RfQuMqpHbFNRV7gYbXfplPUN5TXx
	gEnVqsUjmIPdRPjMIjb31/83vBrhOQAEedMQZCuaIZGdN/PzWqePf1oW8Rc1CAheJoGOIQTxQKT
	/NpE3jS6XeTxsy+d/dMTQiFMJcCIy7C/7bAPiMnEMNMUq8kIhAxAVs5A==
X-Gm-Gg: ASbGncvnTZCPQadoszcPfaaNAJ4yX15T5KMMEjxMyCUdIp6SGoLzMbZhF0TWpxfa+eh
	LL+Q1qA9xWodiHDPnNWZig3Qpmas3jbaLmls6Zi3HU4LU2IdX/VsYQQQ9S8MrrOuZFyYGAFAiXl
	3flcDg6I4FlOqTaHpAoK53yGLnFd9AHdnrrOufcUyXbW6G1+xwpJ8RHuvHuklI26rvb8AX+EsX8
	ogjKZmU6N9BWMEHBmRIkKLAonjDwWEZQVuoaurdmMkNh/fb8Kyjx1u7WBo5mpHsxidUhrGW3VlF
	3W2YbK99Qo7GpbeIKA2ApjQn+882xDQgIQcUlVIB6mnsmfJSSFAMdXzlVy6Kccrx+8ximBBM1Zq
	7FqsrvLl+uN2m
X-Received: by 2002:a5d:64e1:0:b0:3b8:d337:cc12 with SMTP id ffacd0b85a97d-3b917e458a1mr2844047f8f.22.1755097869198;
        Wed, 13 Aug 2025 08:11:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGliia7juhQ3V6lF/4lkvlzow9mZ7AvH0j8KkMCYVco4yvnntuEE7xuNL5gLwNh7jIukNabMA==
X-Received: by 2002:a5d:64e1:0:b0:3b8:d337:cc12 with SMTP id ffacd0b85a97d-3b917e458a1mr2844003f8f.22.1755097868623;
        Wed, 13 Aug 2025 08:11:08 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (94-21-53-46.pool.digikabel.hu. [94.21.53.46])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c489e81sm48559630f8f.68.2025.08.13.08.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 08:11:08 -0700 (PDT)
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: Bernd Schubert <bschubert@ddn.com>,
	Amir Goldstein <amir73il@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Florian Weimer <fweimer@redhat.com>
Subject: [PATCH v2] copy_file_range: limit size if in compat mode
Date: Wed, 13 Aug 2025 17:11:05 +0200
Message-ID: <20250813151107.99856-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the process runs in 32-bit compat mode, copy_file_range results can be
in the in-band error range.  In this case limit copy length to MAX_RW_COUNT
to prevent a signed overflow.

Reported-by: Florian Weimer <fweimer@redhat.com>
Closes: https://lore.kernel.org/all/lhuh5ynl8z5.fsf@oldenburg.str.redhat.com/
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
v2:
 - simplified logic (Amir)

 fs/read_write.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index c5b6265d984b..833bae068770 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1576,6 +1576,13 @@ ssize_t vfs_copy_file_range(struct file *file_in, loff_t pos_in,
 	if (len == 0)
 		return 0;
 
+	/*
+	 * Make sure return value doesn't overflow in 32bit compat mode.  Also
+	 * limit the size for all cases except when calling ->copy_file_range().
+	 */
+	if (splice || !file_out->f_op->copy_file_range || in_compat_syscall())
+		len = min_t(size_t, MAX_RW_COUNT, len);
+
 	file_start_write(file_out);
 
 	/*
@@ -1589,9 +1596,7 @@ ssize_t vfs_copy_file_range(struct file *file_in, loff_t pos_in,
 						      len, flags);
 	} else if (!splice && file_in->f_op->remap_file_range && samesb) {
 		ret = file_in->f_op->remap_file_range(file_in, pos_in,
-				file_out, pos_out,
-				min_t(loff_t, MAX_RW_COUNT, len),
-				REMAP_FILE_CAN_SHORTEN);
+				file_out, pos_out, len, REMAP_FILE_CAN_SHORTEN);
 		/* fallback to splice */
 		if (ret <= 0)
 			splice = true;
@@ -1624,8 +1629,7 @@ ssize_t vfs_copy_file_range(struct file *file_in, loff_t pos_in,
 	 * to splicing from input file, while file_start_write() is held on
 	 * the output file on a different sb.
 	 */
-	ret = do_splice_direct(file_in, &pos_in, file_out, &pos_out,
-			       min_t(size_t, len, MAX_RW_COUNT), 0);
+	ret = do_splice_direct(file_in, &pos_in, file_out, &pos_out, len, 0);
 done:
 	if (ret > 0) {
 		fsnotify_access(file_in);
-- 
2.49.0


