Return-Path: <linux-fsdevel+bounces-75122-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qNFFIjpecmnbjAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75122-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 18:28:26 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2980E6B453
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 18:28:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7106930F6C55
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 17:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A098E369964;
	Thu, 22 Jan 2026 16:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="QuDexhta"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11022124.outbound.protection.outlook.com [40.107.200.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30483363C60;
	Thu, 22 Jan 2026 16:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769100877; cv=fail; b=PnKaZou03jbd2CBB+qPrqzveEyvPpwpkWbCYG1S4Cfy52FmAnN7wyx8tFGv5UlGIp9lgmpmhUoUedi6ro22Kq7JVRLQMlMFbP0KCgRqA/tiPQ93In3fSEJ/GSLU6FRMVTajKGNEj7ETwZdPkyG+GvU0xszwbukmtrP/k41xD70U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769100877; c=relaxed/simple;
	bh=lYAUN6abBYrRjPO5NV5DuSDSBbn8cfXN4D6CQ6NoDV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ROkkqzvS5qihL3rRRfEW9XnFvrVa+Vau71lBIlncqQ+Qgk5UOUerKTOeH9yMctlqMc0bv4nsIFEPB6SeGDxM/GaVCRIQ+r4hcVuT53RYAB2ZYQqJ3TEizRVKb4/Ln8hu0sqYluxTkvnlhPiMuRWqSbswktv4J5bscK6xlTx/zqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=QuDexhta; arc=fail smtp.client-ip=40.107.200.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BptGn7pmzAjz2WLcB4E+PIUFvi/kKZCsRg1eu20/sibwQkhKcQadFvzl6QEmaIJgL4BiAEMjIvgi9KmkvjaPqakKRiq02IARRfDFqZFsB15VvAb4yrm9hxOu1nevbJO8Xfq5MhopZ6+mPqO3Tqp7gI5/YxLlUyudc4jnXZAvvlCG2XW1IAOK/vHZL+I7Ne4gS3gagWc6P4kNOL+qgD0ZwAmF/hXiRaKYobkftoydZ6/dLeL4smPCZvTQIiUEGkVXOV+Te2RHMts1HCwe7MYGmEaL5IEZ9hZwmeBdcMOEAbMYe0J5v7MW0bvAp9P2Y13voLJznc9XY7Vc2ZX3iqs3cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XGKdk3uewItU8YHLxWGElOG5P2POvjcQE/9l2gJ17AI=;
 b=yGLoBsMSoznDK23KHju/4xGfFXWpYnKUl1L7Xb5b1Boc/E6vMXVqn9riTzBnFtA1Xmo75A0yiPEF2EMDaDieqeVlSBd8EkoU73HQWYfmnV941yg2890ncimJGwcD4cUCvyDyWh3BTYLpg+CXEHyW3HBDik2eQhFZ7oG8uM6ExuWRiAV+VohVys+w1P6JGCfcRAYiTsyfRxR9r+wJoDh1m1x6MwqMYst2ipuaGLMA4vU1VybhAv0ryZ/Ldaps84XNUsuedft2sB8lUSoa8CvY4pItLAOk7Mt9n74Moqv4/Q+Vu9b/oparhFmK2NYTQoEMaRhRSszj/ntoiKjRuz5ISw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XGKdk3uewItU8YHLxWGElOG5P2POvjcQE/9l2gJ17AI=;
 b=QuDexhtaqWGBTNON3pPP6HANaQQeLFeOwljTI4bGVpiPOGHPp8fmenBnkbAcCdA/jbhguaY0q7Vy6IoL+H+BEcb65ZMpKrIWEKd/2uqqfTrnnPapkhUdIxgnIopikwNCpcAlWbmxZLHwZnu2Vw39FlMk34U9wWL9M50cdHkrLYM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from DM8PR13MB5239.namprd13.prod.outlook.com (2603:10b6:5:314::5) by
 BY1PR13MB6781.namprd13.prod.outlook.com (2603:10b6:a03:4b4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Thu, 22 Jan
 2026 16:54:17 +0000
Received: from DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3]) by DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3%4]) with mapi id 15.20.9520.011; Thu, 22 Jan 2026
 16:54:17 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>,
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 Eric Biggers <ebiggers@kernel.org>, Rick Macklem <rick.macklem@gmail.com>,
 linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-crypto@vger.kernel.org
