Return-Path: <linux-fsdevel+bounces-70687-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DC7BBCA42AA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 04 Dec 2025 16:10:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D8E331354F3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Dec 2025 15:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98B652D23B6;
	Thu,  4 Dec 2025 15:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aisec.fraunhofer.de header.i=@aisec.fraunhofer.de header.b="WEDSdCCh";
	dkim=pass (1024-bit key) header.d=fraunhofer.onmicrosoft.com header.i=@fraunhofer.onmicrosoft.com header.b="bLfCn4wr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-edgeBI124.fraunhofer.de (mail-edgebi124.fraunhofer.de [192.102.163.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F4126F46E;
	Thu,  4 Dec 2025 15:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.102.163.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764860645; cv=fail; b=QwOJnAbPxS4MAMQxd0bbVT6kQ3HFB7LkHEPtwSTg15gnE+cTNnVLqqUxc3cxSxVuT6XuaP4087+jiPCZEUIAuGgv8vaF79DATYOIxGhNaV8uYXqTWEjU8aeA6pOLILj0KruNh1+GZJGAYrKy6uvaX+TmAFLCJClieY2BjnyskjA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764860645; c=relaxed/simple;
	bh=RLMriuCadsnJtGQYE3HzU9vrXSvvNC0CshUqifJncdw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WWR2xyh8wKyTjN/9fZJzvmn1EuX6o9hKeSKBhdu0PaPGfOLblSpv2P5u1/qVC8bxWPEaoJa3UZ/EfR/DYX01tNCGjERIjMn2kV4GRy3FuLfAaEPWg3rcpp+Jz/4b32IuGrOESLpLCzLASkNRWN9/XyfrVedcK05Qu/jBDo3XXVM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aisec.fraunhofer.de; spf=pass smtp.mailfrom=aisec.fraunhofer.de; dkim=pass (2048-bit key) header.d=aisec.fraunhofer.de header.i=@aisec.fraunhofer.de header.b=WEDSdCCh; dkim=pass (1024-bit key) header.d=fraunhofer.onmicrosoft.com header.i=@fraunhofer.onmicrosoft.com header.b=bLfCn4wr; arc=fail smtp.client-ip=192.102.163.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aisec.fraunhofer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aisec.fraunhofer.de
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=aisec.fraunhofer.de; i=@aisec.fraunhofer.de;
  q=dns/txt; s=emailbd1; t=1764860642; x=1796396642;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=RLMriuCadsnJtGQYE3HzU9vrXSvvNC0CshUqifJncdw=;
  b=WEDSdCChdPypYlHzr+w0X9hgg7p7Yqr1q7+8Oxzg+v9jOg+7mSg60jtl
   fLpuTsvZMr00JXotaesJpnxjGtWF3mHNKmprpWH4mJk1tW4gnLrTbZi5Q
   3PMRZktELISKS8M4DXIXob+dqHhjzia/ivR3HChTP08EB4y8BjDWTA5V2
   +UVIlF9/2tT/AWe3LjhHzGFyelzZKV88G/Hr6SL25+/siq+1UtrMdhVLR
   IxmQMUV8nKw3RqLjW/IX1uuzrfSTufnR0KabF3gsBB4rdZLwBYZuMmbUW
   9j5B1skvqKjAHPi+6ECIhCLb+lMaUjTj4eCUXDOzB3hkrXMu6qvJZ8QbG
   g==;
X-CSE-ConnectionGUID: Q6o8BukXRXi4czuLuk8/jQ==
X-CSE-MsgGUID: 9wgzxsmuTsOeX7TkDyYxEg==
Authentication-Results: mail-edgeBI124.fraunhofer.de; dkim=pass (signature verified) header.i=@fraunhofer.onmicrosoft.com
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A2H9BAAIojFp/x0BYJlaHgEBCxIMhFBAAYIvszuCUANXD?=
 =?us-ascii?q?wEBAQEBAQEBAQgBUQQBAQMEhQACjGgnOBMBAQEBAwEBAQEBAgUBAQEBAQEBA?=
 =?us-ascii?q?QEBAQsBAQYBAgEBAQQIAQKBHYYJRg2CW4EsgSYBAQEBAQEBAQEBAQEdAjVWB?=
 =?us-ascii?q?jIBDQEBNwEPC0YxJQYOBYMCgiUEEgM2tC2BAYIMAQEG2ywYY4FkCQkBgUGDf?=
 =?us-ascii?q?IFygmUBhH1xhHg2gVVEgRU1gnU+hFg4hXeDNJlZSAp4HANZLAFVEw0KCwcFg?=
 =?us-ascii?q?SBDAzUMCyoVIw88BS0dgSMhHRcTYD0XQINJGAZnDwaBERlJAgICBQJAOoFmB?=
 =?us-ascii?q?hwGHBICAwECAjpVDIF3AgIEghV9ggoPiAKBCAUueycDCxgNSBEsNxQbRG4Hl?=
 =?us-ascii?q?B1PnHoBr2s0B4I4gWeBXgYMn2caM4NxAZNukwuZBqM8hVkCBAIEBQIQCIF/g?=
 =?us-ascii?q?X8zGiSDNlIZD44hPoNCvEt3AjoCBwsBAQMJkh6BSwEB?=
