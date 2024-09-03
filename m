Return-Path: <linux-fsdevel+bounces-28336-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7039F969838
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 11:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27C9F282DE4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 09:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 316C519F417;
	Tue,  3 Sep 2024 09:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="UyTZ3ao5";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="UyTZ3ao5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2051.outbound.protection.outlook.com [40.107.21.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7751C1C768E;
	Tue,  3 Sep 2024 09:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.51
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725354273; cv=fail; b=l4SePFm4ZpVCiymocBntNLJvHDE8tmxOtPTTiOE/K6u8KvXAyDDqL6uwxQXiDGfrgL3KauV/brhxx+1QjXiatiYKsSDQRR1HmA0gBBlthaGHiWvF7XtNewbuMhcye+d9HyyDceaOz+26wR5Oco6C9YDxmIqPJjf1Ts/PVU24A14=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725354273; c=relaxed/simple;
	bh=20VxUN1hdqgGvJVVJYLFP4Uqv6Jh/e/DuOr3frCcEJs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QNLYzIn2j4+2SrOvTXiB5iarwaClb9uzpH5iyzksCv7XI92WR9+gQ1AvgoWpNDdFmzFXn2OEGJElpYZhFCgEgf4YBbetpxZ6hPs1GQMODwcan/ZuOTHprOydJniNyCNGfQyL0mCQQ71nAW31AS3up7PmWjqPNlJR/j1Zc64mrPA=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=UyTZ3ao5; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=UyTZ3ao5; arc=fail smtp.client-ip=40.107.21.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=cOYY9esy3hesA9C/TfYIQOIm6R4METIarNCWdImuSd7Rq4C4Tk7qd5btJkaacIm7ovKLjAu/U/mPP+wQGYYPYYKpfqqUBFTbT77TMCViswVv6SzQtl/rXBinKkRRq18fH+iSExpQKQerlD9bz3V2BHTkLdayRtvsC7KGigxBK9Z/ccbtG+ZNHBaY2kiqUdl2bajIIZglOE+gkJa2a4EMlE60n9yRuxsH1WYSC3HXQzZIB9cIBDHkCLW2oSwlUsSZU5aOsphwtWB2CI6bhidtcg0EBrsWiiTjZG11bD93iXvRtMEu+uXqFYUY37chsZRsiGUgthi9lwCpNZgM+PHBGA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R5r9xHQHG+scXrr2lbtrROl2d6zj7h3adAv4PeUbXxA=;
 b=dqeHT87pifPymqSCsjTKsxHCw4q50zf7QeDxj3qmaZ+EVou7XKkpUUoFGCPTpfjU6GSVo7egAmnBzmabIr9qag3VeWgwx8XhFDTn4azete2PUWLREIF7ulOzRzJLLhLfS8BQ0Wv6GE+otwO4ZNQe4xVxM9AHJucX1gOUdhNK1ZP+QalvVCd0qHYQLwZosSdfElOGz5Pnid13qkeXWh4vBrPhPycqGDBFlayOZcUa2qalE0sRvsiY7KgpdgaFEB6oJbYVI3DsjTCmyBztKz0BGF4xwVO7KYh1ARkC6bDkC0CjxrxxR5hMz04hiYHF2JwDGi6mQPwaHLvRkckh0lKAMQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R5r9xHQHG+scXrr2lbtrROl2d6zj7h3adAv4PeUbXxA=;
 b=UyTZ3ao5fXyaGax8FnJq72YkUOJ+jfUV3TvBMEEBDFpQ59EzfXHSGOqt2+pu2mPEPi9HObaBicA6R4BfbGM1Qd2H3qHq04wQX9hdYmNFGjiNMG+h5poaLx0qWAJlw3cApixdihqFJvYCPrd1npvnczn9fKtqMnG/rcd7lvggL34=
