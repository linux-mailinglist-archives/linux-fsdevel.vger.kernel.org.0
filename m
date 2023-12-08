Return-Path: <linux-fsdevel+bounces-5287-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA0FD809749
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 01:34:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49EF6B20DEC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 00:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B294D6FA8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 00:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="r8VE0l9c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2071.outbound.protection.outlook.com [40.107.92.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 709F31716;
	Thu,  7 Dec 2023 16:12:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OdfCFRCUOMRakhgtfCwgH8ilG7fq138W6k8AiTGr7wuExSME1LJka/Qiy2UYd+1C1Stib+BKAG971VqyTEuFxjhFJNVDkmVwuZG6z4fmwW35XA9DEoKoe4WizWGLen4lISMp4sQ+aBEb66PO89ttC5LttXNCm0sHl5LFQUhQAcdGtH/k+iW7ZcyN9gfFkv84hzm4/Y4cG/A+ZzRfi3CZrSh8XxTizpOeNOJzRW96smMN0XCvdyY+OmcPuUJCG6A+p9Lf7sI/dmmMAdPEvMPVvAMsR/jqk7vnJzOMcYS36+8kOmXU/QnoBLYy742d4O+ZRvAmXEv1k2Tq9HZZ5nplJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=naCROcZwFJyDfAQcKuCqlnhY3Re9LTbXdGrG6K0rweM=;
 b=Hx1kRX80fKddb2hP+FOsdW+8q9QvU5lYoJ9QJr5SVbgJYAr7y7/Li/AcqRheyNIZGOfAF1AeOwcqk8j6ftOAz55yhsLMLHUDZw+Vu3YR3lUUWrmbmeILxGDHhLdD81hcWzbTO/IyfD1ykyWFOfWdpX8rRqXAeTnpQKPw07fMctbwfdKHSv0UhNfb3g1xRizFh0YOkieHuIsJbPgkusn5T508smgZLF8OvZls1ojRqiQkW8NZZhWRp/FrICaupiCZyMEr2aV1YYHF8t2zKB79rUa8T3aC1vT9Y0yfo13+6JXL1Pnw7WinfOOiMGbueOIiPSV5KGgGddyAL7MD1zwuyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=naCROcZwFJyDfAQcKuCqlnhY3Re9LTbXdGrG6K0rweM=;
 b=r8VE0l9cVFEC/bXdYRLK6hxkywI5XFh27aXIDOMnet7Xbt9c7RrMltBIt6Wrpd8fcHJ0arlsB84rA7caEjZ/Jfe4bWsTOYrf1yR/tEwnixOpGOXil8AbcuGZJt1uHiSBES+/q5lHJNgbofbOfdnlKpzWvmImq8PCDvahYij1K4U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by SJ0PR17MB5843.namprd17.prod.outlook.com (2603:10b6:a03:40e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27; Fri, 8 Dec
 2023 00:12:05 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::381c:7f11:1028:15f4]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::381c:7f11:1028:15f4%5]) with mapi id 15.20.7068.027; Fri, 8 Dec 2023
 00:12:05 +0000
Date: Thu, 7 Dec 2023 19:11:59 -0500
From: Gregory Price <gregory.price@memverge.com>
To: Gregory Price <gourry.memverge@gmail.com>, linux-mm@kvack.org,
	jgroves@micron.com, ravis.opensrc@micron.com, sthanneeru@micron.com,
	emirakhur@micron.com, Hasan.Maruf@amd.com,
	linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
	arnd@arndb.de, tglx@linutronix.de, luto@kernel.org,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, mhocko@kernel.org, tj@kernel.org,
	ying.huang@intel.com, corbet@lwn.net, rakie.kim@sk.com,
	hyeongtak.ji@sk.com, honggyu.kim@sk.com, vtavarespetr@micron.com,
	peterz@infradead.org
Subject: Re: [RFC PATCH 01/11] mm/mempolicy: implement the sysfs-based
 weighted_interleave interface
Message-ID: <ZXJfT/EXFu+MtTkW@memverge.com>
References: <20231207002759.51418-1-gregory.price@memverge.com>
 <20231207002759.51418-2-gregory.price@memverge.com>
 <uxqkbmqbvcvx6wc3g2h6vhkutv5flrq6rslwdfs7pa6kknupwh@a245pbtfqfgj>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <uxqkbmqbvcvx6wc3g2h6vhkutv5flrq6rslwdfs7pa6kknupwh@a245pbtfqfgj>
