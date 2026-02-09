Return-Path: <linux-fsdevel+bounces-76725-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJetIwAjimnLHQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76725-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 19:10:08 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B33C113658
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 19:10:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 608CF300D0C1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Feb 2026 18:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5449738A731;
	Mon,  9 Feb 2026 18:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="f7MtaBzt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11020129.outbound.protection.outlook.com [52.101.85.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE67138885B;
	Mon,  9 Feb 2026 18:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770660596; cv=fail; b=l5dtwiAgujxxH3oXqdUWtuE3wpUq8Yt6czYzFDt2A71nFuj4PMQv54h3vkZ4V6Q5yohhP1kmTs+903QpGW42uwaqx6NiZx1oNgr50ZZhTu6ndILyySizhJnbEsprLMsLJapHt+iZ1dpzKweEzVUWczNdTiuoxk7rQkqvdaAGGxE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770660596; c=relaxed/simple;
	bh=TEJynTwLWY/06sFt2JHqjXm+0V9/qXt4Wr0oZGAHSws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=r81ar/bds4zb3Yh/IsTheUjKWqmmQ/L5A3AdG2gO7h/Jupcb5ueLtJQNSz52N+LirSZbU5gzOjTiGnOPydzDBtx4wQZkYAKsOcvMaeLmcXu4Dn5himUvx8R3uwd/K+27GMj/vvpi+mRpAj/q2vTB0qVn5FKegQ0XMprWDw8HQoE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=f7MtaBzt; arc=fail smtp.client-ip=52.101.85.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vGymROEz9TRGr5XpyKKaCNd63nIO2Dy91ASBetnepIsIPyUUID6awuef4aSqghO8k04Ro2faPZRHswIRlufjlrZ6mdWtvTJUcL5qfx0Q4XTN9pVXb/ae83Q5sfXmhVcB9t3d3WUv2ub63kzgN1BMtOv5xFZc1skC4rdt+7dkatqnH41JYUwwBWVSsU5Qu3KOJMKet+evrYCUr8RWLmXWCig6qK4jCRsr0YmZa+jZyYgYDyAiI8qJ5Kw9aCvmlr3N9/Mc8iJCtsoBu2fT4pKFO6nS44S7AEmPYLQVASvvmKC2w1qlco21x7ENdB2sjcN/hdapHH1QvD7E6csR+2P/7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xd+rBaqYEApM56/XV9DmImDcsW2UzrhBCO/QD0z9shc=;
 b=rBtzycqITWl0rrSCJgDZ/D5NCjIJuIJKgGpEJTH7PBjqRRvXQ58AgkrTG38VG4QKqFKTZ+aqNfaPsHhdWlZvHm/trkYS92p4ddWWIBNSGaXeAOEJp7a2aqful/ulB0tcCWtYMVnUP+zjJG49VS/BaUQcpjATBDYTWhlWtKqgcrMInRj2wIiPj7aBOIA8srJJQ+FnTMPGOYyYPFvf6rXoFC+BGVbeSfThvYP6W0HqVFfgPRihCDkFUpb1Bd+AitsB85wT7OoXt6b5TNBGQ+4v+n/F2mdKz4NH9xlVAOBZi6rISMopzx8fgFRCu+jAaNhRudNnZ3KlnZj4vf+IOui5uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xd+rBaqYEApM56/XV9DmImDcsW2UzrhBCO/QD0z9shc=;
 b=f7MtaBzt3Ooq4MYzCzaHDUkfctLKmsuhRAHwvliDwdzr+cq4FnekM1SbL7jRS9gQ5xwaYbMsyG0HiKDeeFPjvT79GLJoECZCmvDHBtD1U0qveZVBoGkICnSTWG3zfZH1vNzrdc2nytzAPmvZgmwOr4vHWd4Qmhr8CJ0jmTLT/lg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from DM8PR13MB5239.namprd13.prod.outlook.com (2603:10b6:5:314::5) by
 CH0PR13MB5170.namprd13.prod.outlook.com (2603:10b6:610:eb::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.16; Mon, 9 Feb 2026 18:09:53 +0000
Received: from DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3]) by DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3%4]) with mapi id 15.20.9587.016; Mon, 9 Feb 2026
 18:09:53 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Benjamin Coddington <bcodding@hammerspace.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Rick Macklem <rick.macklem@gmail.com>
