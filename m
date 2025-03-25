Return-Path: <linux-fsdevel+bounces-45013-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6C92A70259
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 14:43:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4955F178FD7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 13:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2204E26159A;
	Tue, 25 Mar 2025 13:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxera.com header.i=@tuxera.com header.b="cm6y1F3k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2091.outbound.protection.outlook.com [40.107.103.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC74419CC2E;
	Tue, 25 Mar 2025 13:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742909451; cv=fail; b=To1Xo/N0bZ37kc1QRnhhypgRXgZwnVGlbc/Xglr7k0862Px6IPPAjxn/n/Hel3YMsw5nyG4T3kMTVd0yW2bcDr+ne9XRExKzVrWefBwiMXuZSJiG9d3QVksYcMX6XdAwPWp4wSnjDMqWcgherBRnmeCG8wvQdOZhJbH6E+ipXfc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742909451; c=relaxed/simple;
	bh=cmPjs5KybOfhWXPelXNSk/47mJ1bSVcoMPnILXMp21k=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=TX9HdZZ2gsrCiju2yedWi/zR2lj/mBq4OQ1yXobMOBGZhxLDcEmaeoL3sFgAJpdwcmHG7yGD2OGGhG2pHmYYsq8OiR4NXWgWqQo2FzDvBjc4dWtp7jlSdu7TQTyczSHUAhyCrK9YPjEmzIsf30NyHIgNUdQKYVq2/4fikp5Bux0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxera.com; spf=pass smtp.mailfrom=tuxera.com; dkim=pass (2048-bit key) header.d=tuxera.com header.i=@tuxera.com header.b=cm6y1F3k; arc=fail smtp.client-ip=40.107.103.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r4SggIQlkNVHUTfx7CmBrVN+6ziZGX+Gl2ImDmZs5ImJ/j7yvV+KUgLnMfZQbuC+LxyMnX3r0wf1rjxJmLQ34RZGI1QPkNACxseeCLoGVYIFXZBD0ICQ7x8mDiwNgkr9rTG88LsQXeI94O6aiPW1GW9E6ViniCP8YKYEV1DxzUY1zBbsnOYY600WxCP205CBUxWiROpfAiwtJHGZfKV56nEVCF79FgbHNAHamjO+sL8waIAaCDWF7qX+K4fVrNb169osx6zn+vYaih1lEzdmmBWfCTkNl8CLctiSJdeaadkVXgOAa7oiOA2+HDmXlZAbYEH+5yPIK/mJDeeNdAsI0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WOkaNf65rFJCLznDYyoQo3E6u86qsFmekyKGAmOJrtE=;
 b=HIjuHhon4+iS74qfMhi/yQDuDYhw1t7mCtjWt0W2T5Aol52TMvGDXvzaxSscKfpOAGjAo8Hq7ccgtQzYJhwSqeEvO46cccdyKP+OkF4m3zaLNKrDjbFS0rgSKSmCHP8qGEy/ih+0GqypWEOyuYNydT0nTrMHqI51glt0lizPpQ6+1vpQmyDBa5xgEcKEGHeeHg7bTcVwlmuS8Z3XZKO63wxC9Jfjj+Rfm248UwymcSJ6rR0kgQCS4e832veCq2c2aC0KPKtmUDmAmSbv77tcI/12OrNh1VZViPpD2JgDWZd+OWUpXGYE0LrIs3+2JvsHVpLTL9vc+NuSkdUwnI/ZsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tuxera.com; dmarc=pass action=none header.from=tuxera.com;
 dkim=pass header.d=tuxera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WOkaNf65rFJCLznDYyoQo3E6u86qsFmekyKGAmOJrtE=;
 b=cm6y1F3kCSesuKE4DCAsiNCB1rM4mjaE1p1VG/oDN09S0La+vfkvO8Qd/0PSOAt1H5tZifimIjPWbK3d14SGW7hLBPiDUV9gCp4YXjJj0j0uTMQIw7NLNW+TE7eTNYOL5+mcMEHbWPDqVjfKKofoiqQSccnOD/IwfF4V6p7E7VInoZlb3pNnr2WcU0aqxQUvVeZhluXGmMKvc2LHHaZoJo/IFHWSlWatanM1L9kOM29pM+E+bW8i/8/7Knhi4cFzoKvgonprp2vIJvrlPwIBsxwqPjeG18o2hoWCwuLnAUA8rRyAvUFtEp8WzUuNaAxFqotOX3G5zNj5CdALfp22zQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=tuxera.com;
