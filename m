Return-Path: <linux-fsdevel+bounces-76727-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GEWXCzAjimnLHQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76727-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 19:10:56 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D533A11369A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 19:10:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 352193031B00
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Feb 2026 18:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C6F38A9B4;
	Mon,  9 Feb 2026 18:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="OYQeX/oM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11020120.outbound.protection.outlook.com [52.101.85.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD28D38A9A1;
	Mon,  9 Feb 2026 18:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770660599; cv=fail; b=ivmm7H24hP6XIhYDDzH8/owAZQf2RMMtIP7SeVc/nbrCs8l53DoU31FZ5v7m7/WPgnhSMa/p552YWJWVYtwv6zSc1c0QVfHgTFJWea65WHKGWngiHSiN8vlETbijoGAFLjgvl3jY3qWmsepmdZaFIsHpNwc1LkaExUM4U1uL4j0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770660599; c=relaxed/simple;
	bh=MaIeG0m5dQr+xtyr+u8a59BTwBPTv64kC6k1CguhBCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PxXCEn0F6+oavZx3XtYzMq4qUeXG4UF+vT32q9DpKl8BmoX0uwNzbdrAY1yYbP8/K2qWYdilD0usZQlkzxshaRr4Jj1HsJP+vRQYiPwLetg9GqZhpmK7hzCW8tBoM8BaS8yZPHGj6oN2O+XKzYUjS7aXmtun/aqWj3ZfmynPW7I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=OYQeX/oM; arc=fail smtp.client-ip=52.101.85.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PXG+CBjcDaYMFkRMFsC6paumwG7HeAMd9MB/Wag3LCtxcwwCobWvpY5Uaoy/KN6KiNQlTZ1pKYvoPgHyqWxFQ529P7o38bIeTlddKF+Kq8PH2Cvn05hAvhLy+g1BIIv1uYGmVEFbhttX6koyw3uWOYgBOJl5pCobW7FRpOicRN4zoLUNmXYJmc7R231Hz4fw04+HhZ+NHJ+IS77EUJAUpLxx/EtadT4FxNzsLxnaezD0rYnfJ29M08GHuUSszR0+qafvVCgguQWgzASpejTKIvVqrITERMKpxwbT86NkpgYUV5eKSA59DiJSJtBU+yIswgRDdHwv4+AjkxtoVwolew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8J1jUyZ9I+o212IFPZOnsGrka11Hk5Gp1GmXUFpP09A=;
 b=VmkTIpTXsM5bDjLQyIrLm60k/RsNcXeBMbJ3n1RJfwxLZjPzMypqcVeEv6LEdwjymawPhQzYdg6+iNWFX857Wi0RxxvuIqxdhg2DYOK5+recgT8jc9VUSBsau/HpOWOSRLNNYzjn6sGrw7Xi0m4hBj+fweVU0/lr/4SaFOYVVw9w+Yb2J9yKZwESQhCxLLwiRSRpQRfZC4zusztXWbTRJsrjcTriFVbN5wt4rf0Ns9Gc7k3lCCSxnx6z7TU493LN2NPgjkx/JNG19HnMx9QAthUoyt1zyKR9aNoNvN4vX6V0Zh/KKFIKnt33DjmRBhS4VtLwLJ8rai0XgL5f3NQw3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8J1jUyZ9I+o212IFPZOnsGrka11Hk5Gp1GmXUFpP09A=;
 b=OYQeX/oMpNS/U7RV72PsuPrevkPiKObBOULSmy+oTPeS+mKiF1HFlqM4Utqv1wdMbNIXNRGe9yQOPoSdAm0ds+kgVxlf9oVG5BSJEEwJj4udBuYjv64YJD20ffny4aw2e9SSTXcdgi6E0VPtztC7he0CflXsfk5yxOhn3Ok/CRM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from DM8PR13MB5239.namprd13.prod.outlook.com (2603:10b6:5:314::5) by
 CH0PR13MB5170.namprd13.prod.outlook.com (2603:10b6:610:eb::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.16; Mon, 9 Feb 2026 18:09:58 +0000
Received: from DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3]) by DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3%4]) with mapi id 15.20.9587.016; Mon, 9 Feb 2026
 18:09:58 +0000
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
Subject: [PATCH v5 3/3] NFSD: Sign filehandles
Date: Mon,  9 Feb 2026 13:09:49 -0500
Message-ID: <c24f0ce95c5d2ec5b7855d6ab4e3f673b4f29321.1770660136.git.bcodding@hammerspace.com>
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
X-MS-Office365-Filtering-Correlation-Id: 98867d1b-0343-4326-2905-08de68066dd3
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7142099003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NjM1nSEj+G9gAxGc1Ip9NXjD8Wp09jmUw5PNUvuWlOaUaRy001QIrBIjeD6m?=
 =?us-ascii?Q?pf4pGDd917sb/o4gZ35xDuwzV1t2M4b4MgrODemV4SDeWSiAe6VLYTyZdU5H?=
 =?us-ascii?Q?4/DZV3izv3rUL0zlgblUXMkQkiki/NKiNXJvpoX/CuAb6dmNJ0FTrCJHWD8t?=
 =?us-ascii?Q?pknn67D6dpZ2ulJJ3ELaAniUpsrqClgIIllHJ9sc4/6LB0DSrycVClwD5Wn0?=
 =?us-ascii?Q?bmbdMNd0NTMNT84huJX53oXIP9x2pcd/6PPjIR2OVYUodeyujluvSUBmoxV8?=
 =?us-ascii?Q?XNtSGrHN/wHhm7fpRmKRIq2GFiAWaKKdgNg2mSYTNSSoA+Bxusu1cXjRoj1W?=
 =?us-ascii?Q?7w4Al7pGRizXipeug6JSn7UoFfXHpsfAAvXvYtNet/GRx84Hw6AD4ssWFM2/?=
 =?us-ascii?Q?z8Kd91Xb1pKeHb8TiuqEp0u32uKQr6SyRIqel3tHOuFq9R2uj310F/0/F7Ht?=
 =?us-ascii?Q?jPggoQITl1bvffbYsmXkA6A2XB1TyT+ASF9kf9GrdTP2pbkOHlRcZhxGm62d?=
 =?us-ascii?Q?JA8V9/YbpIGYRv/bj+lPkWdC7mfKd5etNK4AlcE0s/NwMUwQb+oh8l2cMY7R?=
 =?us-ascii?Q?iyWfa6BzDYV9+lrVymWA/QLi6pJHwhllGaAX6QToqcr/G4TH8cQMg2T1lPt2?=
 =?us-ascii?Q?UgfOJhhor35oKaryR9klCURG9zh7TBTo5dZT5fDFOjA8OA9PPELYRNKhI4yv?=
 =?us-ascii?Q?l6dXZKc4qnSFlRMopg9ljRuRdsh4WKT96s9mq0V2+WbVt19nlGL8y7wu27ou?=
 =?us-ascii?Q?1UaPQuzQlYfOU76px6UKZ+EnR2Gtpoo1ys+nEsmI1QCgXj9BGljHE7IqMScd?=
 =?us-ascii?Q?kt5dQGCES3nCFvLXeVGDRII0fxrHK0x1UFqvTMEWSuPQrRYpXQGdQ840ByqQ?=
 =?us-ascii?Q?vimfDNzOwe4duMJ1kLXHYPYcJzGsQ2jUNiae+OiDKpshSWwe72z7biv2JcL2?=
 =?us-ascii?Q?52NaLudkgV/xx5kzpASz0pEtPLrXXX+VRcSOjB3EWRin97JU7QcJuG5u1zT0?=
 =?us-ascii?Q?Zg7b4NB3Qhq2veDVqwQQBXljWks2HuNwCt2muWvA139fIx52P8+LXw3S1Wz3?=
 =?us-ascii?Q?6TVSz7AfXIZPv4Azo1sVUOJEm0iwGM9FsV6hlBHRH8QfgdU3uYYtFh1Mtvjh?=
 =?us-ascii?Q?wu2k1D8A2nCHr2VlJd2q9aLVoJFw8PZNL47e5U7Iq72ifNubxUp2PvkdUeQu?=
 =?us-ascii?Q?09A1voLT5EWogs7JUyHPAHLqPXeXBt6WZNsO8Hr+JjsrGscpcuLk9jkm4h7R?=
 =?us-ascii?Q?NXTnB8yu/Y2X79yIF/NlhM85wkX5xFmG9w0axQxDp3w/XZovTvFW3hF8zGh0?=
 =?us-ascii?Q?5gHfd09uvTK07O37zX0bxiI3VuIGe4DX8xPNf0Xek3hD3cwfF2om824ZFKUM?=
 =?us-ascii?Q?y6wQ5VX3+psTBXkpHNM4mmj+gVatpaj762FzvYjyp9Dq1wbq2382ruueiRmC?=
 =?us-ascii?Q?95rnUevVvRxE2Qet+bPQJP6NC4hoFnC2DZrmBbocEdV+av983+m7MgTcQU3k?=
 =?us-ascii?Q?fdIQLsqyo6fo1LGtHwB+1rDZfKGhqFD8Fz1ZYiphs1SouPBJ7ixffiGwojQT?=
 =?us-ascii?Q?SMl1JkzMjG+h9aY1Y0s=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5239.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7142099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Uurau5B/IkkxSsPZgfCqytIM4SntkQy4zkz/+OChYphBzP04+osASs8fes9H?=
 =?us-ascii?Q?pfb3svys1LKWS5OgxLHSDmEE7ZfNJogauKtcz5U2ZUR5d8g+FFXuOHcZem5k?=
 =?us-ascii?Q?E+jpuuIt0fLX4diUECdOtt+d07ChuaKRepSrkRFYoAp0sARFchpnrdlzbMux?=
 =?us-ascii?Q?N4dbBfw7I9FZ71cGml1Bqe4I2WWluGH2FVq2hKLu39sEjgF5xbah74qaCADg?=
 =?us-ascii?Q?QjOc674e6lPgiaZzSStr2C+tMfWxQJhCWmgMW0A9ouTNVeWSVqjHAU1KaPYm?=
 =?us-ascii?Q?UYTcykKL5r5FgywvCDFUOvxmBTj7Fomle2ac8jL3vd6zTvZNl65arA0idwol?=
 =?us-ascii?Q?JMhGOYkunJ7wTF1GH6uFUdXsxNeO5LIudkU+EKg4EPrD13P907iqNlaSifqj?=
 =?us-ascii?Q?AooWKvJLr8FL1a7CBcRFLpyydb+gVEvMy/BThCL9u+z9T0HoUxBqVdyG6CbP?=
 =?us-ascii?Q?t69wRWupzKT1H5G3L3hgnsHpOM9B1Skdr7v/c/povy6ex2TlDywX6QelF/5t?=
 =?us-ascii?Q?pTApVZeeDqCsHYNcaJo6bL1CsBv4NAOKgFVYG0mnVlZ3lCI/rgAOsw1R6Izw?=
 =?us-ascii?Q?6E4TSqe00/c6rbey/2Wov127f6CMKrxyGR4jJmFb8AoggFtFBu3ILtEGnc65?=
 =?us-ascii?Q?1LRCSVF7dm+5UjpwIuhFPfjyctZ8f2WDd0n2+DwrGyawibt9/AXgyILfrvTy?=
 =?us-ascii?Q?gvQHm3a1fvNS1Hna9C4R8akKbQpNWrFLargkvUwRrUPRm8pWZa2vY6MQ1zwS?=
 =?us-ascii?Q?SyAi6UEA+AEDZdgAJryN2cfq/CKAjiULx/B7/fLcoPN+wuJOEQnHd/BbzOA8?=
 =?us-ascii?Q?5pcBxS0vFX6dJ3TMUDtUmChJlJMFxDumWaOGSWpUtnbxvaD+6XentFeZunF3?=
 =?us-ascii?Q?ayFCB84L1Uva+H2CP6YnANo0E335pDb3LIBTTJCKXjeCABRRmM9rnMLs6Ciq?=
 =?us-ascii?Q?ObfKJ4TS3THKGeLATKyoGv1uGjKOf3fM55AGx4qPTyrYz2oegz2ZspZS9Gki?=
 =?us-ascii?Q?kqmrxx9TPR4YiPHTwWnapIdp6s5hzHC9S2vZii+bwg5FwiF46bEcd6GK9Y6H?=
 =?us-ascii?Q?8pxWn+vOT5Z6z3+IAzY+NYVpnxg63PTS5zK08VEHFL20CV1k+zzXMWwJhclz?=
 =?us-ascii?Q?YwHFAm5Px6BACA1pl/vmHUBrpKm07vNt4XRLAZEAjjuubVS/G1utnBM8ByO3?=
 =?us-ascii?Q?S3Y6XVAjLOYuSeMVMAzNEcGc5PDztN3rVoj60+tdg0e6A+sBI/BlWuxfc5/r?=
 =?us-ascii?Q?luyuGXzFVte+0xj5vJbtoG+MyRDWoT+6Hm4YKstH8kOpPXvFzV+eJGDiUrdt?=
 =?us-ascii?Q?C8+9+9RrWt8GM/fHRUS5LnS1KOa4/VxOeYLDK9jYY0elkVuXEa+N08l24dth?=
 =?us-ascii?Q?hfSrAJo+rTSCSsIqg2vSDS/5/fSIsgap1FVgc7ZTsbNSxLadG8t4/9cmu/hN?=
 =?us-ascii?Q?GcPFL79PeFJW9DdLImZHr6eM1o1/q60eoMgdyk7rCxrbV9qe9df+bUZeKlrk?=
 =?us-ascii?Q?ODVsDtuxodTDpwZfJnXQppoCpQ44iEaoodR9OepI+2TOPDl54NuehPmAKc/H?=
 =?us-ascii?Q?klvs0+VZe9xM4YoWe25bdGq0jEF6hCZztkuibNOEiPH1l7L3dSCDkp8wWfpa?=
 =?us-ascii?Q?SlJ8l2fua5t3iR7on8Szm6mXxmO6sa1zjZTZl8ZRE7W3KhpJC5zRGovI6Mgn?=
 =?us-ascii?Q?+ukmbigL1xk8PPUV+ffwvOKbhV0FZJUmzj0HVQs49dnnkppm6Qt+ADZzyxrg?=
 =?us-ascii?Q?Y3CPGSAspg7hL0zy6z0gu1kFil7NF+w=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98867d1b-0343-4326-2905-08de68066dd3
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5239.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 18:09:55.6655
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nbkeyRrvBn832Lxc+upIafGWCiOD5iXgcsHfxntW0e/hg0N8pKp4z41Rkltx1NoeIoIos/v3ni3fA5QppiE7wMxsRgyrZChZiX1LtEyVDKA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR13MB5170
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
	TAGGED_FROM(0.00)[bounces-76727-lists,linux-fsdevel=lfdr.de];
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
X-Rspamd-Queue-Id: D533A11369A
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
Reviewed-by: Jeff Layton <jlayton@kernel.org>
---
 Documentation/filesystems/nfs/exporting.rst | 85 +++++++++++++++++++++
 fs/nfsd/nfsfh.c                             | 70 ++++++++++++++++-
 fs/nfsd/trace.h                             |  1 +
 3 files changed, 152 insertions(+), 4 deletions(-)

