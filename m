Return-Path: <linux-fsdevel+bounces-76961-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eJGfFRO4jGnlsQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76961-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 18:10:43 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C00BF126785
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 18:10:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CCCF83029A56
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 17:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C33C346E63;
	Wed, 11 Feb 2026 17:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="V6s0s8Ha"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11023074.outbound.protection.outlook.com [40.107.201.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7941E346792;
	Wed, 11 Feb 2026 17:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770829795; cv=fail; b=s/PHqlngY/jgDAnCrQ6JX4wV3/IEpexrksj1bi+DKBsI9Am8K/aJdnuJod9zyRV2Skw1mqt4FDkALUxXEsdC2OIAFVX/xeIZvrBjLtQHa7CXPzeWitWgvUCaPjpGHKeKvgE+oy42QDm87S3RBEblOAaZ4KMfGdWZvMtPStOFkIw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770829795; c=relaxed/simple;
	bh=R/Uaud25m90G2qaVXe8s83yiM5OfCwQny9UlCC2m9xU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GOZy9uKqkoGTVO/ALuh0re2TKnrvC8x3fMt19xOgTV9IHktdRKTaXKfVLKJsFrQuWyxnTHJIW5LcQUurVNiemL+gJLOUU2IL6r/4247meNbQa1evUOaZpfIlDtBVlUWy6szaWzJYWt3KnU+nqNg7L3jAGBEOo0Jnu4A1DDRt8/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=V6s0s8Ha; arc=fail smtp.client-ip=40.107.201.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RW3g3otcqIB+VIyJw+df28In3P1gayJiqYMQ4+dadrV/DdiDX2tWZp4jR02a8V14Ei7MKtn8MuhCeaV3KChFdJD6aIJKURr6Ia0rom1C1N0DHauUPaVdpoPo/KQ5GkCIuesT1N/HdQph2mS0tqxqN00LNntxTXlZvWYO/arZqvvE/iYNYFa74lPNg0hCrbFoRuvOlmBW/Lud0pgEbBJkX5GwQMvewvSkWB61+BYUvuvms+732/01TqKh3UGhFLnnuO/sztaHwf++8hA/+VW8X3aKlVS5hVwoNOGItJ5Ul3HdSeGnczoe/4EldjG1w5EnjbF0v7uKp/33T9lVb9J+EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uzWnzZY9OlapPmitYy3m5OTzD3NtMYjqdeRsrzblUhk=;
 b=baMfiYZZns3QgU8eV8VVxDgaLVXnBeBecQ66Gu0OtDipM2VTAcCu8YcQFM0v9Qm5GVInxowpbJBUsAzhrx3j6ydiOmYi0EswfcvbcIl+9BarHonicT/gMb0mAmdcYxxGVoL5/lcTypMxXAOiBP8si4uwR8qp+qRz11061wQ07T1uiP82TmJ5tVdbDSYu1ze68uhYTR2JMzgp5ne23ZH0EvI1oMXJVbYH5fyx+bd8rPshVwpjqm+hlrpMYLJFsMn3WN7pVE7V6ho46sHYE6XdtQiA5vBWSv04CyQctrqkg0amNa211NZ16hF56amIdit9Azd6rtub0cnlWKnPRfvL5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uzWnzZY9OlapPmitYy3m5OTzD3NtMYjqdeRsrzblUhk=;
 b=V6s0s8HacBpyPhoiEHbKDAQbwLXdztHZtuzHY5tf/4+vT9UALe+j+4/eas+Ab7vWlS/HFzwdBkM/hDHNiq6GKtTFBQAudihd38wCffmR4FqtHmntAGFfdqUuQ1La/f46fxO18d7TjF7rZoTAmD3mdtfuB7bg9j47Z7K4A5l5ctM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from DM8PR13MB5239.namprd13.prod.outlook.com (2603:10b6:5:314::5) by
 DS0PR13MB6252.namprd13.prod.outlook.com (2603:10b6:8:117::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.15; Wed, 11 Feb 2026 17:09:44 +0000
Received: from DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3]) by DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3%4]) with mapi id 15.20.9611.008; Wed, 11 Feb 2026
 17:09:44 +0000
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
Subject: [PATCH v6 2/3] NFSD/export: Add sign_fh export option
Date: Wed, 11 Feb 2026 12:09:34 -0500
Message-ID: <e10c9b71fe3a430d171ed184a22fa186b28894c4.1770828956.git.bcodding@hammerspace.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1770828956.git.bcodding@hammerspace.com>
References: <cover.1770828956.git.bcodding@hammerspace.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7P220CA0084.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:32c::7) To DM8PR13MB5239.namprd13.prod.outlook.com
 (2603:10b6:5:314::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR13MB5239:EE_|DS0PR13MB6252:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a0d9942-a9b7-45c9-6c31-08de6990597d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?i/qTt1Nb+Fr3pJSV7H8cDGDS2l31vsLuWLTB2gIxjRqjZ8jWz8cPqkLLccW2?=
 =?us-ascii?Q?e9hwWlh2BOtm64Ovfy5zpKjVsmQmUzd7LXpCPI1TpzB0Lvp2Wcjjvi4aU8k7?=
 =?us-ascii?Q?jk3bN2S5Q3Igy471BO/B0oyeYWiigZ+yMJkvqHeOk1neckEHDytCJGXTN7hw?=
 =?us-ascii?Q?JL1GNFrF/PbZmNVXcycbxlsIW5Ho1uW5e7JG+AtAj3DRIjJuM20gyBhQKYQD?=
 =?us-ascii?Q?xyAlas6WUM3xjhHYEGXkG+auh+Pq+pMzDlMc/ZsTCIlPcFJE8o2H8ETMxJjE?=
 =?us-ascii?Q?6BU4fm08gkNwDaQfr/uHKiEI4YZJrmFHLkQ+kpudhlWYqt6xXYbiKt7RMgCJ?=
 =?us-ascii?Q?RnohVT5hK+KM8zqZHMLkysVMdS6XecakHSvw1jJM75x6/he+pnQAyYJpj678?=
 =?us-ascii?Q?zrrgDjSSy8EPUJ8bz5c/1MD961PMoVm/URaRsDA0QSUASI8RzMVqDhVag7Ob?=
 =?us-ascii?Q?w4xOTuXteNFNvLpVZyPJVN3KnkTEJtJsykX3sX+YnA+m6Y6CMXFOd9Q08R9q?=
 =?us-ascii?Q?EhHOWu0VoqUkaPkrpjZaRA1MoUygIaIQhVT18PnWHcZIWAJDPcdx7EM6/PaU?=
 =?us-ascii?Q?q9gZOgaeNkPc4vFCYtAiB/adRPSihiQ39Zk+7Oi/b5o5WwyMg+KzVHOMWuGu?=
 =?us-ascii?Q?79ik8kmSpiP3kjFbXDdDXbS4rcmeIHWTIArAgWhLPfdea2M2t25kaUoCIB2c?=
 =?us-ascii?Q?AGa/NFGWwTlLfKVdZ3p10mzzH/sh8C77+eibOFxojLm1oaSQMZ1rY1aFU6eN?=
 =?us-ascii?Q?Qavt11zgJDCborRLG/PMGV6zw+iKSI3xWmg4lourLsPMxW6lxuAUqGELCHxS?=
 =?us-ascii?Q?JMEUJ/ktjn+eD8ruzgJXynIUTY5Rkme+s4p09z7TUBj9qBS53CVQ3nOTFAR4?=
 =?us-ascii?Q?qJtZoyQilDSazr0UqRWBgqKmXkYsgO7o1XXYvYskaU+cRqfMtOaQtYStP6e8?=
 =?us-ascii?Q?kKZz+PXr0tXEwHzVU2KfAjZjTpVX1Dn4hjFGpeXYV+NmbxcpTMkzhCOWT/Dg?=
 =?us-ascii?Q?32Rh1M53i86rsua0dHYpEj0iHkT8UWWUBZEWIKZ8wEJZovNSY6CgPjzcRlrp?=
 =?us-ascii?Q?44j12bOrlU4pr9p+p/KMmeOc+7/is9lwu23aCpO037KpJCJ3HYAHUEs1+wdA?=
 =?us-ascii?Q?1FVpA7ZGYKT5mAO8JNOTWVVM9VIQORFXEYypd/HEX7S8/fYrcMQK75X8XCyq?=
 =?us-ascii?Q?zTOZz7P9J43A4fX2A6fHoMMxlxKsEafo9MlRn12/9LP5tIvq2P9ilGaRB6u4?=
 =?us-ascii?Q?WYHOjUStvhU7B90ne3pNMbpEQUjZfxwvnuKgBK8YCXRyr/Gua3a6s9Yod6Co?=
 =?us-ascii?Q?i7MN9Wzc6YHSRiHFMPitBjXcA+f3pN/JIUEIcDVBaehMYKp6ojlzCJ/wutE7?=
 =?us-ascii?Q?GdceeKeQYON1HNPn/Cj2hBOEUz3F5WOyRdCk8KIPulPHGCzUjDrciz/vcxKC?=
 =?us-ascii?Q?YVl7soJa5/oq/4CVPCRm5ouEBDUKIPnrAuw6q10cmMqyjO7whXYaVZm/46IO?=
 =?us-ascii?Q?8pNpcKTN+s7v9tYJXtAlpCj3fHn2GklEoIeNRuwK043zRRyYZPnzNDLfSheZ?=
 =?us-ascii?Q?kgSoMlxFiqsQj40bWJ0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5239.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?An9Z0jaIpv3VekOBw9QOcqmdJMYfSGGGv2ao9EUEwxri7+yhxSBpS9PjFnVM?=
 =?us-ascii?Q?WdbuCXCmdzNeexQex/lu56eF5Ypy5io20/Ihn/CUKQj+sJsU+UH9WA8RsjAv?=
 =?us-ascii?Q?t6KgUu0Krs67nXCvdSg7dpJYFtf1Qohv89KdicdOKjgdFQR6e2EU6CiZPqoD?=
 =?us-ascii?Q?hRoRIPv7YBeUq+LAtJoDJFCoCaRG1EtGhB8zSB+y48EhvfUzzA9ZdCk6anNH?=
 =?us-ascii?Q?mHzrLG6Wo0Z4rQTMuAO5u9CCh7viPWv6rSu1ZOD2QPbGhl9/ACW6fsP2R3ZP?=
 =?us-ascii?Q?jIXMnhmrFV/1VEsSBSLTYk52nQ/Yy3Vb+CXBCzY0QrU1lIGtH9fVktDG4gYo?=
 =?us-ascii?Q?F0vCK4XkkZazZeRuNx3+eFfst+cZ6g42kZCMEsVfyFlZr7r8NAnhVmfWSlun?=
 =?us-ascii?Q?BeEyJABx/Y7e3hn4RS3/HUub1ZGchZpjXQ3nXKLA923Vc0CBt4dbtqmLoLcm?=
 =?us-ascii?Q?hP/0T5BntgyEKH92/iSCMxqO/qUcZ+S4Hn9gcbYwuGVY2EQ2xkYrkEwrovH1?=
 =?us-ascii?Q?mRjySnZpTg4V1t6wTxEVna7iI02ao5Os/km+WTFYptb1+3D7+7cMYj9Lorkq?=
 =?us-ascii?Q?cunirJ54HRRqGx3aahEYnxoILhpckobPKljJCIl9MJwJORIVS2T45iRix3e7?=
 =?us-ascii?Q?QIk0SNDGZ4pLmYpfsHshw5TJKszoCOtLJSWV9ezgzeC9UL31JAVFv0Sc0KAp?=
 =?us-ascii?Q?13nd5C+L0QcdnbmbIW75c2FHGtN3k/IIS2XaUk3n5rTAzXRsFxr7Jr1Uc1Wj?=
 =?us-ascii?Q?1jPfZCuUTZLNKd1qrGE1TLaJgRPj+dm+26e+2vvD2D313cKPEc5zRFopplSA?=
 =?us-ascii?Q?hnxbax4tE/fRTO7975ifs3EDmRNj2RwZjYyf+eeb0Mr33s4vNfuhs7qGkMxH?=
 =?us-ascii?Q?MWMsvfWnmI4rLQwZ5gCb8OxVfJIgclbJkQnLPwyVcDgcl1V80U9IGYLLvjD6?=
 =?us-ascii?Q?75DdCaaOuNKtgoLS/aS8cfLjNPJSLvt8adpGQVeRdm3v8QoqG+OxosKkhQlz?=
 =?us-ascii?Q?uNR+sWqsfZ6/HPzaHfbhFN8YkvNHGQE9LxAW0nFRnkdAdjKHFPwmtIQ6BwzM?=
 =?us-ascii?Q?4lFU8SPOQW6ctp36vvdOfiM3vTPob9K5IUkBUlEIIjDlBKErX42YD0Kf48LA?=
 =?us-ascii?Q?uYV+QMcyRBBM0L34Z5it3hUz6w91noGpJTS+dVNQqtXThPefZ0NEfGCKp/FQ?=
 =?us-ascii?Q?7DBGzaIc+2oydRznTYtAiQvEReULWAE7HWVNDXEIV4yrb82Hap203Gmpg+nX?=
 =?us-ascii?Q?IK6ZIq73/+jx4UL8tC+NkFs4IohsypXkK3nJ/JjukWYhT7Agzaac1phTiPZj?=
 =?us-ascii?Q?M1VhkHFGFAdJ4vfiuiBS0EIZG17hJ4qQfWucA+rpFSFFdJR4gMmJSHYRzulH?=
 =?us-ascii?Q?lHASMHvQJfQfAYOa03ohQjA2k+gFIkhpcN57mb4l9Ixk4E/vT1O/yWgiDu6s?=
 =?us-ascii?Q?Rr7PRp4Ts+G3scT0Wr7k19pevtec/vafPe5an2ccmdyWsCFTOHCcS38X34xa?=
 =?us-ascii?Q?zTdCILpB+Wm3kyXmPU8pUpcMHskiWBfubBoYDvcN61cW21TIIPf5vcrRsUDE?=
 =?us-ascii?Q?/vrsxydWFdJApNUM7k0b2kmd6G+Ub67e/u/v+24kY/IHXDUpZLssW42gtJcC?=
 =?us-ascii?Q?WKzigLEqy2M7ESjYqj32foSLCK93TDk9sidOnanvmO5wQFvS/+2SuTDIJLGW?=
 =?us-ascii?Q?aD8CRlWczr+H/K6cAdV5kJOXNk+92MV0nBE9eXW/j+jUMDNEDO7EHgc6weku?=
 =?us-ascii?Q?pj886CikDso3dBBVDfwY1alJSqncRj8=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a0d9942-a9b7-45c9-6c31-08de6990597d
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5239.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 17:09:43.2324
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +CTCpVNsV1cK27Vw6sqK9ktUwC6rpLStBx0HSKbYj/wlquof0UBcnTc2C9mw/ackRnBTits7I4jl1AwBgB+DWE8zMJGVrh7tvthRd+m1fR8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR13MB6252
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
	FREEMAIL_TO(0.00)[oracle.com,kernel.org,brown.name,hammerspace.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76961-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bcodding@hammerspace.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,hammerspace.com:mid,hammerspace.com:dkim,hammerspace.com:email]
X-Rspamd-Queue-Id: C00BF126785
X-Rspamd-Action: no action

In order to signal that filehandles on this export should be signed, add a
"sign_fh" export option.  Filehandle signing can help the server defend
against certain filehandle guessing attacks.

Setting the "sign_fh" export option sets NFSEXP_SIGN_FH.  In a future patch
NFSD uses this signal to append a MAC onto filehandles for that export.

While we're in here, tidy a few stray expflags to more closely align to the
export flag order.

Link: https://lore.kernel.org/linux-nfs/cover.1770828956.git.bcodding@hammerspace.com
Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/export.c                 | 5 +++--
 include/uapi/linux/nfsd/export.h | 4 ++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
index 2a1499f2ad19..19c7a91c5373 100644
--- a/fs/nfsd/export.c
+++ b/fs/nfsd/export.c
@@ -1349,13 +1349,14 @@ static struct flags {
 	{ NFSEXP_ASYNC, {"async", "sync"}},
 	{ NFSEXP_GATHERED_WRITES, {"wdelay", "no_wdelay"}},
 	{ NFSEXP_NOREADDIRPLUS, {"nordirplus", ""}},
+	{ NFSEXP_SECURITY_LABEL, {"security_label", ""}},
+	{ NFSEXP_SIGN_FH, {"sign_fh", ""}},
 	{ NFSEXP_NOHIDE, {"nohide", ""}},
-	{ NFSEXP_CROSSMOUNT, {"crossmnt", ""}},
 	{ NFSEXP_NOSUBTREECHECK, {"no_subtree_check", ""}},
 	{ NFSEXP_NOAUTHNLM, {"insecure_locks", ""}},
+	{ NFSEXP_CROSSMOUNT, {"crossmnt", ""}},
 	{ NFSEXP_V4ROOT, {"v4root", ""}},
 	{ NFSEXP_PNFS, {"pnfs", ""}},
-	{ NFSEXP_SECURITY_LABEL, {"security_label", ""}},
 	{ 0, {"", ""}}
 };
 
diff --git a/include/uapi/linux/nfsd/export.h b/include/uapi/linux/nfsd/export.h
index a73ca3703abb..de647cf166c3 100644
--- a/include/uapi/linux/nfsd/export.h
+++ b/include/uapi/linux/nfsd/export.h
@@ -34,7 +34,7 @@
 #define NFSEXP_GATHERED_WRITES	0x0020
 #define NFSEXP_NOREADDIRPLUS    0x0040
 #define NFSEXP_SECURITY_LABEL	0x0080
-/* 0x100 currently unused */
+#define NFSEXP_SIGN_FH		0x0100
 #define NFSEXP_NOHIDE		0x0200
 #define NFSEXP_NOSUBTREECHECK	0x0400
 #define	NFSEXP_NOAUTHNLM	0x0800		/* Don't authenticate NLM requests - just trust */
@@ -55,7 +55,7 @@
 #define NFSEXP_PNFS		0x20000
 
 /* All flags that we claim to support.  (Note we don't support NOACL.) */
-#define NFSEXP_ALLFLAGS		0x3FEFF
+#define NFSEXP_ALLFLAGS		0x3FFFF
 
 /* The flags that may vary depending on security flavor: */
 #define NFSEXP_SECINFO_FLAGS	(NFSEXP_READONLY | NFSEXP_ROOTSQUASH \
-- 
2.50.1