IronPort-PHdr: A9a23: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
 huIEDoyp23dHrzaHASF71xhoW6JGJeuX0w=
X-Talos-CUID: 9a23:Njgr4m3obI4md+VDvnEfzrxfI54iIlfAz0fqE07kAnR0bKCWGRiSwfYx
X-Talos-MUID: 9a23:Iv/3ggtRKRcPZlcwYM2n1S5tJtdz5rmSE2cAoco6uOWVBDxdNGLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.20,249,1758578400"; 
   d="scan'208";a="14520166"
Received: from mail-mtaka29.fraunhofer.de ([153.96.1.29])
  by mail-edgeBI124.fraunhofer.de with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 04 Dec 2025 16:02:48 +0100
X-CSE-ConnectionGUID: oBH8d8BvRYSYV3hRt0MC4Q==
X-CSE-MsgGUID: S7vJ7eKdTMSUdlQrhA0fQA==
IronPort-SDR: 6931a291_Dui/LoXvhEqCf3TpFQ/RzS++9xIVSWczG7HAu8fkrBMD8NP
 EUM3ksFBlrjEkMDyG/GyMinnduCKbAeu1Xqr1Gg==
X-IPAS-Result: =?us-ascii?q?A0BFBQChRJ5o/3+zYZlaHgE8DAILOoEugW5SQAGBG4EJi?=
 =?us-ascii?q?CEBAYUspWiCUANXDwEDAQEBAQEIAVEEAQGFBwKMJCc3Bg4BAgEBAgEBAQEDA?=
 =?us-ascii?q?gMBAQEBAQEBAQEBAQsBAQUBAQECAQEGBYEOE4ZPDYZbAgEDEiABDQEBNwEPC?=
 =?us-ascii?q?0YxJQYOBSKCYIIkBBIDMgICAqUEAYFAAoxXgQGCDAEBBgQE2yEYY4FkCQkBg?=
 =?us-ascii?q?T+DfYFwgmQBhHxwhHc2gVVEgRU1gnU+hRCFd4M8mjtICngcA1ksAVUTDQoLB?=
 =?us-ascii?q?wWBIEMDNQwLLhUjDzwFLR2BJ32EG4QoK0+CInWBd0EZP4NTHgZrDwaBFRkeL?=
 =?us-ascii?q?QICAgUCQz6BXRcGHgYgEgICAgICgQNAAwsYDUgRLDcUG0RuB5M2nXIBr2s0B?=
 =?us-ascii?q?4I4gWeBXgYMn2caM4NxAZNukwuZBqM8hVoCBAIEBQIQAQEGgX4mgVkzGiSDN?=
 =?us-ascii?q?k8DGQ+OX4NCsyBEMwI6AgcLAQEDCZNnAQE?=
