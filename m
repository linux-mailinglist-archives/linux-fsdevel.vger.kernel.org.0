Return-Path: <linux-fsdevel+bounces-70677-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 83BA4CA4180
	for <lists+linux-fsdevel@lfdr.de>; Thu, 04 Dec 2025 15:49:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 52E943036C9B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Dec 2025 14:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83503340A57;
	Thu,  4 Dec 2025 14:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aisec.fraunhofer.de header.i=@aisec.fraunhofer.de header.b="XLrL5qJP";
	dkim=pass (1024-bit key) header.d=fraunhofer.onmicrosoft.com header.i=@fraunhofer.onmicrosoft.com header.b="nT11QuA6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-edgeka30.fraunhofer.de (mail-edgeka30.fraunhofer.de [153.96.1.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D421A341AB8;
	Thu,  4 Dec 2025 14:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=153.96.1.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764859520; cv=fail; b=BkAfLIGizIw0dRuLrQasx0BCR05+VCPDnTzAEI2hdWw1Ea0rAeUOufwrb798IVQKpR/h2xbq2wlxgWBhQPZMwzL6TGPC+UmQzIc5Y9E4fv7SSeyMN7cJARyay62SMAj/xZQqfQOGmxKlI0EW8bnOBqlsCAG/ZQc91JNKkEp+b9Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764859520; c=relaxed/simple;
	bh=RLMriuCadsnJtGQYE3HzU9vrXSvvNC0CshUqifJncdw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iO7hcQhhNFH/GvJyKNq8bq/E5jZsL2cCgN/KNDDlOAqlG7e95oeytQU/7UOFWi//IFtOZxkYnhCWcZIgvJMYwjDUGTQ10IJVCz5ZZJOrwzDt72NdT9uEsoePS0bRXEqQhC/+fz2RSu6gRfLGN+FWv4i1gv5k0sngxFT+x0D9PlU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aisec.fraunhofer.de; spf=pass smtp.mailfrom=aisec.fraunhofer.de; dkim=pass (2048-bit key) header.d=aisec.fraunhofer.de header.i=@aisec.fraunhofer.de header.b=XLrL5qJP; dkim=pass (1024-bit key) header.d=fraunhofer.onmicrosoft.com header.i=@fraunhofer.onmicrosoft.com header.b=nT11QuA6; arc=fail smtp.client-ip=153.96.1.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aisec.fraunhofer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aisec.fraunhofer.de
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=aisec.fraunhofer.de; i=@aisec.fraunhofer.de;
  q=dns/txt; s=emailbd1; t=1764859518; x=1796395518;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=RLMriuCadsnJtGQYE3HzU9vrXSvvNC0CshUqifJncdw=;
  b=XLrL5qJPscfjtzWWKQb38aY7A9APumRp60NLVbFXL0cBOV3zji0aDkZ9
   RRqfPOZGvRWQUZANGsCJkv6hSg0pXY7U/uQsGo8u4wo0h1lvGFnW4xbUz
   2qzzrr0/BZVwWcgBB9SQeDqFJZEltgPc+oU/PKLm6GEcKb39A/BJdB5xY
   bn6t05U/zbXOL7WD5bcYPCwbzQeJVfOmzvGb1cFvM5y7xF6zUCgMwG0Rc
   q/4jtMGitgWVCi2jCheXKPx5VmEw/RGWSifiJO2sA2RhyqM37hMzsF0B/
   c4YYU+i/gnD87Rfqu39G1ozvmeOzlvfuRUqEi9SpKjFDzktinz8az7zeE
   w==;
