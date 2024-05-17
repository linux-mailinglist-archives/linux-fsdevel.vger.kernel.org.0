Return-Path: <linux-fsdevel+bounces-19687-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF0C8C89D3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2024 18:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A59A328191A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2024 16:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C74512FB01;
	Fri, 17 May 2024 16:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bWR7JMxy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD11F27471;
	Fri, 17 May 2024 16:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715962247; cv=fail; b=AskJNsACTPkSZVdVR3k3TrTB2y76soeOYnI3fyWt1OgSaCeHocX1BU6CNorUxRJz+aVO/TGVz8h0SX6hzl9az9UvZosH5EjP8Asc2agrSERZ6tb63XAe4Jx5oSa6AhrQsHO8l3H9CgKmzYS/IlF4w2dSPP7qPbR1l5yAJx6pauI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715962247; c=relaxed/simple;
	bh=rPRTXZNb30JEv7FzpX8AgQnzAGs/cA5CpzaiIhCMvTU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=E4gc6Rt4To+FWEHJz/6EC4zR2Svz/6g1Y6FdAZU5pe0kJVvc6eNIbLQuPic8uOvA40XLtcKic/SxpxM4NHc7pEqa9q8IF6PAWHhJWFw147dLBYDyzNRvnk/2/Kmwip8NLLLVHi5eS30riCmKqIknKvYLMZKoHpUs9ffZRwDBbRs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bWR7JMxy; arc=fail smtp.client-ip=40.107.220.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mV6z/s0XczA6TlvgM0EVoAO1TkbVBBIXbK5my1cOG59kMA2vYy2QwLkhFBBDYQ4/itASPxVXz7/R7XZjoocrdvL2GulNyIqBPcihgVxUN7CfPADWgOCJ/bAEdiB1G8OtMoUQhXVMIva+g2nxzOuHZ3eL8okNm/+HnPyBV1ZZGNnHtpdgFMWsTWihQXxctXKZXCSMu5t6ms9PAYYhhU9RV/XYmWvi5VoWhC0K2a0VSsL4hGfn7yWYBpqMfN+2nu3qrD1TVFg19fSrOMAbiMENIh732LiiCR2jPLSnAmeZ+DSbfpPwDopwSTusFaW0DaxIsiAsO+Fu7zGwLzFu7YAYqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B044GXw6NmQNvtOuRI2bQwLvZ+g1/AUdWnT6BXpL6C4=;
 b=Wshs40GdqYgZ/cPdEwBD3Imyl65dUUmu0bNbBtxBwkieYlKWxmCEKxjb3DdVRStD4Wmor9eDXXCgUJJGDZ0jLkDGUt0c7Ad9Jf9AtQACURe+JdOIo36nWyecIKSlANsptNmQNIqxp7QKm7I9FO6FnEAoXoQxQe3EdMNZ5+zzEJQoqqVG6XwBIMTTif98bNuxHM/jvNsBhjbRZplsoa7aOZXMD3YPOlNJ5ttFKu4tFwYHHDXYA/t0Q5xMKjFUzbeivtusnXFnuTSX9Zkxiqb/qYuzsPzMLS8Z2/kpHA98uj8jKF2t/3DuavF0Pque08rFWg4ahMzl+FiiAEhQU92KfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B044GXw6NmQNvtOuRI2bQwLvZ+g1/AUdWnT6BXpL6C4=;
 b=bWR7JMxyZQOL2Lq8s4Ne9IjuA9y0DlwMEPnLQTsisGgpAS1IPHtyvWi7/BsCSh1QyqV1Yv0wEip31m8o8ZPb/0NQCvApMN1A5EsaFElXrtXB9Tbtk2Dks5doS8QAZ3pxiv+iiKrbOFkomVgpzscrR9fMFn/aVbWBKkgkwU9qKk5jmLR8zRcn/sP8LXCmG6LFGDq4NcIZVlUS7Dkir6DDD3jIqO/Iyk4TxqQvV4EZYJh9Y220k+0ija5lgcqndXVR/a/Ew5Afkg/1AOq3tFMMfSW42FwJ8Xo+Izx9JPYzLK610i82yvt2PC4R87AGReAPy4KGTVJ4KJnWA7cDG79TTA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by LV3PR12MB9119.namprd12.prod.outlook.com (2603:10b6:408:1a2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.30; Fri, 17 May
 2024 16:10:41 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::3715:9750:b92c:7bee]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::3715:9750:b92c:7bee%6]) with mapi id 15.20.7544.052; Fri, 17 May 2024
 16:10:41 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aurelien Aptel <aaptel@nvidia.com>
