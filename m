Return-Path: <linux-fsdevel+bounces-30902-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59BB698F43A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 18:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1879B281092
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 16:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE2411A706C;
	Thu,  3 Oct 2024 16:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="T729HnV1";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="T729HnV1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2085.outbound.protection.outlook.com [40.107.21.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9781716C453;
	Thu,  3 Oct 2024 16:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.85
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727972764; cv=fail; b=t3OCqaD/0nub9ewntxfrwfdKRNwRLpgaEu5hTsb9T9F7eGdbt6OxynUVIqEjlXzSBh/r4JUdXY5VvqiVojLX2kWHOwZQfGmOa/o+mh0urh+tvKgluZKV979IFEw5pnhYAO3NpfS23wO6wf/FItOfmRqZynIc9LqZFWEZ6gw1gAM=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727972764; c=relaxed/simple;
	bh=WWq1RvtrGZKMosG8DoAVsl8KpsVJqgyMTdM2sW9xVI8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KInCtxlBNdcQTIGHfapVwoRQ0bGu48kOt5zCOC9+BS5m2npwi7Oh/+fZXuluz9lC3uQidM2GdKepmCSuW03TH2RJEt6hLKYvJGhx2ZKFOejD4hvdvbRuKZ9CodHUL2bmoytcBDVQ7nsN6APkGUJuh9HCyq7oKtkC6ocRZSg9xKQ=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=T729HnV1; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=T729HnV1; arc=fail smtp.client-ip=40.107.21.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=mHAN6wsiIep1B2upoX/3ObN1nrpP8tUUGxgnSIw5sEXqbJxOg9zQXFWicW4E4W1ZgHAMqRtkyIO7L9o0nT2niyd5mhY7ZvxXElJ4fLMtoRfSqHXlYZf9DZkUxQMebR7TfD6SZnldHRV6QaTd0NIYEouW2HWprHJv1vx3I1Ib50u+6Hkja6Xs1cHF3wQc2gaDcRxsiPzetiIWsr8Mdwv0lG3uyxiTtuIFC2hj5ZjfLzvQs7txBOAwethJfb4a3uBrWTiaEufzoT0NagWmu2bFtOvC1vxTE2O9ltAuEH2IB+8vV3HC/I7HvjlcrncWtoMVG6Blq9gp6e6kUGI3gztC7g==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y8bUP8pfbQz6muJqZlHMDu2399IoR6iXiLCJQPxtKjs=;
 b=iQ1n9WHB8053wPhdgVmQ/fNS1kkOo6i5yEmkQQ1M/u9TMqv+c7c5n0Zl20PaB1Q2KwddB/2omxoewo8cZTTgoJPF5DcuipQp0YIduSP/+7dAZ6075cIYcy3nyoknj4o1H69BTQOyLXa2KDo8sTGZq7p7pOk9TGomQBP7TqeJmkHx1CP3zT4qGpbgcDEVj8+Y9po1hZhA4PYFsVuou30iYBeq9o506NrHpzefTIv5rX0F47cX1PRqR6qI+6zlVen+9Ef4RVakw7P4wv6CzG+56vKIWS5y0SDcXYr1oEyjBtOhZAxmdxvOLjJuawT4/9Njr3v+M0825hIZ8vZ5AlDnNQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y8bUP8pfbQz6muJqZlHMDu2399IoR6iXiLCJQPxtKjs=;
 b=T729HnV1d3YzZSFdybokhO/nxZhmgfEhNbWvg2OlXUtyjkCBEfRQ6CYUkn5AaP6RuixBBkAS9odU729qi4yu4QAvmiW//FvnKJVT3Z81KR+XGhQyptQi/FnucB22sX+/wTn0vILAXGjyf8zbudF/tMbE74UYcDs1v+A8SHTaUK0=
