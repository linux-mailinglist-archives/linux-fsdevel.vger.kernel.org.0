Return-Path: <linux-fsdevel+bounces-70684-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C6A4CA41E1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 04 Dec 2025 15:56:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 540B4302C47F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Dec 2025 14:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 841E2280A29;
	Thu,  4 Dec 2025 14:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aisec.fraunhofer.de header.i=@aisec.fraunhofer.de header.b="GDanaUuC";
	dkim=pass (1024-bit key) header.d=fraunhofer.onmicrosoft.com header.i=@fraunhofer.onmicrosoft.com header.b="G/Vvui3w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-edgeka24.fraunhofer.de (mail-edgeka24.fraunhofer.de [153.96.1.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6961027FD59;
	Thu,  4 Dec 2025 14:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=153.96.1.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764860205; cv=fail; b=Z13OKr9JLaeFFeEd25IfieZCBfVVBbfHDWw8R7smJoz7AnQPTbGm/Eq1N57ruUD2jjVbwQrjpHWQcHoh1047HhmpVLblKJf9iEYHpuv3Uvgs71S/Gq0G3eBDgxum5SmDLYwC6LFSK42keEBJH1vYc0MceTTYmj8dG49i77Mj1jM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764860205; c=relaxed/simple;
	bh=RLMriuCadsnJtGQYE3HzU9vrXSvvNC0CshUqifJncdw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EwGJTvwAY79n2mztoA8s6wOF/stXJgYeHzTmdQ8v3ZsA7otdehFGwpalsNTb4uO7XH/Tk9Ohv8dgI8Y/kqZHqtFBkkYXVThecIjHqlIwJ4QRp4BjnVSsQXbQ69UK91fzCCFj16DhVPGO2eM1KTXePfEnS6HTXxe7rDDlIIdoVSU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aisec.fraunhofer.de; spf=pass smtp.mailfrom=aisec.fraunhofer.de; dkim=pass (2048-bit key) header.d=aisec.fraunhofer.de header.i=@aisec.fraunhofer.de header.b=GDanaUuC; dkim=pass (1024-bit key) header.d=fraunhofer.onmicrosoft.com header.i=@fraunhofer.onmicrosoft.com header.b=G/Vvui3w; arc=fail smtp.client-ip=153.96.1.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aisec.fraunhofer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aisec.fraunhofer.de
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=aisec.fraunhofer.de; i=@aisec.fraunhofer.de;
  q=dns/txt; s=emailbd1; t=1764860203; x=1796396203;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=RLMriuCadsnJtGQYE3HzU9vrXSvvNC0CshUqifJncdw=;
  b=GDanaUuCfFmxBViEDsUrtINz5l2n6JJ1iWIVE23Fxl4WHYeaZxhbZg2r
   SbIIiPgiVtQVv8JySrUm7SaBhUvHE2TWR/G5YJba7hgMgfDHhxXd2shan
   CnO/SRAoQBwjaFaM0oOCGfEYlZWUx2Xh3+ei3j9pm4fH0LeLIiYOtZ4Ay
   FKv+qveVkBNJxP/1XaytfiYu26AQwZFldu49qC59uUqmh9FfDUB2va9S6
   8aELaBSyb4xsI2Z3dZP1TqSemZWVMHyj1Fchx2dzeS55Jo09XPShyEHU1
   JMlBDRz6wlTtVpjFFrecBAjaUYBpxtWz5HssXbM0iDodOo1IDrcWsVudT
   g==;
X-CSE-ConnectionGUID: z9JxOjYeQtOeCLlHnVdOwg==
X-CSE-MsgGUID: lOF3b464QVWu2+p6Eb4Tzg==
Authentication-Results: mail-edgeka24.fraunhofer.de; dkim=pass (signature verified) header.i=@fraunhofer.onmicrosoft.com
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A2EsBAD8nzFp/9maZsBaglmCQEABgi+vCIQzgSuBJQNXD?=
 =?us-ascii?q?wEBAQEBAQEBAQgBUQQBAQMEhQACjGgnNgcOAQEBAQMBAQEBAQIFAQEBAQEBA?=
 =?us-ascii?q?QEBAQELAQEGAQIBAQEECAECgR2GCUYNgluBLIEmAQEBAQEBAQEBAQEBHQI1V?=
 =?us-ascii?q?gYyAQ0BATcBDwtGMSUGDgWDAoIlBBIDNrQ3gQGCDAEBBtssGGOBZAkJAYFBg?=
 =?us-ascii?q?3yBcoJlAYR9cYR4NoFVRIFKgnU+hFg4hXeDNJlZSAp4HANZLAFVEw0KCwcFg?=
 =?us-ascii?q?SBDAzUMCyoVI0sFLR2BIyEdFxNgPRdAg0kYBmcPBoERGUkCAgIFAkA6gWYGH?=
 =?us-ascii?q?AYcEgIDAQICOlUMgXcCAgSCFX2CCg+IAoEIBS57JwMLGA1IESw3FBtEbgeUH?=
 =?us-ascii?q?U+cegGvazQHgjiBZ4FeBgyfZxozg3EBk26TCy6YWKkVAgQCBAUCEAiBbwuCB?=
 =?us-ascii?q?DMaJIM2UhkPkiG8VncCOgIHCwEBAwmSHoFLAQE?=
