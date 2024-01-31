Return-Path: <linux-fsdevel+bounces-9676-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 611628444A9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 17:36:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2EC228C8EE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 16:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0275A12BE9D;
	Wed, 31 Jan 2024 16:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="FMNKTyaG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D43E12A145;
	Wed, 31 Jan 2024 16:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706718965; cv=fail; b=MkBM2jm7wI+HAiDlsk2TQ8Y6vtkXPdH1IFCYNwuPEWlCu9PUF4F5YG910Xz9WcsAhuLR32etjDiHJjvNJ8ICGiNCKMPQrE1OMDTkmeyN8l7KaCE3Y5+WM6JfhGxRt/viJbtgB2bvQ9vi/m4mwgL2z6czVopwBCKq+tRwe0kg8kQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706718965; c=relaxed/simple;
	bh=e5skd30rZVn1yNwPJ/Md0gVpM+m7WKieWIqw8eIYzvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=S84OyqQfuNmsHpc0SFbfXuVix7w4UoqIIzlGJkogUEGBQydmKjpWDLiTgBPXcl4Vzry88VSDJWNkvLUbYe5BOdZ/cAqnF3W2YITwYY4HYyidNFGjryWA2yfJT3hj638Eg2mCSMO+5N3B6D89PfPviCDLxndSQ1UMf+Ehkbuw29A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com; spf=pass smtp.mailfrom=memverge.com; dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b=FMNKTyaG; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=memverge.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M8DZ+m04sAl/eq/0O1x93JfOGhZyqxXVHbVBjeJGfqmedr5vlQ63QRsUH7Fu1GiXEMJmWES/EtDOoc2p7Q5/nnKRehNbG6FuJWf5a3HL3cnMVXjAYgwTuxMSXaqsooY6mK1ALT2DtgZwvB0may+A2axDehi9a0IXHVVMU0sP5M1uDK8/+usURwCh0KNPUTRDOu1kEu110Eaa4Hv5ue0UEdAEMtSRMoeWdcDqDahpqnB5f2hMeFCWVqAfStoM5tlxggWCHzCbwBNnNuuSObTOzuIgLKzV+yfJnk5F/glHRabO+reOBrwyYkTA12Pb3zeLpnU3CvoKHEWABKJTFTejTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xcll2HF2UN/e3l0oBF+A82+MxKVAH2OH/1Q8jclXfrQ=;
 b=LmQGo9IolTFXzwHjhVwv+W7vLF7L/WRFUoaLPGSaEuOGXzhXqZjGKCXJvwuNIx3+NrmJHIQo/J0qAnoxga9nmgSCVr8Wzw1l5AaIioWvIrYG5uT7leQsJlgVV6wEuiUKaWXdn+WkBJz3V+Jn2LcQk/6LGA1vZZvdi4HeyTBCUkbQdD47glKxO2EOcuhrKXTVkGyMbhhhN8XGTG3BTjb6SQJrh2bLTf7uP3b5OyD8f0Ps2wbK/wvn3/xg878W/sFGldNIIcN1jDkk/4vhHsaQdsKoK/KvAxnmUUuBDoIu7fN627BYtMWPhYvy71RGOkAOYXcgv9i0xyOr3RO1JoHuNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xcll2HF2UN/e3l0oBF+A82+MxKVAH2OH/1Q8jclXfrQ=;
 b=FMNKTyaGVrEvFZHaB/01YmdHWDsEBCan3WtJZsvuTQzE4wL2PRjzvnrZNpoZmaARjwbP2IQaSA6z3kRJGlagG/ZSWHZFlK1NETN6mKTdgY5zYOo97pj3I4xPvljvHMjM23F+TOMzyQmykyKdVgUaxTa5BUr26f7w8PCP9xro794=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by BY1PR17MB6878.namprd17.prod.outlook.com (2603:10b6:a03:52e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24; Wed, 31 Jan
 2024 16:35:59 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7a04:dc86:2799:2f15]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7a04:dc86:2799:2f15%5]) with mapi id 15.20.7228.029; Wed, 31 Jan 2024
 16:35:59 +0000
Date: Wed, 31 Jan 2024 11:35:53 -0500
From: Gregory Price <gregory.price@memverge.com>
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Gregory Price <gourry.memverge@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
	corbet@lwn.net, akpm@linux-foundation.org, honggyu.kim@sk.com,
	rakie.kim@sk.com, hyeongtak.ji@sk.com, mhocko@kernel.org,
	vtavarespetr@micron.com, jgroves@micron.com,
	ravis.opensrc@micron.com, sthanneeru@micron.com,
	emirakhur@micron.com, Hasan.Maruf@amd.com, seungjun.ha@samsung.com,
	hannes@cmpxchg.org, dan.j.williams@intel.com,
	Srinivasulu Thanneeru <sthanneeru.opensrc@micron.com>
Subject: Re: [PATCH v4 3/3] mm/mempolicy: introduce MPOL_WEIGHTED_INTERLEAVE
 for weighted interleaving
