Return-Path: <linux-fsdevel+bounces-70678-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 81468CA4141
	for <lists+linux-fsdevel@lfdr.de>; Thu, 04 Dec 2025 15:45:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6DB6230434D2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Dec 2025 14:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32FD922CBF1;
	Thu,  4 Dec 2025 14:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aisec.fraunhofer.de header.i=@aisec.fraunhofer.de header.b="l53Srktk";
	dkim=pass (1024-bit key) header.d=fraunhofer.onmicrosoft.com header.i=@fraunhofer.onmicrosoft.com header.b="K+TVBXWp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-edgeka24.fraunhofer.de (mail-edgeka24.fraunhofer.de [153.96.1.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78C92DFA5B;
	Thu,  4 Dec 2025 14:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=153.96.1.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764859528; cv=fail; b=rehYwnrwdWUAKSGtAvIWcqmApXVDb3Zig5yAz9pZbsre+zqRsg1xfxbGluE59Gd29Ohjt6H0IPVRRa0l4SVnYZudu+TnExfXuQ8rIxZHzws0DWQymesmaRsgcc458iYoEkvqqJ0HGoYSYXDz3BYODVIC1PvrgRhWS8imdbrMs34=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764859528; c=relaxed/simple;
	bh=RLMriuCadsnJtGQYE3HzU9vrXSvvNC0CshUqifJncdw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BLTxtvW0pAbSTM/NN7OOD6kgpnS993oUGv0DBbXKFdifb1ibmJcw92quCefoUxKZQ0NhIzMKJIwJkebwEEN42EtuKSH1fQBGLcFB1hPY58Edvk23qjlliPqp9qgZM5pvDmpGaK6pFr3h7HCZDF/wMm0g7cGWDGSWiibJZHH4Huk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aisec.fraunhofer.de; spf=pass smtp.mailfrom=aisec.fraunhofer.de; dkim=pass (2048-bit key) header.d=aisec.fraunhofer.de header.i=@aisec.fraunhofer.de header.b=l53Srktk; dkim=pass (1024-bit key) header.d=fraunhofer.onmicrosoft.com header.i=@fraunhofer.onmicrosoft.com header.b=K+TVBXWp; arc=fail smtp.client-ip=153.96.1.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aisec.fraunhofer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aisec.fraunhofer.de
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=aisec.fraunhofer.de; i=@aisec.fraunhofer.de;
  q=dns/txt; s=emailbd1; t=1764859525; x=1796395525;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=RLMriuCadsnJtGQYE3HzU9vrXSvvNC0CshUqifJncdw=;
  b=l53Srktkgd1eDJYW1yHsqChx5yu3cYAlypBCts9TQHpB4CS5KFDVT+sH
   MnS3TVK8QyKvPNgb8Rqwlao4nG69w28KFUnsNuW27fvY4JmSy4ge/t1iH
   6EvI7KKIduashRi8ex9gdiUNhhKTzgsuTxEMWOuxdCwc3UO56cvsrZY+f
   TohoRevR8pSXx0LcZjR0Ogc7FX9fkR2k51RC8oHH9XjtduE4wVjlaY7SS
   ToOqAdoS81N+QGPY+t0yO3leHP7LnB25NA7BJvWeJZ9EUr87zI9OSS1oE
   yEVBQFN1m9HFRfffxoDqC61+LcH6vpOV/VNSw3ePcX2gEPo1GnAOPf0xP
   A==;
