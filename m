Return-Path: <linux-fsdevel+bounces-74029-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D6CD296E8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 01:39:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5BAB9300EF54
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 00:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A022FE058;
	Fri, 16 Jan 2026 00:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="trOW+mnm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012039.outbound.protection.outlook.com [52.101.43.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347A32D4B68;
	Fri, 16 Jan 2026 00:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768523967; cv=fail; b=pPhq+vNpfj2Zb/EH1C2r3r3t1U1hXBwktS+rIW93UpUciSLQhZwaU6kembIOk9dkfO16FHqpJtFWwxKkBbPOA92/wnPMGn0L94ZFQhnU77U0Ob7VzIRPsKpQJ5d8fKsZAnV1XmeA3Y/PEQ89Dt0RRuBBVuY0fQoNod8CSsKirxY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768523967; c=relaxed/simple;
	bh=vuv/u8VI8xVvcp0tM7coxC8pFBgNaczslVnSej6ZqL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TTkZE1r/7hqjHe1taHtuInOV2WMToQrNrqcsXeP5tvbpY7odCW6xjW7KF3EQQHx/BUbxbm8eJgmsFl2UyQaJO6KaEwBPRUbRRpKIZ8ioQqOZhWO7aYFRyqH9qD0b5KMU80ky+gYhuVEcczvEq/YgbwHVX5P3rZhoFNrEJBEtGyo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=fail (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=trOW+mnm reason="signature verification failed"; arc=fail smtp.client-ip=52.101.43.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IsmLj09hTKwlt+U/k0GXIvWcVTPJKONWYXC+0n/wBnh9YaDg2LLhj8a09u1suKsXnCK331Aya+Xc2V9+CjV79YC0NEjQLDo8MwN5/tHwTYC/4A+fKTSOiCGVJJd5GIiO5KJjnMnVHbBPPcfsAyW5VJvux/hXVHdRbE8JvKnz31lUuX/VB0OU/fJufsg0uuCVyA8/+73/0fID0JspuB87bdO7ji9B2wnhwn05JpPH+hvWJdTJxwm/qLghs1AeLRsj4G5my7Z0NgmhFnuSNyQQMH2h75xP/jemBD6r9vfE0ePnZziVcREk5wffbn7FwUQg5bGNvnGiRZSF9eTibSCCiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0IAQhOmPpzoKe0g+b7quQwjQ/r4k+2El9d9339cc0GE=;
 b=ZiVxgWKzSm+dddb5CayCiK2G6f10mI2Nqyp6s9ugT+w8Kfp35IdbZ+cWh6Abkx4e9Iwl2yIrFnykAvS1kqc11LjlofY1JdeCA8EJFTYpVZByWZLsIzvx4II39yomEnCGaX1rLMDvR8k6YtLjuvx40E48bDCSAgHhOFQSPlhKBnIX/K/+suMHEqauElvusK2RVSkHnBzRoCSnwzR3DiE4sjycd338Bw+6NGruLkw49mNkbTumJtTm5D9qOGGtFAAqogWrb5t6noYVnGAr7MDy7zTDobH8izdlWssyqH2KNf3LiNqOil0fq1X+TdTlKiECYwys7D3DnnSkemQjyWRbHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0IAQhOmPpzoKe0g+b7quQwjQ/r4k+2El9d9339cc0GE=;
 b=trOW+mnm5xHJ3jMsuJj4QRCSEdJiBAnzKgr9f3I90K6VF/JzPK44xLvj+YyAVVRi5vD6//MVuoyxXy9TxYFuwu41Kl55PVEje8R0FMr4F6zT0e02/A/oEOvIVVh4BC7kso2TW8/tr6TAcEFSnkDqvxNbx4wlriQXXo4CO+89dm9wNA8Zrv/XnajM8MPj4a9+7wSLCVVRxgvHBL76Ki5DC+8ClZ4BS/OkQCFnE+HG6VeuRMd6BkJ/tVLPuoX5BI5aGm9Lto7M5AZo6p1nGS1jVDv3Pa0eWDocdu/vdjIMdsgb9+sQHS1FgM3hX5iK18ZbWujlOrcv4N1GRIM7/yK8yQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 LV2PR12MB5752.namprd12.prod.outlook.com (2603:10b6:408:177::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Fri, 16 Jan
 2026 00:39:22 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%4]) with mapi id 15.20.9520.005; Fri, 16 Jan 2026
 00:39:22 +0000
