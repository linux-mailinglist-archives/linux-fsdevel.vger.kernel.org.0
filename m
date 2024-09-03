Return-Path: <linux-fsdevel+bounces-28364-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F6B969D26
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 14:14:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1052D1F248EC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 12:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40BE1C9857;
	Tue,  3 Sep 2024 12:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="EQ9hKuhp";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="EQ9hKuhp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2049.outbound.protection.outlook.com [40.107.20.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817431B12F8;
	Tue,  3 Sep 2024 12:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.49
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725365642; cv=fail; b=HQvfd6xwajV4BDpeYaQywG0WptNDmPEt0PmO5BrMP/7bZ7q4HCMyRb9guQAhHLGp3klEAOWvrim5mJG92G44DOFpHIsdyXXrNb6OI+Swxteil1fug/jdlNZZosSyHQ+4w+D8TwDx/rZE/TNEhydIf90vZGU0jg30brn2A4Wngug=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725365642; c=relaxed/simple;
	bh=uMjmxv59KvrWHCaHDrgA2BmZK/LLsBf3qSYAa1upj+E=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nmShNwZzI65meDTcDdoIzHU+cqdoJw1fJP0yIHAy3Hn5IzFbq6TGSDVziqrULe79rwOA5RYhgdw3+EBrtWzMLJoNDWv0gdyaGg18EdaW3PlJspGyar2HRk8dks5xpB63KxQpdNwAL6sxARDVsSipBeNtG/mluo0oQjPpkCfAF3k=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=EQ9hKuhp; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=EQ9hKuhp; arc=fail smtp.client-ip=40.107.20.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=MimmiZVO8ARAFcpRvL2LpWvr/qcZ8a+NYkVybe3Hy08TLaYi54IA9GWck1xDeg+jpouE4o0AIqZ7D3RRkDUUlqlub4SdjmBDQ18XT0y/8kvxIx5pd3nqRQCAgtrbCNix1TtEVA4c3Lklm3YgQEmV3e5HB1SEbLxuObWbeHvfglN6Vnoo6peW2kvJCnAZTLBqcG7k0O9l9BsbuhlK3TS/N3sO52k+xuMVXg/XCtJ6ywQys7ihZnEpXMVHn+/O+1x00N0v8omIVz9sxX8+252h9L22McL5uT2pouQDErOSGWxyd467tsFzqNYhIKd+i+E6XEG7rAuposDE3rFcQCuvHg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=epg425TY8ThFknnTJUOScLPyiBCiIk1XoF0wKby/ko0=;
 b=u7huNHwI9uXFmE31GLfjLeiEvgUOpDu4qjJ1soy85mgC9rEJUBz6s9LKNxjMQajVojl4wLxnJMKIEp0cj70YWNVQnNzh3zO2Ksr5+li6pa+11ugOWbF2kL4NioRvA4zzkXHlhRgiYI7Igh47kIwG3dNkpI+axRNyBCpycMVAFQiwtwvIc/+Ko+sjMHZwltcj9LssN4QQLOnIEPHA1WWOblFT330tZP6tb9L8JJBFL1wNy1BRtUUYJbppbvISoGcTZEW2qC4adPTbb4wKO5hSHo++HkMQOiTKfQeI9iQjw4UgIhoZqHzDvs19Z9fo4P4g4IXUca7vpLh3PXehGYJBjQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=epg425TY8ThFknnTJUOScLPyiBCiIk1XoF0wKby/ko0=;
 b=EQ9hKuhpzcbseLYr8bvf8Hke0QJjP0BYTRxgsxHKbhuKzZ1pSf2D8UpdwXcH3SXf2D39YQe8O5bvV6U04d06aw/mzpTlF15SxYglCgKSV1koI69Ydsax1X2BFn0GAvVgwpiK1h4c57Gv2WZy6z4fVMnMr93kM9iLqlgTcWY3l/o=