X-CSE-ConnectionGUID: niQwG+g9T8+9sEmB7giLOg==
X-CSE-MsgGUID: 6DXYYGflQuCzHMMv/OyF9A==
Authentication-Results: mail-edgeka24.fraunhofer.de; dkim=pass (signature verified) header.i=@fraunhofer.onmicrosoft.com
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A2EqBACbnTFp/xoBYJlaHgEBCxIMggULgkBAAYIvszuBK?=
 =?us-ascii?q?4ElA1cPAQEBAQEBAQEBCAFRBAEBAwSFAAKMaCc2Bw4BAQEBAwEBAQEBAgUBA?=
 =?us-ascii?q?QEBAQEBAQEBAQsBAQYBAgEBAQQIAQKBHYYJRg2CW4EsgSYBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEdAjVWBjIBDQEBNwEPC0YxJQYOBYMCgiUEEgM2tESBAYIMAQEG2ywYY4FkC?=
 =?us-ascii?q?QkBgUGDfIFygmUBhH1xhHg2gVVEgUqCdT6EWDiFd4M0mVlICngcA1ksAVUTD?=
 =?us-ascii?q?QoLBwWBIEMDNQwLKhUjDzwFLR2BIyEdFxNgPRdAg0kYBmcPBoERGUkCAgIFA?=
 =?us-ascii?q?kA6gWYGHAYcEgIDAQICOlUMgXcCAgSCFX2CCg+IAoEIBS57JwMLGA1IESw3F?=
 =?us-ascii?q?BtEbgeUHU+cegGvazQHgjiBZ4FeBgyfZxozg3EBk26TCy6YWKkVAgQCBAUCE?=
 =?us-ascii?q?AiBbwuCBDMaJIM2UhkPjiE+g0K8XncCOgIHCwEBAwmSHoFLAQE?=
IronPort-PHdr: A9a23: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
 Q+TFj07pHqBX73ZGA6U8kB9qHzTVZusMhmq
X-Talos-CUID: =?us-ascii?q?9a23=3AgB9KH2gEvj42f1EBtKOODMx44TJudHzk01iTLB6?=
 =?us-ascii?q?EWSU4U5CQYwCf+YdDnJ87?=
X-Talos-MUID: 9a23:25mobAsTK3+GnaE/bc2n2h1SBfZH7aCXFWsfsbAjpY6jJAIhEmLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.20,249,1758578400"; 
   d="scan'208";a="35871574"
Received: from mail-mtaka26.fraunhofer.de ([153.96.1.26])
  by mail-edgeka24.fraunhofer.de with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 04 Dec 2025 15:44:10 +0100
X-CSE-ConnectionGUID: HmHjYoAtS+KV2c6fRPZRiA==
X-CSE-MsgGUID: GjCXFgKuTfKP0qnCQAc/Ug==
IronPort-SDR: 69319e38_7QVPJ7caZDcnnC+BFIN5k2fH+a8LNGYRNCOocaycHj58uW5
 329d4NNK8UlC0gPg9imp1cY9CWdz3IPgJ6mqLSA==
X-IPAS-Result: =?us-ascii?q?A0CCBQConDFp/3+zYZlaHgEBCxIMZYEgC4FuUkABgSYuW?=
 =?us-ascii?q?4ghAQGFLKVrgSuBJQNXDwEDAQEBAQEIAVEEAQGFBwKMZyc2Bw4BAgEBAgEBA?=
 =?us-ascii?q?QEDAgMBAQEBAQEBAQEBAQsBAQUBAQECAQEGBYEOE4ZPDYZbAgEDEiABDQEBN?=
 =?us-ascii?q?wEPC0YxJQYOBSKCYIIlBBIDNgICAqYkAYFAAoxXgQGCDAEBBgQE2yQYY4FkC?=
 =?us-ascii?q?QkBgUGDfIFygmUBhH1xhHg2gVVEgUqCdT6FEIV3gzSZWUgKeBwDWSwBVRMNC?=
 =?us-ascii?q?gsHBYEgQwM1DAsqFSMPPAUtHYEjIR0XE2A9F0CDSRgGZw8GgREZSQICAgUCQ?=
 =?us-ascii?q?DqBZgYcBhwSAgMBAgI6VQyBdwICBIIVfYIKD4gCgQgFLnsnAwsYDUgRLDcUG?=
 =?us-ascii?q?0RuB5QdT5x6Aa9rNAeCOIFngV4GDJ9nGjODcQGTbpMLLphYqRUCBAIEBQIQA?=
 =?us-ascii?q?QEGgW8LKoFZMxokgzZPAxkPjiE+g0K8XkQzAjoCBwsBAQMJk2cBAQ?=
