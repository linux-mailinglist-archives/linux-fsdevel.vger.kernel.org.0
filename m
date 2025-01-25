Return-Path: <linux-fsdevel+bounces-40114-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2045A1C4B2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Jan 2025 18:44:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 507983A9DAB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Jan 2025 17:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D51270803;
	Sat, 25 Jan 2025 17:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="jHw3cfcv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip168b.ess.barracuda.com (outbound-ip168b.ess.barracuda.com [209.222.82.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9A07082F
	for <linux-fsdevel@vger.kernel.org>; Sat, 25 Jan 2025 17:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737827065; cv=fail; b=BK9MC7Go7rY1MyVdRyaCLBCx51lKXLJ7pou8/u55gPhrQC4vJHRBjO72rFuA9gEVofkfzGv/+2Qop05VGvcx+0wrGlKiZ4DtPgxFIh95f7QC+JQhfApD9u6ucqSkFgTPUFPmSFb7ADjJTmEXvNhIxWjKiMCbGmpUoAhG3DF4HYs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737827065; c=relaxed/simple;
	bh=tVUEcAgMZB2KHZMgoGJo9tEYrFy7s08vwiMoOJ7MChY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b+euejlvWc2zW+X3hCXHH59yTXvx7rh8ub1VDWdUx5zJ8IkMsYOLHg0qOKh1LpBaWr3mkZLDDQidNP3Ux111eWP1h5HQoKE6Onu0WOgKEVpVk/OQP/i3aEyScnFbQZSwtvYfIdCTJ+tcPFROBGBs1NM0PRqCkpRGOPeP+WIlb4Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=jHw3cfcv; arc=fail smtp.client-ip=209.222.82.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48]) by mx-outbound22-74.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Sat, 25 Jan 2025 17:44:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k/J5i5NIrOjKrB5TDkB0XVcHjZsAuJEl+o3fHyDJrG3/Ar2AbtopXU9kAu067NfwQXsBatRUutZjBciJW2Dc00nrp2qFcis8R/2yhKBXjBvLvHHHUeQGo2PL/UsC6vTZxm24aZaniN3ZIySq4+UJBpWAzNQK4KGhlD0YLiqlblJcPfkt+Z+V1ORjDywFu/6nNVyr/8nOtyLp4/EKmJGUste6pOEOd2X7WA5RcqhhHFOtlCvoddx6bDQwXMbLdl6Yd2jxTv7SA4F8PQg3CG3NKMBr4PXWNcN/kmcDagZIVhc6mzDJSEDH/zW4O3pgsFEUeNSQuiiJPfskcvclR5YREw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b/iXpWnfn0Z6SpnLTP32PQZC1OJh8QXNfKeYypUO30E=;
 b=dyuOXWymd22Szcftjk8zj1qvNl2wGS4egLxtJyuGnA8eqFfwQJAkV3I9P8KZVEf24whUZhTCqby76zLK0086uR87htNKU7sN05rcydTVZk7bNr+neOWuRSoa5bY8lBolEhh/UfT78efpxb7nmafTtNJhSaVn7GGFIFN7C3AiR40ctJzFgHsWwikXdjzdGzTfB9UvgRBoCY+bpHIeo6fYq25p7mELeEDRskU/s1ddY1/YGxP1Jlkeh2CcijCdCcTAvKtkL7/xPuz4lRq2cu6R/z9w+ZXTOHwM/5sLDUmcrBmBs/a+ot4/9lT/AJRAY5iwVcEdsoDU/rGFg9IsW60uxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b/iXpWnfn0Z6SpnLTP32PQZC1OJh8QXNfKeYypUO30E=;
 b=jHw3cfcv9YyAT1IoKrNK5irhq3sFlZyXD2VlcAJ4wDKB55u+T5dtPsVbf4etk3vz9Rilold4Aptp8iQyinO7Uj4HdlLOLHYuzEtK8X8xEyk/wDBT89XpJWuXT81iKLvjJmIxYwDRZKcjizSGv9TYoO+SIhqVMgNATrVXO5sFOuE=
