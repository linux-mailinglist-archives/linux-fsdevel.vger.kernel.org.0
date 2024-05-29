Return-Path: <linux-fsdevel+bounces-20471-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4212E8D3E6A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 20:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 629651C2140F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 18:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D7DE1C2310;
	Wed, 29 May 2024 18:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="e6EcmiMt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip168b.ess.barracuda.com (outbound-ip168b.ess.barracuda.com [209.222.82.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9910115CD55
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 May 2024 18:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717007668; cv=fail; b=JS7R5NPxfkDfHzzrwf0QUU60yPrJnxZR67YxtN1qvSVUdTpplwA85hcmky5FCTpD/u8D3aAwizRvUZpF3msFB0emAXDKpRW/72OH6evkcfM/uREtVWTHU3tJg5487CtBb7wvabPe0Vm4y7XsQrzK1yU9BTLyqvw3EhvNPaP2tqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717007668; c=relaxed/simple;
	bh=4k8YX2uhmq6NNHqAE1xe24NaFCdx6sUL+ZTYCqUjITQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=rMg3ZJUXK1znpIbU4lY81Jw9xLlOa6L+xiWJsce/qAw4uk73UDxgFJYH9bnJWhJRA5zbgQUiABFyxZUw6cmywYhBJR9M4ACQiQpk0G55/VDx1dT9KBd2sw7/eE5F47gnT8OVk5vB1xQlX1aZHhZH9xWxmRFJdmduiFxROcxm2JM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=e6EcmiMt; arc=fail smtp.client-ip=209.222.82.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2043.outbound.protection.outlook.com [104.47.55.43]) by mx-outbound16-229.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 29 May 2024 18:34:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dV6tjiPPoODNV7dDhwHNxpdlS5Vj/dYyxIFyW1u7PudQ1bFJxsiNataNC6xMEUc+GLyB2EbEuV+1OEK0JiGGuBI1Uf1GukmUNDU96M4MmYOtSFqXt7O3QFjpE2x9XOV45B3yHsw4tcPOSAPCo7QDWcgOXGjhhZzzpUzCEjz6V/Xx2SKooATCiheGI81U2xF2VTxhOrRTGxzSPSbqjZt/W7npxU8VbrmUbDhUvDHge/hfpwbjjinEt1uX5xnNEhrYieRgSAdhqKrvh8q0HpgW8vudjMC97IG2TMMnrVOITNcr7iw9sWNy5iQjRoKW+sJ9bAXXe6cNVDw6DMa6hqwusQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wgOGu34MpTstBJAxRXm1ROFLuPZmdBBRewx3OfzSaKU=;
 b=a1Gz46GeFPfgnYyD1an/IkvbSc9FTDUerIHigUprH/lu/JZnmmwgd3utAi8QUtx+mfH4Ny+dA80hsjDMG5pt1l/etxNu3ABinOWxUrMtAK8HTAkrvBiR3HxN3lHMyKaZSOv0+UKZxZ/Vb2N54myrStMfWZi2UvvZmTFBvaw4AJyOUnnk/1TqzTUnLUvhpenO5PcFNYZB/JmuRnGECkl3MrPJ5L56a5caja8rkHHgAchs6ka7XWLeWAw/p0epC+lao9sUcmz8sPfIEjf0YwIMtpchqRVW7Qxrbe/TQ2U7BhWVQrow2aM+7KVMD83kTBsATFYU0hKmlFRsmkGCnaE53Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wgOGu34MpTstBJAxRXm1ROFLuPZmdBBRewx3OfzSaKU=;
 b=e6EcmiMtynTxgSizlrilaynOhafpzWUq87CpJyhDtzJs4Pc1YMP0lwIx0KcwPLApSAVkYzWIJ5bbULBo/zChX6feGKQ1f21ohQ9FRFyBOaPE2GZ8P78OpEjwFsqnQz1gV6p/b2bmRQwfOg6oweygVNz2vxomoDUn/Ef/shTSbLM=