X-CSE-ConnectionGUID: 0tJAP5BaTim3CGDnX1b83w==
X-CSE-MsgGUID: xXEeAHG7QkG+WGLt+QUX0g==
Authentication-Results: mail-edgeka30.fraunhofer.de; dkim=pass (signature verified) header.i=@fraunhofer.onmicrosoft.com
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A2F8BAA4Va1o/3KjZsBaglyCQEABgiWzOIJQA1cPAQEBA?=
 =?us-ascii?q?QEBAQEBCAFRBAEBAwSFAAKMJyc3Bg4BAQEBAwEBAQEBAgUBAQEBAQEBAQEBA?=
 =?us-ascii?q?QsBAQYBAgEBAQQIAQKBHYYJRg2CW4EsgSYBAQEBAQEBAQEBAQEdAjVWBjIBD?=
 =?us-ascii?q?QEBNwEPC0YxJQYOBYMCgiUEEgM1u1aBAYIMAQEG2ykYY4FkCQkBgT+DfIFwg?=
 =?us-ascii?q?mQBhHxwhHc2gVVEgUqCdT6EWDiFd4M8ml1ICngcA1ksAVUTDQoLBwWBIEMDN?=
 =?us-ascii?q?QwLLhUjSwUtHYEneYQVhB8rT4IbcoF1QRk/g1MeBmsPBoEVGUkCAgIFAkM+g?=
 =?us-ascii?q?XEGHgYfEgIDAQICgRAQAm5AAwsYDUgRLDcUG0RuB5N3hjyBJpYUAa9rNAeCO?=
 =?us-ascii?q?IFngV4GDJ9nGjODcQGTbpMLjyuJW6kWAgQCBAUCEAiBfoIAMxokgzZSGQ+SI?=
 =?us-ascii?q?boldwI6AgcLAQEDCZIegUsBAQ?=
IronPort-PHdr: A9a23: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
 RrIGzo5wko=
X-Talos-CUID: 9a23:JrcHI2OQOc6lf+5DADVF3XZJMMkZc3iG51j8JX/hAzYyV+jA
X-Talos-MUID: 9a23:060fPgb4+crOTOBTpw/BiRhCG5hR4IvtN28pjdY/hvncOnkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.18,214,1751234400"; 
   d="scan'208";a="26279172"
Received: from mail-mtabi114.fraunhofer.de ([192.102.163.114])
  by mail-edgeka30.fraunhofer.de with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 04 Dec 2025 15:45:12 +0100
X-CSE-ConnectionGUID: dtt6W/brS8e1d68uA6pdSg==
X-CSE-MsgGUID: ZU0oNkh4SwOm/ATZLryR0Q==
IronPort-SDR: 69319e78_EBN5K/yC9X2x3JWgxfBOvuZWOD5VRwFNadu/+5sWLfezfYw
 KnwcKuRcO+X4fWoudgDmK499XP54lC9pP6fKqTA==
X-IPAS-Result: =?us-ascii?q?A0BABQBMVK1o/3+zYZlaHgEBCxIMZYEjC4FuUkABgRyBC?=
 =?us-ascii?q?YghAQGFLKVoglADVw8BAwEBAQEBCAFRBAEBhQcCjCYnNwYOAQIBAQIBAQEBA?=
 =?us-ascii?q?wIDAQEBAQEBAQEBAQELAQEFAQEBAgEBBgWBDhOGTw2GWwIBAxIgAQ0BATcBD?=
 =?us-ascii?q?wtGMSUGDgUigmCCJQQSAzUCAgKtNgGBQAKMV4EBggwBAQYEBNshGGOBZAkJA?=
 =?us-ascii?q?YE/g3yBcIJkAYR8cIR3NoFVRIFKgnU+hRCFd4M8ml1ICngcA1ksAVUTDQoLB?=
 =?us-ascii?q?wWBIEMDNQwLLhUjSwUtHYEneYQVhB8rT4IbcoF1QRk/g1MeBmsPBoEVGUkCA?=
 =?us-ascii?q?gIFAkM+gXEGHgYfEgIDAQICgRAQAm5AAwsYDUgRLDcUG0RuB5N3hjyBJpYUA?=
 =?us-ascii?q?a9rNAeCOIFngV4GDJ9nGjODcQGTbpMLjyuJW6kWAgQCBAUCEAEBBoF+JoFZM?=
 =?us-ascii?q?xokgzZPAxkPjiGEALoxRDMCOgIHCwEBAwmTZwEB?=
