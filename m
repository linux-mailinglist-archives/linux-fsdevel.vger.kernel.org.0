Return-Path: <linux-fsdevel+bounces-40048-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F38C2A1BAE2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 17:47:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BF82161111
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 16:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E230319CC21;
	Fri, 24 Jan 2025 16:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="Xt4thC0r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip168a.ess.barracuda.com (outbound-ip168a.ess.barracuda.com [209.222.82.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24EAF15CD79
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jan 2025 16:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737737264; cv=fail; b=c0WFKrJsWCyhV9jEf26Ul5eGLaxueMqk0Q0ZA1FrlDPm9YY6i3JwMSKkbO52DQ8iVLZbX+O2mRP3Bp9m+ZkC8wM/8Sl9Mpak7Xr1iCPyd2zSO1Ot3ySefrB/Ir5ETzn/OUq22jcUtQusoENT7RWoKTH9UJ8npEu999QBfzO4xs4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737737264; c=relaxed/simple;
	bh=mmYQgr4xT0s+tpERMuxN/3+z3AOf/vKjTEggk2uOsE0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BouNR8VW4oUccoZJUvSw+LrbK42JZPjW8QE2eqqSFi/Uzo5Dzt4egHnuCwEyOGpGaWp3bh9Wp2oCEUWNvcuQdIR55IcTWWMmyRPygzcW1UFK5hrKM33m9xn4VpIECJSf1+2QfhEnBiPLaHPhVCIBNa7gC4cdRsrr6RUL6IVje8Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=Xt4thC0r; arc=fail smtp.client-ip=209.222.82.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173]) by mx-outbound11-174.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Fri, 24 Jan 2025 16:47:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y7lQQKFRMQuHrvsKO3wOL46bHKpcKBE9LBPd8Cu2Yrm90+5WoG/s/ciuKkSuwGC5KijdZSdJO2cAW8/vYmQEzH8hT91Pt4KFk8fFivmGlylwFD1U9htJ0qVAD51/e+JNkUdJ+PVp0bjf5Z+f6Gy5+uM2/3GBGLP7X0xDz4ENNoA1KpxyB8tUzJeqWWHlEblYePmKQ0vzMdaxN/pcvK/8e/pcptow5d0HZV49bHEsZjvcdudaKBCuIpfzqwVzpnsJbbYXfSsz7gGcrZZE9YVBQzxvGks6Cf6e7fdxtikkLDtQB8Hp3qb5mj2hPSAsK266i1xP+JiBD/G0ZOFq0kVZrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=19OfjP+cJyZoJzu+CZ/6sw5/92wMTTylOf2yltTPsWw=;
 b=UAmkwxDUy0A/2YPRxZntUeTaei3Sz8+VHrSoWn2km3SoG46vb1RsbmvtctsMFHLTBFWJqhs5ldYeq4D4ixNYFY+zu5RRjzbAhDBAc6yDrZWOFZ9S7exJCYGqf5eEbvL5dGc8fjqCGsyY0+NkhVMN4jGrmlswhOi725FUk55etXbW+DOtWIfjV5nfLJ7Y0x4QkLEmk8iLMI1GEf9zA2Z/Oa/s9lCn9UvN+gHZlsLBtJTuG6UnmdPd2/RYzbEM/x/tuzXLSx1zNIw9n1lwDGMPS+mPAP74bWMs3Pw8bmc7Z2//GOBegUZlgeHvUi3qGNlnCi91Sl26Z3l0nC4xgfttJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=19OfjP+cJyZoJzu+CZ/6sw5/92wMTTylOf2yltTPsWw=;
 b=Xt4thC0rCj1m30iWZ42XwsbFXpDfoSJXdyBZrezgIZnklGRd/Q2Na/C+sFqSIPADwUSZQ6kcOLplWOOly8S+imWfv7LZYps/GVIPzWd6ZyWkm/5sX4XBsXphl/PgqEyyVX95zVgOHv8OguMR1D8OxqFbg+dckH8PNc/H964SVcE=
