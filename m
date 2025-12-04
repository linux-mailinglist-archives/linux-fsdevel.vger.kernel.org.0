Return-Path: <linux-fsdevel+bounces-70685-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D2FCA4223
	for <lists+linux-fsdevel@lfdr.de>; Thu, 04 Dec 2025 16:00:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E720F300B374
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Dec 2025 15:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C7E2D1916;
	Thu,  4 Dec 2025 15:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aisec.fraunhofer.de header.i=@aisec.fraunhofer.de header.b="xROaRLkX";
	dkim=pass (1024-bit key) header.d=fraunhofer.onmicrosoft.com header.i=@fraunhofer.onmicrosoft.com header.b="ehhB+x8T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-edgeBI204.fraunhofer.de (mail-edgebi204.fraunhofer.de [192.102.163.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E19B28541A;
	Thu,  4 Dec 2025 15:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.102.163.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764860448; cv=fail; b=Ff0vszwdLqyqRQtMYPnxS5NahEXUwuSWcNamx3quwcjhWUu+UPI5SDC1/6M2wHlO1ZdJQCMV95sUwUKiQRCqojjjVpx+2df5Nuj5r2/f70AgRk+WycJBJ4LYO0xzcFIP9uK8KlliX7g0zAXS3GNCuFavKAcwg7B+/0YBIdoaVyk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764860448; c=relaxed/simple;
	bh=RLMriuCadsnJtGQYE3HzU9vrXSvvNC0CshUqifJncdw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=opAjVWfVvqYMvaby3wHzStl08WTyVt6A30eP+MS8oivDVFsxNY1hjWkVC/nY2RcrlOdiChm4hS9VRr+uymtYpNAZmYWAwSWGEwB06Y2uZbQx6b8fskXTzztvqPsr+rNgbbyMyJFV/kaHxHDQKW4aMYB6SHb+oln+VRdjBJEZxhs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aisec.fraunhofer.de; spf=pass smtp.mailfrom=aisec.fraunhofer.de; dkim=pass (2048-bit key) header.d=aisec.fraunhofer.de header.i=@aisec.fraunhofer.de header.b=xROaRLkX; dkim=pass (1024-bit key) header.d=fraunhofer.onmicrosoft.com header.i=@fraunhofer.onmicrosoft.com header.b=ehhB+x8T; arc=fail smtp.client-ip=192.102.163.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aisec.fraunhofer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aisec.fraunhofer.de
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=aisec.fraunhofer.de; i=@aisec.fraunhofer.de;
  q=dns/txt; s=emailbd1; t=1764860446; x=1796396446;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=RLMriuCadsnJtGQYE3HzU9vrXSvvNC0CshUqifJncdw=;
  b=xROaRLkXxHhFqRrkYWYKejmyk4S2l1Xf0E/EGZJMT2ZkqUUqUSRqQvAx
   6wwlCe43k4P8d8prX3uWHf7+4MmxHppOA5bIxeci4lVa+sfrNlcUeSQDY
   SfXjJBkviJsOTVGuDlM6hQ8HfTzgbbTqL7gCJ7rOD4N3q51Nyet5r4G1d
   7N7nC5J4CMMhsEO/MCpgwWlTZZn8H0OWfjVjwPwK2RxF/OWJSz9pogWtU
   GIxMAqd148AbbMka4aT0PDOMa/+qfcIDbKzyFoATp9B2siKRFl6WmO4QQ
   MCQ8jTD49okdhfv/6pN96GW1dtJLHVUwjwZ0XdukC4oiFJ3XTKd9LZXKT
   Q==;
