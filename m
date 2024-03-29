Return-Path: <linux-fsdevel+bounces-15646-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9BB4891103
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Mar 2024 03:03:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E3E91F23DCA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Mar 2024 02:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 732416FE21;
	Fri, 29 Mar 2024 01:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c0KGDrY2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A43B54F96
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 Mar 2024 01:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711677296; cv=none; b=jOpd1AWsEwen+6b+jaFsTigNoU6D7TehULYZhQOolJIOpBByJOR7rwki3mskNE0oRweCm/o6Ec+7tJ3bwAoWKg5RWj3uregvigGc6ebAEiludYLZjHybh2XSoAIilwhM0vTpP3QllH0b3lfqfgAUZm86r/Zftvwm1HdLCyEEwa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711677296; c=relaxed/simple;
	bh=pk9Ej0arFqeZkCMlr0ALuLSLryIAG82IwMSP2yyNpaA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bN5Ng8UgJTE6Kp8vEUbvjC3hBKE5xa/wWfzMvGjmQFwlaKJlLPpTKXMimkYDxn8QaK4c76MTNFUg7P0mdSdWdypanrmwiBlL6K4M+00Q5ugnva6oeSUVr454EnlxaPTe5VKAii6roltiBulFFFLsdKISUK3uJMWS9e8aG55aztA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--drosen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c0KGDrY2; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--drosen.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-613f563def5so25161477b3.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Mar 2024 18:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711677295; x=1712282095; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+fgPCyEdk35RPimkCV3pdmwq6y+0q0t2sbyu7i903QQ=;
        b=c0KGDrY2SPDw7zdMWf7UKCH98zvhJzG5zHgEHZyv7iZqIWji2kfPU5fOBB0d+q7/tC
         sbc7rMYqc6L8RFBccXpQcrptd2BE1gQratTe3haaO2f8/xKijqG9k2WRACjCsoLy8NHd
         jei0sJMtzUZEah1ZaIuKQrxYyYgdSyrwVDRCLfZ7tFj0fSD5utRFrdQMe37n18DjgUaM
         wLN4HU0S9IDoEAgpwkPoEByCwPsq+dkz2chMXrVLay6J01QpCsAsQJkVfaPK56J/Uqa+
         WgWA9kIDia9oaW3km2QfVIYRnSedBxB+pKe87ftQGxhMBcW+J2CPYt0m66ERPTH2QYMb
         kpTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711677295; x=1712282095;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+fgPCyEdk35RPimkCV3pdmwq6y+0q0t2sbyu7i903QQ=;
        b=rHAwnhWTI6hR95F3f94lUqdn/yMReYiG7hWiNRwxhXl/jQ2ByOG1qtdgk/gaY11t2e
         rkWmHxwkqP4eG3LF0L+bMf9AK2KM2OSjAP2i44yandh2kJfnrnNo2GBJDiqIVud3GmxB
         7s/WVLAsz3dmNSmAEcRfVBiSWqiHs2SvBjH1UhkHWJixLo9a/XrZX8Wz+/SxxsaUJU3w
         6yDH2IGsNR2GZ6TSIWoTdcof0fxuW+YozOQWSQllg1UcEFqGbinfInjRrZVvwmOs18N6
         1rn0OyV1NwlfMQmhRRH12+czVUYqWcLqM/KoP0NrzaS5/jPTeX7Jve0LkoHccjFegDCb
         v/xQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4yfr9lG/pxY/Vu7c8NFUQas6DlUavjwd6ixVtH1b9y/i00NegxWNW+GDlMNvzA01s0A+6eB1aZpvhdVbRK92r6T9cUza+wCJvnvFh6Q==
X-Gm-Message-State: AOJu0Ywr4J8N9UctkIoJOC+qPy0voAof7DrMFhzdMj3f/JOuncd8O+wy
	qMI0DS++eN7Q7ugZVP4zjSytu3kL85HGcpwWIoHDhqDtgHEpRgxyBx8JrUsMhYSKmAXlCxTnNJd
	l5g==
X-Google-Smtp-Source: AGHT+IHo+ItJCz1vEMlMJs25DEazsRdzqnfW39HVVXO67q+uyT3d5CUr2ZMLHU+KkcK6U1vReIfsPel7clY=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:201:fcce:d6ab:804c:b94b])
 (user=drosen job=sendgmr) by 2002:a0d:d9c8:0:b0:613:eb1a:6407 with SMTP id
 b191-20020a0dd9c8000000b00613eb1a6407mr266377ywe.9.1711677294719; Thu, 28 Mar
 2024 18:54:54 -0700 (PDT)
Date: Thu, 28 Mar 2024 18:53:39 -0700
In-Reply-To: <20240329015351.624249-1-drosen@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240329015351.624249-1-drosen@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240329015351.624249-25-drosen@google.com>
Subject: [RFC PATCH v4 24/36] fuse-bpf: Add fuse-bpf constants
From: Daniel Rosenberg <drosen@google.com>
To: Miklos Szeredi <miklos@szeredi.hu>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Joanne Koong <joannelkoong@gmail.com>, Mykola Lysenko <mykolal@fb.com>, 
	Christian Brauner <brauner@kernel.org>, kernel-team@android.com, 
	Daniel Rosenberg <drosen@google.com>
Content-Type: text/plain; charset="UTF-8"

This adds constants that fuse_op programs will rely on for communicating
what action fuse should take next.

Signed-off-by: Daniel Rosenberg <drosen@google.com>
---
 include/uapi/linux/bpf.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 85ec7fc799d7..46c1a3e3166d 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -7461,4 +7461,16 @@ struct bpf_iter_num {
 	__u64 __opaque[1];
 } __attribute__((aligned(8)));
 
+/* Return Codes for Fuse BPF struct_op programs */
+#define BPF_FUSE_CONTINUE		0
+#define BPF_FUSE_USER			1
+#define BPF_FUSE_USER_PREFILTER		2
+#define BPF_FUSE_POSTFILTER		3
+#define BPF_FUSE_USER_POSTFILTER	4
+
+/* Op Code Filter values for BPF Programs */
+#define FUSE_OPCODE_FILTER	0x0ffff
+#define FUSE_PREFILTER		0x10000
+#define FUSE_POSTFILTER		0x20000
+
 #endif /* _UAPI__LINUX_BPF_H__ */
-- 
2.44.0.478.gd926399ef9-goog


