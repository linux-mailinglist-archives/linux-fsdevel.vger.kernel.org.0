Return-Path: <linux-fsdevel+bounces-26164-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1087955515
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Aug 2024 04:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D481A1C21BCC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Aug 2024 02:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 580FF7F7CA;
	Sat, 17 Aug 2024 02:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ECm6v1Ve"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687BE22334;
	Sat, 17 Aug 2024 02:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723863446; cv=none; b=J0Hlg6CyOUteTXjITSOv/WLIlKeL7wq9C05RSo0NIG8iNUD6pVZqMdlmOBf49xG0ZX6FOEzKLgUC4QQYKiyRBiBCrtonsjQIx995K/ThZAwM+54kTntAAIR5bGc8ONLyQZIK0i0dEw5C3RqO5jp1pXuwPWWzWwo5L32R2czBqEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723863446; c=relaxed/simple;
	bh=56ESQtaoBbBqZU/saKgTljkr5U/isylgWUhSQpUUDZM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VddTFE+w+bi6Ojl7zs0oCdxoZAm+IMtcVcz0dAT/51gfqRq3TW5JaJPAWFRuSlU9eVNHtJl/Xg3li/ATVrBzVRdvuft7cwXddCj60E27zQEin1Rv1jG06S/eLfjYF5GDIV/HNQCyw5vsC8s1zmYwVv3vlWuYSSeonz60inYvkjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ECm6v1Ve; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1fd9e70b592so26242755ad.3;
        Fri, 16 Aug 2024 19:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723863444; x=1724468244; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QQdkC9XISn7BWPlTE5/iE7aUj/L2jeLonKoaBsbNpS0=;
        b=ECm6v1VeB11TWAQ+M7BgcYFyfSiCRooF1shaB4vGY0SXLIh2zBYdJ4UVsQpOgacWqe
         JhEbjmbAwBZy896qbvRGq3uaZZRcw7sJWvxT74/HzGPZUE0kXtMjQW2D6F2Fa4cwkEGX
         gTeuu7nRJi+w0nNwrjKco4Bn+gaV/ReuzuBoWcyzDJ/5gspdJPBM+oSLarFdcqeaYKhg
         OReQdFvEmB/mXpbh1skLMP+FdLr3DHnUws+axiPTK+TKEt3Z0p5TxBerrof/LNeIAEHb
         Dr+ntBkfFnWBoz7XSAufmfIJhS9W6WM+hX4kOtTLw1I5dKq04ulrvFNEZ9NdHGfAXPFY
         9tow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723863444; x=1724468244;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QQdkC9XISn7BWPlTE5/iE7aUj/L2jeLonKoaBsbNpS0=;
        b=kcZXqOM8O8RbZ14MDYh/1o8824l0xNDJKHtiywwwZS3SL2Xsn71Dn9tmte0HNFA1HR
         unXTYhbCBZBbnR0df3LnSY1hHq4ZjhapqHi3+4KC0MyJSKT6embmmcNHFIawgxVnUsDN
         9NQJhO9Jsi6CB64/PqjtmYXXJYE9Em3pg0UfRhuxDJx639uLFXga26aCw6k9wYrGt8cJ
         W1EwJuSZuNhq+qB0gf0SDZTv2r+UC3XzD0BEflllMu8+twS6QFzqiUkcoT+zxH0qrkTv
         giRBhWlT+T8hP/cw5Kvbt3PxCepyuw4w358hBIMx4MsKh0XUKJ/wHPc146IWUWtcfOo8
         quag==
