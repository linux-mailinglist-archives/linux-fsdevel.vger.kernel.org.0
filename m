Return-Path: <linux-fsdevel+bounces-69491-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB913C7D8CA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Nov 2025 23:26:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 641A03AAC6A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Nov 2025 22:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B752DC350;
	Sat, 22 Nov 2025 22:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="S9NGJRgn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0502D9786
	for <linux-fsdevel@vger.kernel.org>; Sat, 22 Nov 2025 22:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763850258; cv=none; b=ZxCMbdJVEY4FZ0mTZRTFHJ8itoE+1SBujtM6Ncc3m65DGHv7evjOBTOKqh2A2FWrPpb6YsxF+y+tgadEZqRAi86xo6XBsvkdVkL+18WOEy9tWBogABTo3qQ8oRqZCMZweuEgdhEfieG+mX9xqtQW9pihpJeQmuNen5sKVmd1joM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763850258; c=relaxed/simple;
	bh=EnyxoW9Q62zzNLamdD3lY33p/cbJQtd0FxygTgIMtNI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WZhaLFVttT7IAdZpTeO3OehSTIgMT7MmiunM4BSdcQstDbSCZkBJlbEgwkneZ70aKSkI5t3C/8LMXnbOWAKZpKZs9U+l1swRg/0gH4QbQgG6bfLA9sSXGl7EwnaLm/hnYA4B33akssdq8AuxoIIKOxU69dr3lmp7eMQloNA1Kuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=S9NGJRgn; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-787c9f90eccso32990587b3.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 22 Nov 2025 14:24:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763850255; x=1764455055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xzrSObhj5Wimd1cdYGg31ZDKZ8HgVQz7p6sm5WUy9Y8=;
        b=S9NGJRgnpowrXgInACxha2n2Ffk3pLPjp3BC1WNT/wTq4yNHk8eU6sCmka9gmsBTMK
         pER5bynmdLXu7hu9B8itR7Z4TJyotJok/HIBFtiPyLwM9fKuDGaa48ypS9adHNj0wjjF
         obW+dMnDMo1P6jHVTpHMMpI1+BVVR3WLkhCgL7+JdBxzm150angHE5Bs/SslxXf25GmM
         3++NLSaR3B+oc1eQi5AJGfQ6sEBkDbNNjqrqNFywmS2zzWwALBCqzkngHErncKv1F1xK
         xpQMIM8G3yUXBg6bN0J1Zge+v+OmvrTYUCtXntjFh9V8po//Xw9JbC8GwvLGzrusieiD
         AAjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763850255; x=1764455055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xzrSObhj5Wimd1cdYGg31ZDKZ8HgVQz7p6sm5WUy9Y8=;
        b=Q3C8HKc+aP8IgSq11HKtXKBP1UCIjiknQuHdn9oqh6gWwPwXxzTb9Bdm2RT9G/3S/y
         Iaa1w4BaEAmMEKunqDo1ez5ETRrJFbc/Z0L1j2ZWKsk8Dv89oHhb2ByCXL+GVWnECeSx
         hs6ndZKmocGjoCFQyb7sj8IdlFpCNy3zkYYl3y01icc6leuVCT058ashvHM4TGBW5pBD
         PtWaA8lGdUZHKfB70EZsYFg4yaFZAXrBgzPtAJHBjruOV3PYepg7lN0k0SaXb++2L06j
         RTfMQwI56JxJOGrz0dBxWnIdMPMh4jGH8nzAXWVt5PAtQvDTXvRZUXZZkruyqD3m8Xhq
         jg2Q==
X-Forwarded-Encrypted: i=1; AJvYcCW0FQRUXTmo5I89PsUxabdwyye++/ZS8BO6/gC4Xd1cLSlyre/fsgrsqzDwElpBGwBSYtXuN5/SIcIzaPuE@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1UNcP8X+RdGX7pVr8qmcaD05rBjD5nUxPEdEsRjNNCojhmGtH
	jYwHc5u7cgF2+V2/hthF/f25EAoz3zeviigWLHnAM9ZUu3j6f9L5NR2Zl9sbYKX6zog=