Received: from DU2PR04CA0228.eurprd04.prod.outlook.com (2603:10a6:10:2b1::23)
 by AS4PR08MB7687.eurprd08.prod.outlook.com (2603:10a6:20b:506::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Thu, 3 Oct
 2024 16:25:55 +0000
Received: from DB5PEPF00014B9E.eurprd02.prod.outlook.com
 (2603:10a6:10:2b1:cafe::e3) by DU2PR04CA0228.outlook.office365.com
 (2603:10a6:10:2b1::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.17 via Frontend
 Transport; Thu, 3 Oct 2024 16:25:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5PEPF00014B9E.mail.protection.outlook.com (10.167.8.171) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8026.11
 via Frontend Transport; Thu, 3 Oct 2024 16:25:55 +0000
Received: ("Tessian outbound bcce15e2414a:v473"); Thu, 03 Oct 2024 16:25:54 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 4e90799dea60ef9e
X-TessianGatewayMetadata: IF406E2NVOIFiXRMbuixlvdY0LfJgZR9AMmShAAlmhttGJfQeAYOYSCbZhYh2Ti+nmHbQBBe3HifxkkepticuSgFiZA2+glvO/u55hPCMAJrqK/14zh7nhcimx+xz18rBvCOz384enzWSWLP3e8yjw==
X-CR-MTA-TID: 64aa7808
Received: from L6f6aa0bf32e9.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 7644A89E-DC81-43F0-9876-09150D533089.1;
	Thu, 03 Oct 2024 16:25:48 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id L6f6aa0bf32e9.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 03 Oct 2024 16:25:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PUbYYsWhR5PBnawqSnkZON6nMJr9GqcHbnEjrZJLcKGaF52TVkVnWDPkcMqfp5ZWEoEIXamTJaJde1fdOKunjuqxUjWMrEsjCrHG7hu23VFS7UKKSkGwFaLHJqw+Lwo/JkikJLuDRWk14yraZz3jDAUWIe8QqJMnj0j18OOOkNTvfLXjmrkY7h42dQk235sYIJ2r9GN+AlK+1BiSSBWwHMb2d5tAMS7XzCnHGnbE/cu4u35hyKmZiiWMyDlStzqcyKLt50bK1PjJ0Cv4R8Oq7WvZByxkMCkmuzoqZ9pLsQfXAQBk7xxGMOglbf1hMjCwf2uFyx9+eRWiQrzpiU5akw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y8bUP8pfbQz6muJqZlHMDu2399IoR6iXiLCJQPxtKjs=;
 b=ERsQT13DCust0Y//m7n3jtK1gDMcshDsRCtA8cIMPJ5Z0PKVDJY5f3vvtjUrSsPAg2FJxmDSLDYLsGlEXfAROBAi1k2ys7nlv/6/yd2FQ7+HXNC4oA8c8SKGLC5FS7bT0AyMlaHN2Fuln9aPpzmXKbhRdJCaXsidQYkz7M0VNR6yZkYzajA5pv3TPseVy2DR6uGl79y6pP5XVV9x1FWEmt7hQ5xLIE/VvwmUE2xiMksaOkyg90VNmvGiHXsOwZ59e/8iYvF/PXyDCCmtIwSeWderOgQsW2F0/9eD4MtX+HAuVk0xBja8R0rtIYdOdz9L5aTDviroRPySbBhc24I+8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 40.67.248.234) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y8bUP8pfbQz6muJqZlHMDu2399IoR6iXiLCJQPxtKjs=;
 b=T729HnV1d3YzZSFdybokhO/nxZhmgfEhNbWvg2OlXUtyjkCBEfRQ6CYUkn5AaP6RuixBBkAS9odU729qi4yu4QAvmiW//FvnKJVT3Z81KR+XGhQyptQi/FnucB22sX+/wTn0vILAXGjyf8zbudF/tMbE74UYcDs1v+A8SHTaUK0=
Received: from AM0PR08CA0004.eurprd08.prod.outlook.com (2603:10a6:208:d2::17)
 by DBBPR08MB10507.eurprd08.prod.outlook.com (2603:10a6:10:53a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Thu, 3 Oct
 2024 16:25:42 +0000
Received: from AMS0EPF000001B6.eurprd05.prod.outlook.com
 (2603:10a6:208:d2:cafe::64) by AM0PR08CA0004.outlook.office365.com
 (2603:10a6:208:d2::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.17 via Frontend
 Transport; Thu, 3 Oct 2024 16:25:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.67.248.234)
 smtp.mailfrom=arm.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 40.67.248.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.67.248.234; helo=nebula.arm.com; pr=C
Received: from nebula.arm.com (40.67.248.234) by
 AMS0EPF000001B6.mail.protection.outlook.com (10.167.16.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 3 Oct 2024 16:25:42 +0000
Received: from AZ-NEU-EX03.Arm.com (10.251.24.31) by AZ-NEU-EX04.Arm.com
 (10.251.24.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 3 Oct
 2024 16:25:41 +0000
Received: from arm.com (10.1.26.195) by mail.arm.com (10.251.24.31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Thu, 3 Oct 2024 16:25:40 +0000
Date: Thu, 3 Oct 2024 17:25:39 +0100
From: Yury Khrustalev <yury.khrustalev@arm.com>
To: Mark Brown <broonie@kernel.org>
CC: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>,
	Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, "James
 Morse" <james.morse@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>,
	"Arnd Bergmann" <arnd@arndb.de>, Oleg Nesterov <oleg@redhat.com>, Eric
 Biederman <ebiederm@xmission.com>, Shuah Khan <shuah@kernel.org>, "Rick P.
 Edgecombe" <rick.p.edgecombe@intel.com>, Deepak Gupta <debug@rivosinc.com>,
	"Ard Biesheuvel" <ardb@kernel.org>, Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
	"Kees Cook" <kees@kernel.org>, "H.J. Lu" <hjl.tools@gmail.com>, Paul Walmsley
	<paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>, Florian Weimer <fweimer@redhat.com>, "Christian
 Brauner" <brauner@kernel.org>, Thiago Jung Bauermann
	<thiago.bauermann@linaro.org>, Ross Burton <ross.burton@arm.com>, "David
 Spickett" <david.spickett@arm.com>, Wilco Dijkstra <wilco.dijkstra@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-doc@vger.kernel.org>,
	<kvmarm@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
	<linux-arch@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v13 18/40] arm64/hwcap: Add hwcap for GCS
Message-ID: <Zv7Fg7BkP18O9CdS@arm.com>
References: <20241001-arm64-gcs-v13-0-222b78d87eee@kernel.org>
 <20241001-arm64-gcs-v13-18-222b78d87eee@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241001-arm64-gcs-v13-18-222b78d87eee@kernel.org>
X-EOPAttributedMessage: 1
X-MS-TrafficTypeDiagnostic:
	AMS0EPF000001B6:EE_|DBBPR08MB10507:EE_|DB5PEPF00014B9E:EE_|AS4PR08MB7687:EE_
X-MS-Office365-Filtering-Correlation-Id: 140ee3d9-6259-496a-cbf4-08dce3c80e80
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?hP7p46UKxp2ySWE7jzcxYuYBJyVfWkRIHtdnwgcT7nr9bz2ll6nBMdoMjbq9?=
 =?us-ascii?Q?YqVp0YJy0qN3B6jzG1STi2rJInulzOOVt4/i6gG9qkEiUYs3VzFVmpPE+Kjl?=
 =?us-ascii?Q?Hx9TpAz1ynXEOskGxvbL9drKSNHhBCufatzPSoZS12JtA4xH+if9s96jGZE2?=
 =?us-ascii?Q?fd8L72ji/xuOU8xSFWWLhcUmeOSmqgav/vJXDhwWyOrqo4UoRi9vsvglQbZH?=
 =?us-ascii?Q?AqnvGsl8v0bUvPVxZ7FMJrhi67XMDt47S1MrKAAQuoRmpqIN832ErUosaKed?=
 =?us-ascii?Q?vDmMVsFY0QTNSXP9AIutjvaXVsiiOMWqJl9O1J8qIjrF8erHU8r5gDm9rjsD?=
 =?us-ascii?Q?m7RUcCW4UxhflJHaTauojOT8z9dnTo95meT5cIesTwFi0rQi+1ZEEF3vvKnj?=
 =?us-ascii?Q?SFqJzkOb9E4VG93ibkGGj8ovPfvu4Mc+RauauueiqMDSzFAwijGE6G1VdgH4?=
 =?us-ascii?Q?sxTPGDIyfnuciiPIK8Onav3hWWg+F+X6K3A3WyefZFCPh5oKy3OjqcRjEV9Z?=
 =?us-ascii?Q?f+/Tw9KM4F/9Wtsot8atK7sEy3mUB/kWkVv2WkAbz5g9JWr/PZ0rYpc555pw?=
 =?us-ascii?Q?kF5BBfJXLjegRwx132AJ1Vqc+2mF7WQ8BOfN6jk7bYcufPTe1LFApOxkFA9y?=
 =?us-ascii?Q?Nk3DM7zIfG0iGZZ0Rl3KwL7YGGDA7Z8LRu6SarhMUJ76DmIeLwiFQ54XwpD8?=
 =?us-ascii?Q?WhwMrN5JIqnItB32YhENIhkNaBhGAXpjgxmzTPM0uQakM11cns2Np7sJDMz8?=
 =?us-ascii?Q?2zJXbd4Andy4M4pA+OBUB9OK+XOVh3e18iQ1VG62vTxqlefJKKlNwWaxDXu4?=
 =?us-ascii?Q?h25vb25ucxIeJ8PF8iJ557J7l6OKMic7syjarHpywFkzhA9iXy74vKm1tWLT?=
 =?us-ascii?Q?55pHIrqOGrB+YZk7kYpJgN55WcH8+Ju02MxUFNDChfCC9UY/LIH5DelgBF9j?=
 =?us-ascii?Q?IZJloaTyPdWPYJm76MWMB6Rox7Dzg5vwExWk3eNZidtBiun88dpckOAZDTxQ?=
 =?us-ascii?Q?2SjESxrYPGfYDW09LCtrnB5YHC7YvqpGqZrpeEJ6yOuieCProFKyhLWCZBof?=
 =?us-ascii?Q?118hsuPMQnfnIQWJwAJ2k7isM/kha03nIvnSn3T5PL5J2D+zRj1bzJOFbZVa?=
 =?us-ascii?Q?hs5irVxunnI9Lq+fq8AfyarXjKeP8HL55fcDbYdjwQGw3G5wqyymjc71W1o5?=
 =?us-ascii?Q?S4G9llEvkIi8THCwHPKT08KimIOtPF1iy8gmXeSWE5UulZ7Bp+TvTIY6dOYC?=
 =?us-ascii?Q?Z4pjduByNtVopwI0vtRN/D+3P2RvaubuNfQquzF0fGEQTRCmogGfm3Fea2s7?=
 =?us-ascii?Q?DE0vV3wy9PjCqyCx4PVfhqQ5JeL/1BfVdyTJxKyQSxhVQ8ZOO5dE6RngAf8Z?=
 =?us-ascii?Q?kD9u/LBBpU7pX/4/985bZ9RVqo9F?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:40.67.248.234;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:nebula.arm.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB10507
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:208:d2::17];domain=AM0PR08CA0004.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB5PEPF00014B9E.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	2d6d03c8-dddd-40be-a3b0-08dce3c806bf
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|35042699022|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mpSxSRnivdYD1OGtYB/avaiqhfVF3XF6jbIjvqPTJBE6qbB0dPqDwxiXevQf?=
 =?us-ascii?Q?ycp8/cQZCAN1RDc54e8cck56Rr4AYd+Hct5zjhYgjSrTCuM5g2SquZEZbx0O?=
 =?us-ascii?Q?yZXZT7jWTayXy5quPbevJjDjR5NRh4Nlby29HNx3q70YxF9LrbwpR1627hNN?=
 =?us-ascii?Q?2obGPN+kcKBRu/YcfHIyCgUOr3691NvGpDe1o7cKdZJYYbIP2DMq/bPUOdg7?=
 =?us-ascii?Q?dy2iDFeddijD3JIiwPmuL4ZkaiuQdrB8cwv3oJQdhxtZSxt464UssoEElVzl?=
 =?us-ascii?Q?PHDd5Drrq2LJIcQPF6e/u1akJxV7viX07p7FzmMD3+FRTsovkdCkKgfG9Vit?=
 =?us-ascii?Q?S3GV92EdQqjwiPTCSn0AqVUmn0Ie08CRhEf6/zHtPMyaAf6L6APmMPm/oQmh?=
 =?us-ascii?Q?Cc3AWckfakS2V7XBntNVlXZN/EyPqtwa7jQcQOI5YFpif8jWo171mN8ba/jb?=
 =?us-ascii?Q?9A2LYjTyjzmjGhlQ6QTbH5Kt/Kao7kvc8rXQqdz5pO/dPSQoUknWOUrMpg/R?=
 =?us-ascii?Q?aDMnQLHc4ge12dKHj22MKVzYDkITP5BnCZcLwdFeNO4cJgb8KkcwkkTENfqm?=
 =?us-ascii?Q?JPCZMf6hMelcsvrGl2ycYvCcdWqonghj1OM2IjnhgPBufYbD1UnHXoroSseA?=
 =?us-ascii?Q?zybgGllpo27FuAWt8LmbQ3VpuEU9RoTCpqAZndA88LwmxQGzjouzvjyQ9e6K?=
 =?us-ascii?Q?4L0TyQ/X8/zwnV5JZmcdyVnWwOUIRgfH/vOPEFaZaXHXDOZ4GTkUlyjtb274?=
 =?us-ascii?Q?JespN9RkuShDHC5wLnBWKzPNebCapTyhpDOHWFldlymJY2WniwewahzPNeJK?=
 =?us-ascii?Q?+jdC8IpcqOkit57i1gixqLRV0jyY0mnSIKvsuKfOMLsu4syvFHxJIE4SaLg+?=
 =?us-ascii?Q?FrugZvSzo2eBdtBNe8pDMecPUVdzDeaKqIUqCoHAChI8beL3gthoE8SSAS7M?=
 =?us-ascii?Q?czOLogmRFhyvi4bQzjpKSSA7xLtoE04mSbEkFjy8qrKdzK6usOJraFJ3G4pn?=
 =?us-ascii?Q?gfMErwIujQkqbIX0hsrvOCip5/Dz0+hXNp/iLLitqCQXEQl60IiH/dfaueXE?=
 =?us-ascii?Q?F7I675VtGyMNen1qQsVglN/D8xSbvVSKLuOxb4CMmKxadAzarRPnvmOiEfZW?=
 =?us-ascii?Q?dg9oOGzINtWgnuQyDVPWkL+alC3cNu7ENfVIvCjqDpXre9cMa2godyHv2XX3?=
 =?us-ascii?Q?aPz+7tnzmdfg6os8KWlK+t2F73zzzSx+gag5CKY9jMZkAvxTFwIvwgfY51I+?=
 =?us-ascii?Q?Fi3oZYt2zOW9COPoywbRw1xU0GDL9OBxIW7P5bdopCinhtPy5wtH6/RmV8JR?=
 =?us-ascii?Q?8P2j6OJcxTQgjK3t6zxy4OKBrR9tp9+YfLgzRqCg52bDXzNe2JBJ2Ct814Vi?=
 =?us-ascii?Q?nCygZ+DOOjpzIXgAtB2sHdMT7qLu?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230040)(36860700013)(35042699022)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 16:25:55.4335
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 140ee3d9-6259-496a-cbf4-08dce3c80e80
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B9E.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB7687

On Tue, Oct 01, 2024 at 11:58:57PM +0100, Mark Brown wrote:
> Provide a hwcap to enable userspace to detect support for GCS.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
>  #define HWCAP_PACA		(1 << 30)
>  #define HWCAP_PACG		(1UL << 31)
> +#define HWCAP_GCS		(1UL << 32)
>

Acked-by: Yury Khrustalev <yury.khrustalev@arm.com>