IronPort-PHdr: A9a23:t/2bSh9Nk0lUs/9uWWy9ngc9DxPPxp3qa1dGopNykalHN7+j9s6/Y
 h+X7qB3gVvATYjXrOhJj+PGvqyzPA5I7cOPqnkfdpxLWRIfz8IQmg0rGsmeDkPnavXtan9yB
 5FZWVto9G28KxIQFtz3elvSpXO/93sVHBD+PhByPeP7BsvZiMHksoL6+8j9eQJN1ha0fb4gF
 wi8rwjaqpszjJB5I6k8jzrl8FBPffhbw38tGUOLkkTZx+KduaBu6T9RvPRzx4tlauDXb684R
 LpXAXEdPmY56dfCmTLDQACMtR5+Gm8WxyBsJhLE8TrzUoz3kDfVj9tQgwmIAJzoV4APRyqEx
 P9AUx/VkSYJFTgy/H6C2akSxKgOqjavjBoj3JTEQti7Ddx+bLLdT/U2QzZeAN5xUzxKP6agY
 ogxF/cRMd8C8KDPllwT80b5Wg2dCuW+xjhWr3TZ/JYFjPh4NCff4ScQJ88s92nftvzNGZstf
 cuXkI300zf/f9pTyC3S54LIUCEYiO23cpFNYZb0zQ4KEiPMgXOum5P8Ih+p7eEDq3jB9MgwZ
 MD/lHQk6BFMuRm/wdUTrrvE3NhWyW757iJdyroccI7wWAt6e9miCJxKq2SAOpBrRt93W2hzo
 3VSItwuvJe6eG0P1J0E7kSOLfKdepWO4hXtWfzXLTorzH5mebfqnx+p6gDg0ezzUMCozUxH5
 jRIiNjCt30BllTT58GLR+E7/xKJ1yyGygbT7e9JOwYzk6/aIIQm2bk+itwYtkGrIw==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:QaY0xK4thHfOe0PyyQPXwUyBI+orL9Y04lQ7vn2ZFiY7TiXIra
 yTdaoguCMc0AxhIk3I6urwRZVoIEmsv6KdhLN+AV7MZniBhILFFvAA0WKm+UyaJ8SczJ8R6U
 4DSdkGNDSYNzET5qyagDVQUexQuOVvmJrYwts2pE0dKD2CHpsQiDuRfTzrdnGeKjM2Z6YRJd
 653I5qtjCgcXMYYoCQHX8eRdXOoNXNidbPfQMGLwRP0njDsRqYrJrBVzSI1BYXVD1ChZ0493
 LergD/7qK/99mm1x7n0XPJ5Zg+oqqv9jIDPr3DtiEmEESttu+aXvUjZ1REhkF2nAib0idqrD
 ALmWZkAy080QKUQoj/m2qQ5+Cp6kdQ15al8y7fvZKrm72JeNo3ZvAx+75xY1/X7VEts8p717
 8O12WFt4BPBReFhyjl4cPUPisa33ZcjEBS5tL7tUYvJ7c2eftUt8gS7UlVGJAPEGbz750mCv
 BnCIXZ6OxNeV2XYnjFti03qebcFUgbD1ODWAwPq8aV2z9ZkDRwyFYZ3tUWmjMF+IgmQ5dJ6u
 zYOuBjla1ITMURcaVhbd1xCfefGyjIW1bBIWiSKVPoGOUOPG/MsYf+5PEv6OSjaPUzve8PcV
 T6ISZlXEIJCjDT4Je1re12Gzj2MRaAYQg=
X-Talos-CUID: 9a23:oHQe2Gx8QvoPniToL4eCBgUTMOB1fi330k3hGH6GUmZTVOWwYgOprfY=
X-Talos-MUID: 9a23:Yty33gWt4agvwYDq/ASzmhM9OeRk34GVNUwJqI8GkpGKDAUlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.17,290,1747692000"; 
   d="scan'208";a="46761749"
Received: from exo-hybrid-bi.ads.fraunhofer.de (HELO smtp.exch.fraunhofer.de) ([153.97.179.127])
  by mail-mtaKA29.fraunhofer.de with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2025 16:02:39 +0100
Received: from XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) by
 XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 4 Dec 2025 16:02:39 +0100
