Return-Path: <linux-fsdevel+bounces-76061-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sP2+AdnQgGlBBwMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76061-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Feb 2026 17:29:13 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD4CCEFD0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Feb 2026 17:29:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1765B30B76C8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Feb 2026 16:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB40037E313;
	Mon,  2 Feb 2026 16:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="cYLWbBKH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11022119.outbound.protection.outlook.com [52.101.43.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E03937E2FE;
	Mon,  2 Feb 2026 16:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770049199; cv=fail; b=jiINK4qwCIrqmAqqSJw7a8sK4/04U7wqzVF3Eydt48+AvK8ITeadx/GdcQ/VR0yhs4Ga45Z9Twd6YykD8lg0kQCSUsxTZTcThSk5Hk1CVpKLt2kJrw81Di8bFGhOU23CreUQziUeeSXuHxL7K31M423wuR6IRznfAmuc4ujoNiU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770049199; c=relaxed/simple;
	bh=2h6opXGnP9DLgI2jpQsCXBHTCKyMN8RYbjqjqcQqdFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GdyoN/h80J918yPR7jS52vdazHq3LLjijzJRhiOVL1JgLKZyjL15s/3sYMokMd77S/IkDZP6xf8ADv6GWGxYkXXWAxIbvELhCINqctMqhjlMU5f93sSljA8hFsz7z75/k70chvHhnfT2CZc2ydKzhSHKLC5XB528qrwdTMt8URU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=cYLWbBKH; arc=fail smtp.client-ip=52.101.43.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iZF5fMkj4uovs5//1HCniJ/Uf+YEmX4X6pNm650Uh+ipo+u6MLCTVyDTeGXK+A6fISUYEaEdVTWFa0lBTZvCkKIOK66XxgrxAAjP9CC/WhmUca89EVEEtqln5du3MzFNNTMp/CObfbR/AwrB7a1lCLfQBcZlBFss/b0lGrhGTdENH7IHRefh+Vw/9qT+bdLes2lK6wsruYSCNaIL1zRzIk2s8EFxhetb/5/hOY5GpvH+Ew/sRvF7wf0DZThZdqYGVLg5HSqzAFZ9ONTEli8gHXJXA9SURZ6qGL3o1FeE00191cxecvPHNq0HKJf2g42vAQ9NuvMvhuzMaNb+TGiBIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ropcw7fFzaZnvlMXf5UzMnv+EeZEyKD6r0ka9sVqQ/w=;
 b=tQ2t5MLrhS1WdbP32Y3l5haCn5wH6HxKH4JNF5U/8s4pPbulFNBoVp/UIPcCVznlS5Ua5DCB4MOHYMe16F6m4HAzVn9oKfngoou0zNdvKSX0MxhyEq1x+ytltoVBDoudzsiJGCRGdoCbHOrRrzz7AFkXbhE87vs7jZnXp4sv/XaWPiiL1WDDUc3fEpkMY87faNNRbpZdYXopJ+obGNM3NP2DinEX617LYyHlwCHFN3zM2FGolKVcHTb0XOFAwJlq0GskKgiRz0bOTzVwlfLiZGZdf55Dr6Kk7ZSHIdcwKChu0ffTcAYXTO9ONGN6ylq5ciHNDQsJSwQwcoR0k8zLkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ropcw7fFzaZnvlMXf5UzMnv+EeZEyKD6r0ka9sVqQ/w=;
 b=cYLWbBKHbyoJcpKPPvLP+MuN93ghgh74loP9Y+BpOPLJ8pNANGwq3wiTB1ryDF+QgXoMehgJ+R6rprrMC5l01CdEYoW5GRlv7p3fD7oZVfeEgL8SKrnpyg/5eDSvPNeqWH1L/S2DgzBRwk/eiJhpCLaRJraz16b0Yn5C7QRORtA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from BN0PR13MB5246.namprd13.prod.outlook.com (2603:10b6:408:159::12)
 by BY5PR13MB4470.namprd13.prod.outlook.com (2603:10b6:a03:1d1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.11; Mon, 2 Feb
 2026 16:19:54 +0000
Received: from BN0PR13MB5246.namprd13.prod.outlook.com
 ([fe80::39d0:ce59:f47d:5577]) by BN0PR13MB5246.namprd13.prod.outlook.com
 ([fe80::39d0:ce59:f47d:5577%6]) with mapi id 15.20.9564.014; Mon, 2 Feb 2026
 16:19:54 +0000
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
Subject: [PATCH v3 3/3] NFSD: Sign filehandles
Date: Mon,  2 Feb 2026 11:19:38 -0500
Message-ID: <11253ead28024160aaf8abf5c234de6605cc93b5.1770046529.git.bcodding@hammerspace.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1770046529.git.bcodding@hammerspace.com>
References: <cover.1770046529.git.bcodding@hammerspace.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7P222CA0019.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:33a::22) To BN0PR13MB5246.namprd13.prod.outlook.com
 (2603:10b6:408:159::12)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR13MB5246:EE_|BY5PR13MB4470:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b79e9af-beb0-4d92-d164-08de6276e65b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7142099003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?t8tfByzRwK+OpaHhlP/F/Ld1LJzCj/13FAWqURKFg6I6h0iMUOJCZu0q4Bp8?=
 =?us-ascii?Q?beEJ+iBG+5FgS/hisO9cU/QXdh8HKoufFZkLFwTG8DvA39MqJwb7Ln3zPkK1?=
 =?us-ascii?Q?PbJyEQQ1QlSvsCzg4rljCL7Ze27aMxGwjTLoYdJfG77osrsqskrtJgmWIWj/?=
 =?us-ascii?Q?4Dc1+Q1r7bbi71kh6bS+/rbJ2Yz4WXaCGQsBhhBa6IsKenIepfndCMqO9DvK?=
 =?us-ascii?Q?cFJJaRhLp6nM6+jGFmBGQDPC17Z8AIEayiLAb/6f9xNmbOJdhJ6EU4cdNmc/?=
 =?us-ascii?Q?Kt47NW3J/FzGbQzDn5DNZzd040in3bYUYGtBF98iYGsvMLd4LY5QOvIW5+7C?=
 =?us-ascii?Q?KgLxxiWYIFSqScgIkRTN1BwUPrf7zHtXvCzZBBKNnof0Q+g501L0ZfgFUz2M?=
 =?us-ascii?Q?EvnTKIVuJCxVthYFSn7EovleamyWlttv/gcFBrEiwiZ+yAq9RihtiJCZkZ41?=
 =?us-ascii?Q?mbUCGQVmbB302KTE9N6vrTzKawlMgzASyX6+MjIcjbTbA4G012+cHZhsx7Uh?=
 =?us-ascii?Q?1JO5n/U6RbP5m5beuVXyw9xmz0mZM1I/DT1HDXf1RuqdDWY4cQKnUBvt1Rys?=
 =?us-ascii?Q?d+2uPCWau2bd1ZT97EoOKiui5owFaWf006NtXJaYuSIn/1HdTt3zXoBDzztC?=
 =?us-ascii?Q?xHNfL18O8RFLgE4ggkEmk+pVrHf6TKctNi5jncNyhwvsAqHyqabmF/6K+M1H?=
 =?us-ascii?Q?C2O3laHNZ2V5OvSIbjnbt8p8nt3vzP3sfG1WidK2svenYnVVY718f2Km72E2?=
 =?us-ascii?Q?/RJRWSqZRysaVjTTTGDRQmXf7bRGAUA3YyZj8B6EGfi/7NVlWJeW3cNeZa/F?=
 =?us-ascii?Q?dTr0avGtoud5l82w7bFQN6oOB1dLdRMxhIk4MdfvFeyjtlKf0rbErTGZgy8X?=
 =?us-ascii?Q?2VktCnlQErqJuDtlwtzl95MmWLD68LHszlSnBp/T3Ayf588mTBp08grT9ZSH?=
 =?us-ascii?Q?fZaBth68TTrv4fTtIkS7ZrYjepnAAL95cyabd7C42/ROaHUeekTkIvh8px9C?=
 =?us-ascii?Q?4WE2u/8qFPYxoc2odvF0v8JzECaze/Rp5eaMer7pA42ML/U2fSxVai32LVmg?=
 =?us-ascii?Q?sHu67KfLAVrNPD9EV1u22eWyYlPFux0HhfEJPVhS9YdS1Y3Ol/FZthajkrFB?=
 =?us-ascii?Q?4sFFbqyUWUY7EMW09PJEAg+tpVD+QndzdvcU3KpEZ3hB2VEASdYNDXPxHSNK?=
 =?us-ascii?Q?O1qCOjJoztrqCQOyT4aPDeVglDt0R7dgu0xzL+CpgWiyvTTe6bRo4LCHUb0r?=
 =?us-ascii?Q?SZ52z5t4Lwk3FhE2q/CR+rM2otMB6/qhq4HIVKVI1XwI54iwGhSThwuCM7VK?=
 =?us-ascii?Q?9NTdb9tP2behyWkiQ7EFUB+/GlmbrE8dYu/Ql0YarIdJPy2M33BkJb3iD8Z3?=
 =?us-ascii?Q?sObqMs8y7KAcO5dq58CJAiegw30uFSuXEbt8bKaukz241fZ4zcKVw8Hm1gwg?=
 =?us-ascii?Q?6mcBWXIgUUF41GK/UiEL2vv69Glbg225sAMD/jriXZRJFt0jH/YyDd/GeNxD?=
 =?us-ascii?Q?z+ZQpsijaNESXs0KKvxeC0h8e8zTOJsnj/m6TyE8MvBlEHeVmM5OIxZqGoC5?=
 =?us-ascii?Q?SFGMbsXazj17jk7Xo8M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR13MB5246.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7142099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eN7Aedy/acagnz+AgM0mB0ETJu4YDeqv0uCIYyiZN+Cay7WLcGQdOyUM2PSe?=
 =?us-ascii?Q?3/psq5FR35KBC5nO8C5qx3sIknZRPiGKDyiVEQKmlJqj9+ETdV5QDBr1tTtM?=
 =?us-ascii?Q?taizQnbz4rLaer5jSxU4Z6KqshIrbRqdnP5F/7TxP2SoeXX33E3ykIDFcZxe?=
 =?us-ascii?Q?PKGcuER8E4aicdIpqkgcDiGkqUIclKFhuRcZeVYbxKLt3Kiy0k0+78mhH4hT?=
 =?us-ascii?Q?yHElkUwPW+soszFwvUpdTsHmitqqXja2gvV+j5WPQJzhRt0FAs/4hwQqqiud?=
 =?us-ascii?Q?qgiUFBEff3VlYh82e21FGJOdrrJwlOG2lY+WW/9feK3LDCV2l+Y3r6T0A5rP?=
 =?us-ascii?Q?HRZl9yYUb+MQJeqyHWCG3hDv7qp/qtkdv6zHHw2yrTXaBN5KbaNCQLLaqL9M?=
 =?us-ascii?Q?lf5xJ66vyUXOlxCgW7hgESohUxUlSDYQdWVb3TFWLVzhnUY2FVvYYEo7bwW6?=
 =?us-ascii?Q?nA1zcSmBU7n0sO05Xph+kp+Xmss0TyFhmlg3n62ZI8FaKhjc4Xhb3hw+xqoj?=
 =?us-ascii?Q?Qh9IZpjNsYP/KnupFQQSUIaFNAUtTiLC0SdTJI8DL9CXGX8C/lQsgGitNYQo?=
 =?us-ascii?Q?bSebOSMzqSwCeUT81Z9Wxv3Xz3TbO2oe4G3jbNTXCbTkqJRM9gZlvV1zb/NK?=
 =?us-ascii?Q?9hQaLZmju+sTwjTH0LeOo0vPlvnT9zickX7N+SySk2U8e9zfA18+dxTvbCG4?=
 =?us-ascii?Q?j4VoQdF41oQg8vQIVUaoOtOgaHMwjV0a+LajVW+JY6dWSXXpfCmHybxUETvx?=
 =?us-ascii?Q?05ygPsK5wKeAAcp5J9AXaK8zlgoegw/nYt6Tt2bU6Q5u5t4tNZ/QsHLsd2bQ?=
 =?us-ascii?Q?Qnl9xUmoYyLJCnh66OBi2lbPE90uYRo65UoKYyGCMZzRznUXWLNNrjGI+5Hq?=
 =?us-ascii?Q?urNVH0wHWv3PExPGr4cNYkrtlKrKoawYAIhy3GMc6YKXpvYb08JnRmcVrVY/?=
 =?us-ascii?Q?KDcCzmPpquujZ7BvzefjSuwmajCIWmpRsDiens6uFw4tcSIzzMKcrid6W0fI?=
 =?us-ascii?Q?giqqhMSDlGEgCp5aaOvOuUXJ3AfOpkZr8/SMTglJXMKmT8fLjhi+rpBl2TZb?=
 =?us-ascii?Q?iuicBvYit1SRZfUrkx7wmrU0xp7fbAJ23sWusQN0dHPanEUnkG7iLoPtzdBm?=
 =?us-ascii?Q?EeEesFwXuTN3R3E69SZghcDo1kheYDh/rHyl9kfzOjZRYk7DBXuNStA4dOp7?=
 =?us-ascii?Q?X0/kDuf22pk/k/dvvngPr5DXL8EanWJKgQ3x7ObUKiU6fuM/TJJ3G9SllMXI?=
 =?us-ascii?Q?wmay1jGN9CsKN+yyT1bPMA5QP9UgL6dKxZwhBcbmcglWJq92brdK9Wh3zs6Q?=
 =?us-ascii?Q?wrpUe7N39tbeqsuWKhjYRYOoGU5Ue4iWVeX23d/hQjVCSZJakjIC2GxorPBV?=
 =?us-ascii?Q?eepl6AJPMUlw3u/56CDhpCNYVD1aKOFmbn1Sh+FLdK0sJmTQtfxBGYOYiAxI?=
 =?us-ascii?Q?RSSCHlB0Y3PdkIh6p7lJBPVNSiBVl1wMWJDUCqYK/5HemLm7R+9oN763AqK4?=
 =?us-ascii?Q?Y+tK1WIA30r6db7PcD/m6qZtl0CH2vN1eO9DMhGSs0Fjldl0dSIFVY0ExrxU?=
 =?us-ascii?Q?QaWxSbqlvabpLk5QliKPQxZ0NmRocvPd2WFQp6C/HtY4hMiewu2JluWkiZKH?=
 =?us-ascii?Q?Kd9BxsuaCWsDWByQZAcEZ+lLI+5H6ZarXvOdpzwCSBVlC3XIgeGqSQb4DtK0?=
 =?us-ascii?Q?uvttTqXVBa3GtUT/UvvM8jlcvZsQ5j/crceUQDB8bW6Ag8kgg1SoHSlie93A?=
 =?us-ascii?Q?sewNlS6mRocHjuU7/yuzAWLmcSXai+4=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b79e9af-beb0-4d92-d164-08de6276e65b
