Return-Path: <linux-fsdevel+bounces-15649-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3497891110
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Mar 2024 03:04:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4E901C21CBB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Mar 2024 02:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E40708593D;
	Fri, 29 Mar 2024 01:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cGvlUFtl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC7885631
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 Mar 2024 01:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711677303; cv=none; b=OSLuOZFxSuDMov0WVaazaaQ9PD+AhStRu4UQt5ZFM9nMmcOCKF8CdCXjfH9ceeyG+LdBGW5wOOUBzRhbIgyLuxbTnA9IyGLCacXJuwhW5X75XYgMO8dfPOoNnTSm8nucNJ/bIN8ERf1o4pU7lvleuGTl4AyHz4Xt7TGFfTZYE5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711677303; c=relaxed/simple;
	bh=KCoIZNUHcwv2RV9ZRbHBJii4HaQ9xYYtK2VIovQhTY4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Twca8Avs3z9gUb1Q7OfAE1qJzWb21/wud82qy224Zu2JP19ftTs8Aw/XlekdY7NxFFxvolfiBd44SvyNLc1sh7U1Wr0IYXpSGQX6gRzNH1uGVsF4Z4GUjrJy8F5y67jmJYiFWXtURrzmLQBC22MoSsh7Elp+QZgLYVld3abP5pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--drosen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cGvlUFtl; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--drosen.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60a2386e932so29402057b3.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Mar 2024 18:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711677301; x=1712282101; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/G940zvh+KpSLBvufKEbVa5uESG7TAs31JyWujh5JiA=;
        b=cGvlUFtlWGRTPkcyYNCMwvSxvP8qlwrZr3JOFvlMOAHhswasUvQzmPZLlH01AY8Kke
         CDnQgoMEJhPRIKJsyS04oYc8Uuu55Dzdh5jmQyxNhfsUDMZZEkM1xiv1h5HuuzYlN6zl
         PODUMjxw8QyB8/DxnT+YoKR3DI/rJSNob2BNPMMEmg+Bogh048li815kIsg18b85Utld
         Iymm98q4jMGrSCjfKBjmefZPnJZpcMtoplmG+B4yi7PxdPAoPOD9gEgZgZCkQSQESDHb
         zNE7xCcmRxlLfrm4sMPXWZKy3jJxhIq7sq9SCl2/E0a/qS5mSG6DsrzM9EQEaQppU9Hb
         4vfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711677301; x=1712282101;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/G940zvh+KpSLBvufKEbVa5uESG7TAs31JyWujh5JiA=;
        b=JLPxc6K/MwBtyveZIArjNsVU6MmveHBLNbyK8MRx0GuHU1S/LL/AVIHlNfSYh42KFg
         ZFvlnbF9eIWcZObrLPsp2rEtp772lfhvk63xVwCIPIQoz/lnaucU3woVuoQZ0JvcsvqG
         /+yx7tg5eRlTUe2g2IjM/naaf+Ha32fEfzK50S9jQbpRpGfBhNpuYFtoGEWrFeYLACQd
         ewnXmhk9ANd/dU5eY0wE71mNW7J2RVthP2WNpa/tlbOTGpePWC9hyy5Oh8P8KvPZ1Tuv
         /wFjwJMlTzI3nSUL8s1EIQonF8qcxERhQjd7utG5hkS3c8rFvmFAUE3Hs2RE1071/YFd
         XFBg==
X-Forwarded-Encrypted: i=1; AJvYcCUNUomgo+nw4FHjmIomvJ9egG4cXCH966SdLNTpQMaC/i4Es4P2c8gITVjGOIAXk9eCXnN2emjOouBSn57RY0w0bS29/4uVco2jKfsyMw==
X-Gm-Message-State: AOJu0Yx3Afqg4eSYP5j2vPBaoFUIR36cCqB5zq+8jy4vy1BhGKfWehxH
	LPA4mr4yEmQSNuwc4PNN+bpjNfqZaZTUFM/5Qm5YMojnlOI6IWSXyaHPSd8KD5Ek8k28pMWco/e
	BXA==
X-Google-Smtp-Source: AGHT+IGsCzOtwN105f/bltaErVUfpSBRC3F9RkDjk/0Wfd4wmn+phWiKkcXdiSoxa6ZQkSCXtl1Jd331NFw=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:201:fcce:d6ab:804c:b94b])
 (user=drosen job=sendgmr) by 2002:a0d:d8c5:0:b0:614:4c1:c8d with SMTP id
 a188-20020a0dd8c5000000b0061404c10c8dmr308593ywe.6.1711677300998; Thu, 28 Mar
 2024 18:55:00 -0700 (PDT)
Date: Thu, 28 Mar 2024 18:53:42 -0700
In-Reply-To: <20240329015351.624249-1-drosen@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240329015351.624249-1-drosen@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240329015351.624249-28-drosen@google.com>
Subject: [RFC PATCH v4 27/36] fuse-bpf: Export Functions
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

These functions needed to be exported to build fuse as a module

Signed-off-by: Daniel Rosenberg <drosen@google.com>
---
 kernel/bpf/bpf_struct_ops.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 43356faaa057..ae76b99c07c1 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -1024,6 +1024,7 @@ bool bpf_struct_ops_get(const void *kdata)
 	map = __bpf_map_inc_not_zero(&st_map->map, false);
 	return !IS_ERR(map);
 }
+EXPORT_SYMBOL_GPL(bpf_struct_ops_get);
 
 void bpf_struct_ops_put(const void *kdata)
 {
@@ -1035,6 +1036,7 @@ void bpf_struct_ops_put(const void *kdata)
 
 	bpf_map_put(&st_map->map);
 }
+EXPORT_SYMBOL_GPL(bpf_struct_ops_put);
 
 static bool bpf_struct_ops_valid_to_reg(struct bpf_map *map)
 {
-- 
2.44.0.478.gd926399ef9-goog


