Return-Path: <linux-fsdevel+bounces-55752-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B19EFB0E5D9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 23:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E32981886EA8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 21:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C8E28B7EE;
	Tue, 22 Jul 2025 21:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="DCZyEpUw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip168b.ess.barracuda.com (outbound-ip168b.ess.barracuda.com [209.222.82.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B839428AAE0
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Jul 2025 21:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753221494; cv=fail; b=iETEi4Dh5hPeHu3RZmXkJGXBvbgty25gmnxWp/mgaWU7ql5TJPShJS2NLmasKaAQv27EMx/KPtD5qrW/+V4/P+b6Lfk1IN/94nvJu4cN3ULo61l0JqfQiCE7wAAG5X8YWOBnZf9rvvXvoslC3DZ8E1aR8NOguu6Rh1Fyz6o1Rk8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753221494; c=relaxed/simple;
	bh=MwAB0RKU4VVU/9If4jmtXzwMR9yPH0rpmqRvDcIvwzY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=KJ2yHqERNS3TcWPDzH4CMtD96XyGs7lH0AdE2QlsuqfYS55KNZiWy4jd18airHGBkhGN3lnKJmfP2xo28j01de5DqxGWS1x0dfTXva7eTLlOG8vWz13NXvG4QABdxokfHSRwLeRvZkjPZHHOnVji8Q/5zvs70HvleVwQAwDPwvw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=DCZyEpUw; arc=fail smtp.client-ip=209.222.82.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2101.outbound.protection.outlook.com [40.107.236.101]) by mx-outbound-ea46-43.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Tue, 22 Jul 2025 21:58:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mCsjOVOllHK3QvXU/44Gkm9tlFXZe14UlrRiicNdmjEeNBQ18mL4U8ubIykfGxIP4agVZkS2vORjgcZZvCBj66trMiBUeujUgEpOpXGh9U3IV4YaWPX3g1VfRQcdsB458+64HiMIriV8VqrY4LirKd00bwwNLnFiZw/UW8p3xhAv9maiqJA4MGwx8UQTu3umGmuUXOenXywq46Ecj35qz70TuQJi7ZH0mNuq4lDpV+F82njdEVLvVylQYpxcE7wZWZ5Odp8CkZsKlKlbOHnaU4prOQVQG07GCi8T14ZDezpXSt9WZJ96tpd6P9lpFY5N9BYOosU7uMyUiDBdNDlwcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yRIXu+nmDjEkeOFyjn0AYhcbEhOmllC+/+pQfkp/3aI=;
 b=odOAIl2nFb+0LiKTBLdpUaU2srxrfwu/HdwpN3lftJalIRnjp7WO9W8avtgBtpNTk9N2nxLSaf0M/wVhls+sukMuuqi9LIn/Y/Kx6mzPQYqB8yqqZDief/OTs0ZnqcOemcHptgyPa5gGCUDGEdeHqJEbYR2jGgqbhHM3G/iJhmD8gZjQh9GFJQ+uCCCtr57F/sYihSKmBg5YOxbGsOFvyslNzgsaYy5x28c/NZRIr6rri8pRmDJnPaUpyWp4L36ZGMDwYOFvtllumCUDCBxWjm3KpPXlrb+yB5+BS6fAuY9jOh2CK5tbNKRYC5Qn8Hgd15DdMTQ/KqghPxGcZnvXYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yRIXu+nmDjEkeOFyjn0AYhcbEhOmllC+/+pQfkp/3aI=;
 b=DCZyEpUwrcMfyaAuuOKr2VztAZs/7RS1UFjagS34xklg5vIK1ZTkgvHn/EBJT/tf9hRFFVHU4eEX3jwV9OBHqJatDOfhf+5bqoj/SpPdCiJQ5f3jM1OqfAr6Szr4meyXtUa5Ss56/EQGVpjQ3HsLgVWHjeBTJ35b9k+8nF0M3Ko=
