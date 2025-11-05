Return-Path: <linux-fsdevel+bounces-67093-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 047CDC35436
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 11:59:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A484434E0E1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 10:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1783430DEBC;
	Wed,  5 Nov 2025 10:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DGFGX0B7";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="LvatTV13"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A318D30C379
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Nov 2025 10:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762340352; cv=none; b=tUnNa4YhtZ3S/gXtwDhMl4NXFV6vwGZs2cCZfeR0D/5lG3vNOUx41w8EjH7i+hFJkb//krtCbxBRCquDQXrI9tcUhjpQw0jtZY2eHpu3fenRewBFuQLB55NMtXYLfDf2GkM27D/QZ6Xfdcw8REaRWJF3b5zivBsQflTtr7gIDO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762340352; c=relaxed/simple;
	bh=mDYPQoa9g7C/yEpqbRIi6ESdyE1WLl8zUuyXg+ubNy0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sPXFdHIA+JJgdsx5zKWv1GBlAycR1w66nLo8YsmmZ5clwyKDhD/0XH1sIacUkCubbasaYiALV+8IFAgkZwsBiiWGt1a+Gi80el4yFsENOZYptoUZJw/+3Oc2qP8B6qUwTEh2VlXkv5EYadZ0sr4HrjM0gJUnroQu3bq9d9Pd//0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DGFGX0B7; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=LvatTV13; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762340348;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fi6lMVZB+GdSzEqZmyJtwxQVO8YBPh6HS+ZyxPLOlA0=;
	b=DGFGX0B7I6qnj1MN91y9qP54QK8nyrTmGvB16ssocl4m9Wr58KmDQsTzRtuEmeHO5tk+22
	LPa41LG7FH3TsHiNdzNTgjeVzwr0i848BlPUOVT7u4zX33K3LC3tXaoHi7Scgc4AFF9sWi
	X/bA41aDIifEEOU9j7w1xBc00mfaaSA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-KwoUXVFlPXCjamrW6ISFOg-1; Wed, 05 Nov 2025 05:59:05 -0500
X-MC-Unique: KwoUXVFlPXCjamrW6ISFOg-1
X-Mimecast-MFC-AGG-ID: KwoUXVFlPXCjamrW6ISFOg_1762340344
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-470fd92ad57so85117005e9.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Nov 2025 02:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762340344; x=1762945144; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fi6lMVZB+GdSzEqZmyJtwxQVO8YBPh6HS+ZyxPLOlA0=;
        b=LvatTV13nKsR7HuD2OBSVSCbKiUnsb/3nZT3pBVig03ZtUzIoyWbQ5l+MNvlfzJLdu
         TllfZa51xrADveEhpvutdRd4q0clarkcAoQYBtJMdlJaagffDhpMPFEIIDmo747cLi0P
         3qCZ2OehMcrUl8vpuD/N+WJarCfesqkW9Xq/9oeWO4tLLJb06YnMEGBo0M/GQgTbR45O
         0KVL1bC/ZPnNEKd/wspgrLe4wdW8UrB1mzKuNnGHNcItX/Opn9+2DIeZAw6zmyGEEiRj
         EZIodFfJC/4CXfhkYjpqvegQJX5apkoWmmAE1wXlEAJRLBb3ov8sjBUbAgJI1Tnw9MXQ
         s1Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762340344; x=1762945144;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fi6lMVZB+GdSzEqZmyJtwxQVO8YBPh6HS+ZyxPLOlA0=;
        b=LP6CB83Z6GTPMet4zG0ESkK2txfmuUztsrMOu0BdYrftC7MXbLjYhUs0YODy0aHzVM
         QO6zWPzaGPDfz7SorIWxQMA3OrSqYt9lI9n4qGRBt34y/42gGDii5jwnmkmcvwnV6YbB
         m3q7RX8WDoWE3ASAqTLhPc3/KHZvbtRLtjWy+kVbAw1yovugaaf0LbkmYwFFbBCNAlqd
         3XqatqipMRSBGnJln24A1rWyQ+rVE4AuMRI2kHjxSMCb+G+dFLNCq/FMKk066kqjZkSL
         D04aM6oc/jZgb7yjo21teH5ErEfh3DDux9FX1uJ8xtXVTJE0oU2uS2N3FTda5qwGgVYL
         npDA==
