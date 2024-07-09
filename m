Return-Path: <linux-fsdevel+bounces-23363-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 823B892B231
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 10:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F2801F217D2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 08:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D49A9152E15;
	Tue,  9 Jul 2024 08:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="NLMuXB1o";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="NLMuXB1o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2064.outbound.protection.outlook.com [40.107.104.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67363152796
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Jul 2024 08:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.64
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720513986; cv=fail; b=gija+vYWXMB4iq84kp4IA59r0OOvH9RGROIkzWeZ05DuUZHZHZ3eriXLawf3mZhUkaPfLTB2uO62drPRFNyMn2MOu0TxTCFJkfOrhqfM3CZxJ6k13BHRuvF7qTfNuDwgujAVzN7YvwUGCFVaZyDpeg5kpnfTGZUeUuv2V+GjZIU=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720513986; c=relaxed/simple;
	bh=CNUFDFKp6nZweZgtR76wvckC64UE3kUSpXanFYCV+gc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=m1FrhfR60kD772zGH5SYu1FbajW6RBjg+DFkBm9NEJPrs1NRwqox68Bgy03npXeEry0jmY/B5vKmYWLM4p2ACkA50U20idu2k31B6988xS/7TNABGwVmM2JhLWBRCgaueDLGK6xIIOrUQ/5k5sLmAaKz5+quftogvqq/VbmUPoY=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=NLMuXB1o; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=NLMuXB1o; arc=fail smtp.client-ip=40.107.104.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=JJIZoI6rNtvppZFnsTESsxRwnkFcvayj/aYa6fBCWN7shZ4xLBek2vX+hZjYrmhehJ6SfU4TJruaSWZjrTojnKgr9H11sSPnto1RevpH+u7wEE1r6idzeWRbDL1l37Qg8mVXbb7k9qCsDW0bqQVRnfDuEdMIxtFcFEvIygVcTE99retll0QWS8KshGWCUH10KnNG3cyKfDd0U1ntmjgSru2XqwveVH5Q+N1KP8L3LQMDWjhLuXREPV5onAi23zPXuQOvpYCJpSN2ToYmpJ4uBhEa6R/rE7yQt8GRXj7pePFCI9ajKt2WR7gznl3a87aA2L+ZSz9NqxjTjsUR1b4P/Q==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fa+/cBsfraTPLWRjUaTedFIB+misiBywHLb6+XVNAvg=;
 b=C4Mj6A9JkotLTbHlO50ECMQF41FQ/SQvn4HbNqgD06wyi4ddkQB56sPMu71nJtcdtxTbdeMYeVLL3w8RgT4Kdx/FuqgMsxRmRasDtdErNnBNu/g14+VSw0TrB63GzOuEDWO/XuVcZ9JpM51rx9nLPHMuw83IAxTInloUwmrAI72PF4a99zwz5ZmB7xcvafpHyXxfJqiUopk0f344nVRuU42m5JL1G4QpRb3yWlvT6CD3x0IPR4xTWi4p5pnV8HIOrrWw/C2A7rxn2isEQwm/09dkziVVf4FG26KTSmU13qqTRxarh2FPB6fKRY9ANdhLEf5/VvrhPSalQwILQWXq4Q==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fa+/cBsfraTPLWRjUaTedFIB+misiBywHLb6+XVNAvg=;
 b=NLMuXB1oez5YyZVVgHKZVhT5FI3KaMF1SfGAmcPT+CwoAaw/Na85P2IFCTvcudr1mRG0gtAc1BaVBCfmOHUytNkaCfhHYR1XNHA3INGDLDb12FGcnqr9PLI/lJ2Dgl6b7wtSD9ZKDrn4JevkXWNbtIn3KnL3RQOGLixeA92m+Qc=