IronPort-PHdr: A9a23:aQxxXRcYnyjoqNASqOQonlc7lGM+49/LVj580XJao6wbK/fr9sH4J
 0Wa/vVk1gKXDs3QvuhJj+PGvqynQ2EE6IaMvCNnEtRAAhEfgNgQnwsuDdTDDkv+LfXwaDc9E
 tgEX1hgrDmgZFNYHMv1e1rI+Di89zcPHBX4OwdvY+PzH4/ZlcOs0O6uvpbUZlYt5nK9NJ1oK
 xDkgQzNu5stnIFgJ60tmD7EuWBBdOkT5E86DlWVgxv6+oKM7YZuoQFxnt9kycNaSqT9efYIC
 JljSRk2OGA84sLm8CLOSweC/FIweWUbmRkbZmqN5hGvZLPUqCrnneNxwy+4IeLPfJ1veSafv
 rlxeCT2lgEsbxUi8FzOi8JSiqlXv0fywn43ydvSXNjMDedXIKDxce4hSkpoYcZDdgx5M6KGU
 o4FAcUOIexztrDGplwnjB6TKBW1GPLv0w5Nn22p+aIQicgBOBvjzhcOT5USqS3OjfzIOog3b
 c2ql6DowGWbaNhS3nDvttmWbgt4mPSNYqh5dJDh9VIPSDvFjgq7qZ35MTSM2r8L8HKp19VsX
 r7+jDYiiwRMriTo6/cuqaDywaI47HD79QFFmNxtBPmKR2gkUN3xQ9NA8iCAMI1uRdk+Bntlo
 zs+1ugesIWgL0Diqbwizh/bLvmbeqKpu0u/EuiLKCp+hHVrdaj5ixvhuUSjy+ipTsCvyx4Kt
 StKlNDQq2oAnwLe8MmJS/Zxvw+h1D+D2hqV67RsL1o9iKzbLJAs2Pg3kJ8Sul7EBSj4hAP9i
 6r+Sw==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:97yRqKmZYivQ8moK1DYrv0+rA2LpDfPHimdD5ihNYBxZY6Wkfp
 +V88jzhCWZtN9OYhwdcLC7WZVpQRvnhPpICO4qTMqftWjdyReVxeRZg7cKrAeQfREWmtQtt5
 uINpIOc+EYbmIK/PoSgjPIaurIqePvmMvD5Za8854ud3ARV0gJ1XYGNu/xKDwQeOApP+tdKH
 LKjfA32AZINE5nJ/iTNz0gZazuttfLnJXpbVovAAMm0hCHiXeN5KThGxaV8x8CW3cXqI1Sul
 Ttokjc3OGOovu7whjT2yv66IlXosLozp9mCNaXgsYYBz3wgkKDZZhnWZeFoDcpydvfoGoCoZ
 3pmVMNLs5z43TeciWcpgbs4RDp1HIU53rr2Taj8A/eiP28YAh/J9tKhIpffBecwVEnpstA3K
 VC2H/cn4ZLDDvb9R6Nq+TgZlVPrA6ZsHAimekcgzh0So0FcoJcqoQZ4Qd8DIoAJiTn84oqed
 MeQf003MwmP29yUkqp/1WGmLeXLzQO91a9MwI/U/WuondrdCsT9Tpa+CQd9k1wga7VBaM0pd
 gsCZ4Y5o2mfvVmHZ6VO91xMvdfcla9OS4kEFjiVmgPR5t3TU4l7aSHpYkI2A==
X-Talos-CUID: =?us-ascii?q?9a23=3AMsrl02pk/eRu1lZZO6GlTk3mUcw5biPii33KGB+?=
 =?us-ascii?q?1UGo3GKC8F0ecw6wxxg=3D=3D?=
X-Talos-MUID: 9a23:MPA8awuAtp1h6YiDkM2ntgw6M+Fr4/iVF2cI1rw6ie2eJBYoAmLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.18,214,1751234400"; 
   d="scan'208";a="29868109"
Received: from exo-hybrid-bi.ads.fraunhofer.de (HELO smtp.exch.fraunhofer.de) ([153.97.179.127])
  by mail-mtaBI114.fraunhofer.de with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2025 15:45:11 +0100
