Return-Path: <linux-fsdevel+bounces-39459-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FFDDA147C9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 02:55:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B6DB3AA659
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 01:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4926D1E1A17;
	Fri, 17 Jan 2025 01:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kcReJsJh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B2025A65B;
	Fri, 17 Jan 2025 01:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737078890; cv=fail; b=J1qTsk5E6OJEmnW4WCQnIKqJ9VYQONXdDKt2yemNt7pRbkM/srhqFbzTyw7C4mitWSHUkFd7yqh53qqfI+0FsxFsbhwCTdZfak8ar4mVTJ6r9KXY+Uz4C8ErQ6A5/xWhz3Mb43OSJWBObWoIskf99UOuyzvN8GLxZGWEPA6EE9s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737078890; c=relaxed/simple;
	bh=zJmcQNMH/4ZdSuAxeLQHhPZc5paiSCsbOrkcx2T46R4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iPDPgs8oJw16J7a8Mtv0m5sXPVUTkQXQOi+6Hayn/sVMAP9JEAx36Pgugty5R8NIo8nmzTfpdYJo9KpZaWb6H0wa/Wp+HMylgNLryZbxwIQ4Vm3SFUnkJyuPvh+2lns3K87rvVZoWlCPZdDShZMvAVa68IOvr8LZgNU5EPaaSWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kcReJsJh; arc=fail smtp.client-ip=40.107.220.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p0Ndik2jUJLLqNfyDZDeLNl0yWLbsxxOHUlriBEB06QDE/IY/XeEYPywChj79cZiPLeeR739wTHdhuXQ5Gw1pjs/X+rqbMW/0QZc9+uplc+Mc5+tvANDto7jlrNoYJW818Rt16/IPpSnvKPArDJ4uB6JPrPJA9dLiKZBmnyo7cGZ55rW0m/Cl9YHC/vWQNzfTSRx0ikGLmbyrQYqjKDzHxfFE0lcWS5cxp3vjSKnp1FHsv0KPZy3We+OfLKpsY8mkB9Of+gUDMe2+nJ4LJLrkFKs+v+4B4vrLMGN0hZibwcFzgmD5UM2fFhKUMTo+QY5MrWGEinlw1NPNHpYv+NJBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hpQhF1Eu3o5/dVcEBvFi4uqy64IBZ4EGdR7QRq2M8j0=;
 b=IVSCvIVGZLKTUl3fFU4IN83os37u9e4oqQ+5wsZGJ6In+mLN7hOdNiPcIFmvYzBdLywWf12kNP/sEkBTTyrocd82yS3kYucLN8B6gBV9zo3KhUo8XbWflLXgngUTyFEQzoUHIjpvkQsjfGUKdtXYrq37UhyP5a2mkfhPO9pzYdBIFoKrs2TtisAZheLCeUJxaerV8aB4cyLauKNEhkTrvzYTpnUblRyCCn04mCd0t+YOu8F5fiVIu41oh8lvaiXaSYlpB4QfYgiPQW5ie9L/ko5BUaHkxfF02+RpUj8s9wIDzLxXrbmqRUXZjMgmZUM49RL08X1gZ13yO/FWPn1pMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hpQhF1Eu3o5/dVcEBvFi4uqy64IBZ4EGdR7QRq2M8j0=;
 b=kcReJsJhU7OvOX+s02NrSJrEIy8pDI8zLOE3MnXnlPKiGn2ldR/cS69jj9AiVXJZc/pEVfEUuYAzvTEqQ7ReDo9yGFTCshtTddiWCm5eakx1+K+j+xCgR+zpT+kjdO/J3bTVvcuE5cAARiW5xtlBU1HcIdAeTfv48RffJyUcUXhut4r/kaDujDgwCWnCHpmsDEbjXT4xeKIqIDaXfp80iSZz6Mha/eBA6tzco7fyCEvEyqSdbQWGTzKzIfZJpruxZXoG1QniHubLHx0WKUf0gox6c8C2oNihuBk7RQ/F7V4XRwMQOmPdckNCvEl2SIayMC6fPGyTm7xsXnOcr6sJzg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 DS0PR12MB8272.namprd12.prod.outlook.com (2603:10b6:8:fc::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.13; Fri, 17 Jan 2025 01:54:46 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%7]) with mapi id 15.20.8356.010; Fri, 17 Jan 2025
 01:54:46 +0000
