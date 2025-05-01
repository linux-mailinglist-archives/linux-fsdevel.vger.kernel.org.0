Return-Path: <linux-fsdevel+bounces-47806-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA784AA5A3F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 06:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B63567B70FF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 04:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A8D22E3F9;
	Thu,  1 May 2025 04:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EqOCDE8i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954991E5718;
	Thu,  1 May 2025 04:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746073068; cv=none; b=mlR25uhy56z5TkWzLa0dVV7ceR0jzSiBtuPiP3fdnTN5+eceVNqLRzIk7jCyOvF3YNirSnrBxv7IbwIabhP2TKuTddQtkv8wicvGtE1PYYMiJE1tY5L4fR8SKoRGNh6nG8Q1pBiuEo0mQ/ZyWTA4QRyRLdpGAhgKrcCGVIBweWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746073068; c=relaxed/simple;
	bh=w6ykFKU6W8XbzySYo6UA6ZzlGN8WlCDHXAPwnIpqbJ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GfxbWi+skbJ02uJxUb1DgMPS8wK9hXUs7MQDS3jKhxZ3DqKp3y78mNacwr3+uR81RZTEC7sGeH6F/SuXOcKlUO6jeyysTbqk9F+/nahg0RGkU4u2aOdcHdt8PKImUzn52BImebgAjj93O/6Cza73LGzKsxbb90/t/hJpAQBRLzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EqOCDE8i; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-73bf5aa95e7so539217b3a.1;
        Wed, 30 Apr 2025 21:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746073066; x=1746677866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n21bC37JtSPMbsSu3t2OsrA8QyyqY/ViIMbItOPfpIM=;
        b=EqOCDE8inQ0tL8XtUkzsJm/Epnkx+RNDphy2dkBrhInRsH9jEaGHYa2S16OfWCfHIp
         oUSHikw2R6eD1qJOFmezFzTsib2e2xc5KqjaYarnh8TrkPt7rtTBTC9hWfKKqZmmVJOk
         sMPDCA0gBuBuKCzjrCEBKtJD0tychpfDVLI08ZlSN+V/+JPyrYqiQDKR8UWfa03uxmMG
         jClOmIRkGI8a5cY4+vbxTq6SRC5D5dkW/Pe+uAgGowscUoUPtGQwcFPyDFzr1z1M9dsF
         yoOWCFPohhc5tvd2VY0dL7oKFphtbMGVxh04+anGthYiTUID/EcF95gkykaos/UbNypO
         9HjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746073066; x=1746677866;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n21bC37JtSPMbsSu3t2OsrA8QyyqY/ViIMbItOPfpIM=;
        b=AdrorPCm5888eFk4mqkWEhZBJ5DFYqjydsE2iD1UFWcTzGljvZnNw9zKOjjkAa4pF8
         C11BDqpeMl5Kcj9ouLgmL+nY9PDuxP23grokm41aOPP8CP9Rml9F/pZOjBdnOlNTMlvF
         qEsx0vcu7cmQ2Q3ssD/r7tKjiTpwnWIQSXGteZFo/C53/RSX2bfkp3gr4wJwXUuGHUBz
         uh7l/Gpu/dj9qMi46ush0SMu64rC/F/in+LzgJEKzJ2LInU7B1AZDre1Of4dr+zSV1JD
         VR5fB7QLWQy1JxirulOIISYvV35LcNfgCSusUIaL6uC1jSfVZI9ofeYwKO2u+Fkxsg7O
         SL1g==
X-Forwarded-Encrypted: i=1; AJvYcCUhSDHxPe62i8ZW0xwkat7PHBBRiMphqCsf397aVl8isap/FcQ0qyyd4WVL+IjRM8UpvbLNRdwBP21yRL+W@vger.kernel.org, AJvYcCVj9eCvrzPdJU5WCYc5KXgbZpjEyeT5SnBcZ/Xd7tOjlc/8rW8z+7scHjR70t8TFVMjMogabJD5wQtQelSv@vger.kernel.org
X-Gm-Message-State: AOJu0YzEE/3030pHf+/pIt2BWpcfCB3hw5/7PWDStSt7yWeoM+F9NyHU
	gjTvFzFj0nFo1ajXFdWD2CUGS0P5b2dOI7c8OffvLSasEyXmWaOa
X-Gm-Gg: ASbGncv+stxruc+OufliW9XRYLhjusj191jPn4hzAlGCCj0rxpydTHc9eGw/kIDRRyD
	+uDU7djyrUt9GdbKkiaJpHlzD5ngtWVbyCHk4e50D2Ew4GYy04jG5WRBEMEffMQP9doiO9/F54H
	wx4i1c5UZv78wJUR76ilCFOdXpz1jBEiGOYDxmFXZIHfLojT8g1tFWYH/rLGvfSomW6jko/wuzS
	B4kJ4ZAf02u+aTqbAi9YncO6thzc+KQ7yJMLQryiq2HgRTC5GM716jBy7uGtNnoWrux41/9WGle
	V68Uv7DlZTygb6mZ/fH+L2U/D17qQ0mpuc+uhNObbMwEV5K9nE7UMw==
X-Google-Smtp-Source: AGHT+IHDSecc++JnN9ZF7KiUO77n8h6r+gRK/5dMIMB4VhSxeBrb8DmzphALPYOnOFOCgood6UnY4A==
X-Received: by 2002:a05:6a00:22c9:b0:736:4ebd:e5a with SMTP id d2e1a72fcca58-740492701c0mr1701661b3a.20.1746073065721;
        Wed, 30 Apr 2025 21:17:45 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-740398fa1e7sm2585506b3a.5.2025.04.30.21.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 21:17:45 -0700 (PDT)
From: xu.xin.sc@gmail.com
X-Google-Original-From: xu.xin16@zte.com.cn
To: xu.xin16@zte.com.cn
Cc: akpm@linux-foundation.org,
	david@redhat.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	wang.yaxin@zte.com.cn,
	yang.yang29@zte.com.cn
Subject: [PATCH v2 9/9] Documentation: add ksm_stat description in cgroup-v2.rst
Date: Thu,  1 May 2025 04:17:39 +0000
Message-Id: <20250501041739.3324672-1-xu.xin16@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250501120854885LyBCW0syCGojqnJ8crLVl@zte.com.cn>
References: <20250501120854885LyBCW0syCGojqnJ8crLVl@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: xu xin <xu.xin16@zte.com.cn>

This updates ksm_stat description in cgroup-v2.rst.

Signed-off-by: xu xin <xu.xin16@zte.com.cn>
---
 Documentation/admin-guide/cgroup-v2.rst | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 8fb14ffab7d1..acab4c9c6e25 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1718,6 +1718,18 @@ The following nested keys are defined.
 
 	The entries can refer to the memory.stat.
 
+  memory.ksm_stat
+        A read-only nested-keyed file.
+
+        The file can be used to observe the ksm merging status of the
+        processes within an memory cgroup. There are four items
+        including "ksm_rmap_items", "ksm_zero_pages", "ksm_merging_pages"
+        and "ksm_profit".
+
+        See
+        :ref:`Documentation/admin-guide/cgroup-v1/memory.rst ksm_stat <memcg_ksm_stat>`
+        for details.
+
   memory.swap.current
 	A read-only single value file which exists on non-root
 	cgroups.
-- 
2.15.2



