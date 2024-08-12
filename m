Return-Path: <linux-fsdevel+bounces-25709-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D5494F619
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 19:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 932241F22047
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 17:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F89A189518;
	Mon, 12 Aug 2024 17:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="I6okfPUZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip191a.ess.barracuda.com (outbound-ip191a.ess.barracuda.com [209.222.82.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72394187332
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Aug 2024 17:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723485020; cv=fail; b=qwVOA6kDjbCBooFpAn5LO8WAUvpzNxdgFgDxXiR4edEoJ2xBxb9X3/AxO8BbSDHBapjK6aZeFq9Xv+GeZpsNp4m24/8CEqOEsmkhhpbUZZ5Yezh/SAHDIiYrTWw8AfLON7+LcItR4Po/F+0TpAP4fugE4avVhbburSoqCRRVQrw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723485020; c=relaxed/simple;
	bh=ZM9Gzat834qZLFmI+qXWuxjYZbAV4BBP21K6sCVgyYs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FvSG88efRju02nYIIy2Q4vTqJQhF9Fy023qVICUBXTXnGER4IoU32tkioHeCMEbQfGjn+PcizKCjsgfrnJi1Pta7DK4cMiGNegpgquzP1khuoLMN9ebxXxiySkeSF5cyXRe9cnqpHqh9mp6YYpkIv1NUzLB8Zz9E6s7uiCeyfwk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=I6okfPUZ; arc=fail smtp.client-ip=209.222.82.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176]) by mx-outbound45-50.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Mon, 12 Aug 2024 17:50:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iIYU7Wizr1V91L7UYjOGOlUizcJ5sWdfL07DUbkFFC3Z0P68+AUG3myv8wZRIRjYiva3kndOvhWGpQmnJt+G3hTmoLZ4RYR0jyPAf/e1CZl1cJP/+75q5XoAmn+4SxyHfGVqupaBj71Def56h4jq4GQHnIfrbGFvczRyjSJJgd3f/ueh44B4l6rCekQNAc6B4C2aRwX0OkAEowamHKmIU/NKKR9Px0Ch5IvLXzYYeZ/ZtIMZVuOPVv9HHJCZ2868mhbNKnMMO3qQTC0OW9OBH1oSsCkfQb70LTQ6NP7uOj4zRNKVFqo35jh0aNrpyJTaQ8Aoh6JZP+Dm3H9LrZIVaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PKxrsm5wha+rTSW/Fx78lWg5zLdUTEaDtAzAiZVjHpc=;
 b=lN64mQaAsSQpoDXw59kyS2eOmAGJvnTnLMae7CjjMVtQEEj+ihwzAzq93wQzdwrjzuU7RPvx6ykjJABXr4vGMeQ/bgTr2gA2mxccn2M7CA7xLi3VEw1ap1TNafRyY3QK/Un+KSRQ77KgafFLKeDbxFt1FlEwDFdzJfXW3M63Ta/18E3t0KT/MOcxD0VXVe6bSOqo67CQxCz9G6Yh47OVK+fg3j70mvq3urr8Jj8raoqIo/BSXRlEwUKwpxJTo7+Sz+TwT+nyn4SyuHLd30aQOx+to6g2/rIlf0zLGFTy78/Ct9Y6BJp/IX1Te20l5H2gl2gT9oAURXigj7SV8um6WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PKxrsm5wha+rTSW/Fx78lWg5zLdUTEaDtAzAiZVjHpc=;
 b=I6okfPUZxMXpfxg06BwlmDjJob8lN9wF7z8PcPf8suNpVUjKT62XDoo+f3ReiILMV7eTVJXURF/4JkMyvqRTiU21kF71jg2Uepug4InBS1NHoCgkqxLpkt5UGFSpuVc6ntXznHlFNFXy/46S6oUrDw0ePE0unFixSdlOUNU0wNE=