Received: from BN8PR04CA0001.namprd04.prod.outlook.com (2603:10b6:408:70::14)
 by IA1PR19MB7637.namprd19.prod.outlook.com (2603:10b6:208:3f7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.17; Fri, 24 Jan
 2025 16:47:16 +0000
Received: from BN2PEPF0000449D.namprd02.prod.outlook.com
 (2603:10b6:408:70:cafe::d8) by BN8PR04CA0001.outlook.office365.com
 (2603:10b6:408:70::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.20 via Frontend Transport; Fri,
 24 Jan 2025 16:47:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 BN2PEPF0000449D.mail.protection.outlook.com (10.167.243.148) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.8
 via Frontend Transport; Fri, 24 Jan 2025 16:47:16 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id F1D2934;
	Fri, 24 Jan 2025 16:47:14 +0000 (UTC)
From: Bernd Schubert <bschubert@ddn.com>
Date: Fri, 24 Jan 2025 17:46:53 +0100
Subject: [PATCH 3/4] fuse: {io-uring} set/read ent->fuse_req while holding
 a lock
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250124-optimize-fuse-uring-req-timeouts-v1-3-b834b5f32e85@ddn.com>
References: <20250124-optimize-fuse-uring-req-timeouts-v1-0-b834b5f32e85@ddn.com>
In-Reply-To: <20250124-optimize-fuse-uring-req-timeouts-v1-0-b834b5f32e85@ddn.com>
To: Miklos Szeredi <miklos@szeredi.hu>, 
 Pavel Begunkov <asml.silence@gmail.com>, Luis Henriques <luis@igalia.com>
Cc: linux-fsdevel@vger.kernel.org, Joanne Koong <joannelkoong@gmail.com>, 
 Bernd Schubert <bschubert@ddn.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737737231; l=6303;
 i=bschubert@ddn.com; s=20240529; h=from:subject:message-id;
 bh=mmYQgr4xT0s+tpERMuxN/3+z3AOf/vKjTEggk2uOsE0=;
 b=oYxbAHpmlYhxNE1i87BXGUj9QaidBu7mkie8SRig9Ju+K1SrCaTwpxyfPsv4QfbWMxQlIuLzS
 Lrb0Azdd4CQA0tHMpYrGShG4o7n8oX3vDRA/CSRsBmJuqpVt4KCdE0t
X-Developer-Key: i=bschubert@ddn.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449D:EE_|IA1PR19MB7637:EE_
X-MS-Office365-Filtering-Correlation-Id: 18ca1c92-67ad-4af5-0e86-08dd3c96c275
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VEVZR2xJdytsaGIrMDh4OTRFc2cxdkN0NTNlVEE5QWFGWE9PckhpYXVvL0pK?=
 =?utf-8?B?Nnh5UTJGNnVuM3FnZE01aENNZTFZUEV3WGM5UmxpdTlxUmkvQUxXYWF5bFpQ?=
 =?utf-8?B?MGRuclVHNmZRUTRtamFacmhOM3RvNDhzd2xlUUphNjQ0bG1hYlIyNDI3MElR?=
 =?utf-8?B?cXg4UWNlaUMra0ZyZkhoamp5OGl4dDJpRENycURXUlU2TlRRejkxaWI3ZHgz?=
 =?utf-8?B?dFh0UzJlcWUxa2ZLUEo3SVgyTkRoNVY1TERHQVFNODVHSWhDSmhEa1ZPY1RM?=
 =?utf-8?B?Q3hzbHdHamhSOGZxTzFqanRtN05iT0d0M3ptQmMvS0pJTGVMN1ExaWhaak10?=
 =?utf-8?B?L1d4RGlqL241b3RmN1pLWjBpYVFKdERkN2RnMUxQendoZnFHc2hPYzVLZGZR?=
 =?utf-8?B?Umd6R0JSNTY4cGc1cUREa2pzRHVsemJFM1BNSnUyQXkvbkRiSXNra2Y3S2xW?=
 =?utf-8?B?R3kxRTdUczFPdTNReWVlajZjdUJyY3VmdWJlbk1CQXdHN1AwbnJQM1RVSnRW?=
 =?utf-8?B?bEkwbmVGNG9EZ1ZYdVBMT3ZlNzFIdE5mOXVtVHJkTXlLOXRaZmRQWXFtZDUx?=
 =?utf-8?B?MTc3QVo0cGJoWU9nSzBwNVRvbGNrYzFwVGhYYnM1ZFpZNmo1NWRDNjdXY1Nj?=
 =?utf-8?B?UVFweUpLNXlnbXJwRmx1WVp5OUlpbk1UaGxDRHpKNFNGTDIxbTNYY1hrVUNG?=
 =?utf-8?B?alFSTnNyWHQ3UmJsM2VrdUFjN2xCb0dFSUxMQlZUTlY4U2g2TmpFeCs2LzBJ?=
 =?utf-8?B?di96eTA0eVdmcExsMm5EakJDUTFQYmJWU0xvdGVSWDVWVEFnZUpmRU1SK040?=
 =?utf-8?B?amNjdEV0eDUwcWRqSGgrcHVtanZhZmdnL0x6Y0hNQ1MyUk0vcjlOTUhyM25J?=
 =?utf-8?B?SEkxODVYZExYTWFIbk85UmtuTDgxdVh4RjBDa0MxclpXc3g5bHhnRkRsTEVj?=
 =?utf-8?B?RkV4amNZV2MrM3ZsNlJScXZMZHZUWUtVRURpeE9uZ3cvcmlFT3p6UlMvMDg4?=
 =?utf-8?B?Y3dRUHVVaHlROGZueUcvZXZXTEJ0bG81dXdyZUJrcVZ4TWwxNXdzMmx3K2Fo?=
 =?utf-8?B?ZThGNndxZ01BL1gwQU5IcUVCUndWZjNRQXNBZkF3NXFQdlpkL0JaMnl0K1gv?=
 =?utf-8?B?ZTBDY1h4Z1gycTJHMG1ObXJtSmwzNjdWRGNHazVwekVrRENWZDNNRnNsWmFY?=
 =?utf-8?B?VmJwaDUzUFFTRE93WWM1RlNsNStoYkE5Y1kvT2pEYU1XZHR0SzcwVDVvejBs?=
 =?utf-8?B?aDVCUGNCUWRQZDdHNjNsV0s4SEduY3g4K2Q2UnZGTkVqZXliNUQ0Tm1xYzd3?=
 =?utf-8?B?MkhIRGRmMCtKQVlPVHlZM1lYZXh4MEpiMnVZTXY0REV0VFBkM2VWMlMvTXNH?=
 =?utf-8?B?OUY0eDkvdDMwWXo3R0RVNWVLZDl2SWNQVEYyaHJFdGlXK0gzVTNkSHNJYzRx?=
 =?utf-8?B?UjlnSFd5cWR1U3VzcG5hREdOajFyOGRjSGtnOWtwTmNXLzlMMGxSV3VPb3pz?=
 =?utf-8?B?TTNnMzV4MGozdUx1T0l2ZklKaUk1REJYQkJ0NnJJQ2I0Q0llVmpwS1NWZlhN?=
 =?utf-8?B?L3RoY3BWRzlTM29JbVpueDM0N0lMeFBuYkl5R3RyMm5kQjVGN3JHTFNhOFdh?=
 =?utf-8?B?ZXVIOTZyM3d1bmk5Q1c1TEtiTXVIQzRWNXRlVmxId1RKM1N3VUNZb3MzUHc1?=
 =?utf-8?B?Q0hzRjhGaHJyMjc3Mi9LbHRlVjNHZEhVbjd1RVFPL001Z0EwTXkrUVdyU0Zx?=
 =?utf-8?B?Vndkejl5bU5SNFl6cHF1bHR0U1VhbS9KbHBUUnM5aUFJR214NExjdTFYeXU4?=
 =?utf-8?B?alpCaURMM1RwaUVpb2k2MnNwQ0l3NENpUW94SitTSjFzajVPY1RJNTZyVjU3?=
 =?utf-8?B?WTl2aWN2dlRJMWtSMzQ4Z0p0aGJwYzE2bTRORWlDeDFoK3JmUXRSYjJteXNr?=
 =?utf-8?B?K3dxZnNyMTRNeG5xV292TWx4OC9Tc2FjR05uRCt5T3dvSS9PRkc3YkFaNDlk?=
 =?utf-8?B?NFBnMkRUTXBRPT0=?=
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	mkBlJbUiH2djE33wsOf2Bfa3wE/f33X/xav4EwhAreTtjKGKzkxYpGwr5r+sRtNvR8T8UwH65/b2t0a9zYS1G84scOJJd2kLwtfKWVpWa12/YUDKtyseSB18LGBq7EJWlIUGGqt9CS/xrVSvxXTbcwso37tjW4DwJ66cdehnXr0K7qIpaXBirAbO51mKLtV1MnVoq1gGMq195Uz+KLyukv3YIYENwSDHPzPt54LPAshRlxOkWWZHZaHsLz8jHx3SHwUDQrrcdov9amhA/hP1wevML7UL7vyo/mPnX5vONgqOb5ZABq+TRAx5xvBg5uLhD2rzy5Duw8NRlD0A72RtF9+VFTwyeuiAIbC+zPBcBOC6Vj7LVJ/kGYLq/xuAZT6blRyv6YYdkK1I42zYZkIQpXQend3fqkKQBP0mP1SNjmgjAt8W8VDsFNqF1FXycrj3V7SuP0SlXtvrkp+9FYgNrJFAtgFurxedrXJveCb3KxBzanAHM8PRTbGilphnuNNsaHa8n8x/Mn9z17pWp9xfSEtcroBlO4qPlfhGplUTbGwhN/D7A5+1K/imZyOqTx1IvcpYEKGxzy0ZwSNGEQXS41d5iIJcPNUZNUTsSrklIyeHCpMeThLpxdKxDRXbEpMoopUkeu5M8RE+az0+AnImDg==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2025 16:47:16.0284
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18ca1c92-67ad-4af5-0e86-08dd3c96c275
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000449D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR19MB7637
X-BESS-ID: 1737737239-102990-13434-20870-1
X-BESS-VER: 2019.1_20250123.1616
X-BESS-Apparent-Source-IP: 104.47.56.173
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVmaGhoZAVgZQ0MLIItnY3CDF1C
	TJwtzC0DjJwNw0zdIyLdXM3Dg5ydhAqTYWALZdbUpBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.262028 [from 
	cloudscan21-255.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

This was noticed by Joanne, we better set ent->fuse_req
while holding the queue lock and also read it with that lock.
Issue in current code was mostly fuse_uring_entry_teardown(),
which could be done from an async thread.
This also changes fuse_uring_next_fuse_req() and subfunctions
to use req obtained with a lock to avoid possible issues by
compiler induced re-ordering.

The only function that doesn't use ent->req without a lock is
fuse_uring_send_in_task() and that was changed to use
READ_ONCE() to ensure memory access.

Fixes: a4bdb3d786c0 ("fuse: enable fuse-over-io-uring")
Cc: Joanne Koong <joannelkoong@gmail.com>
Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
 fs/fuse/dev_uring.c | 54 ++++++++++++++++++++++-------------------------------
 1 file changed, 22 insertions(+), 32 deletions(-)

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index 87bb89994c311f435c370f78984be060fcb8036f..c958701d4343705015abe2812e5030a9816346c3 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -75,15 +75,16 @@ static void fuse_uring_flush_bg(struct fuse_ring_queue *queue)
 	}
 }
 
-static void fuse_uring_req_end(struct fuse_ring_ent *ent, int error)
+static void fuse_uring_req_end(struct fuse_ring_ent *ent, struct fuse_req *req,
+			       int error)
 {
 	struct fuse_ring_queue *queue = ent->queue;
-	struct fuse_req *req = ent->fuse_req;
 	struct fuse_ring *ring = queue->ring;
 	struct fuse_conn *fc = ring->fc;
 
 	lockdep_assert_not_held(&queue->lock);
 	spin_lock(&queue->lock);
+	ent->fuse_req = NULL;
 	if (test_bit(FR_BACKGROUND, &req->flags)) {
 		queue->active_background--;
 		spin_lock(&fc->bg_lock);
@@ -97,8 +98,7 @@ static void fuse_uring_req_end(struct fuse_ring_ent *ent, int error)
 		req->out.h.error = error;
 
 	clear_bit(FR_SENT, &req->flags);
-	fuse_request_end(ent->fuse_req);
-	ent->fuse_req = NULL;
+	fuse_request_end(req);
 }
 
 /* Abort all list queued request on the given ring queue */
@@ -298,13 +298,9 @@ static struct fuse_ring_queue *fuse_uring_create_queue(struct fuse_ring *ring,
 	return queue;
 }
 
-static void fuse_uring_stop_fuse_req_end(struct fuse_ring_ent *ent)
+static void fuse_uring_stop_fuse_req_end(struct fuse_req *req)
 {
-	struct fuse_req *req = ent->fuse_req;
-
 	/* remove entry from fuse_pqueue->processing */
-	list_del_init(&req->list);
-	ent->fuse_req = NULL;
 	clear_bit(FR_SENT, &req->flags);
 	req->out.h.error = -ECONNABORTED;
 	fuse_request_end(req);
@@ -685,16 +681,16 @@ static int fuse_uring_copy_to_ring(struct fuse_ring_ent *ent,
 	return 0;
 }
 
-static int fuse_uring_prepare_send(struct fuse_ring_ent *ent)
+static int fuse_uring_prepare_send(struct fuse_ring_ent *ent,
+				   struct fuse_req *req)
 {
-	struct fuse_req *req = ent->fuse_req;
 	int err;
 
 	err = fuse_uring_copy_to_ring(ent, req);
 	if (!err)
 		set_bit(FR_SENT, &req->flags);
 	else
-		fuse_uring_req_end(ent, err);
+		fuse_uring_req_end(ent, req, err);
 
 	return err;
 }
@@ -705,13 +701,14 @@ static int fuse_uring_prepare_send(struct fuse_ring_ent *ent)
  * This is comparable with classical read(/dev/fuse)
  */
 static int fuse_uring_send_next_to_ring(struct fuse_ring_ent *ent,
+					struct fuse_req *req,
 					unsigned int issue_flags)
 {
 	struct fuse_ring_queue *queue = ent->queue;
 	int err;
 	struct io_uring_cmd *cmd;
 
-	err = fuse_uring_prepare_send(ent);
+	err = fuse_uring_prepare_send(ent, req);
 	if (err)
 		return err;
 
@@ -777,28 +774,22 @@ static void fuse_uring_add_req_to_ring_ent(struct fuse_ring_ent *ent,
 	fuse_uring_add_to_pq(ent, req);
 }
 
-/*
- * Release the ring entry and fetch the next fuse request if available
- *
- * @return true if a new request has been fetched
- */
-static bool fuse_uring_ent_assign_req(struct fuse_ring_ent *ent)
+/* Fetch the next fuse request if available */
+static struct fuse_req *fuse_uring_ent_assign_req(struct fuse_ring_ent *ent)
 	__must_hold(&queue->lock)
 {
-	struct fuse_req *req;
 	struct fuse_ring_queue *queue = ent->queue;
 	struct list_head *req_queue = &queue->fuse_req_queue;
+	struct fuse_req *req;
 
 	lockdep_assert_held(&queue->lock);
 
 	/* get and assign the next entry while it is still holding the lock */
 	req = list_first_entry_or_null(req_queue, struct fuse_req, list);
-	if (req) {
+	if (req)
 		fuse_uring_add_req_to_ring_ent(ent, req);
-		return true;
-	}
 
-	return false;
+	return req;
 }
 
 /*
@@ -806,12 +797,11 @@ static bool fuse_uring_ent_assign_req(struct fuse_ring_ent *ent)
  * This is comparible with handling of classical write(/dev/fuse).
  * Also make the ring request available again for new fuse requests.
  */
-static void fuse_uring_commit(struct fuse_ring_ent *ent,
+static void fuse_uring_commit(struct fuse_ring_ent *ent, struct fuse_req *req,
 			      unsigned int issue_flags)
 {
 	struct fuse_ring *ring = ent->queue->ring;
 	struct fuse_conn *fc = ring->fc;
-	struct fuse_req *req = ent->fuse_req;
 	ssize_t err = 0;
 
 	err = copy_from_user(&req->out.h, &ent->headers->in_out,
@@ -829,7 +819,7 @@ static void fuse_uring_commit(struct fuse_ring_ent *ent,
 
 	err = fuse_uring_copy_from_ring(ring, req, ent);
 out:
-	fuse_uring_req_end(ent, err);
+	fuse_uring_req_end(ent, req, err);
 }
 
 /*
@@ -840,16 +830,16 @@ static void fuse_uring_next_fuse_req(struct fuse_ring_ent *ent,
 				     unsigned int issue_flags)
 {
 	int err;
-	bool has_next;
+	struct fuse_req *req;
 
 retry:
 	spin_lock(&queue->lock);
 	fuse_uring_ent_avail(ent, queue);
-	has_next = fuse_uring_ent_assign_req(ent);
+	req = fuse_uring_ent_assign_req(ent);
 	spin_unlock(&queue->lock);
 
-	if (has_next) {
-		err = fuse_uring_send_next_to_ring(ent, issue_flags);
+	if (req) {
+		err = fuse_uring_send_next_to_ring(ent, req, issue_flags);
 		if (err)
 			goto retry;
 	}
@@ -933,7 +923,7 @@ static int fuse_uring_commit_fetch(struct io_uring_cmd *cmd, int issue_flags,
 
 	/* without the queue lock, as other locks are taken */
 	fuse_uring_prepare_cancel(cmd, issue_flags, ent);
-	fuse_uring_commit(ent, issue_flags);
+	fuse_uring_commit(ent, req, issue_flags);
 
 	/*
 	 * Fetching the next request is absolutely required as queued

-- 
2.43.0


