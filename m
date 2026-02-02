Return-Path: <linux-fsdevel+bounces-76060-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kA1WAsfPgGlBBwMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76060-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Feb 2026 17:24:39 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 714A9CEEAE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Feb 2026 17:24:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 673AD3019149
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Feb 2026 16:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B79337C110;
	Mon,  2 Feb 2026 16:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="Bs8QoGAn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11020136.outbound.protection.outlook.com [52.101.46.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A44358D13;
	Mon,  2 Feb 2026 16:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770049193; cv=fail; b=Q/AMc0pAI/UY4DgTyWU/qQSs7/RcNVi6fSv8xZzCX34cw/bTpQRcfJaguePRiXHdJ8DdjqyO5mub9cDnPD0IezIQRbdOsUXz0IBkcuVmJe2nmtWy0PwGNt2DrseyjwYjxjsgEMIwYF1ASROpfcJ+KNtopWOMUh+guCsE9+VaDQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770049193; c=relaxed/simple;
	bh=c6DawMCC9w4HtCcvrHCUT1n/W73frlxwBfXkdOvFfDo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L4OiVm9CoHFdrMRyo3Hy5KJ1tODbo6Uwr6+8M+a1GSL3/lZWKaXtHlFuQGNkg/xlV/JRn1DIU+0wbCxm2PAgcupda31JIxU1xERTMkpAwOoa0G7ZpzD0L/lgYnL41/2bkYSyTBf+tuXFoXD4frSgXnvmXZ96BfPnIqb4Ezlbut4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=Bs8QoGAn; arc=fail smtp.client-ip=52.101.46.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EWixXsG9k2JunJM29ZxXr/weo3ap565YO7cZtrYuUeQXAPhGCF0smii2QLq3jElbU97C+ObZT4IquXc5TxQ7mRAIyK0nZeCcjdsgg+0Fpijj3mfi5x43O4+haa+dcvY9hHr5xWRFe2SwK2FK8NH9ockjrmTec9MXtFGI1eHuynH9sb+evMv3pPzpeadHnAOfWeRZLkLak/KFGMOXrQd5pSRtemii/6X8+4tXykwlyt2rkVa4apTqblNPIq+kffv9bSJq8wV2unMgbG62TrHV2HRgJ7Ozhj18dzKwcPkyfXsG2ACtAvja8vJ38IKgM6r+H3ZpNhcb5hTkQZLzNInDZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UbYIhU3I9oqYVZnR3J/KzQ+T5O1vihuiHXLIwe04CE4=;
 b=s4FXmrmjHpvxpNUCghyIZBW44spnT1eq/YCpdh9g997vp/bpPWhM4zXar6I5RrrkV7BaDVN1FQKy7NWFXPiPjTI9jVRqr4ChJAOIOQ/LMJgwKqMuk6PaKeBCKrVNi4OeadHPE4p5v+fT/QFMQf447+vLhykVFvDYLYD+3f8/jy5wnaifKTJGyyQBjY8nZBiojTaD3nVz9dg7Xwf8BFMIfF+ndhNjQiEOT8PB2C5cI3/iaUz/k0gd/FPbtCKzz9hEtp/V/8DXm2PnQDuI//MwYvixcIim1tGNfEJdE5ZuV0QZi0I9uHCxgd3XjwZgd+MPdf7uKO0WD2LEG7DNJw5y/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UbYIhU3I9oqYVZnR3J/KzQ+T5O1vihuiHXLIwe04CE4=;
 b=Bs8QoGAn2fk7Peb+sBVbh+k68O4r7FpIg9lCsatwWAJ/lQfULNfwQVvMgU75v11JcqB4Rzt/fO0+wg5Hf2tqVWjRwy2Rne40QNpRgbR59HkYytMwRl+mP/3TB5eBTRgnVnECXOMUUQG4UG0kP5j1HIMf5zByIOA72RuDYsRPi30=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from BN0PR13MB5246.namprd13.prod.outlook.com (2603:10b6:408:159::12)
 by BY5PR13MB4470.namprd13.prod.outlook.com (2603:10b6:a03:1d1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.11; Mon, 2 Feb
 2026 16:19:46 +0000
Received: from BN0PR13MB5246.namprd13.prod.outlook.com
 ([fe80::39d0:ce59:f47d:5577]) by BN0PR13MB5246.namprd13.prod.outlook.com
 ([fe80::39d0:ce59:f47d:5577%6]) with mapi id 15.20.9564.014; Mon, 2 Feb 2026
 16:19:46 +0000
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
Subject: [PATCH v3 1/3] NFSD: Add a key for signing filehandles
Date: Mon,  2 Feb 2026 11:19:36 -0500
Message-ID: <e3806f53c351c03725ecb12fb7ad100786df04f6.1770046529.git.bcodding@hammerspace.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1783bbbe-6347-44f6-5bb5-08de6276e0c8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7142099003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oYKXMxCxlIROmlxvK865VM4QgzwZGBtl2VI+1BqEk8TwagzbUn6QcpSrzwGX?=
 =?us-ascii?Q?gzwTATqST+HgdELBKiCIWWJdWx6sQiVdSDKrZDW6Ld5m16caWcOTjLL/Fsd4?=
 =?us-ascii?Q?wpCVBznIO3mhWmHcCP0teQcai/nicoLoFAsznSRUig8hH+PzIpLKxeQWXTZO?=
 =?us-ascii?Q?hHvZjtWjwblZYaPkrBfdCe9CR/PhKKj24gZWxBhf/F1HNnLZ5bopRC2TTpyG?=
 =?us-ascii?Q?NqizH2qPSGtu6y0UcXRNbkgxcztNuX/yDpEPK5sVXc1M1aP6MOMHdBX0NxPR?=
 =?us-ascii?Q?ZMjc3nhGh+XZ0qHdAOnA/gDqM+omp0/CgIM9Qzuk/gAP3OjIZ+E5azj+yb5c?=
 =?us-ascii?Q?xB2YOYouCDj11b+o9PsB8bQ20c0RtAy1pVJEW+LJwsE8z1hdMHD2Ii18RPMl?=
 =?us-ascii?Q?u+wswT/Ye8HB3P7qESbog65J7xX5+XCQbpFAMCTRO42PCNDle88s4A7Idhvn?=
 =?us-ascii?Q?weV0fMYjGyNce8PNnA0G8Jb4L5ufHZMfD+oJgmeFw8Zq+72t1mV0gexG1nKk?=
 =?us-ascii?Q?w4qxjXyJBxl6+MQn4otr355vFvtkthsOLLmKS06fX85Bmjfba1WiDJwqiZmY?=
 =?us-ascii?Q?8g6YSdkb0tNUojfb056eYTd5t0gqbeDoBOJ68UFI2NBUXuyOIiLfjFFeaWBa?=
 =?us-ascii?Q?wAeiZvzb/06a2HRh+sN6QLnGRGYWKg5bMy/BAjCBLNg6XoXeGDxN9MpqNMXf?=
 =?us-ascii?Q?kb4RT4FgfkDfl0WBqXwIA8hCzCrj3U310lyMTp4E5w7ExDNw2L/Yz1+KC7MY?=
 =?us-ascii?Q?J1+LIpyOb3NUBTLfaX+9pJIwbHDnoGLBwufW57+2asZMNIyCcGGJDzTet0MR?=
 =?us-ascii?Q?QX8V4ETNFec3UcGLLy46+GzLua5u7VUFT68YzDv2dpEGnXtNIlMoztkjtx4e?=
 =?us-ascii?Q?mvU6EvgUeiZD5XbSt0lGOcuZU9kNu+4cO71NpHgL4OpZXaBnmhgmuZBnadHl?=
 =?us-ascii?Q?ycidlZej+VOPk3Y7aI3DNsyIbca1gdoQuKuh7lKW7+c9wjwcniWLjIuv3nWN?=
 =?us-ascii?Q?Kcl9A5qOiOIj0n8OWkRwmKgvrrlql5oTNvjcDWCXc3/dqSTq9gUOaYVw4x1M?=
 =?us-ascii?Q?1mODvB4zCf0F6M6+ivqSGNiZ3Yb0SVgJmlqEqQ4NqpNlM5BpjBR0gPY3mHyI?=
 =?us-ascii?Q?sHYKnDTte17ggPABIEclCNQDaNSThpO8jbIhrgvd6W89u0dpw/fk1eQw0IhA?=
 =?us-ascii?Q?70ef38Lai2l51Sb1gsWH6nCY6J4b9KnS3bLEKN9TEe/amKhVfx0sR39UdkVX?=
 =?us-ascii?Q?HXphUHErs7/TCTEE/ppIA/vCpc8Eq78WWXxnr013hHYuK97lzo2N7olBUhDH?=
 =?us-ascii?Q?dxe1bR5F9ZOkeL2Virx7kJ4v5OGY7gbn/TY3F09T+uBW+PqfDqbLY+jrdY5c?=
 =?us-ascii?Q?MBOc4pCwiROueZAPqcpFc6NLWk7SQ6fYff2Vs41ds+HlWuaUw8K7Pd5tTCvU?=
 =?us-ascii?Q?l7aebJGYR2+0P0HGoUXfWo88XqwHxpt0e04w7A8HAMGa8MRwKUuBKvy7IjRz?=
 =?us-ascii?Q?vVtLjThN0wo/tSnTgh7T3zQNQ1dzCCZiYeKCWRDmS+N7ri4NF++L2n/xrVCC?=
 =?us-ascii?Q?rM6ZqE2fsehr61RrrLQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR13MB5246.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7142099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?smSLFVZCwrHP2G3pybMtpVgMNhMCmc/cCfZ4pmoMBbqcJ9rqIGtiNNYjTBQo?=
 =?us-ascii?Q?b+ZrEX+lnJUtV83frKCYD6BhWRQwE0apbuXYPrKiZD7bEBWAEEQKrfjZtASs?=
 =?us-ascii?Q?10jETTvbnh/Z+/5RUT7Fw16M6Uwhhj4Ak1ZQmIjEkfx7wWNwI39BObnD+kMy?=
 =?us-ascii?Q?kYlAlhOa1no75X88VG0wN9c2V8/javW8RRJPkADyYuF9nicLVXxDgMWU29Ec?=
 =?us-ascii?Q?vwEYuSotGLfJsBOLSR7foH0IQF2faWkMpp4sEejvPqHYbtgnv3ED3Qp+NH8x?=
 =?us-ascii?Q?HMY/wZ63cJLmJayOHESiyT+CnHGsOQhgjFPJnYFjxnLWLYRuCEIkX2ZRprm/?=
 =?us-ascii?Q?85TzLrTyL0OE8UvqFb3xjyCST17yLGLwMvVOMZFXyNHsMvTClCDfamKXzg2J?=
 =?us-ascii?Q?2Trx77momj1GKuyvDrD5wCB2aKzeJit79xVJL7ws9zhD89CiR816eovQkTRm?=
 =?us-ascii?Q?KJqXN4nDFrQEDAKyVgk/oLEkVWXiSQahY77/iIcRPCyvNPZ3sXHqyBECJ4Ek?=
 =?us-ascii?Q?I/xLXlFJOzsJwr02899NIcxcSZ6VZp5sEbNx3ZWX2aOiZB0v9gIz/eGsigFk?=
 =?us-ascii?Q?Jcl6EBT3lx257Sqe2su10ac50ht7psSKooIs8MEDxRpZt3EYdbU5D9M+Onsu?=
 =?us-ascii?Q?KuginA9zsyh9B+WVYaUsaFv5SthpaexK1LNg7e/aHTAlesqmM20EF+VNbMT9?=
 =?us-ascii?Q?FuItI2JwZpVk42ZxKtomV013fTX0vtDyPaHCZ3K+8j86uSaOgGcTksl9tzKm?=
 =?us-ascii?Q?rxZkGf0waDu+a6sx0NXATTami2bAB2d9Lzv9uPZaQ6KsKhxbyWtu1nMftQNV?=
 =?us-ascii?Q?o3fgWxEbMqko2Lqi5HE1oZv1HHfO7ncvTHk0Y8VcY7AnYfksixFDeFg6PCYL?=
 =?us-ascii?Q?Zm60D4NTgVgAWah6yMbDMIFBDh5HAbjnacKvCkhXs8ocUMdnJAMIHYDF9RfY?=
 =?us-ascii?Q?lhf0+9CP92s275wlVNRKgCY+JOukYQuIZmTS3RBJwLeAVGOeTOnZCZPig/JE?=
 =?us-ascii?Q?1bxX5nQASRhNFjFqB9VMmgoI9KSJwTVRKQmBGp8okzy5Sv+scJlTRCH9Ly77?=
 =?us-ascii?Q?j1/FrCiBOlq5f888iHffHsMzW4g9WAwlrUlIV6Y37apOm0Ywln4Pzop7+LkR?=
 =?us-ascii?Q?1/CmwEslfkawLmiikDvmzJP3murH/kLRtWBvvUsURikM/+jgM4k1+Ax6lxbi?=
 =?us-ascii?Q?ZPmQ7wMeeBCCVVKoz6z5skCQ8YjGuPDyb3FNyfBVtyiqwFIUHEKAHGDYIPki?=
 =?us-ascii?Q?5JPMm/oo/3WvgC8ed9r7LMrZlgcz3QRaLFee/ho/pEiuhm64Z3/c3uT/laR6?=
 =?us-ascii?Q?3eqfEXMkxrjkG17JFawoH8/4iQmg2fDOo6Cn1bKSZNMV4b5xvt99B9Cn+/g6?=
 =?us-ascii?Q?V603x+oL4OiC6UsVFGfJUM8so8tDIFZmf1iTwIRM36/j8IU71NTMkvKmgsPF?=
 =?us-ascii?Q?cFhdmDuDNz4TqtOH5AvXSzhaicAhlsiMo5zKmgvevMdruo0VB4sG6+rPdYJm?=
 =?us-ascii?Q?CpYTfZIufhlMP2EZ4FNqpNLOFi8D0qjLxIWRHGPtglxNzYA3hLOrUunRurqM?=
 =?us-ascii?Q?WZRk50NUXveterzUeb6+7JoQCMFQbg29qpOfeFq/PfMxMPmfFpbXoY8FSdVp?=
 =?us-ascii?Q?20ankebsW/d4WAK6RTGm7dvUnHCsrw/y7TyMiTzZg3BOmzfbpgPkIu3dKAVH?=
 =?us-ascii?Q?Bn3qS/cDt1H6bGjMFce+WVj6KvvL3tCS6GYFx3urrxH/zd5JU4ZFQuWp6Blp?=
 =?us-ascii?Q?xbI8wkboK7UwaNSYGkzswLkSbuW9+YU=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1783bbbe-6347-44f6-5bb5-08de6276e0c8
X-MS-Exchange-CrossTenant-AuthSource: BN0PR13MB5246.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 16:19:46.0930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IS+va+DGqIhlKrB6+YbFuiDUVoHua2Bx9nQTdhOoJqjetmi29eYPXaEgEY1pYrxoI/BCUZ4M4fJgSyuu4cmuzXzgWu2JBUTfofx9lWMMJxM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR13MB4470
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[hammerspace.com,none];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[oracle.com,kernel.org,brown.name,hammerspace.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-76060-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bcodding@hammerspace.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hammerspace.com:email,hammerspace.com:dkim,hammerspace.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 714A9CEEAE
X-Rspamd-Action: no action

A future patch will enable NFSD to sign filehandles by appending a Message
Authentication Code(MAC).  To do this, NFSD requires a secret 128-bit key
that can persist across reboots.  A persisted key allows the server to
accept filehandles after a restart.  Enable NFSD to be configured with this
key the netlink interface.

Link: https://lore.kernel.org/linux-nfs/cover.1770046529.git.bcodding@hammerspace.com
Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
---
 Documentation/netlink/specs/nfsd.yaml |  6 +++++
 fs/nfsd/netlink.c                     |  5 ++--
 fs/nfsd/netns.h                       |  2 ++
 fs/nfsd/nfsctl.c                      | 37 ++++++++++++++++++++++++++-
 fs/nfsd/trace.h                       | 25 ++++++++++++++++++
 include/uapi/linux/nfsd_netlink.h     |  1 +
 6 files changed, 73 insertions(+), 3 deletions(-)

diff --git a/Documentation/netlink/specs/nfsd.yaml b/Documentation/netlink/specs/nfsd.yaml
index badb2fe57c98..d348648033d9 100644
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
       doc: get the number of running threads
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
index 4d8e3c1a7be3..590584952bf6 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1571,6 +1571,31 @@ int nfsd_nl_rpc_status_get_dumpit(struct sk_buff *skb,
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
+	siphash_key_t *fh_key;
+
+	if (nla_len(attr) != sizeof(siphash_key_t))
+		return -EINVAL;
+
+	if (!nn->fh_key) {
+		fh_key = kmalloc(sizeof(siphash_key_t), GFP_KERNEL);
+		if (!fh_key)
+			return -ENOMEM;
+	}
+
+	memcpy(fh_key, nla_data(attr), sizeof(siphash_key_t));
+	nn->fh_key = fh_key;
+	return 0;
+}
+
 /**
  * nfsd_nl_threads_set_doit - set the number of running threads
  * @skb: reply buffer
@@ -1612,7 +1637,8 @@ int nfsd_nl_threads_set_doit(struct sk_buff *skb, struct genl_info *info)
 
 	if (info->attrs[NFSD_A_SERVER_GRACETIME] ||
 	    info->attrs[NFSD_A_SERVER_LEASETIME] ||
-	    info->attrs[NFSD_A_SERVER_SCOPE]) {
+	    info->attrs[NFSD_A_SERVER_SCOPE] ||
+	    info->attrs[NFSD_A_SERVER_FH_KEY]) {
 		ret = -EBUSY;
 		if (nn->nfsd_serv && nn->nfsd_serv->sv_nrthreads)
 			goto out_unlock;
@@ -1641,6 +1667,14 @@ int nfsd_nl_threads_set_doit(struct sk_buff *skb, struct genl_info *info)
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
@@ -2240,6 +2274,7 @@ static __net_exit void nfsd_net_exit(struct net *net)
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


