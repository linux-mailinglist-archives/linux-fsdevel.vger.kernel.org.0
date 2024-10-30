Return-Path: <linux-fsdevel+bounces-33248-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5682F9B63D6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2024 14:15:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15EA52826C0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2024 13:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A104315F;
	Wed, 30 Oct 2024 13:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="F60hM910"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AD33FBA7
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Oct 2024 13:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730294119; cv=fail; b=EbM5vWzQ70fOWQ7Z20+C+5xtzvdWhtMJ+RIeO5OYA0TeWJuojqpjjDNWmMEVBTSFDSHXrhCC2FiLunaIjQZoLLGa3IEFkxyCUTA6yGbDOUMVNYVLpgptodO8/iwn4hnpZMTyGESzYJn43cwyswLhFFuYPiFukwfqHhYjgtD2V4M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730294119; c=relaxed/simple;
	bh=1kRqoXvNbbHNJ8MNvWV8e7wQ6fPp7oHheHgTxIXqZ5U=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=Ley5xIEJOAJrMc04guhN+HbhBpR6pHQa8miFbqwSX1ubREqHTvNkD5Nuq46kgZ8b8ObzYr0PIHDRcRbR4ggeZ1g+RcOluVcptfittxnCoOynPeSEC+m3QC7ESVcu+GmqjiLwH2z//a/pNR66ePQs2FJzDVlZRv5XNgwMsQ0hjiY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=F60hM910; arc=fail smtp.client-ip=40.107.93.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OnQTwBi5FIFta9srISgukNjmoT6WdPGjypfNNiKoIGjJSw4oPA1MoA2NKlulafZ0U20h6JHCVvrqX+EdOGhSdNV+ZlStvN2NMxjcXNAoK0zpUyQqUlNb9sfk5wI8XwTjZ+b08ZU5s12+/SEemFdfSJrg4cG4FGH8NiqIBipJRFaJIJ91R56OCFrOb8igh13wa1byYqRtG36zzVAMfDxHUSDN4LOww5PpQaEEmuV+HowtKyjxLrSfBWAJwJeX9Ibi8DHUi0XZ6hyHvinasOLdWkd7P/k3ocZXDkUoS2ixpRULiQeEK2THh1/5sYpN963XDlBy9Pj2Rg02DRpQZJC8Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=POrGTYKQRm65vfWj+wdxs85fC8o8a64BzC5jvIKu99s=;
 b=P2ZrbdcNBUhXoMaH/5WvaNOvxy4mH1D2Dsm2VQB9K17UPlF2IMj7uTHBwPo7CM2s5uwCYGbGW8P7bg4ui+DalcM2SeAF12LW8Iw6ACZAFbzsFZXYBYM9S9AF1s9QR5OLLWNmOWOGySN9UEBdT6gAxk8UUJ3gI13DMYAsGt3sB+PnVZTG6WtZiUYzmA0Yufkn5u+NrbFn1nSA5zLqHGGB4yPtr1MaXdlD+hG/C8UZy8jo+TIFuPEEghHU837MZusf0ORv+gbjdC56KeWhQ0N3AYzQzC2YfOQexztTlOXC67ZTcKZ1EGj/g2tp0iS38YROoHFf+rGnl8+axmQ8DiXhUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=POrGTYKQRm65vfWj+wdxs85fC8o8a64BzC5jvIKu99s=;
 b=F60hM9101v6FnN/FLiWTrvJVMMWqmSUcGZo1WcQwaXycwCO+mp8HJJMBhFWPSluV5qri3ysNiWVy4gNe+HYGew7EIGMaoZ9UW8Mbb4qRePknGYVGZ0pnazKxwEPFR4GX1X0OV+d14WG+0vMH/pId8MXQCRiVl/0TAV1XCwKe7fHcflFhCiz7OwRapH2m1mDYZHtaL7hpslxYUFFAeXKWl09baSK9Rxl6XYjVK75g4GEROFyg4AG727WJ6HBDk3Hz6rn1MB+PkP3Sx7n/fP1JZ5iBI9FEAr0NwrXHFifTUmgWTgIU840LNHtozE6SWh62khACr5BQLG467xT93WvFRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SA3PR12MB9105.namprd12.prod.outlook.com (2603:10b6:806:382::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.27; Wed, 30 Oct
 2024 13:15:14 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8093.018; Wed, 30 Oct 2024
 13:15:14 +0000
Date: Wed, 30 Oct 2024 10:15:13 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org
Cc: Nicolin Chen <nicolinc@nvidia.com>
Subject: xa_cmpxchg and XA_ZERO_ENTRY?
Message-ID: <20241030131513.GF6956@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: BN9P223CA0029.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:408:10b::34) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SA3PR12MB9105:EE_
X-MS-Office365-Filtering-Correlation-Id: eecb6edf-f497-4ae7-1a3d-08dcf8e4e3ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?X3QCdhRCrf6t687cvdgBvhPJ/IBRxb6JVZKzPI8SiI+Jq3RL3yIg31LNiCln?=
 =?us-ascii?Q?7Q9y+SXG492/Q+Rt+ZDPQcPz0JbTGrutkIRBue5xKkK6kHqkBAlAg7Osk6Wv?=
 =?us-ascii?Q?DKGR4/TyQcxNL+fKhP/x1fW1VoQDlsYp4VBK+A47Y13XB+HAuTv01ZZWpGbo?=
 =?us-ascii?Q?BRrI0mgCU77lCTdaShFu8AhdTQTaFe8InNrsawLvCk/8aqhdIIAhfJ3dG4px?=
 =?us-ascii?Q?b1VkLf4qRuCVkyPcVjJZfc2j+2k/DkfGZdpQshaVZUqOhvYEtPLbT/q7WDl0?=
 =?us-ascii?Q?oYFNUo2Mc46fNq0ndg8JAOKivV2bLd15K2Ek8OxQ4ocMwDJ513AIinnvthMh?=
 =?us-ascii?Q?hJ/AqtiaojINHogjmsFZKAoNwMLfgGuStNB886Fdo6I1ERBf9d7xLNK+Myeq?=
 =?us-ascii?Q?xxTI6U1fDJwl4PxeEhsTwk+oNfeOevPrHFthj3zuW99Kf6iTGnZGMhJKLLB1?=
 =?us-ascii?Q?kBWiX8eclQ8f0EEXz0DVDi4nVFNt1FTFx5PYF36Ok3wyIirnzumeoHSz5P8U?=
 =?us-ascii?Q?KDnKZdUgGGf0KeYFqv53DjO4UNHiUVb0zsZO3B/p3p8SdQYenmSAnPWX2Ux1?=
 =?us-ascii?Q?PuLGRCAMqHXugFmFmpEL2iUnU4SWqhcjvx8ZXC7Tobs/LeMgi/IwZeESzYKx?=
 =?us-ascii?Q?dSb9CS9bJfygZTSr5wiI3TTTksTJxo47fn3xRi3ndrUeWhmJAn282MRYznBR?=
 =?us-ascii?Q?ZxA8XzDgJdoo7Mx7ESbB+Hw5SoG1hzTpuIccSTnjMqSw/J2lcaN0oXEufdb1?=
 =?us-ascii?Q?jQadAYh/SNCrVNDChJ6RnKtyVp7j1llFV9waAD0I1WSVL+lCWtcM5901EmIU?=
 =?us-ascii?Q?7Bke0SOc8Y2rkpcZboIWZosAEQPH3gBL0f+rkoZwGmnnSP1hJIsNcJs1AOYw?=
 =?us-ascii?Q?bEzcvEA/E2Wt6eL7snzM7dnaDxn7/CLG8PEnVEIklKG+iUqy4XdUhLoJTbcx?=
 =?us-ascii?Q?M4OVDPFmoAFruZOfA+d2J9YAZOBvIF1D5m+R6X8GeeX1JthA24xrcARxbqzp?=
 =?us-ascii?Q?4X4ljIS6cL4bVLNjhMhPYQ/L5KlCg8jMR2kE/uytK7FRsuA5rd0pKhttU7rP?=
 =?us-ascii?Q?1vd4RnbDUkaVqFIyFVmIcsRulLdeLHbbRxBHYHwkKWnJJEshVGdHSkmUZI36?=
 =?us-ascii?Q?75/sO/TJaiMy23pfJucSc803rJOSZK6Vg3a/zeYE8BQ+dW7TjeMffVTvB8kO?=
 =?us-ascii?Q?eDafZZPkbgjQFX3NgqbOXVyeoUKsZkqqg03N6MBuWw1SKHCr1uQ8iCJSJLx/?=
 =?us-ascii?Q?4raKasSvpG+a8EgTRrdCGhoRs73m3n3ttUNzfP5lh3mMFL7v5flS7M/oPGcO?=
 =?us-ascii?Q?uL8tHJKW0POd6/APC4Wn6s8h?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?a9yPyHJqonHebhCfYEbPy9Gz7RTLmei1W5OANu+o2Jm+EtJ8TyM42bJIqxCz?=
 =?us-ascii?Q?IQRAkM29SHqEtsuUv4dEk2Fn9+jD728fcuIGHQxDRcLxf52GC4/PVP/ar7kZ?=
 =?us-ascii?Q?d+wQqhKO7hPeW1HqF9QTBdXAZoqQ3ff6zZ+eaqTVq+PsJLeHaxbx8bn4NrVb?=
 =?us-ascii?Q?ljlSD2S3oHFxKGZqZntOUdqhTYh2rBkJsMUi7F2aKcKU+HaqEtH6NsDPcFUn?=
 =?us-ascii?Q?RLRHMwSGfYSQkaNxveOEvnZd1dKr7MuIkQcsdYN800GCTYk12YIk9MsEquqd?=
 =?us-ascii?Q?B1a53euub3uyigAfXFsW8NQCI8AHHAUWCT0ZXAhy8nFz57e3lKQQtQDyhi7u?=
 =?us-ascii?Q?WxMx4mQpBNhU67DG8YDvJc5u+3TqICdOX+btC7Qw0caIdPTPTSOXIxQdwW7Z?=
 =?us-ascii?Q?hVL4WkZ8dDTaJdpJEheWbpge2AEJ2sPWHRotYr3WUOfM8DbtzLOtFSbQejV5?=
 =?us-ascii?Q?VMs/bZ1tkdRFUSsL4JlQtMD4SgkZTiCMscQD6+rdUJBeBhmBodMg7+9ISpVu?=
 =?us-ascii?Q?e9/4+T5YxW6SQO2vcDpDaNBXXERDeIvHUKuQ40OJcfKc8S6iMzUY2n+NL5TK?=
 =?us-ascii?Q?iQQXBhO0zeFb+AaTW1DWwh8Qe5kUgttAt1Kkx7FRtbBlD/CFh1sAOya0raN2?=
 =?us-ascii?Q?1HxZWU4cTUPAcOKQUhmstvU5C2JYP4USlcSDGofPK1IaIln/WxYZri+lWr9N?=
 =?us-ascii?Q?D/JWlE48X0mRMiuu/DCybZoAIKkrQJEYGIzwV6IQX9KK9wdBIrmr/KjdV3Fa?=
 =?us-ascii?Q?kwDDOsFpPckdQbe1775NvQMxQTj7K4LbWWuCTgFH1wXba2v1+adYdrxK2kem?=
 =?us-ascii?Q?Ee0FanlQUoIDt+n6MPi82nL2Ve9vHFkh112DgYrI1vR0gGL6ZJJsDxZUZbg6?=
 =?us-ascii?Q?Yk5bQxYwt1UB5B+UDxa3J0VBjfl2lZQSXSB5gYZBHUd6C162cRdgX1v+2gjR?=
 =?us-ascii?Q?9whU8Cb5yqip+EUSI/HGSbbZssUTUow/tDv9v9jl8uZ3HqGG2ZbMGcFoceXM?=
 =?us-ascii?Q?vxoamji8KCJW/VJrMxReFFS6c+7L6oprpoKmCnrSDN5e6HqPLt3bhoft8oST?=
 =?us-ascii?Q?BvfJrFW0bjhflvQ4M2ubR2WvoOTi5wlZYRYYpAbcWk7Ogo81fQfnnsB5gDsQ?=
 =?us-ascii?Q?txAF6pn3rewWHEO1QRSe5RYmQPsnuBaMrXVLObyb1FQgusUwgXcXql0ar2aU?=
 =?us-ascii?Q?KHBqqFxUNO6JuQtqaP1yL2Yby12wQY75mIhNsXiFk5gvKuu/VkXbey6t05MO?=
 =?us-ascii?Q?qVchZGCh+/CRUlfLwcLkxtX+bfMs9VInwqgH3MTnWS4/NHHocjLQ7esWAGfh?=
 =?us-ascii?Q?lbEJLOz1jiB+fBBs/h5sauxAjDP9vgcswYiVH3fCHiBMfbKAvs7MEm4l9HYY?=
 =?us-ascii?Q?b6kbbZypdXOmdJxG/UL51RNLoCMKRaneFvCQGLORbMtu83q+F3fScLIYA8wt?=
 =?us-ascii?Q?zcG8A+M1Zf8C0/aSxNWZiNhofUNCCIhRCIiXyS0B70hgakBk9KzP4utOoxDh?=
 =?us-ascii?Q?j15bBCgg4EaCHOKx5+qrpGTxhd+uvMr7vRX0boxOJlPLjsaILKlHpQTNbJEh?=
 =?us-ascii?Q?s+fB5KO1Q6biKFgBLiqpO5eyjLxB7OnOteoDurll?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eecb6edf-f497-4ae7-1a3d-08dcf8e4e3ee
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 13:15:14.1589
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H54SLGItdTIMweke6I2+R+4Lfq/t/GnvL3uu+DgFaJx5MKs2rJwY2DSsXGwX9uYW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9105