IronPort-PHdr: A9a23:r+ZnWRywLEFuvLDXCzKQy1BlVkEcU8jcIFtMudIu3qhVe+G4/524Y
 RKMrf44llLNVJXW57Vehu7fo63sCgliqZrUvmoLbZpMUBEIk4MRmQkhC9SCEkr1MLjhaClpV
 N8XT1Jh8nqnNlIPXcjkbkDUonq84CRXHRP6NAFvIf/yFJKXhMOyhIXQs52GTR9PgWiRaK9/f
 i6rpwfcvdVEpIZ5Ma8+x17ojiljfOJKyGV0YG6Chxuuw+aV0dtd/j5LuvUnpf4FdJ6/UrQzT
 bVeAzljCG0z6MDxnDXoTQaE5Sh5MC0ckk9yJy3f7QzRV5vqtAnmmdNM9XK6L/CnU6oEYiq8y
 YwzYwTotT4GORw/+23I358V7upR9THimyJV87HMa5qkHflnUobGY8NZQWlPV91rURJoLq6lc
 LshEOcxIN1ij6zljgQujDKRDDu1Ps7L5x1lrV7mhocozcYaC1795jVjGIoVqUbqiu3ZGKgxS
 LDqz/XE3Bb/fuFMgznn+NGZTTsoovu0Wa1MbpfRkxN0GDrIklm/maP5FBCfx+cqrki/zto6C
 fOFlFcI7Coomiaf1NUUja3SnZwZ7VSf0CQn3okQLojrAF4+YMSjFoNXrT3fLYZtX8c+Fnlho
 z1polVnkZuyfSxPzYgu5DeFNbqJaYGV5BLkWuuLZzt11zppe7O60g676lPoivb9Wc+9zEtQo
 2Jbn8PNuHEA212b6sWORvZnuEb08TiV3h3V6uZKLFpykqzeKpU7xaU3mIZVukPGdhI=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:IS5elqOHg9u/TMBcTz3155DYdb4zR+YMi2TDiHofdfUFSKClfp
 6V8cjzjSWE8wr4WBkb6LW90dq7MAnhHP9OkMAs1NKZMjUO11HYVb2KgbGSoAEIeBeOvtK1t5
 0QC5SWYeeYZTMR7KbHCWGDYpMdKbK8gcSVbJLlvhFQpHZRGsZdBmlCe2Sm+i4ffngAOXJnf6
 Dsv/auwlKbCDAqR/X+IkNAc/nIptXNmp6jSwUBHQQb5A6Hii7twKLmEjCDty1uGA9n8PMHyy
 zoggb57qKsv7WQ0RnHzVLe6JxQhZ/I1sZDPsqRkcIYQw+cwDpAJb4RFoFqjgpF791H22xa3u
 UkZC1Qfvib3kmhMl1dZyGdmzUIngxeqEMKgmXo/EcL6faJOA7SofAxx/MATvKe0TtngDg06t
 M040uJ85VQFh/OhyL7+pzBUAxrjFO9pT44nfcUlGE3a/ppVFb/l/1rwKp5KuZ1IMvB0vFRLM
 B+SMXHoPpGe1KTaH7U+mNmxdCqU3wpWg2LWUgPoIiU1CJKlHdyww8ZyaUk7wc9HLlUceg02w
 3pCNUbqFgVdL5oUUtUPpZzffeK
X-Talos-CUID: 9a23:1QZj7mDPCXGQY4T6Ewli1EwlHek5ST7+8i3bfUGCMVRTSZTAHA==
X-Talos-MUID: =?us-ascii?q?9a23=3AkP7wMQ4+fOcNambKSgrzI8sXxoxH4Y+eJk8ujKk?=
 =?us-ascii?q?ImPHcLCpbAh6Wywm4F9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.20,249,1758578400"; 
   d="scan'208";a="34567113"
Received: from exo-hybrid-bi.ads.fraunhofer.de (HELO smtp.exch.fraunhofer.de) ([153.97.179.127])
  by mail-mtaKA26.fraunhofer.de with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2025 15:44:06 +0100
Received: from XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) by
 XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 4 Dec 2025 15:44:05 +0100