X-Gm-Gg: ASbGncuCws+xm+Rhnu65VF1lEKb8mzzW6Xi2Ff9AkeydVoGjLvw597aariZ05kq2K9H
	sqpUwgqV4QhXRu67GRF+sM8jRhUcyJact/oBgFbbdNkPRHPnZ7Vr7FpOmRmUvBedSzw9l74DVFk
	T2BRdEIm3335quky0efFwJP/zIO4NwpTdrVsNgGKl3IbudS5eVuHHSFVvKp/tQB7laRq2aYgDMA
	1NCzhCyh7gjZbn1xXXfwc+SRJBVBMWDSzLkFUtTu61rFmsWAojAavWb7PS84sqYILu3hfO4ZLFm
	AJy6rE9PiasAIo7TayHMO3WFEeA6ePEiWJSmdAEH3jGnGNuj6abdr5yIxn1efXVo2Ji9fqQLaVn
	Cf+aFFgwa/+2lroRTiAFb02w8u2u6JAadziaS5c5V+kbnFSHXzuQBKC9xIKPxb7mMV4+x3ZZsRq
	qD8/KYujgHi5lpPG/yy62H3XhzVHHxQNoOv63QZ3anjHJKu3gleX4Q0hX02LpabgBow0h78P8IJ
	6FU0KM=
X-Google-Smtp-Source: AGHT+IHKuSAjgrt1dxDo5oomNcqBOfqdLocHIsya6Qr+JoT/gAP6yZKLlAopzeyv3C1y1/iPUXwmuQ==
X-Received: by 2002:a05:690c:b99:b0:786:4fd5:e5ce with SMTP id 00721157ae682-78a8b541204mr57832467b3.37.1763850255139;
        Sat, 22 Nov 2025 14:24:15 -0800 (PST)
Received: from soleen.c.googlers.com.com (182.221.85.34.bc.googleusercontent.com. [34.85.221.182])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78a79779a4esm28858937b3.0.2025.11.22.14.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Nov 2025 14:24:14 -0800 (PST)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: pratyush@kernel.org,
	jasonmiu@google.com,
	graf@amazon.com,
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
	linux-fsdevel@vger.kernel.org,
	saeedm@nvidia.com,
	ajayachandra@nvidia.com,
	jgg@nvidia.com,
	parav@nvidia.com,
	leonro@nvidia.com,
	witu@nvidia.com,
	hughd@google.com,
	skhawaja@google.com,
	chrisl@kernel.org
Subject: [PATCH v7 09/22] MAINTAINERS: add liveupdate entry
Date: Sat, 22 Nov 2025 17:23:36 -0500
Message-ID: <20251122222351.1059049-10-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.52.0.rc2.455.g230fcf2819-goog
In-Reply-To: <20251122222351.1059049-1-pasha.tatashin@soleen.com>
References: <20251122222351.1059049-1-pasha.tatashin@soleen.com>
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
 MAINTAINERS | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b46425e3b4d3..868d3d23fdea 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14466,6 +14466,18 @@ F:	kernel/module/livepatch.c
 F:	samples/livepatch/
 F:	tools/testing/selftests/livepatch/
 
+LIVE UPDATE
+M:	Pasha Tatashin <pasha.tatashin@soleen.com>
+M:	Mike Rapoport <rppt@kernel.org>
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+F:	Documentation/core-api/liveupdate.rst
+F:	Documentation/userspace-api/liveupdate.rst
+F:	include/linux/liveupdate.h
+F:	include/linux/liveupdate/
+F:	include/uapi/linux/liveupdate.h
+F:	kernel/liveupdate/
+
 LLC (802.2)
 L:	netdev@vger.kernel.org
 S:	Odd fixes
-- 
2.52.0.rc2.455.g230fcf2819-goog


