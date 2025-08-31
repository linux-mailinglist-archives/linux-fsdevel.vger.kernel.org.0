Return-Path: <linux-fsdevel+bounces-59720-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85368B3D480
	for <lists+linux-fsdevel@lfdr.de>; Sun, 31 Aug 2025 18:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40F353B9B27
	for <lists+linux-fsdevel@lfdr.de>; Sun, 31 Aug 2025 16:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 331A5270575;
	Sun, 31 Aug 2025 16:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JywhYH0L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7871EEDE;
	Sun, 31 Aug 2025 16:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756659193; cv=none; b=iTPI2c5FuDwh0R3/WI80tYlsY6HTF43logq9kMSCf4DSLmwhW3g0LwE1/UxBhrvupHE3PxPYjtzbVqmASpcU0nyv8uiQO9sCh5zgQicH80Ot0IoD+TAbIa8h1TLcg5TkEHKWPKYVpYS/fAIhuGTFDWAH8ZRUmxT/d0ae+rnAdnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756659193; c=relaxed/simple;
	bh=vdgXQRWdEqGlHhCQC5Cy1C6PSMXprMo/vMvVIuQOFkA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SdIHCmEvKgiWsg4MSbmu0kITyEsgBm8dY55qK5H/sF/1S4NgdDwNmrffJYGyvCSGb81UvbN4m6uDu8L8g4iWu678MDb5qr5XZ3L9yLGOcTyBhBF8+LpPL6yyuqiZbFQTazNVqLibrP8pMK1vNGhM8Jd3G90MHb5Zyti3zog9YPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JywhYH0L; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-45b87a13242so7956715e9.0;
        Sun, 31 Aug 2025 09:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756659190; x=1757263990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4wO/zcVnjHVcWBSI/bA+qHfM2i/RTTRPucRX1zIL1fo=;
        b=JywhYH0LI0qmd1/wPKmO0Np6/LoDWqfhzn8w3Qd/y58D1znSZsny9sVvoeMvpQO6ML
         JV/zTeQAH1W/d3/pq/EQGXq4nKpvuqO+qVI4t6cP7hc/e7pbynOyVnc/cI6yG3vHdWBZ
         lRJAmPKpPlLge+lyu5Zrn74QQTVQI+1Umm/9AUMEClXz858ktyyYA57SDH1jMBArM4gO
         XZ57tdif+VNqagvyLOLCuh5YAMpT0r03slellC7wN3YW3vb8r6y2j7aJ6Tne3sRSKZa2
         LanUMwy7rQLOQJ4cWR3jZyWjwys1odie0u9A7rw+NcWZhc2PiRy2hzVEe67E9lAWgdUv
         Udpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756659190; x=1757263990;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4wO/zcVnjHVcWBSI/bA+qHfM2i/RTTRPucRX1zIL1fo=;
        b=InhuQXsH1hCReBElJI1M8CbqY6jmV1hMwTPC6ZQO9jqPQUiuth+YcmoeiUlXTZbvcQ
         aLJDDEoOuMVI2CsCDUezO93fXdjeNOO9e1jowGuJCzHiPCTK8mpLemDGeiF4plM4e6XR
         2El2lLL0Ku6SCDu+C/pgDnx6rKS8B+hG6RUll4D7AQoZ+Rg8vYvDYuKdlGPXhSAk6HNr
         36vIyZF0SP9h9X0eSa6owvpgkCNGiHAWD1XpVZRDJgne7PtkBJK+kOQRNXEx+zL9TluN
         BaYTEhWkhrxEwIU0c9KF1seDVW8CPSk95Ic+X6uYsjmRt8IiWjQdYDcgGpoxLoHhXV1r
         FSsA==
X-Forwarded-Encrypted: i=1; AJvYcCXdyoW/Fi0p+facZZi/cqnWu9klkSETW7yyLXganMz2V20tjFa+1898R8gfhXeSju7Cf4VdspCI2sbE2f6Q@vger.kernel.org
X-Gm-Message-State: AOJu0YwLloQV4lg32znMrcYN38xejHCT30WORne/RFRIIgIVcTH8fpCj
	KuwVQ4yA5wZkeYyfX6wqCC85YDW3hTZB4OYd8Aknrhwj7p1/Wh7Ssv0MLAotOUd2
X-Gm-Gg: ASbGncuGCiThiQTv7GzPPgkH1XKxx3hfhz2bqtusiMh2Rq0ZYJRQvfeejxfoYKGVlNi
	3+WnrbnNDl35hCrbPXRrUSQ1S4hsmI3AWw2MCZrfzkAmxhGA/0ISy0plApZ0Qd1CeVcQRQsCCPl
	1m4OALqYeZofYRrFcwRqpWODQxFY4M4NA+bGRevlVp6o1JPmmb+2EvXZiqWLCOsr6PlVKLDGz9K
	kxMNi7K4Ki0v0KbTJxndPVZvqYWrlz1gVxK+45PtO4gfr5cJ+gMiYjzhQ8HEi51Q2zs6jcD+NE9
	EsYuiiyQiaMYwL4Cbdqx1EtdOh5L/gcLXbKlFYXfKzzFck+Iz+qV1kDxGosjXQoOT7u3yfKOs54
	28ZULX/ahSy8JviPg9nyBA6SlQqKZRH44tQ==
X-Google-Smtp-Source: AGHT+IGFjev2snd4S9w2ey4FWwKVjSGj830DbgRtoZ16pJGqTBHzAjC/9jhGmMoMrfPxZJuR/PwEBg==
X-Received: by 2002:a5d:5f55:0:b0:3c0:3fcb:ed77 with SMTP id ffacd0b85a97d-3d1dea8dd85mr3504290f8f.47.1756659189935;
        Sun, 31 Aug 2025 09:53:09 -0700 (PDT)