Received: from DUZPR01CA0049.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:469::9) by VE1PR08MB5615.eurprd08.prod.outlook.com
 (2603:10a6:800:1b3::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.19; Tue, 9 Jul
 2024 08:32:56 +0000
Received: from DB1PEPF0003922D.eurprd03.prod.outlook.com
 (2603:10a6:10:469:cafe::eb) by DUZPR01CA0049.outlook.office365.com
 (2603:10a6:10:469::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36 via Frontend
 Transport; Tue, 9 Jul 2024 08:32:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB1PEPF0003922D.mail.protection.outlook.com (10.167.8.100) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7741.18
 via Frontend Transport; Tue, 9 Jul 2024 08:32:54 +0000
Received: ("Tessian outbound 7c3e8814239e:v359"); Tue, 09 Jul 2024 08:32:53 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: f64dcc8c5b7c941b
X-CR-MTA-TID: 64aa7808
Received: from 34990bff5547.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 635D81E7-D5B7-4838-9F51-AE528AEE27A6.1;
	Tue, 09 Jul 2024 08:32:42 +0000
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 34990bff5547.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 09 Jul 2024 08:32:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lj66p5Bbg3qbGUNS4u7VmfhPrbvMf7D7KOXbohf10gDiP4fOm9P37SpcvH4semFb4ygHD5ElM5P84t6RmOkjdyA33jHnUIRnuMaXON9RzbOPVsLh+6edZx6m4HzJJQMG9JljZR0nYc3z4m2QRDH4PoFwEIwZUJAvaa3dZubjuQzm83mJDvQeZLCaOxgrWhjAHjU0hNo2KQODsUnGEeqMeeJbiYlEqtOYPf/1GTMKsKakvnwMV0Uz2oie6AJz2GGjRfmXdZDeP/Yd5V83mQHEZcHLquPFeMXEO0a1vrl36Pg58nGTd/QouojdPeY7RmVyzMbKRGcK7ecBz5pyYIZQ5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fa+/cBsfraTPLWRjUaTedFIB+misiBywHLb6+XVNAvg=;
 b=bxVubXjY7fTFxPhxKCCpV7/dIM9n0A/tXmEvmOV+JjTjUrSivam+bK4CF8lJtAu2LZF6n3u8Fr2u3G1G1gx3iTsbrI5SAa5l+xLfSDgHGlQp2jQ2pwDdkecM0nA6OeoXZm0CyX4A5puKQoUNFpFxb2XswCWLyocURnfuS3KPXHtT/FmmgevB/I8i2MjJIhdFgb2gwfX0hRftrYCf+XZGVffpjNrK0wla8xKee5LwMkmOCJ7GNyTEXbf1sg0Dj6kT6OmQz3VOg9xuhRxR4D/HBRz0/lFJvFqgCueEVX9JYTVaZbaPTRmZ7g+wXBAWmXLrgHYOCKAFg1K7S+j6bRBsuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fa+/cBsfraTPLWRjUaTedFIB+misiBywHLb6+XVNAvg=;
 b=NLMuXB1oez5YyZVVgHKZVhT5FI3KaMF1SfGAmcPT+CwoAaw/Na85P2IFCTvcudr1mRG0gtAc1BaVBCfmOHUytNkaCfhHYR1XNHA3INGDLDb12FGcnqr9PLI/lJ2Dgl6b7wtSD9ZKDrn4JevkXWNbtIn3KnL3RQOGLixeA92m+Qc=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com (2603:10a6:10:2cc::19)
 by AS8PR08MB10361.eurprd08.prod.outlook.com (2603:10a6:20b:56d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Tue, 9 Jul
 2024 08:32:35 +0000
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::7d7e:3788:b094:b809]) by DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::7d7e:3788:b094:b809%6]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 08:32:35 +0000
Date: Tue, 9 Jul 2024 09:32:21 +0100
From: Szabolcs Nagy <szabolcs.nagy@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Florian Weimer <fweimer@redhat.com>, Joey Gouly <joey.gouly@arm.com>,
	dave.hansen@linux.intel.com, linux-arm-kernel@lists.infradead.org,
	akpm@linux-foundation.org, aneesh.kumar@kernel.org,
	aneesh.kumar@linux.ibm.com, bp@alien8.de, broonie@kernel.org,
	christophe.leroy@csgroup.eu, hpa@zytor.com,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org, maz@kernel.org, mingo@redhat.com,
	mpe@ellerman.id.au, naveen.n.rao@linux.ibm.com, npiggin@gmail.com,
	oliver.upton@linux.dev, shuah@kernel.org, tglx@linutronix.de,
	will@kernel.org, x86@kernel.org, kvmarm@lists.linux.dev