IronPort-PHdr: A9a23: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
 wiUGSA6qnCVFKCZGgma6Ux8qGnIHYztPHaSTEQ=
X-Talos-CUID: =?us-ascii?q?9a23=3AecgvsmoaZVJZtkQaMK1CLq3mUdJ0UG36zkbdGlO?=
 =?us-ascii?q?fBE1NTJ2Td1O356wxxg=3D=3D?=
X-Talos-MUID: 9a23:chtbLwh9peb2ukAXz1dw4MMpMOBGuK7yVhw0r6ob4YqcawF6ZwuPg2Hi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.20,249,1758578400"; 
   d="scan'208";a="35872302"
Received: from mail-mtamuc217.fraunhofer.de ([192.102.154.217])
  by mail-edgeka24.fraunhofer.de with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 04 Dec 2025 15:56:30 +0100
X-CSE-ConnectionGUID: jS3GN0FaTbKnN2DIDPFPTA==
X-CSE-MsgGUID: kM27+GRpRsGKkwl5/sOyHQ==
IronPort-SDR: 6931a11e_d58b8B4qk2tQ6cqvVLOgFDfBxYazmIjSRvX9mrAVH59R1uh
 pZ1WUeba2Gqer0h7E7ED0/jTNdAT6+uzkHbHxhQ==
X-IPAS-Result: =?us-ascii?q?A0CEBQB0oDFp/3+zYZlagS6BK4FuUkABgSYuW4ghAQGFL?=
 =?us-ascii?q?KE4hDOBK4ElA1cPAQMBAQEBAQgBUQQBAYUHAoxnJzYHDgECAQECAQEBAQMCA?=
 =?us-ascii?q?wEBAQEBAQEBAQEBCwEBBQEBAQIBAQYFgQ4Thk8NhlsCAQMSIAENAQE3AQ8LR?=
 =?us-ascii?q?jElBg4FIoJggiUEEgM2AgICphkBgUACjFeBAYIMAQEGBATbJBhjgWQJCQGBQ?=
 =?us-ascii?q?YN8gXKCZQGEfXGEeDaBVUSBSoJ1PoUQhXeDNJlZSAp4HANZLAFVEw0KCwcFg?=
 =?us-ascii?q?SBDAzUMCyoVI0sFLR2BIyEdFxNgPRdAg0kYBmcPBoERGUkCAgIFAkA6gWYGH?=
 =?us-ascii?q?AYcEgIDAQICOlUMgXcCAgSCFX2CCg+IAoEIBS57JwMLGA1IESw3FBtEbgeUH?=
 =?us-ascii?q?U+cegGvazQHgjiBZ4FeBgyfZxozg3EBk26TCy6YWKkVAgQCBAUCEAEBBoFvC?=
 =?us-ascii?q?yqBWTMaJIM2TwMZD5IhvEtEMwI6AgcLAQEDCZNnAQE?=