Received: from laptop.. ([2a01:e11:2026:c380:9ae0:723f:673b:3552])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3cf270fbd01sm11939066f8f.13.2025.08.31.09.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Aug 2025 09:53:09 -0700 (PDT)
From: Mattia Massarenti <mattiamassarenti.mm@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Mattia Massarenti <mattiamassarenti.mm@gmail.com>
Subject: [PATCH] add documentation for function parameter
Date: Sun, 31 Aug 2025 18:53:04 +0200
Message-ID: <20250831165304.18435-1-mattiamassarenti.mm@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add documentation for parameter 'name' in function 'name_contains_dotdot'

Signed-off-by: Mattia Massarenti <mattiamassarenti.mm@gmail.com>
---
 1                  |  3 +++
 doc.log            | 27 +++++++++++++++++++++++++++
 include/linux/fs.h |  1 +
 3 files changed, 31 insertions(+)
 create mode 100644 1
 create mode 100644 doc.log

diff --git a/1 b/1
new file mode 100644
index 000000000000..9e2cb3b10423
--- /dev/null
+++ b/1
@@ -0,0 +1,3 @@
+Command 'make' not found, but can be installed with:
+sudo apt install make        # version 4.3-4.1build1, or
+sudo apt install make-guile  # version 4.3-4.1build1
diff --git a/doc.log b/doc.log
new file mode 100644
index 000000000000..5af85cbcc86b
--- /dev/null
+++ b/doc.log
@@ -0,0 +1,27 @@
+  PARSE   include/uapi/linux/dvb/ca.h
+  PARSE   include/uapi/linux/dvb/dmx.h
+  PARSE   include/uapi/linux/dvb/frontend.h
+  PARSE   include/uapi/linux/dvb/net.h
+  PARSE   include/uapi/linux/videodev2.h
+  PARSE   include/uapi/linux/media.h
+  PARSE   include/uapi/linux/cec.h
+  PARSE   include/uapi/linux/lirc.h
+Using alabaster theme
+WARNING: dot(1) not found, for better output quality install graphviz from https://www.graphviz.org
+Using Python kernel-doc
+WARNING: ./include/linux/fs.h:3287 function parameter 'name' not described in 'name_contains_dotdot'
+WARNING: ./drivers/gpu/drm/amd/display/dc/dc.h:254 struct member 'num_rmcm_3dluts' not described in 'mpc_color_caps'
+/home/mattia/kernels/linux/Documentation/gpu/drm-kms:360: ./drivers/gpu/drm/drm_fourcc.c:397: WARNING: Duplicate C declaration, also defined at gpu/drm-kms:35.
+Declaration is '.. c:function:: const struct drm_format_info * drm_format_info (u32 format)'. [duplicate_declaration.c]
+/home/mattia/kernels/linux/Documentation/gpu/drm-kms:476: ./drivers/gpu/drm/drm_modeset_lock.c:377: WARNING: Duplicate C declaration, also defined at gpu/drm-kms:48.
+Declaration is '.. c:function:: int drm_modeset_lock (struct drm_modeset_lock *lock, struct drm_modeset_acquire_ctx *ctx)'. [duplicate_declaration.c]
+/home/mattia/kernels/linux/Documentation/gpu/drm-mm:506: ./drivers/gpu/drm/drm_gpuvm.c:2446: ERROR: Unexpected indentation. [docutils]
+/home/mattia/kernels/linux/Documentation/gpu/drm-mm:506: ./drivers/gpu/drm/drm_gpuvm.c:2448: WARNING: Block quote ends without a blank line; unexpected unindent. [docutils]
+/home/mattia/kernels/linux/Documentation/gpu/drm-mm:506: ./drivers/gpu/drm/drm_gpuvm.c:2452: WARNING: Definition list ends without a blank line; unexpected unindent. [docutils]
+/home/mattia/kernels/linux/Documentation/gpu/drm-mm:506: ./drivers/gpu/drm/drm_gpuvm.c:2453: WARNING: Definition list ends without a blank line; unexpected unindent. [docutils]
+/home/mattia/kernels/linux/Documentation/gpu/drm-mm:506: ./drivers/gpu/drm/drm_gpuvm.c:2457: ERROR: Unexpected indentation. [docutils]
+/home/mattia/kernels/linux/Documentation/gpu/drm-mm:506: ./drivers/gpu/drm/drm_gpuvm.c:2458: WARNING: Definition list ends without a blank line; unexpected unindent. [docutils]
+/home/mattia/kernels/linux/Documentation/gpu/drm-mm:506: ./drivers/gpu/drm/drm_gpuvm.c:2459: WARNING: Definition list ends without a blank line; unexpected unindent. [docutils]
+/home/mattia/kernels/linux/Documentation/gpu/drm-mm:506: ./drivers/gpu/drm/drm_gpuvm.c:2460: WARNING: Definition list ends without a blank line; unexpected unindent. [docutils]
+/home/mattia/kernels/linux/Documentation/gpu/drm-uapi:574: ./drivers/gpu/drm/drm_ioctl.c:915: WARNING: Duplicate C declaration, also defined at gpu/drm-uapi:69.
+Declaration is '.. c:function:: bool drm_ioctl_flags (unsigned int nr, unsigned int *flags)'. [duplicate_declaration.c]
diff --git a/include/linux/fs.h b/include/linux/fs.h
index d7ab4f96d705..a8272ca3306f 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3281,6 +3281,7 @@ static inline bool is_dot_dotdot(const char *name, size_t len)
 
 /**
  * name_contains_dotdot - check if a file name contains ".." path components
+ * @name: file name to check
  *
  * Search for ".." surrounded by either '/' or start/end of string.
  */
-- 
2.43.0


