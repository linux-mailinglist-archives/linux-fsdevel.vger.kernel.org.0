Return-Path: <linux-fsdevel+bounces-57718-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C547CB24B7C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 16:05:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F7CB16A549
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 13:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6728B2F83DA;
	Wed, 13 Aug 2025 13:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PqVbjOtF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B1C2F4A07;
	Wed, 13 Aug 2025 13:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755093456; cv=none; b=Hx0M5LMb2FTJCiLz/klcWNSKusKHyIaQS0fjPJUiD03GGdt0Y5xv1mnvirTMYOdNW0UTJVjxSWdd5ELVdwhKfWPj8h06W/liUWnwJ8umVq0l/bNItoOSszaoqWkHQZns0yb15CfhzJIOfKO+aFIk3ah552uKY3afMNEYJrCqvpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755093456; c=relaxed/simple;
	bh=dwZleO+ECJXYRtkIplELzdB4F/FmMZBsaYbVfGpxaLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g64zNZ9wURjvNNRM6BvR25e0jJnq8Lgx/+j1GaqBvcfqzY9Si15BzD6ajIYpGDvC3aDLD7fpX0Lrji5jA1UjlGIyFi6VK/tiCNf7iIdwNoI7aw27Yf3huKVLDgTHr6lqxUfRbd6i8H/MN7jaa7s7oOrP7kro17vNXME9n9OBqho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PqVbjOtF; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4af2019af5aso75364851cf.0;
        Wed, 13 Aug 2025 06:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755093453; x=1755698253; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F8KvrPpvE8O7r2ITHiw0xMgvWGn8Fo8lwPzPF7CGMas=;
        b=PqVbjOtFySeZlqmlCB36+cWy6un3x5yCeqXuzuWgjPCe9QeOHp2fwfvUp/NvsCFL5p
         z6/zAFRO2mf+Z8mGeT9VC0AZ83gFNsKnyy26gGC16DBQ8CaSrmyQEKDYJl0b22T2AZQW
         R2GD55w31w4iywukbzgqgoTPIoJSQ3KvbNzp3c6NIPO7NUAufxe0YhWg7oL1R/7Ol0ha
         eqy8tVT0a27NLyZlh06S0TBzlLPB87lKYugIGE1TctHc0iI8l6+M7a1ZeY3qEUeMwpHY
         aCydRSY/HPGa50lXELDM0DXnjO8lIM+vrXFpCti9yZ/GyuhTVe0Fh6rJYs13TH++rQQc
         wsAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755093453; x=1755698253;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F8KvrPpvE8O7r2ITHiw0xMgvWGn8Fo8lwPzPF7CGMas=;
        b=GFRdjg2RZsif6HSpLxoAAa/5uIu21fqbY5rH7b6luL967V35+JGUfbKiy6T6YI+w28
         /IEsIRoxi38+audX+h4eHtGeI3YI1U3K0eiIcK6jLMsO0pRQHTECg/vhv/Px+/OS5dpo
         qcjpkf1Zyk3D6ABeIo0/qadvCt9ZF6JaXU4W4wRPChift0ikj44/SCU/EiAyNP+WqyPh
         GuxZ4zh6SiOn4uGObcRoxNwy0hZvhhnTpaQguwOKuOluP+abEpF9L0xd5nvCUvcbDgwh
         FcRK5sciZYe0jm3bDUCbIo5sQAyHpWqs/vsGqTqsMyQ+zCtleCZwOe4aJsydapxq7Rpm
         uzMg==
X-Forwarded-Encrypted: i=1; AJvYcCU9nDXjmamxKposwoTwzYXqeQ2tnl8JIA4/mzkFCJOiw8T883e0c5J/VKwHeFsK6W2hcJT3LDchEk0=@vger.kernel.org, AJvYcCUpBn82iqWq6QCxdCCSLALPeNJvrYrn6aOIZRMWFvr+IF7zoHnZ1jtXNVtvaYiRG6yxJrzI/PT+wWKRDTIC@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz22x4TJbzfMXOAJLDmNb9L37QUDaPU0T+51QcU+LlwJNXFxxi
	z6wSIrZAlL7LFJfsyZh4By6PJFOrShWqZ+7sp8wjrDxSd7CxeIGGRCXc