Cc: linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-crypto@vger.kernel.org
Subject: [PATCH v5 1/3] NFSD: Add a key for signing filehandles
Date: Mon,  9 Feb 2026 13:09:47 -0500
Message-ID: <945449ed749872851596a58830d890a7c8b2a9c0.1770660136.git.bcodding@hammerspace.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1770660136.git.bcodding@hammerspace.com>
References: <cover.1770660136.git.bcodding@hammerspace.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR01CA0018.prod.exchangelabs.com (2603:10b6:208:10c::31)
 To DM8PR13MB5239.namprd13.prod.outlook.com (2603:10b6:5:314::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR13MB5239:EE_|CH0PR13MB5170:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b338ac3-5cfc-4dfb-0a7a-08de68066cac
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7142099003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XdkkIb0Or2DyY76rWCBpelmEp6YtBWSE/TbmhDtJNC6CTh8Gi8TzxCzjViay?=
 =?us-ascii?Q?yzJrXO5XEgT/7ogFIA++ClJTIlHmJP0AO6oe4033JtQ58vKKXHcTUh6etWPN?=
 =?us-ascii?Q?jbu7DG/k3KWrbHlJ2Dj1wVw0wC0Kl4Tbt8QpD2zVj/6wbp8ybAqKA/g7+V76?=
 =?us-ascii?Q?CtneaFbr45hqastTk7ZHBVv4xHrHW8IVagWZLOvONu538ogIWTtDPEQ/AqDZ?=
 =?us-ascii?Q?l2+V20W0wBc8zDA1O2xdV6A2o59YI6p52OELycYwlkFzpDJJbNRnx53hqkDU?=
 =?us-ascii?Q?WvyixAEQ3VcwCC2kmGIltxYh/WEFG1RgrFUC02e1c/Xv80B33rTh2dG4Sf5J?=
 =?us-ascii?Q?h8Lq+tVgMBveTyLSe9QJ3s87MqckiHN5J81/KH1iZf2LHvnbUwksgPKpEEKm?=
 =?us-ascii?Q?68Fkm8GAnaZ51tfROnAaomnjzmtIIAQTrZiIKmWaMY7AS1VSSknpuDGa/9Xh?=
 =?us-ascii?Q?9WTnXpHWZ3hH3w4x7xdy61pbdZpBshYEn5rgIYG14QRKfG1fGwniDCk/NHus?=
 =?us-ascii?Q?tUUzQbKrFoUhpUHxJaoU3orcAxXqr2cRSFzJBY08WA8EtqWtxDn6f0MCexjA?=
 =?us-ascii?Q?Lcb5LadFtHRbiBVZIKS8QykUBCBhLkMeYV9rl6rEYw4xA9XgQzytOxYPLl0J?=
 =?us-ascii?Q?SB0Y3v3De7xq2zLy15qtzCE4D+kCcy3+B78cYB98jSUQA6EHaFtQuT09lqO3?=
 =?us-ascii?Q?WnXZ5yTIzdXi8iIz9zmFu1tvzY+AlWe+dE7/LT0mCPmiw/TJxj8wAtAywa4K?=
 =?us-ascii?Q?SRPobCKT0wLXp/SxZxBfZMMrPKNxWzaWN++80JBkB6GWHJvMppPfzBearhox?=
 =?us-ascii?Q?+lbt1iNxmv51KLnWhaY/GB4yAoEc5WfE7wfuFJ5B7cvJGLntB4gWjp2dMUMT?=
 =?us-ascii?Q?Y22vXI8BVfNQ9rK8FPdykDAAuvzETKatOp62oMUGmBjIYGBUQS1XckWnZzpo?=
 =?us-ascii?Q?4efjI+b15KyNP+AN6P4mNeiassGncBaxhDkr6yZwLjhlZCjkpbJZ1kB2euZV?=
 =?us-ascii?Q?0RWRSS30+Bj32foaIyVYRxRs8BRcCfJB3Imwibx0kl4A703ReWMrMMGzKTxG?=
 =?us-ascii?Q?Zl3WiP8tADKwHplQTigCHWImxGm8Il6o6JGRUbj9vSd3VX/oSqOiNGHWxtX+?=
 =?us-ascii?Q?IkISwjB7Px1uiRDiFhg3BUXZN2LaBLS7+9T1H9SqBVp7BEOcUbuI7Lfby9rf?=
 =?us-ascii?Q?JPJ5deL3nXYXINpX40UJo2PiuNtNnvIVwYhWxJ+lNy+2t1sAr4m8zfyvwu/h?=
 =?us-ascii?Q?DoAaPC2Jl40KIp4AYxS++wsICeQ4gCngGphwA0L73meg9iBdrrJB3zqm7DMg?=
 =?us-ascii?Q?IEq1SCC2W7AL9Y0UkSk8CBQqCvs5BqhxcqbWbea5ho8N9hdJpN9AUwsgksEe?=
 =?us-ascii?Q?PDTKfw/ALXUcT4WH17jNGkwy/+dR7944vAL4W9uoQ6MEgJGOgtzwcHAyeAZN?=
 =?us-ascii?Q?r8QtXqK6mOzKsuvCaCy5krVx3QQ3bRPK890V0NlZWXlNwBwBuO3PcTyu0cBb?=
 =?us-ascii?Q?moWneAbD/vG+c0apHB+TNVMZNaI57l2jGtaDlbU0+ZIm4X7hMz61cdF8amuW?=
 =?us-ascii?Q?fJ1YrHODyRE5cguN2lc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5239.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7142099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TE4FCXcDUo5git2Kq/FJkmPVHXhodwWAAEuXe5/ryu32Xnn//pldyt06pArx?=
 =?us-ascii?Q?cGO0iLeI+ypB0zuCJZ11b0FS4vv2rbrpA2cXxhFK5LlnvTcZHftrwOxX0DTL?=
 =?us-ascii?Q?HjTOMACxYMvbycEr1ch5c1rRsiGIEwLz6Wx/ZLd07IZ+u7IM2i0YAeRGhoFe?=
 =?us-ascii?Q?JWYpG8BxMt0CM1vFXKYf6MdVF/JUllc2tjdxx74REPuRLOHAV2KdM44FEVwa?=
 =?us-ascii?Q?SuzU5VSPbSGdBdoiGq5LCPE+7m6Ww5md/466NOFVHXzJULkMlVJi69Fa7XZQ?=
 =?us-ascii?Q?xbgy8jZ/pJ1Lo5d9mbg8b17qkM7xGX2KOxBZM6Esbq2gbMx7xQcndPzDdZY/?=
 =?us-ascii?Q?IbJD+OiBmHJJnRgCXi1zBy+xEvBvPgP0p/SlgOLUZuexJQfoInvO97avfPBT?=
 =?us-ascii?Q?gerszzOUTa2NbgSeVWXWHMvaE5JKiB7THjxuMpF+bdVG6mgZG+yVZTZ2XoTy?=
 =?us-ascii?Q?ZZ/vETOa9Ue6aUGCTBD1i6Ks4Sl3fCR6d6sOrfOGtHjzUEDlBWqVpLGPyHbk?=
 =?us-ascii?Q?7/wBngtQrVMPkPGugXetitHqzBaKbSewdnGLa/61b0jGnzU2C4dRsfGOeQIY?=
 =?us-ascii?Q?yyd8yv+04CSVNC3scDRz8vSPGrkGM4GTvIKOtlenzJ0EFvr9H06jZuqmnkRt?=
 =?us-ascii?Q?YqEB1/CsOaHI6+SqdiIlIveUEgt/2zHWhawf2hhuhnupLCaEJQND2PmqD/NR?=
 =?us-ascii?Q?ElemLhWxOOuLgTfkFZcLEquXO0uxZXp3OjHOXYNLzvBnVRhPYc/TFGnqPulc?=
 =?us-ascii?Q?9p/Fn2VEdMD7ZNW8suF6YJz0rrnglCSLGfLOCdybOPMjjcFK2WLOQQ6muDFu?=
 =?us-ascii?Q?YQKbNDHuNojw/1PLkfmiXDnK6poikVZRNDp6uPRQhzGhpso3Yv7lGxVhRVbF?=
 =?us-ascii?Q?Qw4LCwWm/ol/mcuIS0dDlk+adB73CiV9HXyaT/Beu5yVSjT94iW8ZxhSG95c?=
 =?us-ascii?Q?eG4Wjx8oQ7cfDwQYStbOV2465Pc56Ds22nCWbN3ur/JAQVMpwrkrFTuqT9GI?=
 =?us-ascii?Q?i5jBONbE4MyHdpnDotpiBUN9kkeMplFf9BigHvqi80X0jf2iJvO4Oc9KuvkJ?=
 =?us-ascii?Q?jPeL9hfG00xRK5VqG2cxLXDabenJROI8Tuvf5VAsHQDbRGkC/sbccHOHWYB5?=
 =?us-ascii?Q?Hif42+qt795193/Bv2v6zZQP+IkGrT0aW0eZ/xcCAD6q69EUA6YY/J7SU5RQ?=
 =?us-ascii?Q?8fE95rIAJ7X2cjYLBskbyd/mJjLWowG7XbPcwh09BxGe5++H9OM8wAuQu8H4?=
 =?us-ascii?Q?XLFOdAq3fOs0CqX2+e11B4FruQGj+jAmUMBAB2JIFOXI041y06jwvamj2O0M?=
 =?us-ascii?Q?fY0pYbsPB7vcQBW73JILPEcUVu0jJbgJ6OnzmYNAjIhqyCHpmiYz1V9nn6Uu?=
 =?us-ascii?Q?sH+c5YgcQ2JDbf0XZuv3xDAtV4V1U7X38TbNaquEs2puXZckYE+n5+6loF9S?=
 =?us-ascii?Q?DRaFVWluiaWTvT+97nlvfm2pgtl9o+Xv+kSwP7mh42O9r4Sgl3+QPwXk7DJJ?=
 =?us-ascii?Q?IJrWhM99zeM7ejzUwS1NcZ8lc1Qg1zlhZ2FSm0EOvZ2yii3o/ZXQJom8DF1N?=
 =?us-ascii?Q?konJyIGDUXe9lerm8F0TcN0gC7bGDpEqFrBVGolvSlLgt8M1K3hpgsBRpG2m?=
 =?us-ascii?Q?JQCF255Wv4+z09oRJN5adoeqCeFBTOUJhqnoMfdk+ERixYJLP+QLxhPoDwHw?=
 =?us-ascii?Q?QuZPKmfX0Hf2HeRaOOxP1fgmBHgigYx8nvpnH2L4l/T5iQ1mUTIQetKAqoyo?=
 =?us-ascii?Q?SmdlugtgiTyfsAuiZF5Dpls95sjjpao=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b338ac3-5cfc-4dfb-0a7a-08de68066cac
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5239.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 18:09:53.6653
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7aE9WlTaR/B+mf3OdNQzVUEVNHf2UKZoL7sjP16rqqd2a77bJqq/x+kYTe/YcCDORscNp7vXk5DPUuFig2+OXSfSExtXJbNFVN0qe4RMcMs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR13MB5170
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[hammerspace.com,none];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[oracle.com,kernel.org,brown.name,hammerspace.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76725-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bcodding@hammerspace.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hammerspace.com:mid,hammerspace.com:dkim,hammerspace.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2B33C113658
X-Rspamd-Action: no action

A future patch will enable NFSD to sign filehandles by appending a Message
Authentication Code(MAC).  To do this, NFSD requires a secret 128-bit key
that can persist across reboots.  A persisted key allows the server to
accept filehandles after a restart.  Enable NFSD to be configured with this
key the netlink interface.

Link: https://lore.kernel.org/linux-nfs/cover.1770660136.git.bcodding@hammerspace.com
Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
---
 Documentation/netlink/specs/nfsd.yaml |  6 +++++
 fs/nfsd/netlink.c                     |  5 ++--
 fs/nfsd/netns.h                       |  2 ++
 fs/nfsd/nfsctl.c                      | 38 ++++++++++++++++++++++++++-
 fs/nfsd/trace.h                       | 25 ++++++++++++++++++
 include/uapi/linux/nfsd_netlink.h     |  1 +
 6 files changed, 74 insertions(+), 3 deletions(-)

diff --git a/Documentation/netlink/specs/nfsd.yaml b/Documentation/netlink/specs/nfsd.yaml
index f87b5a05e5e9..8ab43c8253b2 100644
--- a/Documentation/netlink/specs/nfsd.yaml
+++ b/Documentation/netlink/specs/nfsd.yaml
@@ -81,6 +81,11 @@ attribute-sets:
       -
         name: min-threads
         type: u32
+      -
+        name: fh-key
+        type: binary
+        checks:
+            exact-len: 16
   -
     name: version
     attributes:
@@ -163,6 +168,7 @@ operations:
             - leasetime
             - scope
             - min-threads
+            - fh-key
     -
       name: threads-get
       doc: get the maximum number of running threads
diff --git a/fs/nfsd/netlink.c b/fs/nfsd/netlink.c
index 887525964451..4e08c1a6b394 100644
--- a/fs/nfsd/netlink.c
+++ b/fs/nfsd/netlink.c
@@ -24,12 +24,13 @@ const struct nla_policy nfsd_version_nl_policy[NFSD_A_VERSION_ENABLED + 1] = {
 };
 
 /* NFSD_CMD_THREADS_SET - do */
-static const struct nla_policy nfsd_threads_set_nl_policy[NFSD_A_SERVER_MIN_THREADS + 1] = {
+static const struct nla_policy nfsd_threads_set_nl_policy[NFSD_A_SERVER_FH_KEY + 1] = {
 	[NFSD_A_SERVER_THREADS] = { .type = NLA_U32, },
 	[NFSD_A_SERVER_GRACETIME] = { .type = NLA_U32, },
 	[NFSD_A_SERVER_LEASETIME] = { .type = NLA_U32, },
 	[NFSD_A_SERVER_SCOPE] = { .type = NLA_NUL_STRING, },
 	[NFSD_A_SERVER_MIN_THREADS] = { .type = NLA_U32, },
+	[NFSD_A_SERVER_FH_KEY] = NLA_POLICY_EXACT_LEN(16),
 };
 
 /* NFSD_CMD_VERSION_SET - do */
@@ -58,7 +59,7 @@ static const struct genl_split_ops nfsd_nl_ops[] = {
 		.cmd		= NFSD_CMD_THREADS_SET,
 		.doit		= nfsd_nl_threads_set_doit,
 		.policy		= nfsd_threads_set_nl_policy,
-		.maxattr	= NFSD_A_SERVER_MIN_THREADS,
+		.maxattr	= NFSD_A_SERVER_MAX,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index 9fa600602658..c8ed733240a0 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -16,6 +16,7 @@
 #include <linux/percpu-refcount.h>
 #include <linux/siphash.h>
 #include <linux/sunrpc/stats.h>
+#include <linux/siphash.h>
 
 /* Hash tables for nfs4_clientid state */
 #define CLIENT_HASH_BITS                 4
@@ -224,6 +225,7 @@ struct nfsd_net {
 	spinlock_t              local_clients_lock;
 	struct list_head	local_clients;
 #endif
+	siphash_key_t		*fh_key;
 };
 
 /* Simple check to find out if a given net was properly initialized */
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index a58eb1adac0f..36e2acf1d18b 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1571,6 +1571,32 @@ int nfsd_nl_rpc_status_get_dumpit(struct sk_buff *skb,
 	return ret;
 }
 
+/**
+ * nfsd_nl_fh_key_set - helper to copy fh_key from userspace
+ * @attr: nlattr NFSD_A_SERVER_FH_KEY
+ * @nn: nfsd_net
+ *
+ * Callers should hold nfsd_mutex, returns 0 on success or negative errno.
+ */
+static int nfsd_nl_fh_key_set(const struct nlattr *attr, struct nfsd_net *nn)
+{
+	siphash_key_t *fh_key = nn->fh_key;
+
+	if (nla_len(attr) != sizeof(siphash_key_t))
+		return -EINVAL;
+
+	if (!fh_key) {
+		fh_key = kmalloc(sizeof(siphash_key_t), GFP_KERNEL);
+		if (!fh_key)
+			return -ENOMEM;
+		nn->fh_key = fh_key;
+	}
+
+	fh_key->key[0] = get_unaligned_le64(nla_data(attr));
+	fh_key->key[1] = get_unaligned_le64(nla_data(attr) + 8);
+	return 0;
+}
+
 /**
  * nfsd_nl_threads_set_doit - set the number of running threads
  * @skb: reply buffer
@@ -1612,7 +1638,8 @@ int nfsd_nl_threads_set_doit(struct sk_buff *skb, struct genl_info *info)
 
 	if (info->attrs[NFSD_A_SERVER_GRACETIME] ||
 	    info->attrs[NFSD_A_SERVER_LEASETIME] ||
-	    info->attrs[NFSD_A_SERVER_SCOPE]) {
+	    info->attrs[NFSD_A_SERVER_SCOPE] ||
+	    info->attrs[NFSD_A_SERVER_FH_KEY]) {
 		ret = -EBUSY;
 		if (nn->nfsd_serv && nn->nfsd_serv->sv_nrthreads)
 			goto out_unlock;
@@ -1641,6 +1668,14 @@ int nfsd_nl_threads_set_doit(struct sk_buff *skb, struct genl_info *info)
 		attr = info->attrs[NFSD_A_SERVER_SCOPE];
 		if (attr)
 			scope = nla_data(attr);
+
+		attr = info->attrs[NFSD_A_SERVER_FH_KEY];
+		if (attr) {
+			ret = nfsd_nl_fh_key_set(attr, nn);
+			trace_nfsd_ctl_fh_key_set((const char *)nn->fh_key, ret);
+			if (ret)
+				goto out_unlock;
+		}
 	}
 
 	attr = info->attrs[NFSD_A_SERVER_MIN_THREADS];
@@ -2240,6 +2275,7 @@ static __net_exit void nfsd_net_exit(struct net *net)
 {
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 
+	kfree_sensitive(nn->fh_key);
 	nfsd_proc_stat_shutdown(net);
 	percpu_counter_destroy_many(nn->counter, NFSD_STATS_COUNTERS_NUM);
 	nfsd_idmap_shutdown(net);
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index d1d0b0dd0545..c1a5f2fa44ab 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -2240,6 +2240,31 @@ TRACE_EVENT(nfsd_end_grace,
 	)
 );
 
+TRACE_EVENT(nfsd_ctl_fh_key_set,
+	TP_PROTO(
+		const char *key,
+		int result
+	),
+	TP_ARGS(key, result),
+	TP_STRUCT__entry(
+		__array(unsigned char, key, 16)
+		__field(unsigned long, result)
+		__field(bool, key_set)
+	),
+	TP_fast_assign(
+		__entry->key_set = true;
+		if (!key)
+			__entry->key_set = false;
+		else
+			memcpy(__entry->key, key, 16);
+		__entry->result = result;
+	),
+	TP_printk("key=%s result=%ld",
+		__entry->key_set ? __print_hex_str(__entry->key, 16) : "(null)",
+		__entry->result
+	)
+);
+
 DECLARE_EVENT_CLASS(nfsd_copy_class,
 	TP_PROTO(
 		const struct nfsd4_copy *copy
diff --git a/include/uapi/linux/nfsd_netlink.h b/include/uapi/linux/nfsd_netlink.h
index e9efbc9e63d8..97c7447f4d14 100644
--- a/include/uapi/linux/nfsd_netlink.h
+++ b/include/uapi/linux/nfsd_netlink.h
@@ -36,6 +36,7 @@ enum {
 	NFSD_A_SERVER_LEASETIME,
 	NFSD_A_SERVER_SCOPE,
 	NFSD_A_SERVER_MIN_THREADS,
+	NFSD_A_SERVER_FH_KEY,
 
 	__NFSD_A_SERVER_MAX,
 	NFSD_A_SERVER_MAX = (__NFSD_A_SERVER_MAX - 1)
-- 
2.50.1