Received: from BN9P220CA0016.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::21)
 by IA1PR19MB7661.namprd19.prod.outlook.com (2603:10b6:208:3f2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.17; Sat, 25 Jan
 2025 17:44:07 +0000
Received: from BN3PEPF0000B06F.namprd21.prod.outlook.com
 (2603:10b6:408:13e:cafe::d9) by BN9P220CA0016.outlook.office365.com
 (2603:10b6:408:13e::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.20 via Frontend Transport; Sat,
 25 Jan 2025 17:44:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 BN3PEPF0000B06F.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.0
 via Frontend Transport; Sat, 25 Jan 2025 17:44:07 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id 1621658;
	Sat, 25 Jan 2025 17:44:05 +0000 (UTC)
From: Bernd Schubert <bschubert@ddn.com>
Date: Sat, 25 Jan 2025 18:44:01 +0100
Subject: [PATCH v2 6/7] fuse: Access entries with queue lock in
 fuse_uring_entry_teardown
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250125-optimize-fuse-uring-req-timeouts-v2-6-7771a2300343@ddn.com>
References: <20250125-optimize-fuse-uring-req-timeouts-v2-0-7771a2300343@ddn.com>
In-Reply-To: <20250125-optimize-fuse-uring-req-timeouts-v2-0-7771a2300343@ddn.com>
To: Miklos Szeredi <miklos@szeredi.hu>, 
 Pavel Begunkov <asml.silence@gmail.com>, Luis Henriques <luis@igalia.com>
Cc: linux-fsdevel@vger.kernel.org, Joanne Koong <joannelkoong@gmail.com>, 
 Bernd Schubert <bschubert@ddn.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737827039; l=2456;
 i=bschubert@ddn.com; s=20240529; h=from:subject:message-id;
 bh=tVUEcAgMZB2KHZMgoGJo9tEYrFy7s08vwiMoOJ7MChY=;
 b=ubCRTsAI1ghuEtn9sCbw50Nz5PoxuQrJSzVW962pvVzInlwyhg1QD5NXXQw7B1i3EgClYdaKg
 QkrJqsKxksKBMxAwH3Bsn9neBGRgx+gBn9m733OLyyfQsgcuk/kq9Vx
X-Developer-Key: i=bschubert@ddn.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06F:EE_|IA1PR19MB7661:EE_
X-MS-Office365-Filtering-Correlation-Id: 21d709f3-11e7-4e9a-3cb4-08dd3d67de03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YitiMkxzdk01SUt1b0dsaThlSGtUMkduQVdQbFlvWlAvQlAvaEZ1VTBDdEgv?=
 =?utf-8?B?elpJK1FyRjAyV3FBdU13ZTR5UFFqRVoyMTU1c0pUVWJTZUdDNjJ3TEhWeUZi?=
 =?utf-8?B?eVdPZDFJaFdoMkRxaUxha3RtZVVId3AwYlNuTGZEY2pKbTlRMFA2VWZEV2Yv?=
 =?utf-8?B?dE1xSmMyaW9RR2lUMkt0aStLb0pmdUdFOUtKWXQ5SWh5cEExOGxGZkRZVU1E?=
 =?utf-8?B?T01IMEJEY0ZodC9lcXhuWStSd0FZMGtidHdlaEMwQmhLL1pYUUZTV2Vrb2NX?=
 =?utf-8?B?RVhuc3poS1Z6c1g0RmUxTWdERVZlNC9jeGtNVWpOTnlsN25tL2RHTHF0YmR5?=
 =?utf-8?B?ZUNSOWVvWklrbjFjc2lLaTR3ekpNSkVFSWk5MEFFM01QdG84MTFGNXZWTy9i?=
 =?utf-8?B?VUdMR0wxN3BZTVF6SFprV1FFNHh4Tm1wYXFrY0NoaERsMXNjQkdJTU0yVFQ5?=
 =?utf-8?B?dWUxYndIMFZuLys0c1NUZ1ltQkw1Lyt6YWNKK3M4Z2dPZzNsN0tab3MySEt1?=
 =?utf-8?B?VjFkT1lkVWpnRlk1LzJDdWhOdmx1eGw0eFQ3VHYrZkR1YkNkdklITnJCRlVy?=
 =?utf-8?B?UHpzWVdFOC9XUEdReHhnQS9jbWt0eHFwOVJnRElJajE2ZlhzOElkNlNqZEdy?=
 =?utf-8?B?bmhIYmFXaUNyQnR4VXNGNWRHK1prcWcyVUdEWWZaTG5mV2oyanE0dndRTDR0?=
 =?utf-8?B?azZlaTBOQ3ZhSnhHQUVpbmJHS1Yydmd5eTVJWUIxZWxqYXdHK3R6cXVMcVJO?=
 =?utf-8?B?bWI3SUFHRXExbFFPRUdUb0ppWmNwWlBHN3YrZXBQbjdvclZJT3lNSXh2emIy?=
 =?utf-8?B?elk0WmRMMi9XYzM5c29hcGFxK21OU3hTUExiTUxybVdWc1lZY3lxM2hZMXcx?=
 =?utf-8?B?QUUwRXY2YndrbHdxUSt2QXdXUEtFT1hTWGpRcFRvVmJpajJnbUp0Q1BPZVQv?=
 =?utf-8?B?UzNNU09QOUZSdEx3L3ZPdUMxUXhCK1l5dXphQmttSWg3MTdNYVV3cm5HZGh1?=
 =?utf-8?B?TXMyVjFwZGRaMHRDR0NkaDRRZW1QNnZKY1prVUpJbUxTK1RNRittbFhIRDkw?=
 =?utf-8?B?WCtVYUxqNGQ5aUtSTDRUQmdpVXhMUTYvREVWanNQb0VSMjE4cnZzRVViRTFj?=
 =?utf-8?B?a0ZQV3RMZEZTNmVjRGZFUDNIRFJDNnNSZ0kyaUN5QTZnZVZrWDZxMHJLMWJJ?=
 =?utf-8?B?MTk2TGdaaWtQbUdjUmdDMHphem12eGszTnliQmI1bzczZTdRbWx3c2pzditV?=
 =?utf-8?B?UFBaclp0dFVMYmE4UWhwSGtTdGd6cUZQVDErSlJrNFRlTVdaSWdmdk81Y29X?=
 =?utf-8?B?RzdYVk8zNUhWb2RlSUhla2ZUOFBuMWZJK0pUdUZmaklXNkplK0dCV3RRdTFt?=
 =?utf-8?B?N2FRdHNTQmswOVBKTGE4Rkk4NDMzMUk5OVdiekVFRlNrd1ppUmNIUjJwK3I0?=
 =?utf-8?B?aUVyeUxvYUNZYkZWTm1pMDV0TjRCQTJJZGtCMm5jeW5mZWxaVWpjV3pCMXY5?=
 =?utf-8?B?dlFlWTcwY2s4eEoxVGlhTFFybExUNk40ZkFvZVBCRnloN3BMTDZFaHVyMFk0?=
 =?utf-8?B?VlBSak16bXZMSEQwVUdUbEZQa2hNa3BFaU8zdkpjZzB5Nm5UNWRrYm9uaHNZ?=
 =?utf-8?B?SnhYeGp4Yis5M2FVcW5aQ3R1blJPNzFmSVEwQTVuMWdhUk5iNEVuQk9NMlgz?=
 =?utf-8?B?WU5oR01GZnN0Z3RmZ2F4WitHRWxBSld0cjRLcVowYyt6MldVM1UzQ210MElB?=
 =?utf-8?B?bFNEZjQ2dXhHZ1Q4QTcxN1BRWmhJeW5CL05Cc2RLNjlqN2hSUjRYVEU5RlJP?=
 =?utf-8?B?REJLNllCSTBabitYQ1I3WDAzTjVwUU9TVGN1bktaWnJyOXU2a3kzM3BDQ3RZ?=
 =?utf-8?B?dDEwdFErU1g5YXMrVktxUHQ3NS9RQlFjTU55QUxKOEUyTkNoVVVJc09ybDBh?=
 =?utf-8?B?WDhaLzNmaTFQU0RUT0l6Z3VMbnM2M09JaW9LVHFIbXZ3ZzZMZWUyZWdpRlJI?=
 =?utf-8?Q?to28uZIRvd5PMNI4mOYvgjVmBTvctw=3D?=
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	iXepg/g3rBJUd70mmq5pR+fJgZAwwVN+Jsukl8KHFatgmdWQyhsUwx67/5SnllTIewCIJnIRlhDh9usniCJQocy6S3gju+kR5YZTj+mqDjnrK0ooKsMs0lW9Q2CXJWsNSM+SMxJjQzPBrkSHJfu6m6zgbxbjWafW8BXCEHbWmLdr6Iov3cRfinFP49helmU17eUaV+31E/xL48xkBHflo2BJcsrexyLEg0YXUKwWqdGXnCsvB6U49e/S07wqc10CQo5JtIJLnBrPNAHXxCKBSqzjBGwURHeMXFqPdD3t2OMELT8J9/3XHdyoIqDHBacej5ecIVreLWBR/m4wlOB4GWGMxC18ibiyf505Ea4igrP8dTODlw45Va8BSNpjDYGAHIYx9I08RvfpHYwTbCuy2aOZM11OQD3FZAKQ5B5RGb+DReE0h7VscfWPDd3vIYwBwclnpCvZ1Lyed9wMdsdQSI8vSjrnYxhOXRyzqyfftUEI19LVPFmJ1qA3uwkZ1gdYQAao0knpYskmIClRA6NspKYWKmLNM/BzTFrym0CCzyimOgwPOo9NphynMupNRktiN0QlKwj/XZPI/j1zUU4ZNSpHoA2yDaxACw+t54VgkSW14+ziz9GtDfoshEsk4X4zHLMLjiaxP86LqD7ZNTO27A==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2025 17:44:07.0595
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21d709f3-11e7-4e9a-3cb4-08dd3d67de03
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR19MB7661
X-BESS-ID: 1737827048-105706-8216-1021-1
X-BESS-VER: 2019.1_20250123.1616
X-BESS-Apparent-Source-IP: 104.47.66.48
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVkbGFoZAVgZQ0DTR0Cg1zSTVJM
	3EJDklycTcwsI81TIp1TwtzSI51cxAqTYWAOMGsExBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.262052 [from 
	cloudscan21-81.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

This ensures that ent->cmd and ent->fuse_req are accessed in
fuse_uring_entry_teardown while holding the queue lock.

Fixes: a4bdb3d786c0 ("fuse: enable fuse-over-io-uring")
Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
 fs/fuse/dev_uring.c | 34 ++++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index e90dd4ae5b2133e427855f1b0e60b73f008f7bc9..9af5314f63d54cb1158e9372f4472759f5151ac3 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -298,13 +298,8 @@ static struct fuse_ring_queue *fuse_uring_create_queue(struct fuse_ring *ring,
 	return queue;
 }
 
-static void fuse_uring_stop_fuse_req_end(struct fuse_ring_ent *ent)
+static void fuse_uring_stop_fuse_req_end(struct fuse_req *req)
 {
-	struct fuse_req *req = ent->fuse_req;
-
-	/* remove entry from fuse_pqueue->processing */
-	list_del_init(&req->list);
-	ent->fuse_req = NULL;
 	clear_bit(FR_SENT, &req->flags);
 	req->out.h.error = -ECONNABORTED;
 	fuse_request_end(req);
@@ -315,14 +310,20 @@ static void fuse_uring_stop_fuse_req_end(struct fuse_ring_ent *ent)
  */
 static void fuse_uring_entry_teardown(struct fuse_ring_ent *ent)
 {
-	struct fuse_ring_queue *queue = ent->queue;
-	if (ent->cmd) {
-		io_uring_cmd_done(ent->cmd, -ENOTCONN, 0, IO_URING_F_UNLOCKED);
-		ent->cmd = NULL;
-	}
+	struct fuse_req *req;
+	struct io_uring_cmd *cmd;
 
-	if (ent->fuse_req)
-		fuse_uring_stop_fuse_req_end(ent);
+	struct fuse_ring_queue *queue = ent->queue;
+
+	spin_lock(&queue->lock);
+	cmd = ent->cmd;
+	ent->cmd = NULL;
+	req = ent->fuse_req;
+	ent->fuse_req = NULL;
+	if (req) {
+		/* remove entry from queue->fpq->processing */
+		list_del_init(&req->list);
+	}
 
 	/*
 	 * The entry must not be freed immediately, due to access of direct
@@ -330,10 +331,15 @@ static void fuse_uring_entry_teardown(struct fuse_ring_ent *ent)
 	 * of race between daemon termination (which triggers IO_URING_F_CANCEL
 	 * and accesses entries without checking the list state first
 	 */
-	spin_lock(&queue->lock);
 	list_move(&ent->list, &queue->ent_released);
 	ent->state = FRRS_RELEASED;
 	spin_unlock(&queue->lock);
+
+	if (cmd)
+		io_uring_cmd_done(cmd, -ENOTCONN, 0, IO_URING_F_UNLOCKED);
+
+	if (req)
+		fuse_uring_stop_fuse_req_end(req);
 }
 
 static void fuse_uring_stop_list_entries(struct list_head *head,

-- 
2.43.0