Subject: Re: [PATCH v4 17/29] arm64: implement PKEYS support
Message-ID: <Zoz1lbjrp+y3HXff@arm.com>
References: <20240503130147.1154804-1-joey.gouly@arm.com>
 <20240503130147.1154804-18-joey.gouly@arm.com>
 <ZlnlQ/avUAuSum5R@arm.com>
 <20240531152138.GA1805682@e124191.cambridge.arm.com>
 <Zln6ckvyktar8r0n@arm.com>
 <87a5jj4rhw.fsf@oldenburg.str.redhat.com>
 <ZnBNd51hVlaPTvn8@arm.com>
 <ZownjvHbPI1anfpM@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZownjvHbPI1anfpM@arm.com>
X-ClientProxiedBy: LO4P265CA0078.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bd::7) To DB9PR08MB7179.eurprd08.prod.outlook.com
 (2603:10a6:10:2cc::19)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	DB9PR08MB7179:EE_|AS8PR08MB10361:EE_|DB1PEPF0003922D:EE_|VE1PR08MB5615:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bf3bf57-2934-41c7-212b-08dc9ff1ba71
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?S0wrRXVOYldzS1lSZDU0QjZHTzZKTlM5RzkwSkF4cHpOVVMwTzVMN25qajln?=
 =?utf-8?B?bm9oazNnNlMreXBzWFQ0UmFUUmJHb2RUa2FtTUVWR0g4dnZNTWI5a2tRbE5p?=
 =?utf-8?B?blUyMk4xd1k5OTVNRSt2Z2VMRnFIbzBadTBjelNySW83NzkzSllrTjFIMFhn?=
 =?utf-8?B?UUszVnRUMmZ3WGVDMnJ3ZDkzMzN0M0pzNGcyZTZWd0I5cmxVTWZVYXZrdGhj?=
 =?utf-8?B?K3ZPTWxaL09kMTJhdE5DQ0g0ZUtnYjhHSEhoOGlFUFZYc2VuR21yRWw3Smcz?=
 =?utf-8?B?Z2N3Q3BKVlJVQ2Z6SkJxTUw1dkhFaG5BeEVuMyt4SmNYWnRUNlV3MGQ5K1kv?=
 =?utf-8?B?L2RTb2VYNFIyU09LRDBKbUU3dzBudG9YalM1dnBtMExYNmhTcDhWOEFHQzVF?=
 =?utf-8?B?ODkvRkNBdkNTMndiZnJTZnlmK2E0WWp3VEIySTJTQkVQM0htNW8wbVkvb2ZO?=
 =?utf-8?B?ZG1aeVBkSTFtL2pWT2RzS2dsSjc3amxaa2dUY0hUMkkwRzhyaFBhYXFrZXFB?=
 =?utf-8?B?L2dRRzcrMEcwUkdqNFljNHBUbXZxbGdXNVppYXNTaUlaWDBkVXJNQ0Z2akl6?=
 =?utf-8?B?azZvcjFKeTZRL1hsRDYrMVhlKytkVzFqdVlCbHBXYkVsUTFOQXBZc1dZSVlx?=
 =?utf-8?B?aDRGMGV4WlJKbFEzRzZjVVhHS3BzWHJsZ0UwS2s4T01YdWUxTTJEbWVKSTUw?=
 =?utf-8?B?T0JMVTE2eWg3Q0R0Ylh6TmNKV21jeE5JdzZueGZ3aTlYMXhnditQenFSRUxp?=
 =?utf-8?B?SFZwb0hZRDFqTDIzSHFpTUI0YncyUGQ2aWlSeGRJaVlHQWd6bGtmekRocHhq?=
 =?utf-8?B?SnVmV095aXI2K2dVaVhrRUhFeEl2ajNjU1RwTTZ4Vk1oSmpaV05LcFhTTW9p?=
 =?utf-8?B?R2V6TmJqZWFSY2ExWTlTVWhEM3ZMQ2k3d3FWRTJHRDRvMTluc2pKRk1xUlV4?=
 =?utf-8?B?eUxPZkZDc2drQ3JmeXZhTHNwWDlrZnVOb3JNUTYxV1pXY0I4ZTU1dDE2eUVh?=
 =?utf-8?B?YWhrZ2RwTzJEOFJiUEtCRWFKSlhlWFA3R2xHSW5xQmErelpsbzhIanA2N2lP?=
 =?utf-8?B?dU8vVkc1bVhmRzZzeWVacG96bEpvenF6WDBuSmRmWmlVelVKOUx1cmw4dFIv?=
 =?utf-8?B?Qk1XRFhmMG9CcUNhd1V2T3FzTW80dTF0Wm4xdWcvRnlZNC8rb3lFNS9KNlpN?=
 =?utf-8?B?RmpDMXJXVWZaUHdNd3FSeGpzNXVHYTYrdmp3dXFxRlJSQzVDazYzTG53S2lZ?=
 =?utf-8?B?d2xzTmpGQm53U3lISFh0V3BCSmFCanZFdksvQ0IzV2h3N2NhWGlJWTlOdlRJ?=
 =?utf-8?B?ejJHbjBkRkZkTCtRekJnSXM5MFQwMm0zQm4rV3AwaFk1dXhFSDZacTdsTmM2?=
 =?utf-8?B?TXhPaUlRZFJHVTFMQWtoZEtEcnk4bHZseHFYU1NvVWwwMXFYTHdTT3QwTjYx?=
 =?utf-8?B?eS9LNHBqTmVuSVcyMnpZUERQTHJDVVI4QzgwVkZNWWIxMGZEd08renVUdmlG?=
 =?utf-8?B?YjlpY1cwSmVNeFF5ZC9NVDBuYTU5WU9VcGtjdC9ncUtkcVpBSkdxcUtqVVdp?=
 =?utf-8?B?ZjRvMXByeXdNc2FPcHJETWlEZXpsOWFJV1pCM204bEl3aE13NkJnWDBBbzdP?=
 =?utf-8?B?QVM3eGdHZWRSQWJvMHQ4NDhTK2lSN1F2ZjV4MHFVZ0N6LzZRUjIwVDdWSjRs?=
 =?utf-8?B?QnVGajVVZGRFS2lzbkNmUzR3cmx3UmRRYmFBdFZ1UStMMERZelVLSU9Zd1Qv?=
 =?utf-8?B?TURSTmFFY3oyNElmOUNwMTJvME9SVnd1UnExdnNDMkt4RFBBYmtWOXQ5ZDRk?=
 =?utf-8?B?VCtpTFZWWXU1N0RZd2Y0dz09?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB7179.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB10361
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF0003922D.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	b0ede9e4-ae99-4548-f34b-08dc9ff1aefa
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZFFtNWVGK2tUUExTR0pLcDRmTGRxby9RcC9nMWlFT2VwMGlITFlpeTk1b1Q2?=
 =?utf-8?B?K1o4Y29aQ1pVdGdEUUJlcThrRThldjM1ajRhYUZPeXUwOWJuOHU1NlRyQ1V6?=
 =?utf-8?B?SVpXZXhpU1JxWVJoSFROcVRiN1l2dU5GeXJra2UyaGR1c0xHdzZCNVRTOTdr?=
 =?utf-8?B?QUd1VVlaVkVCU1hCRVRXeVNRbDBnVjJTNkRITldhZmVNcVJkMVpSaHRNUjU1?=
 =?utf-8?B?d283TitDVVBDUktqS1M0MEh6aEl4WnJBOHpvc3M0QnMrVDZtNWY5dGdZTkNB?=
 =?utf-8?B?MVQzbWxUYmJEa0syR0Y4Y2FIZDNMMVpLK3B2anhqb3Vwc0QrWGo1VTZaSTlS?=
 =?utf-8?B?NndjTDNXTjJrdlpjV3hqSzhFUWRESUhTSkhxM1czcjZvRzhFNENtbUtXT2F3?=
 =?utf-8?B?anhzRVJoV0xqV2NBS05NeFZBMnRlN1ZzQmdGaGFGZTVFZHdVTitTWGRIcUtI?=
 =?utf-8?B?eXRmNmMwbzNabDlIUjg0Y21uQ0ZheDMrUnNVM1VEVWVUNUVFb3JJQ05ITUIw?=
 =?utf-8?B?L1hKVFRHT2NPcmhDYUNNSGc4bnlVRk5rUmZpMjZRNmZvT09FWldSdUp1dEVN?=
 =?utf-8?B?bjhEWmJhSzFJU3VWRXVhQUpVL0dWdnFkQlJhaVRCN2xheW5PbE1LUWhTRTBF?=
 =?utf-8?B?aUdXQmI0aWJDWG9MUEdXY2V1a3hMUjl0d21jRFFzQU5YZTB0bFVlbnBYeUpp?=
 =?utf-8?B?c1hBR0pBU3cwN1lvYlB3TzltRnUzZDV0UGErN25vdHhFSitHeUNMWEV6UXow?=
 =?utf-8?B?YWQ5RVJ1N01VeFYraHY5Z3oxcWRMMlBoRkNOTTFmVE4zdjd0bDdYVEx5SUhv?=
 =?utf-8?B?K1NzQnpINXhjSlBKTmZnZXlySXlVdktLblgwZHdDUXJVZ2lrUG1GUXB1eFBS?=
 =?utf-8?B?MXpRdUg4UUFEZ3FGYjZmT0FRWmJRY1czc011Y2tVWVdxMm94QTYza0RHTExI?=
 =?utf-8?B?YVc2Wmc0TlhzR2lDb0p5ak9pQnFweVJUakVwcTZwUFJkcUpSODNYTDZUWk42?=
 =?utf-8?B?SWVWRWoyWEdKbjlHMmI1azFOcHNDTUtGL20xVDR0dVlRaVkyNlNsaHBDUkYw?=
 =?utf-8?B?OE9TOFJSalNHVE9uZ3BlQmVHamNybFRWbEtDOUpKYUtBdnV1WmorNG1rajk1?=
 =?utf-8?B?aVVsTkozTFJqdW1tVWs3UmxTek9CNjVtblpsVnJ0dUU4OUpOM1BGK0ZFNFFU?=
 =?utf-8?B?dHRYTzVLZGRDL0hKb3FkNit3Y1FBQ0hwTXJQZndWV1dMNWgxMm90VDgzb3V5?=
 =?utf-8?B?ajRnTTdISWJMZnhCVkxOZGZ6SHRibm9xa0dxZ2pWck9UT2VTS29GU29pcUdS?=
 =?utf-8?B?aW1jSUN1Z2lta2YzRkNUOW44andaWjlNUnZSMjJVODlOTGo3c2Z2YnJ5WGZ2?=
 =?utf-8?B?YlpEbEpzSkYwTVRkTGRNdllCZkRFOFAzRnVhL1NDY2JDVFJaR1ZxTFllN1Jj?=
 =?utf-8?B?Qkt0UzRYVVZOUFZzVEthTmNyMWJXc09ybERvYWp2UmFrTUJEWUtjaXd3NHZk?=
 =?utf-8?B?SU5MS3hyWXE0WnFoamdxVzhQeDc2MVJ3TDVnV004d0NEaDRFd0U5RHU1SlFx?=
 =?utf-8?B?blpVZGJsd0MxUllSbHM3KzdOeUVUZXVGd3N2UUo3bE1YMlN4UUIzc1Q4Szc0?=
 =?utf-8?B?dGkzTmw2U1doVDBEZzNsSW9pcDZBZ2FCc3hueUJFSjEyNnRjMjluU3lQNDY1?=
 =?utf-8?B?a1MxZjJ1Sk5rSGE0S1dDeUZyQXpqaytVU2RDeHl6OWxGYlNqVGlFamUrblB2?=
 =?utf-8?B?TFcxVklVcjU5cUNuRVFpQThkbDY1U091MG1uQ3E4d0NrVE5wQ3hiSGE1a205?=
 =?utf-8?B?YTVJQ2g2cmN3QmFhMkYvQkdwRVgzTDZVbEdPemVnQk1XSFgwWUhrMWlCY3JH?=
 =?utf-8?B?V3hXZGxOeEFDNWV3aVBRamFHWXdEaEZ1aCthOGdBQkovTmp0T3owUDNvMmc0?=
 =?utf-8?Q?eOpjBBU0zTvs/xVGjLH6TEHMFxWNwKx/?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230040)(35042699022)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 08:32:54.2741
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bf3bf57-2934-41c7-212b-08dc9ff1ba71
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF0003922D.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5615