X-MS-Exchange-CrossTenant-AuthSource: BN0PR13MB5246.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 16:19:54.5516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r5s+OtehFuWXCkDziVvrnBpY0OFfrZVDoZZGOXb37FbDuHW19KRamisvWxeZH/HBARUi+cO6y032/EYN17pOQec8i9IBAACZM+ZIMbZiemo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR13MB4470
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[hammerspace.com,none];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[oracle.com,kernel.org,brown.name,hammerspace.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-76061-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bcodding@hammerspace.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hammerspace.com:email,hammerspace.com:dkim,hammerspace.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9FD4CCEFD0
X-Rspamd-Action: no action

NFS clients may bypass restrictive directory permissions by using
open_by_handle() (or other available OS system call) to guess the
filehandles for files below that directory.

In order to harden knfsd servers against this attack, create a method to
sign and verify filehandles using siphash as a MAC (Message Authentication
Code).  Filehandles that have been signed cannot be tampered with, nor can
clients reasonably guess correct filehandles and hashes that may exist in
parts of the filesystem they cannot access due to directory permissions.

Append the 8 byte siphash to encoded filehandles for exports that have set
the "sign_fh" export option.  Filehandles received from clients are
verified by comparing the appended hash to the expected hash.  If the MAC
does not match the server responds with NFS error _BADHANDLE.  If unsigned
filehandles are received for an export with "sign_fh" they are rejected
with NFS error _BADHANDLE.

Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
---
 Documentation/filesystems/nfs/exporting.rst | 85 +++++++++++++++++++++
 fs/nfsd/nfsfh.c                             | 64 +++++++++++++++-
 2 files changed, 147 insertions(+), 2 deletions(-)

diff --git a/Documentation/filesystems/nfs/exporting.rst b/Documentation/filesystems/nfs/exporting.rst
index de64d2d002a2..9d61e3b4fb37 100644
--- a/Documentation/filesystems/nfs/exporting.rst
+++ b/Documentation/filesystems/nfs/exporting.rst
@@ -238,3 +238,88 @@ following flags are defined:
     all of an inode's dirty data on last close. Exports that behave this
     way should set EXPORT_OP_FLUSH_ON_CLOSE so that NFSD knows to skip
     waiting for writeback when closing such files.
+
+Signed Filehandles
+------------------
+
+To protect against filehandle guessing attacks, the Linux NFS server can be
+configured to sign filehandles with a Message Authentication Code (MAC).
+
+Standard NFS filehandles are often predictable. If an attacker can guess
+a valid filehandle for a file they do not have permission to access via
+directory traversal, they may be able to bypass path-based permissions
+(though they still remain subject to inode-level permissions).
+
+Signed filehandles prevent this by appending a MAC to the filehandle
+before it is sent to the client. Upon receiving a filehandle back from a
+client, the server re-calculates the MAC using its internal key and
+verifies it against the one provided. If the signatures do not match,
+the server treats the filehandle as invalid (returning NFS[34]ERR_STALE).
+
+Note that signing filehandles provides integrity and authenticity but
+not confidentiality. The contents of the filehandle remain visible to
+the client; they simply cannot be forged or modified.
+
+Configuration
+~~~~~~~~~~~~
+
+To enable signed filehandles, the administrator must provide a signing
+key to the kernel and enable the "sign_fh" export option.
+
+1. Providing a Key
+   The signing key is managed via the nfsd netlink interface. This key
+   is per-network-namespace and must be set before any exports using
+   "sign_fh" become active.
+
+2. Export Options
+   The feature is controlled on a per-export basis in /etc/exports:
+
+   sign_fh
+     Enables signing for all filehandles generated under this export.
+
+   no_sign_fh
+     (Default) Disables signing.
+
+Key Management and Rotation
+~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The security of this mechanism relies entirely on the secrecy of the
+signing key.
+
+Initial Setup:
+  The key should be generated using a high-quality random source and
+  loaded early in the boot process or during the nfs-server startup
+  sequence.
+
+Changing Keys:
+  If a key is changed while clients have active mounts, existing
+  filehandles held by those clients will become invalid, resulting in
+  "Stale file handle" errors on the client side.
+
+Safe Rotation:
+  Currently, there is no mechanism for "graceful" key rotation
+  (maintaining multiple valid keys). Changing the key is an atomic
+  operation that immediately invalidates all previous signatures.
+
+Transitioning Exports
+~~~~~~~~~~~~~~~~~~~~
+
+When adding or removing the "sign_fh" flag from an active export, the
+following behaviors should be expected:
+
++-------------------+---------------------------------------------------+
+| Change            | Result for Existing Clients                       |
++===================+===================================================+
+| Adding sign_fh    | Clients holding unsigned filehandles will find    |
+|                   | them rejected, as the server now expects a        |
+|                   | signature.                                        |
++-------------------+---------------------------------------------------+
+| Removing sign_fh  | Clients holding signed filehandles will find them |
+|                   | rejected, as the server now expects the           |
+|                   | filehandle to end at its traditional boundary     |
+|                   | without a MAC.                                    |
++-------------------+---------------------------------------------------+
+
+Because filehandles are often cached persistently by clients, adding or
+removing this option should generally be done during a scheduled maintenance
+window involving a NFS client unmount/remount.
diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index ed85dd43da18..998332d93d05 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -11,6 +11,7 @@
 #include <linux/exportfs.h>
 
 #include <linux/sunrpc/svcauth_gss.h>
+#include <crypto/utils.h>
 #include "nfsd.h"
 #include "vfs.h"
 #include "auth.h"
@@ -137,6 +138,57 @@ static inline __be32 check_pseudo_root(struct dentry *dentry,
 	return nfs_ok;
 }
 
+/*
+ * Append an 8-byte MAC to the filehandle hashed from the server's fh_key:
+ */
+static int fh_append_mac(struct svc_fh *fhp, struct net *net)
+{
+	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
+	struct knfsd_fh *fh = &fhp->fh_handle;
+	siphash_key_t *fh_key = nn->fh_key;
+	u64 hash;
+
+	if (!(fhp->fh_export->ex_flags & NFSEXP_SIGN_FH))
+		return 0;
+
+	if (!fh_key) {
+		pr_warn_ratelimited("NFSD: unable to sign filehandles, fh_key not set.\n");
+		return -EINVAL;
+	}
+
+	if (fh->fh_size + sizeof(hash) > fhp->fh_maxsize) {
+		pr_warn_ratelimited("NFSD: unable to sign filehandles, fh_size %d would be greater"
+			" than fh_maxsize %d.\n", (int)(fh->fh_size + sizeof(hash)), fhp->fh_maxsize);
+		return -EINVAL;
+	}
+
+	hash = siphash(&fh->fh_raw, fh->fh_size, fh_key);
+	memcpy(&fh->fh_raw[fh->fh_size], &hash, sizeof(hash));
+	fh->fh_size += sizeof(hash);
+
+	return 0;
+}
+
+/*
+ * Verify that the the filehandle's MAC was hashed from this filehandle
+ * given the server's fh_key:
+ */
+static int fh_verify_mac(struct svc_fh *fhp, struct net *net)
+{
+	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
+	struct knfsd_fh *fh = &fhp->fh_handle;
+	siphash_key_t *fh_key = nn->fh_key;
+	u64 hash;
+
+	if (!fh_key) {
+		pr_warn_ratelimited("NFSD: unable to verify signed filehandles, fh_key not set.\n");
+		return -EINVAL;
+	}
+
+	hash = siphash(&fh->fh_raw, fh->fh_size - sizeof(hash),  fh_key);
+	return crypto_memneq(&fh->fh_raw[fh->fh_size - sizeof(hash)], &hash, sizeof(hash));
+}
+
 /*
  * Use the given filehandle to look up the corresponding export and
  * dentry.  On success, the results are used to set fh_export and
@@ -237,9 +289,14 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct net *net,
 
 	fileid_type = fh->fh_fileid_type;
 
-	if (fileid_type == FILEID_ROOT)
+	if (fileid_type == FILEID_ROOT) {
 		dentry = dget(exp->ex_path.dentry);
-	else {
+	} else {
+		if (exp->ex_flags & NFSEXP_SIGN_FH && fh_verify_mac(fhp, net)) {
+			trace_nfsd_set_fh_dentry_badhandle(rqstp, fhp, -EKEYREJECTED);
+			goto out;
+		}
+
 		dentry = exportfs_decode_fh_raw(exp->ex_path.mnt, fid,
 						data_left, fileid_type, 0,
 						nfsd_acceptable, exp);
@@ -495,6 +552,9 @@ static void _fh_update(struct svc_fh *fhp, struct svc_export *exp,
 		fhp->fh_handle.fh_fileid_type =
 			fileid_type > 0 ? fileid_type : FILEID_INVALID;
 		fhp->fh_handle.fh_size += maxsize * 4;
+
+		if (fh_append_mac(fhp, exp->cd->net))
+			fhp->fh_handle.fh_fileid_type = FILEID_INVALID;
 	} else {
 		fhp->fh_handle.fh_fileid_type = FILEID_ROOT;
 	}
-- 
2.50.1