Subject: [PATCH] fs/fuse: use correct name fuse_conn_list in docstring
Date: Fri, 17 May 2024 16:10:28 +0000
Message-Id: <20240517161028.7046-1-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0134.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9f::26) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|LV3PR12MB9119:EE_
X-MS-Office365-Filtering-Correlation-Id: fb7d90d9-cee5-44eb-d7ba-08dc768be633
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?acD3uGnuzfPm8sgu1fTpv6Bs9VDi1N+7xViCky2JtFvrYkwx0e/cX6ZkOjVL?=
 =?us-ascii?Q?UcXxYZeKu/5qA9SiermjLkDsvFmCkoQZUT9IuOH8HlVNTNK3xhF8jg4BK2YJ?=
 =?us-ascii?Q?ynpJA1QAXRRlYarrAOtF6DXkWrbFETXYrX98eRc+6q1DHgv26U7i11CumwOT?=
 =?us-ascii?Q?pascLNJvNbhGg18RdWxo9zQQtLvrgBKNoJeSEWT22cRPSGL8ToGaOW8yq1zS?=
 =?us-ascii?Q?C4tcCpXN0yjMisvv5C3+4zECta4DQnNv93yyfaDJErmTvt0dYJ0uF+ApSXoL?=
 =?us-ascii?Q?I0hYNZrX0xu7kAiuQNvYt3OLBPjJlf1bdE2N1yZP5zNXwcMzF9+n9j7gC6+N?=
 =?us-ascii?Q?kmTd3E9ZEFrhZmopXmUP6pYVAiRO52XUNSKsdhBcAnp2fIf6PE5XblBAedDB?=
 =?us-ascii?Q?VpybBU+kGk1QNPlKQvQRKC2jTAmfN+rvqhNWe8ml92WG7htG6Ps6Ou4PF+L8?=
 =?us-ascii?Q?1IHhoSV5P733NRpq2e7EUZ8mDguNBuiqYeYEc7AwKNUQMLBrIc52AkGL3EAM?=
 =?us-ascii?Q?Vj3TV/OHBaAwrOoB2yc6rmxQFa/UzGSCEj3g2MfD7jnNsxDHqE/DV9vkXdG8?=
 =?us-ascii?Q?U1pXPXa7ZJgnCcSQct+KOBQcod4tSpy2VR+T9UJBAjBh9h7/9wkWs6XwMEvx?=
 =?us-ascii?Q?FmZ93VlwZmtnQj1GPDwFS4CXcvpaU52Csjw3du6yZ7p9lNyKq9fc/HdoKv+/?=
 =?us-ascii?Q?26gR8v0nRXUKWZ58zkmJj/H2EOXW6y4fVnY8bPpvr26KXO2nKH0Zv466Uy4j?=
 =?us-ascii?Q?CiE67aJZtad1YVcqZHSV483CfW+GxWrh/sR1Gpfj919ougDt0f7qR0YsCCae?=
 =?us-ascii?Q?atQM0+OHXwlKhYTKyFD29xDLmvYauZzLefOGvhyg/U3sY6Cblg+uSJ89RXEa?=
 =?us-ascii?Q?bhc7doy6U8y/cWqlY6qAKJLMAIfXSaFGBv1kwElbZaQZjYZd0fzkNdL8CK2Q?=
 =?us-ascii?Q?msjbKa182VqH+RQJgSTe2k1YtuzsAcG+mwuejUVYqyaCPXMcAUkLw1S9iqem?=
 =?us-ascii?Q?Hv3N/A1KvKVnsltpJA08XkzNAn4X3lxsDB3YlvM5HgLerJrcIH9l4CfmRhbA?=
 =?us-ascii?Q?D/3LHoZ3ca7WeM0TAMeK8Z4+fdaMcdD0yhsOQaUo8uGzfuSPWhTjqevNxxLD?=
 =?us-ascii?Q?eMJY6hSb/lK22zwQDqZX6ASVfbQkO2H6LNegaEQ2960su7NIEgtx3yGJ3Xrk?=
 =?us-ascii?Q?ccDnrY+udBsfjP4rPh01DisPu6zVdyr2uiPATi/ONw2OzXwl/0yeYzvrl/sq?=
 =?us-ascii?Q?NQy7gpNe5vNRrWi6wC4BUWDn6mb2+xtYXq1VzeuaBA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vmiMTBx40zOlCoXjpiaOze3ysBGxOsbKt6Gx+ZF/tcWwAnSi3KSMigFsYo2B?=
 =?us-ascii?Q?uP/GSVbs8z+gS6Dz1wtBuYSs/RFJvKwUcipHn4ogJVMUxKEA+LsEvBbP7ddX?=
 =?us-ascii?Q?t/cpattE7v3M0NZqaAOoLYfsNhP+O/sCN5aNV21uApcyreGALCRrZKTCFPTy?=
 =?us-ascii?Q?flAR3GMbE57t5nYEsXH1lPgi7wMjSOUCOFXzSvoot4po3w6lL1h5cTO1RF1N?=
 =?us-ascii?Q?IDPDL+3uUiTUbKm2ypFIvwj+7Vat0eFa0jloY5qTwHQIcRHYR7jFHym8V1gB?=
 =?us-ascii?Q?uv4UqAbf+jbAVrlK+vTyi+EoqxEW+yV/V5a6CaRa2CheQHiuwlLjmlU9KcaZ?=
 =?us-ascii?Q?b+7C1/OnbQG/WPMQl/3KP4bZBogR4S+/Emo2Wd+pVXfqTfa3P4Gm4kLOsL0K?=
 =?us-ascii?Q?OxZX4n1+aKZfyYPrXNsfM7Snk9cmcFBcxTaR4NHaxbHDcDdN8XZZfgWoLyhS?=
 =?us-ascii?Q?dFSyn4bnlwJW3deb2KzLzKTGJo+5PTp4t9eJPh6hn4uBnrKUIh+nZNaHpryp?=
 =?us-ascii?Q?mekb77ifXWycYLGupG9MdpskmPNGaKdzJOjQGlZ675CvD2p+i7rDRql+++zh?=
 =?us-ascii?Q?yFg7vmIHidsEDz28TY7GmAmCvzPMO2pQ5qpEi2/HhYSZ7ajp3+1ZhfGX+tr8?=
 =?us-ascii?Q?wUzRtBaITp44W+j6KR+OwkV5O087+axeKmtxPJHrZWg7cnh+/mDiWOIHWuBa?=
 =?us-ascii?Q?x/v3FKvwXXn8676w9yJG5eXbQVKWU62C+5hylhOAPkvaAxVIeOo/CiPW6qes?=
 =?us-ascii?Q?CMvjqw/CH6xl6UGzSm9pauJwQu4FkXmeT6ST+khPFYqX8gjpXWMeg7NzDW7m?=
 =?us-ascii?Q?6dxrFWbNUsahMmaZ6GHO1VoEOcI3Ljs5/nKVXUQl/t1RSQ623niJb6p9z3EN?=
 =?us-ascii?Q?VC8NH+F14HKXhtpgYa7e1d3Xq7pqo/w5jn4POtXNMsMFLxGCbGRFYnBoHr32?=
 =?us-ascii?Q?oTkbVToaDS2c+rqpvnyKKtRHnHfF0iy6EQT4V7hzSiVF235zrfx3zbGw0pB/?=
 =?us-ascii?Q?/cWybMwPDPIGE+I8atBu1AHnd2xN6HT05gjehQjqvKpBBDLB0h+7BgXN1QwN?=
 =?us-ascii?Q?lUpA7wP0ARB4f69U4z6hlMRwbOYvhJUKRNtK9A4urqUwHvake7K85X89RqmX?=
 =?us-ascii?Q?kGt4MhX/Tv72QFJDrcRQZcwGcEqNjFQEIgXoqyxTgbpJfEcX0gCDbKWn3ZG1?=
 =?us-ascii?Q?ZsPyRbggfpvo/lnjBl2hLASKprkT0wcwT5VriMRppSE8hegF+v7lXx3bFvDc?=
 =?us-ascii?Q?mS+s7Tp1btQ/j8S2GThbpXioVvi1Kl+zjySIWUc7aDpMk8Vr3CDPA2WMNJ+/?=
 =?us-ascii?Q?cP8oE4Jcc6bzi7tB5tcHapcTfamOV4TZmf6V3S4kSidMmAXEiRyHBa64WfLE?=
 =?us-ascii?Q?+1+lck8jeUP49p5LnOJMT4ebjTtXx3HTO1zAPX1HDGxsHH2D/W7rf6FNPLEc?=
 =?us-ascii?Q?FP3A4sEg+vQPECn21H6/We02yFSl0lhfmQCuzv2SGW1nNW1yseXfLmBmQeAb?=
 =?us-ascii?Q?6zAZqiBQvEhKGECPfNwEmdLQ36pXTxSve/z4e0v2dbPwEpYFMwlrTLaakI4L?=
 =?us-ascii?Q?YmpRIpGwqsVQ851Vc/32HvzHU5+ftr/jmZQGMzBM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb7d90d9-cee5-44eb-d7ba-08dc768be633
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2024 16:10:41.5736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t1N/5d0uOhoJ4QDnXGswBQamCw29j4/H3StP0ABu7xeMtdobX+alNM9AIIQYBgqlocuGoryQCKliXTURkyefIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9119

fuse_mount_list doesn't exist, use fuse_conn_list.

Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
---
 fs/fuse/fuse_i.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index b24084b60864..bd2ae3748d37 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -869,7 +869,7 @@ struct fuse_conn {
 	/** Negotiated minor version */
 	unsigned minor;
 
-	/** Entry on the fuse_mount_list */
+	/** Entry on the fuse_conn_list */
 	struct list_head entry;
 
 	/** Device ID from the root super block */
-- 
2.34.1