The 07/08/2024 18:53, Catalin Marinas wrote:
> Hi Szabolcs,
> 
> On Mon, Jun 17, 2024 at 03:51:35PM +0100, Szabolcs Nagy wrote:
> > The 06/17/2024 15:40, Florian Weimer wrote:
> > > >> A user can still set it by interacting with the register directly, but I guess
> > > >> we want something for the glibc interface..
> > > >> 
> > > >> Dave, any thoughts here?
> > > >
> > > > adding Florian too, since i found an old thread of his that tried
> > > > to add separate PKEY_DISABLE_READ and PKEY_DISABLE_EXECUTE, but
> > > > it did not seem to end up upstream. (this makes more sense to me
> > > > as libc api than the weird disable access semantics)
> > > 
> > > I still think it makes sense to have a full complenent of PKEY_* flags
> > > complementing the PROT_* flags, in a somewhat abstract fashion for
> > > pkey_alloc only.  The internal protection mask register encoding will
> > > differ from architecture to architecture, but the abstract glibc
> > > functions pkey_set and pkey_get could use them (if we are a bit
> > > careful).
> > 
> > to me it makes sense to have abstract
> > 
> > PKEY_DISABLE_READ
> > PKEY_DISABLE_WRITE
> > PKEY_DISABLE_EXECUTE
> > PKEY_DISABLE_ACCESS
> > 
> > where access is handled like
> > 
> > if (flags&PKEY_DISABLE_ACCESS)
> > 	flags |= PKEY_DISABLE_READ|PKEY_DISABLE_WRITE;
> > disable_read = flags&PKEY_DISABLE_READ;
> > disable_write = flags&PKEY_DISABLE_WRITE;
> > disable_exec = flags&PKEY_DISABLE_EXECUTE;
> > 
> > if there are unsupported combinations like
> > disable_read&&!disable_write then those are rejected
> > by pkey_alloc and pkey_set.
> > 
> > this allows portable use of pkey apis.
> > (the flags could be target specific, but don't have to be)
> 
> On powerpc, PKEY_DISABLE_ACCESS also disables execution. AFAICT, the
> kernel doesn't define a PKEY_DISABLE_READ, only PKEY_DISABLE_ACCESS so
> for powerpc there's no way to to set an execute-only permission via this
> interface. I wouldn't like to diverge from powerpc.

the exec permission should be documented in the man.
and i think it should be consistent across targets
to allow portable use.

now ppc and x86 are inconsistent, i think it's not
ideal, but ok to say that targets without disable-exec
support do whatever x86 does with PKEY_DISABLE_ACCESS
otherwise it means whatever ppc does.

> 
> However, does it matter much? That's only for the initial setup, the
> user can then change the permissions directly via the sysreg. So maybe
> we don't need all those combinations upfront. A PKEY_DISABLE_EXECUTE
> together with the full PKEY_DISABLE_ACCESS would probably suffice.

this is ok.

a bit awkward in userspace when the register is directly
set to e.g write-only and pkey_get has to return something,
but we can handle settings outside of valid PKEY_* macros
as unspec, users who want that would use their own register
set/get code.

i would have designed the permission to use either existing
PROT_* flags or say that it is architectural and written to
the register directly and let the libc wrapper deal with
portable api, i guess it's too late now.

(the signal handling behaviour should have a control and it
is possible to fix e.g. via pkey_alloc flags, but that may
not be the best solution and this can be done later.)

> 
> Give that on x86 the PKEY_ACCESS_MASK will have to stay as
> PKEY_DISABLE_ACCESS|PKEY_DISABLE_WRITE, we'll probably do the same as
> powerpc and define an arm64 specific PKEY_DISABLE_EXECUTE with the
> corresponding PKEY_ACCESS_MASK including it. We can generalise the masks
> with some ARCH_HAS_PKEY_DISABLE_EXECUTE but it's probably more hassle
> than just defining the arm64 PKEY_DISABLE_EXECUTE.
> 
> I assume you'd like PKEY_DISABLE_EXECUTE to be part of this series,
> otherwise changing PKEY_ACCESS_MASK later will cause potential ABI
> issues.

yes i think we should figure this out in the initial support.