diff --git a/Documentation/filesystems/nfs/exporting.rst b/Documentation/filesystems/nfs/exporting.rst
index de64d2d002a2..54343f4cc4fd 100644
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
+~~~~~~~~~~~~~
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
+~~~~~~~~~~~~~~~~~~~~~~~~~~~
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
+~~~~~~~~~~~~~~~~~~~~~
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
index 68b629fbaaeb..3bab2ad0b21f 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -11,6 +11,7 @@
 #include <linux/exportfs.h>
 
 #include <linux/sunrpc/svcauth_gss.h>
+#include <crypto/utils.h>
 #include "nfsd.h"
 #include "vfs.h"
 #include "auth.h"
@@ -140,6 +141,57 @@ static inline __be32 check_pseudo_root(struct dentry *dentry,
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
+	__le64 hash;
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
+	hash = cpu_to_le64(siphash(&fh->fh_raw, fh->fh_size, fh_key));
+	memcpy(&fh->fh_raw[fh->fh_size], &hash, sizeof(hash));
+	fh->fh_size += sizeof(hash);
+
+	return 0;
+}
+
+/*
+ * Verify that the filehandle's MAC was hashed from this filehandle
+ * given the server's fh_key:
+ */
+static int fh_verify_mac(struct svc_fh *fhp, struct net *net)
+{
+	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
+	struct knfsd_fh *fh = &fhp->fh_handle;
+	siphash_key_t *fh_key = nn->fh_key;
+	__le64 hash;
+
+	if (!fh_key) {
+		pr_warn_ratelimited("NFSD: unable to verify signed filehandles, fh_key not set.\n");
+		return -EINVAL;
+	}
+
+	hash = cpu_to_le64(siphash(&fh->fh_raw, fh->fh_size - sizeof(hash),  fh_key));
+	return crypto_memneq(&fh->fh_raw[fh->fh_size - sizeof(hash)], &hash, sizeof(hash));
+}
+
 /*
  * Use the given filehandle to look up the corresponding export and
  * dentry.  On success, the results are used to set fh_export and
@@ -236,13 +288,18 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct net *net,
 	/*
 	 * Look up the dentry using the NFS file handle.
 	 */