Date: Fri, 17 Jan 2025 12:54:42 +1100
From: Alistair Popple <apopple@nvidia.com>
To: Dan Williams <dan.j.williams@intel.com>, a@nvdebian.thelocal
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	alison.schofield@intel.com, lina@asahilina.net, zhang.lyra@gmail.com, 
	gerald.schaefer@linux.ibm.com, vishal.l.verma@intel.com, dave.jiang@intel.com, 
	logang@deltatee.com, bhelgaas@google.com, jack@suse.cz, jgg@ziepe.ca, 
	catalin.marinas@arm.com, will@kernel.org, mpe@ellerman.id.au, npiggin@gmail.com, 
	dave.hansen@linux.intel.com, ira.weiny@intel.com, willy@infradead.org, djwong@kernel.org, 
	tytso@mit.edu, linmiaohe@huawei.com, david@redhat.com, peterx@redhat.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, nvdimm@lists.linux.dev, 
	linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-xfs@vger.kernel.org, jhubbard@nvidia.com, hch@lst.de, david@fromorbit.com, 
	chenhuacai@kernel.org, kernel@xen0n.name, loongarch@lists.linux.dev
Subject: Re: [PATCH v6 20/26] mm/mlock: Skip ZONE_DEVICE PMDs during mlock
Message-ID: <2oqithhbrzugwdyucy44ehcl3oumly65oml2ozi5x5cbuj3pxp@empgh6q3buzy>
References: <cover.11189864684e31260d1408779fac9db80122047b.1736488799.git-series.apopple@nvidia.com>
 <e08dfe5ec6a654e8cb48f9203d7406326368f5a6.1736488799.git-series.apopple@nvidia.com>
 <6785cf266ea89_20fa29487@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6785cf266ea89_20fa29487@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: SY2PR01CA0020.ausprd01.prod.outlook.com
 (2603:10c6:1:14::32) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|DS0PR12MB8272:EE_