Hi Matthew,

Nicolin pointed this out and I was wondering what is the right thing.

For instance this:

	xa_init(&xa);
	ret = xa_reserve(&xa, 1, GFP_KERNEL);
	printk("xa_reserve() = %d\n", ret);
	old = xa_cmpxchg(&xa, 1, NULL, &xa, GFP_KERNEL);
	printk("xa_cmpxchg(NULL) = %llx\n", (u64)old);
	old = xa_load(&xa, 1);
	printk("xa_load() = %llx\n", (u64)old);

Prints out:

xa_reserve() = 0
xa_cmpxchg(NULL) = 0
xa_load() = 0

Meaning the cmpxchg failed because NULL is not stored in the entry due
to the xa_reserve(). So far so good.. So lets correct the code to:

	old = xa_cmpxchg(&xa, 1, XA_ZERO_ENTRY, &xa, GFP_KERNEL);

Then:

xa_reserve() = 0
xa_cmpxchg(XA_ZERO_ENTRY) = 0
xa_load() = ffffa969400d3e68

Ok now it succeed but returned NULL.. (noting NULL != old)

However, if we make an error and omit the xa_reserve step():

xa_cmpxchg(XA_ZERO_ENTRY) = 0
xa_load() = 0

Now it failed and still returned NULL..

So, you can't detect a failure from cmpxchg if old is NULL/ZERO? This
doesn't seem right.

At least I've already fallen in this trap:

static int ucma_destroy_private_ctx(struct ucma_context *ctx)
{
        WARN_ON(xa_cmpxchg(&ctx_table, ctx->id, XA_ZERO_ENTRY, NULL,
                           GFP_KERNEL) != NULL);

Which actually doesn't detect cmpxchg failure..

So what is the right thing here?

The general purpose of code like the above is to just validate that
the xa has not been corrupted, that the index we are storing to has
been reserved. Maybe we can't sleep or something.

Thanks,
Jason