Received: from FR5P281CU006.outbound.protection.outlook.com (40.93.78.54) by
 XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Thu, 4 Dec 2025 15:44:05 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CVgl84sc9YCONy30MD3X2ixRS8YmPNllwrQoLaieSj445hOumLaz5PSJDJkNfzGsFfxrE773Yg898/guv84JVt3p8rIQOdSlzRNa0iqqFM1ZXnJ9TqTVQ6wL++c8hFcgKkOjZY2DmbpmAZ0Wi6PXvD4o1aNnFo8/arsF6Mda2lZFzDfA5rCKEnBJzVQq+VOiqISaf9JUH0zh3tv3T/UUz1pebkSrOLdpMkK5KipDaavN96tH6/ibe+8GRkKM0wK8Xai535bsFUt0k2KpHEdjCTyAkI0yl172QWnaaL0c4yxlQUvdpjORAZVkFF2OmS/ZFkdVE0Kln6K4Pxk2UyEGRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RLMriuCadsnJtGQYE3HzU9vrXSvvNC0CshUqifJncdw=;
 b=ZiWklyIx4Hi495EsPWUnIrh4ajWP3vnk4/+MLvOuu5v0QQKYlWoKOh/cY6lS8SqqEPumWegQ/q7+la+518RgC4J8RaOi8+szmrOlfj4ipdP0lVY/7dZleR8zDXWbwLYHxnWpdZTiriWbGB4X2vQIX1oXVISItMnEiWJ7ydDq0e9dr5afu1ZLoxIx2SNcWui3f833QO7Yt7myrCIxV+ED5yh+7+5TDMPoyMEqmsWKHOTLCb0JafssZJFD4RbiCHHZ1I16eD7hKpiUJrLNgZEDCTd4I2YTIiAL3LWqlOY92lpBAHmj08GuWCLCwJsh7bjPOVGwF4jjBcrU3Pg6Bp706Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aisec.fraunhofer.de; dmarc=pass action=none
 header.from=aisec.fraunhofer.de; dkim=pass header.d=aisec.fraunhofer.de;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fraunhofer.onmicrosoft.com; s=selector2-fraunhofer-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RLMriuCadsnJtGQYE3HzU9vrXSvvNC0CshUqifJncdw=;
 b=K+TVBXWpcsYAkqDMsvx+lkfasRnVADEqwXFweXuSRHMpA7HIAGaZqRELEJECIx3BzvJSr7SRQ+o0sqZVNPDDgKq87k4dyKTyzr2frx19WCakbPlwTw5h223gQetdGXGtCKbykOuHLIX24yBwQG/C1PvXzzPoLssvdOl3Mi6vgMc=
Received: from BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:43::5) by
 FR2P281MB0026.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:c::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.11; Thu, 4 Dec 2025 14:44:04 +0000
Received: from BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM
 ([fe80::ae34:1ec2:9d34:a9fb]) by BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM
 ([fe80::ae34:1ec2:9d34:a9fb%5]) with mapi id 15.20.9388.009; Thu, 4 Dec 2025
 14:44:04 +0000