X-MS-Office365-Filtering-Correlation-Id: 10aebc8a-4fc3-4fd5-4fc5-08dd3699eb60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MWXGs+NOUhX/MZLeCteINhkZxXMkzzQnns/R0OOpV9ii0xc4W/kMuOPdsLQU?=
 =?us-ascii?Q?ZkwAFpc9PaRKZWlelNDKpVvSOyE/2qvw0Inc8O6sXvIKYJ2jyMBFdZ0MX83v?=
 =?us-ascii?Q?5aPmFNheu/C3l2IRpc2U1z4ekxdbXdGJlQha8Gy/uHTpTEX1tO8ynSiihRwv?=
 =?us-ascii?Q?gr3FsEHACSFqTd2Fy3vTgO3tnfqS1M80+vkdWXuRa97vPv+flacKNkP5QHPo?=
 =?us-ascii?Q?rDFZAywmFVbb8eiUOVvM3rOC4+hbQWQk8bxrbGwM0Gn37pcv1/8Ua6QOBGro?=
 =?us-ascii?Q?ANGi8gUuPNZscHQsqqjULvvdjb273COGhOTbWAMaxRE5Pmym6Wc2nEObNKMr?=
 =?us-ascii?Q?j3MjFNdf5T9gctwpY6ZRjXH225oiWwLB3ta0hbkE+fTA2mtroTf/DQDMh0hs?=
 =?us-ascii?Q?yvGu73TYjuMOSa4uVKKZFe3xPLTb/aDhTvRnpUr9JtuJQC65Z3DeBFpjhrJ7?=
 =?us-ascii?Q?3QYTGT4TI4PrtCXXXE2pWb5Ar21xyOoIm8jOv3GRykNVBgPSQ5mx0sl5JjKC?=
 =?us-ascii?Q?DmVMOGbWkpI6N8oBWt592eSEJY1eKM63v8JZwnE9je0IMttKsn93Y97lYfXZ?=
 =?us-ascii?Q?tBoFXSZ2YV1vSWClxU0yGEENzOCiwBTqOLG/LHfTD10jR3atKXUanR3UcVIG?=
 =?us-ascii?Q?+JkjBzxf7I2AryeVw0qvYTJ3tKGGEw4Passf2oItn/84cFOGJYyp/BlXvByc?=
 =?us-ascii?Q?/tfdrUfbeX4w5w++8B0TmBOcjKOMRnYy9U/mEV1DxtGz7fqvz74r5bcrwjNa?=
 =?us-ascii?Q?/z3vBtvO71W2ZbtnUwqXOMKip51mdnwCuzAh3bQgvzg4iQnKKDy5f4t6W579?=
 =?us-ascii?Q?/oVdt1AVKLIAGQfTHDcFugDbDM9+KoNagMq5YqP4hNlcx9Kporr5jdJOp3gT?=
 =?us-ascii?Q?0o+5oGl1fdOtxRVNXKJW0srHxvSlgaHTIyFA7DuCivgnLGdyYIrhRgGwNCZi?=
 =?us-ascii?Q?lSiqKQXbdIrutN1sS4bQ5hwGneOCEa4gsUabr4RI37ISjZHqkt/sv+L1sO77?=
 =?us-ascii?Q?E2NbOp0qFje1RcpDzPWSkkp6InPxHfdwTyRYj2vPBLUUm+bOjnXXTuf91SZi?=
 =?us-ascii?Q?mdGf0LQzQaHBqLBhafnsmBZL5pQOJpDX+IXsM/yU3X6jkAvR8L/o01D1THoH?=
 =?us-ascii?Q?094ooYW7NZAL7dMgwVURv8EA40gWsvQkDckjARmHR5y+9XorS9N816ebi2b8?=
 =?us-ascii?Q?D79Ej1wqCfDFb8QO471k1Yemfdk25K3ULOV2kH42o+m7bWigHEx9s3uehGLk?=
 =?us-ascii?Q?ODbC8qGmY3v7RtOD8RQdLqhfzluKKAQ2uLYmebk7nfCruF9YX4V3OnkNpw/k?=
 =?us-ascii?Q?OB3dQs/2fJACpJtDsWB3hTRxLm7yxLonBt9EXArde44ErT4TS6dqKfUJvDRx?=
 =?us-ascii?Q?fj5/GkrQx8NswsPwbSTpgepLvZ9N?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7bsvSXwgl/uWpGvhqsCMERpnYm39nGUpRpNvQgR5DvP9vze5FM9N8lk7YHwd?=
 =?us-ascii?Q?1mtVrQQJd3UKGZwscXnE5oo53WeHRhtA5YHCxRFDuFqVeSg4wqgEsFwg57fF?=
 =?us-ascii?Q?D64R5n09sr0WyR10Rod7+hSuHKHQ7zdoqnL9377Be7Eu31OgKYzLcwe4xpTy?=
 =?us-ascii?Q?nz6nFMgUdq6XCIRV48dcB1wxY2yRvf6DIK18evmKivq10eXNFWFb0IE88B+5?=
 =?us-ascii?Q?7gUYU03ooK2AyL4sqCmFYTxp8XTe445GGO6lahSY+O3i9Q6zRbu1eIlkVYdV?=
 =?us-ascii?Q?WjijLKm4XJWBUZLmNgE0f3D9VaLkUtulUTZdv+w+vtXeZfecn1+zsVABwp/Y?=
 =?us-ascii?Q?v3msX7dnBzUHyh9hS81wPSQhxgRbzdobh4KVyh4s5rSVh8h8hPn8KnTWm4vQ?=
 =?us-ascii?Q?aZJtfr+OE40HdxBTjXR+HyKOw16rt3HxmLDzV6fv+lCbe12JNGm/1X2qYSfQ?=
 =?us-ascii?Q?8LXFG1F89uAddG85AQkxnAFDTCu9k6a1EQlDa4rehQ5D6tGfRw0/HmNpvMVs?=
 =?us-ascii?Q?V47e3JYPXqPBz9sX2wyzQn4+frYAryj3MCe9bOnPhdKt44UYchy3gDXYgeUo?=
 =?us-ascii?Q?3EHtBTTQyvn2GzYgZWTvrojpJHSh3cWgFJZDUYAIaPmrbDd2BMIlikYOuDpd?=
 =?us-ascii?Q?Qar1s08RnHzMB7+STU58VM/7RaaS4MFAVX/xVBohaBtnpodsq1iTUF6Vqol/?=
 =?us-ascii?Q?RpzUVSleIAdDxC+dmcRCMaMOCkyiBNgi5/UflPh+n4t8E+rN2uHylf4HngGu?=
 =?us-ascii?Q?/xos9CTAKRBA+t0AGtmPz5Vg8Um7kZc8/ILVCpuIbF08ICUGrPOH3lbWte66?=
 =?us-ascii?Q?OMUVQEzkUpohVMEd/yoFDxGBpm0T2ehD4WFpMLzZg1JqirGEdQOAx6ufMF8t?=
 =?us-ascii?Q?luM3kiwMTSc6949WIy9LKjJyty+EHJ0wNnoxXVVCbexTfkWhxhLVHICQW5xI?=
 =?us-ascii?Q?Pd1qK2Jf5Cl/besoB/tLO3PGLd/jirn/LjGVyUFrI15pb0XbU29YBGmn3Qqy?=
 =?us-ascii?Q?wZbfhYE9soVRmXnAJY/ACEnAtzH1GOC+QfzB4G+FXvtFFaWjG9eRPz1gDAhr?=
 =?us-ascii?Q?D6vyfkJGE2KytuU3oN3llp83yn2HSoGYtybcEGxbvj0q1MqBnsDXogpoBXOz?=
 =?us-ascii?Q?tBTlXBe+ifWyxByb2XJuduIFrrVjvaZP+Zqz2Uot7tTWnDGX250nIPlCJUUC?=
 =?us-ascii?Q?N7EIk7N+hYk+KBygpI9z5v+0TIPij1WiIzDMsWgWE8IEsyY8BwHRIxdhjkfM?=
 =?us-ascii?Q?YgWCMhHPKwuvTMVdX2rH6Cb74QJNhQhJHaLXajWPmGxXJEDDcGgN22gGNb5B?=
 =?us-ascii?Q?MXsnkxOM7DmJQpiCfwGBZUn4A/b/oDt4kW5ZOPZ6WaNn6FBBBDctrQfBF6R9?=
 =?us-ascii?Q?BE/DQoz//AGrhJJARXsdudK1q5SCALRKvzgK2vbj+qbnxOuA3KqYJkaFW+GZ?=
 =?us-ascii?Q?MyMMwiky9dgOnur4u1D8hWFgDP97pQbDU3PJqled32EYw6gVnqxEHW2uGBXn?=
 =?us-ascii?Q?ixZZg8NWJWRh2TnDTOn5kmc3Till+Ngu6HVq5w3meIKH9tZKsfKzL4oRRWPr?=
 =?us-ascii?Q?z19xTE8wEyR+enOliTUYqPB6ddWnld7hdv0VeSjo?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10aebc8a-4fc3-4fd5-4fc5-08dd3699eb60
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 01:54:46.4350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QdZzbjUSCPneQxQX95jdT2oBpKGz2zQRBy1cLVLGwzHqwn5Wg8cbRkBm6Of1DZSOe3pG/bI3z1XzV1f7ERvuDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8272

On Mon, Jan 13, 2025 at 06:42:46PM -0800, Dan Williams wrote:
> Alistair Popple wrote:
> > At present mlock skips ptes mapping ZONE_DEVICE pages. A future change
> > to remove pmd_devmap will allow pmd_trans_huge_lock() to return
> > ZONE_DEVICE folios so make sure we continue to skip those.
> > 
> > Signed-off-by: Alistair Popple <apopple@nvidia.com>
> > Acked-by: David Hildenbrand <david@redhat.com>
> 
> This looks like a fix in that mlock_pte_range() *does* call mlock_folio() 
> when pmd_trans_huge_lock() returns a non-NULL @ptl.
> 
> So it is not in preparation for a future change it is making the pte and
> pmd cases behave the same to drop mlock requests.
> 
> The code change looks good, but do add a Fixes tag and reword the
> changelog a bit before adding:

Yeah, that changelog is a bit whacked. In fact it's not a fix - because
mlock_fixup() (the only caller) already filters dax VMAs. So this is really
about fixing a possible future bug when we start having PMDs for other types of
ZONE_DEVICE pages (ie. private, coherent, etc).

So probably I should just roll this into "mm: Allow compound zone device pages".

> Reviewed-by: Dan Williams <dan.j.williams@intel.com>