X-Gm-Gg: ASbGncsgkuZYYfggLJuOq20K0M3UMesNh4fG5m2z/zdR8ffDhh7MQICGYXZkKbzTt9l
	kB2SNkHrpC8GK71mYuZnO6z8b8mVevmcbP96v3gxh24NwKXgiOoRtIaXOLNdGrty9ajyuAFpbx/
	9of8AH+IRSCnuGjKWhlPzF8xtOWwtM8SXofTOqOM9qcN50S48MGYBDmQNSi/ufgeuqGvpkpaRws
	VP35820hBD7A6OZmrNv5yemYatoCbmHSxKHVyumM62QigwDfx1vUNwSZkH88JQHngqjyzimVW3q
	PpX4WiiEu7h0/EnotUkfvWtbVuQb8rcMNXsIwKLk5xLMN5vv4FQP//oQuxRM6+ew+v2xEZuSK73
	ZlRoKEynVRMBxRK2Oags=
X-Google-Smtp-Source: AGHT+IFO7mefK+rYFXL42NudjKdK6tfjHKCVAgyJ/AZ4W5tZA9XVk00/ibsX1hVezDTws24ZfpzPCA==
X-Received: by 2002:a05:622a:1184:b0:4b0:742c:e8e0 with SMTP id d75a77b69052e-4b0fc896084mr37283731cf.47.1755093452947;
        Wed, 13 Aug 2025 06:57:32 -0700 (PDT)
Received: from localhost ([2a03:2880:20ff:1::])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b081827cd7sm120357531cf.7.2025.08.13.06.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 06:57:32 -0700 (PDT)
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
Subject: [PATCH v4 4/7] docs: transhuge: document process level THP controls
Date: Wed, 13 Aug 2025 14:55:39 +0100
Message-ID: <20250813135642.1986480-5-usamaarif642@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250813135642.1986480-1-usamaarif642@gmail.com>
References: <20250813135642.1986480-1-usamaarif642@gmail.com>
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
 Documentation/admin-guide/mm/transhuge.rst | 37 ++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
index 370fba1134606..fa8242766e430 100644
--- a/Documentation/admin-guide/mm/transhuge.rst
+++ b/Documentation/admin-guide/mm/transhuge.rst
@@ -225,6 +225,43 @@ to "always" or "madvise"), and it'll be automatically shutdown when
 PMD-sized THP is disabled (when both the per-size anon control and the
 top-level control are "never")
 
+process THP controls
+--------------------
+
+A process can control its own THP behaviour using the ``PR_SET_THP_DISABLE``
+and ``PR_GET_THP_DISABLE`` pair of prctl(2) calls. The THP behaviour set using
+``PR_SET_THP_DISABLE`` is inherited across fork(2) and execve(2). These calls
+support the following arguments::
+
+	prctl(PR_SET_THP_DISABLE, 1, 0, 0, 0):
+		This will disable THPs completely for the process, irrespective
+		of global THP controls or MADV_COLLAPSE.
+
+	prctl(PR_SET_THP_DISABLE, 1, PR_THP_DISABLE_EXCEPT_ADVISED, 0, 0):
+		This will disable THPs for the process except when the usage of THPs is
+		advised. Consequently, THPs will only be used when:
+		- Global THP controls are set to "always" or "madvise" and
+		  the area either has VM_HUGEPAGE set (e.g., due do MADV_HUGEPAGE) or
+		  MADV_COLLAPSE is used.
+		- Global THP controls are set to "never" and MADV_COLLAPSE is used. This
+		  is the same behavior as if THPs would not be disabled on a process
+		  level.
+		Note that MADV_COLLAPSE is currently always rejected if VM_NOHUGEPAGE is
+		set on an area.
+
+	prctl(PR_SET_THP_DISABLE, 0, 0, 0, 0):
+		This will re-enabled THPs for the process, as if they would never have
+		been disabled. Whether THPs will actually be used depends on global THP
+		controls.
+
+	prctl(PR_GET_THP_DISABLE, 0, 0, 0, 0):
+		This returns a value whose bit indicate how THP-disable is configured:
+		Bits
+		 1 0  Value  Description
+		|0|0|   0    No THP-disable behaviour specified.
+		|0|1|   1    THP is entirely disabled for this process.
+		|1|1|   3    THP-except-advised mode is set for this process.
+
 Khugepaged controls
 -------------------
 
-- 
2.47.3