IronPort-PHdr: A9a23:QqI5ABQuOP+JiFM8s5CwDlu919psouyeAWYlg6HP9ppQJ/3wt523J
 lfWoO5thQWUA9aT4Kdehu7fo63sHnYN5Z+RvXxRFf4EW0oLk8wLmQwnDsOfT0r9Kf/hdSshG
 8peElRi+iLzKh1OFcLzbEHVuCf34yQbBxP/MgR4PKHyHIvThN6wzOe859jYZAAb4Vj1YeZcN
 hKz/ynYqsREupZoKKs61knsr2BTcutbgEJEd3mUmQrx4Nv1wI97/nZ1mtcMsvBNS777eKJqf
 fl9N3ELI2s17cvkuFz4QA2D62E1fk4WnxFLUG2npBv6C63VlzH7q8F01DKcH9HZdIEZAhSw0
 vZ1Ui/TljkhHGYS62Hqk81+rqRQrA309Hkdi4SBT8arKud/JbzCIMtZS0tzZOgSUyZRMoCuf
 7pSHcMbIuJJhtbi/VxUhlihFAj8Ntnx4zNvjET3+Yxj0blxKAia3CMcL4tWvy6NvvvqD4FNe
 MSxnbLF4hXHcstV/yf299iPfzJ+h/HQf7dreOzc1QohUA7ElXnKl7a7Jz+zjLo3jXS21ek4Z
 MugoWE19wsrumSFysYs0IiRtIMVx07C2xQ+7pdvOISZEWkiffCrRcgYp2SbLYxwWsQ4XyRyt
 T0nzqFToZegZ3tiIPUPwhfeb7mCb4Gt3zm5DbnXLy1xmXRlf7yynVC+/Bvoxu79U5ys2U1R5
 mpek9bKv2wQzRGb9MWdS/V880vgkTaC3gze8KdFdGg6j6PGLZ4mzLMq0J0VtEXIBCjtn0vqy
 qSRcy0Z
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:y5QEcai0dALb9sKNWY2RjYLLZXBQX/113DAbv31ZSRFFG/FwyP
 rAoB1L73PJYWgqNU3IwerwRJVoMkmsiqKdgLNhdYtKOTOJhILGFvAb0WKP+UyCJ8TezJ866U
 4kSdkCNDSSNykwsS+Z2njCLz9I+rDum8rI5ds2jU0dNz2CA5sQqzuRYTzrd3GeMTM2YqbRY6
 DsgvavyQDQG0j+DayAdz84t7epnaySqHqCCSR2QCIP2U2rt3eF+bT6Gx+X0lM1SDVU24ov9m
 DDjkjQ+rijm+vT8G6X60bjq7Bt3PfxwNpKA8KBzuIPLC/3twqubIN9H5WfoTEOpv214lpCqq
 iAn/5gBbU+15riRBD6nfLf4Xig7N/o0Q6j9basuwqtnSU+fkN4NyMOv/MaTvKT0TtfgDg16t
 M744syjesTfEj9dWLGloH1vmpR5zOJSDMZ4J4upm0aXo0EZLBLq4sDuEtTDZcbBSr/rJsqCe
 90Eajnlb9rmPyhHgTkV0RUsauRt04Ib2G7q2Q5y7moOmJt7QNEJmMjtb4ioks=
X-Talos-CUID: 9a23:+h4JtGAUEJOBc3X6Eytcr2EyQu4sTnf+ylGKD26UMUhRdJTAHA==
X-Talos-MUID: =?us-ascii?q?9a23=3AdnxhEQzOPaVDiMzL3ZwH54nsAcKaqKeLUh9Ovq8?=
 =?us-ascii?q?egdKrFi9vP2ralxOmYrZyfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.20,249,1758578400"; 
   d="scan'208";a="32626778"
Received: from exo-hybrid-bi.ads.fraunhofer.de (HELO smtp.exch.fraunhofer.de) ([153.97.179.127])
  by mail-mtaMUC217.fraunhofer.de with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2025 15:56:29 +0100