X-CSE-ConnectionGUID: J8HoIFZrSDCSIpkHq+Au2w==
X-CSE-MsgGUID: NwsElthzS+GGZaH0Yfix5A==
Authentication-Results: mail-edgeBI204.fraunhofer.de; dkim=pass (signature verified) header.i=@fraunhofer.onmicrosoft.com
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A2EsBAB0oDFp/3maZsBaglmCQEABgi+vCIQzgSuBJQNXD?=
 =?us-ascii?q?wEBAQEBAQEBAQgBUQQBAQMEhQACjGgnNgcOAQEBAQMBAQEBAQIFAQEBAQEBA?=
 =?us-ascii?q?QEBAQELAQEGAQIBAQEECAECgR2GCUYNgluBLIEmAQEBAQEBAQEBAQEBHQI1V?=
 =?us-ascii?q?gYyAQ0BATcBDws7CzElBg4FgwKCJQQSAza0OYEBggwBAQbbLBhjgWQJCQGBQ?=
 =?us-ascii?q?YN8gXKCZQGEfWgJhHg2gVVEgUqCdT6EWDiFd4M0mVlICngcA1ksAVUTDQoLB?=
 =?us-ascii?q?wWBIEMDNQwLKhUjDzwFLR2BDBchHRcTYD0XQINJGAZnDwaBERlJAgICBQJAO?=
 =?us-ascii?q?oFmBhwGHBICAwECAjpVDIF3AgICAoIVfYIKD4gCgQgFLnsnAwsYDUgRLDcUG?=
 =?us-ascii?q?0RuB5QdT5x6Aa9rNAeCOIFngV4GDJ9nGjODcQESk1yTCy6YWIJYpj0CBAIEB?=
 =?us-ascii?q?QIQCIFvC4IEMxokgzZSGQ+OX4NCvEt3AjoCBwsBAQMJkh6BSwEB?=
IronPort-PHdr: A9a23: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
 i6ACjQhrHecF7fFWwiZ7UZttXXUFJ63cXqQIREk
X-Talos-CUID: =?us-ascii?q?9a23=3Ac3KRbGgeaU4oI337/ijC0EPmODJuUC39y1b+EVW?=
 =?us-ascii?q?DJU1SaaWWaUbT0b4+jJ87?=
X-Talos-MUID: =?us-ascii?q?9a23=3AvaBnGwxqN7PTEfRKFNlgaYS2rs+aqIKxE20JjZU?=
 =?us-ascii?q?UgIqrGh55G2+sgjWnH6Zyfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.20,249,1758578400"; 
   d="scan'208";a="14770837"
Received: from mail-mtamuc121.fraunhofer.de ([192.102.154.121])
  by mail-edgeBI204.fraunhofer.de with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 04 Dec 2025 16:00:41 +0100
X-CSE-ConnectionGUID: o1oLJhtbSQi909RZ9lvC8w==
X-CSE-MsgGUID: M0zzska0Q3KQUqPnWgW7uQ==
IronPort-SDR: 6931a218_v443aGRY878b9cg/DvcfrwNy3RxohLn8990kW1aFfyqih0i
 Ix3it79vScRF0hf9RL8T0w4fGF8SiiUFtqWI+vg==
X-IPAS-Result: =?us-ascii?q?A0BCBQDL7aZo/3+zYZlaHgEBCxIMZYEjC4FuUkABgRyBC?=
 =?us-ascii?q?YghAQGFLKE1hDOCUANXDwEDAQEBAQEIAVEEAQGFBwKMJSc3Bg4BAgEBAgEBA?=
 =?us-ascii?q?QEDAgMBAQEBAQEBAQEBAQsBAQUBAQECAQEGBYEOE4ZPDYZbAgEDEiABDQEBN?=
 =?us-ascii?q?wEPCzsLMSUGDgUigmCCJQQSAzUCAgKnJQGBQAKMV4EBggwBAQYEBNshGGOBZ?=
 =?us-ascii?q?AkJAYE/g3yBcIJkAYR8ZwmEdzaBVUSBSoJ1PoUQhXeDPIg1khtICngcA1ksA?=
 =?us-ascii?q?VUTDQoLBwWBIEMDNQwLLhUjDzwFLR2BDxh9hBmEJitPgiJ1gXdBGT+DUx4Ga?=
 =?us-ascii?q?w8GgRUZHS4CAgIFAkM+gVwXBh4GHxICAwECAoEcGkADCxgNSBEsNxQbRG4Hk?=
 =?us-ascii?q?1WdcwGvazQHgjiBZ4FeBgyfZxozg3EBEpNckwsumFiCWKY+AgQCBAUCEAEBB?=
 =?us-ascii?q?oF+JoFZMxokgzZPAxkPjiE+g0K3OkQzAjoCBwsBAQMJk2cBAQ?=
