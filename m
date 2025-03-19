Return-Path: <linux-fsdevel+bounces-44450-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D17A6930F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 16:20:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41C558A4664
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 15:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D85DB1DDA39;
	Wed, 19 Mar 2025 15:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="tLzgdU94"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip191a.ess.barracuda.com (outbound-ip191a.ess.barracuda.com [209.222.82.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36EF536B
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Mar 2025 15:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742397135; cv=fail; b=TyDGeENtJeqOiyfvBaGAxfjtmVkavOqWcvs7GwY1hwpaWzYAhGW4deXi+lVnGNeixTSG2glq7y9X3LYRRHycaDpBvOle9a9z6iTpGKCclL0WnSOlHeC22nYHBH7rb/gMpcizboitHber4zkLAxNaV/rocYvldwZqIf5ZBQRQDTY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742397135; c=relaxed/simple;
	bh=KVB8pk6lpypMTWJdc3MYy2au+sE0ewYLr4HMBfSRvMs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gJiIQZMSKuYlOPdCuAH64yf55wUvoPJj83/kvLkUvuMpwNAEloFhhoGm5SDc1Cc2vi9GefwPq93mbQMmfX1xqSs/bcJ80RQk5TDjtHzrrkGibi+so5IJKUWh3+I/yanR1BqKAMiHoxt6anJMUiqugDexLoZRlPgsWzjy89qBUQQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=tLzgdU94; arc=fail smtp.client-ip=209.222.82.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2044.outbound.protection.outlook.com [104.47.70.44]) by mx-outbound10-195.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 19 Mar 2025 15:12:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SwG0/TogVzuJEB4+jk6HN0mN6HmHkLb72zOt8axS+qdXENyaTiJL4ZuONhjLmYlv3OzSeRyBi6mF6aBJxcHjAfHAWQeDhD5TmJQNBd4EqiZH5w+9k7C57svZ9/Ds+UQ7PI1A76urHRwxErz3wxUsBw0X08clknJfHzkXpuc6G68huoXLW1UeiD0hrdyEuuh4WORjnXHEn74+7OdSTtHaFU7XeIaPF5aUOljHHq5jbzwqGcK8NrwiudeFDCavilrbmB6OK5fQdq3mOw27Dp2Ck7zw3CZPjMqhw1GCDOY/+Vg9AOPQj7vesnDMOYAyy7mRZFHGVzWvGv/7Xb56L1YD7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HXT0Y9GR5OQW7FrVy+z+ODD1u5IEv+oZhyIDdC3YdeI=;
 b=WYUsIqJKwqHUL6wpJuClRODlr0B246Y03ViqkAuHzEMjllJP7WKpdUv0uOGizP2rBc4jYel0I44gdWuQqCCipDBIR1ZWiGtrNVCjmSlsYqMaYiTplUpY0vEtN/PN+XNVddtfiGZKQEA5ltONctzpWQtxEY0yWeFO+kvZGplYDZPEDuXjTgME/cdlG/b09XcdheikxltZGFVuiurV0qM7zkCP12kNYhKrjSVcnzTLbb2+eThgWC2kUDD6DI9QcAo9tZoYR1DuIbmQnzXo+Q4zuRowHIzpsFCJWM1ZhTmh214UwwHD9U1ZCiECzKiSnVcinTtucMEgM1eDnmYtr5XOSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HXT0Y9GR5OQW7FrVy+z+ODD1u5IEv+oZhyIDdC3YdeI=;
 b=tLzgdU94TwpegQ6Op0vpYRV3orxCQ4hFfqraHZrYTYl9EZpbx4aDyzrY/fICyBXyERzt/Edc6y9FrVK5jwo/XjpqfRfVUBt0PbTdd2Es6ild7/ZyDPRnftwWj07Ji+4ObI9a0CW9+BWI4vlgqg2UpXql/f9RHw6zi4KkrkK9QIU=
Received: from SA9PR13CA0005.namprd13.prod.outlook.com (2603:10b6:806:21::10)
 by SN7PR19MB6587.namprd19.prod.outlook.com (2603:10b6:806:271::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Wed, 19 Mar
 2025 12:36:51 +0000
Received: from SA2PEPF00003F62.namprd04.prod.outlook.com
 (2603:10b6:806:21:cafe::c0) by SA9PR13CA0005.outlook.office365.com
 (2603:10b6:806:21::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Wed,
 19 Mar 2025 12:36:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 SA2PEPF00003F62.mail.protection.outlook.com (10.167.248.37) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.20
 via Frontend Transport; Wed, 19 Mar 2025 12:36:50 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id EC2064D;
	Wed, 19 Mar 2025 12:36:49 +0000 (UTC)
From: Bernd Schubert <bschubert@ddn.com>
Date: Wed, 19 Mar 2025 13:36:34 +0100
Subject: [PATCH 1/2] fuse: Clear FR_PENDING in request_wait_answer
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250319-fr_pending-race-v1-1-1f832af2f51e@ddn.com>
References: <20250319-fr_pending-race-v1-0-1f832af2f51e@ddn.com>
In-Reply-To: <20250319-fr_pending-race-v1-0-1f832af2f51e@ddn.com>
To: Miklos Szeredi <miklos@szeredi.hu>, Luis Henriques <luis@igalia.com>
Cc: Joanne Koong <joannelkoong@gmail.com>, Jeff Layton <jlayton@kernel.org>, 
 linux-fsdevel@vger.kernel.org, Miklos Szeredi <mszeredi@redhat.com>, 
 Bernd Schubert <bschubert@ddn.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742387808; l=911;
 i=bschubert@ddn.com; s=20240529; h=from:subject:message-id;
 bh=KVB8pk6lpypMTWJdc3MYy2au+sE0ewYLr4HMBfSRvMs=;
 b=sdafUy3Ha7eOsmxOorARK24p81L7Jd9oyl+NqGoLIeRSlLwPcm4Idhi1MD+P2AVvBNbEzs/wX
 5NSVy+MwXLTDX3brZWTWt+VbJimEQG2ANHjMv4/ed7/x8BrIyc9oKrF
X-Developer-Key: i=bschubert@ddn.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F62:EE_|SN7PR19MB6587:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b6f1036-9529-482d-d807-08dd66e2b90f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?SGg0RXJyS25IVU5sb3gzM2JWTVg0dFZJdjM1V1dLU0FGMHhHTEZRcXZKTGR4?=
 =?utf-8?B?OFU1VXdhbk5wd0t5QU1JRHp2YlNMWXY0K2dWNTZ1RE03SG5SSTdlSk5iUkhY?=
 =?utf-8?B?eHJ3Mi9lMTU2bTU5ZUlQT2ZSbFFSMi9nS3VUbXFFS1UxOUF3S3VobkgvdWkw?=
 =?utf-8?B?YysxWE52YXJxRllyZTVPdzlHQmptUDJpcmdybVlrMUMzNE1hNWlsN2t2amN4?=
 =?utf-8?B?MnV4V0k1eDZWU0tpQ0d2SHZGVThJdGpIcnEwZGFkTEMwNzhmWkxGNUhZTjMr?=
 =?utf-8?B?U3dBUWw1SWZyVHpnbkc5eVA0M3N2aGVKZklGMFRKWENNMFZTRzZxbnhNaVh3?=
 =?utf-8?B?WUNlcTk1citPWXFDQTA3L1J4cWVoWHNvVzhhVHdQdEkzRHBKOE03SGxVbHEx?=
 =?utf-8?B?VksvYTRRUTZGaEdOZFcyRjNOUjBpR2ZtZ3U5aVFsRHRPaVZlVEpCdStQL1lU?=
 =?utf-8?B?NktQNUFoZGFESVE5VzVCWGxiOTc3YUNFT1pEVTZjSkw3ZVNXRDBNYndCTjdq?=
 =?utf-8?B?ZGdKQVU4bmFZRWZ4ODh3N0dnOXQ0MnZTZW5sWkY0cXFXcnhYelFJUXZIS2xp?=
 =?utf-8?B?S1B4bDBjRHVFN05DQTQ1clI4cGJQS3dmK2NTZ3V0Z2g2M1RFRVg2SzBaN2dS?=
 =?utf-8?B?WVAxZjRMVFp1elQycFFzaDJFOEtpQ21Vbitld2pYT2pLWVd5NitHWmR5Umpi?=
 =?utf-8?B?dm9wYXYxSmdYSFpzQ1F1YlBQL0NzVjVlYTdMMnRkZW1aM2ZHeWdXTEMydTJD?=
 =?utf-8?B?WTdnV1RxclYzZno3c0hQdGcyenM5N2wvNG92VjQ2M0hHZDd1SXNuRHZRV0Jw?=
 =?utf-8?B?UTcvOVVsZ2FCZHVoKzJUTXgxVEhVcnNRVnMrNEVkUUt5c0h0R2NPeUkzb1JV?=
 =?utf-8?B?RUdtUFAwbGgvTlhGc0xtRURuZWN5UktKY1J0T09FZURnZTNFTGRNRVN2MlhI?=
 =?utf-8?B?OW03cWhJbU15K2dzMW5kOCtSM0VDQXlvZEVvUTdMbnFWa3ZYU0hLN3BkOGNs?=
 =?utf-8?B?Y09TN3JvVi9HcExiYTdIdHQyRkZGN0VoOFJQOWZJZlBxMkc2eUlPckxRUG5z?=
 =?utf-8?B?cytTZkhnb1FMaDdQMmkxVHZNUEFnTHJEQUFVa1VsaGt3b1IyRWJLVEZxc1NS?=
 =?utf-8?B?Y0kzcUJ4UnN1TnYyT3NpZDhWK0tFc3o4TDZmL0dEYzFOTnZKckh1ZUs5MW9G?=
 =?utf-8?B?ODFWTWpzSVJJM3Nwa05BZ3N4WkcwOWpzMGkwRzQ1UklsQVNkZEJqRG9wK0VH?=
 =?utf-8?B?SzROVGc3aWdGbDQzT1FpbmVxbGgxV0JnMXkraitFQUJTNzdFZWJheEdTOG5N?=
 =?utf-8?B?SWFrNURFRFFNRC9HMHhibS81STUrTjl3MmtMMndNQlpSVW83SlFydWlXcnMv?=
 =?utf-8?B?RDFmaHdxd3ZsbERQb1VEY0p0NDBROFJyTmt2bW5JZDhocUtGZVN0TSs5ZExD?=
 =?utf-8?B?aHZpUW9GVEo1dk4xcVBBTHZMSzNjUnFDUUN6dStLQUhUQ2ZCQ3UvUVRWNjIw?=
 =?utf-8?B?SFp6V09BUHpBNGd4TXZhTExBMkk0dlBlcmoveHpaSG1wOFdtekFBRy9CWlMw?=
 =?utf-8?B?dzAxQmJ6OElMOWFMcU1oRDFuQWlkMXJLbVkxWGNSUUdBdDk5ZGFUeVNIV0J2?=
 =?utf-8?B?NDhRdm43TFM1RXNpT1ZGTUlhemhYQndxZWpJV1crWHhmMFpHNXl2M1cwemxl?=
 =?utf-8?B?dnhIWW9wSVB1dGpvTEZuTW1ERFl2NVB1WkJybFNCWE9GdWs3cUpKUjQvczBG?=
 =?utf-8?B?bDVKQTIxeUR1S3ROVmxaUy83dmU5K2w5NkxWQVVYQ0lSY09rY3FTVkZzaGg2?=
 =?utf-8?B?azZidXR3bnJkU0oza2tiemJtWTlNY0MvMkRISFFnSnFFTWl0cWM1SmJMTUxm?=
 =?utf-8?B?L1h1c29rZGpjTk1wM0FDSjZDTWNYWVkzT0ltT1Vza3djNyt6dHcxUldjVkRk?=
 =?utf-8?B?VnBnMURCZTNaS1VocHVURDhlVUgwVC92OFVIOFo3TVlNWENwbFNEbUpEa1R3?=
 =?utf-8?Q?38YakBO6E4UAbGvUqXswyRtpTRz1+E=3D?=
X-Forefront-Antispam-Report:
 CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
 e+zFQ7xdzTOlsjJCMU4IN2v3NTjtw37jPD6P+bm1VqxX4PcK/AfQgmKb0POTk2NJ6ChAijrx+sYhPc7VemS8369+vZr94yiwJIETnSgc1D9Va1nRIhxxeOmE81Z+tx/SIRGw1xOKIWZ6UdZ9i8ReFhaCsYuzrlPfY4TDluhuxs1oU+MX4aOP14KcAZ3r1MFKl2qunCDTZ8yEvDNMmKbmqYhIh8BQgqRWGNzGaV/1B8TSBvudyXaVXVlrAdD/YLU6HUCDX7yPlZA9bErMIfkjv1ouWU2yxarFLzLx4bBA54Elfe/ct+srcJ9wfG1Fn9McBeW5OutuofEu/tPwRIIzWFCV33RxHWOeIVMukM7VGNdeUUwr7xySZxlu+t5dpb0RVnibik/x52T8ZFUjoyVpacaDwCxhkjXn5A/uwvJbNc3ABl4rTqQihBSmf06UudsM+qPo/+BZclXhcDACk5drRQ3q8i5I3AjlvTMHPK1KSVE/gIyf5LVQHBs+pHsG27o9geybNy2rGmj7G3H21WZmCT2ZJOKKdvA2S8rzkCi94FEsLTJK2mk2FvwUyn81DRR2rzh2GiHx6ONuqweXn/BBhUc4Y/C/dgtKhjgDS/k6Tlp3Rm0IDkYqMV+rmawdH+6/UwsymnJhFUjvXEwROksfLA==
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 12:36:50.9162
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b6f1036-9529-482d-d807-08dd66e2b90f
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
 SA2PEPF00003F62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR19MB6587
X-OriginatorOrg: ddn.com
X-BESS-ID: 1742397130-102755-15474-2094-1
X-BESS-VER: 2019.1_20250317.2316
X-BESS-Apparent-Source-IP: 104.47.70.44
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVhYWZkBGBlAsNSnRzCIxLdUyxc
	wiNTUtLdnC2Mg42cTSyNgkzTTFwEypNhYA+hB19kAAAAA=
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.263269 [from 
	cloudscan9-86.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

The request is removed from the list of pending requests,
directly after follows a __fuse_put_request() which is
likely going to destruct the request, but that is not
guaranteed, better if FR_PENDING gets cleared.

Suggested-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
 fs/fuse/dev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 2c3a4d09e500f98232d5d9412a012235af6bec2e..124a6744e8088474efa014a483dc6d297cf321b7 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -438,6 +438,7 @@ static void request_wait_answer(struct fuse_req *req)
 		/* Request is not yet in userspace, bail out */
 		if (test_bit(FR_PENDING, &req->flags)) {
 			list_del(&req->list);
+			clear_bit(FR_PENDING, &req->flags);
 			spin_unlock(&fiq->lock);
 			__fuse_put_request(req);
 			req->out.h.error = -EINTR;

-- 
2.43.0