Message-ID: <Zbp26WZBkzhpLTLV@memverge.com>
References: <20240130182046.74278-1-gregory.price@memverge.com>
 <20240130182046.74278-4-gregory.price@memverge.com>
 <877cjqgfzz.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <Zbn6FG3346jhrQga@memverge.com>
 <87y1c5g8qw.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y1c5g8qw.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-ClientProxiedBy: BY3PR05CA0012.namprd05.prod.outlook.com
 (2603:10b6:a03:254::17) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|BY1PR17MB6878:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d1ceb2b-5ad5-4b77-75c0-08dc227ab48a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JbROw9JFq3i5mUJL6svO/fKzOz+nupBpwhfGF2HpV1PFTtCVwzxj1wLpcaknQgiTad5gnlFlA1sbp823w/+gsuVsjMM/5yF8o7+qThltyKJF/PLjZgmxaOymzNWtFxbz1UKEg/UH9Iipt9yQ6QTddWzyWGY59LwoNFXbplLdL4FPHiNjRzm76J+OA6BYWelm/lrYlh6ISi8SZErmgtGSk39aPv19XNV4dMCBfoadjUcT/uyNtluoaHA7jsv+W18Sswdv/pcsBMkA5XUAgalG/FCvCeuH1n9a5IWLy4Ju9At3G9zE+EiMyHXt0ZZqbaxp8Hb1CRH7C63y9BGZaPbSsIjsQdT+8KqDw5wWZ58A5SQsGbGusr0mIYqUDWLilEItlh6b/t0LkULOUoLIePQlczEv1iH39n8YhAvRCmgeut3uRjyrGGexfZQA/jFPE+tOMiDBT1LDT4LcWGZx2kh5MlKeGNt14BwsM3Ed+J8pQ1J83dQaXO7Z/WInywpQdGWe9DEHBkBg7oc3zIL+kJW8ibkdsrPgf/2vPTaJvs3JAFaWOt+egnWHXBfZkM/5qJmtE399MNEgY5upPKfi5FB35us5UWDUTOrGZ5KKaQ5L4KU/NsyxYad2cggIb5NiNA0J
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39840400004)(136003)(346002)(396003)(366004)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(26005)(2616005)(83380400001)(478600001)(6486002)(41300700001)(6506007)(6666004)(66899024)(8676002)(6512007)(4326008)(8936002)(36756003)(44832011)(316002)(66476007)(66556008)(6916009)(66946007)(54906003)(2906002)(5660300002)(7416002)(38100700002)(86362001)(16393002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iLHkSBamSyy51NedgAIFl+Ghj4g/cSmMzxhkU+/PJpf+yVwJWAFGKN/PuDfW?=
 =?us-ascii?Q?xd2dQhQxE8Lp2KhTV29Xx4x3Jvt6mf1x1qc/D7DY+KfZ6RmBBt0ze7pbej7x?=
 =?us-ascii?Q?UtRA59T/HIDbRACpH3Kcd+o7PnwI4auRmXwNDmecHg3ffksEWYY4/6V2x2rH?=
 =?us-ascii?Q?4gEHJ6oTtfeYTNe9cYsyVruyxvmdFHJvSsztbDeJ4esofRBAVzWLmNv7ke53?=
 =?us-ascii?Q?SB8WLAHNc8M8m2c5gfYNTrkJ3cclA+3+2HXfkxOM8DppeCy6TflbjmEZrc6l?=
 =?us-ascii?Q?Y1fjs17PzD8PSmDv8q2uWEslnh4SJxt74TSJGxTtYhsY8iIE1VVttFYreVKb?=
 =?us-ascii?Q?fUcdF8DzxB5RLuAvPh8clfl/64soVVnq2/IImgYVg9xPz5qIosrRnpixhI3s?=
 =?us-ascii?Q?oIPvV0R6Rdy5jAfbSpAGZtdl7I1fxpTge+GaJGV74qNOu2LJAgF3cXQPMIcq?=
 =?us-ascii?Q?5qRXYb/JGw4asmQvTieB8K8RlBH3Z+xlf+iSMwFlKCHKizHMjFc8C3m2mQSx?=
 =?us-ascii?Q?7t2uzLb80fZKrrrgA9xhAxaV3KoIEwIntfuLayQZ5EOu/RUsPb9l4jIX4NJW?=
 =?us-ascii?Q?xZeeZljTutkSebTyZ2EhLdt3RvzAD/lp+mX5GyND/MK7o9ivEbhlyjBzwqDE?=
 =?us-ascii?Q?7vAbyyL6E872oydCSQEYE1668Rr3w1HyoR60JXMmmojHixb6XI7uBzLQB0uS?=
 =?us-ascii?Q?qy+gBzKdivMtoIbAvfmfy2h9Gu0JU0IgrHyGOMnTYpIoF49QtQSR0JDvPLBN?=
 =?us-ascii?Q?Rlv0Vv9idaLOJfLvZx7NgGpT6Mj35ab1uglmg2kDALeRtsB1qHsRXrT9n019?=
 =?us-ascii?Q?qtBmYgOEH7aR34BHP8kA2LHePxLPM5xxtjANx42fmEfRj1ez8LZkdOhndjTf?=
 =?us-ascii?Q?YmFPb45yjsqAuN/wYshEQsEkjuxTr9TMsMFQstYmrdS9Pgjv1GaiHLRIQEj1?=
 =?us-ascii?Q?8iNmn4wZ/ZpjNuOe4U4CsRcA7pdReIZ7d4GbITzmcBrjm73veI6AB6uF+DT2?=
 =?us-ascii?Q?Q33VGcAGYlKln/HrJ00BZWe48Ni14OteJ9RY/gpRexI2dnGUk44v68k1Niuz?=
 =?us-ascii?Q?ZwzMYfhSS6+gp68td1YpEizr9axFKpkF7rUYKSb5Rrw3spr9rmpzOKyKdyTW?=
 =?us-ascii?Q?ZRc+UNEnMXS/fuDe2wMj138Os/BRDbzFTo0Y0gvbLOwgIjbPT7e8Ma3vZane?=
 =?us-ascii?Q?7x7J5kA+5CqnYFBRXWJHBNGCNYyOxDBkH/i3hIRpFCb+KixM7kxRn5tel2q7?=
 =?us-ascii?Q?X1lLmRwaMCKmGNkALCoEGxzW8NL1Aka1QPQ0Vf4LDGFHpf/wLAKqZTzu6YsY?=
 =?us-ascii?Q?r7xXfQKeX8MnnsyAwJ0i1TaYxl83QR5gbh4dTGONs1/Q7iANZzX253Oqs2W3?=
 =?us-ascii?Q?Rn7hZ0T7Fz3D71Oo7XULPy/zvUNu/ow2FmZQi0MDk6asy/oo72V2aPpYvWU8?=
 =?us-ascii?Q?9f5hWZbyPGCL5v6XTq12rHH3MBxG9JxrXswzG2zoYLFMWt+Uhe8rJnrm3v5E?=
 =?us-ascii?Q?CjyRM2ZplqsQwCfOcx5GMM/haoW0NMj4HuTZg3b39e04MXckTRO7HSpaquH8?=
 =?us-ascii?Q?xBR0oMJyzBLbQVDpkfsaobPR7znKZOfyK1C09zGYlojZkB4nByxB/xggNVAd?=
 =?us-ascii?Q?Mg=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d1ceb2b-5ad5-4b77-75c0-08dc227ab48a
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 16:35:59.1692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bfExtsZ3aMZfRmJt1mGuuEDhGT7Cme0mDjcjJyErGagf8jgaf3WtFk1cgHfcK00Kn+2AHWhj03Bl96OBooL6Yb9GO7BSJeNUtqkL4/K763s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR17MB6878

On Wed, Jan 31, 2024 at 05:19:51PM +0800, Huang, Ying wrote:
> Gregory Price <gregory.price@memverge.com> writes:
> 
> > On Wed, Jan 31, 2024 at 02:43:12PM +0800, Huang, Ying wrote:
> >> Gregory Price <gourry.memverge@gmail.com> writes:
> >> >  
> >> > +static unsigned int weighted_interleave_nodes(struct mempolicy *policy)
> >> > +{
> >> > +	unsigned int node = current->il_prev;
> >> > +
> >> > +	if (!current->il_weight || !node_isset(node, policy->nodes)) {
> >> > +		node = next_node_in(node, policy->nodes);
> >> > +		/* can only happen if nodemask is being rebound */
> >> > +		if (node == MAX_NUMNODES)
> >> > +			return node;
> >> 
> >> I feel a little unsafe to read policy->nodes at same time of writing in
> >> rebound.  Is it better to use a seqlock to guarantee its consistency?
> >> It's unnecessary to be a part of this series though.
> >> 
> >
> > I think this is handled already? It is definitely an explicit race
> > condition that is documented elsewhere:
> >
> > /*
> >  * mpol_rebind_policy - Migrate a policy to a different set of nodes
> >  *
> >  * Per-vma policies are protected by mmap_lock. Allocations using per-task
> >  * policies are protected by task->mems_allowed_seq to prevent a premature
> >  * OOM/allocation failure due to parallel nodemask modification.
> >  */
> 
> Thanks for pointing this out!
> 
> If we use task->mems_allowed_seq reader side in
> weighted_interleave_nodes() we can guarantee the consistency of
> policy->nodes.  That may be not deserved, because it's not a big deal to
> allocate 1 page in a wrong node.
> 
> It makes more sense to do that in
> alloc_pages_bulk_array_weighted_interleave(), because a lot of pages may
> be allocated there.
>

That's probably worth just adding now, I'll do it and squash the style
updates into the branch.  Sorry Andrew, I guess 1 last version is
inbound :]

I'll pick up the reviewed tags along the way.

~Gregory