Received: from PAXPR06MB7984.eurprd06.prod.outlook.com (2603:10a6:102:1a9::9)
 by AS8PR06MB7750.eurprd06.prod.outlook.com (2603:10a6:20b:335::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 13:30:47 +0000
Received: from PAXPR06MB7984.eurprd06.prod.outlook.com
 ([fe80::f663:f3dd:7a0:7d4f]) by PAXPR06MB7984.eurprd06.prod.outlook.com
 ([fe80::f663:f3dd:7a0:7d4f%4]) with mapi id 15.20.8534.040; Tue, 25 Mar 2025
 13:30:46 +0000
From: =?UTF-8?q?Aaro=20M=C3=A4kinen?= <aaro@tuxera.com>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org
Cc: linux-fsdevel@vger.kernel.org,
	stable@vger.kernel.org,
	anton@tuxera.com,
	=?UTF-8?q?Aaro=20M=C3=A4kinen?= <aaro@tuxera.com>
Subject: [PATCH] hfsplus: Return null terminated string from hfsplus_uni2asc()
Date: Tue, 25 Mar 2025 15:29:47 +0200
Message-ID: <20250325132947.55401-1-aaro@tuxera.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GV3P280CA0002.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:b::27) To PAXPR06MB7984.eurprd06.prod.outlook.com
 (2603:10a6:102:1a9::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR06MB7984:EE_|AS8PR06MB7750:EE_
X-MS-Office365-Filtering-Correlation-Id: 60e856f5-b520-47a2-f8ca-08dd6ba14023
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z01tSG9vTVF0VzJpdzVJVXNhLzd0d1dMWnI2YlNBUHRkODlqTDRFejg4Tkoz?=
 =?utf-8?B?NVhkQVhwOS9hL1YwZk9Va2lHTVI4YjlNN1JPNFIydVQ5WlZOTVpEdkVZS2FP?=
 =?utf-8?B?Rk9UU01MSDllNnZ2Z1VPTjRlWFp6K0phRFFNTFB3TExXd0xmOWRXMFRNNGpL?=
 =?utf-8?B?VDZmSC9uQ2x5SnIxYmsyVTl0RDA2ZFo1cmVYKzV6bGtHdnRvRzFuZ3ZmcFZ0?=
 =?utf-8?B?bFZHMDY2WHlTNlRqZnlTcXBoeXRObm9nTGtuUXpsbDBxNzVGVTMxM0Ewa2N5?=
 =?utf-8?B?YklXclVYQ1paVVRvZktNMUxDUHZUOEg2Z0krUVRkVFllQmVjRDNKNEhHZDFx?=
 =?utf-8?B?YXROVTVOcVJwOW5MTEdoWWVSWUVmOEQwU05rckgvUlUxSndiQTNpL281YjIw?=
 =?utf-8?B?RlFaTkoyRWNPRk1ldW9ITk5xMVlLVmNGVWdPQy9udVZDSHkya1Bia05KZlcw?=
 =?utf-8?B?RGlKYXVDTHFxN3oxQkdBQXpwQUNtaWJPMXdmQjlyUU5pZm1oSUNYSERJeGVn?=
 =?utf-8?B?eVYwTDhVVkh4K29DTi83cnY3MURNUndQUzFscXpsSzQ1WGNTWkxwTWhJSHpL?=
 =?utf-8?B?WWxROEFCWENzY1dRbklzNnlNY1pVUXE2U3hEUEhoNlQzQ3hjYjRNMmVORlYv?=
 =?utf-8?B?dU9zaVhNazR1V0RmODV0ZFh4bDUxdC9sMFhkbTdpdTVqZldrV2tPV1ZjdGhB?=
 =?utf-8?B?VFpVWnc0bDZiUGNpNURHWHhZSE5GRndQZ2l2OXA3bXoydUdKSkdCS045NWhh?=
 =?utf-8?B?NGpZcHB5N1Z2bVU3VmlzK2YvM3NTNHp2VGlVQ0RDM1krNnBVR2dHVGtweGF5?=
 =?utf-8?B?NzR5SUxqcEdtczdyZGF4TWF0UW9pNFRCc0M1WEpXeitGN0R0anZrQjR5cU1Z?=
 =?utf-8?B?cDRmdmdqcVRrb1QxY0gySTZhWldHb0pKeWF3dXBCWm0rNTZNYWpKZFVzRlYx?=
 =?utf-8?B?T3R0NzMxZ0hJNklnSjg3WXBmSGV6ejJVLzViQnVBV0pDUlVHclJQVS9TcjRa?=
 =?utf-8?B?V0c2MEFEdUE4REFGbmhOV1VEU1BjdkJKUGhZbVoxaGVvRlRzNFlTN1RwRWor?=
 =?utf-8?B?eTNRTm0vR05QZzJPRG5qTXFJQWdTbEowSUV3K2c0bGpNREU0Tm0welBmS24z?=
 =?utf-8?B?Vml0ZmI2NUlwRGcyOVAyd29QNFB5dzNlZFRXL28zZDlPOHRrOWdxZEI5L01T?=
 =?utf-8?B?M05IU0NHbHBma2szb0tCT05QdUxUcmpBN3l5RThITWtLZGF5OXlRQ2pYa1Mv?=
 =?utf-8?B?UGREZHBCS0FrRDR2MHJvLzhjZWNxQk9qS3c1S2pzSjh6cDhYNWNzdEV5bmxh?=
 =?utf-8?B?MlZKUmhCeU1QWEYvcmdkWUNlWWpWS3ZsNkxMOElxeW5qS2pPSTlFTit4cTl2?=
 =?utf-8?B?MHVzeDduSldTdnc1M0dqckFVNERQM3I3amJLWTRiV0I0L3BZMXA4V1FVVi85?=
 =?utf-8?B?eE1MTEpqY1hVem5pelh6dGtvQXdHZC9PN1hsNHVpRkwweUlCSjB6K200ZnNE?=
 =?utf-8?B?alNqenBWdEZ4cDNteEJoSDhtekxxTHRHZEhqZkhKZE9VaXJTWDQwa3ljMzhk?=
 =?utf-8?B?NEVtQ29SZzRXYm9qeHM5VUZHL3dqUHRrYzhXeEg5aXk0c3lUc0ErZFBzZ0xk?=
 =?utf-8?B?Q1hTVnJoRUw4Vm1mU0hjdnBkbUZ0QisrbHJYVWxDbC9NcDc4N3prTGJ6Q3U3?=
 =?utf-8?B?bmNmWEhrSnlFN1JETGxOS0lWaWxoWnI4WGVGTG9wdmVRcHZPKzBrVTE3aSsx?=
 =?utf-8?B?NXFtK1plOVd6Z1lNUWdmeW12ZzRGaGNYQ0dnT2YzNmZ1MFBMWDBiR3ZFaEg5?=
 =?utf-8?B?dTJIRCt4TUowL2JFQnB5SXNsUlJqU1JTU2NZNHRRaTFjVUNxaEVwNklMVlI0?=
 =?utf-8?B?clpwS1hvRi9hQ2NnRWRRbjlQdGxoV0hhTGl3eUptdUlzck5qZXA4ZmRhWnVV?=
 =?utf-8?Q?UO5FvzqFum4alPdK+F79Uf7hwM0x6qiN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR06MB7984.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R1pnaWlyZ0Ntbkh2N043bGpXSVRJeHBPN0lNTFFZL09yNi91NHkxSFdqSmdu?=
 =?utf-8?B?V0RReHUzR3gvRnRaUnZwUldXakZ3VHFIaERlS0FVM2ZKZ3NLZW1kZHIxZVIz?=
 =?utf-8?B?ZXZwOWV1RE9OaXFzOGRMQjNJWGMzRWtzSE1yY0ZoVzJ5VVVxZFVBUHY4UHR3?=
 =?utf-8?B?WHdlZUJ6UHpzcmJ2T21nRTRTNTd2c2lhQ2VFTmRtSThOay9hS2NteXVsam9O?=
 =?utf-8?B?aXNGeFVBcVViQ1c0OE82TmtvZEZBZzV0aTFtZ09wZzNNandqVmczOGNUbTdu?=
 =?utf-8?B?Q0E1S05IUDFZUVN5TmhZYWkyc1ZZVkl6VG5XWHB5S1VhcVVuVVY0MjFiKzJm?=
 =?utf-8?B?b24vblRoTVFMT2Q2ZmRXZmdNdmR1TFFMbTBjcC93NVArby85aDRuTVpOMGpY?=
 =?utf-8?B?TGZ3QnlyT1NzeVJmeEdxK0gvd3E2U0NhQ21BbHFoSjdHUHQwMWZ5SHhCUVR1?=
 =?utf-8?B?ME8xL3pPcTk2MUw5R2ZuZ1Jmdlg3TXo2OVkyODUyaUR3UkZXaE1MWHdad0No?=
 =?utf-8?B?OC9JVkpzaXdiZ1M5ancwby8rVWJSTjAxVHZNOEYwRzgvemJYTzRNc3hnN2hl?=
 =?utf-8?B?YllqUTg1QkJTdkRVSm0rcWlYQm9rcDFzL0hRM05MU2JIdzI1UWE5cWpCVUlX?=
 =?utf-8?B?aElraGliNTRoT2ZxVjVFZ1kvUW9LZlA3K1BuMFhHOWRPVzVHNUF5NmR6QXlt?=
 =?utf-8?B?aTBUUC9FRFp3SkRjM2dLZGZ4UTNKVkdPQzRuTHNnZzJTR2hOYTJpUm5TYzhD?=
 =?utf-8?B?SWdsN0xZRzhjTXBDbW0xUUYzUDA3WnoxZ0YwZHNNeFo4S01sZHhqc1luS1Rr?=
 =?utf-8?B?eWVEb0VTeTcyS0ZodDlVeUd4ZWc0dWY0WFN3Z2dmbTdYd0Z0QUhZaE40Tjdv?=
 =?utf-8?B?YW9zZmIrK2RvK0xyeUFlRld6WGJmY0RPYUh2cnJVSTRYV3EwK003UFRTRnZy?=
 =?utf-8?B?Z3NNUDNRTGhOeFhFczVpQWZ0TGg1dlJFcE1zMTN4NXhqNHMrQi81U3VCK1FU?=
 =?utf-8?B?WWpucndibVBPYXBkQkRXdUN3NUVoWnpnaVE0RFUyMDZlcExOc0llRVFxK1pZ?=
 =?utf-8?B?ZGpPSzZJeDJITmlZdTVnZUVJWXF6cHpabWpyT05oZzFzWkpyRmt2cnhjV3pJ?=
 =?utf-8?B?Q2ZTanYxdmFJY3JUZmxMdVFkLytzQk1mOXZuZ0ZOV211dGJpVldZV0NlZzNX?=
 =?utf-8?B?R2grYWUzYkxKcm9hWElJUURHTGhadmFBSklyT0RWSTNhOG11ajBIVmkrTUFh?=
 =?utf-8?B?cTg4NnR2RTh0SndESThoeHo1VkhGRldtcTNiWFFLdk9NQkZBN1RGdzl0Vk13?=
 =?utf-8?B?cVNhR3dCVm1XOVVOTXM5UGtQRG5HWEZXNFlVcGJIME90VHR3RmRTM2ZORXFT?=
 =?utf-8?B?UmlzTURzSGh4bE90cGF5ZGZZOHFZTzdNSmxib2RXQ0FrUllFOUdQMnBHTmxj?=
 =?utf-8?B?eU9BZXFNblN5Q01ncVY3c3V0Z20vT1VRclBta1ZLYzhnOXBZcW5XMlJDODVp?=
 =?utf-8?B?bnM0cVU1ZnBnQ1VnRytwNXJxVEpGd1BZazc5RWVvYTJMRzFWVldiWnI5ZjJl?=
 =?utf-8?B?anNidng5RDdjeFdtTVc2Zkh2MW93Q1dvL0NubWtpOS9mT3I3OFFTYXFQS1dV?=
 =?utf-8?B?blBSRC9GaDZyMStXSkFWbU9vTkIrQnk2QTBTUnZ5OXJaaytvV1hSNkNrUDdL?=
 =?utf-8?B?TzRjYXRqV2t1Qkk0ME9HTGR1NEhMcUthTGhlZzA4aXZIeEVDQ3Jjc0EzZmRH?=
 =?utf-8?B?RngwRFRCM3BVazErQkN5VDNBMHRUb3JuYmcvck9sUDlmekIveGV3bmZLVjcv?=
 =?utf-8?B?MUUzcERQQTJmdEppUEl3cEtUQTE1aks0akxHaE4rSXovTW9jT1BocVcxd3Zh?=
 =?utf-8?B?WEhVbzd0Tlh6b2dEdk1DM1crY0oxQ3lFMXNyQWVqVHlXMkV4NFJ0T1NOVGhs?=
 =?utf-8?B?OW9DcTJyVjl3WTExcEQ3Q2xzTS9zalhuazZ5K2NYOW5qVUxidk9xQnJ3Mmk2?=
 =?utf-8?B?TDBhVHRtZ0VNdnNic04yejIxR2JQZm1kTE1EWmxKcHZGejQ3bmxWWkFYNGlJ?=
 =?utf-8?B?M05NcU96V2ZMZ2VHQ3hZNDYxWnMyWEVmVnJLN3dFN2VrZGVJdHcxRUFNM0FH?=
 =?utf-8?Q?GGCFcbP5AX/dwKHQb8++lXeN5?=
X-OriginatorOrg: tuxera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60e856f5-b520-47a2-f8ca-08dd6ba14023
X-MS-Exchange-CrossTenant-AuthSource: PAXPR06MB7984.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 13:30:46.7945
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e7fd1de3-6111-47e9-bf5d-4c1ca2ed0b84
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nw7NUC538sCUS2/+J6QzzbCRUExxlwwQykyIYSqiJNgkowIxkVAigaGIN4Gg9sVJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR06MB7750

In case hfsplus_uni2asc() is called with reused buffer there is a
possibility that the buffer contains remains of the last string and the
null character is only after that. This can and has caused problems in
functions that call hfsplus_uni2asc().

Also correct the error handling for call to copy_name() where the above
problem caused error to be not passed in hfsplus_listxattr().

Fixes: 7dcbf17e3f91 ("hfsplus: refactor copy_name to not use strncpy")
Signed-off-by: Aaro Mäkinen <aaro@tuxera.com>
Reviewed-by: Anton Altaparmakov <anton@tuxera.com>
---
 fs/hfsplus/unicode.c |  1 +
 fs/hfsplus/xattr.c   | 13 ++++++++++---
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/fs/hfsplus/unicode.c b/fs/hfsplus/unicode.c
index 73342c925a4b..1f122e3c9583 100644
--- a/fs/hfsplus/unicode.c
+++ b/fs/hfsplus/unicode.c
@@ -246,6 +246,7 @@ int hfsplus_uni2asc(struct super_block *sb,
 	res = 0;
 out:
 	*len_p = (char *)op - astr;
+	*op = '\0';
 	return res;
 }
 
diff --git a/fs/hfsplus/xattr.c b/fs/hfsplus/xattr.c
index 9a1a93e3888b..f20487ad4e8a 100644
--- a/fs/hfsplus/xattr.c
+++ b/fs/hfsplus/xattr.c
@@ -746,9 +746,16 @@ ssize_t hfsplus_listxattr(struct dentry *dentry, char *buffer, size_t size)
 			if (size < (res + name_len(strbuf, xattr_name_len))) {
 				res = -ERANGE;
 				goto end_listxattr;
-			} else
-				res += copy_name(buffer + res,
-						strbuf, xattr_name_len);
+			} else {
+				err = copy_name(buffer + res,
+					strbuf, xattr_name_len);
+				if (err < 0) {
+					res = err;
+					goto end_listxattr;
+				}
+				else
+					res += err;
+			}
 		}
 
 		if (hfs_brec_goto(&fd, 1))
-- 
2.43.0