Received: from BEUP281CU002.outbound.protection.outlook.com (40.93.77.7) by
 XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Thu, 4 Dec 2025 16:02:39 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SVhO06SJEDCwChsUqtl2YpvTZTDuvulS+VfDHpuA6Bzg7uez1JbaYyFl3sumUhVuck0N0fSuMpb5JGzdOWoOqYY+gLz30Msr+lZ0aIoXUYCU9wKwdzVbUCSxxN+bunNLlpFRSqt+bACHm8OGjDWIeMx09qn6+aMBPB0Aqbv0YxpX89d/xdKJPwxPJ63KIBcbOCOedbFjDE9ktKohOOrFU6zqsAeLJMs7xoMQkSKwCmXzkQGROKZpE8gsxptLUhCez05HAY45eT40qqXtcTRpdC6H+Vp+e7N3Uj4lpxeQY4uQuNf3UOL/u0jym5/X7lT1AOCjqOFsvR/9xvkpqgarhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RLMriuCadsnJtGQYE3HzU9vrXSvvNC0CshUqifJncdw=;
 b=dYnO3dvOrwc3rLUQUE6Nno29jfC+cZXfA5pNnyBhVfCypJyepELjNSe44qc6xMpoZ4dM+GCZ33VCw3QMk/8/9b+MJ6KI2ftyJE8HWkWSxMwb4N5kK8fcj+r6GOQ6LY/nKet2NwqsOV9VjY1ibbBGXEAYqycfM0hdO3NPuShM6jQkCYWuG829C3tAyp8ajUwr4MxbRUGYxWbNjKcdYawtkMSGaF15OXs0W6kPGE6YBR+R5Hf99RWvzdE1A+g6Qcycm1RL10JAOTs/25VMwSeb+CXbbSKotEbS4YxloE5z/WONoBdVqnfT2K9ZtNWQcucxZpErUlh4LjUI/9GvJtH3YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aisec.fraunhofer.de; dmarc=pass action=none
 header.from=aisec.fraunhofer.de; dkim=pass header.d=aisec.fraunhofer.de;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fraunhofer.onmicrosoft.com; s=selector2-fraunhofer-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RLMriuCadsnJtGQYE3HzU9vrXSvvNC0CshUqifJncdw=;
 b=bLfCn4wrxJ1FQNhzyhZNDn4w6pHlxcUMtekVpuxdQ27AZYou65/7lYfn9dovAcGISW7t1MNqUCXPuJ/ucrAPETWDCJ4LTvjTxAmyrGgbhJYQAtSGKUx4Ml/MmHagNVZwquDTSmfpx2sJ8YJ8wrk+xUsIxozWLZe22+kVUsoLbTA=
Received: from BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:43::5) by
 BEZP281MB1831.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:5f::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.9; Thu, 4 Dec 2025 15:02:38 +0000
