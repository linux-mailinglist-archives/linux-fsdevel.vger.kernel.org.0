Return-Path: <linux-fsdevel+bounces-20640-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AF008D6501
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 16:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 681F11C244D2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 14:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 324E65C8FC;
	Fri, 31 May 2024 14:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="IiFRUDpc";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="IiFRUDpc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2077.outbound.protection.outlook.com [40.107.7.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A191CF9B
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 May 2024 14:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.77
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717167489; cv=fail; b=QKyHYDIcxDIJhqKOgytP9UbWDUaADz9SlOLZRqTO454/xtBaLGYGLJ5OZCzLoMgR6mqsxE4y0JPyd4bbuYYVwTGY1nY11hEhNr6axJOemAyPT8Exbgf/bdOsQ3u1NDxbnzjJKT+RYPlNVeIp+9t4O7mdFhqyRd38EqkeWOAxkWA=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717167489; c=relaxed/simple;
	bh=IQjs+9Vxu2E2sGL9dPcRcY2l7VdAYxrnrbb7oEgGGr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Gsxb7Ht619tQK8gVre3svLUd0VSkR1iMPc/+swJHtExBUu8HYd27I//cZnO/zpyR5l3YKePihVa9mco7RlPF9bISJhGmo60rFQX5mXAq8m/D+brZrKJjrtqciN6I+dopv2W3X3OMGi1ycfwRg1LlvYXKNC6KR3CbfqVDObc7/+4=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=IiFRUDpc; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=IiFRUDpc; arc=fail smtp.client-ip=40.107.7.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=Q6wvRlZig1+noVyWsmRkj3t2nbgk7qBqlixT1XytBankO03TccuHPYsmlFr2EoBg0w5jJRiYmrZciDzqaoNhiuy+/HpwaSkfpgMpeBgrXHivJ4csm2fpmDTOxaKnDcOcAI6ZjvXOF8FPzZNGT2RFL4oJ/TF8TuhhgPw21QWNNTyJwEuk4MPQMhmGNpN404gnreYpBe5tmLFAts8j7BuFgvbZkcz8rX4Q8hkOtGt/ZbjsZSbOmf8vOwf8ahXPl8PwPbFYDmqs8fdTbJ4l5vxsEWxQTi2C6z6XDmPSDqykXCzBTClZ27HbwuYDfHUXZAS13FmFljd7mPTpPxUr/DXKQw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6fyDs3nrP7CF6zSQzwHD0RccZ+CrYXNXayMa/mBSk0g=;
 b=JCIuuD/NZceAOf5K7zathimnBSUl8qmg3Vpv+HJqtHi67r2ATSKTEhHv2oyX/BqlijeBuCnFC9P2crCr7l0fafcPsc0cc/ufsjrP7iRVH0MV3vyqcY6S6KRFKFJmZl5qp55Hp7xAR5mRmV/7i1i3+TnNFbBCiM6vto1hBXHqoUvGzd/6ZtuD5KfWmrttUkJYSCkJqnSFCIsgFaVkxYyX1+vn8TGXo4FAob1VcThfEZcELzWaEBSia2rZx7CM7UWrFpxgiCaM8E5D6T7qn8zrvopOdiExvIyiT2EwdYr0cl1ZZNLVOxRj7U0VYJaYBnGlqbeAGGfYoYN6Pm5lQ30SKA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6fyDs3nrP7CF6zSQzwHD0RccZ+CrYXNXayMa/mBSk0g=;
 b=IiFRUDpcAVoQiNqUAO6+YUVP28VgWDAgnBJk/bjpu7IrR41eM5mlIRVIDLFw4OSVdW7r1hZIcTeYKkcEvhubQYWV3S79pivfEMz9ecfqzP+igu06pGpQQ+t+tXCoBtDiMO4oYxZ6sZecUBrffbsvkHsvZwqrvHtpd6PtwZbRhQ4=