X-Forwarded-Encrypted: i=1; AJvYcCWN6zUj5W326AueYLxlN2L0PTRot7kAl4JCEhehQ8yuQKDH6ycNdwlKDWu5PC6Zi30lRbTXJ555EqFPtJIR@vger.kernel.org
X-Gm-Message-State: AOJu0YzfdeLcoWA6/aJFkp5+T8Wiy7Xc00/vGYQeZCbTviykXRhltk3D
	13FfC+JkF8lqv6JtBq46wJ6aVjSeJ0n59sfSyDhdtSrvQmJcyOCNOfcYSprexpf0qnS6m0K49R/
	X8SssbfK90QdKDBR2aMGZUbCxTUoj3BxlxoR2awWXLXRc05cgDIDCuV+F3EV1lMWupBA=
X-Gm-Gg: ASbGncsRwDyw9PWnWeALoIg9WgDZir4CF2yEQkou3ZUgGWbLCTidQMm6yRA9OXJsW79
	1Ean+wGsQbOfgWFMWqiW9zhD7lEYBh9wv4Vq0erTcwaJN/ahEYFM7CQni4DeFIsi2w80ZHWHjhs
	J6e/8xCdyo5/bYpR7hAF5H/c/3K5FmD8mG7AUn6mzr65Bv8eJsyGebx0gni2yEu4zKPTmKyT9P3
	ycT+IxaSg9PjMMqiFoy1+xukrhDVdWbdd2BtuQ8RgH2lc7eDQ5Uizk3mV0ymWOWH8wSBbcDa4Sd
	rCW2KnY0boxP6pe0hyWVwjkZ8K7R8woveXUbBWUbazoY3xo0p1N2D0RoEP6+qlyPpZdhcC1tL3a
	qnKFnB/ORC+gR0DahhskWFzpLuNzDXPqmVX3v6rEdbFeEvBYn
X-Received: by 2002:a05:600c:a00a:b0:475:d8b3:a9d5 with SMTP id 5b1f17b1804b1-4775cdbf0bfmr23847085e9.10.1762340343920;
        Wed, 05 Nov 2025 02:59:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFGMcjTBOz+Nu6wkEk+5mmod0huDiyH5V1WOUYLCdKWa9YhZHNUKUTSo1PqiQsOwaH+WwN8Vg==
X-Received: by 2002:a05:600c:a00a:b0:475:d8b3:a9d5 with SMTP id 5b1f17b1804b1-4775cdbf0bfmr23846845e9.10.1762340343543;
        Wed, 05 Nov 2025 02:59:03 -0800 (PST)
Received: from lbulwahn-thinkpadx1carbongen12.rmtde.csb ([2a02:810d:7e01:ef00:1622:5a48:afdc:799f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477558c4edasm39000785e9.5.2025.11.05.02.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 02:59:02 -0800 (PST)
From: Lukas Bulwahn <lbulwahn@redhat.com>
X-Google-Original-From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
To: Matthew Wilcox <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: [PATCH] MAINTAINERS: add idr core-api doc file to XARRAY
Date: Wed,  5 Nov 2025 11:58:57 +0100
Message-ID: <20251105105857.156950-1-lukas.bulwahn@redhat.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lukas Bulwahn <lukas.bulwahn@redhat.com>

The files in Documentation/core-api/ are by virtue of their top-level
directory part of the Documentation section in MAINTAINERS. Each file in
Documentation/core-api/ should however also have a further section in
MAINTAINERS it belongs to, which fits to the technical area of the
documented API in that file.

The idr.rst provides some explanation to the ID allocation API defined in
lib/idr.c, which itself is part of the XARRAY section.

Add this core-api document to XARRAY.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2b5f86dcf898..01e1668cac02 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -28010,6 +28010,7 @@ M:	Matthew Wilcox <willy@infradead.org>
 L:	linux-fsdevel@vger.kernel.org
 L:	linux-mm@kvack.org
 S:	Supported
+F:	Documentation/core-api/idr.rst
 F:	Documentation/core-api/xarray.rst
 F:	include/linux/idr.h
 F:	include/linux/xarray.h
-- 
2.51.1


