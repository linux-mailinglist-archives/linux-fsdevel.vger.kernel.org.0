Return-Path: <linux-fsdevel+bounces-53021-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB54AE9284
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 01:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E74A01C43FA3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 23:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A124306DB3;
	Wed, 25 Jun 2025 23:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="UhfLI+L4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13412F0E42
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jun 2025 23:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750893567; cv=none; b=Huoj0B38awl1xz4qJQ8qWOcX1o9S/VF7z2aQGMg7Swd+kgiN5MxZN0Ynsd5VZcnXBsGa7vOCyJ8/ACCiiFfP0gWrj6ihNttf6KX2hiGsx/XOiCwaNxeOEWpfUnKEjjqnxbMh07jUZ7XyBbMrUYqqC+6xYGOFdkwYWowzVngl9HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750893567; c=relaxed/simple;
	bh=RcNYbs1efhmf/4u7FSKyFDgmK+5VrQkZtAduMmc72no=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RhgCaKpKf+tKHVYUt+lNwir+KP4PqDMCkJIvVo4p9ExQIQq7j6e1Jx7XkxB/0OzD0/gYfwQUSv51DWODGB51LmJycPMKSSpEjOgk7cpN19R7VGVeQUaD1kT0FxZbP5eeTDDfiGE4Je7nSXTvQktlRE7r8KE8hFgYTRLFoFji5tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=UhfLI+L4; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e81749142b3so278690276.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jun 2025 16:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1750893565; x=1751498365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iRo4ArwTr+rzDEl5s/rKZCEUFMQwNFwkQlgwE4JalXY=;
        b=UhfLI+L4w2vOEShq7dx+0k68PsM69ZJuJnolkQJVf290inX4WSHRoaWnWTbcGALG2s
         xErwEmK4mGFriWQbwjiWxMSFCiSMEJbogQglUhdxgThTEzk20e/ktQrYgJurtBbbn3Mc
         7qgUg5tBOweM99VcAHl+WRTsT3h6lSdEYah5jD5Q7IlqEHzA0VDRO46r5wHLYixVuepu
         Uzz1tS2iVPFVKYPX4MMPUj3Qm65wqOLP41uT4MeYbDYsv2PPD6qhbEMwcZgMcK69jzuC
         ZDdVn/rJB60PiwgmoFcYgEEK6SjHE8CdJAaSL5CPPrPieRxOrFQIkReKQ07zMYOGQmy1
         p2Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750893565; x=1751498365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iRo4ArwTr+rzDEl5s/rKZCEUFMQwNFwkQlgwE4JalXY=;
        b=BTb2HXQkqSOemrjLGKxhCR5EPoeWNEPLcW7V03XkkP23/2Nj9ho0HRirHCniQ0Jf3V
         5NDeiKP1+QNXJjstRN0JVVCleMbFd4DT0PrG+2KqfGKal1xeONQX1r/WHwYdcSTWIuvF
         VzBSaw83Umw/LMuD83lnQFVapkwv1gynenKqmvpqM7LXzQbo3ii6LPbjdRedUePNTsG2
         5QqTnElx9jX89jSgomx2uPpSlufGqQTVOEVwss5kb6cZ9+TGEF3+FUSpSaivgXCuZv56
         vdNQEeyZjJSzl8ex+D7Pd5g2JvhLlzJ217UBU0ue6D1cMgLryFeIHSLhEd064rqwu97J
         Gd3w==
X-Forwarded-Encrypted: i=1; AJvYcCUaGyrUbHSD+FCknig23CWLlZkzZlAgoDUeKthkpVJVWPmT8c8Gn2sX1ZtZiyoEupva84rvFf9Wh/jFubRq@vger.kernel.org
X-Gm-Message-State: AOJu0YySlsRMqZGDzJJvCzgiGqJ7ml0q3P+frx11MJvwxZWZrnMKQOPN
	CSTyg4Yy8upkW841jWYawtDVOLprDU7F+xq9kuGsUZKRgh7pKP0lTzG26GDQ/W4lgTQ=
