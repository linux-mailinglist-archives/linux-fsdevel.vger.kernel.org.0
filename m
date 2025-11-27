Return-Path: <linux-fsdevel+bounces-70020-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F4FC8E6AB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 14:19:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A92E3AC530
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 13:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE371246793;
	Thu, 27 Nov 2025 13:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="NnKtd/5O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11021081.outbound.protection.outlook.com [52.101.52.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80481E00B4;
	Thu, 27 Nov 2025 13:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764249544; cv=fail; b=hZ5VRzLIle+/1AR4vu9OjCjyVAArBYCr8lV9b1z9eUTPG1DITDokh5C5A3OBovXJBpEAdTwndXv5teqZL93iglAY+bhehjeZH9Ohsvn2o0zlP04K6g2+tIdP7DA+t5NvhzAfvbW9SaNBihfb6prXa62plvJM+4HtWEylal8awHc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764249544; c=relaxed/simple;
	bh=vNLlRAMz8Tz119DWjObXbN+RIe3SoEzJDpL3w81CaJE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cZw7i3HV6vLvMvSFqUi406sFACYHsvAFu3G20fvX/wbgFurS4BcFDpv+WShTw1dsuoE6KVH4L21X9KbmgGNvJdTa64efA5tZyVaUgGYoycLxJ3vlLU+X9TZdtOe2lac3N7BcQx8p0h/8/f1hrdHrg0Eq0hV1Ez3wxv2fqlTlaO0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=NnKtd/5O; arc=fail smtp.client-ip=52.101.52.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ksZgVaSy22HItXOP4CYFMJd+6uDXgq1oKMADwXsJv1DnXKlrbj/O/5D5ko+TjNRawo1dNYmdGOVsKpD4Qkx8hyFi5czbzMo+okJwx+XuJHuarjKgTRujq7jRa3hErBpRTpx+zY5XIyHbz6wIJK43jVIehtMsJst8lr4Y5VwvxzyX03r4riyQ++Vp0s3mEVog3SWznE8hYZYBrFelh9OdFO+UTqW9IJDYP6sE8VblhUOtJvI3e2I3lF/P3XQxozBxiuSHfi9aAfGTzRdZ/862yJf43aNFq7QtXPXcogiwDVJPqzL4pMOVmIFs7jh218gEWHtxoorcg9UaFMyMSojFOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aFAVkCc/7k1xIQaky7VwUH/pjt0jLjXkgZm0iTXAbhk=;
 b=A5h92IrCrdNY3lYqnsJNaM18A32cZ3j+jOCOVXFGR2YMAFEwHRSgX7A4vhIl1KtUUbdKqnsH16yuNpn3O8ZO9BNUNLRfhExx+HpezM7BEOkqGS/NvgF5sPxCMujJ+Sio9VktKd9/71x5AyqLXcaHPMVUx8xVcCPma0+AKdz0soU8isMHC7wjUWvjiDpHSekfKebRUo6BIw0kcwWH42tWxhC41Ydwepj1arwNccyGFMxEna7hbC/IOJHRudhXP9g/DI5ZONlsbgbjjwHnQxELIvgIbVA/84Y4oWDi2J0Lx4plN5rlFjkfRQAYGlt2w83lp+hJkLk7IAbpxpdDV2SNew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aFAVkCc/7k1xIQaky7VwUH/pjt0jLjXkgZm0iTXAbhk=;
 b=NnKtd/5OgEBUm4fZS4wEC48eKYqtzm1MVCBiTiCyU+MOmfHQTMZzO1OG2d5YwfON+EclIM7Yc8aIEKkTcXYAHCgw6FnRvKHB02hOGT8ZFmJfWNViedGx3NSKjJV66YWW2QHizAFP0BbwFsjSepQoN6FuYd5fmWuT71EhyrijcM8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from SN6PR13MB2365.namprd13.prod.outlook.com (2603:10b6:805:5a::14)
 by IA3PR13MB7176.namprd13.prod.outlook.com (2603:10b6:208:539::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Thu, 27 Nov
 2025 13:18:56 +0000
Received: from SN6PR13MB2365.namprd13.prod.outlook.com
 ([fe80::9127:c65a:b5c5:a9d]) by SN6PR13MB2365.namprd13.prod.outlook.com
 ([fe80::9127:c65a:b5c5:a9d%7]) with mapi id 15.20.9366.009; Thu, 27 Nov 2025
 13:18:55 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: NeilBrown <neil@brown.name>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org,
 Trond Myklebust <trondmy@kernel.org>, Mike Snitzer <snitzer@kernel.org>
Subject: Re: [PATCH v1 0/3] Allow knfsd to use atomic_open()
Date: Thu, 27 Nov 2025 08:18:52 -0500
X-Mailer: MailMate (2.0r6272)
Message-ID: <1B5CEF7A-9F38-49AC-93A3-7A81C3330684@hammerspace.com>
In-Reply-To: <176420378092.634289.15227073044036379500@noble.neil.brown.name>
References: <cover.1763483341.git.bcodding@hammerspace.com>
 <176351538077.634289.8846523947369398554@noble.neil.brown.name>
 <0C9008B1-2C70-43C4-8532-52D91D6B7ED1@hammerspace.com>
 <176367758664.634289.10094974539440300671@noble.neil.brown.name>
 <034A5D25-AAD3-4633-B90A-317762CED5D2@hammerspace.com>
 <176419077220.634289.8903814965587480932@noble.neil.brown.name>
 <9DF41F45-F6E6-4306-93BC-48BF63236BE4@hammerspace.com>
 <176420378092.634289.15227073044036379500@noble.neil.brown.name>
Content-Type: text/plain
X-ClientProxiedBy: PH7P223CA0008.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:510:338::6) To SN6PR13MB2365.namprd13.prod.outlook.com
 (2603:10b6:805:5a::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR13MB2365:EE_|IA3PR13MB7176:EE_
X-MS-Office365-Filtering-Correlation-Id: f5faf442-f430-4982-c520-08de2db78464
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SQT/uMwU+EoP9LD9Rnc9g0c/h+m1Z2vB8hPceoXpig/VEIcfaxoQgx51vAl1?=
 =?us-ascii?Q?73TtVQywQihxGkhepK94581utoSWJzt/tFIUxzSZwolzwuP8SrkM7N6sgNAs?=
 =?us-ascii?Q?h9iokIKyaE0Bc9wZO4hC0d6CN2nci7PwHn6DACDVtijCv5B8MxIp29zLIsZl?=
 =?us-ascii?Q?q2FBZ8NfkUjv73+iu1TSLXjOPY0Goni+HeLIE2zN9trGuW+7F3gI+yzOTx4Y?=
 =?us-ascii?Q?1zp1UlxbzXSqNZMs1le3zSEc9EuVsoNZ6NxpChuEgHjswbkcupVz+CgkLuYw?=
 =?us-ascii?Q?ZSxPA016fvR6pHZl/7LQXcAQvNvqyETimWhnBcZqzRIIQOYG8XHugE9Zepqc?=
 =?us-ascii?Q?wX9QMGhULVPAyUY8yRYkXyPB6yxJpRl6iLNI0QfYPJBszyEH5g65sJDtWTVw?=
 =?us-ascii?Q?xWmIcHzVF/CxnrIV6IvK+1pYrsC6gjL3Xr1TahjnTiWyzHaOtkxn7T5WM8IX?=
 =?us-ascii?Q?4mx84UeMj6aVucwPt3bDeAZ/dsghKDgYVofYRgZmRHc6BJY7lOcnN6+dQNbt?=
 =?us-ascii?Q?cvjwQbACL+SkX6NuLGXZRDWwWEulkmSr2dww5MErE7KLsonN6ynEhaLjDzfx?=
 =?us-ascii?Q?aTis2bFvWvp/1KZvu/UgJmJsLFJNioCSdhf1A1oDGlENAjVmroYImJLnMQSG?=
 =?us-ascii?Q?mOhu0bJz2yJgArHTEudFPPVAr5pQLgGqyNyak//AfwqbKNut5AxAtkclZ4hh?=
 =?us-ascii?Q?skgvn/jlV+Kv33rioAT0I1mPimlydf5DGznudfZq+B2EYrh7zupycjYjENmb?=
 =?us-ascii?Q?+uR4J7qutDH5iV+2/NJZ6czmVXxYcrkju/Kc+gSLm5Pv2UEJWmbmrGwFK/tf?=
 =?us-ascii?Q?aLDdLZBiJ8gSRLdeyePMlAGC0QdO5pCgqh62jLb0pevwYQru9/uny5w+5ZTc?=
 =?us-ascii?Q?wy9xBTMcEKos4OmE/Mean0+HOF+7JK6Vu7wHjKTwUv0dnFrieb6XnOffnwsl?=
 =?us-ascii?Q?87KfJ2JHXtjte+aX5gVlYIDgI+e4U8sYhJD9n/85XwIxEd3lYPYSxXmkEcD6?=
 =?us-ascii?Q?RfrfLouj/zVrPO0V8wXkS6FU0gQKvLy+Oj27b0FlOVZLAT+sPSpXbCXdB4FV?=
 =?us-ascii?Q?zkO+YORRZtWFfr80Lz523cIh3OO1EkLqFGo9jz0B99joh3UIV4ExterII6/f?=
 =?us-ascii?Q?ZszOQd0S/8Trp7t5yQA4noOKKgxy70la+ZuYijw5D3/ENwY8JmYk/hQBFcI3?=
 =?us-ascii?Q?P6xkb2Mn/PXSJ+MIHwrAKQkpjtsPUKMMLSgB0yy38myV2DYwqwbAMFACYyor?=
 =?us-ascii?Q?fAKdU5EgjjRDdiNs2lhRYxV5MGd2z1Z9MGp4ekHMU2GJYZtcLUc3gu0j6qkE?=
 =?us-ascii?Q?myfsOQ5D75/0qvtD8pD/mWe8SGxNOJJcSRY2p8YQZ2Hu0czf1H+UGgm2QXmJ?=
 =?us-ascii?Q?mB2dO99t3+P4A/COKMr6zRDgIqWTYSKOOC8jUppIw5mIZuGIvWRM4h287o/T?=
 =?us-ascii?Q?zXkqYCcV1Fc4oJK3bGvyIupjhI5NNJcl?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR13MB2365.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?keVUVXlJVd0sXEnbtUOozf0JyGQtSwvOzmmMbd2vVzJDGXJ6OtzmTTgur+Lf?=
 =?us-ascii?Q?BTYVGKsdah5C/YjShvFIuQR26lHj+tHOa/44/Ya+gcX9hhJpltBKTbeJDcCJ?=
 =?us-ascii?Q?L0YhRC2lod+4+1VAXVs19HXiH+nAWXbRgpGo/Ws6U/QzU+eRocG7P5RQGiO8?=
 =?us-ascii?Q?PCPamJhHVs43NwdtzRmPJxaWYzPsKaZXmqmW0lxJ8v3/HtWDuMxv3mssfJzI?=
 =?us-ascii?Q?53N86OSjNRJfk/XdP57lzSGGMhDsKKrqIZ/EEGyYUo39s2fkLjkSNvxQGwvv?=
 =?us-ascii?Q?C69h1oLMRRvV5K+W+U/TiSBW5CPrS9ZzJq4W6ymi0n1XiQ6uyb7DzT7a1EQ8?=
 =?us-ascii?Q?cCK3QTL9toX5XrJkAvyAaCTbEfuvJSNnBG0sIFWubqWvtCTZTXdNuYrLeMxT?=
 =?us-ascii?Q?DRpRQc2dn0SszqsHa1RoRofRiMQBepj4/DUJLvi+Xk4Jx9j/O5ovJm4K5aK+?=
 =?us-ascii?Q?E+OF+PXI/KBfLzP9XqMMCSEtVkNc/U8BgPro7jLbHND2fFjc/HbVYmSEoogG?=
 =?us-ascii?Q?2LAPPRpAV3rxrbcmWt7gXqXRrVSR1iEI7ynxMB9skI6YE5thzZkYrDHS9M7o?=
 =?us-ascii?Q?wvlEsC0Tn6PGjOqC0XOEwYpjv8GDRB7XcIMnDcKLo7IFKa/S32degNL79iUb?=
 =?us-ascii?Q?ZNMe3488+FlUSPsFAQa76k0R045YZAHdcxW6YGqRIJvCJg1Za1cSkyK0snVW?=
 =?us-ascii?Q?/aNFzHr5e8ZXCFm4JcVZTn7ZliAm2kLwS0KgjxycgXBRgfbJyK8eho1SmyNN?=
 =?us-ascii?Q?DCIW7ZOz9AjhtZ/o04d3i+lvgygZkOpVOQEJa8BHWwrGd2Me/BPA9Max95Cy?=
 =?us-ascii?Q?fvgJ9m1BO04ObducXkaLMz5TEDv1TAtIRapYi6a4+N6VSWIkI3HFoejnjQMc?=
 =?us-ascii?Q?PiTU8J3fyJzo1Zi/yja0jttAK/4fpQxbdObH5u0Sy2sO5PHe9a3vx2/4kRs4?=
 =?us-ascii?Q?wypEVdBxDaKb4arg9lmoLpp70dkzOyvIsB32H86fp5DtMgkpTOfiQFreKDEz?=
 =?us-ascii?Q?s+31ByyI4zp72Evngiz8Ctn4clXcos2JpsUOhiPCSRavoeafjqFjRyfvuTBB?=
 =?us-ascii?Q?BwwW0GvY+yP5aD1fbxqdScJGXHaVbzm2lQXtCM/hfYL81sD8QClvUT7WPy7O?=
 =?us-ascii?Q?aQ6agHJyarePWokEGFq68TCIKlu/S71LZaG58aajg/PXC9HHtPl5HCdO91rJ?=
 =?us-ascii?Q?U/Yivl0d1gDnjlMnJOKjyJK/PT4sHCRMGLIpiYHA/TG1ubOvruiE7W2CKYZN?=
 =?us-ascii?Q?3hgaYuPWYScu+FlIWiRdgMAi5B9VcBIeZDEFGf/RXAJTyGAtScUmA/L1PFrp?=
 =?us-ascii?Q?rCRfJAHaYKAS+3l+90XJ2ukVqdR+ugquoGc1e6zvXAvL8FMlKVFXWZaJtT/c?=
 =?us-ascii?Q?p0aO99sUsDGPZAHJAYZZaqG/GNjg6eUb91f0kDXuLmRtNcjrJBKX5g9FVZte?=
 =?us-ascii?Q?AyBlNr3Usa0s0PTeQHSYez1X0Lw+PIDEhPr6ji7+MSS7w85NG7i5GzJDNih/?=
 =?us-ascii?Q?u0nlteTVaA8tHC42xBp/F3hMGwBrkWAyRUZ0uLS8wT7uxZMgkTxGknIL+gI3?=
 =?us-ascii?Q?o5CrrdFixDWYLQ9/EkGECC/pKNdFPGUFek+GLp9KlYDqvckhSzxR/tHFo8su?=
 =?us-ascii?Q?FA=3D=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5faf442-f430-4982-c520-08de2db78464
X-MS-Exchange-CrossTenant-AuthSource: SN6PR13MB2365.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2025 13:18:55.8241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i4RG8BtTbMyjxUIBXexN/u8UWWfapzMYcZsg9PIMslX6ZViDXwEMgARDE5UthHmZ1BWHnBLk2R9UBu7czmsMhusQArEddAXQuWl1PcD0Ois=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR13MB7176

On 26 Nov 2025, at 19:36, NeilBrown wrote:
> It isn't so much that the change is incomplete.  Rather, the change
> introduces a regression.
>
> The old code was
>
> -	error = vfs_create(mnt_idmap(path->mnt),
> -			   d_inode(path->dentry->d_parent),
> -			   path->dentry, mode, true);
>
>
> Note the "true" at the end.  This instructs nfs_create() to pass O_EXCL
> to nfs_do_create() so an over-the-wire exclusive create is performed.
>
> The new code is
>
> +		dentry = atomic_open(path, dentry, file, flags, mode);
>
> Where "flags" is oflags from nfsd4_vfs_create() which is
>    O_CREAT| O_LARGEFILE | O_(read/write/rdwr)
> and no O_EXCL.
> (When atomic_open is called by lookup_open, "open_flag" is passed which
> might contain O_EXCL).

Of course, you're quite right, I should put more effort into trying to
understand your very first reply.

Fixing this up seems simple enough, I think we just need to do this on top
of what's here:

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 7e39234e0649..6990ba92bca1 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -202,6 +202,9 @@ nfsd4_vfs_create(struct svc_fh *fhp, struct dentry **child,
        int oflags;

        oflags = O_CREAT | O_LARGEFILE;
+       if (nfsd4_create_is_exclusive(open->op_createmode))
+               oflags |= O_EXCL;
+
        switch (open->op_share_access & NFS4_SHARE_ACCESS_BOTH) {
        case NFS4_SHARE_ACCESS_WRITE:
                oflags |= O_WRONLY;

I will send this through my re-export testing, but I don't think that its
going to produce different results because we lack a multi-client test to
detect cases for O_EXCL.

Ben