IronPort-PHdr: A9a23:2IT70BTc0nOjkLIUahads8nt8tpsouyeAWYlg6HP9ppQJ/3wt523J
 lfWoO5thQWUA9aT4Kdehu7fo63sHnYN5Z+RvXxRFf4EW0oLk8wLmQwnDsOfT0r9Kf/hdSshG
 8peElRi+iLzKh1OFcLzbEHVuCf34yQbBxP/MgR4PKHyHIvThN6wzOe859jYZAAb4Vj1YeZcN
 hKz/ynYqsREupZoKKs61knsr2BTcutbgEJEd3mUmQrx4Nv1wI97/nZ1mtcMsvBNS777eKJqf
 fl9N3ELI2s17cvkuFz4QA2D62E1fk4WnxFLUG2npBv6C63VlzH7q8F01DKcH9HZdIEZAhSw0
 vZ1Ui/TljkhHGYS62Hqk81+rqRQrA309Hkdi4SBbYGVHrluLp/FQtQrGkVYYtgLCAl7ALq6T
 aYuBrNdGP5opImliQUAo0X5XgalIejVyzhamWb7z59m97oTSCLPzQd+LpEu6kzs8c6uJrtKU
 bmU/K35wTj+d95v/xPR95rWKAwusM2DYetreInT1FV0PD3F0V7Jq9fJYTGp8/Ujo2u3zdR9C
 6Wl024/mjtggzqU3OUridDYvL8Z7WDt6CtowqEeKPmiaxZ4RML8RcgYp2SbLYxwWsQ4XyRyt
 T0nzqFToZegZ3tiIPUPwhfeb7mCb4Gt3zm6Dr/XLy1xmXRlf7yynVC+/Bvoxu79U5ys2U1R5
 mpek9bKv2wQzRGb9MWdS/V880vgkTaC3gze8KdFdGg6j6PGLZ4mzLMq0J0VtEXIBCjtn0vqy
 qSRcy0Z
IronPort-Data: A9a23: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
 lXghb6ZTAkzIK2ciggk6TF9mbCbBaDGIeg=
IronPort-HdrOrdr: A9a23:TOM9xKiLHJo23g2nBYQbWrIXGXBQXtsji2hC6mlwRA09TyW9rb
 HJoB19726StN9xYgBFpTnuAsa9qBnnn6KdjbN+AV7AZmnbURWTXfhfBOLZqlWKdkHDH4VmtJ
 uIHZIObeEYdWIK7voSjTPIceod/A==
X-Talos-CUID: =?us-ascii?q?9a23=3AhBp8xmlxXK1B/8s5cO5Ta2SynNHXOXqEy1PyI1O?=
 =?us-ascii?q?yMl9oGeXEc23B/L1Pw9U7zg=3D=3D?=
X-Talos-MUID: 9a23:hwLDOQVIUlkrCgvq/Bq0liN5N84w2v+NMX0UqZM5tPbbKBUlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.17,306,1747692000"; 
   d="scan'208";a="32649226"
Received: from exo-hybrid-bi.ads.fraunhofer.de (HELO smtp.exch.fraunhofer.de) ([153.97.179.127])
  by mail-mtaMUC121.fraunhofer.de with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2025 16:00:39 +0100
Received: from XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) by
 XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 4 Dec 2025 16:00:39 +0100