Received: from XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) by
 XCH-HYBRID-03.ads.fraunhofer.de (10.225.9.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 4 Dec 2025 15:56:28 +0100
Received: from FR6P281CU001.outbound.protection.outlook.com (40.93.78.7) by
 XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Thu, 4 Dec 2025 15:56:28 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SsT4+JEtgS1KA4g9uYBKh+fDAGtDUJ3lrwVEpu2Lbs7f8KsxNjEC+gucH2LPtsOnWB/SkkJELGu74DpJZrTGFb6ncS2kAyWu606vxE6zwm+GzjqGNOOto7/M6uBMcVGZ3ws6lHgHDnaU48Oh+uPr9AXKMfgIDoJWQN9FM9R3oG9Gq7ea0pfzJVW//TdCfvGHi8Grn9AIlzoR/9WeJ0xgnMQkqG+Z70B/R1b/RkCEpuSWfKyv7ZnZIdsYaQy3UA6qOuaBTDUwl6SF4/hlrU7Wtsv5jCQm3QVPzi2NK0T8TW6IGfjuS5m844ILtJwX6olYrAPLJ4lgDk3gteQ94z6rdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RLMriuCadsnJtGQYE3HzU9vrXSvvNC0CshUqifJncdw=;
 b=GHrFMHd375Kq/bHb4WPqdfUCGQre8BM5zCdYE6e6XfYi3DPNfKRnLNJsP3uvhECFkzQzxLf2sZgKhV8Z+3jdbwB4cLwvCdF0CfskmQQUsaqkWL0OFC2/Qvu2noJ0YEJ4++J8QG5c0/VdqMh0Xz1+VuC+wNKkIvqrd1ii3PsqalEwosoNQdwJtMy9z1D6ASEAzWRfVQ0JgrJktrgHsYC9zNIecDc6tUTKEQV8podDkI7cRC2APb+kQElkZhITSXFGKvMY9Qeo07cL7ibD5Y7tUdBhUACf7bcasvK6hkj4c8EtnzyrDyezhmzPpRTn1roHRjG/udFhoApcCUqb92DJqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aisec.fraunhofer.de; dmarc=pass action=none
 header.from=aisec.fraunhofer.de; dkim=pass header.d=aisec.fraunhofer.de;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fraunhofer.onmicrosoft.com; s=selector2-fraunhofer-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RLMriuCadsnJtGQYE3HzU9vrXSvvNC0CshUqifJncdw=;
 b=G/Vvui3ww5p+fIZRF+lbxXkzxY5zArwlyA7w2o2C+wyi8ZRvAdObSiLI1j58Qa4hGTX10g21zFwSN7ALl9seGHluPkNxcw8/eJ7Nh4JmsaNet+f/eisD2VR6pdN26RVtERk0YAgBgz4b2p4Bdih2i0ZihevnFY/Fy2u1I1O1tFg=
Received: from BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:43::5) by
 FR4P281MB3740.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:d9::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.9; Thu, 4 Dec 2025 14:56:26 +0000
Received: from BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM
 ([fe80::ae34:1ec2:9d34:a9fb]) by BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM
 ([fe80::ae34:1ec2:9d34:a9fb%5]) with mapi id 15.20.9388.009; Thu, 4 Dec 2025
 14:56:26 +0000
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
	<tmgross@umich.edu>, <vbabka@suse.cz>, <x86@kernel.org>, Andreas Korb
	<andreas.korb@aisec.fraunhofer.de>