Received: from DS7PR03CA0049.namprd03.prod.outlook.com (2603:10b6:5:3b5::24)
 by PH0PR19MB4760.namprd19.prod.outlook.com (2603:10b6:510:26::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Mon, 12 Aug
 2024 16:18:44 +0000
Received: from DS1PEPF00017098.namprd05.prod.outlook.com
 (2603:10b6:5:3b5:cafe::3e) by DS7PR03CA0049.outlook.office365.com
 (2603:10b6:5:3b5::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.33 via Frontend
 Transport; Mon, 12 Aug 2024 16:18:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 DS1PEPF00017098.mail.protection.outlook.com (10.167.18.102) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7849.8
 via Frontend Transport; Mon, 12 Aug 2024 16:18:43 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id 3F58FD2;
	Mon, 12 Aug 2024 16:18:36 +0000 (UTC)
From: Bernd Schubert <bschubert@ddn.com>
To: miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org,
	bernd.schubert@fastmail.fm,
	josef@toxicpanda.com,
	joannelkoong@gmail.com,
	Bernd Schubert <bschubert@ddn.com>
Subject: [PATCH v3] fuse: Allow page aligned writes
Date: Mon, 12 Aug 2024 18:18:39 +0200
Message-ID: <20240812161839.1961311-1-bschubert@ddn.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017098:EE_|PH0PR19MB4760:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 35b3724f-28f1-46ae-edeb-08dcbaea6ff4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Sw4cOsRT+nIjLh5olGMJQfSFpBg5/QXdML5nhQjfB/R5ldHW2uoY6qtuLuWQ?=
 =?us-ascii?Q?mjV1QvSORE2FkGl2OT7LnfBqJBk6RmJGSDmF7BOCpNoVnrhsHBDYqUOFKy+Z?=
 =?us-ascii?Q?/d4MLUSNbx4792RRZCxPtjQl7SsaW8CavBeO3AFwAK06pgcK67DJF4Dpw3ac?=
 =?us-ascii?Q?m6sgtnsA532UvIdG5fr4X4n3XfeUika3QKTf3Ve66CmB3RAYH2fzIyQLi3j7?=
 =?us-ascii?Q?aTFJLvHB3tjeclm5RuKZ18wSvDMMtA+lTpz7BUql7O7qx3Lh6/RzwAsUtkuU?=
 =?us-ascii?Q?pE0fJP74KbkWZXwFzW/jbsXMUuEfovImgbUnuPPKjGO85zUQ7a2m085eN1mJ?=
 =?us-ascii?Q?jbPZwVsKZ6Oy3aMt7N/JjVhRAbyYQx7NyoU0s4jey3JUNXUsjqXASrBzXWs5?=
 =?us-ascii?Q?CLRyUcnAZoG8UA7Fw/JM49szqGn/9hs2cPS6ayzc15BxCsw/iPqRVjfXASMF?=
 =?us-ascii?Q?Mvk/fvLO/0i2aGTgfJxMwuEh8mwXRynFjcJMd/DS68vYT8l+LO3NSI81r0Ww?=
 =?us-ascii?Q?IATBvB2xvtfXKlllKHw+StETF2ZkFTQ69IqvhO1YeaNLHfi0TLEzcBaXwjns?=
 =?us-ascii?Q?nJh3Bwe+N96F2Z7sS/K6d92oQjR6o6pDfdUgiSlwMV0/+8jX26t/IRkaYsA4?=
 =?us-ascii?Q?ts/3uTCrAyIPcAqh0pnGEIvsKuD7wIkXhXnZhyVX2d8B2MIB404sPmnwdtZR?=
 =?us-ascii?Q?Bgk8bCaRSLmxTDHUNgsqIMBFw9NPZZWFpyeQNkEnZD0g3xb6aE9QT8WOpPrP?=
 =?us-ascii?Q?IW3YwbqlbNIhUSLgjovbsJ7ujr3JrNGxxy+znqRRK3OMWvClhQCZa4KpmG/E?=
 =?us-ascii?Q?un0kTCc1ahQWqJ+bQrTskiyP8VrAFqv/+PMRxzxMrCI8T+ARNsgr/ry60nZY?=
 =?us-ascii?Q?3vJqVvwExqVeUGq1F7x8o8GlxTM+qoAg+B0kF0TqS15/qvpLevP4OuYzOtx6?=
 =?us-ascii?Q?bJWw6Nf0GTpwgcnEReBc7qoncvAy7sDuySzUqjNDR7Seowa+h+aLNElLWyXD?=
 =?us-ascii?Q?8aFlI5qBEHAANHcX4T9QGP612HRkdrbqur+JJaU2y5SsdzLVRADEtIT5K8b/?=
 =?us-ascii?Q?hE2sUOH4PIf9WlPNVkkpvNIz8xVNf/roZrHJRjrIIU91vgV50IbAjM/FsLAO?=
 =?us-ascii?Q?gVbWweUircvKCSeowCFJDo0vazF6cIPJX+JxFQKPrTHowuQLQkSvTF8LShUW?=
 =?us-ascii?Q?quRN1AptOpCHkur3vI9gPmpwXJ/nuBv0p9TkDSLBtr1qs/o4WXlytzf/JNOs?=
 =?us-ascii?Q?U+7dBvu9mszZJk4wGTAjMQ9JtesMIWg53haVh1EJjRyaM1Sl9ijqHwNl+DB4?=
 =?us-ascii?Q?vKs9gjI3RjPvxNWpKDetokwf8D4N0QQ7+Y/2A4noaq9Mlcscp+5KNFRtAacr?=
 =?us-ascii?Q?wNCJiWFlA6+SV6hqvnBaEF+vAdAk?=
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	nlCJwnJj5klqOygXlTuq62FjxuMBaFfhITqmB0KEDC8KiBdWVz2+aZxDNmZ2A207ImJqrAMUjtd0oKej1fgziBOHR+xorHYKEOUISYCMT/ISemMQoIg0MDzb+PZD5m857tEGsOac267xfdkUeLEWUlt121VVw2rvJf6IR3ozKXf/aldV/jrNRH6/HjaaVYguuM6iFDWMyz34dmPDjQbx3jfeX4cEYx8DYsp0hoWzZCnHPvhVefi48icxFKY8+mxvDwbx277lnrCUFSxlSFl/hYTNheM+9mRbEIvoqOTpn3JS5tWURFNTmfWqTSAGcSr3Uzk5RKBOZPl5Qc8DJdFuuBS4YrgyqELaKs6WbkbnkbXkumaDCEpQKhJbXEO08AuqbspFMoMgSQJDTOTCc1oZ7zjIWBjrKGK73h+bWXgjoDc66Ny4eDl+6bYrQjLJtIpoZwLmSLCpgmhs5vu+dkYg7EVtawOsa44NHdWJwVUaEEJ5z6qYlU6H63ew6K87+YTbbHoeC6Cx1lqgpkq+wwJK14G/CskzPMFA/96j/dx2r/+0G2qjeA1JWFFIts3R0rVnShvBcDUJcQbYq737Fvn+v8bRWxpEhVCl90WTDdHd53f3DyUv6VACUr2/1Hq0mmNAExIZi3XEpiSF19geh1HRIg==
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2024 16:18:43.9454
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35b3724f-28f1-46ae-edeb-08dcbaea6ff4
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017098.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR19MB4760
X-OriginatorOrg: ddn.com
X-BESS-ID: 1723485015-111570-14593-844-1
X-BESS-VER: 2019.1_20240812.1719
X-BESS-Apparent-Source-IP: 104.47.55.176
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVmYGFsZAVgZQ0MjcPCXRMi011d
	AgycjMwNLYwtQszTzNKCnJ3CDZyChVqTYWAGsdbG1BAAAA
X-BESS-Outbound-Spam-Score: 1.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.258292 [from 
	cloudscan18-130.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.50 BSF_RULE7568M          META: Custom Rule 7568M 
	0.50 BSF_RULE_7582B         META: Custom Rule 7582B 
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
	0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
X-BESS-Outbound-Spam-Status: SCORE=1.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_RULE7568M, BSF_RULE_7582B, BSF_BESS_OUTBOUND, BSF_SC0_MISMATCH_TO
X-BESS-BRTS-Status:1

Write IOs should be page aligned as fuse server
might need to copy data to another buffer otherwise in
order to fulfill network or device storage requirements.

Simple reproducer is with libfuse, example/passthrough*
and opening a file with O_DIRECT - without this change
writing to that file failed with -EINVAL if the underlying
file system was requiring alignment.

Required server side changes:
Server needs to seek to the next page, without splice that is
just page size buffer alignment, with splice another splice
syscall is needed to seek over the unaligned area.

Signed-off-by: Bernd Schubert <bschubert@ddn.com>

---

Changes since v2:
- Added a no-op return in fuse_copy_align for buffers that are
  already aligned (cs->len == PAGE_SIZE && cs->offset == 0). Some
  server implementations actually do that to compensate for fuse client
  misalignment. And it could also happen by accident for non aligned
  server allocation.
Added suggestions from Joannes review:
- Removed two sanity checks in fuse_copy_align() to have it
  generic.
- Moved from args->in_args[0].align to args->in_args[1].align
  to have it in the arg that actually needs the alignment
  (for FUSE_WRITE) and updated fuse_copy_args() to align that arg.
- Slight update in the commit body (removed "Reads").

libfuse patch:
https://github.com/libfuse/libfuse/pull/983

From implmentation point of view it is debatable if request type
parsing should be done in fuse_copy_args() (or fuse_dev_do_read()
or if alignment should be stored in struct fuse_arg / fuse_in_arg.
There are pros and cons for both, I kept it in args as it is
more generic and also allows to later on align other request
types, for example FUSE_SETXATTR.
---
 fs/fuse/dev.c             | 22 ++++++++++++++++++++--
 fs/fuse/file.c            |  6 ++++++
 fs/fuse/fuse_i.h          |  6 ++++--
 include/uapi/linux/fuse.h |  9 ++++++++-
 4 files changed, 38 insertions(+), 5 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 9eb191b5c4de..139b059f3081 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1009,6 +1009,18 @@ static int fuse_copy_one(struct fuse_copy_state *cs, void *val, unsigned size)
 	return 0;
 }
 
+/* Align to the next page */
+static int fuse_copy_align(struct fuse_copy_state *cs)
+{
+	if (WARN_ON(cs->len == PAGE_SIZE || cs->offset == 0))
+		return -EIO;
+
+	/* Seek to the next page */
+	cs->offset += cs->len;
+	cs->len = 0;
+	return 0;
+}
+
 /* Copy request arguments to/from userspace buffer */
 static int fuse_copy_args(struct fuse_copy_state *cs, unsigned numargs,
 			  unsigned argpages, struct fuse_arg *args,
@@ -1019,10 +1031,16 @@ static int fuse_copy_args(struct fuse_copy_state *cs, unsigned numargs,
 
 	for (i = 0; !err && i < numargs; i++)  {
 		struct fuse_arg *arg = &args[i];
-		if (i == numargs - 1 && argpages)
+		if (i == numargs - 1 && argpages) {
+			if (arg->align) {
+				err = fuse_copy_align(cs);
+				if (err)
+					break;
+			}
 			err = fuse_copy_pages(cs, arg->size, zeroing);
-		else
+		} else {
 			err = fuse_copy_one(cs, arg->value, arg->size);
+		}
 	}
 	return err;
 }
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index f39456c65ed7..9783d5809ec3 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1062,6 +1062,12 @@ static void fuse_write_args_fill(struct fuse_io_args *ia, struct fuse_file *ff,
 		args->in_args[0].size = FUSE_COMPAT_WRITE_IN_SIZE;
 	else
 		args->in_args[0].size = sizeof(ia->write.in);
+
+	if (ff->open_flags & FOPEN_ALIGNED_WRITES) {
+		args->in_args[1].align = 1;
+		ia->write.in.write_flags |= FUSE_WRITE_ALIGNED;
+	}
+
 	args->in_args[0].value = &ia->write.in;
 	args->in_args[1].size = count;
 	args->out_numargs = 1;
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index f23919610313..1600bd7b1d0d 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -275,13 +275,15 @@ struct fuse_file {
 
 /** One input argument of a request */
 struct fuse_in_arg {
-	unsigned size;
+	unsigned int size;
+	unsigned int align:1;
 	const void *value;
 };
 
 /** One output argument of a request */
 struct fuse_arg {
-	unsigned size;
+	unsigned int size;
+	unsigned int align:1;
 	void *value;
 };
 
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index d08b99d60f6f..742262c7c1eb 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -217,6 +217,9 @@
  *  - add backing_id to fuse_open_out, add FOPEN_PASSTHROUGH open flag
  *  - add FUSE_NO_EXPORT_SUPPORT init flag
  *  - add FUSE_NOTIFY_RESEND, add FUSE_HAS_RESEND init flag
+ *
+ * 7.41
+ *  - add FOPEN_ALIGNED_WRITES open flag and FUSE_WRITE_ALIGNED write flag
  */
 
 #ifndef _LINUX_FUSE_H
@@ -252,7 +255,7 @@
 #define FUSE_KERNEL_VERSION 7
 
 /** Minor version number of this interface */
-#define FUSE_KERNEL_MINOR_VERSION 40
+#define FUSE_KERNEL_MINOR_VERSION 41
 
 /** The node ID of the root inode */
 #define FUSE_ROOT_ID 1
@@ -360,6 +363,7 @@ struct fuse_file_lock {
  * FOPEN_NOFLUSH: don't flush data cache on close (unless FUSE_WRITEBACK_CACHE)
  * FOPEN_PARALLEL_DIRECT_WRITES: Allow concurrent direct writes on the same inode
  * FOPEN_PASSTHROUGH: passthrough read/write io for this open file
+ * FOPEN_ALIGNED_WRITES: Page align write io data
  */
 #define FOPEN_DIRECT_IO		(1 << 0)
 #define FOPEN_KEEP_CACHE	(1 << 1)
@@ -369,6 +373,7 @@ struct fuse_file_lock {
 #define FOPEN_NOFLUSH		(1 << 5)
 #define FOPEN_PARALLEL_DIRECT_WRITES	(1 << 6)
 #define FOPEN_PASSTHROUGH	(1 << 7)
+#define FOPEN_ALIGNED_WRITES	(1 << 8)
 
 /**
  * INIT request/reply flags
@@ -496,10 +501,12 @@ struct fuse_file_lock {
  * FUSE_WRITE_CACHE: delayed write from page cache, file handle is guessed
  * FUSE_WRITE_LOCKOWNER: lock_owner field is valid
  * FUSE_WRITE_KILL_SUIDGID: kill suid and sgid bits
+ * FUSE_WRITE_ALIGNED: Write io data are page aligned
  */
 #define FUSE_WRITE_CACHE	(1 << 0)
 #define FUSE_WRITE_LOCKOWNER	(1 << 1)
 #define FUSE_WRITE_KILL_SUIDGID (1 << 2)
+#define FUSE_WRITE_ALIGNED      (1 << 3)
 
 /* Obsolete alias; this flag implies killing suid/sgid only. */
 #define FUSE_WRITE_KILL_PRIV	FUSE_WRITE_KILL_SUIDGID
-- 
2.43.0


