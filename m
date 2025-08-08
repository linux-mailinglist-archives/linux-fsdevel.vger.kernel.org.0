Return-Path: <linux-fsdevel+bounces-57032-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0BBCB1E2E9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 09:15:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58BF43AE332
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 07:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9190F231837;
	Fri,  8 Aug 2025 07:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="XcdUpotE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012009.outbound.protection.outlook.com [52.101.126.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15299226D18;
	Fri,  8 Aug 2025 07:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754637315; cv=fail; b=EpKe2MVcNFogPe0JMc9MTp461zdMbCbPMrsbZgrqLGe+zDLF6UG7xfWR/W7lTE17SsJHgAnP2bUamwud9FfbeeeKRVIskwGUQRuZ3vSQZCcCNWDBMKpcS3FAruG8SXc/QjyPAZUeIpoL2OOvFkzKYdyrLcHqRPkpfn3wixbnCQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754637315; c=relaxed/simple;
	bh=uvuvHvjX6yh5ylMwhA3at7/5eNgiaTjwCI1Vuk5zgWA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=elbUKIUesCb7lltlI2JXRoGvtisFKNMbAxNfwJ0m7Pz/9LeND4+BOALu63vcwvGty+cl5tMrlA41DT4YCalyy1tERuyzgdjqh/ReOvyRcpCBKI61F3Y6Ri3zg+DJnuhV4SqFsTQAC3RZcIzAmaecr3iX5rrpaDMjOLF9H1jgrcc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=XcdUpotE; arc=fail smtp.client-ip=52.101.126.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a5RoJ9cJWHru3pF709wapTJeT+w0VEaA+1hmlsHR/CubuaeeM+JFGJoYtuGp2/2nBDTwWHnJJ9G3/6MxBM1vXojfjGGVEfuysON3I7OW1SpeZG9cBjXPFftidpOEJDorXqJsUjOne6MNo20Rjb/L42kPZ/MLAc301lWcejDTJGZLzxLetnneNMM7IZFZvbDgoCVZJtRWugwPV/hTE37W+nNPy3iS9tyqY/q0zfYjwKM0usEn79+Wet3s28t4Ndens+bZGkKUfiNHqUUDtO7EHfWkruvJ7GHbSkHvYBfiNSRpJ6nwghrPI3ucwAk4V1kWUN5sg+cVppXW1DdtnMqpUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EaRsp2hafX5T79uW/jAUVQCj5NhROIBp0mmhNdGdHyo=;
 b=e2yVbDl7YMSKNXp69AqlvxWZlYYC1w3ARRBQlxq3WUwxodPg5HRvrnp/Hm+SVC6qxbe4BohxPTY8n7KK7HBIXIxJwmbDvxOugq7rbnpwwWzJZtJIoeJSrYR9HnWpMc8iufuiR3X4s3CbGIAb+RRkyTbkMxsPm95VXckxQ8VhLVU1e47SF7ar/nPC64eBxfG9ZjTbeN1zW2xBs3FE8e616lATq/1TBl0GbI0+hT9fI4UW/RaW9Jn3wvLV3Z0L9zJtEHtfr7x6UX6qkOVqgu0DsEp7PSGA5jJZrP2Sqb9B17PMO3bdStRfcqw0/ecHqPqLE7AcJiBSLxLjVJ2qfOddZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EaRsp2hafX5T79uW/jAUVQCj5NhROIBp0mmhNdGdHyo=;
 b=XcdUpotEzvEKdHFQ7X5hUbD9JAQGecySRP2q6OYXAJYIQyYQoXqx89ZP5esqqP7a51sGADCWFpxsmdhvw6M2w7g5KTtVVQ7aNneYNzK2V23N91lfDCSwpb26II48Z3wAmm/6IZaZY3RnM+5G1i3x3TL4BUeQls3Dqfhamnbprn76Kbd2PttQTy0WhrdN2+p8127QGXWq3XMiR4Snorz81b4YC2hKzHEtkc9nW+U+AuC+Vtn/YxM9QDVWPomw7tqTWfZ4Df8N62zG9kvqs5MaU6mgOs8LMW0LOpzl7wnXSLwbCfzun+T6x1vYg771oaN1fimFgTpVb4nSHneB0/9jvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com (2603:1096:820:d8::5)
 by TYZPR06MB6463.apcprd06.prod.outlook.com (2603:1096:400:464::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.15; Fri, 8 Aug
 2025 07:15:09 +0000
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb]) by KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb%5]) with mapi id 15.20.9009.017; Fri, 8 Aug 2025
 07:15:09 +0000