Received: from AM5PR1001CA0030.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:206:2::43)
 by GV1PR08MB8451.eurprd08.prod.outlook.com (2603:10a6:150:83::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Fri, 31 May
 2024 14:57:38 +0000
Received: from AM3PEPF00009BA2.eurprd04.prod.outlook.com
 (2603:10a6:206:2:cafe::e9) by AM5PR1001CA0030.outlook.office365.com
 (2603:10a6:206:2::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22 via Frontend
 Transport; Fri, 31 May 2024 14:57:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM3PEPF00009BA2.mail.protection.outlook.com (10.167.16.27) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7633.15
 via Frontend Transport; Fri, 31 May 2024 14:57:37 +0000
Received: ("Tessian outbound c5e515ac9ee1:v327"); Fri, 31 May 2024 14:57:37 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 49ef7dee730dc2c4
X-CR-MTA-TID: 64aa7808
Received: from fc581970f3d6.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 1E6A01C6-4485-48B4-8D7B-C3E38CBB81D0.1;
	Fri, 31 May 2024 14:57:25 +0000
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id fc581970f3d6.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 31 May 2024 14:57:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T0zbFUfBg9hBCu5I7UuAQOt2hZgHE4XAaWcejDMciIRajACWh7VtW5IecIZqlKq0GxUkk9mN2Ll1YeGJZzcuYMxSZsBPuv5VdeXX2YVTcAnkrpWRasOApOeXG0t9mRYQnY8p9pa6TVgM1Y7+aud9GissT89mPEn61yAteACBFV03oMyPsHX1ZqypRdf99gm/xLhedX8ysDO/pdDU0/y/wpaiAp+vC8drYlWsjJ76yvbafwcYBDuV7fFwJFaMLbemu1GhZcN6z2Wx33pBxbYHiA5v5upOSGeXoYhJBq82shjGu8NlVHsuS2gvrIrxkw2XIhMQ5n0VpJ1tWIQnAW5h6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6fyDs3nrP7CF6zSQzwHD0RccZ+CrYXNXayMa/mBSk0g=;
 b=LwwPKJSPjI1C7cvCPSzgMNnVsT6Ee00ZCwhhjhxi3758/B90BaZYzPt41tfHYBhlmfirLF63LgNASUiL495LiGF2sXy+qLZWmrxN83UieX3EQkm888eUWoylwpLTcpsbZTGDu+/1CPKQlSZWzlK5Q8VEblHjIK6EYW5ErY911hAhH/x1U6KwLPNwaT5VU6hW5CRdEyI97o9KL0jZMO0HoD7lyCBSCrgjgSOYwPGv5R02tM5uJoEj5AZ0OF4dHA7IgVbSmNmo6vg7NU5LbpUbtdZvWrpQBHy71T9ggHZ34cXtz6VPdjZx4CkMVA1e1edq7d1PoFWKm7Caz6JG1qt8pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6fyDs3nrP7CF6zSQzwHD0RccZ+CrYXNXayMa/mBSk0g=;
 b=IiFRUDpcAVoQiNqUAO6+YUVP28VgWDAgnBJk/bjpu7IrR41eM5mlIRVIDLFw4OSVdW7r1hZIcTeYKkcEvhubQYWV3S79pivfEMz9ecfqzP+igu06pGpQQ+t+tXCoBtDiMO4oYxZ6sZecUBrffbsvkHsvZwqrvHtpd6PtwZbRhQ4=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com (2603:10a6:10:2cc::19)
 by AS8PR08MB9147.eurprd08.prod.outlook.com (2603:10a6:20b:57e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Fri, 31 May
 2024 14:57:22 +0000
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::7d7e:3788:b094:b809]) by DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::7d7e:3788:b094:b809%5]) with mapi id 15.20.7587.035; Fri, 31 May 2024
 14:57:22 +0000
Date: Fri, 31 May 2024 15:57:07 +0100
From: Szabolcs Nagy <szabolcs.nagy@arm.com>
To: Joey Gouly <joey.gouly@arm.com>, linux-arm-kernel@lists.infradead.org
Cc: akpm@linux-foundation.org, aneesh.kumar@kernel.org,
	aneesh.kumar@linux.ibm.com, bp@alien8.de, broonie@kernel.org,
	catalin.marinas@arm.com, christophe.leroy@csgroup.eu,
	dave.hansen@linux.intel.com, hpa@zytor.com,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org, maz@kernel.org, mingo@redhat.com,
	mpe@ellerman.id.au, naveen.n.rao@linux.ibm.com, npiggin@gmail.com,
	oliver.upton@linux.dev, shuah@kernel.org, tglx@linutronix.de,
	will@kernel.org, x86@kernel.org, kvmarm@lists.linux.dev
Subject: Re: [PATCH v4 17/29] arm64: implement PKEYS support
Message-ID: <ZlnlQ/avUAuSum5R@arm.com>
References: <20240503130147.1154804-1-joey.gouly@arm.com>
 <20240503130147.1154804-18-joey.gouly@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240503130147.1154804-18-joey.gouly@arm.com>