X-Gm-Gg: ASbGncuahxnfvhUbGbAmjIcjsDnE0GSKxPqxOv4iSH18P5nnGnRdPBQJiCs6r/alXY0
	OvGU9jjIqxA9T1m+tOR8sDEU5iNzp6jusoxLCmZAEKCKvpsEXu4hyG6GVfEs90+Xmdr+WdVX9Mp
	WxlWdgjlSsjBrw6DfXFdga/2z6Mapxnw57WJp6+HOjp0uYHjh0b0QingsSmqdlAkWlhkY/aPNpd
	j1/mB7tMt9TsbHCTbjLkguYUMCibzjiBazm6SEzEHf2+v/8pyNkD8m5B72SGhfh4JFEOvvr5gS3
	EX86ll/+p0zOBKqmgy3c2itQq6o3wgiJrporCLPgRm9Wy3dwDhCE3ZfvPZBV61U3ZnZniG3K7S8
	2ZEzLmAhsIfg+S6taOO9JOj/Ejoxt9XAs/wq76Xbzamn8+KxsQ1VoQ4lqA7w9Pik=
X-Google-Smtp-Source: AGHT+IF/QqEmdOGEafHDFkdYh+DPEw7yVChLh5FM2HcZlMuGRDD+U97tQzodPIWh00zLYdSn83m6tg==
X-Received: by 2002:a05:6902:1790:b0:e84:4b7f:5b67 with SMTP id 3f1490d57ef6-e86017258b6mr5603267276.1.1750893564869;
        Wed, 25 Jun 2025 16:19:24 -0700 (PDT)
Received: from soleen.c.googlers.com.com (64.167.245.35.bc.googleusercontent.com. [35.245.167.64])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e842ac5c538sm3942684276.33.2025.06.25.16.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 16:19:24 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: pratyush@kernel.org,
	jasonmiu@google.com,
	graf@amazon.com,
	changyuanl@google.com,
	pasha.tatashin@soleen.com,
	rppt@kernel.org,
	dmatlack@google.com,
	rientjes@google.com,
	corbet@lwn.net,
	rdunlap@infradead.org,
	ilpo.jarvinen@linux.intel.com,
	kanie@linux.alibaba.com,
	ojeda@kernel.org,
	aliceryhl@google.com,
	masahiroy@kernel.org,
	akpm@linux-foundation.org,
	tj@kernel.org,
	yoann.congal@smile.fr,
	mmaurer@google.com,
	roman.gushchin@linux.dev,
	chenridong@huawei.com,
	axboe@kernel.dk,
	mark.rutland@arm.com,
	jannh@google.com,
	vincent.guittot@linaro.org,
	hannes@cmpxchg.org,
	dan.j.williams@intel.com,
	david@redhat.com,
	joel.granados@kernel.org,
	rostedt@goodmis.org,
	anna.schumaker@oracle.com,
	song@kernel.org,
	zhangguopeng@kylinos.cn,
	linux@weissschuh.net,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org,
	gregkh@linuxfoundation.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	rafael@kernel.org,
	dakr@kernel.org,
	bartosz.golaszewski@linaro.org,
	cw00.choi@samsung.com,
	myungjoo.ham@samsung.com,
	yesanishhere@gmail.com,
	Jonathan.Cameron@huawei.com,
	quic_zijuhu@quicinc.com,
	aleksander.lobakin@intel.com,
	ira.weiny@intel.com,
	andriy.shevchenko@linux.intel.com,
	leon@kernel.org,
	lukas@wunner.de,
	bhelgaas@google.com,
	wagi@kernel.org,
	djeffery@redhat.com,
	stuart.w.hayes@gmail.com,
	ptyadav@amazon.de,
	lennart@poettering.net,
	brauner@kernel.org,
	linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v1 24/32] MAINTAINERS: add liveupdate entry
Date: Wed, 25 Jun 2025 23:18:11 +0000
Message-ID: <20250625231838.1897085-25-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
In-Reply-To: <20250625231838.1897085-1-pasha.tatashin@soleen.com>
References: <20250625231838.1897085-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a MAINTAINERS file entry for the new Live Update Orchestrator
introduced in previous patches.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 MAINTAINERS | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index fd097e53fff2..90554f3a1bec 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14009,6 +14009,19 @@ F:	kernel/module/livepatch.c
 F:	samples/livepatch/
 F:	tools/testing/selftests/livepatch/
 
+LIVE UPDATE
+M:	Pasha Tatashin <pasha.tatashin@soleen.com>
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+F:	Documentation/ABI/testing/sysfs-kernel-liveupdate
+F:	Documentation/admin-guide/liveupdate.rst
+F:	Documentation/core-api/liveupdate.rst
+F:	Documentation/userspace-api/liveupdate.rst
+F:	include/linux/liveupdate.h
+F:	include/uapi/linux/liveupdate.h
+F:	kernel/liveupdate/
+F:	tools/testing/selftests/liveupdate/
+
 LLC (802.2)
 L:	netdev@vger.kernel.org
 S:	Odd fixes
-- 
2.50.0.727.gbf7dc18ff4-goog