From: Xichao Zhao <zhao.xichao@vivo.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Carlos Maiolino <cem@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <jth@kernel.org>,
	linux-fsdevel@vger.kernel.org (open list:FILESYSTEMS (VFS and infrastructure)),
	linux-kernel@vger.kernel.org (open list),
	linux-nfs@vger.kernel.org (open list:NFS, SUNRPC, AND LOCKD CLIENTS),
	linux-xfs@vger.kernel.org (open list:XFS FILESYSTEM)
Cc: Xichao Zhao <zhao.xichao@vivo.com>
Subject: [PATCH 0/6] fs: correct some spelling mistakes
Date: Fri,  8 Aug 2025 15:14:52 +0800
Message-Id: <20250808071459.174087-1-zhao.xichao@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0021.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::8)
 To KL1PR06MB6020.apcprd06.prod.outlook.com (2603:1096:820:d8::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB6020:EE_|TYZPR06MB6463:EE_
X-MS-Office365-Filtering-Correlation-Id: fcb5ed14-2b15-4b1c-7c81-08ddd64b4f17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|52116014|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tyWK/eClma1Rp+YUtrvNaahw+83Pkfen5d+86EKzo2O/9Zn7VrSDi1WQIoa8?=
 =?us-ascii?Q?56xBgYmHv6gS3rMxvMIzk5a3QYtEmoNjdEHbNqIp59+8CAUik9O8nEXe2FIN?=
 =?us-ascii?Q?dCwDCtbwiSxdpmVlslrfayDJ1tIz2oN9o68chokXPANsyv+zUKTZSZ0gmh3A?=
 =?us-ascii?Q?cCvbJ1ABwDy2Dv4GqJUQc70drxtoZjl1PtYwQabuEteH1hjJoXv5UIdjDtDk?=
 =?us-ascii?Q?Zd2XEdVl1GmbBLpCP6Ysgyx7xlSELDxcwHDbum6xIZduoukX8e9fL+xfJZK3?=
 =?us-ascii?Q?uaOyzhNMs5XSFRVgS+TGp0D/Z/QgcDxsvH8UJzMAEC9SsVWP1hPfhj3IucLn?=
 =?us-ascii?Q?L/07vW+6kwWaU8PH2ywzcJSbnSd+p1Z8R58RprM+boXYhYGtOmruzhF2yQpn?=
 =?us-ascii?Q?4Dg0wrMAsG7gerhjjy8I8G2YMhtAvvd9y2IMx6kjgwLR0x9846jKdZWn+dHW?=
 =?us-ascii?Q?DqrDjZAahqPWnug7Tq8+J7qcWpsKsotgTsJtLi4uX18rS3Hgr7R5nbgPGwdI?=
 =?us-ascii?Q?m1+Lewm15sSD17VxJlAAJesS37fDYkmerjAVhX63pf7DsIApGTYkAkWUGbC6?=
 =?us-ascii?Q?93CfQ0pbHQej6N6UAUfZDUHdB7hFLEHVE1nQiddeHmPaueRAU91d26EzD+0E?=
 =?us-ascii?Q?wKLCzggyi6RE7UYdWxJOoCO77vlBjA039/OMCr2wn+hHUP7p0QYoUXbh/yOj?=
 =?us-ascii?Q?n2WsAUVb3GH2Vh/ViCRmMGcGYyBBpUSPEZqENJeDeemPkqYizMvbyiFscaIP?=
 =?us-ascii?Q?8e+hTEJW/5OO4C2E5Ia1Ux3XXH8wDi++fHkZRUjs5G7QPIih9HFntex1ousI?=
 =?us-ascii?Q?o3QWWV1n4MkAmYuSVlFfq2hPywVsdn6Z7uhyYGjUc7ODMFd8IplhbdBdTPaa?=
 =?us-ascii?Q?uCz+iFsj2h92L8cBGVkO/L/HCK1yeIjTNGkUyNiYCfiwjztCAE/Y255AfFNB?=
 =?us-ascii?Q?iKSEfrO7eU+FQIFeIylH1sSsIReMfFCPLUCbpaIItRZ5MQRDPeJfTWyqjOdr?=
 =?us-ascii?Q?5bJ24gbAERxw4WmuDBARD2p1uP57Tbt8Sx3+KSl7Em26/+Jn2wU30Wi8ITQj?=
 =?us-ascii?Q?+MlaJfIiwAFh0a1laMDrqtuiUc7JrEdGZmx1vZH8yEBdwzG9QBKr2BMJFSgt?=
 =?us-ascii?Q?TrCY+xefOwOt9zHbv2GCt5jqQ4Rc5pZZ7/XPAZKdQzf5qEHs6Z8YAh4Z+SoT?=
 =?us-ascii?Q?oX1z/Fc42MRsxgMKkncxPT3PcuaVpXG+pKv7HdDYQ8YMI1S+G9wVnc4MvSMt?=
 =?us-ascii?Q?5SuzCjgTWS5Q2egqfHdaPelNvwMXUolluh0FhFGCl//JVZZoQgKIa7++dwOA?=
 =?us-ascii?Q?1ZN/ua9WBgYkQ2SM+qXnRbN8Tb4Z7RkylSeXpER0PBJwdCBa1zFVHE8Us4eD?=
 =?us-ascii?Q?SDPdxP6D2YZebqmxlN2RCJYEPmdH2Vr5hf1uor7b/SBNQbDHZKMOXYNkLFQM?=
 =?us-ascii?Q?Fp8dTFHnljddXW+2ejWt46tH+MASvxaEQBDmV/gzTyaQbueBNzyGMduCi2t2?=
 =?us-ascii?Q?Ou64gYhlUCZboV8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB6020.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(52116014)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/z4MSPtNXtjDozKsgWYMFstQrXyhu+nCeDNlXCfiCu926eWPsd+QJF1ouHmj?=
 =?us-ascii?Q?ERfqsM25dWLdo8O/nZhja2XcKULsHuF2+qi1iD+nowgf81H0DhyWuM+BTpBj?=
 =?us-ascii?Q?rWmFFSV8LlqOKN7XtmmiKnkjAMcOT1sjlpckzkYxYwPms5WeJ42hDYnGb9T1?=
 =?us-ascii?Q?/5Sx7MbTKnFq2qwxonVPik7p6h5Wttis+zNhMezgEEa2TwRUzO1K+4V4BQMz?=
 =?us-ascii?Q?JyT7lmGVPQ7aqPaNIfdslvh0rkVGobuE846v+//b7eVjOvUA6lsXzC+NpDg5?=
 =?us-ascii?Q?UlEdL6K5P1M3XzJl0LwddnOqI98YZNu/0BHem7lCdQwZd1coOApDeyCIqoHv?=
 =?us-ascii?Q?/55O9SC4YXA+DTVExAtROTT2ZWCsQEl1qEmHuUhb1uELgdfZ6/vas9GzN81z?=
 =?us-ascii?Q?7jz5JiL/QUkz646EEmpktifPC1Nq8g84U2Hw6571Uy4SkAWFFGX9XMloGMvZ?=
 =?us-ascii?Q?B7Mr0zjFUXBJqmoPwN0QG2Xd1DbReLcJyIaEAhMlIQk2wAN1Phl7WkahUEY2?=
 =?us-ascii?Q?5yR72ZJv3s2rHj54IT7YRK3ZbWHhjeEdXpbaN9trc7s4UTPOBMhRgvCpE7v2?=
 =?us-ascii?Q?/akHxBRaLu4VarjM7jeJx/5u46resmMbolMNyyzVMHnEIM4GA2AjHMuyGfnS?=
 =?us-ascii?Q?nuImymkBfo2O4W9DB8MYvQqFMTZOGVYHkJ57Qa1P7Yatv33EzlXSjyefPqyh?=
 =?us-ascii?Q?oWTtOSebb8A4WhpTuL5/Bqbmit5GXZ+pDsjgJksjLsfW4BCoXO26JQx+Zv0j?=
 =?us-ascii?Q?UFipsd8MEebkXTmxRHPGgrqO3UKGLb7qNIx92Pw3CZLFmKpntwy/IFN82v+R?=
 =?us-ascii?Q?KmZ89tzrCLT41RwQetxrrGitSezksAZnlTbSardR29RRsZbtuvPPrMwqn/i6?=
 =?us-ascii?Q?clMIY7xX7/EwcKXRYFT9nE7s5e/wRG0907sC/FcE1P9F04GZ0PVb7VBeKiE1?=
 =?us-ascii?Q?bazBAeNE/SZksKBIUxhCVzmOQU2MSAdnk0DPxkvlqY8TCXi1UWMPaXeiwsqy?=
 =?us-ascii?Q?KbrnnfNRIatllounoSCzb8YWTG0UKylU0TpR5tAHAdXhQ8R3nXoVIh39QGRC?=
 =?us-ascii?Q?cZ/yoqTJgTj4+3B63hcKcFTaPJ0rd1GgRMVsjRkHID1BwI60HGJ8yiUwxaQe?=
 =?us-ascii?Q?V9j30akAdujgJ6CF2sCWO82++VkpVlpRTlVfwFw8g2AyLQuKhUBfW/PmiOeR?=
 =?us-ascii?Q?unpcVpd5zBkd5vuZykdQvsOzLfzJeNJkqsNmTD6KAB4OCUP1AagXQHRj8AXj?=
 =?us-ascii?Q?9TPTR+xfvjHQ9C7mmGXgnM721gtM7FbQmt/KeVnjJwmcmoG7RQPBIaIRbwyR?=
 =?us-ascii?Q?5+kEakLfVbPe5gyJoOI5AJ3wFGbktmmEQ20jusMhpNkU2aHcty21VTPv1XXs?=
 =?us-ascii?Q?hFBhbidshHUdGnzd9DvXhZGBNafhiaas362JAwalOFT6a0PzNnpRpKznxSu/?=
 =?us-ascii?Q?7oyriVxOSoOMoIsQD4/1sQruLqXgbLIucSiPfz8r+aC/qobGLPp5K4lNZI5K?=
 =?us-ascii?Q?L7kA8PppWaNkA8bK1+lQfH+YYcdk93nu1D2cknjD2Po5+E29VJJ6+MS40PxL?=
 =?us-ascii?Q?mlVBhebNbquPgLZTuWWV+jHNcWfcci5pYTn1Be2E?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcb5ed14-2b15-4b1c-7c81-08ddd64b4f17
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB6020.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 07:15:09.7238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TNhnmAsApkWxL6gxypAmINRm235rrfPZfYWmdidh3lVV0bpjyqKpKIg43RIAIYPpXYkMsoScnxJVGdau7AJaBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6463

Trivial fix to spelling mistake in comment text.


Xichao Zhao (6):
  fs: fix "writen"->"written"
  NFSv4: fix prefered -> preferred
  fsnotify: fix "rewriten"->"rewritten"
  xfs: fix "acheive"->"achieve"
  zonefs: fix "unwriten"->"unwritten"
  zonefs: fix "writen"->"written"

 fs/namei.c                           | 2 +-
 fs/nfs/nfs4xdr.c                     | 2 +-
 fs/notify/inotify/inotify_fsnotify.c | 2 +-
 fs/xfs/xfs_inode.c                   | 2 +-
 fs/zonefs/file.c                     | 2 +-
 fs/zonefs/super.c                    | 4 ++--
 6 files changed, 7 insertions(+), 7 deletions(-)

-- 
2.34.1


