Return-Path: <linux-fsdevel+bounces-56659-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42319B1A648
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 17:44:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9105A7A0F60
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 15:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD8E272E5A;
	Mon,  4 Aug 2025 15:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hnkTPBrg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B4826CE30;
	Mon,  4 Aug 2025 15:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754322225; cv=none; b=KXaRkD7vwjR3AdxU/9BzeyfguHuW50dyfH7qBOW23dLAeeSeqf1yjBCsSXO4ihO0BkkCT+97dCsC77p4Zzwrf4cVm6eAk4b9tFbERVRIP9Ix0fBlYnn9leNEAfZyak3PD9SZSrF4kumYPo3sSsRB0F13sOBc9U1GeLHki52EP/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754322225; c=relaxed/simple;
	bh=lGzOELJhrCci+XdLDFyVu3648iFkuugWcmHQwvvhow0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZJjCIMzRMNwHXWVWhBmYo2SRKo6/ppotVDKmN1EcmVVUPmOO0z9n4JSs7GpggJfaBx7fsnhtJdE8vm1yVRGKD6o1kF3mZHKdt2dhapFa35ZAy+d2KzSH2berykpdW4iV3G326xVF3fLUa0ONeMHgEsQ27PmbJ5W32MXEetpaRgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hnkTPBrg; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7e29616cc4fso415365385a.0;
        Mon, 04 Aug 2025 08:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754322222; x=1754927022; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a7FGysSwc9ir6e18/+ECYekeynrX3D9ugFjSYDa8j38=;
        b=hnkTPBrg+OJbEAgjpSiAFrLqojnbaspbVKN6FkWCU2CI3zy2V/xsi8npeucIydPYmT
         K+7jcIKt/HwO1LAvW1pk08lHOKG7zKRRwMywy+i0o1Bz/ImjjneP9NHizF+MBu5Q/VJp
         LekbDOV8bs0irULwzK5QiKWqaSoids3kXhh3HgqiBb+l52+mv90Bsjv5Qutp2zn6y8wr
         D8WIptfv7AHqSNVFRLQnQu/qPTgjfpJolRQ+NqWJFgGrvO24IjTNgnZyMt9Oc9AYJocr
         sZPKwsYU6qMTym4qQcSd7Pys8gBC0FFypjt8NvAGOt6uOwp1XTkoJivQELAZ3GhHqbJY
         xpXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754322222; x=1754927022;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a7FGysSwc9ir6e18/+ECYekeynrX3D9ugFjSYDa8j38=;
        b=MCsCjuCth1k52fS68w1jayrZLM1852Ms7wjSw4yQzNDEzWnMwFr0DzBzUy26mXawPG
         5N/XosrgtIHH4eVGdFolL7IYQDcsO33QjwyqZqDxY7FBizU7Ewsl0Yb+w4ji1DDBvzHi
         2zsVMcw//achIWawmJvActHUm3vez3pe5nBdTImCkyXxKRWBMzvFTtz53xqdaLCQxQhS
         1cKLD0LreVnc/xHYq06d6EqRncfRSp/LH7yl0bhTIab6R30qhWwbAA5TPKOLnX2Zj/CN
         WIyeBxeqdoMaTpJdH1iaVjOJt1JPWiPqxbXqeDIPDkYV/v5koSBIBPRBvG5SpG7QXNex
         waEA==
X-Forwarded-Encrypted: i=1; AJvYcCUG6HPhiH3pk7xMa8qMDwVClRoGg5Plf5Q+EkIO7DWxtPka8DcrLfvPdVlwO5Z2xzX5Hv9bIJUzwzU=@vger.kernel.org, AJvYcCXRZsZEXCYKw2jhaXW1IiI3b0gN9BFcAWV3xQgnZhQ0W8ECtJ7jq/bwjGFR7uyOKOiktUrvsq7TmW8q1NIQ@vger.kernel.org
X-Gm-Message-State: AOJu0YwnlJS8TB1hXt0xF3RzW5f9q6uEcgZI6WwsPwRrjEuawecYCG9f
	YhhV8JcrbRVIPT3gPFlCGebM+XK3GfjgmdC3aGFUeCXKTh5XBC5I30nfnx1OV++s
X-Gm-Gg: ASbGncsc0Bf3L7Pg/kd4Dme5mSbPLMU+0z3mecnIOeXOmz40wU1E1vbYf4lNN68sS3k
	/sqSpLBE8AwUO3Qe4dQmdPyyaVzuqL1wA7Gsto3u5kIQ0IhoApfrC/n76aR2rYJQagXaT0YU8ZD
	MxBGl34lXdMqHlN2WqylMS/EI4VxsyOzOk7r1GvKXS4AWXcoPobt6t6p/pSsnzSw6uh2u6WkL1p
	NnswAwiZT/xmcEXRV5zO4K/FZ6VlatLbm/LssWLdkNjuhrvi2Wx3BRBTdEiIyQeU5x68Htpr3bo
	ZhVwuXco3Uvlt89B50xXGwyOzGHIC2VW02zD6jumFbxM2g032UOIwnR3wzek0oDhPA9drhXZc84
	HiZLuFFT5TXDo6ZuWMtg=