Received: from XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) by
 XCH-HYBRID-03.ads.fraunhofer.de (10.225.9.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 4 Dec 2025 15:45:11 +0100
Received: from FR5P281CU006.outbound.protection.outlook.com (40.93.78.52) by
 XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Thu, 4 Dec 2025 15:45:11 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QmtGY+x2DkbiJmxu+K2qV3EC1qYWxkX/Dmvh7LbThEUTh4UGKpBXbht2X6XprxYWplshdAl4fhUYFD4tX9Oqs75waBbwmZEB+Ef0l/floMXgiTbtTyyXckH9c97AlHTqHD6IuuOtYZFwXNB1wzK0a0p/8hndak0iaZFB9DTCnyWgvJDyB4u3GMCizs46zQW70tgswQDQnuPjQ3rrRIXUFl6bgI7uB57Ea88zva4G6dStVQHVcI5wj6uJv4Lh2HwS372RDJAeXj3o2UhwfXc01aKjTaamindgHfBT8T2OeB+fqlTWK1Kl9upP8eGNylAEU6TQIwMpMCic1byYod3t/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RLMriuCadsnJtGQYE3HzU9vrXSvvNC0CshUqifJncdw=;
 b=xxeDcjweF0YPQQRo91b9pGqwNl2AXqOoJ6IAQvcAWPdmptDrr97v6xVxk10xv8byeP1IElc0b8bLR0YTMDika73KZOEpyxbarOPdjBSkLzqI6/3GuZg8wvgWnywtYBBl5q3JzPAIPtcDPjf7l/g8Im9Ad0NH5EZta7BgSwnWA+P9+noxlr0IHqbcyBWkNlwPkxGR/iBkVko/kzjpHSBKzgWZJIJo1/hy+8ho0qgP/U6HZ7/0YpUTx0KQD3dbr14UbAdNTNjECn/Pm0pQ4MnK7xd6TSP/DcSjmqnaYI07UT9ZhwKEjqaCr60kHiLlW26isCzi1R7yKi2lh/dzpGhrWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aisec.fraunhofer.de; dmarc=pass action=none
 header.from=aisec.fraunhofer.de; dkim=pass header.d=aisec.fraunhofer.de;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fraunhofer.onmicrosoft.com; s=selector2-fraunhofer-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RLMriuCadsnJtGQYE3HzU9vrXSvvNC0CshUqifJncdw=;
 b=nT11QuA6kDdUSgHAWhzIHPYIRUmbfGgtbCqQSioAImEEtqtyhqYmqz7LgB2DHArMzsF8/tq1rIAUfGMTEw3aHe80oClo/z696ts1QmiWram2XTsH7Phh7Chytfoqd3n+rZPWdc49o0mHmUdt/EXjKAS/HENHWhLT020ILZgN7Yk=
Received: from BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:43::5) by
 FR2P281MB0026.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:c::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.11; Thu, 4 Dec 2025 14:45:10 +0000