Date: Fri, 16 Jan 2026 11:39:17 +1100
From: Alistair Popple <apopple@nvidia.com>
To: Jan Kara <jack@suse.cz>
Cc: Seunguk Shin <seunguk.shin@arm.com>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev, dan.j.williams@intel.com, 
	willy@infradead.org, Nick.Connolly@arm.com, ffidencio@nvidia.com
Subject: Re: [PATCH] fs/dax: check zero or empty entry before converting
 xarray
Message-ID: <yavred3s6dugshfczj5mhnvcympcdsrdrkmktoyp5w4mgovmio@hlfnstnj3sai>
References: <18af3213-6c46-4611-ba75-da5be5a1c9b0@arm.com>
 <pj7j72k2f4kc5hhid6md6ntn6hwapl5oocuubc2g5ec7vhf2te@yux7oeq43nhe>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <pj7j72k2f4kc5hhid6md6ntn6hwapl5oocuubc2g5ec7vhf2te@yux7oeq43nhe>
X-ClientProxiedBy: SY5PR01CA0045.ausprd01.prod.outlook.com
 (2603:10c6:10:1f8::15) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|LV2PR12MB5752:EE_
X-MS-Office365-Filtering-Correlation-Id: 31070b30-10be-4c92-6f0e-08de5497b14d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?B6xGzB2os753Br2+sxFJiMCXP5qYvFPeg1WHRt9O4LHjsI3Klo+16+Wbog?=
 =?iso-8859-1?Q?lS2sQxXkPWoucTsoSeTfMg9RJH9RiD6xLQsTcQvxj0OXLavov8P3eQldwD?=
 =?iso-8859-1?Q?6Gf9w7sWyAXJj78RmVYAGqWNzlXIHC88To0VQTx4Eo5nfCCzisjwT3sOjh?=
 =?iso-8859-1?Q?gHp5rPaiHUWt0f+v+Z/tLgPoy6PoDQMvgg/L70VCh/UX4fe2ndMF0gehh3?=
 =?iso-8859-1?Q?LstEDUym8LdQiHWZoMKjQP7QkE1HKy7Ry3ij6ELpZo74Xvw5OreFCneIm+?=
 =?iso-8859-1?Q?4Jn5KXqeB1GhQw7RRQukP7Xm3vN7dpZ7kqPTAzzX0gvfRFxiDuoCiY9tF1?=
 =?iso-8859-1?Q?kACw6GSjhK7zFFFsN9fZTcFLuG1th01iAUqHHlXwmN4+j3vCTXag0fRJkH?=
 =?iso-8859-1?Q?flWKhexl8LiywkvM8yLcXh6hHG6IV8CtnePag9oyfe4LWeojKuq1lQC7Cy?=
 =?iso-8859-1?Q?hi6FflhgA3Rmj7w690gWfNe3ghaToewp6prTBjJOLJ2StjrgUx9JbvUZfG?=
 =?iso-8859-1?Q?3B07PtGi9tQc7ZuLqqs1gKbAQbek9V+36JfOLAO3ioQ3NXk2uGwC0sZoA8?=
 =?iso-8859-1?Q?Tld8BMgbB3cfDi4J+ttU28vhgzWtaxe2+Wimq954JvDfsUF2wNsjWtTUCk?=
 =?iso-8859-1?Q?xLovqDrp79TOwmn3rk2Gmsj/Vx3JFxXPLrkzIJLIYrUEyKBi1KShqEvO2K?=
 =?iso-8859-1?Q?f9DISb8i/LuqyycU2XQZJU2OMK3iTnUcjxxO80RCHBWEqrDpvXwGN/VbIU?=
 =?iso-8859-1?Q?hPlne2PCV3vgRuK1bJD3svBWVRCHHVKiVT7Nksu5M+xac3bAe+N5BUrNUv?=
 =?iso-8859-1?Q?jhpY8+5M3O+h+NOOrn4tmDRm+Nned4Sy2L+O4unDFsUL8OOI1u4jViIOgh?=
 =?iso-8859-1?Q?dEH/vFR7Pjs3PStVfUp0RmyVbKECrSoHRRhWF+HMoMG8fLpKHV/cXENPGa?=
 =?iso-8859-1?Q?VHUvjoiFnEr/xK4qdTk6uuM1slvMd6diGqjcWewUvQ5Z5NuGMILIDPHOGE?=
 =?iso-8859-1?Q?aisBOExcS4YuiIikRFJEDxfO4sJ1ZV90hMnCpRARTOhQzsey33rgBp6LhL?=
 =?iso-8859-1?Q?VsuTYQsuFGzNceXy9r1zzeOxzK49pXdCVyi8d0hrbuUxgV3xrQGMhn/Ppy?=
 =?iso-8859-1?Q?2tXdPgZvKLOP9HuTplBqnQTiMiashPvOpzfazTiPDdQlATCHIQKoV/5yDZ?=
 =?iso-8859-1?Q?cu/O19CvBa+GaZ4eVH7sp4yau/FuNtKbku2/1UXDYKod+5J3SNoog25akH?=
 =?iso-8859-1?Q?EpnAvLicDBG8+uqU0YikDMJlDKH/AkANUuLHJFgmlPFP0zgQe1N7KO+9oS?=
 =?iso-8859-1?Q?E1kTHG3ecg0Kw5xU3N+WhiYU2HzYtzuxys94CPwLsqburMxp7s0Uu2/3V5?=
 =?iso-8859-1?Q?tkHzs4O5mN9cRzvxRAUWm/fNskkhKPpCXRtWQ5dWDiRHh6pfLMVx1miSLR?=
 =?iso-8859-1?Q?zozZq32fYCYS6p8b1vpRtrk0V2jsIyQVBwHRkmy/rOIslSFPUasKmMBIGm?=
 =?iso-8859-1?Q?hqkMthKDUNmGguWhlJ1SVSNM7mLfPLtOD67AOh6b1Y8i62Dlciay+90dEo?=
 =?iso-8859-1?Q?sCY2KT2x4iwuYs2bGwG9ElspPfQS6j+kmhEJmQYavMksJoe3h4a57qPtZI?=
 =?iso-8859-1?Q?AQX2t6V5dROpU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?rZblO6qTEsLZjyvL2gqLpHOh338m7sHsZwFUtvGcnG2S57jJRia/mLSqaO?=
 =?iso-8859-1?Q?gGkI/C9xhv/jCYl90Lcv1GgZBFIQDwYiXlolivFpTCETuck0NgsXvVyoUj?=
 =?iso-8859-1?Q?W4BO5Zv+ygcCxZqPaidi8AI8uktR+W8pW16g0wOOTonUpEgGM/91F1XsCw?=
 =?iso-8859-1?Q?7VKc/g21hnJa+iXRy3gYaqgh/RRT/iB1XDPVd6Pn1gNi4LfvNDRfODr6Du?=
 =?iso-8859-1?Q?ZyMuGlDRoiTtImmTCiYAY2l1Rijq5nXQeEtPpoPjCXrpRyX0ZYbCTlxjL9?=
 =?iso-8859-1?Q?3cOz7KQz7J01R/WJ6pq0vXgXOgR4q+r8J32OpLnSuSPyJzmY4kBtoYnwJt?=
 =?iso-8859-1?Q?23WjDhtobcWId/i4mF78zT+3qid0tBqXZ1BxFYO6BbGUNQZUxPYm2Z1Ijc?=
 =?iso-8859-1?Q?3ZSGC0oDlIXd4vbh22fpssRZM63Gz0/hpZnDV0kuelUf9fB5xM8rQm3Rjg?=
 =?iso-8859-1?Q?3vpH+/lMoV9ycqTgb27oO5SXPL8Z0qrM/jJKgLV2bfsX/8WhAuvTIX4/vz?=
 =?iso-8859-1?Q?Zql4u8c4UHtmQSr6/ka6YZ+jlbVOXKywEVtZdUTkbyC35qdAZMcLuX4tho?=
 =?iso-8859-1?Q?r4tym2cJWDYALBQicl1057+060jMZbK6JIxFTUdQJ0lHC9jpu94CcRZ33j?=
 =?iso-8859-1?Q?orXpD6PW/brQuu0U237enc1fXlb0UC73sIMzxIeh9lKdiz+TRnF1LpIZbG?=
 =?iso-8859-1?Q?1w82lkRwYkkmQjWlQSvHSEEmh+ayEvVwSjNihezZJ01MUwr7af4HYlyg98?=
 =?iso-8859-1?Q?i/iUC+noDuSQSXr06qhhMfWnYavD22PGrybsPc/07y42XpMGOHwlN+/5iQ?=
 =?iso-8859-1?Q?gIEGhSpTpV0VNix4btzUPqdvNdIRA1PXGeTKYmntpHHeMxWqVphM4PVvW8?=
 =?iso-8859-1?Q?AM4svFCOgmpH5YrzBvWXn/1u6hOn4Iii6FapxKtl5Yhpvn91w4+dYgYMu4?=
 =?iso-8859-1?Q?WFclIam3xG3kEhbqwiqTvHvvkO+X1XYR0Wd2ymtzn4OjZqTUjaMKQivf/O?=
 =?iso-8859-1?Q?yse3poE6wY8wOA5oBRViMnc9+1Mcs3ijLSnwIVFjHsDgchf23BWNwGRP5L?=
 =?iso-8859-1?Q?P2oKf37z/GMfkDhiMPskgtZc1+9Waa3Yc5XBdXNsPw04v/P2rclPu1fyZ0?=
 =?iso-8859-1?Q?JSRJibtE2StrD9hmj7IyjqL/wnrroAVLXfSdPxGkE43u3Vz4tGpaCMiWl/?=
 =?iso-8859-1?Q?lYahTfqe5pf43+aMittZ54MnNGfDIT2KY8VXmS9zz7wVoZh8TbDXJ6CNCR?=
 =?iso-8859-1?Q?4dVvo6UCE0NPJYBDJ0Ni6EBU3QM+m5A8JnWIAaBl8PUvwp8RKg9BisV3qi?=
 =?iso-8859-1?Q?VvlcS5bJR9CLF3gyNtmOeAjEok7DWSog+tutI+oZQYB3ag/T49T0XEmPfY?=
 =?iso-8859-1?Q?PC5l2ZlMDcZP2Bvc4O5onsORPZ3zgGBYQ73GsDZ+QV0QxvHAFZObAXQWLb?=
 =?iso-8859-1?Q?te92szAKGyYcq1P9PQsYr7L1HuuwdrMMvkRsXzKtVfjzc6bK63xScakBmo?=
 =?iso-8859-1?Q?kaUSoY4icK5xWvTaEFs74StQgYs4iC1p2ZiV0adRexlRH4xpNEnhmJyRdx?=
 =?iso-8859-1?Q?zXpkfp7GoH64a7Yi2jkFXKaZMsu+K3PxQp94TORXbIV0mhc3jsDe8H/ZhZ?=
 =?iso-8859-1?Q?f2MoN5uwmhtPhb0AibxsIlI+icB/CTBHVF3GswqEp9sz8lSK2nBkTLqfRx?=
 =?iso-8859-1?Q?k8kJXaHQOvtW2Lprj7lDswYfQnSfzrO4UbShF5AgEA25tJX/4r6MQnB/Pk?=
 =?iso-8859-1?Q?mvNhoHhcQi9U7foa0bY7FS3aw7A15fLNMm4iB+zfOUpwEwV8q/DV+UsW5d?=
 =?iso-8859-1?Q?UrfiJju8dg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31070b30-10be-4c92-6f0e-08de5497b14d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 00:39:22.6812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vt1KyBtbm0uaVP4TEnxBp4nWUhToQ2WZPemSW8tM3ZSrR1NHGpCAwM03NA7MThG4ITGmYeIbPn5BuJleZ3zBuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5752