From: Andreas Korb <andreas.korb@aisec.fraunhofer.de>
To: <devnull+debug.rivosinc.com@kernel.org>
CC: <Liam.Howlett@oracle.com>, <a.hindborg@kernel.org>,
	<akpm@linux-foundation.org>, <alex.gaynor@gmail.com>,
	<alexghiti@rivosinc.com>, <aliceryhl@google.com>, <alistair.francis@wdc.com>,
	<andybnac@gmail.com>, <aou@eecs.berkeley.edu>, <arnd@arndb.de>,
	<atishp@rivosinc.com>, <bjorn3_gh@protonmail.com>, <boqun.feng@gmail.com>,
	<bp@alien8.de>, <brauner@kernel.org>, <broonie@kernel.org>,
	<charlie@rivosinc.com>, <cleger@rivosinc.com>, <conor+dt@kernel.org>,
	<conor@kernel.org>, <corbet@lwn.net>, <dave.hansen@linux.intel.com>,
	<debug@rivosinc.com>, <devicetree@vger.kernel.org>, <ebiederm@xmission.com>,
	<evan@rivosinc.com>, <gary@garyguo.net>, <hpa@zytor.com>, <jannh@google.com>,
	<jim.shu@sifive.com>, <kees@kernel.org>, <kito.cheng@sifive.com>,
	<krzk+dt@kernel.org>, <linux-arch@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-riscv@lists.infradead.org>,
	<lorenzo.stoakes@oracle.com>, <lossin@kernel.org>, <mingo@redhat.com>,
	<ojeda@kernel.org>, <oleg@redhat.com>, <palmer@dabbelt.com>,
	<paul.walmsley@sifive.com>, <peterz@infradead.org>,
	<richard.henderson@linaro.org>, <rick.p.edgecombe@intel.com>,
	<robh@kernel.org>, <rust-for-linux@vger.kernel.org>,
	<samitolvanen@google.com>, <shuah@kernel.org>, <tglx@linutronix.de>,
	<tmgross@umich.edu>, <vbabka@suse.cz>, <x86@kernel.org>,
	<zong.li@sifive.com>, Andreas Korb <andreas.korb@aisec.fraunhofer.de>