X-ClientProxiedBy: LO4P123CA0165.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18a::8) To DB9PR08MB7179.eurprd08.prod.outlook.com
 (2603:10a6:10:2cc::19)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	DB9PR08MB7179:EE_|AS8PR08MB9147:EE_|AM3PEPF00009BA2:EE_|GV1PR08MB8451:EE_
X-MS-Office365-Filtering-Correlation-Id: 543a60be-9d7e-465b-75c2-08dc81820344
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230031|376005|366007|7416005|1800799015;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?U1psQmpTR1pkQ3FDekdlVXNGNFBrQ1FOTXpsT0hHZ1N5OEhpeUpGeVhXNXY2?=
 =?utf-8?B?WGFMWnZGT3Fza1B0b3V4Ulg2bWE4SHZocHM3UkJoS3BXVEdURVpyMW1VNThQ?=
 =?utf-8?B?d3RibEFrV0xVSUVUdHNCNUxjZitXQWlhSnBkV2dNTFNzZXAwTEFZbHh2QXB5?=
 =?utf-8?B?aXhyTEJ5a0hPWUpCUnJDYzhnNUptSnhwZ2tWSVVmdGhLZldJaE5sV2xrS0FN?=
 =?utf-8?B?MVRHVlJUUHV2NDBxcDRMaHNyWTlneTByZFVuZnhxbGNrTTNSSGJDY2p3ZHpU?=
 =?utf-8?B?eVVkejlrL1dPRzRra1FwbjRyMGRpWFVyZ2wrLzNQNS9ZZEtSQnl0Qy9kLy82?=
 =?utf-8?B?aEorR1dHSFZKSjRkYStJQXF5eUVqaWRvalQ1SnpKZFlHcU9JUTF3VHRCM2dq?=
 =?utf-8?B?YVdjVHU0bkFXV1R4VnFGa0FkL1dtMUJ4MXB2NU9Yc3VwM003WjQrRWo4L3E2?=
 =?utf-8?B?NEJLdUtVenROUFQ4V0VySWVRNVUrTldVdHBwUUd3MEg2blU1QmN3OVN4SDcx?=
 =?utf-8?B?ZmhucTR6ZUg0MmNlSG1ia05VVVpEU3ltMnhLbFdWT0h1b1BMWFhOMnMrYVFL?=
 =?utf-8?B?dzNPQVVjYWRBZlJacnlyeFpWejB1UzFZUCsvSTdkVnNqbHlLT0NzS054Z0c2?=
 =?utf-8?B?L1BEWjk2Zm1UVkVVZ0E5bFlDQy9HZG5HUmQ2Smc2UzBaK2VPcEwvaVkwV1Z4?=
 =?utf-8?B?ZFVYUHBxOUgyZ1NzVG1QSDRVbnF6TFVNVXN2aHdQcURGWmJ2dVprcTNkb3U0?=
 =?utf-8?B?WU1Mc21KNVRwT29zNmMyc3JPWlJtWCs2MzE4VzUwbVU1b0dqNU5CbWFlbDBX?=
 =?utf-8?B?a2pjRFVkTXNWWVlCcGFFeFBDWnh2ZjljT3NsRkRXcGk4WnhvVHkrckZFME9w?=
 =?utf-8?B?cTc4OGJnS2pTdHg1QnFxaXFJZ1Jua1RtbUZyaXZldjRrZ1Z0Z20zRTdWY0Jx?=
 =?utf-8?B?L28yeFlRVVBpREtXT3N2ZklTdUYveXRzbEJ2RUVWSHJLc1ZLczlma1NmZWVy?=
 =?utf-8?B?SDN4ZnIxYkd4VEE0bFBEZE9uMmhhOEVsRE1RNHdWSnErelRsRGJPV21PWk1m?=
 =?utf-8?B?WVVwdnAvME9hR3VEenBZV0JvM3hwTnFtMEd6Y2o5NHZVOXQzVTFpQVViVUhI?=
 =?utf-8?B?eHorVkNZR3MyU1l0L0RIdE1uUFl4QzhxTHh6VzVYSW5QMWt1am5MeEJpOHVk?=
 =?utf-8?B?TUJiMjRoazliNURpaCtVc3pCUmQ1OFdweThRUkk2M3FLemJjSDIzeFQ5ZERP?=
 =?utf-8?B?eFhUV2IxNEY1TWhaOXBJWEpnYU95bUUxdTVIc1JNbzJGZEx1MllrMXhUQ3Fi?=
 =?utf-8?B?UmRQSjhwcTNDYnVXQTRRcXE4N0EvaVRhaDFYL2hGTG1TanIxQ0pOelZ5N1lT?=
 =?utf-8?B?Sld5aEJUSzlmWVV6ZHdzL09OYnhGZHJGMzVaV3VnRDVPajUvYnVTM2lwaEM1?=
 =?utf-8?B?Y3ZoTUVZejgvUWdPdG5CWGZ0dXhXdGtITHlKQ2VMTDcrQmJ4ZnZ6VkNXUFl6?=
 =?utf-8?B?MExwRVdjRG84a2tRUFFWbVBvUndWNnB1NXhwRUVxZkNkY1I0dlluUkRKRFVF?=
 =?utf-8?B?V0NLa1B6cmpOa3oxQjBmRWVibTQ5b0dFa0RtdnBnMzE1c3IzTTlPbkR5SFNP?=
 =?utf-8?B?WkNnOStDM1k2VzZJL0xGcHMyWmpJMG9kQXVobkxxY0RmcEVtM1ovUGFIZUtj?=
 =?utf-8?B?K2x1a3JBbkxwVC9taXI5R2NyYkYycGx6bGlxV1RjRlpFMjRxc1IyR1N3PT0=?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB7179.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9147
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM3PEPF00009BA2.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	1174fe25-a175-4ede-f27f-08dc8181f9f1
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|36860700004|35042699013|82310400017|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZlBzSFkxUDJTK3Nic3FyaHkvazBUbERtMjJBUzBPNE9wbVVIMXJxQU5hNUpO?=
 =?utf-8?B?cVYyalpjTHk2NlJ5cm16QjFwR2JuMHVvNURVRC9YUEdyTll1bDV2U0FUenFR?=
 =?utf-8?B?RnNHTWIzNVd6RVRvZHdaSFlVbU9BNjRCbXBxVm1uK2hZTXBISVZRdVYxOVgx?=
 =?utf-8?B?RnllenZoZGlvY2JDdjRXOVQwbjd0UGYwZnd6emIxZnFSZUtYay9zNjZzeXVt?=
 =?utf-8?B?LzI0M3UzbURYTDZ1RVNtTUtRRzJKeDJueGVmUGZ2b3dFcEtjZ3dmeDhaNmw4?=
 =?utf-8?B?dFFjNFpWMklibFczTHN3dUxQWDJGVjVvM3VpdFR0eXZKamNseFZHeW9ZV29G?=
 =?utf-8?B?VG1jbnd6cHVLcUsxNzQwRDJMN1BJMDVTM0llY3EzY2Q4c1h3b1lIbXlFaEhP?=
 =?utf-8?B?dWdNYk1oUU9jUml3NmJYS3B2VHRnRFZ1VmhpcnRTaXBObUJMbU1yVUIzaWRk?=
 =?utf-8?B?eWI1d1ZUWUVuY0FUN3VVUVdiMzFLTnlNdnZYWkFTck8rekdVMlFYSWZuTm5C?=
 =?utf-8?B?NFhnOXVjWGtXajRKU2gzNFcybnBXb2VjZWd5ZDBRZlJWN0pPZ2grUFA2RHZR?=
 =?utf-8?B?dHAwdk54aVlZdWZoaUZrS3pTR3pOOXNjSTBEdHUyb28rNVBFS3IvVmFQTG1Z?=
 =?utf-8?B?T0RqUEZrTURSRWJNeVptbHlhb3dEYWFJaHhqOU91UXgxd1FoZlc5dlM5L1pk?=
 =?utf-8?B?VUpNSHRQV1FHQ1ZTSnJBSDhXY25YWXJwRSsrWFl1ZUR1U09QRCtraFN1TEVr?=
 =?utf-8?B?RHFkT0FIeUw5N0kvMTluMTZLTm83ejJua2tCSUJvcjJtV0RtQ0ZhU3BOU3RG?=
 =?utf-8?B?WHAvNjEwQTdzQXJ6VUZweEJYSGdPU2ZtSmYyL1ZIWEdhU3U3VlFwQTAvYmZ1?=
 =?utf-8?B?ZUI0RmpPblBZTFlJa0E3ZVgvUWY0Wm9wYTRNN2dQSkpKd0dPVEZrOTdTZWg4?=
 =?utf-8?B?TDVvcDZJUm81eDRQOUFoZHVzazk1NzlKVWs4aGpHM1VuT2R2bkhZM3I5Y1Vs?=
 =?utf-8?B?ZFFXYmZIT2ozUGt5R096djZjcWJaMUVrNC80ZjRnMEZtcVFHR29KTDAyUUxh?=
 =?utf-8?B?REZ4SHpGODNqNTJVSGZIUFVXUDBtRkZWZnlkT1lmWmxCN3Vpc0RsUGJhUWNV?=
 =?utf-8?B?VTRKaEozMWZMc0dHdkJVWWtFNGJyWnpxb1ZOa0IwU0ZkZUxDaFN0b1hzWXEr?=
 =?utf-8?B?MHdnMkhNcmthVmFDSk5KM08yWFFTRUJzQVd3RS9zbnAzdkVsSGpYaWhWa3VT?=
 =?utf-8?B?MjI0cncwRmNERlFUYmtiS3FhSldwaHpvWndJa2paSS9ZOGMvelQ4Z0ErVGhK?=
 =?utf-8?B?bG9CQjFkd1BTSENuYkl6WThmZWF4WVBOWUhBdnJBTG1oR0Rjd3p3K1dYSzc3?=
 =?utf-8?B?UEdSTTUxS0EvQ0YzZ2dEYUJwMDBwWjhiTWlUUDhEV2tLdHV0bTYyejhHWUY0?=
 =?utf-8?B?Q25GdmxrTWhhcVFNWTJzc2dIUXlLeTRLZG1od3hFWHZ3TXA3V09yZk5xL2Ux?=
 =?utf-8?B?aXpJamRoWFVtS1dJVXMvWXRKdWhoL0dpaVFIZmJJSU90OGorbk5Sb1FmaDVI?=
 =?utf-8?B?Q3VpTXNVaU9QWDVyMHVNeitiTkpkZXZ6ZUx5cGE2Uy9XZ29PdThqdEl1NXVv?=
 =?utf-8?B?ZkR6R0tyWFd5Q0tBaVk3U25NTG5hSnRTUXB0bDFuVG9MdjhOWDdpcVR3Q2E3?=
 =?utf-8?B?Q3hvdTgzMkcvSC9YLytsQUtMY2xmRFJ4NzlHclU3UGVPblp3WWh3WnVPYk1Z?=
 =?utf-8?B?MVF5UmVJTHgzVlFyckxaUDh3MFNFa1NHN1VQTEl1YUVQelhTN1hGRVRYUlI1?=
 =?utf-8?Q?lTlPmwcVzFZCFB+JEyanuoa5MFQrxt7RMTPGc=3D?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230031)(376005)(36860700004)(35042699013)(82310400017)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 14:57:37.9848
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 543a60be-9d7e-465b-75c2-08dc81820344
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF00009BA2.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8451