Received: from AM0PR02CA0125.eurprd02.prod.outlook.com (2603:10a6:20b:28c::22)
 by DB9PR08MB6378.eurprd08.prod.outlook.com (2603:10a6:10:257::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Tue, 3 Sep
 2024 09:04:24 +0000
Received: from AM4PEPF00027A63.eurprd04.prod.outlook.com
 (2603:10a6:20b:28c:cafe::17) by AM0PR02CA0125.outlook.office365.com
 (2603:10a6:20b:28c::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25 via Frontend
 Transport; Tue, 3 Sep 2024 09:04:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM4PEPF00027A63.mail.protection.outlook.com (10.167.16.73) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7918.13
 via Frontend Transport; Tue, 3 Sep 2024 09:04:23 +0000
Received: ("Tessian outbound 7d86ec5dfeb5:v403"); Tue, 03 Sep 2024 09:04:23 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 80ad58ed9b07736d
X-CR-MTA-TID: 64aa7808
Received: from L9b17469c2d2f.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 347FD1DC-81CC-4A6F-9EB7-015C880B5A28.1;
	Tue, 03 Sep 2024 09:04:17 +0000
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id L9b17469c2d2f.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 03 Sep 2024 09:04:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CGnSc1tcK1mWJ5kalmbTGs6wPcIQgHIZTsHCQLt4DRB4b5BNcC19lPN4QGqwgL5faDT+kOouF8v0MRzD4HyEpI3vT1vj+pGw7ZD3GyKPKW1utzHMJTT6l13sjg/z5Nh9VlDsQFDKXxx1gWHQZd8k1WfafLSMmQvk/2F4sb3ZUAc50IzQ/pIFJYWv/Y6aiK34oRN/+26hb9djKq5SNKDWBzuqBIoYkAsXSMCOOT/MEyltptBzTvCU8wl2qrD1QEQ3dhrSJa1c7aYWIL4cuDQ85+6zd6o57sTffG3lqG0o6+WTJGdgvHs9OU4UQAygL7yq8lwFhQa2dycIOknQOSzyPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R5r9xHQHG+scXrr2lbtrROl2d6zj7h3adAv4PeUbXxA=;
 b=EK0zmy27VTjj5wU/9TCYZ89FU0lnlhEzKptsAfJtgbruaa/VHLWROd8SdNZe5wPbUgm+aKU7KR1x7aXf6QfneSbQix9DgPCFvFrlwBdED0k4cBp7eFn559eeHymC8MabUpCBqWJGp4JySQMTRnLii9pl6a9oHvoOfgU8pgb1fKkz6kSbh444dg9iJLyor2VOZepcHRZnEQSeYyNskbGXs8I0IbqQqvfkPtHWd/0ANgTxuY/UPJhxmd+e94DDaU08eLHmo2rPCKKQSxdViO/NUTpsJ6QhVHYgHKeGffZPasNAHyzFvBqFt8Am2l9ufefrIsYuksalVIVhBYHb7l3rGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 40.67.248.234) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R5r9xHQHG+scXrr2lbtrROl2d6zj7h3adAv4PeUbXxA=;
 b=UyTZ3ao5fXyaGax8FnJq72YkUOJ+jfUV3TvBMEEBDFpQ59EzfXHSGOqt2+pu2mPEPi9HObaBicA6R4BfbGM1Qd2H3qHq04wQX9hdYmNFGjiNMG+h5poaLx0qWAJlw3cApixdihqFJvYCPrd1npvnczn9fKtqMnG/rcd7lvggL34=
Received: from AS9PR07CA0041.eurprd07.prod.outlook.com (2603:10a6:20b:46b::28)
 by AM0PR08MB5460.eurprd08.prod.outlook.com (2603:10a6:208:187::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.12; Tue, 3 Sep
 2024 09:04:12 +0000
Received: from AMS0EPF0000019B.eurprd05.prod.outlook.com
 (2603:10a6:20b:46b:cafe::e7) by AS9PR07CA0041.outlook.office365.com
 (2603:10a6:20b:46b::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.13 via Frontend
 Transport; Tue, 3 Sep 2024 09:04:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.67.248.234)
 smtp.mailfrom=arm.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 40.67.248.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.67.248.234; helo=nebula.arm.com; pr=C
Received: from nebula.arm.com (40.67.248.234) by
 AMS0EPF0000019B.mail.protection.outlook.com (10.167.16.247) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Tue, 3 Sep 2024 09:04:12 +0000
Received: from AZ-NEU-EX03.Arm.com (10.251.24.31) by AZ-NEU-EX03.Arm.com
 (10.251.24.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 3 Sep
 2024 09:04:05 +0000
Received: from arm.com (10.1.28.157) by mail.arm.com (10.251.24.31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Tue, 3 Sep 2024 09:04:04 +0000
Date: Tue, 3 Sep 2024 10:04:03 +0100
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
Subject: Re: [PATCH v12 21/39] arm64/gcs: Ensure that new threads have a GCS
Message-ID: <ZtbRA6SUWjo-WTO2@arm.com>
References: <20240829-arm64-gcs-v12-21-42fec947436a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240829-arm64-gcs-v12-21-42fec947436a@kernel.org>
X-EOPAttributedMessage: 1
X-MS-TrafficTypeDiagnostic:
	AMS0EPF0000019B:EE_|AM0PR08MB5460:EE_|AM4PEPF00027A63:EE_|DB9PR08MB6378:EE_
X-MS-Office365-Filtering-Correlation-Id: c0d02d64-62d8-43d0-e7c5-08dccbf767b8
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?Sz8qv7zs7o6n0qixkEqGeIyau7O4NlbbTN+sbG91v3+nFVpbgoDhMckdSs79?=
 =?us-ascii?Q?+1qAGjnDGwd9P1KiCuwnXB9NThmQy16eVxA64IGKj19QFNciXYC+SAdW359A?=
 =?us-ascii?Q?81O/P+SUgcqURGW5V1TWjaCZEWvwZeAieBoB2VYG8P19/MhCEWR/CkGmPTRX?=
 =?us-ascii?Q?hxBX9uOecY3yZFzspKU1mibpCv4RdSOdRvH3+TuJ7CEM5vWFv0+UZX5oM1Mu?=
 =?us-ascii?Q?9BLiWurFQQchLA5HyD6PWdYIgActaqCE5lVbtZFTdcn4qVdavHE5u17qCmeR?=
 =?us-ascii?Q?BeyeuvbUjZpiR/Uw0G0b5EEKwkTHvonW2BXRhUsV9ozTUVIEtF5qmxNj+LhY?=
 =?us-ascii?Q?O9HJYDLg4yW1rWlYe/SGLpht1eiPq8AyydGhtzJhTz9xH34n4nH7MG1rU/cs?=
 =?us-ascii?Q?Ah3vLkUt+vKXrWTX+yJG9DGoibBJGfI+3/eu5yH0dNJbL/S6MBJlLi76TB8C?=
 =?us-ascii?Q?n4lkBSDvOJvzgURLCnsoTzF9iaiB+LmbJyby1WR3D/L6o1j40bY7oq50+7k3?=
 =?us-ascii?Q?Dap+Rwtk+dbs3d5lJSQ7uZFGJR95OrHiTXBFdKyyo0C+GsJxevjmx5UX6+o4?=
 =?us-ascii?Q?qpcud/mCtDCZwS6gFCFo6UXpLC0FsWN/zUHslcYHHmfNWQ4ke2KBeAT+gkN6?=
 =?us-ascii?Q?+Q02ZrOfcfEkLRs+WA8RB3OS/5890whhX3LsS8ZOai98vmIsm1reWZRkWgoz?=
 =?us-ascii?Q?V+IkreOU9kEK7sxYZ7P5uzEb5dXUn6nIhyQALR7ojaXKjku3s5LxORdm5/hZ?=
 =?us-ascii?Q?o/xeYtlon4vL/9ByLkNjgS290gzQGTnupyZOqlGXl/409xkT/RdydBLScWKl?=
 =?us-ascii?Q?QltOMTZU1KFQZqcEA+io16WlNwP9PCwgkysi1dWQzqCvp9/s5WHR9Xs5Ciq8?=
 =?us-ascii?Q?h8PeB98bsPNnPtMIcb54rdKat0J2jdWEDu3HljjAolisiFYIzXgiXFZIHyp2?=
 =?us-ascii?Q?07Gahim3WYlgj9a7cfnv3E6uxWTIaqNKISX3Ln5rDM4TbIH4kjXDqRPlsH7R?=
 =?us-ascii?Q?zbwgDI3KtX9CHtYJDKCFzPUcK2XdiqKbcdKa1in/fkLMkmu0YmZNaiJ5PY0B?=
 =?us-ascii?Q?bZZDiWRYjlEZgY1hnET0AJN4DV7SIWHSjr6O8Ty4A7oNXXjRH4hWQsB2pD5T?=
 =?us-ascii?Q?796Ira+XbZHozsw09BaHvwkkuq6e/UPqMBHqFa/EqeChu7JTiU2xAgO+rdAg?=
 =?us-ascii?Q?LESqxThbpeJuNrFXGUzemoozvYRu1ffHV9RJvWcDhGijqIS2S3OMSJHl6ark?=
 =?us-ascii?Q?X3s9K8W2JM7kum0pCVYyxF0sgThQr1aw/irAQwqRoATrgDfHDz00vtknDNGa?=
 =?us-ascii?Q?GqdLPLsZf5NbduMS874QU6OpNLtUVucaRol/V7kxiwvcJyiwdFDsUuFkHLz2?=
 =?us-ascii?Q?/7HAI0FJsGeBXOGRL8ZwUfqaghHw9NNgNRlwietq589CkeCRpeG6cJptAAd4?=
 =?us-ascii?Q?ZLBCnX1WmlkS0NBzarSA7fRsEddgAc2D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:40.67.248.234;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:nebula.arm.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5460
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:20b:46b::28];domain=AS9PR07CA0041.eurprd07.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM4PEPF00027A63.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	f68233a2-0c1a-4af8-2748-08dccbf76132
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|35042699022|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BsgugLrJMyp74JHiE8b/E+1v0R94+cJ+QAEhwH9OAWyE0TG1m6twg28UwtWv?=
 =?us-ascii?Q?bYRQVW3mL8azGJwqpoHM3J2U2aXxQu6Q5jPHpoYq05BKGZJl2ZV0yp9au+bF?=
 =?us-ascii?Q?gE+BCrvjY+5lTOQ7bFqru4erwDcL1CnqKq1lkgkaWQ0lKqmXtNEIM8lFJaDJ?=
 =?us-ascii?Q?XEeZhIA+lWV01TsIYPcfy7VhGypH5Mh0MtQdZkPY6r3XHaJI3hL0l5u+cFtH?=
 =?us-ascii?Q?ca0EOtxWf5mqfp+4oOfNgI6crtuW+BHgxOp4a7GEeMXQ+eIrgpG072RQiZtI?=
 =?us-ascii?Q?+uFzSae1t54X4dYz88ro3npeShtVsrzn4jW2IhTmQ/baDKHNDqej4GbxmCl2?=
 =?us-ascii?Q?VjC06Wpl6c+radQKzxB3a7GeyOhQUNhHy8S2OwX9aAjdG0qPEflLhB6hZTJG?=
 =?us-ascii?Q?pQJ3f9OYE2OHZEC1kKeQ7gK/1+3IWyy0xIIkGhFsS786x2OzYQ4GnCSbQ4Ft?=
 =?us-ascii?Q?bMOzX2Qst+dU4DMk6A8dlJ+OTF2higK3ns+giZYMtJnUhKe1wUM3pUqOcfKN?=
 =?us-ascii?Q?iENlQ++d7aFLF1HSGFHDwucFESy1HormXpNRVSveJM/xiZRlesM9b4WEBWn0?=
 =?us-ascii?Q?Hz4c9r6VrQXuQfqrANaP1KAqR5VRwWwkCjtYtfgXGgFAYoJSm9GFQlK3v5T+?=
 =?us-ascii?Q?NVJzf2LD3PthdPCvYkbE/blsaYmqZizZZ3/msjNeoYd1Qc95EWdFDVyg1gKs?=
 =?us-ascii?Q?9rHyFIs6y2cJBj6/hf/0uGoEEvhQleMkQPS5Wk799ZUY+/GEXNMVglchJxqe?=
 =?us-ascii?Q?LA/s8+qYXAnl5ZrTlWBGbp+IF79X29iAnWw2QN5SZUe0g5PqWnRR2kN+Hfuk?=
 =?us-ascii?Q?scnGONxRAjMZa5sHcPpeEifC4h+qlDRQiS+a8DRxVV67ScSgX0gHVtNZQ48p?=
 =?us-ascii?Q?rEYxp041GJ9LFtQLebaugyaSiz9NuabwIdOxdj6MhBA4aWFblmkPzJI1dlHU?=
 =?us-ascii?Q?q4iSH359sRBsbdULDKXLiYr+EqZMxL+pOEGLNGFKQvLFtZUyUiePnQQSQvkT?=
 =?us-ascii?Q?sLoySjeaN31Kc7ifzdU6ecExReepXC7OBy6b9q9uMVSiybQ+p0i6Gh5crLsa?=
 =?us-ascii?Q?fQ1kFR9e50Dy8kkKElp0bEo9sla90y+urmFi7TScJMGErNgc4h7C+I4BeSwh?=
 =?us-ascii?Q?FoLLR+PW0Kt5DfUiyj4FXJ8iAtj6Z65fGkI0Qfu30mn9HcrrwUwdp5Zd3qFr?=
 =?us-ascii?Q?VRQnijUttWjIjrsG1oPJBSCRpcgXyoBQfdzqb4ZRrKDbiT3GdEU2zohg6cob?=
 =?us-ascii?Q?jaH9PbpLgE6eXlBndxdchnyDh1MlaEY9WHniyNH2jFOThuuKWh0W23vN5eFB?=
 =?us-ascii?Q?IZovRmPiPBM5MW3ePU6sEJb79bnpZAPUmpKlXa6U++MbXntkXHoP7TjN6CwM?=
 =?us-ascii?Q?AKtPrZSoDLQFFNEQjMAHObdf+tFsxerZ8gzMiGR8xe74ntiUnQsxJPSJqZ+A?=
 =?us-ascii?Q?Ja4QdVzrBcd+ZMeOuwGMCAsFgLumLGYl?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(35042699022)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 09:04:23.4643
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0d02d64-62d8-43d0-e7c5-08dccbf767b8
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A63.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6378

On Thu, Aug 29, 2024 at 12:27:37AM +0100, Mark Brown wrote:
> When a new thread is created by a thread with GCS enabled the GCS needs
> to be specified along with the regular stack.
> 
> Unfortunately plain clone() is not extensible and existing clone3()
> users will not specify a stack so all existing code would be broken if
> we mandated specifying the stack explicitly.  For compatibility with
> these cases and also x86 (which did not initially implement clone3()
> support for shadow stacks) if no GCS is specified we will allocate one
> so when a thread is created which has GCS enabled allocate one for it.
> We follow the extensively discussed x86 implementation and allocate
> min(RLIMIT_STACK, 2G).  Since the GCS only stores the call stack and not
> any variables this should be more than sufficient for most applications.
> 
> GCSs allocated via this mechanism will be freed when the thread exits.
> 
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> Reviewed-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
> Signed-off-by: Mark Brown <broonie@kernel.org>

Acked-by: Yury Khrustalev <yury.khrustalev@arm.com>