Subject: Re: [PATCH v23 08/28] riscv/mm: teach pte_mkwrite to manufacture shadow stack PTEs
Date: Thu,  4 Dec 2025 15:43:29 +0100
Message-ID: <20251204144329.10409-1-andreas.korb@aisec.fraunhofer.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251112-v5_user_cfi_series-v23-8-b55691eacf4f@rivosinc.com>
References: <20251112-v5_user_cfi_series-v23-8-b55691eacf4f@rivosinc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0213.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::7) To BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:43::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BE1P281MB2435:EE_|FR2P281MB0026:EE_
X-MS-Office365-Filtering-Correlation-Id: e369e008-28dc-4eba-ce78-08de33439254
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016|3613699012;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?N7dVDwzyjuBVhR2jNDXolvyxdgkbbGNYYCP6rG757E6FpfZoYozGxEI+zBgP?=
 =?us-ascii?Q?XxDeWnTT8oC9oHB6cHWEBmMxC9gw6e6mU9mGPTvWuSWiQVLw5wManlI2SP/q?=
 =?us-ascii?Q?IoQ1SkXESPTeYRobanJ7jGxbEjwaZ16XrbFryUZDXXiZXL6s9kSyclmXBDA3?=
 =?us-ascii?Q?8gVyLVpMrFcziTKvENAZN9jpfuQdNmH7a54/4jhzvvZmFAoflwqHSFAdlMQq?=
 =?us-ascii?Q?2uOmctU9+Mxff2UKZwMy3FETlIl6S3Z4iDWzvWDqGrJLB8Fqre/ufnxXC/QO?=
 =?us-ascii?Q?eVeWsWIysR0ToS8qT2c738ImZna/+egxK+tFq2Udmd2LklUj9ut7HP+mCObB?=
 =?us-ascii?Q?lhFHcvDvPYUyw5lUpE+Nn7xw2MvMDrC4uNdfqBFvfmkz4w9zho+CtlHyAhmG?=
 =?us-ascii?Q?MTVwrryrsgq8qwxRbFgyb7+bWeYFCoVkJWKxjXjrqQQgpqdOvGyufBZ/1VC9?=
 =?us-ascii?Q?Sl3fMJV5Bhqb9pNHJQXfIN0YiWEfuwygRQv6hu/A8HJlLu0LbzOhiRL8Wtnf?=
 =?us-ascii?Q?rMeD3B2xK8EEaVhLVL+3BjvpG72YQInifnKPlMuFbrmvbZnZrkRup9ydNoXc?=
 =?us-ascii?Q?UbUF12lv34nxk44SgRI4nyf5DbuqFzK6XwsSB/yiLbYR1tgX8rLmBG+1tOxL?=
 =?us-ascii?Q?4HhwgcVkNnTpUpVNbbnnjjMr5jnvT6cGOOtTg+i49JvaYQIssRxAoC5LKeiA?=
 =?us-ascii?Q?azi1MyQUMyo2N7D54qGwOx2Xyj2NRRMzKhehwsQbv46DRoiw+aAn0oLVpEVc?=
 =?us-ascii?Q?xKeEqusI1e1DUbEvnAtzIf3ik+rqn/o9evKY2TXrmgwa27RX7TuDE6KdOsXc?=
 =?us-ascii?Q?LT0t1trT9FpRoeRv4Jxvy/G8FNIvyvLUjhfE/fslHzU3lWlvKp+4ZOWlVfrk?=
 =?us-ascii?Q?YAXdmEDn/DVQRdsWbRjh3LitcaqS59qOI+u7aBnQieRpvnNChkHei2WUcGag?=
 =?us-ascii?Q?FoAOsIq+4tb7KxJYQelJtH+dNPtLUtyxQ40Q1K8pbFI5haeVc+JTn5ZXEiX0?=
 =?us-ascii?Q?UA2LkW12Y1ewD4YYDvbDZj1Qok1w6ezQJMTWnejFF00A/7Wc8OWiTOap2lFz?=
 =?us-ascii?Q?3cOsBuyZse6tSpwIpP/+IXOtgMd/1UZxP7jCHRKDrXjsUEmDD7s8o/AWyZNj?=
 =?us-ascii?Q?/e48y6z4ZbWF2tIPXGLO7UQf+4+6dDLP1tELbLV2bxEO1uwkIo28GwbpztrR?=
 =?us-ascii?Q?o74+YTo+Dz7LhbKS08mmTopD8sksgT+CJfEmggiigt84td3Yr/hwK8HdOMWf?=
 =?us-ascii?Q?6LatStEPajSQou0nQpTB72Oi133gEEWuzpVT/alkrTCo+hm+8uPa8XKgL3uf?=
 =?us-ascii?Q?ec25yBFGXD4bYkm51pOzgm97gGXCA+M670FwHfT61FzTOdCtUdt2fYiFlbjB?=
 =?us-ascii?Q?Pk1TlBiFGMBBwTId9mw1/clWaLFN0dsR3qTiqWFUcpt5RgCJPFYtN/3NeC1g?=
 =?us-ascii?Q?lVEkqakObuZH6LXqlnHggolsVFA5pow2xGevai2hAwxs/jEgXS+PSnz6u5Bb?=
 =?us-ascii?Q?odceIoLZsxBq5A1gBtYI5oo8VvKPaQM8Z190?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(3613699012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YkrlzUkfNEdmtETDPPNPUPvNVuDzrP/sh2piJP47IsHstMFQnJ+RW+me5yOM?=
 =?us-ascii?Q?FIUFKZe0lYa1d7xKfTK9rPLTyYJXmaTikMcsVxdScw611y+qR9WtfckbBIoh?=
 =?us-ascii?Q?sDHI00NppEp70clGTp8T4Zhf6bIRo+5Zpq7Nn3MW4H72KzpWmzpl820qcyvZ?=
 =?us-ascii?Q?mhXUhA32O2/Jbv5ER+91qxi4G5FVQqqSJ3kdpOjq/X6/pHIEtqxEIrlf60PF?=
 =?us-ascii?Q?gYAjdyXgKyBWfXqKSKR89SqmrQrIL5XMVE9NyNkE6kMGjacymquv+hSkNk7A?=
 =?us-ascii?Q?5SnYk/491PnHRGVcL/qG7+IOxw3S+pMguE/kH7mNanPWTU0V3kpD/iQWSp+I?=
 =?us-ascii?Q?FjPfyB2YevE5myhJ8JxrfU3L0W62NxxqvwG59ftz8fVkFt++/ATIIlGaLbXP?=
 =?us-ascii?Q?KsM4Te0nYdEWZ2r3c5oYG6gN3GnBNCjJA014hHXKSeyM9bmROStdqJUONoEo?=
 =?us-ascii?Q?GE3LS9XQh3KPbV1er9mmphfDyj0o3cDiZMGN6s9dudb1F8SETgODvDNlINza?=
 =?us-ascii?Q?PYt6Kv+QclSIl+L/+Kti4Od5VEg9Sb0JMw4qFaMobIXw5LQu/TVKGz9vpYD2?=
 =?us-ascii?Q?27gwgDLwVIifZT9xL6TMNCfvIHsGNjSp4V1f6FPG38cSiGRnlvrOZQ5QKr6D?=
 =?us-ascii?Q?PkaxGkuVtblmKF0vENrt2ZVJAm8hl1PqCYb2NGSOoSLuGltvdORBb+tsSrlK?=
 =?us-ascii?Q?kohepcZlJLAylHMpp1xnFAeMY++7hUl3RgUmuzua97A8W5zctvnDF0+A5SJS?=
 =?us-ascii?Q?4Rvjg1zG4a992UGCGxC6k9QFWdbvDO+GZIbiVfw4qvVF0X1JXgoB+l5PKzRn?=
 =?us-ascii?Q?de7PGbghDiYKMhKNGtRB7PoQPX0DZJZwlyftkU5ItvM2xpW12Nd4E2PiqIHG?=
 =?us-ascii?Q?nhCPTsBCHGfiG6euIpt6Afqw+pNOmzEqfYIRt0KvxK9iM/Xv8XjuyzRI9UjZ?=
 =?us-ascii?Q?htNnpnYhz4zayG2ma6AFxoXK9SthMvARnA6yeYahCy+ebLeB0eCWCMF6A3Uw?=
 =?us-ascii?Q?J5YcStesj78Bn3GCquiPS/4qrfRrDdZZrN3gZ7v87SNVQ3aJN0PfpiJfiL0P?=
 =?us-ascii?Q?dV1i2TYbeULExgoLdtq593VzpczZJ03y7p8OrPfChDbQ8/y2012954gx2Xw7?=
 =?us-ascii?Q?f9gBxmv9dgI21kbEKnUJIi3C69dch6tg5EJc6NPU7aGB36IigRcg10BasjrO?=
 =?us-ascii?Q?1G9JBJly69XoM+t6z7Jkms+aoLuz6q72pntlo7VpztxqlfyUJGDvfERSgF06?=
 =?us-ascii?Q?xC8FZaTIk22nQasBHEgtFrR41EvtwAPzA8DU+1GOGk9SVZnsqQGrJSlxrpfx?=
 =?us-ascii?Q?eyfsv31GZURFPnIk6/+r+R8Dpw6rE4Eb012swmC0zof+bBxTKCFd9WZ8eIS1?=
 =?us-ascii?Q?n7nXYrYjf4iELnN+pQ3tBEuoDSt6fDiasueaX7AZ6x60XTL4qMzuz/AJoU1U?=
 =?us-ascii?Q?EVODuX9bp2fbcgESYYgDvbWpXc3CaF+snT1wEzS50kMwJNP11XXAW8C0ZLta?=
 =?us-ascii?Q?QhUDBxvrvm84E6l8Ks/qrAVCDNQ+fa0kbz4zrcwtxSlTC5hitW6mqN17LeJt?=
 =?us-ascii?Q?+W0g+QX+LCd3nui5BkrBRnwm7LaJJAzpf2PHhg9OgwTa1nCOI00ejRomRLNY?=
 =?us-ascii?Q?YN2nIbFZyEFYwmA+qWB5tPc=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e369e008-28dc-4eba-ce78-08de33439254
X-MS-Exchange-CrossTenant-AuthSource: BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 14:44:04.5534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f930300c-c97d-4019-be03-add650a171c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oyKmcvooFEabj3ZKT/rPZ0WQoV+YL5IRiyK+TvBNRkh7YOuE6oRDGoMxEvTko3FyKGglwm38O1xdUu2hbsaEc4RL2RyaYTZ7giok3/on3kI6RrctjTC0W2eBRpxRNN9m
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR2P281MB0026
X-OriginatorOrg: aisec.fraunhofer.de

Tested on qemu and on a custom hardware implementation of zicfiss and zicfilp in the CVA6 core

Tested-by: Andreas Korb <andreas.korb@aisec.fraunhofer.de>