Received: from DU2PR04CA0335.eurprd04.prod.outlook.com (2603:10a6:10:2b4::11)
 by DB3PR08MB8817.eurprd08.prod.outlook.com (2603:10a6:10:433::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Tue, 3 Sep
 2024 12:13:51 +0000
Received: from DB1PEPF00039232.eurprd03.prod.outlook.com
 (2603:10a6:10:2b4:cafe::3) by DU2PR04CA0335.outlook.office365.com
 (2603:10a6:10:2b4::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27 via Frontend
 Transport; Tue, 3 Sep 2024 12:13:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB1PEPF00039232.mail.protection.outlook.com (10.167.8.105) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7918.13
 via Frontend Transport; Tue, 3 Sep 2024 12:13:49 +0000
Received: ("Tessian outbound 97d928cc87dc:v403"); Tue, 03 Sep 2024 12:13:49 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 28daf87b48a464b2
X-CR-MTA-TID: 64aa7808
Received: from L0abff40add27.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id C8D8A4E4-9BE0-4964-8CB7-890C598D964E.1;
	Tue, 03 Sep 2024 12:13:42 +0000
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id L0abff40add27.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 03 Sep 2024 12:13:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MlpnaYD15kk8GyPjtmcvrvzHgp09h/EVNpdasxvUhKAO8nbOy0u9H8MLCDf6ZU0f+yRcTF7Y8eDsBedXdjJN5B1b+8ie+njcYRU2QpiEDPrAhVwNXNHbqmW1tOJXsT1JOLzuoxTbCuvqvkHCVh9cFhwCbdJFiJo7BHy+Q0Y5X0Z98usNbDOn+o24J+7h7ECXIeeM8dIJkqO63OdH8oFW2SK7/u5zmP3bznBZ1NQZQpXEIZ/09sxN0ESEymc5oMX8hKFf4IHa92cJ/zxpdlpCjFQip5Lv9a/oIrLydjly65PSBDB3jSe8RVbc3cI76GiWad+ORxEDdRUGcWSdlRh4aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=epg425TY8ThFknnTJUOScLPyiBCiIk1XoF0wKby/ko0=;
 b=Nx8+D42Iw+TKTLNTgGU8ixyFlJnSydM8v/bG+x8WYFK0cqsbAQwUs0pZ/0i3fvLYw+qlK+mJ35efTWL9PqbENqpxSUMQ9LvoOuUSJ2AqhQMxhIzIl8IV91nxKhF2Rqu3bFb1ZfOKcMfEfGEEl55UClcljOGSYr4oOhHtNMoEJCEL14houej2h0SAGzzESQVw/KkB0aW7muv7x5G7JoupYjC+1taQCnP4S3npoLkfVV6HddT9mnFj4lzyzcf3Gj4r+D8HEy4ykUZKmYMqllbwvfO98MKIoNrEBjAOeNjEn+tc4HfYE9UOHgyZ6cBqCNkMVcnzWaicpAPFq+uPkOBU1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 40.67.248.234) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=epg425TY8ThFknnTJUOScLPyiBCiIk1XoF0wKby/ko0=;
 b=EQ9hKuhpzcbseLYr8bvf8Hke0QJjP0BYTRxgsxHKbhuKzZ1pSf2D8UpdwXcH3SXf2D39YQe8O5bvV6U04d06aw/mzpTlF15SxYglCgKSV1koI69Ydsax1X2BFn0GAvVgwpiK1h4c57Gv2WZy6z4fVMnMr93kM9iLqlgTcWY3l/o=
Received: from DUZPR01CA0029.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::18) by GVXPR08MB7678.eurprd08.prod.outlook.com
 (2603:10a6:150:3e::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23; Tue, 3 Sep
 2024 12:13:32 +0000
Received: from DU2PEPF00028D0A.eurprd03.prod.outlook.com
 (2603:10a6:10:46b:cafe::96) by DUZPR01CA0029.outlook.office365.com
 (2603:10a6:10:46b::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.26 via Frontend
 Transport; Tue, 3 Sep 2024 12:13:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.67.248.234)
 smtp.mailfrom=arm.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 40.67.248.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.67.248.234; helo=nebula.arm.com; pr=C
Received: from nebula.arm.com (40.67.248.234) by
 DU2PEPF00028D0A.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Tue, 3 Sep 2024 12:13:30 +0000
Received: from AZ-NEU-EX03.Arm.com (10.251.24.31) by AZ-NEU-EX04.Arm.com
 (10.251.24.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 3 Sep
 2024 12:13:30 +0000
Received: from arm.com (10.1.28.157) by mail.arm.com (10.251.24.31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Tue, 3 Sep 2024 12:13:29 +0000
Date: Tue, 3 Sep 2024 13:13:28 +0100
From: Yury Khrustalev <yury.khrustalev@arm.com>
To: Mark Brown <broonie@kernel.org>
CC: <Szabolcs.Nagy@arm.com>, <akpm@linux-foundation.org>,
	<aou@eecs.berkeley.edu>, <ardb@kernel.org>, <arnd@arndb.de>,
	<brauner@kernel.org>, <catalin.marinas@arm.com>, <corbet@lwn.net>,
	<debug@rivosinc.com>, <ebiederm@xmission.com>, <fweimer@redhat.com>,
	<hjl.tools@gmail.com>, <james.morse@arm.com>, <kees@kernel.org>,
	<kvmarm@lists.linux.dev>, <linux-arch@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-doc@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-riscv@lists.infradead.org>, <maz@kernel.org>, <oleg@redhat.com>,
	<oliver.upton@linux.dev>, <palmer@dabbelt.com>, <paul.walmsley@sifive.com>,
	<rick.p.edgecombe@intel.com>, <ross.burton@arm.com>, <shuah@kernel.org>,
	<suzuki.poulose@arm.com>, <thiago.bauermann@linaro.org>,
	<wilco.dijkstra@arm.com>, <will@kernel.org>, <yury.khrustalev@arm.com>
Subject: Re: [PATCH v12 25/39] arm64/signal: Expose GCS state in signal frames
Message-ID: <Ztb9aNvPZQsRPdB7@arm.com>
References: <20240829-arm64-gcs-v12-25-42fec947436a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240829-arm64-gcs-v12-25-42fec947436a@kernel.org>
X-EOPAttributedMessage: 1
X-MS-TrafficTypeDiagnostic:
	DU2PEPF00028D0A:EE_|GVXPR08MB7678:EE_|DB1PEPF00039232:EE_|DB3PR08MB8817:EE_
X-MS-Office365-Filtering-Correlation-Id: 1463d6f2-8bd9-4386-43de-08dccc11de53
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?DZOqgoROdYpgohQ8x5V79Yx9Hbh/tdqVp2CanyPkjyfnqxjP4sr7Ww2TCcZM?=
 =?us-ascii?Q?/XQX43tCZYAfg0r+y/DdrqnXd8w4qAzvsp+DObw246XsBR6l1g+rNzmfnDKM?=
 =?us-ascii?Q?7eGI4ExOpzYuza1mL8cuk1g1EP/bwNqo+ZUdiR+A9o9faJSVcKWls1b3cZIf?=
 =?us-ascii?Q?/8/g0jzY1iyYSvrpzEULdgzbmiGruyNUhaxbgiZPr70Db/JYG7QmLxbuZH9y?=
 =?us-ascii?Q?Zc1qLikuCGCCjry2t5r0GF9+BdKyZJDUCwEQKPMMoxohiBHaYY9zGNwbai2a?=
 =?us-ascii?Q?Zt1iBXxU+Jo7VMJortGLkQcBzzxAoO+OEfF8c83mj8aJdIo9qfoYkDUI3jQO?=
 =?us-ascii?Q?riF0qdDx2yXSiK9/kc0TklwYbS5ZNUEhc/OCIyj3bIJ6JaG1tTU03WqK/g+L?=
 =?us-ascii?Q?lLCvc7bn7GKN+/tnCrOecV38aSaAJggjH65yqQos0/ZBoQWjytBVsVmev3uq?=
 =?us-ascii?Q?JDJ1krF3lsQrKSIoTpbAg7VQlhbOgGVtol8FHuimQDF/1ViXMTfzMAfD+ReZ?=
 =?us-ascii?Q?h8fl8OO8XCJx/69TeQp+hctK+0N6wVWueeZ4LE12UHfrAGoa2yfIiYXtLZnl?=
 =?us-ascii?Q?RQVJbwbhpmfBCluPuSYuK61ffDVXyBvRTunw+wl7BYiXLQS2yD+HpIMTuG8k?=
 =?us-ascii?Q?UJqLloRZuvCJAFLsVtwsh+LHcHJdmhPU8GLFjy/Hs7as6JUgnw7oNeFTN2/E?=
 =?us-ascii?Q?FwshQieBP/h0YFSvH4FTCPuC/y9ajhPIS/Ly/CSfP19f/xl41rznt4joVwbs?=
 =?us-ascii?Q?8kgR09fB1oCRSsW0kOdM177km0EgBnkg6snecaKS7W93DiDebph3/B0X7eR/?=
 =?us-ascii?Q?n9vUSH2zy02gdavFIRzy4/lFDOeqL9VwQJsQnXdggxLWOsgDb8a/jipVoePq?=
 =?us-ascii?Q?fFMslkDfxMxH5fH7uNs7MtCJKpzQjx5e50do8BN7Y1L0sdNKVw8wSaA2Jkx5?=
 =?us-ascii?Q?kuBmSuEzMLmb6Plqk1gr0XQB4ECyXSovRwYD+SLl3o/cyLzlkvwKR9Rw9RXl?=
 =?us-ascii?Q?dA/3lHmRsFQ0VIvyDxv0Z6dKPaBn6qrbdgEr9eFIhDxUGwprCKZ62BsyNuYT?=
 =?us-ascii?Q?1WL6izNDSMCNYW1qyZGEN3PYeKOo+blS1PnL34+J3Bc48g3VE7YCZCrMTZxe?=
 =?us-ascii?Q?v8dFl3cx+nZhYbfG3mp6KNd9eAB1DT9MprQnZRR7OmH4pn+KJ5JIhb/vHenZ?=
 =?us-ascii?Q?y29sOeLBLcPVGqaPxTluGCoMQj+xDS4AluJBZMIESbjdiCMb2GU7ju+TCwpb?=
 =?us-ascii?Q?NAakLrLElV7Ixnj48EHAcowo6JNZI5HfKrfB1rppST/xV2MV0OT+dkGxqi67?=
 =?us-ascii?Q?AUH+wxSeG0dRP36jgXs5ZK366qiG2CLBsz+siYZXnSx37sWavYcTVm8RPThX?=
 =?us-ascii?Q?LHL4Z9Yw6HZsdWBXY2AnMbAg5uyJIqJk1SanoRxg17RcLtFYhp5Qk1qNZHD1?=
 =?us-ascii?Q?NS0k1hrkVoLXvdicOSbhYYh+fijyt7yb?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:40.67.248.234;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:nebula.arm.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB7678
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:10:46b::18];domain=DUZPR01CA0029.eurprd01.prod.exchangelabs.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF00039232.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	3008b241-3267-4aef-bb3b-08dccc11d34b
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|35042699022|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KgushX8Xk+ugfi4GR8tPvfAco/qKScDgVrnJaPXD20WPCGjjIBOMal5odMQs?=
 =?us-ascii?Q?lhWmVqP3Yd5SRgtdilOZ4bmSG63QAlxXtCmH//rTWLeMyGCH/+D5bd1JLago?=
 =?us-ascii?Q?6N3IVxOD68rPWiZwj6EETg09XdA8hhzEeJmUDj4T4PEaBQbQ9qBU13PkfSv0?=
 =?us-ascii?Q?Ynd77SgQSL8Gd7DhXy9Wr6Ut6lykI8dS3FdOVEmNSRcfTBXb75tra/xKXVeI?=
 =?us-ascii?Q?qmUmQKEk0SDVj3vEoyOzQQ4XaYkfNwjUYzCKLiyvURRtUNUIaFxXykbtW86h?=
 =?us-ascii?Q?ZKDQJWnHxNhgZNTeoz++bFHcgUJqgMfnlnQwXiQtSRdh0E5QA3T7+moK2txm?=
 =?us-ascii?Q?LQc5s3UqAl165bJ4dCfBby25OUdleQy5/c30fVcf7DMyTLXiwIm4ePGfWqb6?=
 =?us-ascii?Q?J3NxA/2DkKyuZP7vq23gigbwD0LQaz6uUQCu49kEPOSX1SQeOU+FtPWG8BtY?=
 =?us-ascii?Q?/rn3T9DsyZJ+aRLrafifhDqUzExXnPo0I0fBDkm0kV1b3M1vO9WsX5o0+Q6d?=
 =?us-ascii?Q?adwto4LaNWdtqPPlb0Z35JO4ksuK+OMTZAzBo3Gkbm6qtnzH8FckoWTLkt03?=
 =?us-ascii?Q?vou1VxdTPb2Er4r42ypuIXhwUcSnaCM7AKJIwYexYp707SOpzn8D5fEYSaxW?=
 =?us-ascii?Q?UCsOOqCyMeg6M474/MB6Fk0aYaKN9M4yecM3lQjG1iHXzlsZypGiOak/Mmq8?=
 =?us-ascii?Q?F082XnSbc+YvMzVh1MsZi9MTW2ennuCS7LlRy8zD8CyCtOd0bMjBQdYieQrq?=
 =?us-ascii?Q?Ld5ZBdA3IYJCuHTO3lRZr5LXquLQqOHLdzW6kJ2s/TJBYAbnboX2WAMKNAI2?=
 =?us-ascii?Q?Ea3sz2igGVIhefCtadL+lktJM2Nm3zjdWcFsAy17RwYKrjDgI4ulHWFSRZM9?=
 =?us-ascii?Q?0hYqxlPouMtLQQon+XhihfMuDmfm+rV+kd+hqHCwNHWbCso5A6FbvOmNqOZH?=
 =?us-ascii?Q?Ntrkgs/8lAkDidPp79JMctKGRFSPAgTxdYIESTeC41BjkKrzbNamHFYbwlxm?=
 =?us-ascii?Q?6MQBXI8PUW9qk4ra7ka1RPQ7/1q7N3H/gm260GGHOe/yPq6TNfLLbAG5bHMy?=
 =?us-ascii?Q?MmmwIx0wBfSHYzeMQdV3bGLV9S5rOxjA8CVNggssJtz903aOssD7g+ksD2eJ?=
 =?us-ascii?Q?G24IEj/wjwu7SQP3qyVcpe13trJkBTTsXOIxxv9lwBjwE4QKYpi0WmhkU2qE?=
 =?us-ascii?Q?FDaPMZ1I/bR0jbxM+xaPdhXLC2jgtg5rSLwdZyeKZZT6WScTlFx1j2k5i6ho?=
 =?us-ascii?Q?AVdJ7lGN1Bgr/IJ2i2NVD1DtUfaO/mzeBObYO4WhEpM/Apjm0tpZDnrGj/KX?=
 =?us-ascii?Q?4CCX4QI+HSp3L9ISowsu2gLStBKD/2cTWzCPYrHsRDtXNbaD1KZZUuxWmRZg?=
 =?us-ascii?Q?4gcRqfHIfra8xkN57z4/3vCNtYI045N64+PDPwshSoggkqM1JP27IB2hrxPQ?=
 =?us-ascii?Q?Ad2NKvZt6jfylgWGABcuJyf8eXiIO3Af?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(35042699022)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 12:13:49.5495
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1463d6f2-8bd9-4386-43de-08dccc11de53
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF00039232.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR08MB8817

On Thu, Aug 29, 2024 at 12:27:41AM +0100, Mark Brown wrote:
> Add a context for the GCS state and include it in the signal context when
> running on a system that supports GCS. We reuse the same flags that the
> prctl() uses to specify which GCS features are enabled and also provide the
> current GCS pointer.
> 
> We do not support enabling GCS via signal return, there is a conflict
> between specifying GCSPR_EL0 and allocation of a new GCS and this is not
> an ancticipated use case.  We also enforce GCS configuration locking on
> signal return.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

Acked-by: Yury Khrustalev <yury.khrustalev@arm.com>


