Return-Path: <linux-fsdevel+bounces-62976-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E8BBA7B53
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 03:08:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A621A17B1ED
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 01:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E92EE287516;
	Mon, 29 Sep 2025 01:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="YqgwQruV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4A0257852
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Sep 2025 01:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759107886; cv=none; b=E9Ni66JR25Tq5cS+uulBSEhD8lvsoimlLzNYAcTDP2xyAWA+Vbua4hycskBlaaes/9lvVCcncCeLkDjMDH4w0QCXYvm7MH34XUszKzViMwFNibxYS/gkiWc95pRnu7jO8vdBSiOWo53/Dt/x9ZJ3myq+qJW7eMHqbzXGSOzhVME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759107886; c=relaxed/simple;
	bh=9W8xPT3N53RvPHAnS9f5/QrLnT01yqAHq2ba0G88QkA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rSl6ns6XXnj5QjtFoFYKF9qhzK2aYpX/GLrK0AT7p7u28WF8Cpv64Yh1TVmDLxdKkuoq3ppT+R3zNtxhOatvsA1WdwR6ckrRutbYo1yfiRGilnj9vy6vTlyxcIa9rvCbCDroIvyZPnw6dAVOeuMayZRbLm5fE+Fobml6rgswSWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=YqgwQruV; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-85d5cd6fe9fso293012585a.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 28 Sep 2025 18:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1759107882; x=1759712682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g7EcpRB2lXFP1cLCapL56dmZqGYeN55I/l6E6y0w+Pw=;
        b=YqgwQruV64DhTVuvvXUghhuaB+AJDi1BI1iuUcrVyWiMrPyXJEWs/dwlNUAnUN024w
         T6KBZc/EJHoBLkXs8WfudD9QpAUfnowBYAeQDRF3q+dM8PTTf0h4bOMwKFlOTOzw4WMf
         MfKHlrAwaY6i3poHdRRD2bUgIQcABCKGgCyY1ibV04dgNPuVvvvS5BBdskC6E4FXB6ky
         rKqmCnfvb+12cLzv78dlntY4PMfABHP1UIWjLoxffc3AAsgJn07ZCy/Bwj/jO7bP4kiH
         k3YTU5+2SnVTbnsZ5O98z8ZU+Mm7SWNeahppJ9z+3NLrVs9wuHaMhAaRWlEokvGsLr0Z
         /tnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759107882; x=1759712682;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g7EcpRB2lXFP1cLCapL56dmZqGYeN55I/l6E6y0w+Pw=;
        b=AgpaejtqvZ72xe8GV/1DLKg3lMG9GWpiI89irTDxRT1kIWtB6gfbRG1q/EfZQ5ICrD
         MG2UcjkXmN4rx7BeHm753I9Tw2AruvzYoGtFF8egV04UodGSdg82DZbViyFW39T54bxq
         CfqpeHqussdYGQDLnpKPIW0crktHUEkmATxQ9l0ii22vrCf9OaRqyku8O1kJvhdESeip
         Ce86sd7ue0imgqMAEcxfQDaomTd5sStcpJigWBC0/7jhSA7TNN2Nk0AYQ4wcLg0+lBCr
         +znZ1iD+VYnMmB3pXqfAfUQIbe0leZ44jyuGa+BwhBAtDUSO4PC23AlniTWCeNbdc20C
         a8tw==
X-Forwarded-Encrypted: i=1; AJvYcCV9n3+PFj+gd8I4tu82SIboI/B0/fq++MsQOr7vGetrqvckNlgUZp2BpQgpZGC7rPH+AcRWhpwq154bg5Km@vger.kernel.org
X-Gm-Message-State: AOJu0YwbioM2PF5l4Oi9d5kkAt6b5NVFUq65DMtUnrNfrzPQ8YJMDt3h
	bAlGfefmU9+l6q3roUWoxv+sZu8EkHBoFbUuaMzHEcWAhL6TE05sPYmM2W7sh05eS80=
X-Gm-Gg: ASbGncuXgi4tmYrHw0cqzukwl9xqPWPATsgyF2nRdwL9whdWZ5Cby0cKQL9tBvE8Wcq
	D5a4Tol1M1c8qBLCLqsix12Ii3/fx8bZQgHieDKi+sa+LxPWkIFL+j4ij1JXkMachR534TO49Qd
	YccKuOspVomxi8a7dTy2V7uL2vY1xnDYd+Ck/ziwQR/4twJHjU0sJV22UI1fdigbwzxnsVxNfN0
	Dp2N3Fs5For6cQVMtNkSi/voKzAqxt+I1jSL84KImwoiODAysGhqRCgMoQQ9wdByzgUJEmohWeJ
	Ni4Hc3Ecy7dqUW6OfVPURLB4U5/KRSlIsD7PWdfrH1OpX/IgU3/ft3VYH+3nhwWgs3KGAPNmZnD
	vJutzI54o1B73L++3tbpS+Q5FkeRTQeTpWlW58ATsMwzMBh17FbCwSwRE1VzeQCsMlb93AMjqIo
	cFy23HkYhq5kEBE3k8ug==
X-Google-Smtp-Source: AGHT+IFiLMT68nSMNgBaSuSlJ+JLaJj7OJOpOwM9krl/tnM9X12Z1SJwMWK8EaN96FbQ1GWCyUBDww==
X-Received: by 2002:a05:620a:294a:b0:864:48eb:34e with SMTP id af79cd13be357-86448eb08f9mr880925585a.55.1759107881875;
        Sun, 28 Sep 2025 18:04:41 -0700 (PDT)
Received: from soleen.c.googlers.com.com (53.47.86.34.bc.googleusercontent.com. [34.86.47.53])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4db0c0fbe63sm64561521cf.23.2025.09.28.18.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 18:04:41 -0700 (PDT)
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
	linux-fsdevel@vger.kernel.org,
	saeedm@nvidia.com,
	ajayachandra@nvidia.com,
	jgg@nvidia.com,
	parav@nvidia.com,
	leonro@nvidia.com,
	witu@nvidia.com,
	hughd@google.com,
	skhawaja@google.com,
	chrisl@kernel.org,
	steven.sistare@oracle.com
Subject: [PATCH v4 20/30] MAINTAINERS: add liveupdate entry
Date: Mon, 29 Sep 2025 01:03:11 +0000
Message-ID: <20250929010321.3462457-21-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
In-Reply-To: <20250929010321.3462457-1-pasha.tatashin@soleen.com>
References: <20250929010321.3462457-1-pasha.tatashin@soleen.com>
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
index e5c800ed4819..e99af6101d3c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14431,6 +14431,18 @@ F:	kernel/module/livepatch.c
 F:	samples/livepatch/
 F:	tools/testing/selftests/livepatch/
 
+LIVE UPDATE
+M:	Pasha Tatashin <pasha.tatashin@soleen.com>
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+F:	Documentation/ABI/testing/sysfs-kernel-liveupdate
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
2.51.0.536.g15c5d4f767-goog