X-Google-Smtp-Source: AGHT+IGS07Gw/uqMyBQHFvHilTAJPxp7B447DJt/tc+a5i1DvNlJq4ZtECfwx07goEsa9zjexjCclA==
X-Received: by 2002:a05:620a:39d:b0:7e6:30ad:be32 with SMTP id af79cd13be357-7e696268883mr1447844185a.5.1754322221625;
        Mon, 04 Aug 2025 08:43:41 -0700 (PDT)
Received: from localhost ([2a03:2880:20ff:1::])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e67f742e7asm559131385a.71.2025.08.04.08.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 08:43:40 -0700 (PDT)
From: Usama Arif <usamaarif642@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	david@redhat.com,
	linux-mm@kvack.org
Cc: linux-fsdevel@vger.kernel.org,
	corbet@lwn.net,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	hannes@cmpxchg.org,
	baohua@kernel.org,
	shakeel.butt@linux.dev,
	riel@surriel.com,
	ziy@nvidia.com,
	laoar.shao@gmail.com,
	dev.jain@arm.com,
	baolin.wang@linux.alibaba.com,
	npache@redhat.com,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	ryan.roberts@arm.com,
	vbabka@suse.cz,
	jannh@google.com,
	Arnd Bergmann <arnd@arndb.de>,
	sj@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	kernel-team@meta.com,
	Usama Arif <usamaarif642@gmail.com>
Subject: [PATCH v3 4/6] docs: transhuge: document process level THP controls
Date: Mon,  4 Aug 2025 16:40:47 +0100
Message-ID: <20250804154317.1648084-5-usamaarif642@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250804154317.1648084-1-usamaarif642@gmail.com>
References: <20250804154317.1648084-1-usamaarif642@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This includes the PR_SET_THP_DISABLE/PR_GET_THP_DISABLE pair of
prctl calls as well the newly introduced PR_THP_DISABLE_EXCEPT_ADVISED
flag for the PR_SET_THP_DISABLE prctl call.

Signed-off-by: Usama Arif <usamaarif642@gmail.com>
---
 Documentation/admin-guide/mm/transhuge.rst | 38 ++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
index 370fba113460..a36a04394ff5 100644
--- a/Documentation/admin-guide/mm/transhuge.rst
+++ b/Documentation/admin-guide/mm/transhuge.rst
@@ -225,6 +225,44 @@ to "always" or "madvise"), and it'll be automatically shutdown when
 PMD-sized THP is disabled (when both the per-size anon control and the
 top-level control are "never")
 
+process THP controls
+--------------------
+
+A process can control its own THP behaviour using the ``PR_SET_THP_DISABLE``
+and ``PR_GET_THP_DISABLE`` pair of prctl(2) calls. These calls support the
+following arguments::
+
+	prctl(PR_SET_THP_DISABLE, 1, 0, 0, 0):
+		This will set the MMF_DISABLE_THP_COMPLETELY mm flag which will
+		result in no THPs being faulted in or collapsed, irrespective
+		of global THP controls. This flag and hence the behaviour is
+		inherited across fork(2) and execve(2).
+
+	prctl(PR_SET_THP_DISABLE, 1, PR_THP_DISABLE_EXCEPT_ADVISED, 0, 0):
+		This will set the MMF_DISABLE_THP_EXCEPT_ADVISED mm flag which
+		will result in THPs being faulted in or collapsed only for
+		the following cases:
+		- Global THP controls are set to "always" or "madvise" and
+		  the process has madvised the region with either MADV_HUGEPAGE
+		  or MADV_COLLAPSE.
+		- Global THP controls is set to "never" and the process has
+		  madvised the region with MADV_COLLAPSE.
+		This flag and hence the behaviour is inherited across fork(2)
+		and execve(2).
+
+	prctl(PR_SET_THP_DISABLE, 0, 0, 0, 0):
+		This will clear the MMF_DISABLE_THP_COMPLETELY and
+		MMF_DISABLE_THP_EXCEPT_ADVISED mm flags. The process will
+		behave according to the global THP controls. This behaviour
+		will be inherited across fork(2) and execve(2).
+
+	prctl(PR_GET_THP_DISABLE, 0, 0, 0, 0):
+		This will return the THP disable mm flag status of the process
+		that was set by prctl(PR_SET_THP_DISABLE, ...). i.e.
+		- 1 if MMF_DISABLE_THP_COMPLETELY flag is set
+		- 3 if MMF_DISABLE_THP_EXCEPT_ADVISED flag is set
+		- 0 otherwise.
+
 Khugepaged controls
 -------------------
 
-- 
2.47.3