X-ClientProxiedBy: SJ0PR03CA0235.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::30) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|SJ0PR17MB5843:EE_
X-MS-Office365-Filtering-Correlation-Id: efd1d4a4-66d9-4f90-627f-08dbf7824f4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	t3Duk6XKpZ4l7zsZ46tI39m5PyVKQYpIwEn7vT4uyNOfDHnPYz+K4Bk9MLxsNEqz7yEFK3A0jAlpLu5opcglWT6GLQP9JPGeC+civkovDBviCFptMgUc7y8myQ2xgbNUKErioD9WzXj0rskxPX2Zcgr+XGZZ65JbfgBRkj2Zmass3zUQwbATNwHXyShgBli3mBo0LXg/n7eHripRi6XwAjHAqp/CwI3lL9+PconBh2CCaurUcDB1yQbK1iQD8t90Qn2LgWSB9sdzmTegNJa9owxfvHMPKd0PzlPGYBnub8T15LnPTMuKL+Ojj23K6CcMH4FqZYDtnlOPS1KVRvB4X4Q4BYXr0voGYflyS3ZNNZKimpt+0pZS+7wMs+4y8obx8dOu+F3L3Mfx4jZuW6z7ZakDExEqjo4g2iDTOkYrHhamfQTe/PwwlkmdaownPODMP6vBqd4c/BV6EVCLSRt8Hrk2CL0oeiBI+yIdI7HwINe23FRCU2zj3HAoIwAmGVeN63lhFDbBF+qP8SN2cucAbmaHMGL8vF4MW7pfhD9fc8B5nMXlf61d3G0LUKfjnT4OAlbprCER3p+QiySsWVP8mr97QE9ycbQQfF4QaWuPrR7DZtwCSRmr9RE/Msj3vv7Y
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39840400004)(346002)(376002)(366004)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(41300700001)(921008)(36756003)(5660300002)(2906002)(7416002)(7406005)(83380400001)(6666004)(6506007)(26005)(38100700002)(2616005)(6512007)(478600001)(6486002)(66476007)(66946007)(66556008)(44832011)(8936002)(8676002)(86362001)(316002)(16393002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6kM1oHoIff6eXahaQ1lELhOknww9FIYINdzojy/W0zzEc5mqwbLRZuTOf6+1?=
 =?us-ascii?Q?aDr2ksgtXpEAFCvWL+dfvZuuC9iaJVqdIr8yhDhZ9Y/MpCZX4JBswwYRvaFN?=
 =?us-ascii?Q?GhMTkxdCaQyF/ZVp63UhU4/jpINPXA+lgI615CY4yHLl2qKLexDn/F0JLPzf?=
 =?us-ascii?Q?qfcMooDw5/dZ3d1SgdgaD30Pvvj4CbJroNBlFZJ4B+ypbb8w5cegACwApK1z?=
 =?us-ascii?Q?uzGBHaBMxd9Q/QEnKAiMT3YZlFVslLQWPtf46j1X2ebT0mCodZVpcOa+SqMT?=
 =?us-ascii?Q?yTsKKO11fySOm5yrJMNgKHR+gXZLBvClwDobY4BCX2xrSRYEzw9sAEL58Nig?=
 =?us-ascii?Q?5uZEzWZXVYOOJDVrF+srCorBZ4BCuZ4pbarVEZ8oM/e5gyLEeUkdDlGeRagH?=
 =?us-ascii?Q?IEXL2+cPpESiv5fZZ8RM5n1AHv61HHHSI7+mkB81brDLaHgMZgVJjPab37hK?=
 =?us-ascii?Q?1EwAAuGAZEWGAQxm7/3XwwpMWmV9jUMAtIBNa53nnU+7anvM3968CcLVFPaF?=
 =?us-ascii?Q?IhWVPEJOIWQLaDhuMItCzKX92EHw2QseV/hDMF0c6RKvSPOlTScWyEIPAuCz?=
 =?us-ascii?Q?aZ173fSGJeurU3133bNj0yunnGBc42UdDKfQuqp5AVbZK7hMW6ZheUT/3q62?=
 =?us-ascii?Q?dIo2nJ06XGYYf1FmzxoqP+UL92wQ9khl+LvKuo32qpJnpLKeB71VHXW3nXAK?=
 =?us-ascii?Q?HdpoP+vvH0jBQBTDqqJ16A47Pkh/j7DtCvit2+kpseTg8bjYI8BG9x3EWTfV?=
 =?us-ascii?Q?RaRSmBrETQiZpJnAE9Y3vFXSXl5prbZkPh4oRIUu9lvNqfYvuYzVvbFZ8mMt?=
 =?us-ascii?Q?xaoSrnMPpqaDzLynbxFEDmxc6oATfDtvMo19Pkw6cTrRPmF7hMyvb4oRyPv6?=
 =?us-ascii?Q?a5OM4a9qN4fqx0+FI2pyUJXapmNbMz84p6jjHeenIawkIqBnpVCjVDnsxgmW?=
 =?us-ascii?Q?XYzWDqaVNuzNVmb13Zr1nPOX8WB5wT9zuDxFUJVIOsaJulX+tjYrzZDHM4JJ?=
 =?us-ascii?Q?GJ/q8I8EpxG9960lKL3UKPi9FVpd5oI8AnLaWNb8XrE9Bt7YSXX/sMXEiBUe?=
 =?us-ascii?Q?mtiY2TKfRGfQKKfsy86nErka166e97THnFCaz+OQVXGxWaj8JfWwq+DVzHRB?=
 =?us-ascii?Q?RnrDVZDOpm2BCmd++Ag+mdFs4s+UYy8DzAFVNSfwAu3tpmaQdTpue8+xq7C9?=
 =?us-ascii?Q?acq7KWawGLyJGKFICLlNQL4Eq2pafcGMRPHR58B62RIhVDQiOrkcF68ko4VS?=
 =?us-ascii?Q?rpBx6xkfUCF1V31G16KOLNiKaE09W4OLKbyLhBipZejOO8+p9d7eUjjheH93?=
 =?us-ascii?Q?7LWwDQWCFrGN3CBn+M1Nk+OmmktPYE0SFuWmvetwqwiCH7Vv3GiBH8evBHaf?=
 =?us-ascii?Q?QwJx0/bnhlRTM1fjFdSh6IMdpzlHxaZqcoBUOk60kGcRL5mFmrxC5C/yiCJU?=
 =?us-ascii?Q?RH5gvicy6Lbyd4ZpVEXsvC0PWaKgZgNoQjzlpkUTm4qGUe+rymA1A6OsfvfX?=
 =?us-ascii?Q?nMyJLMfXiqDjXuDspMiO4P2mtPKV0VwfYFXYnPHOjQXDWz3nHX6TuA9td92i?=
 =?us-ascii?Q?qRpUrQW5xnHf/sqFdkxyDnzjt/NaB/1Fl5jLrmG7sz91cT7iAh3rFWIskOlQ?=
 =?us-ascii?Q?JQ=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efd1d4a4-66d9-4f90-627f-08dbf7824f4c
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2023 00:12:05.3240
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p+aHLrGHdKXqRCL4AufnaHHvk+iXpIjGJaodIPDN7Mfdnv14Mrnepe0YnoXRC1aCwnUGuHwYgkpM1jMU1voi30GYtLH7m5z9F3mMIsCTys0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR17MB5843

On Thu, Dec 07, 2023 at 01:56:07PM -0800, Davidlohr Bueso wrote:
> On Wed, 06 Dec 2023, Gregory Price wrote:
> > +
> > +What:		/sys/kernel/mm/mempolicy/weighted_interleave/nodeN/
> > +Date:		December 2023
> > +Contact:	Linux memory management mailing list <linux-mm@kvack.org>
> > +Description:	Configuration interface for accesses initiated from nodeN
> > +
> > +		The directory to configure access initiator weights for nodeN.
> > +
> > +		Possible numa nodes which have not been marked as a CPU node
> > +		at boot will not have a nodeN directory made for them at boot.
> 
> This could be better rephrased without the negation. ie:
> 
> "Only numa nodes with CPUs (compute) will have a nodeN directory."
> 

I thought documentation was supposed to be as confusing as possible.

lol I'll update it.  reading it now, this is awful.

> > +		Hotplug for CPU nodes is not supported.
> 
> Can this even happen? Hot-adding a previously offlined CPU won't change/add a
> new numa node. So just rm the line altogether?
>

I... have no idea.  In that sense, aye aye!

> > +static ssize_t node_weight_show(struct kobject *kobj,
> > +				struct kobj_attribute *attr, char *buf)
> > +
> > +static ssize_t node_weight_store(struct kobject *kobj,
> > +				 struct kobj_attribute *attr,
> > +				 const char *buf, size_t count)
> 
> iw_table will need some (basic) form of serialization.
> 

originally the SKH group recommended a serialized "N*W,N*W,..." format,
but this doesn't work for a matrix.

Possibly i could add `N-M*W,...;N-M*W,...` and add a nodeN/weightlist
interface that lets you acquire the whole iw_table for one or more
nodes.  Might be a nice extension.

I figured there is an aversion to multi-value sysfs files, so I reverted
back to a one-file-one-value file.  If there is a preference for the
fully serialized methods, I'll happily add those.  Easy enough and I
already have the code to parse it.

~Gregory