Subject: Re: [PATCH v2 2/3] NFSD/export: Add sign_fh export option
Date: Thu, 22 Jan 2026 11:54:13 -0500
X-Mailer: MailMate (2.0r6272)
Message-ID: <B364CDCB-39A6-4C51-A562-CC52CE22C059@hammerspace.com>
In-Reply-To: <29da00c72005812ca83954e8f2af91248b5bffe4.camel@kernel.org>
References: <cover.1769026777.git.bcodding@hammerspace.com>
 <7202a379d564fc1be6d2bfbf4da85c40418d9b07.1769026777.git.bcodding@hammerspace.com>
 <801018d9115ea8abb214eaa74d5000c6f7f758a4.camel@kernel.org>
 <0597653E-1984-4D2B-9A47-9BAE3A8E7A8B@hammerspace.com>
 <29da00c72005812ca83954e8f2af91248b5bffe4.camel@kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: PH8PR07CA0027.namprd07.prod.outlook.com
 (2603:10b6:510:2cf::25) To DM8PR13MB5239.namprd13.prod.outlook.com
 (2603:10b6:5:314::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR13MB5239:EE_|BY1PR13MB6781:EE_
X-MS-Office365-Filtering-Correlation-Id: 2440276e-9c58-4233-798f-08de59d6e13e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZScaG1/hjbGHHmqiaUZdKaN4r8UzCGGta4q9GucETLGCGIBKV3npUcZUDf9D?=
 =?us-ascii?Q?8ciUpKr94l2VZmOkA3Kq+4OCuW/VdeJAJ1tidldVr8MqJFFlqeN2ykRjmroQ?=
 =?us-ascii?Q?iPFoHaqtjQp+PhPL2r9RUodcxqUilenfv4kuqI4JjR06705HDxfcU3gDO6/M?=
 =?us-ascii?Q?0Isq15ncpb2FmxpZHwt1vBsUmsZhwRiRvBOR4nTJAcaG9qdwDpJKWeKjUlH7?=
 =?us-ascii?Q?2LuFaCM2QrREb6jQnZRxZorTl8XXzLy4/xkgnSKAxGgluBWhMjQUIHKPxQSD?=
 =?us-ascii?Q?/nbWlntuJCHMPJLmOkywf1B4pszlagqFNHidHV5nlET786dZd1Vdye3A6Dsl?=
 =?us-ascii?Q?RYh/eieWLh4e3ky6x8p117WLYkl/0ypY9hHmrfOxzcnf4rsxGZFnZMkFXHJR?=
 =?us-ascii?Q?FAeypgtshK9GiEz59vEXU8nCxvxhRZCjEuruwvnHVR8EVbLrlOxdYk0tJLx8?=
 =?us-ascii?Q?LNJQaEzoSPYR2DMBtzRg7eDGjIYvsHEJ2//HrC+N7IWrG/th0rSNqM54yIh4?=
 =?us-ascii?Q?/disFRv3YJYIdmnRMYtXsevplvF6YN4yz5tu9NPLei4jkhSxqClLU34IsAEU?=
 =?us-ascii?Q?YY7+TRjsASNIarQLwiShKMlC55PGswpn7g2Ni9FrCTYkrlbe5kXmsBu28rVY?=
 =?us-ascii?Q?sAAguMCgrT4giDbUbzim1EYIFwJ15ugqsXaSggY5r3x9pLyuhM4dJQU9zTcm?=
 =?us-ascii?Q?fY8zOGlU0hvgfaurjRSfNRtDW+U4WKn+iVTQVeChz/2hSZRYznej3+t8NUrS?=
 =?us-ascii?Q?1kcEWBRMNxO49l+npsNfMKiqKNZ92qbFkS34YaoE2RxMAM4mEr26ORJlEKoG?=
 =?us-ascii?Q?buV+UdPa1Rt++cIuOQUKkDrVxRE4a40oIKIyv0qZtWtGE147Cxdd2P92NT0l?=
 =?us-ascii?Q?j8/XtSqGxPsiV6WMosIaf7DYO3lhkAWXsdJ5+Hrwd4b7smfoNBF3LdlfeWC8?=
 =?us-ascii?Q?NHdoeLlKWjbVkGwC2MB58cV16q3jLaQhiGd8bzQ5si9I58e2INt0tInn4PCF?=
 =?us-ascii?Q?VfftF0YOAkSgH0n8ZM9Dji9oolwQDNO0qHCjezcjWbBkEvfWZWVSYVZFZNNT?=
 =?us-ascii?Q?9Qjxz1kpqeq40kZ9l2PYs1LJFbJ8N1gLi7nkNqASpkqsTeW4IGNDks3qg5x3?=
 =?us-ascii?Q?n4N0oL01sMJQXJa20VyPDfMLhMhVZJkHSVb2Aqj3YMZcgfSbuBmy3EA0/dg9?=
 =?us-ascii?Q?Q4MsWXXBo1th3esGhBvrST55TAJt05TbBoXAPn2rRAw+ZaGAfy+S4qwjam6U?=
 =?us-ascii?Q?qZdFWkNfv6bJ2BpIC/dz+du2ou0q/1Va5/cH4A4j36HrXrmtdQmHuhBivx4q?=
 =?us-ascii?Q?iNXDigg+nR0ktwWrADJK8qGeYbrrnirkW7Y+t8Zv+YXaJAFhs23VpXV2vDHV?=
 =?us-ascii?Q?ltskaeOzVasDXPQV5u99cRQqTFaAGWS5FcYU9PHqzL+CvB//S4fLi9rpuwnL?=
 =?us-ascii?Q?OChKEyyiYFweOZ2ku4jRJWsV/jg/iUptwCMrGRDmu7BGY1giaWon2Pd9TS6f?=
 =?us-ascii?Q?2q0qlWOiz3qf72OPSZL9JFrEQla1AgD+ceM3FHQXBk+VXbCKRzNbJjdFddjK?=
 =?us-ascii?Q?ngkgUhK947kLzywgO88=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5239.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SyhXgE14UCgKG+s9dNiW/EfJg+vA11qn/wHp9PH5jvIEylCa51lBhUhYLti+?=
 =?us-ascii?Q?vMtT7Dxsw2/pdUdza4rVUdlEBvtvR4cEruq+OuBaTxRT04PevGiC0OeOJYKW?=
 =?us-ascii?Q?JTDYlo7XIoQ/Lf4F0QhOf3bXl4KDm/15Kft7hYahInhX1KvPhPRzmep1pbgG?=
 =?us-ascii?Q?/OMtKhfBEIyJoxwc4kzN7C2sHMSIfgKrCpxIh+qVd+a2vzKaDbp/QeccfAH2?=
 =?us-ascii?Q?47PTf7GF1BXt/DsPZPRgO2urQdVn5yqb6TPjXVwd0BWeWC/M1vTEdza8TgUQ?=
 =?us-ascii?Q?UbCYuohAy+zSx6hzjMsHWT745KCbBU7PHtaZsTga8wMcFog5mxztLIjlceyf?=
 =?us-ascii?Q?bYy/mbFHyB0yNAwb+WTQ+qidWVMHIfxQj6GfcglhpuksLBxa2URhseYCODG1?=
 =?us-ascii?Q?3ynB2QNEryMiarvZBsQssKnlqVO8bPxn5TbouLWetxK7wT83l7Z5+3CCt6iF?=
 =?us-ascii?Q?XVKnk4W/AIjvDtwPyMjqppd+5fSsLDPUJlSCmXfTUAH83BMITGj8/WSfwLQ/?=
 =?us-ascii?Q?hHJVI0ybafdKCG7bv4dWxbL4BuHf+DSDg+dMcaaRFTsCl+EFVL2EzXadzM/j?=
 =?us-ascii?Q?jWdvY5sz5oj9wrpQrAww5DqsAFanmpYkjVum2FrPiVfwsEnRDMxN9TINcagT?=
 =?us-ascii?Q?EsTtGclg6YR6nBEps/6v/u5YpO6+mlyF7Sw8aI7CCH5rbuFrgnuh211T1Nt8?=
 =?us-ascii?Q?a7+ytl3gMbg9NDBVigjOJYJlrqMN1HWNt0f4YUY6x6S5TYN/UFx27SvplesE?=
 =?us-ascii?Q?be4OUUGwUHv00NGJoz3bOgOUTQi15H7+oMz/Ifc2QnR1dJ4nXckrZJ2AIHqo?=
 =?us-ascii?Q?hQSB/BM0ypa1FPmv0ONBLnnHWzZ+GAWIHaRgW0f0pO8H8yl/3LA7klCbTOQB?=
 =?us-ascii?Q?Uw1QZiXJv1kAj8D2N95fzeO2AQMLMnWg+xfizKKhffcErXi1XcTp+Mj1Vq1B?=
 =?us-ascii?Q?pmsFlLzQl+jR1SAuseJ8rmyFtTM2NuG1WbWzzCz2SqXRUdZ+1wTR2Kuj+d4W?=
 =?us-ascii?Q?EfgsFKYkf+u79bJf+Db1TGjC5P3DA6k7pVN8XcCu6uWUXly1JDa+yIqj04ZM?=
 =?us-ascii?Q?DMcpgMerU++nNICtVrihEfdPZysCROzlE4ziygbMiFM17vsUWx8LcabqOrje?=
 =?us-ascii?Q?i402pmzwvmxJU0KKrk7MMtTeB8W1eztn8nKObHBBNfRK4qVBWotRj4uzUB5U?=
 =?us-ascii?Q?WCOrkZ2jKixWsukXlwbTSojSyIUijUKr+QNCxKVSr/56YQAioDfoyiqeHPe0?=
 =?us-ascii?Q?48kwYKA7DbocGyqtwglokGU+9nAy5gY8ADhrhtlBDTsvLbvRcGGVLK39Lfvj?=
 =?us-ascii?Q?LqcS6pdYdjH2E1t4b4ysaEBxtUDYZ1E6q1vXz6POrgmfeuK95JmrDSwtB/Lm?=
 =?us-ascii?Q?dQvOyxylZQrBZhwOvnp7fqjdoXeG9+R71iCupyk+eLd2OalXd6iNYGpD1Ouc?=
 =?us-ascii?Q?h+oTf2D7eK7f58ST8ucN5FCwh5Zc8WMGzH9264tu1J1DvwDkbzyL2RaJ4Kih?=
 =?us-ascii?Q?l2StT0LyAS8LaVN8qSXrA+QqvStWKuY6hjq5QQOJ5wk+Cquoj3EIR8LO+b+3?=
 =?us-ascii?Q?x2PPM+TtrrkDitpJuxsOrZWiA4D1lkORNjv9XMCaPgfhqr78PBCQoHjJltSx?=
 =?us-ascii?Q?vY0x8TYtzWji3yIRx4MjtRIw88p1iEjfGjg2M3sXrWeYWCbV7F31MyyRWEoX?=
 =?us-ascii?Q?acMYur66uH6V8/gdBLsIgQbbPTf85YnD+veHwlb80QpnFK84A8FQrJziVr6V?=
 =?us-ascii?Q?NwDSexkZWma7lty+djI9dJ+B0lExMXM=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2440276e-9c58-4233-798f-08de59d6e13e
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5239.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 16:54:17.1010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LIX7PFUG9Fo85aglkfHUHNIAAIag5TU0b0mfxJvWN4K+tZJ+6QRECT4rnP2f9sxwBnPEcQ6MEggb/Ap8l0S+Hf1gL8VMwwjnJoQ0vtQZTbE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR13MB6781
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[hammerspace.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[oracle.com,brown.name,kernel.org,gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75122-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bcodding@hammerspace.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.991];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,hammerspace.com:email,hammerspace.com:dkim,hammerspace.com:mid]
X-Rspamd-Queue-Id: 2980E6B453
X-Rspamd-Action: no action

On 22 Jan 2026, at 11:50, Jeff Layton wrote:

> On Thu, 2026-01-22 at 11:31 -0500, Benjamin Coddington wrote:
>> On 22 Jan 2026, at 11:02, Jeff Layton wrote:
>>
>>> On Wed, 2026-01-21 at 15:24 -0500, Benjamin Coddington wrote:
>>>> In order to signal that filehandles on this export should be signed, a=
dd a
>>>> "sign_fh" export option.  Filehandle signing can help the server defen=
d
>>>> against certain filehandle guessing attacks.
>>>>
>>>> Setting the "sign_fh" export option sets NFSEXP_SIGN_FH.  In a future =
patch
>>>> NFSD uses this signal to append a MAC onto filehandles for that export=
.
>>>>
>>>> While we're in here, tidy a few stray expflags to more closely align t=
o the
>>>> export flag order.
>>>>
>>>> Link: https://lore.kernel.org/linux-nfs/cover.1769026777.git.bcodding@=
hammerspace.com
>>>> Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
>>>> ---
>>>>  fs/nfsd/export.c                 | 5 +++--
>>>>  include/uapi/linux/nfsd/export.h | 4 ++--
>>>>  2 files changed, 5 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
>>>> index 2a1499f2ad19..19c7a91c5373 100644
>>>> --- a/fs/nfsd/export.c
>>>> +++ b/fs/nfsd/export.c
>>>> @@ -1349,13 +1349,14 @@ static struct flags {
>>>>  	{ NFSEXP_ASYNC, {"async", "sync"}},
>>>>  	{ NFSEXP_GATHERED_WRITES, {"wdelay", "no_wdelay"}},
>>>>  	{ NFSEXP_NOREADDIRPLUS, {"nordirplus", ""}},
>>>> +	{ NFSEXP_SECURITY_LABEL, {"security_label", ""}},
>>>> +	{ NFSEXP_SIGN_FH, {"sign_fh", ""}},
>>>>  	{ NFSEXP_NOHIDE, {"nohide", ""}},
>>>> -	{ NFSEXP_CROSSMOUNT, {"crossmnt", ""}},
>>>>  	{ NFSEXP_NOSUBTREECHECK, {"no_subtree_check", ""}},
>>>>  	{ NFSEXP_NOAUTHNLM, {"insecure_locks", ""}},
>>>> +	{ NFSEXP_CROSSMOUNT, {"crossmnt", ""}},
>>>>  	{ NFSEXP_V4ROOT, {"v4root", ""}},
>>>>  	{ NFSEXP_PNFS, {"pnfs", ""}},
>>>> -	{ NFSEXP_SECURITY_LABEL, {"security_label", ""}},
>>>>  	{ 0, {"", ""}}
>>>>  };
>>>>
>>>> diff --git a/include/uapi/linux/nfsd/export.h b/include/uapi/linux/nfs=
d/export.h
>>>> index a73ca3703abb..de647cf166c3 100644
>>>> --- a/include/uapi/linux/nfsd/export.h
>>>> +++ b/include/uapi/linux/nfsd/export.h
>>>> @@ -34,7 +34,7 @@
>>>>  #define NFSEXP_GATHERED_WRITES	0x0020
>>>>  #define NFSEXP_NOREADDIRPLUS    0x0040
>>>>  #define NFSEXP_SECURITY_LABEL	0x0080
>>>> -/* 0x100 currently unused */
>>>> +#define NFSEXP_SIGN_FH		0x0100
>>>>  #define NFSEXP_NOHIDE		0x0200
>>>>  #define NFSEXP_NOSUBTREECHECK	0x0400
>>>>  #define	NFSEXP_NOAUTHNLM	0x0800		/* Don't authenticate NLM requests -=
 just trust */
>>>> @@ -55,7 +55,7 @@
>>>>  #define NFSEXP_PNFS		0x20000
>>>>
>>>>  /* All flags that we claim to support.  (Note we don't support NOACL.=
) */
>>>> -#define NFSEXP_ALLFLAGS		0x3FEFF
>>>> +#define NFSEXP_ALLFLAGS		0x3FFFF
>>>>
>>>>  /* The flags that may vary depending on security flavor: */
>>>>  #define NFSEXP_SECINFO_FLAGS	(NFSEXP_READONLY | NFSEXP_ROOTSQUASH \
>>>
>>> One thing that needs to be understood and documented is how things will
>>> behave when this flag changes. For instance:
>>>
>>> Support we start with sign_fh enabled, and client gets a signed
>>> filehandle. The server then reboots and the export options change such
>>> that sign_fh is disabled. What happens when the client tries to present
>>> that fh to the server? Does it ignore the signature (since sign_fh is
>>> now disabled), or does it reject the filehandle because it's not
>>> expecting a signature?
>>
>> That's great question - right now it will first look up the export, see =
that
>> NFSEXP_SIGN_FH is not set, then bypass verifying (and truncating) the MA=
C
>> from the end of the filehadle before sending the filehandle off to expor=
tfs
>> - the end result will be will be -ESTALE.
>>
>> Would it be a good idea to allow the server to see that the filehandle h=
as
>> FH_AT_MAC set, and just trim off the MAC without verifying it?  That wou=
ld
>> allow the signed fh to still function on that export.
>>
>> Might need to audit the cases where fh_match() is used in that case, or =
make
>> fh_match() signed-aware.  I'm less familiar with those cases, but I can =
look
>> into them.
>>
>
> No, I think -ESTALE is fine in this situation. I don't think we need to
> go to any great lengths to make this scenario actually work. We just
> need to understand what happens if it does, and make sure that it's
> documented.

Got it - I will document this behavior in the commit message of the last
patch on the next posting.  I think I'll probably also add a check for this
case -- no need to send the filehandle off to the filesystems if we know it=
s
going to fail to resolve to a dentry.

Thanks,
Ben

