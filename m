Return-Path: <linux-fsdevel+bounces-76058-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QNMWIX7PgGlBBwMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76058-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Feb 2026 17:23:26 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7544ACEE5E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Feb 2026 17:23:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AB58D305BF72
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Feb 2026 16:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE51280CD5;
	Mon,  2 Feb 2026 16:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="fXLE/Yv9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11020136.outbound.protection.outlook.com [52.101.46.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10C723C4E9;
	Mon,  2 Feb 2026 16:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770049189; cv=fail; b=aEcs/hXImaAuoPtkNdeK+W7ZBAxMf8pJ9S3exnmbKdIxgN4Uc1CrXM1RJ1RLtcNQH/ERwUbBuoviME7VaUm6Zj+gAidw55c5zKut/8SST5G70t2dCggsBh3nfmJeJ1KMLiqgIEB5tPI5s7jTPcsmm6LPwH/Y+EHlKx1Lf93pTiA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770049189; c=relaxed/simple;
	bh=+nqAXW3VHTiJQDb8aK202spo2p+7SAky2s6nkha0ypI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=I7BYQ4mREKyqkHcB+Ypgg0zsGT/thFLrw445WRiZ9YmF0t95cNrXwSikNdGnqFvyH03Gb/GC1iQtWSXu7ZqMp2tu82Gjf51SWfOS4D8e1Re3ODmjsaMNogxSbjEguGHOdGIca37sT7VR7fuipKNZrWBlXPYIQp0s7dMQ8V8q/CU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=fXLE/Yv9; arc=fail smtp.client-ip=52.101.46.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DKsayAtLTsmTAdqQJhR+uanVpcjdQem3tWASmhmF5FTtKpUi/anDvvGDbx30S0A9wKT10HMz1nK+JULdaqIeMJHJxcCC9dCWRNS5nyNq38+aqfpnsWXE8X/zW/9fAIfT5WSxrEAi78s+26qYoJTP5P+y3NOPUlHc3/dESu1got2WEOJY7gFB42puFYzcrVuaESjfP5Y2iAwAyPqDfqb2bOfhF6K1r6SKjQY91CrfsNfWSJiMnQNbuvK7hmfCAhww+7dTAzgR6VcYAqO5ANgl2MOAauzabgIIoyZJbWMNiC1D8cXnOjn4K+MQnJWkXNK1QW6zT5EvXLKiHkV37H7STg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KqBkpgclRCjtchLzgayjoOitwWIdN4rTeFNCObaKXBI=;
 b=oetYf+4hqzBFf3l5DWvcP8Q7jdFTIP3o06SQXfYJ22I4IAoyDfb3Vkkw7E/8Pewx0TaidlDh7J4gkr598SOSymHev5lpfLAHtkUpxri8lGwJjNx16oA7q7kWdx4jO11Bsc05wJWzYYlp5FsK/qNlcN96iZ+Fr9pMPmBe3/j0ViJ+PaqhckeAvjqAPn20ZOQUGd6Riqbk3m1UFEdEslTq5sGgzCsd9Q75lgl1ns0XC4yZ49jamu08oDhSSeWGtS7Jp6CoqZHvKwmdl4BILA842rvohmHqPvQaQLUIzhqIHu26RS3AUHHOKtV48UVN+DgYouM9DTANl7hRDexYnC75Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KqBkpgclRCjtchLzgayjoOitwWIdN4rTeFNCObaKXBI=;
 b=fXLE/Yv9so/JAe3qHZbTcY2YVmYKeldAaQj3Tstw8yDyXDkKDSaUlPFfWce8/vTuY3tbXx9EdQHFKzNeSKXM0sE4R235d6tPFLWWcKcpIOJXpX6PECc+1/EKDUq1O9H12JichVYl0ZIC1GlxPiXyFhZwGzYli/nv2yue4s9LDGk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from BN0PR13MB5246.namprd13.prod.outlook.com (2603:10b6:408:159::12)
 by BY5PR13MB4470.namprd13.prod.outlook.com (2603:10b6:a03:1d1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.11; Mon, 2 Feb
 2026 16:19:43 +0000
Received: from BN0PR13MB5246.namprd13.prod.outlook.com
 ([fe80::39d0:ce59:f47d:5577]) by BN0PR13MB5246.namprd13.prod.outlook.com
 ([fe80::39d0:ce59:f47d:5577%6]) with mapi id 15.20.9564.014; Mon, 2 Feb 2026
 16:19:42 +0000
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
Subject: [PATCH v3 0/3] kNFSD Signed Filehandles
Date: Mon,  2 Feb 2026 11:19:35 -0500
Message-ID: <cover.1770046529.git.bcodding@hammerspace.com>
X-Mailer: git-send-email 2.50.1
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
X-MS-Office365-Filtering-Correlation-Id: 8d72afa7-1275-4858-9d86-08de6276df35
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7142099003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+q3HFwBYu+ppkVITXfJ3NBUxqOWOByJ6rdMWvFtnA1s2DLJZtWnY+KLGrzxk?=
 =?us-ascii?Q?8dWE0dcKXrSawOoFo/WqeB5V6O6bnW3y0xDvaJf0e05EYvqn+5N8uviBmD5P?=
 =?us-ascii?Q?Eyzfa39rbH2V9kqc0upxuflO03LsNBLO4Merx6mBAMEW040nFnl++n0uoio3?=
 =?us-ascii?Q?fNvHzQL6GyQn+cuo21Vj2z6Td3x8ppGQCAtwCMYxuflHzlJp7fuCA+jCfV3v?=
 =?us-ascii?Q?1AngNyx+3aZTW2j9pdEIBdHlTHCUxD57Yj8/HXLT1g4gK0sop1ANX4ILOkCU?=
 =?us-ascii?Q?qPM2w8kMn+M1r50uotMq2myhp67nixDwwVnILEtEevWMaxxYSIv3BAWKqi0u?=
 =?us-ascii?Q?xsUjv7T3qs0IP+kNrWNFveInZQg0/AQp+Gvl7SR13yTgizePUj8OLLiJ2msg?=
 =?us-ascii?Q?rHAUStifWJ6BHD+3fsjWV8HfOG5HpRzsscQozJyNLAUe4HdpNbs0CaO5BKYz?=
 =?us-ascii?Q?qF34d1ExVW2f2/uWFEuK8BbYosClfeVfRUwtyCWpjicn15sBXV6m78/32Yhz?=
 =?us-ascii?Q?1VI0t6tHtDmgkhOC/ixJTNFTmrTJqw91353+x+7zQkhkuqxJOgmtMU/StDA1?=
 =?us-ascii?Q?FAGMAUXC7BzLZ2TJlsHwSJdc5SD0G+n+x3cu1SKOwi674AMFPgubMJWy23bt?=
 =?us-ascii?Q?cU9TL0y4eYe12TcI8j+NVvmFVLG0I3MQH64eGw7P/3Vgl9QXf/PIah2HNcDF?=
 =?us-ascii?Q?wGSY3b4dYFr4gcEWQKarwv8MNH5si/LWsVD0/PwtNiS23l1H8NuUUuu2yBI/?=
 =?us-ascii?Q?2wEjjUpc2AwecM2YQU675+llLJfiRkc81G1zgLZ/zl3FKorqMr1a7OvgDkQl?=
 =?us-ascii?Q?hmbjFW2kBtJcxTETMpLBrnCYBGAzBJb5VjGpwZcxsDURcFsFElshiKh2PWdm?=
 =?us-ascii?Q?oXuiQ95OORuzrTzSjQraO56KOrSL1mI5+ezj3mmq7Nz5ifk4kS2E60l3rP/F?=
 =?us-ascii?Q?GBMwO8uL0G8q4/eLIb5wO1ol3z/wBHMqivZbZ/4x7GOVCetQkL3kZSacIYCe?=
 =?us-ascii?Q?pTJ0Q7NSi3N6DV3m1BD2du6qCzqyzDLm59pIOBdZJLZRoxvgd4MtF1LkMmHc?=
 =?us-ascii?Q?VTnk1VeBLyYRKdmlk+DJhp2VNbumzBiCM8LRhzD6iFJyerO5b8Hr5WmVxob4?=
 =?us-ascii?Q?JHQ+KE5lpQdCUY1C3em/t6dWLOw1E7lYWCh5aJNjYVMtMSObkH4NJZDlNOH5?=
 =?us-ascii?Q?c+JWrZhR3kOJxdJyjyKCns04M7/tWVqiIzKQfyt0tCHcpOEbcTjiaZCiGo2x?=
 =?us-ascii?Q?DDIKgwes9enOTcoBbeqcwQPyzT8mFEYYv28i61m8AVwYPeUVdNhXG5IjBOYC?=
 =?us-ascii?Q?JAw+eMPOMZUClWCg36RoEFidEGmC5/bulK5YPTqbor8DboQ+aEoxfXxbqBUv?=
 =?us-ascii?Q?IZi7xubmwGT51dfhn1N8SLGUAtRhlJCdQ3Vossu6wPy2CxMN8CTK1LH2Ysuq?=
 =?us-ascii?Q?l6UJxoTz3cw+oCihT004Zq/Ko7sNVSkQZeUKBJQJzSzii5tLpkk/K7UhR4Zo?=
 =?us-ascii?Q?idBXPVX0vmmZBZ6RB3Iw9wkaIYYgHckLECLO99QZRxfLrdgeIzLJmSPuH+h0?=
 =?us-ascii?Q?zDyZ1laDmgkfmhNcJRUcaar4N86SFPkSzdoxu6tD?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR13MB5246.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7142099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ONrXNRdkAxX5cYq61XHrr2xPHMbS7/J3jmM2+nx4TDBnVnNJZjgwdmlNCP9i?=
 =?us-ascii?Q?mjfx3yvzIF0y8Ryro03/4yNxNXFMVUV7lS+4A34CBdjzsfVEFrPuc/nRRMuf?=
 =?us-ascii?Q?YoRs9GqHjWQvdIObdVqSJyIWgeAPfdIrhLrG7UBnOWS2u2Py2EbLdZJkXCOp?=
 =?us-ascii?Q?g9zqja3NXy9vZ5i4cqHoy4iRsp6uZQUpntBIFa7gkbhjDB2Uebjl9e9HBEEA?=
 =?us-ascii?Q?AbU0Ni9C7K9AlHfJLobpnHTnSwb/rQQPKlnF6aQcg0GHnu9eNMIweMPRTXVd?=
 =?us-ascii?Q?b8Avxyybpn68NIxNe22JoNpyPKAL3JrHp1ciDSw2hvukouLA3CDKaSKeClqk?=
 =?us-ascii?Q?84wdbVbuU/WMOBQF6FXUqSkiyeq89ZIxxuMxife74kIIxbH/PJye4E2K35m8?=
 =?us-ascii?Q?8vDxlFm0InxyESpIhSp8ENb7hXfH0/Dec+LmeL6ufGPlFd/nPPAi3GXjbcaC?=
 =?us-ascii?Q?Gzrec1zwc1acwyC6fbsmXf7nkl6E7L6X4b/qIZT65twNQ9GtDgqkHG8uv+Qt?=
 =?us-ascii?Q?BWx2VrIKCLlfewwg+b+w7KLanCf/E2kGxEGNGJhVUb8Dd5d86i33j3BjrWb0?=
 =?us-ascii?Q?DgEIvToe2/CevNgMYJ02N+N1zHBRpvTyersiu7g3GKb3RUObiOAckkNmkmvT?=
 =?us-ascii?Q?t+WMuWhSOiHJARbqXNHmIKoVWAoLhmP/xbG9GHV2GvyCWW+hY2MYvUyi0kNV?=
 =?us-ascii?Q?zoS9oa3f5/R+kx1N+j0Wwh4R7wsbNDltgrmGvlZKLjcAJdV8wNzLa7Dzpdei?=
 =?us-ascii?Q?tcFdqCqs3DRB6bKphxDrOI50IINN1c6RchUXQBf3eyP4EgkGdB5eVFNqx3Si?=
 =?us-ascii?Q?BKwt1yClxPeIy1Y0xYGeOIcY+El8MyASuH48Xbar+L6hCvvrWAG66TrqMD9u?=
 =?us-ascii?Q?jaTo8hfsrKAe9gjByVp8iZ631w4c0r2LtJIsg3ilfB/j5weHFySPAyvIrpfH?=
 =?us-ascii?Q?dFQn5xTGyu/AcjVo+LY7Sx2jNJsNqlltDTyCtVBB4c9AZAOzzpNXxrDIrl/s?=
 =?us-ascii?Q?J9qAfznezo26KjH8pBfTU06yNTvg3dRjpzF0VkXkuduN5sg58P9Y7lE5BF8T?=
 =?us-ascii?Q?FjnpRAZoBiLNZV65j7bCkB1GcJo9J3feTK2JS7q18oBSVsAg0SGKbhiq0+wY?=
 =?us-ascii?Q?Lt0VoPvCIp0zA/AVY/Dk8FeP6Mc7E03xaATizE+uyVJey24SrvpheEsfXnY6?=
 =?us-ascii?Q?MBfiyVoWhs0e+pz76U4TJ7QG3Il/VV815gb8IK1ugFqscfKhp7R7uM8tUwbW?=
 =?us-ascii?Q?pEcMkweWTcx5kFpUQbkvviG5D3Z0Akz8wWsTGFmmzzxJW9jXQwrZaAop/eHe?=
 =?us-ascii?Q?8dCaJbySamQc5P5fxRVDmeKfSjx6G0rsmmqHem1KkZAcvNgJCHZBjp/BgfeU?=
 =?us-ascii?Q?OVZHhedzOKrOjSNUaUIz7V9NLMs2ifkQHpo6+fkjVFSHiuJ+EjphgI3gGCwM?=
 =?us-ascii?Q?MPfBt/XW7Hg146HxDT6VKrDx0OjUC2MBFTBqkvnwHDZpks5YfkZuG1dlJ+ko?=
 =?us-ascii?Q?Ovgx8/+YWq/6ph5aJTGmiiSyLl65y6sKTkEoqD/oP9HIww5wbv/2D4UD95/a?=
 =?us-ascii?Q?/YOFH73taNU0zV2VIfcZdJKe5BlqpdUZgtdDwmfhctD+erdn9WMLkxWOqAPw?=
 =?us-ascii?Q?jO3t+SSXcSJWrfmXu4CISazpsYpfj8LYkCciUwxoBsNkto3bhgKnrfp/7Wkg?=
 =?us-ascii?Q?5MayqUvHZQsZpxEMJi8fzNwb59oTtY/tpmwpaHmiT6uQCmLjgU8LeJYaJzh9?=
 =?us-ascii?Q?A9k3G9Yvr4uYJa0NPuDgx16vOXtStC0=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d72afa7-1275-4858-9d86-08de6276df35
X-MS-Exchange-CrossTenant-AuthSource: BN0PR13MB5246.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 16:19:42.9230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kyo+mS5NzXva/YGZVERZqzpcGNhASXLSrjLyj1qy6RatX3xrFTvQYA6QWCyGk47FGp2XLIeuf3kyWgFYpy7EpXzY66jsNBW+We1LdwPWNbg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR13MB4470
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[hammerspace.com,none];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[oracle.com,kernel.org,brown.name,hammerspace.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-76058-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bcodding@hammerspace.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,hammerspace.com:mid,hammerspace.com:dkim]
X-Rspamd-Queue-Id: 7544ACEE5E
X-Rspamd-Action: no action

The following series enables the linux NFS server to add a Message
Authentication Code (MAC) to the filehandles it gives to clients.  This
provides additional protection to the exported filesystem against filehandle
guessing attacks.

Filesystems generate their own filehandles through the export_operation
"encode_fh" and a filehandle provides sufficient access to open a file
without needing to perform a lookup.  A trusted NFS client holding a valid
filehandle can remotely access the corresponding file without reference to
access-path restrictions that might be imposed by the ancestor directories
or the server exports.

In order to acquire a filehandle, you must perform lookup operations on the
parent directory(ies), and the permissions on those directories may prohibit
you from walking into them to find the files within.  This would normally be
considered sufficient protection on a local filesystem to prohibit users
from accessing those files, however when the filesystem is exported via NFS
an exported file can be accessed whenever the NFS server is presented with
the correct filehandle, which can be guessed or acquired by means other than
LOOKUP.

Filehandles are easy to guess because they are well-formed.  The
open_by_handle_at(2) man page contains an example C program
(t_name_to_handle_at.c) that can display a filehandle given a path.  Here's
an example filehandle from a fairly modern XFS:

# ./t_name_to_handle_at /exports/foo 
57
12 129    99 00 00 00 00 00 00 00 b4 10 0b 8c

          ^---------  filehandle  ----------^
          ^------- inode -------^ ^-- gen --^

This filehandle consists of a 64-bit inode number and 32-bit generation
number.  Because the handle is well-formed, its easy to fabricate
filehandles that match other files within the same filesystem.  You can
simply insert inode numbers and iterate on the generation number.
Eventually you'll be able to access the file using open_by_handle_at(2).
For a local system, open_by_handle_at(2) requires CAP_DAC_READ_SEARCH, which
protects against guessing attacks by unprivileged users.

Simple testing confirms that the correct generation number can be found
within ~1200 minutes using open_by_handle_at() over NFS on a local system
and it is estimated that adding network delay with genuine NFS calls may
only increase this to around 24 hours.

In contrast to a local user using open_by_handle(2), the NFS server must
permissively allow remote clients to open by filehandle without being able
to check or trust the remote caller's access. Therefore additional
protection against this attack is needed for NFS case.  We propose to sign
filehandles by appending an 8-byte MAC which is the siphash of the
filehandle from a key set from the nfs-utilities.  NFS server can then
ensure that guessing a valid filehandle+MAC is practically impossible
without knowledge of the MAC's key.  The NFS server performs optional
signing by possessing a key set from userspace and having the "sign_fh"
export option.

Because filehandles are long-lived, and there's no method for expiring them,
the server's key should be set once and not changed.  It also should be
persisted across restarts.  The methods to set the key allow only setting it
once, afterward it cannot be changed.  A separate patchset for nfs-utils
contains the userspace changes required to set the server's key.

I had planned on adding additional work to enable the server to check whether the
8-byte MAC will overflow maximum filehandle length for the protocol at
export time.  There could be some filesystems with 40-byte fileid and
24-byte fsid which would break NFSv3's 64-byte filehandle maximum with an
8-byte MAC appended.  The server should refuse to export those filesystems
when "sign_fh" is requested.  However, the way the export caches work (the
server may not even be running when a user sets up the export) its
impossible to do this check at export time.  Instead, the server will refuse
to give out filehandles at mount time and emit a pr_warn().

Thanks for any comments and critique.

Changes from encrypt_fh posting:
https://lore.kernel.org/linux-nfs/510E10A4-11BE-412D-93AF-C4CC969954E7@hammerspace.com
	- sign filehandles instead of encrypt them (Eric Biggers)
	- fix the NFSEXP_ macros, specifically NFSEXP_ALLFLAGS (NeilBrown)
	- rebase onto cel/nfsd-next (Chuck Lever)
	- condensed/clarified problem explantion (thanks Chuck Lever)
	- add nfsctl file "fh_key" for rpc.nfsd to also set the key

Changes from v1 posting:
https://lore.kernel.org/linux-nfs/cover.1768573690.git.bcodding@hammerspace.com
	- remove fh_fileid_offset() (Chuck Lever)
	- fix pr_warns, fix memcmp (Chuck Lever)
	- remove incorrect rootfh comment (NeilBrown)
	- make fh_key setting an optional attr to threads verb (Jeff Layton)
	- drop BIT() EXP_ flag conversion
	- cover-letter tune-ups (NeilBrown, Chuck Lever)
	- fix NFSEXP_ALLFLAGS on 2/3
	- cast fh->fh_size + sizeof(hash) result to int (avoid x86_64 WARNING)
	- move MAC signing into __fh_update() (Chuck Lever)

Changes from v2 posting:
https://lore.kernel.org/linux-nfs/cover.1769026777.git.bcodding@hammerspace.com/
	- more cover-letter detail (NeilBrown)
	- Documentation/filesystems/nfs/exporting.rst section (Jeff Layton)
	- fix key copy (Eric Biggers)
	- use NFSD_A_SERVER_MAX (NeilBrown)
	- remove procfs fh_key interface (Chuck Lever)
	- remove FH_AT_MAC (Chuck Lever)
	- allow fh_key change when server is not running (Chuck/Jeff)
	- accept fh_key as netlink attribute instead of command (Jeff Layton)

Benjamin Coddington (3):
  NFSD: Add a key for signing filehandles
  NFSD/export: Add sign_fh export option
  NFSD: Sign filehandles

 Documentation/filesystems/nfs/exporting.rst | 85 +++++++++++++++++++++
 Documentation/netlink/specs/nfsd.yaml       |  6 ++
 fs/nfsd/export.c                            |  5 +-
 fs/nfsd/netlink.c                           |  5 +-
 fs/nfsd/netns.h                             |  2 +
 fs/nfsd/nfsctl.c                            | 37 ++++++++-
 fs/nfsd/nfsfh.c                             | 64 +++++++++++++++-
 fs/nfsd/trace.h                             | 25 ++++++
 include/uapi/linux/nfsd/export.h            |  4 +-
 include/uapi/linux/nfsd_netlink.h           |  1 +
 10 files changed, 225 insertions(+), 9 deletions(-)


base-commit: dabff11003f9aaf293bd8f907a62f3366bd5e65f (cel/nfsd-testing)
-- 
2.50.1