Subject: Re: [PATCH v23 16/28] riscv: signal: abstract header saving for setup_sigcontext
Date: Thu,  4 Dec 2025 15:56:19 +0100
Message-ID: <20251204145619.13381-1-andreas.korb@aisec.fraunhofer.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251112-v5_user_cfi_series-v23-16-b55691eacf4f@rivosinc.com>
References: <20251112-v5_user_cfi_series-v23-16-b55691eacf4f@rivosinc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0037.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::6) To BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:43::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BE1P281MB2435:EE_|FR4P281MB3740:EE_
X-MS-Office365-Filtering-Correlation-Id: 457e3ece-3f6c-489c-767c-08de33454ca6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YShw9MiIVrQvKFsCeF38yymXsDCheN8zWLInI9nM09q0LBU8D/eNViVyP0bM?=
 =?us-ascii?Q?lVCViKmVJcVJAO8w1lnNQU5VZ9R2tuVCoSJ2XhZTIcxfWVxHrW9LSnSa+Jr5?=
 =?us-ascii?Q?EoDTI5+adZcXAe1LNYOdOhxe8qmmy1ggcGk5BuQxTGgJeTH6zYzG7vS0djWV?=
 =?us-ascii?Q?tJWcdP+v278BJpoGW4ssEy+e2pbjuPtNxC9YX2XH22Sk35KfYEi6767J8zzn?=
 =?us-ascii?Q?r3W3eqsfyQzgliQ9dBIBMISyZs2bMOQVHjI7gs8UivApEbWf53+UGmLVy18i?=
 =?us-ascii?Q?0xwjUH75yXdgjWrD1LebEUs36Cn7VYJ53jXbTUHiV+t5yg0mpC1OXhPFsI+Y?=
 =?us-ascii?Q?540R7wYYDOCTqteXN3AuqmwbaDYSKstVt8F6Z0bPlamdtXDyAw6ZEZgyOaQL?=
 =?us-ascii?Q?MtFw+yPmAHFAXPg1yN55jtF/QgnvFNOKHidf8nhGh4yiVtmJcpp99pZu2RkA?=
 =?us-ascii?Q?I8/gK/vpYpMT8lkSdv3M4Ve/61Q5cSzfzcHCq+PWu6Rj7MwUNeYYryQJaTgN?=
 =?us-ascii?Q?rc8rEEq8mJpJs9qjualU9D5NEOGJKk6HVfL53g2t26O7HbyUR6/vTB+Fv9pH?=
 =?us-ascii?Q?LGdhQbnu55nq43Axj730VfCUWOY8kEh9ZcynZGUh0MqjYeL2Vr+cG6dSbLtI?=
 =?us-ascii?Q?gJUw1zePCcEDuTRI8rD0IkMeXGxKxnx5eYWLW0SvDOdbBfOK77NwYndIbZ7y?=
 =?us-ascii?Q?822TvTyNySI82EXoSx3m0VSY4DsczGuKM+Ntdg/j9saLMGnb7NjuTa3QL0Kf?=
 =?us-ascii?Q?xYkOMJZKnGYqXDTFR2ORnDl9wifHE7DQejCEV67QD7wpSpZPWErq7jhW5Ffx?=
 =?us-ascii?Q?y+/5Dll3csdgHCV4qBS9IvtAENI95c9u3QeL/FlOWnbJxA6KZZf0obmZuP0x?=
 =?us-ascii?Q?vPKqMdCHSxY7xP7VJ+RN800+x3skoGot54gDRTeJ9qznPrXpb0Ab3IWNnwm0?=
 =?us-ascii?Q?0Zb3xbtg99bqURU48elGmJaD/SYfRQNSbkE12tGN+aSDctfhpc6tbOAO3+lH?=
 =?us-ascii?Q?eFQ4HvAWNHqACrTR6YrXVEImX0Kr3wg1ehE110PnD8LLA5Ucmp0XUyEHeG4C?=
 =?us-ascii?Q?mydbQT7nkomoS5MZWJ2cYNqUmWEPPPwbD/1fvXlJPULmDO9v4ifo3sFBEzza?=
 =?us-ascii?Q?LjeIPGlKybAX0EDebLB+JRSCONXP0ICQjYJ2ToojfHRc1MFFcdsmrGXUnGvj?=
 =?us-ascii?Q?cyOawpXEc5wvYNZcQiXEL/Vg3KW54EL6DNBB9O5Q1l4+gvXu5vudyPpqxOI6?=
 =?us-ascii?Q?/VughXQckuemQdP1AMMgSlToMutpZLxYmeCX8tzRuBIKY0rq7r0FPEQk8ehe?=
 =?us-ascii?Q?vyJWf4la7tbOQ5UNHmv2sPpF29Znj90juQExfI2433U2SkmSptUKzJNIvOS8?=
 =?us-ascii?Q?SyJePal1gT8/LmjCgg1Uu3bEQmXRu341NeXtM8SHorfmJnynfCpK2rdl8vs/?=
 =?us-ascii?Q?uIJGlO74IBSBJALsRbxXFc6Q48WIlQW+?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Thtej4IBKo/x53J/LHsmllvngvoUfiqLVIi0nDGbZXsgnVKbEXe69WmtzYoC?=
 =?us-ascii?Q?hvVMRAeI3d1uBZWhpply3CH60vy3WG2Po+jazIZssndehj2HC61EEMH5wUq2?=
 =?us-ascii?Q?D5MT/DDJCIdabKXR6YfALO09KS1VhubNjRajC9a+p5cR4Qz1pyDYM1DqGudX?=
 =?us-ascii?Q?YiF7ci6/XRyKvji5EjZdQ3NYzS686yjQlzYMWihIeA64gXHW6W5gjcGG3uSo?=
 =?us-ascii?Q?aD7cpMmOBYMK/MeFlRpu12MlxbVizSd8UU8I557xuohlT2VJTqejz0nwLrDA?=
 =?us-ascii?Q?hT4HqlrQ4onvyx1jKJPfSudfdXXjtcW9Yp6xHnwVMc/KfekRNUyfFRrdb6oO?=
 =?us-ascii?Q?ieYl2bU9Wv0zkit9XuclMURM2uKd/L4L4nxMd0sOPzYR5/uKAvTwm4L1x+C8?=
 =?us-ascii?Q?xf7Q3tSimrs0MVYP0X+BbdBEHP9diU8dzJhQrHW0UPFrhoAqyfj6x7F6gaEW?=
 =?us-ascii?Q?8bcWdEDfzUXQT01vFDoPH/teimna11N6TrNwmUAuGAJ0yqXIslVQOjBh+7Fs?=
 =?us-ascii?Q?6MsL4j9JGtHQRfW6fBf1N1ELM73aVYEd5eJsaXYTcneSjmDTh8GOSnvAcbcM?=
 =?us-ascii?Q?5jYEoz7t9vZDghkYmMrWldwMUpJqHssp7ECvPMpjnWv7HP0gTeLKSUkY7Ezs?=
 =?us-ascii?Q?eC4g7tfNkUK+9CQf83ILVo+Zh8GUgBvqRb+aQcBp9Hq0VT85TlxWP9hw756f?=
 =?us-ascii?Q?XmuIucgXlmhW8kk+LnOhumYvP1XEayK1fjU59n2kWwdlbDeSKUjBfZztFSGt?=
 =?us-ascii?Q?urip5TVYRCzQXcL3becPtUjrqKtHI5BTSoD9Bra11+I2EKaBVm8/I/mgbeuj?=
 =?us-ascii?Q?IK1yhSMJnALURChJe45Y3DquYEOc6SswyO/I5z8/X+nN43gUih7OsCyTG5sE?=
 =?us-ascii?Q?4fZwtivGMd+pn1m5rxHgKsFoGbL1Zm3Nnq3n1zAIGHqBYftyoFk850ldmJgX?=
 =?us-ascii?Q?+uHRf82UEGZCujPC8HGAw9xsfIXM/ltfcKqrnngl40HVgD8N6BErMBxINZGL?=
 =?us-ascii?Q?eUWaiOoFDaHToeYXxQFtEKv99R9+XRwyqdqUQ3BxgMtdLzLG4uO98DbYPY60?=
 =?us-ascii?Q?lZV1eLmmBIRIXbtsj1BOnK44o4qXaR1LSJMJtKttqs+sRaT2z+Omi1sP/LPO?=
 =?us-ascii?Q?VNW2feWen1s+u3fVrXpoVl8Cyv3Y9enA1TBm3tSe9sOEYWi9LC/6/o5HpeqS?=
 =?us-ascii?Q?vvtrcFXfxtSqI+EKup1lx0UcCRlQ9MFrdd/5Oh2yvT3tzesDAZc1J56Yp1L7?=
 =?us-ascii?Q?r/cjcKw+M6nugAhWo36P/zzbD8xsnkdWLmFVJCmJ7JawpyUhLz4yrMpWAxL5?=
 =?us-ascii?Q?ZoPHKLFRK7zA7dCFJG0mSn5861rToQBququLengEkG5o4W2axsoYkewVk+hC?=
 =?us-ascii?Q?PJPHTD+FICdONtGFYIswb6UbgxgUc0pIyolndN+HwkUuGdSb+MZCSdHejYRn?=
 =?us-ascii?Q?nrm+TJtTJDCn7YQ+WqplQBM2xy/2gkNVsM23I2iP5xbzNcS2PIUTlDnRWYRU?=
 =?us-ascii?Q?C0SlVrlUTjBHx6ImMqD/Wpgk1jFNbp4/cUcxZt8Ny02ilNN06m0BbnJxAHIE?=
 =?us-ascii?Q?kqRbn/DYre6aJ+gQQ17nb6CvrtkKpuWrcMm11r02UK5qkFaVCvKWjL6skckI?=
 =?us-ascii?Q?0Q30fTeMVrhrdWg4kv05Y+g=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 457e3ece-3f6c-489c-767c-08de33454ca6
X-MS-Exchange-CrossTenant-AuthSource: BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 14:56:26.6308
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f930300c-c97d-4019-be03-add650a171c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fieCUXaYFAUgfI8Iv1oyJpaMVBdcoBc1Nuq/2AerQuWhTfqMDxEgGjP6+HquWApAbeYWkg+FMi6oGAFA/d93HdfAGDboUd38Nci5ZQ9rzMyZtxxPlv4L1uGbC9GO5+/P
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR4P281MB3740
X-OriginatorOrg: aisec.fraunhofer.de

Tested on qemu and on a custom hardware implementation of zicfiss and zicfilp in the CVA6 core

Tested-by: Andreas Korb <andreas.korb@aisec.fraunhofer.de>