The 05/03/2024 14:01, Joey Gouly wrote:
> Implement the PKEYS interface, using the Permission Overlay Extension.
...
> +#ifdef CONFIG_ARCH_HAS_PKEYS
> +int arch_set_user_pkey_access(struct task_struct *tsk, int pkey, unsigned long init_val)
> +{
> +	u64 new_por = POE_RXW;
> +	u64 old_por;
> +	u64 pkey_shift;
> +
> +	if (!arch_pkeys_enabled())
> +		return -ENOSPC;
> +
> +	/*
> +	 * This code should only be called with valid 'pkey'
> +	 * values originating from in-kernel users.  Complain
> +	 * if a bad value is observed.
> +	 */
> +	if (WARN_ON_ONCE(pkey >= arch_max_pkey()))
> +		return -EINVAL;
> +
> +	/* Set the bits we need in POR:  */
> +	if (init_val & PKEY_DISABLE_ACCESS)
> +		new_por = POE_X;
> +	else if (init_val & PKEY_DISABLE_WRITE)
> +		new_por = POE_RX;
> +

given that the architecture allows r,w,x permissions to be
set independently, should we have a 'PKEY_DISABLE_EXEC' or
similar api flag?

(on other targets it can be some invalid value that fails)

> +	/* Shift the bits in to the correct place in POR for pkey: */
> +	pkey_shift = pkey * POR_BITS_PER_PKEY;
> +	new_por <<= pkey_shift;
> +
> +	/* Get old POR and mask off any old bits in place: */
> +	old_por = read_sysreg_s(SYS_POR_EL0);
> +	old_por &= ~(POE_MASK << pkey_shift);
> +
> +	/* Write old part along with new part: */
> +	write_sysreg_s(old_por | new_por, SYS_POR_EL0);
> +
> +	return 0;
> +}
> +#endif
> -- 
> 2.25.1
> 