-	error = nfserr_badhandle;
-
 	fileid_type = fh->fh_fileid_type;
 
-	if (fileid_type == FILEID_ROOT)
+	if (fileid_type == FILEID_ROOT) {
 		dentry = dget(exp->ex_path.dentry);
-	else {
+	} else {
+		if (exp->ex_flags & NFSEXP_SIGN_FH && fh_verify_mac(fhp, net)) {
+			trace_nfsd_set_fh_dentry_badmac(rqstp, fhp, -EKEYREJECTED);
+			goto out;
+		} else {
+			data_left -= sizeof(u64)/4;
+		}
+
 		dentry = exportfs_decode_fh_raw(exp->ex_path.mnt, fid,
 						data_left, fileid_type, 0,
 						nfsd_acceptable, exp);
@@ -258,6 +315,8 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct net *net,
 			}
 		}
 	}
+
+	error = nfserr_badhandle;
 	if (dentry == NULL)
 		goto out;
 	if (IS_ERR(dentry)) {
@@ -498,6 +557,9 @@ static void _fh_update(struct svc_fh *fhp, struct svc_export *exp,
 		fhp->fh_handle.fh_fileid_type =
 			fileid_type > 0 ? fileid_type : FILEID_INVALID;
 		fhp->fh_handle.fh_size += maxsize * 4;
+
+		if (fh_append_mac(fhp, exp->cd->net))
+			fhp->fh_handle.fh_fileid_type = FILEID_INVALID;
 	} else {
 		fhp->fh_handle.fh_fileid_type = FILEID_ROOT;
 	}
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index c1a5f2fa44ab..8f0917b1b55d 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -373,6 +373,7 @@ DEFINE_EVENT_CONDITION(nfsd_fh_err_class, nfsd_##name,	\
 
 DEFINE_NFSD_FH_ERR_EVENT(set_fh_dentry_badexport);
 DEFINE_NFSD_FH_ERR_EVENT(set_fh_dentry_badhandle);
+DEFINE_NFSD_FH_ERR_EVENT(set_fh_dentry_badmac);
 
 TRACE_EVENT(nfsd_exp_find_key,
 	TP_PROTO(const struct svc_expkey *key,
-- 
2.50.1


