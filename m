Return-Path: <linux-fsdevel+bounces-56355-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26471B166DF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jul 2025 21:25:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2DDE7AD35E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jul 2025 19:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA782E3372;
	Wed, 30 Jul 2025 19:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y8cVwUvx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D752E3371
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Jul 2025 19:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753903523; cv=none; b=mmpcvi4PrAkhaJHAxEP5oNYWLvX7B5UGotJj9Vr+K1du59+mfs9laf0ynj0hDfvfrzXb6ugDmTvjijPrJEdp5k55FD8WlzUiH7S3ycUGLVj+pamx52ZA/SCVMsrkpcOgLsRKcfXVlKj0au3503cFfur0UriSBwkQ8vRZYauZ2gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753903523; c=relaxed/simple;
	bh=rwq0k0RYZQX7GCPfsRHZ5S6owb8YHw7Jqnkl6ApF/Ps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D+iACiC5STWtc/rhkhfLupHm+C0DOt4Msh6bdueY03ecGzav4IoTsTDWptahK4rV/Vmbv8SkFvc0uOTLOBc9f7zKF2rVtqJU1pGW2OYo01ZLLZCjdrIGuaPGD4RzzXfSszcxS4/6WqT0nalDAW13E4lTbSsWNRxLDHBTy5BWgmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y8cVwUvx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753903520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mEfzs12KwG9m5a8L/OU1+VFjO5dA7Lh78TnbObJb7DY=;
	b=Y8cVwUvx4j+qFpYPfFxESaoNUdNwNvP82mGevixQYhWFt+NuNyVsm9PJ/+IQOWPNra9wjx
	pt6nsZlFoSLMIzpsO0WIL/bNg/rnaAhn5FHcuaU37LOC0u276H2MDQnd+V+iuwlsQJzMlq
	nbemzbCb/VDJQVXFXJto8HaX8y+IfWY=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-449-BuRpAJ9dPpqDdETGULp9-g-1; Wed, 30 Jul 2025 15:25:18 -0400
X-MC-Unique: BuRpAJ9dPpqDdETGULp9-g-1
X-Mimecast-MFC-AGG-ID: BuRpAJ9dPpqDdETGULp9-g_1753903517
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-87c1cc3c42aso22491339f.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Jul 2025 12:25:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753903517; x=1754508317;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mEfzs12KwG9m5a8L/OU1+VFjO5dA7Lh78TnbObJb7DY=;
        b=gDpXj0tt1P/JFe572UBouIgEh23Diajkq11yTqbME75uNLpRydBSVH+oiMcx8EWupv
         nLMrQe3ZGPcqnaOrequzeOGNSSatgBz/XSHjWRqWraomPW2cCiHYH0L+RKThWi9L1YBz
         Pq1K67z4JUyJGj4lWkb9+JEgF8k5pyQERX/5z2a9Z9OFwbOJAYGcm5gVm9b6QSpZ2xPz
         GmAbd0CJlflQVi2dvoHpEcnOaLKPZ3kj3K+2iSrDVTlzTEe0ra2blkDEvLXkQ6eAQ9gB
         ODPvaa0gUMlzpdkMpza+it0aPcNlhkjDrGu8kyZHDuMJ0DsGcajP1VjNdw488I1uniyf
         MOuA==
X-Gm-Message-State: AOJu0Yx6Fw/URJ63EGv4ItqXj2ZtZtR+f3bQ2pY6m3ucHFLEdvx7FnSr
	DdV2a9AZI9LIbEog3p6ydK2ik1obQ8gWjsq+h5y6uxGApoFHXctQUSopBUHNHRMbI/ouFl0fZr9
	GtBFcWwIYhJTy+MP7196171c6pT3OXPtJksgqjKdPEKT9agUZHA4cnoQb//ZSmN3vN9I=
X-Gm-Gg: ASbGncsTSMOBQy/VZmSwlzUXJCwO/G/yPJXNstUMPw56XAwh6XSiqag57aqO1DfzyBZ
	GVD6aFja71LlbjXGoto3dTWhKuRpCeDe0OXhuBjJvSaMuzMuATPJtPUBlw5Le5icJqU/DFze4et
	PoR89CJBRAwRLBNPBX+CX67ujZj8c0RZPjLPNQT5vAUbISsxzuKqKXSV7x60YIsyO2Vo2B+F9d6
	DzshaE13AArurLMYGs065gEX4akiRzPcnatrMvShxnAl3ugCdJqmdGpuKpWoH4tKu7kUTFbFvam
	HXdQ4yCCAFmIPlf+1V8bCuKwbZFXDkHzKgA2REXWsFm1
X-Received: by 2002:a05:6602:a00c:b0:875:bc13:3c26 with SMTP id ca18e2360f4ac-881377137e3mr868052939f.4.1753903517270;
        Wed, 30 Jul 2025 12:25:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYSI5R0bI3u3DKzzNn3KOYViNQi9Qe6fU6AJs0MUhFISdXELzv3d0ZVqXPrG24JPPMCaPtNw==
X-Received: by 2002:a05:6602:a00c:b0:875:bc13:3c26 with SMTP id ca18e2360f4ac-881377137e3mr868049039f.4.1753903516975;
        Wed, 30 Jul 2025 12:25:16 -0700 (PDT)
Received: from big24.sandeen.net ([79.127.136.56])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-880f7a29956sm284856039f.25.2025.07.30.12.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 12:25:16 -0700 (PDT)
From: Eric Sandeen <sandeen@redhat.com>
To: v9fs@lists.linux.dev
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ericvh@kernel.org,
	lucho@ionkov.net,
	asmadeus@codewreck.org,
	linux_oss@crudebyte.com,
	dhowells@redhat.com,
	sandeen@redhat.com
Subject: [PATCH V2 1/4] fs/fs_parse: add back fsparam_u32hex
Date: Wed, 30 Jul 2025 14:18:52 -0500
Message-ID: <20250730192511.2161333-2-sandeen@redhat.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250730192511.2161333-1-sandeen@redhat.com>
References: <20250730192511.2161333-1-sandeen@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

296b67059 removed fsparam_u32hex because there were no callers
(yet) and it didn't build due to using the nonexistent symbol
fs_param_is_u32_hex.

fs/9p will need this parser, so add it back with the appropriate
fix (use fs_param_is_u32).

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---
 include/linux/fs_parser.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/fs_parser.h b/include/linux/fs_parser.h
index 5a0e897cae80..5e8a3b546033 100644
--- a/include/linux/fs_parser.h
+++ b/include/linux/fs_parser.h
@@ -120,6 +120,8 @@ static inline bool fs_validate_description(const char *name,
 #define fsparam_u32(NAME, OPT)	__fsparam(fs_param_is_u32, NAME, OPT, 0, NULL)
 #define fsparam_u32oct(NAME, OPT) \
 			__fsparam(fs_param_is_u32, NAME, OPT, 0, (void *)8)
+#define fsparam_u32hex(NAME, OPT) \
+			__fsparam(fs_param_is_u32, NAME, OPT, 0, (void *)16)
 #define fsparam_s32(NAME, OPT)	__fsparam(fs_param_is_s32, NAME, OPT, 0, NULL)
 #define fsparam_u64(NAME, OPT)	__fsparam(fs_param_is_u64, NAME, OPT, 0, NULL)
 #define fsparam_enum(NAME, OPT, array)	__fsparam(fs_param_is_enum, NAME, OPT, 0, array)
-- 
2.50.0