Received: from FR4P281CU032.outbound.protection.outlook.com (40.93.78.50) by
 XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Thu, 4 Dec 2025 16:00:39 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V3spyIkWlLeqU3stFuO4QSYqFP1XS/4INr4PgSVdbPOlq9UrXXjtY8J5TEOim/oFKpetPXpxMSpGpJVWddx/2vHsnKrN014CFnuPbXIgbgFaEF8VBcJnHkG9DoBnmbyUuzumr11MuMe4vDEZPDargnGhyjs4V8VLlb/fUT7H7hJzJuYO36bGpAVf/rmzGYYHkoy0OZHqErzHiumMvkhZbxUYEDZGgYrVWOXjIHhpkMQZcFqatOX5UN1yzSrAcvn3v990NEe2I/i1gnQZ5ExzNQqpJSCW4bqRVitKC61qm1GDDPXzollv6kvH+Kpa4n54d7O4wp47kXNsqRrUQEdlzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RLMriuCadsnJtGQYE3HzU9vrXSvvNC0CshUqifJncdw=;
 b=PaQJ6g+jE0NqY0EC0wOOmpPWQbuT/toFsxYusNJrSxr7rPzINDBM+4EYLn8pzXPzaXA8VegTZZBYDPzHJbDp1GjCT1VdOePHG+GWgW7+4Tkm2IujLwnrFWOK+GNgdsWkx89iuI+tgIY7n51EO7tC52tkjcDq/s6st0QwuKkpD3procXNAHH/0ZNEnGnpOfeewYvMJGrBFlplHwGQf2Dmcu03Q2DG4Sy9gX6WVNH3P8dZvWm0ke8Xrgh4v58TbhnU8SljGuQDLNDuE4wm4a4F85snZavq3/0t+rgHuXT7DE5LPYkNoF83B9gK3UFvnMQwnPdgSsnN2FGbK3b1gUoiYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aisec.fraunhofer.de; dmarc=pass action=none
 header.from=aisec.fraunhofer.de; dkim=pass header.d=aisec.fraunhofer.de;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fraunhofer.onmicrosoft.com; s=selector2-fraunhofer-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RLMriuCadsnJtGQYE3HzU9vrXSvvNC0CshUqifJncdw=;
 b=ehhB+x8TpWoY7GqTv27MRjQnJEIa14MpXch0F6ff6/3gaMcRiozwqezZ4L6Z1Kayc6Y+H2PP5s3zt0h1IXlYdeUpEQNLDwzv2tgyTgT1sa+jut3CVh7c1j3D6jTMyFxkDJVu6/b0hpYRyIjSrJok1yRUdOXAufyjOCeLrK0kMt0=
Received: from BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:43::5) by
 BEZP281MB1831.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:5f::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.9; Thu, 4 Dec 2025 15:00:38 +0000