On 2026-01-15 at 05:19 +1100, Jan Kara <jack@suse.cz> wrote...
> On Wed 14-01-26 17:49:30, Seunguk Shin wrote:
> > Trying to convert zero or empty xarray entry causes kernel panic.
> > 
> > [    0.737679] EXT4-fs (pmem0p1): mounted filesystem
> > 79676804-7c8b-491a-b2a6-9bae3c72af70 ro with ordered data mode. Quota mode:
> > disabled.
> > [    0.737891] VFS: Mounted root (ext4 filesystem) readonly on device 259:1.
> > [    0.739119] devtmpfs: mounted
> > [    0.739476] Freeing unused kernel memory: 1920K
> > [    0.740156] Run /sbin/init as init process
> > [    0.740229]   with arguments:
> > [    0.740286]     /sbin/init
> > [    0.740321]   with environment:
> > [    0.740369]     HOME=/
> > [    0.740400]     TERM=linux
> > [    0.743162] Unable to handle kernel paging request at virtual address
> > fffffdffbf000008
> > [    0.743285] Mem abort info:
> > [    0.743316]   ESR = 0x0000000096000006
> > [    0.743371]   EC = 0x25: DABT (current EL), IL = 32 bits
> > [    0.743444]   SET = 0, FnV = 0
> > [    0.743489]   EA = 0, S1PTW = 0
> > [    0.743545]   FSC = 0x06: level 2 translation fault
> > [    0.743610] Data abort info:
> > [    0.743656]   ISV = 0, ISS = 0x00000006, ISS2 = 0x00000000
> > [    0.743720]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
> > [    0.743785]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> > [    0.743848] swapper pgtable: 4k pages, 48-bit VAs, pgdp=00000000b9d17000
> > [    0.743931] [fffffdffbf000008] pgd=10000000bfa3d403,
> > p4d=10000000bfa3d403, pud=1000000040bfe403, pmd=0000000000000000
> > [    0.744070] Internal error: Oops: 0000000096000006 [#1]  SMP
> > [    0.748888] CPU: 0 UID: 0 PID: 1 Comm: init Not tainted 6.18.4 #1 NONE
> > [    0.749421] pstate: 004000c5 (nzcv daIF +PAN -UAO -TCO -DIT -SSBS
> > BTYPE=--)
> > [    0.749969] pc : dax_disassociate_entry.constprop.0+0x20/0x50
> > [    0.750444] lr : dax_insert_entry+0xcc/0x408
> > [    0.750802] sp : ffff80008000b9e0
> > [    0.751083] x29: ffff80008000b9e0 x28: 0000000000000000 x27:
> > 0000000000000000
> > [    0.751682] x26: 0000000001963d01 x25: ffff0000004f7d90 x24:
> > 0000000000000000
> > [    0.752264] x23: 0000000000000000 x22: ffff80008000bcc8 x21:
> > 0000000000000011
> > [    0.752836] x20: ffff80008000ba90 x19: 0000000001963d01 x18:
> > 0000000000000000
> > [    0.753407] x17: 0000000000000000 x16: 0000000000000000 x15:
> > 0000000000000000
> > [    0.753970] x14: ffffbf3154b9ae70 x13: 0000000000000000 x12:
> > ffffbf3154b9ae70
> > [    0.754548] x11: ffffffffffffffff x10: 0000000000000000 x9 :
> > 0000000000000000
> > [    0.755122] x8 : 000000000000000d x7 : 000000000000001f x6 :
> > 0000000000000000
> > [    0.755707] x5 : 0000000000000000 x4 : 0000000000000000 x3 :
> > fffffdffc0000000
> > [    0.756287] x2 : 0000000000000008 x1 : 0000000040000000 x0 :
> > fffffdffbf000000
> > [    0.756871] Call trace:
> > [    0.757107]  dax_disassociate_entry.constprop.0+0x20/0x50 (P)
> > [    0.757592]  dax_iomap_pte_fault+0x4fc/0x808
> > [    0.757951]  dax_iomap_fault+0x28/0x30
> > [    0.758258]  ext4_dax_huge_fault+0x80/0x2dc
> > [    0.758594]  ext4_dax_fault+0x10/0x3c
> > [    0.758892]  __do_fault+0x38/0x12c
> > [    0.759175]  __handle_mm_fault+0x530/0xcf0
> > [    0.759518]  handle_mm_fault+0xe4/0x230
> > [    0.759833]  do_page_fault+0x17c/0x4dc
> > [    0.760144]  do_translation_fault+0x30/0x38
> > [    0.760483]  do_mem_abort+0x40/0x8c
> > [    0.760771]  el0_ia+0x4c/0x170
> > [    0.761032]  el0t_64_sync_handler+0xd8/0xdc
> > [    0.761371]  el0t_64_sync+0x168/0x16c
> > [    0.761677] Code: f9453021 f2dfbfe3 cb813080 8b001860 (f9400401)
> > [    0.762168] ---[ end trace 0000000000000000 ]---
> > [    0.762550] note: init[1] exited with irqs disabled
> > [    0.762631] Kernel panic - not syncing: Attempted to kill init!
> > exitcode=0x0000000b
> > 
> > This patch just reorders checking and converting.
> > 
> > Signed-off-by: Seunguk Shin <seunguk.shin@arm.com>
> 
> I think this was introduced by Alistair's patches (added to CC) and as such
> we should add:
> 
> Fixes: 38607c62b34b ("fs/dax: properly refcount fs dax pages")

Ack, thanks for fixing this. I think I see what happened - prior to this change
these three functions called pfn_folio in a loop using for_each_mapped_pfn()
which filtered out empty/zero entries:

static unsigned long dax_end_pfn(void *entry)
{
        return dax_to_pfn(entry) + dax_entry_size(entry) / PAGE_SIZE;
}

/*
 * Iterate through all mapped pfns represented by an entry, i.e. skip
 * 'empty' and 'zero' entries.
 */
#define for_each_mapped_pfn(entry, pfn) \
        for (pfn = dax_to_pfn(entry); \
                        pfn < dax_end_pfn(entry); pfn++)

That function did what it says on the tin, but it's subtle because it relied on
dax_end_pfn() for a zero/empty entry returning zero. Obviously I missed that in
the conversion but the fix looks good to me so:

Reviewed-by: Alistair Popple <apopple@nvidia.com>

> 
> tag here. Otherwise the fix looks good to me. Feel free to add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> 
> 								Honza
> 
> > ---
> >  fs/dax.c | 9 ++++++---
> >  1 file changed, 6 insertions(+), 3 deletions(-)
> > 
> > diff --git a/fs/dax.c b/fs/dax.c
> > index 289e6254aa30..de316be2cc4e 100644
> > --- a/fs/dax.c
> > +++ b/fs/dax.c
> > @@ -443,11 +443,12 @@ static void dax_associate_entry(void *entry, struct
> > address_space *mapping,
> >                                 unsigned long address, bool shared)
> >  {
> >         unsigned long size = dax_entry_size(entry), index;
> > -       struct folio *folio = dax_to_folio(entry);
> > +       struct folio *folio;
> > 
> >         if (dax_is_zero_entry(entry) || dax_is_empty_entry(entry))
> >                 return;
> > 
> > +       folio = dax_to_folio(entry);
> >         index = linear_page_index(vma, address & ~(size - 1));
> >         if (shared && (folio->mapping || dax_folio_is_shared(folio))) {
> >                 if (folio->mapping)
> > @@ -468,21 +469,23 @@ static void dax_associate_entry(void *entry, struct
> > address_space *mapping,
> >  static void dax_disassociate_entry(void *entry, struct address_space
> > *mapping,
> >                                 bool trunc)
> >  {
> > -       struct folio *folio = dax_to_folio(entry);
> > +       struct folio *folio;
> > 
> >         if (dax_is_zero_entry(entry) || dax_is_empty_entry(entry))
> >                 return;
> > 
> > +       folio = dax_to_folio(entry);
> >         dax_folio_put(folio);
> >  }
> > 
> >  static struct page *dax_busy_page(void *entry)
> >  {
> > -       struct folio *folio = dax_to_folio(entry);
> > +       struct folio *folio;
> > 
> >         if (dax_is_zero_entry(entry) || dax_is_empty_entry(entry))
> >                 return NULL;
> > 
> > +       folio = dax_to_folio(entry);
> >         if (folio_ref_count(folio) - folio_mapcount(folio))
> >                 return &folio->page;
> >         else
> > --
> > 2.34.1
> > 
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