Received: from DM6PR06CA0080.namprd06.prod.outlook.com (2603:10b6:5:336::13)
 by CH0PR19MB7849.namprd19.prod.outlook.com (2603:10b6:610:18a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Tue, 22 Jul
 2025 21:57:59 +0000
Received: from DS3PEPF000099DF.namprd04.prod.outlook.com
 (2603:10b6:5:336:cafe::52) by DM6PR06CA0080.outlook.office365.com
 (2603:10b6:5:336::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.23 via Frontend Transport; Tue,
 22 Jul 2025 21:57:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 DS3PEPF000099DF.mail.protection.outlook.com (10.167.17.202) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.20
 via Frontend Transport; Tue, 22 Jul 2025 21:57:59 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id 05E5BB0;
	Tue, 22 Jul 2025 21:57:58 +0000 (UTC)
From: Bernd Schubert <bschubert@ddn.com>
Subject: [PATCH 0/5] fuse: {io-uring} Allow to reduce the number of queues
 and request distribution
Date: Tue, 22 Jul 2025 23:57:57 +0200
Message-Id: <20250722-reduced-nr-ring-queues_3-v1-0-aa8e37ae97e6@ddn.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGUJgGgC/x3MQQqDMBBG4avIrB2wKW1qryIiaeZXZxPthJSCe
 PeGLr/FewdlmCLTsznI8NGsW6q4tA3FNaQFrFJNrnO3zjvHBikRwsnYNC38LijI05XvIb58L0F
 6/6Ca74ZZv//1MJ7nD+unt75qAAAA
X-Change-ID: 20250722-reduced-nr-ring-queues_3-6acb79dad978
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Joanne Koong <joannelkoong@gmail.com>, linux-fsdevel@vger.kernel.org, 
 Bernd Schubert <bschubert@ddn.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753221478; l=1047;
 i=bschubert@ddn.com; s=20240529; h=from:subject:message-id;
 bh=MwAB0RKU4VVU/9If4jmtXzwMR9yPH0rpmqRvDcIvwzY=;
 b=uGJByPTN11Bgi9mOAPAQx9kG21mvMlHb5/L4knUAUhCVWDga9d66e3ADpBLvVJer8q4LCd7BP
 8juTSbaGhozCxxEuqbrFVYJ3+JZIH/YjNDLJf/PIGR8cJVlMI9XWGZO
X-Developer-Key: i=bschubert@ddn.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DF:EE_|CH0PR19MB7849:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bb0c826-8907-43ab-b463-08ddc96ad2d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013|19092799006;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cEkxOVN2OTVEdnJNY2RORlE1THlLK1ZUeHljbmt3bnBUVEY3ZTRKNEcwNFNY?=
 =?utf-8?B?L242R28rSTRFL2Qvdjk3eUloMVd1bThxVG8wMlNITk9uRDRQaDZ3ajJ3M2ZO?=
 =?utf-8?B?OWxzUU45QTcybjY0d1J4WHNpbHNBQmRpcUV6SWFxdkkyU1BFMVp6MGh6QzdF?=
 =?utf-8?B?TTRNODlNNEpZQmY2c2x2dmVGQzVTcnMwYmNsWmZVSkZXNlZBRnRrbDkxdUZT?=
 =?utf-8?B?eGRXdGdDczdrNGcyeUhJOHpVNmh4d3ZXc2hHd1dJMVpIY2N0MEpTN0xOMy90?=
 =?utf-8?B?VUJqWTlsK240Q3JUTWdJQWJBanhNZi8wdTZMSE9ZZVY3ajRFRDBLblFLbWw1?=
 =?utf-8?B?S0ZYRlRnbkxSNExLOGNHRmg4RFp5bG1mYTdvaGl3SkRTaG9ibE9tRUdQUFpP?=
 =?utf-8?B?eTNZSFNwOVRmaFhzd0JqVFpzRVNXN1FIMERRYmpQUFcvelNXNkZ0QWFVbHc3?=
 =?utf-8?B?MXVuNkxVQVhCMks2dDl0YUZ2NTFCbDdBZ05HdVpJWjQxTnZmUFdhaWV2R3NJ?=
 =?utf-8?B?RUlnZ3NzTkVEK25ENWNRNnVja0g0dEkxa0JMNWNqcDlNazczT0ZFOTk2T0Fs?=
 =?utf-8?B?VzV1alIxWW5rY00xRTgzQk5aSUgrR2FZWE02N01iMERhdG5pOWVBSlN5RVJi?=
 =?utf-8?B?emZIMklvOFR5ekJRUkw4SzhwdDZ6a1FZdFFyTlJKS0VYOWN2cGNYMFZBbmda?=
 =?utf-8?B?VzlPQlVHUFFjdjVZRFZwQUdrUXlDd3lJU0hQaFpFY3diYWl3ZTJYK0g2Vy9D?=
 =?utf-8?B?N0VJYysrVEMxMVZhWmdyeWowZ1BWTFd5VEdXTk1tMW85MFlPN0NBUzhDNzhH?=
 =?utf-8?B?dzFOQldTclRpQ0xBc1BZd3MwNEMvUG54aWVmbExGdG4zcEFINDIyWGtPbFlx?=
 =?utf-8?B?VzB0TkpzS0VnYnNXTTFBeWFpZlA3SEMvNU5ubGdzY2FBTmpFdVhhdTI0SnBz?=
 =?utf-8?B?b1NaNzJHTGM5REh6eGtubS94eUtBSU9ZN2FybjgxVWpOQkg0ZURoaCs0WlRs?=
 =?utf-8?B?OWxqaldRTG9idWRYY2FpQlJWRnUzcUJZVlBNM2YrN2RFSm1RcEdIaUVHT1Rx?=
 =?utf-8?B?ZUJmcjdvY1NzYlZJam5rT3l6Ukp0NWFtZ28waGtreHBsRTVPYzNqbTNmc1d5?=
 =?utf-8?B?RVJpOS9vQUdqSFhxbExzTU53b0oyOHpxQk5DUXBMSDg5UWFwWG5xeEFkSjRs?=
 =?utf-8?B?TWorc3FJcEZNK1pDdDNrNDN3QWNPa3FPcGdwZE9xRGw3QzJ2dmprNGYwZHda?=
 =?utf-8?B?L2p2UTRPbGIrQUNhaFlHTy8wRlMyZ3RzRFc2SWpvZ0djVE15OTNVNUh5MEs5?=
 =?utf-8?B?YzNzM1ZzaDhtcHlTZ0JMSUpmUTVGVmtITk1vL1R3eVpZTHF3V0Nnem9reDNy?=
 =?utf-8?B?WFBQMXlSRUdYN25QcndoSGJFdEJaYmxteWxheWM5M0w2b2Z4UTBHUmJtaUlh?=
 =?utf-8?B?NVpzdC9qTm9NT0lpR0M2Yk9rWHFwMHEvMGppbUMvSG11RExHU0J6ZS9pckNj?=
 =?utf-8?B?MXVyYnYvYmJKVEtKRXNnRGdLaFZQaFBxY2ViN2FKcURHUXViOGlpVTlQMTBX?=
 =?utf-8?B?S2NGRUVkUFF6ZTZ3aW40ZUdYYWNqdDUwUzgzbkpmZWN5YmV2eUZtMlVlcExn?=
 =?utf-8?B?WURqdWliVzZUMkF6Q2IrSGl5N2xuQlZqa3VVdWJVbmo1MEo4aFBNdEc1VDls?=
 =?utf-8?B?Zzcwc3A3NWFBM0dkWjlkems0bzVKbE1Ma1laT2ZubjNkTTA4Smhtekh3QjFo?=
 =?utf-8?B?aENzV1VXRnJPNTdkUU9tSWJaOEs5eExIRk9oWjEwdTVGeFRmQnk1UzNBUW5Q?=
 =?utf-8?B?Z0x4UmVhSk9DOEFMS05BNzEyTUhOWXROcEJGODBWVGFmcjdVeENvbGtONUFE?=
 =?utf-8?B?NkM4azMwUGRiRWxpMUp2MmdZQk5MTis3RXEweW1LdXhXamZpQmtNa2RwcWZE?=
 =?utf-8?B?MFdKRm5uMkMxNUxMZlBUYU9tcWYrSUc0SE9TYTlOYkIydXVpR0VFWGpMUGZk?=
 =?utf-8?B?cVdhNlYySlV5Z0NsNmtoTWVrOWdOWDBWckVjSFBnZEZMWXZWL28vZm9aTEZa?=
 =?utf-8?Q?djIenV?=
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013)(19092799006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vpWYOXyGX02gkiDtGEJexBmwwU1rj3zo8/+saod9Q1jWZJS8Cvcy0jDpGudKz2/93oC+pGeRTWcS6YbGqGNzm7rPSIumSxrfRnUKnp0BMzguAYt/O+9Xqb89JEI+TTZwfAn+axL6NQKmJMlhDs8M89rcCPFSKjbIwWFm+/8v01cTeoHr+dIX6NBYWPeP3Fc/42nYhy47d/f1lvq/ezrEYo3zugi9s2hXepv6hJDkV9+S/jtlaAxbmRX0HQqC/r91SxGSJ9dKJRg0sLNxHiyVS3g3DMHHrskMaRZhA+2IcLmrcFKqVm94ve+ByKFXf+L4jCe9gkxT3e6rMWfAdyhq1Jyk6MXihqILb/J0ET8kNv5XZcwsy5Gxby4+et1s7kxdFn2rqDxTSqDh8eJ1/CaU10IEa5pG8rLO3mU8YShTxxceI0z8DChkKj+eJxHqeSM4R24lda6asO3HD8mFF/dzHYOvXE7gVmElbSZdsbdXo4PnQrG1LWbSxR/HcuwgJqkkfxdW6tKGYx5w2gSFj+voH3m7boRr7ddovfV1MCkY5/xwpgy/hli85bGu1FxiX88U+yuFGUtZjOaQUcn6GZECJ7fFKmRZDYteMLAoCnXh0YRUuw1fu0HbumqfP0Gi7Fq8wke/lzLPBWrEuoJvRro+Lg==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 21:57:59.6551
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bb0c826-8907-43ab-b463-08ddc96ad2d4
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR19MB7849
X-BESS-ID: 1753221484-111819-9854-44310-1
X-BESS-VER: 2019.3_20250709.1637
X-BESS-Apparent-Source-IP: 40.107.236.101
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoYGRkZAVgZQMDHFPMnc0CIt2c
	LEMNE8NSkt0cAk0dDS1DAx2SjVxMJSqTYWAE6vaM5BAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.266236 [from 
	cloudscan12-169.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

This adds bitmaps that track which queues are registered and which queues
do not have queued requests.
These bitmaps are then used to map from request core to queue
and also allow load distribution. NUMA affinity is handled and
fuse client/server protocol does not need changes, all is handled
in fuse client internally.

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
Bernd Schubert (5):
      fuse: {io-uring} Add queue length counters
      fuse: {io-uring} Rename ring->nr_queues to max_nr_queues
      fuse: {io-uring} Use bitmaps to track queue availability
      fuse: {io-uring} Distribute load among queues
      fuse: {io-uring} Allow reduced number of ring queues

 fs/fuse/dev_uring.c   | 308 ++++++++++++++++++++++++++++++++++++++++++--------
 fs/fuse/dev_uring_i.h |  26 ++++-
 2 files changed, 286 insertions(+), 48 deletions(-)
---
base-commit: 6832a9317eee280117cd695fa885b2b7a7a38daf
change-id: 20250722-reduced-nr-ring-queues_3-6acb79dad978

Best regards,
-- 
Bernd Schubert <bschubert@ddn.com>