Received: from BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM
 ([fe80::ae34:1ec2:9d34:a9fb]) by BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM
 ([fe80::ae34:1ec2:9d34:a9fb%5]) with mapi id 15.20.9388.009; Thu, 4 Dec 2025
 15:02:38 +0000
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
Subject: Re: [PATCH v23 22/28] riscv: enable kernel access to shadow stack memory via FWFT sbi call
Date: Thu,  4 Dec 2025 16:02:31 +0100
Message-ID: <20251204150231.14633-1-andreas.korb@aisec.fraunhofer.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251112-v5_user_cfi_series-v23-22-b55691eacf4f@rivosinc.com>
References: <20251112-v5_user_cfi_series-v23-22-b55691eacf4f@rivosinc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0046.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::12) To BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:43::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BE1P281MB2435:EE_|BEZP281MB1831:EE_
X-MS-Office365-Filtering-Correlation-Id: 54c7f1b6-1825-464f-221d-08de33462a67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Yel/hJRnc1CFwesVLiZqD7zbzF1dw2qhpd6UAjYLNHX9aG1EB+pleVzcxksm?=
 =?us-ascii?Q?Fu3lcRdIwJjDZ9N06c4Z2O6lbsUXmEtck7tvrROsyIHos+HZiFY8TfpRtsgS?=
 =?us-ascii?Q?ksgp0OJYvJgPlSg53AQaR0BoCMQ9jEpIFX5omukBSR+zBbaT7kqoPKyLw3E7?=
 =?us-ascii?Q?UYdCuN1HRIM5pvuOcXo1MRWQoXZHG3bVLVR+B7NzUaFUnftL64mllVOFocji?=
 =?us-ascii?Q?7ZgQH2oeKUPzreaZ59OKyVFBtrPUJg6LosfdLFcpFCrb/FVuJMqFXhUwYxSv?=
 =?us-ascii?Q?YUGisLm9GvmIKL+9RPoGozFe9JJBUJL+mrLEgHFNjnyqaOA+WPuR37YVHGPN?=
 =?us-ascii?Q?apHi/sw0oJiX/3H1xu2kEUI/fhlCksKHW+NBSIafjok412bFEJMADdyu2qbV?=
 =?us-ascii?Q?u1CtZl1PgOEb/7JrlvL7NQ8mq61x/pZX1qxrTKxHo3I8hIq9kUpLNTSZQpMr?=
 =?us-ascii?Q?8/Ynwn80LXDTD6zAzrtx6SPtijIZlJ4vQtERXy24kul9h0PQ3DYPj/YzdBkY?=
 =?us-ascii?Q?TF/Mm9I1jHBKqIIkIN0D4hjNPRs1PpkPOr0SKP02aWVuYCylT4v9QLZOM9EI?=
 =?us-ascii?Q?qpwltvkADRfC0T8zYcrTA13/SXPB97w8ceZ//ZiwtdBwTVCBY7PUv1il0fGR?=
 =?us-ascii?Q?giIPvFZlbyJpk9utuZjAKPQVUNz3oW2HgRdCJvx/Ab5xuvFoCExHd2SbTHng?=
 =?us-ascii?Q?pqfnA0Qjyfk+FNfu3O1IxmfTiDqaEmW45/vx8pZHtz4K7TlBlj3dmauXzcnC?=
 =?us-ascii?Q?soT7+PFRnvQl9JSM+/UWz6vYfsosCUoRJECRfAM1e3JZzLQG7zD4Tfz5nEg6?=
 =?us-ascii?Q?Ola8+uoQkB1e2LrsQD7xJwVAe3hSs0Ytv+OxjRVOLZ74p3ILJOGR1EbiaLrn?=
 =?us-ascii?Q?hksMke+6wAImcDXfzwiRNiHxUMPwYs/lOuxSv4sfOTjRKRf//3Yos8X7jRAU?=
 =?us-ascii?Q?ymFp/3KHhVl4sAL0rbbZPYfpWoJJtBv2SCBoBUaw+DHYH8ryQVUoi1irVnL8?=
 =?us-ascii?Q?qYpvcpQKJiVXUWBpz/0skTbhxPXHxmSJPYOb8ZFv46V6jg5QtbsZbhqwfeEi?=
 =?us-ascii?Q?VExNjLcz8KyHkOfNqRAmyASdVDWEiN0DXcwU41SorR83zQHmTtHITwOfj35t?=
 =?us-ascii?Q?IPqYgPtGN+cDZ31ndFY7rIFnGabBsXTcP6tDK+90EgHQpr2ibHIj1HXjxaqU?=
 =?us-ascii?Q?OT8Fd9LNV6aK1w3jI+tbAbOgWfEaNag6Beiiwn5c5c9rqAVFwuF0QlfWptuW?=
 =?us-ascii?Q?FuSvrIaTIHXq9JcPqyVipWpoOYZ6OJyw5fsMPoUVoBdvrwJr8WJrZ8xvlF4N?=
 =?us-ascii?Q?IK24iHKTmYuTVGUT7WxRonmD+h+80Yy9CoQJUNxigaZEjQmN5X6nINHFm7OM?=
 =?us-ascii?Q?UjaHhg9ODjfgb/ZFF8F4pqvERrxgRAOGvuLmBDnMTLs4j8FCORqcNleReLPB?=
 =?us-ascii?Q?JGuBqp78PUxeuJtAZnYPhdov1P8s3WKK?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4MB/pw4br6px7ogt7B5/8/7J+Lb/QmuwI2CVVF5ESs1mMjTotOcIb85zBgSY?=
 =?us-ascii?Q?GTYg6EsGAPBP2yG6yZXQAv3QLoJaJL8iCZE3Iqaz1fPrqJ3E/U9rK16CDCFJ?=
 =?us-ascii?Q?+vq0HMfWwBQkHs+ZQFszShE8hwAyMqeTDB380PTq0dH9yGYtX6Z2pL9TeISR?=
 =?us-ascii?Q?X8/ohfCRGLMBcZH2xdtsYlqiVrPaqFufMP0IQsmmIWcRTaNtckHrpp3RVBCb?=
 =?us-ascii?Q?JZPWVs7v7hlApRA/jMttykhA08ooSAR1lbeiu4xAshdXzDwdiwcdo0QMFh8D?=
 =?us-ascii?Q?Mizcoqnk/5Ja8MpxrmINfylpuZie/Et8XfaDCFfYaQ93dKVnNyqL7LLmz4my?=
 =?us-ascii?Q?FRgrj8wNr337SxoGuCvFzQ9qADQbVUZpvpaYAJI6Q6KbkPHAdCRMdyAza+ef?=
 =?us-ascii?Q?u0CDsfrQyXIOnRG/G/2YN9ufOOaRieBbYX134haiCvyHpcyLwfAXBHoV9Yxl?=
 =?us-ascii?Q?mxW0fLBdbQBjvRIt90k9G0Jzoq0kslXiVjUkY3WveXld+xtfZDoxMxM3Ob8L?=
 =?us-ascii?Q?45uJpuj0YdhtYyE1CulLj/AUKyDw5knEHBui+gd3k/AgqX+ac9xBJ0POXL4i?=
 =?us-ascii?Q?JJZmjTK2TF9WAE87qJdhrY+3uVhzxTX7gO8xUSXork1i6pYvUuhvOz1iZzHD?=
 =?us-ascii?Q?j5mINm0Wxg+l8FbIlHArA5/lJnTvmCNwoApruTY6C9Wmlz2Qc9ZAhHu32FZ1?=
 =?us-ascii?Q?4qMqDpblsFHFW8c9Pe3LL7ke50aF5E4Bixp9fcHWsoX1zHst4xkaIqBDnHb6?=
 =?us-ascii?Q?NnJ7xuQqza3N7zOG1qAjowzFPx6PLJcZXkKAn7Rk2d5Wdsu0N4pcqLtXB3C/?=
 =?us-ascii?Q?gWvm71HTG9mlgvhbcm7f0oegNc39pnGW2QS4FSDGva4OX5vXEka0lXl5AW9v?=
 =?us-ascii?Q?4ZV2Lh7KMab5JtlQ9LacE6vJZPzpgTBvcgabcuZvU5TyTC+b1ET2u7GV0yjX?=
 =?us-ascii?Q?9dznHvYc3EqhLUOyLpX1ZRdkw4V7L6b9hJZH3mncG/cykMRFrzKpjh4gl3Gt?=
 =?us-ascii?Q?fTTzpqxhHFlOftT8ClPz6lFBgoc3u3pp1DlYjhesjoBsbAfeytnetstwq4Pm?=
 =?us-ascii?Q?wrvXfKwPl9Fqnyb6e1O4eLK855T/G3IuKtV8tmkAhkhbPn5ABVs3d04O8Avl?=
 =?us-ascii?Q?eL8wTRVENsmcxhvQTFLXNP3rZS+FLTEFHLoedAv8AQODkrpEKEV0SRs6s+ne?=
 =?us-ascii?Q?sgxDs+ZzsS9q3LZxmPhdTz5K+lEs80PhlBQL7CsT+6oKJ55hr3nRzOWGgGag?=
 =?us-ascii?Q?sbSBIIn03hgkqiKtI+SE+TYrDuzd8jEzcGOIavgJUZeJFDHhPV3WGIOLAw49?=
 =?us-ascii?Q?Hdvdh7x9t9xw2M2/evPGJg09ewWNxPMuayEwo7IQCVHBgK57XzeAuHz02ADZ?=
 =?us-ascii?Q?tDyFlPIcLophfEOiax9xYDCPUz4txLV9PL5y9RJmK62tUEpDtiqhajt2hCAR?=
 =?us-ascii?Q?78FmS4FWjGbbl8rvgFT9QssAe0Wf/u6A3Y++7R/PnZyVpatkTQoUK+WzKfM2?=
 =?us-ascii?Q?rPHR0a/2XsMKSB+gJz2vxGUL3DnPjXhGURsXHFn+oPTllu+W+T0Ga0LhkHCk?=
 =?us-ascii?Q?vbU6jLuAdA/UHDsjrzGSheChTQHFTQhh6gQsLvL2/TZajrJ9/7BoFDDi/tha?=
 =?us-ascii?Q?Y/AByeQT+dfWOINJ+8nL5vI=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 54c7f1b6-1825-464f-221d-08de33462a67
X-MS-Exchange-CrossTenant-AuthSource: BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 15:02:38.6794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f930300c-c97d-4019-be03-add650a171c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TMRlI2kKpqbl8rYjzZ5HMbcVZwfSZvNd+Ota9H0BaelYKjURQBb0jao+HyluSBM2bxsvfBSzTzEvp6yDGUxIDDfTJEdCaqmXGJ8STjJty6c2IOKMIdUnFFugfBHU+nnX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEZP281MB1831
X-OriginatorOrg: aisec.fraunhofer.de

Tested on qemu and on a custom hardware implementation of zicfiss and zicfilp in the CVA6 core

Tested-by: Andreas Korb <andreas.korb@aisec.fraunhofer.de>

