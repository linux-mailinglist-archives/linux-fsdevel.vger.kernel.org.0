Return-Path: <linux-fsdevel+bounces-19365-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F4868C406F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 May 2024 14:06:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A09B81C22776
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 May 2024 12:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DAD414F111;
	Mon, 13 May 2024 12:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fFcNCDDR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9E914B097;
	Mon, 13 May 2024 12:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715601990; cv=none; b=ByNx6eiG9PSU+jRFMsl5tylLoQIH4pqot7j0RMFNR8y7WhStRAaiEbroycmg2AqptHuF7xBXjHV7oBMq+RZAEyIr590wF3xDJefMQiLLKVDa6mQMnmsLtgRPEqxIwBuupfqyAWsl34gARwdougLUadm3M5n8jPbGELZADLvik80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715601990; c=relaxed/simple;
	bh=PlS+KhBbiQSxy8kciTdJ82XjeOSaREimicSvft5VoD8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=a1ecP8fxpPMznTNIexgOguDkncWVDTj/Utsgh/6hpXonikdB3QLQoj8T02nOraC5KU0toPmNosOrpv5qSunyEWVZJu16yVqAgqDIi0UDj4gktiaY1mOBMmQcpiuW1Z148RBPDdsZ20r/WSOALltAEvADQcDMEvL6U/1vxeHI/lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fFcNCDDR; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6f4e59191a1so2062470b3a.1;
        Mon, 13 May 2024 05:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715601988; x=1716206788; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nzzkXIpspGxlK9arGRKGa5KvjuMpX98o0VZp6Fx/3xo=;
        b=fFcNCDDRe1Lr1cn7Hg02A0nSDKAaYDl4Taf5ziUL1fx0689n5K8zZnsju6JLu2S1TY
         DILDVomQx25g8guXR4LsHPG70NnyRKHkOjAC1UMuDDdcmapUSKdRsXWta+0rzsC4ONg5
         RACbtR24kxJVxb29XbUShkcDLKx0gE5rtcLUChKXAIh/qmQvqXjlUzePNQc3ae5qyhlI
         5UMQn86edJW5aiimNHheJABbR+aNP5E5Q7KHXVB4k6URVjQJV3jWCNrazZOyKWf40Q2T
         9tE6HHnNuWaUtXoMS/ylAR9QDdrXA1Z9/tQqTSQgXPVy6/HEcG5XLY5GIGomwhvadcIx
         YS4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715601988; x=1716206788;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nzzkXIpspGxlK9arGRKGa5KvjuMpX98o0VZp6Fx/3xo=;
        b=VVb08ClTx+t+YlVG+QE5/K6Dpvj5/3Zgh1bGo3HxKbgsPMmXq96vaJFvswvHUtpbnk
         +gELn9leuOUdVJYxxFTm4rQjQAhMOHg2FRzF4nBqhb6kpeUzMQb1CBvSeOFdfPoNLbLP
         6Vq5LWA6g5CHqsHX+0SBvl0fLBzzAP3CRK00Z25DZanAtHMtvKAAq5B3hteX2wigDTKe
         klmEWzrh4bs4SuITN8ZzvS+RYLSEBStwq4pOxvYt819Bl1j886CRnlXUEvSmfayNUib+
         wvs3iVJ+em/jx8TMv+VIOZF/Ayvy/VyVKxseLpdKpNPJplgsqruetq8u3PrETeTcHGsl
         cnpw==
X-Forwarded-Encrypted: i=1; AJvYcCV5mhJ3ZHht3EfTv0ZQQ/5jHZzJc+GxMAnCMoXxLQpXkI2qEwXNNN1YmFG1Wjaf6wfH4ogb9TDWEohUf+JCGQXyvxMGq2IzT9fHZ/iXqg==
X-Gm-Message-State: AOJu0YwA55ztJQq1ftMtAu6jGOqGxQtKtjBWSIaOG+FOSKD+SkYkFzg9
	z1eCdKYxm7P0URjEIeUDC1zygbSnnNeRct/DweowKDv6IH8asX166Pz4dAhv
X-Google-Smtp-Source: AGHT+IEOkHXszBhRM1dw00wR72iQ8gy1feLCWvMWIynMNzbZmpBBv+ozSiaYNzJWY/2oDNW2aQrTYw==
X-Received: by 2002:a05:6a20:748f:b0:1ac:d96a:4fd6 with SMTP id adf61e73a8af0-1afde0d54b7mr10078265637.23.1715601988481;
        Mon, 13 May 2024 05:06:28 -0700 (PDT)
Received: from AHUANG12-3ZHH9X.lenovo.com (220-143-204-48.dynamic-ip.hinet.net. [220.143.204.48])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2af2b1esm7446131b3a.171.2024.05.13.05.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 05:06:28 -0700 (PDT)
From: Adrian Huang <adrianhuang0701@gmail.com>
X-Google-Original-From: Adrian Huang <ahuang12@lenovo.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Jiwei Sun <sunjw10@lenovo.com>,
	Adrian Huang <ahuang12@lenovo.com>
Subject: [PATCH 0/2] genirq/proc: Speed up show_interrupts()
Date: Mon, 13 May 2024 20:05:46 +0800
Message-Id: <20240513120548.14046-1-ahuang12@lenovo.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since there are irq number allocation holes, we can jump over those
holes in order to speed up show_interrupts().

In addition, the percpu kstat_irqs access logic can be refined.

System Configuration
====================
  * 2-socket server with 488 cores (HT-enabled).
  * The last allocated irq is 508.
  * nr_irqs = 8360. The following is from dmesg.
     NR_IRQS: 524544, nr_irqs: 8360, preallocated irqs: 16

  The biggest hole: 7852 iterations (8360 - 509 + 1) are not necessary.


Test Result
===========
  * The following result is the average execution time of ten-time
    measurements about `time cat /proc/interrupts`.

  no patch (ms)     patched (ms)     saved
  -------------     ------------    -------
           52.4             47.3       9.7%

Adrian Huang (2):
  genirq/proc: Try to jump over the unallocated irq hole whenever
    possible
  genirq/proc: Refine percpu kstat_irqs access logic

 fs/proc/interrupts.c |  6 ++++++
 kernel/irq/proc.c    | 26 ++++++++++++++++++--------
 2 files changed, 24 insertions(+), 8 deletions(-)

-- 
2.25.1