X-Forwarded-Encrypted: i=1; AJvYcCV+P55+LuRtOwWlqTGip49qQ/TD0C/+JAGn1oF/U+WNKwUPDpg9BqLG8xZfU/N/lJ8QC8dl@vger.kernel.org, AJvYcCV1cuwarGsJDdDSJb+Zsp0XSD4S4tBbCkumqMp2jay57H0k3S/xFBusTMgRkztcERlhVKKouKGL@vger.kernel.org, AJvYcCVytU9qje+VtPrUdtAyx0iaOJqCpA+Rfb+4A2hCjQIyWAiRvJoPajN9xUn9SeBCHsBpDPGiUkh6aA==@vger.kernel.org, AJvYcCW/PaiflTtOw+7iviLSfAg7/5CHC+3i/tKmlrOSHP3CJExW7q1JmE1uJpJhPOtbOwtc+xQNCwmQzR8g4Q/ocOxt+RpqPfot@vger.kernel.org, AJvYcCWPY194/yngH/g/qYxrA6rpRiJcvJm185eW8TbyE3ee+sdQD6rGZPq7E/+S8SOcQYNOwqhrgQ==@vger.kernel.org, AJvYcCWSz5CatfaG1RFP4TILDAeBNwo4SJAw2IThMp0IbiYseM/aLib8n952sqYplMzD6Zr47rkNqRvM1AlxQMBE/Q==@vger.kernel.org, AJvYcCWxol9TwTdsUFoDRBcg1WY+QQ2Bx4ntooxsaSgCa5DcKD9POCQH+pFggPDSw6vEuc+iz23ri4eij0If3UuZUzgp8YdX@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+EJO+7f92wl4Jg7TaO/R1uVPJ9BDN1N5RXLBmOC76x2HrxLwM
	4pETm9WZoJziDJ4RvF0dp1LEme3GvhS9gq1J60bdL2YYA2542SdpomlD9RtIWVs=
X-Google-Smtp-Source: AGHT+IGimEn6HMsvkqgHYM+kruqPW+JJG9kJGgyigEFWYmxee2uabObu84uvkyN6MQRp9Qx9ywJBnQ==
X-Received: by 2002:a17:903:2281:b0:201:febc:4366 with SMTP id d9443c01a7336-2021969a77dmr17762915ad.55.1723863444544;
        Fri, 16 Aug 2024 19:57:24 -0700 (PDT)
Received: from localhost.localdomain ([183.193.177.10])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f031c5e1sm31801785ad.94.2024.08.16.19.57.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Aug 2024 19:57:24 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: akpm@linux-foundation.org
Cc: torvalds@linux-foundation.org,
	alx@kernel.org,
	justinstitt@google.com,
	ebiederm@xmission.com,
	alexei.starovoitov@gmail.com,
	rostedt@goodmis.org,
	catalin.marinas@arm.com,
	penguin-kernel@i-love.sakura.ne.jp,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	audit@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Yafang Shao <laoar.shao@gmail.com>,
	Quentin Monnet <qmo@kernel.org>
Subject: [PATCH v7 4/8] bpftool: Ensure task comm is always NUL-terminated
Date: Sat, 17 Aug 2024 10:56:20 +0800
Message-Id: <20240817025624.13157-5-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20240817025624.13157-1-laoar.shao@gmail.com>
References: <20240817025624.13157-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let's explicitly ensure the destination string is NUL-terminated. This way,
it won't be affected by changes to the source string.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Reviewed-by: Quentin Monnet <qmo@kernel.org>
---
 tools/bpf/bpftool/pids.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/bpf/bpftool/pids.c b/tools/bpf/bpftool/pids.c
index 9b898571b49e..23f488cf1740 100644
--- a/tools/bpf/bpftool/pids.c
+++ b/tools/bpf/bpftool/pids.c
@@ -54,6 +54,7 @@ static void add_ref(struct hashmap *map, struct pid_iter_entry *e)
 		ref = &refs->refs[refs->ref_cnt];
 		ref->pid = e->pid;
 		memcpy(ref->comm, e->comm, sizeof(ref->comm));
+		ref->comm[sizeof(ref->comm) - 1] = '\0';
 		refs->ref_cnt++;
 
 		return;
@@ -77,6 +78,7 @@ static void add_ref(struct hashmap *map, struct pid_iter_entry *e)
 	ref = &refs->refs[0];
 	ref->pid = e->pid;
 	memcpy(ref->comm, e->comm, sizeof(ref->comm));
+	ref->comm[sizeof(ref->comm) - 1] = '\0';
 	refs->ref_cnt = 1;
 	refs->has_bpf_cookie = e->has_bpf_cookie;
 	refs->bpf_cookie = e->bpf_cookie;
-- 
2.43.5