Received: from BN9PR03CA0808.namprd03.prod.outlook.com (2603:10b6:408:13f::33)
 by IA1PR19MB6524.namprd19.prod.outlook.com (2603:10b6:208:3a8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.19; Wed, 29 May
 2024 18:00:52 +0000
Received: from BN1PEPF00004682.namprd03.prod.outlook.com
 (2603:10b6:408:13f:cafe::36) by BN9PR03CA0808.outlook.office365.com
 (2603:10b6:408:13f::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30 via Frontend
 Transport; Wed, 29 May 2024 18:00:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 BN1PEPF00004682.mail.protection.outlook.com (10.167.243.88) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7633.15
 via Frontend Transport; Wed, 29 May 2024 18:00:52 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id 3668A2B;
	Wed, 29 May 2024 18:00:51 +0000 (UTC)
From: Bernd Schubert <bschubert@ddn.com>
Date: Wed, 29 May 2024 20:00:37 +0200
Subject: [PATCH RFC v2 02/19] fuse: Move fuse_get_dev to header file
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240529-fuse-uring-for-6-9-rfc2-out-v1-2-d149476b1d65@ddn.com>
References: <20240529-fuse-uring-for-6-9-rfc2-out-v1-0-d149476b1d65@ddn.com>
In-Reply-To: <20240529-fuse-uring-for-6-9-rfc2-out-v1-0-d149476b1d65@ddn.com>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
 linux-fsdevel@vger.kernel.org, Bernd Schubert <bschubert@ddn.com>, 
 bernd.schubert@fastmail.fm
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717005648; l=1418;
 i=bschubert@ddn.com; s=20240529; h=from:subject:message-id;
 bh=4k8YX2uhmq6NNHqAE1xe24NaFCdx6sUL+ZTYCqUjITQ=;
 b=dQZVlIdsu9gDX1ijkm9ihfHbc6liz4BULyR22YA8vWCSUD4U5wxFypaQ894tbpUmb7WzGzsUQ
 oHOPTOeZuoNB1YoHCTVVWb6bGj4jgr0fkybTeS9lvDqrOyL6yiUujtQ
X-Developer-Key: i=bschubert@ddn.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004682:EE_|IA1PR19MB6524:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b000c26-37a8-4db3-9cc2-08dc80094799
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|1800799015|376005|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T2tuWG5TdE12TDJzaFhFUkYxYmdMQ3NCSWpWK1hzeWxtRFlmUEN4UG9vcXJu?=
 =?utf-8?B?a3E3dExSL0VOMVdDWmtkYjJTNTlPMDZYNk1EcGVoekJ4QkI1blpKeUkrNzgv?=
 =?utf-8?B?ZStOcmI1WFlheXMybDJMYjJpYndEemNXdVFVc2UzeklCdkJxUzl0UDNoWGpR?=
 =?utf-8?B?b2Fhc1NEbzkrUmVQTC9uNjVCclowbWpsUnFTdXcxVE9iNDFXTjl2amlQSy9u?=
 =?utf-8?B?ZENJMlQzbCs0MGIrbDhVZC9PNTlETDkzcVY2dTFpOS9RNFhVanM4cjUyV0oy?=
 =?utf-8?B?N0JpR1dsY0FDbTMzMHgrZUZEMVYwWEl6c1IxR1M5aUkzeGp1NUE1YmJIN0E4?=
 =?utf-8?B?RkcvdHV2QjFKU2cyckh4WnN3QzFNSjV6ejJtdlRMU2JGM05WMmVZMUhTeXFE?=
 =?utf-8?B?TmJ3ZUhZQWRQYVVkM2RPMERCWVRnQUIrQWk5Z0k5WFRCTTMxcy91bHE4Tkkx?=
 =?utf-8?B?Y3BqbXdBTk9CVGdhdEFPcnY5WU5sRVRmSVUyZXN6cUpzUDZ2WTJQcEU4UnMx?=
 =?utf-8?B?NEZ3ampxOWFJWVFwTEE5TXQ4L0Z0aUN2WUJkcWJ6ejJJQk1td0dkNEcyNVVY?=
 =?utf-8?B?N1BsSVhSM1RtMVBYOVJoanVQa3JscFFtaG4vOEtHd29NczJFNDZWd1ROMDFF?=
 =?utf-8?B?UzdlZUxaTjJwNldsK21aSEZaeFNhYWtpWVppZ25uaXJsa0lPNUZzMDBUWTNW?=
 =?utf-8?B?ZkVYYXVqMFQwOTRqVzNPalZwU0k0Z3dTc0xPcGVmUVBRaUQrQjBrNUZCakxG?=
 =?utf-8?B?Q003OERsd25UWkFUREZRMlZ0eXB2bm84RTU4R1hzbmoyVXhYSjhKWnNQWXFL?=
 =?utf-8?B?TDBENDAwUDY0VDVMcG5MNG9KQ0VoeFZrcDVnT3FhaVlTWEY0RzhtOTlaRW16?=
 =?utf-8?B?ajRkaldCWVFVNEUweW9NZnZBdWpUZEpRb3p1ZXYrN1FkWmtQbnozK05idUl0?=
 =?utf-8?B?dnFqa0dqVWlob09ibTVZcUF6WTBHWi8rZHpXSU5xaXNEV1pySjNFZFpaUE9r?=
 =?utf-8?B?U0xIdHBIeDRLSWFUcGRpdXF0NFFDSWVicTQ4d2QycGpRSmFoTEJpakFBNjBK?=
 =?utf-8?B?V3VvYUFPR25GbzV2TFo4Nk9DZy9pWG9ZTFFaY2dRNnAwWHdIWEE1NCtaWWdU?=
 =?utf-8?B?V2sybHloT1dOemRmK2xwQlRzek1MeUVydG9vc1VSNGJIVzdnakJJZ3NEZnBX?=
 =?utf-8?B?ZzdLS2RZMDNndnFTaElrWXk5bGVxZE5sMjNwamxQMmRDTnhVelJ6L0p0RnR6?=
 =?utf-8?B?cC9HQitDOHdxZWc1UkhaTFJiQTdKRGtoRW4xbkIrbGdQMmRZWjZ6dVpVVXNs?=
 =?utf-8?B?NzFIRlFaVThLY1dWczlIN0VOeUlWVzdJa2lxVDdBU2sxSk13WW51cGRZOFBh?=
 =?utf-8?B?RVR6M0tHeFhtczIxS0kvVDBDLzJ2UmsyZ0tQaDArWWxRdHpObTlSSjlxcmxv?=
 =?utf-8?B?OGZldG0wZ1hKR1RubnE0ckNpaTQ2emlDTXA5N3EwSTFQM21Lc1hiYlhjNndY?=
 =?utf-8?B?S3gzWlFDZTl6QXRlVTk5RHp6cEZ5bzM3enNuMXAyMzB2dzhVS29ZZS9KcE9Q?=
 =?utf-8?B?ak1yRjdPcW1YVGRwM3Y2bkxoalhkcGF3c0lGRlBiV2tBMUV2Z0pBc3ltK1Vt?=
 =?utf-8?B?SjN1QjRRZ3RnV3JYb3o5TGRNaUlmdWxhMkUrUUhQbzdpYXlVN2F2a2tkUkt0?=
 =?utf-8?B?S1F2V0hOcXBZYUtybDNjWE1IRVBqWjNEY25WMit3N3VkMjBsL0Mzb2xSazh0?=
 =?utf-8?B?M2l0SnRxWlBtL2hYYnl0TmpFckxMZlZQN0czc3RmRnpMSFFlVGxpRnozYy8r?=
 =?utf-8?Q?9kLL+dacAS400PuAOk5bcXiG4ttZ8ImP1cKbY=3D?=
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400017)(1800799015)(376005)(36860700004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	HeQ9JodxLkcj7R55VkCC/gGkAtwoCknKLq3LFMffzjms6iIiW0tNHuIgzMGrZ1WqdE4AXKSRvn9cUZn8OCFe+EDoynLi29Xguoh+CZ6SNDyVM3XrhzLKwD+9+KBkKMUKgegj1EIr71s8rjWksuphHbv3l8ZBHs0WWF+6eP2NfFEW45RbxM8EdknpFzfsXEZo0r52EIcmB74lxPAkwszG7gfnh2aqngPXgAV6EL+yTMiVMSYWDKIMBDYNI77Vcul7VdnO5BM5iFbTRNxD2M1ebPdTRsriN3wTsjWBn06BJqTdyM9a95kGnRi8TNomrF9TnIMFZkBQuyHmypn3qNloo7knUb1JEHH6cZ+ePo7/z4zpxxGzKV+j3x2y7CKolAd1+Pd5YsUF/mcK45cXlJg9tQ1yJczG7jhPsx7O5B2bL29UXMRPFGEa7GrEQAEUdUA3POPbiHephPs5boJiOnqDmjLrBLsQ4EePV4LAPrbOwNYOruo/9qOeKW3DTGRo35Ma7hCuII74P8YhhrFq1oFoeQBgv16Xz+ZHmP1LodqXxVc2DxfIBdGIprhSk0RzZ4pkm/PtHqJu9FVQ37NhVZcqpeqBkGh93lFkpSRge5mklMQ2o8mNKzzkK8UO2hDYH9wORa00rdBGe/53F3tttQ2hoQ==
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 18:00:52.1109
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b000c26-37a8-4db3-9cc2-08dc80094799
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004682.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR19MB6524
X-OriginatorOrg: ddn.com
X-BESS-ID: 1717007665-104325-16135-2858-1
X-BESS-VER: 2019.1_20240429.2309
X-BESS-Apparent-Source-IP: 104.47.55.43
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVobGZuZAVgZQ0CDN1NDcOMUgxc
	TQ0sIkMdkoLdHcwMQyOdEoxdAsKTlVqTYWAOLVMt5BAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.256584 [from 
	cloudscan23-4.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_SC0_MISMATCH_TO, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

Another preparation patch, as this function will be needed by
fuse/dev.c and fuse/dev_uring.c.

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
 fs/fuse/dev.c        | 9 ---------
 fs/fuse/fuse_dev_i.h | 9 +++++++++
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 5cd456e55d80..3317942b211c 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -32,15 +32,6 @@ MODULE_ALIAS("devname:fuse");
 
 static struct kmem_cache *fuse_req_cachep;
 
-static struct fuse_dev *fuse_get_dev(struct file *file)
-{
-	/*
-	 * Lockless access is OK, because file->private data is set
-	 * once during mount and is valid until the file is released.
-	 */
-	return READ_ONCE(file->private_data);
-}
-
 static void fuse_request_init(struct fuse_mount *fm, struct fuse_req *req)
 {
 	INIT_LIST_HEAD(&req->list);
diff --git a/fs/fuse/fuse_dev_i.h b/fs/fuse/fuse_dev_i.h
index 5a1b8a2775d8..b38e67b3f889 100644
--- a/fs/fuse/fuse_dev_i.h
+++ b/fs/fuse/fuse_dev_i.h
@@ -8,6 +8,15 @@
 
 #include <linux/types.h>
 
+static inline struct fuse_dev *fuse_get_dev(struct file *file)
+{
+	/*
+	 * Lockless access is OK, because file->private data is set
+	 * once during mount and is valid until the file is released.
+	 */
+	return READ_ONCE(file->private_data);
+}
+
 void fuse_dev_end_requests(struct list_head *head);
 
 #endif

-- 
2.40.1