Received: from BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM
 ([fe80::ae34:1ec2:9d34:a9fb]) by BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM
 ([fe80::ae34:1ec2:9d34:a9fb%5]) with mapi id 15.20.9388.009; Thu, 4 Dec 2025
 14:45:10 +0000
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
Subject: Re: [PATCH v23 09/28] riscv/mm: write protect and shadow stack
Date: Thu,  4 Dec 2025 15:45:03 +0100
Message-ID: <20251204144503.10895-1-andreas.korb@aisec.fraunhofer.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251112-v5_user_cfi_series-v23-9-b55691eacf4f@rivosinc.com>
References: <20251112-v5_user_cfi_series-v23-9-b55691eacf4f@rivosinc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0096.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::19) To BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:43::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BE1P281MB2435:EE_|FR2P281MB0026:EE_
X-MS-Office365-Filtering-Correlation-Id: bfb15d01-5e64-42c6-80ba-08de3343b972
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Aywd9/qrMxuemTYk96aDP2jN/llvysQW3C4DEXHE8EU+/eCm7u0JwBsWnQMx?=
 =?us-ascii?Q?cW/kHx4XPf/L7qrHUbSTwnmv6+uVk5cVM/lCrrNwe6bYaGzWQiWvRhpd9Laz?=
 =?us-ascii?Q?qjZZP4i1v0f4wDRlK23C59Z5NAAuM1eNCxaDflCOYx/JPnXdP+eJS1D94LUE?=
 =?us-ascii?Q?rw22TRToQclIcmDAS5F/Ayo4p6pE0D6Tdzb9j2+BqhvrZ6A4/cBI0dql0u6U?=
 =?us-ascii?Q?Os8HrQp/arlRELcio+h5IAYA0/VsTtF54JWzRgP/OxTZRLYmyrz4gUjuvCW0?=
 =?us-ascii?Q?SuzkMKlpasCbQfcNQAvvANEsn7ljoQ4/aAS3cMgBdjaCtP+YRGntsP/hw+QK?=
 =?us-ascii?Q?QJhzWLQAWSq9TkGwxYh7QMjsDCwbZW/bRnrtsQA2ggYRFCvW8Tsk7ElQhABx?=
 =?us-ascii?Q?GAEnvYyunHwEimz6Yv58dIoq55cjwXdgskxZVbFRr3dVWT7tidRKNPSe7AtA?=
 =?us-ascii?Q?AV/MV6npf2qO0UbKDeVrArOAYDNRXIG6nCOZxO7fgmwQTIIQYftvvgXnQQWi?=
 =?us-ascii?Q?6YNb5X72kqrnA6hf0+fAhbzDOtKI6lY0zb3GiiX9uZknCFEJAnthpTu76fc9?=
 =?us-ascii?Q?OByWxeK1Av/HPBG0cWg5XcV/5JODKONYID3Huzb/B8wcAvyx9SxtQQ6EFK6n?=
 =?us-ascii?Q?gHXLhSdtIM5BoYlR2Ea/FnUkjasiqZCEU2gA/YE/xKFnWe+77T8tlSJi+qTX?=
 =?us-ascii?Q?8QxisXoV+13t9TaX+MijYCvg8sF9lLRUQZ+ktwRV8INAfrvKlNurCq9/R36k?=
 =?us-ascii?Q?66RKNBRdbP6IHsJH1yAW5+3zqHu35/aJO5C9U44kHEFTHEydbQQEbb4DPcrQ?=
 =?us-ascii?Q?uDSSE6F90515X0kgCntnxawanuX8E+enBzty/Dv26HXqS6a14MvbVFKJJ1ok?=
 =?us-ascii?Q?wkFKPEmJvrSeottM2yjkFdakWs/857Gt0N/oSbpBxpAoMRrD/wv5fNMFjH4v?=
 =?us-ascii?Q?87/B9YBPu0mOOk3SRTha8lJ5VoAydM+Hxrf9EzGvTILLjQU44+q+Bu2puOqF?=
 =?us-ascii?Q?mhKjvcgX1OMifvNZbiEj23XCBPsNfKA6u7IuXvq2zmCWmYaAJGkTy+72kwa2?=
 =?us-ascii?Q?PIk65rGbEsM8B9VCtxx2S5netFaYZ87kEcVN3LEdQ2OPCbsCzOVCptzS986h?=
 =?us-ascii?Q?+WDG81GL6ldojwx/ptF+4taWfNK7ELbmQnR1R5u+x6E6IdkPxyUnaZLIg1+T?=
 =?us-ascii?Q?a2Xz2hSaVL9XkwCbnxulQQTAsSm/i6wJ3CSrgawTdeOupVLlRpmrAPltQqZP?=
 =?us-ascii?Q?Ag7QTOFrC2rDTotUQZ4Ddq5CyNsmRiJR40gX1VTDdaYKt0FIJj3I0XCF5cQ1?=
 =?us-ascii?Q?rkEC1WnsSCOilkGSsYEMAjzPH41c861Y9RH1kUs4rq5LgBiIo4fyWk6DrsWt?=
 =?us-ascii?Q?bKjaWnx+4bwDiczgHRlAMm1nyh0++XKL4FyVmyLGtJhI6cOfatbnHdeipDQD?=
 =?us-ascii?Q?VsaCCyi4qQbwP2YmRtrWWkFaQrOKz18s?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4+cMugT0T0jCk416145/pqW1lu/Y0owT0ggNRbw8e1+Qs+m5wmob3riY2RDG?=
 =?us-ascii?Q?axpuTeKfUOIvaZsdOGAqXs2VTudbqnRSjB9XL8KgasCKdwZFo3BS51EYPPlQ?=
 =?us-ascii?Q?ZYpo0J5MIBWUdOiw4p5+kuJ3bSXwmGU2tu5tHtUr3tLb5TABw4ZymuVBhPHq?=
 =?us-ascii?Q?EiIWibou3GVos6iUehqOngaCVskOMFx2RNachLY0RVzNXAMw2jfftRXwjj7d?=
 =?us-ascii?Q?Ow9udtucH2rZQ2Rkm8i225rGGqIepqReimNeCWK1bxv1e3YVSToRRHwNJiL9?=
 =?us-ascii?Q?MiSZZur7JmXNABMBdsV3lkulF9EJX6+cu8KWsh7b7RDPTfhVDyGF3szwOnlB?=
 =?us-ascii?Q?GCFF6zQE7/JdBHhCdPmEPUv8tCOMvQxjNX5RXw8/51e8jqQFJzEJRJOUdT1+?=
 =?us-ascii?Q?5BsC4MK5vU9eAm2d4ZZI7eEoDpR+KYBYIh+1QbYAU5qtBJLhjcXeqTaeO/l5?=
 =?us-ascii?Q?M5tE2hfloWP1q2UZaQOm20CwNdfXEfudts86AlNZWYljm95WQJBrrAxlRxK7?=
 =?us-ascii?Q?k6oKFEpfee5NQSm6A3iIv9F5ptKF4h5FCEzEpznziJkl0I1ICAZXGsjjhOpR?=
 =?us-ascii?Q?cA7KdozV2esXDkCllFCW9EH+PLMJVf/HtmQwCkUiyD6wCdLt6hQ915PfASOc?=
 =?us-ascii?Q?K40dAxFnJrJlohQ7yTFsBING2A8uUWfXRbtBGh44CkZTXXlOUn5W9UcO+7vr?=
 =?us-ascii?Q?f0EftC/8M0KrBuiVUiQJB8qaRVSsbYPl7ot6rgOFS66zBrZR6E+YEZIi089Z?=
 =?us-ascii?Q?qOiSwAdKSZHCUyCilgCU68CYifWNob9Ymnsa4lCuxMhzaZMhVakTqO7n0GX/?=
 =?us-ascii?Q?P4weSchPq/nTDYsrPAZBgTx0VP/fQeTPDMyTcHxHFtmmng4j0uA2k6NftIh7?=
 =?us-ascii?Q?UlEF09zhVFY1BWsKvZFWgwrHc6//fioTJeuX44XR4KNyJLIWqS4hG54EYIp5?=
 =?us-ascii?Q?+12LO/HiH8N061MdMLaWXa7W5Uh2uH22cTZkH+nWVYHV4nzi13L28h9rC9On?=
 =?us-ascii?Q?sUYuL2TMtDQaAQeBeTbdvb8W6FmKqEoYbA6LW6mDf2SRKrN6wYCTDxT+BFr5?=
 =?us-ascii?Q?zGy1ZVXRsUx10pymP9HNn0QXwRrDq0rhPvl2JfzrNQaAazBEcVCGgXNxqCM1?=
 =?us-ascii?Q?VrBKhJxNBc61/8wrAMo4UqBwubQ7XTiy4s+CWOM4mTU+KNOzZM15ekyP7fYJ?=
 =?us-ascii?Q?aBYipnMHNopLNlJBbZjae5DsNs6Z4h0xbeJhXW9lHVyQCTZs0bO12uNlkGcM?=
 =?us-ascii?Q?HA9d/pw9i6thDgrt2su1Cu+a72Lnl5sMZSGFvD95+YgDlHdHKIVwncVIpKLa?=
 =?us-ascii?Q?4t+w3rlFojD1x6RQ10gNr9MDj4ZW9MlxAdPkhHhzEl4x0XnQmvQPdpNBdV7r?=
 =?us-ascii?Q?vM5RBAeR82gOrRQVpXC0slFxuAeQjUb8O3mrYqqcAD8Zr78j/IU0eheYFnYb?=
 =?us-ascii?Q?39sLpUTg9C33+L1/ALZlbXuNUEewVONk1cDRUNZDdrO4FCCjj5kvNWZE280e?=
 =?us-ascii?Q?95jIhFqrHhy0R1eHUfCQYo+EfR6w64AYVNJLX4zB1N9XGGqK+trrYwJ+aj6y?=
 =?us-ascii?Q?31rNogoHIWLys2iMGe6XM/sLFuPsaoHTiLfDWwugyggvHp1Bbv0LvQNxhkZ4?=
 =?us-ascii?Q?FiXs/ig0iYgsnUIlRxmxDv0=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bfb15d01-5e64-42c6-80ba-08de3343b972
X-MS-Exchange-CrossTenant-AuthSource: BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 14:45:10.1736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f930300c-c97d-4019-be03-add650a171c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yZAEesWayYACcuJM6kTzR2G2q7nZ1yytwSQaHwhPkmoRWYgRlIcQwNyN0Jr2leUmzSP7UmzUiwMixPFkKuNy04k8L/8b2g2BcLzK6ANtcF/zBYP1qW3TpWcR27rltT33
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR2P281MB0026
X-OriginatorOrg: aisec.fraunhofer.de

Tested on qemu and on a custom hardware implementation of zicfiss and zicfilp in the CVA6 core

Tested-by: Andreas Korb <andreas.korb@aisec.fraunhofer.de>