Received: from BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM
 ([fe80::ae34:1ec2:9d34:a9fb]) by BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM
 ([fe80::ae34:1ec2:9d34:a9fb%5]) with mapi id 15.20.9388.009; Thu, 4 Dec 2025
 15:00:38 +0000
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
Subject: Re: [PATCH v23 16/28] riscv: signal: abstract header saving for setup_sigcontext[PATCH v23 18/28] riscv/kernel: update __show_regs to print shadow stack register
Date: Thu,  4 Dec 2025 16:00:31 +0100
Message-ID: <20251204150031.14202-1-andreas.korb@aisec.fraunhofer.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251112-v5_user_cfi_series-v23-18-b55691eacf4f@rivosinc.com>
References: <20251112-v5_user_cfi_series-v23-18-b55691eacf4f@rivosinc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0153.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::20) To BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:43::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BE1P281MB2435:EE_|BEZP281MB1831:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c8ad25f-dbb9-4bbe-6851-08de3345e2a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cHn9dYj9pvpUyjEcMH5R0YHHUaw0jK5ctLI3laGXSt48sOH65VzrVy6IsQB+?=
 =?us-ascii?Q?JPnbNKIDPjQ8mdL45tOt6dAD7uVKgUugFsWe+6jpdKeIAGzhKmzEtHy2q1my?=
 =?us-ascii?Q?pyilh+LUJcBKeNtAPKZrlnd/KHO0EECfs893b2JQArv8jKcB1n18qDvfvOh9?=
 =?us-ascii?Q?GF4yobe2Sg6OXIlEnWhvTRsr6mZ9M1Fbklv2NRVFh1kZ9ZaE03L46V8V9b1x?=
 =?us-ascii?Q?hgufCdL0hPfUa5i6oebLHet9OMgckQ+KjzzG8JKthm28ba1k2D/o4uO/oc4w?=
 =?us-ascii?Q?XT4iDpw0t4l376ekGKsjlPPRDr1fjXdw3JskLzaG1fb5qUvegrQZn7CPG1tw?=
 =?us-ascii?Q?qPue7bv9UpbhELfbh7cfiKo4jBYbtyNEY6mDb7WlVrnD8h+1Ty1KRB1ihSuX?=
 =?us-ascii?Q?22/UOtLVLdw9SSuMnacs129XvhOdhElQZAZnWv6RpevLkS315Tbiey39fKEZ?=
 =?us-ascii?Q?Y+HS/up8NC8Dtdv1452ghKLhS8u2aA6hG/GhfdVp9VPyz5V6vIRJsyBdeDzJ?=
 =?us-ascii?Q?d4b3A/v13qx2CHNtSnshD44DUHoucUrQSRWOPwvDt5eEv1TTf8Itv+VSzEP9?=
 =?us-ascii?Q?SDma3J5BAWFDMMQVmN5byd7B0ZdIbZoEVcYuFQv8LIvXvF1dtEz9gX2QzaOJ?=
 =?us-ascii?Q?mubgLb4DTqmyfRuqA9UcltnfSG7t2eHdWSly3nundUA+YNQt1m8u/3gGLNch?=
 =?us-ascii?Q?Rvnsr+BJteqYE0JpwMQoLUl5Z9W69X/wCa0Z9EyGE8Mz1mvH8jA6GyMvd4zC?=
 =?us-ascii?Q?GRwoGtL/vOcsqiIwSj9FMn/V1Yx4Yvol+bBUy1ietB/EarcMRIMT0OTPCOq2?=
 =?us-ascii?Q?rJ4W7kBpUcT4oEKgpXoLSCIwJ53JtdbwSpfaTQ6Tuy9wGYEV5Yb/4xtguyiQ?=
 =?us-ascii?Q?1h1Hu8D2mOQQ2PQdt+ylWnuZ1O78t3qw1o7gKXmRRvsFaI1JUvady1iwX2tT?=
 =?us-ascii?Q?gI6QdDyQwlSGYCVStvEKTrfm7jQJzBuFC3Cd/FJnBG9W39kppjcL9rZvXuVM?=
 =?us-ascii?Q?zJrYfi5oEdhd/nDYs+cIoVRp/ndc1BejzDPtTr1eRxdNVeACV7H8kFQ5K52S?=
 =?us-ascii?Q?dCwLWn5qWWAgLYC7adOLCjhwMrtHr2B0jTnqRCzxCdVUoXJ74McfNCz7bpKm?=
 =?us-ascii?Q?jFI3HynkXpvgyDT5Taq8gyb+m69PF0PyoCEgbR4Teb3Y47ryM+wBVea8otue?=
 =?us-ascii?Q?ZeARhP8z8sSUBgac6MM30k6IZyADz8BFIl2fQ5EMq0TWTMhV1akK8LaHEIYM?=
 =?us-ascii?Q?0r2o/BS2Rt0SS6PfhzTnMkduezWE/vF8saAQ+wiKFR+WT2l5Tg/39XGObmV9?=
 =?us-ascii?Q?gc3Uh3PxSe2yz7jLG/GA7SRHo3iaGIBRFSuGiW08Hbkf5ZcYaz7ml9FOLEEi?=
 =?us-ascii?Q?EyNcDd8XvOBUjy8ERdIcHcJQqQ8WKK9LdD5Vku9JX/67A7RO0oCOOXM+Gtut?=
 =?us-ascii?Q?J2UILhX4shRtQrXM8FrlU2VfcTWNRzfZ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QhYXXrKPrfy6OMw6uRc5mAXltTwA3ipSKEce0sbPuobKFkNkXA83zjBZ/3Gk?=
 =?us-ascii?Q?17WNafhFpbeOyG3J3yUE7t9/8EhOiENQTbSS1ZKyBLtS7i1y+z+J89Ao+GA1?=
 =?us-ascii?Q?Q69ehvsgPeKl/4VyD/WWerskJFZ1efAzZwdLioIw5PGB1mOXf4CrI1mQqDxP?=
 =?us-ascii?Q?XzLyIweeI0XFpKK8Fx7vDkimDS9r9wDun7+9RJ8ROMg3EzpuV2VTQ16dGZ3b?=
 =?us-ascii?Q?h4KTp2z8zRrcnZn1A4zJ1xkcLUSVKF65xWulaMtChCjDG8NLAXEOvP//ZNkd?=
 =?us-ascii?Q?PRG4xHh1/DYQdsdFdK70Q/4erbQ2SLx4NDZ/ICIcNLoaHKkfvY+ZgXsd8K88?=
 =?us-ascii?Q?xrJ78+FLzwgeh3Iw3gDAsS343h4hqyFTLVBjLQVQdnU+bxmp+1QjNW5tQI20?=
 =?us-ascii?Q?8UJRegvmN5NMAPHvIn3F2lQdWYxV7UewlbKRokW/v3b3S2yuqwGYXHil6NdJ?=
 =?us-ascii?Q?PlNPJi3ESJbTpgJtMkuxEZZcapnYWYDP4RvzKJxvDFDJLb8xkNKYhwmq6jIE?=
 =?us-ascii?Q?7jR0zDkjJSSevybTuxfP1rxAdlDRVCkLQloLVXdugdmd9Y17XcUiSYYVIvqb?=
 =?us-ascii?Q?WKBBkb/Fk6daEgJOPdcvz34lwJ1yC7H+1NaIWJBBYM7PHy7i+N3r8xtiiIBi?=
 =?us-ascii?Q?VN9HQO/ow44Pg4vXXMtfvrocqre8Lf2Et+JIKLnCY6/HlJHsPwTi9ChjRdEl?=
 =?us-ascii?Q?aR7YEkYsdyv/mjg3enq2TDygeEaR5dYUqCYSZkIYIyoJgfdn71it5LDd/ir8?=
 =?us-ascii?Q?P7NO0NsRNWnkZ9Dq7rR1w2ZgD6F2BbsgdbmGEialp52gHfctZnycd6G8HkAH?=
 =?us-ascii?Q?9OQ/Pzfl3o/pvqNFx67F+ZOo9Y/lkEBSsbtOIgYcRYe/oSH/fbXKo6rZsdvj?=
 =?us-ascii?Q?Vh2jYpdayBbeGZKCRW1CUjemH8inBc4JhUmobx7bPDmbQ0Ql1OmvV3a6+oht?=
 =?us-ascii?Q?RfBKIY6ra6oQkXmCQ4sq3gh8Bv+r8hiw34oJYVnrsPde62jPYFewC0nQ12XM?=
 =?us-ascii?Q?yfVsKPOVDOKVcqG8E/Guc9mu+eyo+cP+k645tPprgwcNsbG+Rv52d2J4H73V?=
 =?us-ascii?Q?IWrY28zwZRcZ6X5AunAl+ber9quUjzIWT5zS2gkaJ4WXhKmhM841G3JdlAAK?=
 =?us-ascii?Q?UzSJ/vmsBGyGJ3L9tuJGCvo5dUIcQ4WjajvswhOnNqOz9gE1AWc5fx8WeE/A?=
 =?us-ascii?Q?IcwUdQDb0vhz9NuyYAMsoVXha0hJFZRzOQVfNeOBF0laemKWmG+mCw/Jr52a?=
 =?us-ascii?Q?jNiLvHTtgoxUYEY9uLh4HFY8ZhUy/FJw0GmhhmVrCxT+sE+EFM3NpI9k/yCG?=
 =?us-ascii?Q?6LDsQJXiYu7v1ux+BBuga47hQX7/59QKcICOysAbAXyXebYJrMu0iivSgxuy?=
 =?us-ascii?Q?QdhdstdUSb1QKgp/2U240sQI9IB0MJyohXNvCwNQ5oObUjkugfYJNyZPXPO4?=
 =?us-ascii?Q?elAG/NX2ro6V6mfuvkb7ZiIL2+Q+szjfEtuzxenI/Gr/Cd2fXxfzkWta99DR?=
 =?us-ascii?Q?XLTnP1Yf7Xp+0rCC3TzvMcHiNMJea0fxou/Of1a5Qg5kjb2YFOI1g2yqtgmJ?=
 =?us-ascii?Q?8lT2MbD06TlkV6S7ECEt6DjzXW4VuY3PPy/1+Ul2n3v0TJzbUQViZ2lBkTpL?=
 =?us-ascii?Q?n9bk69ISl6v1kLqpWkgg4Q8=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c8ad25f-dbb9-4bbe-6851-08de3345e2a6
X-MS-Exchange-CrossTenant-AuthSource: BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 15:00:38.3298
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f930300c-c97d-4019-be03-add650a171c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MV1cAGza+9R+QtFsqeMDwlTthL2ECvQpWX8DSpwW1FOIuofGz2pSKVLqXEcU2w+L+gMGuc945sNqsnN3ZsbqeBJguumjJfcvSdzdfV9q1VxYXwBXH39r556lt8XpytsN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEZP281MB1831
X-OriginatorOrg: aisec.fraunhofer.de

Tested on qemu and on a custom hardware implementation of zicfiss and zicfilp in the CVA6 core

Tested-by: Andreas Korb <andreas.korb@aisec.fraunhofer.de>

