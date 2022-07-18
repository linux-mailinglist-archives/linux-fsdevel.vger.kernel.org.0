Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6F95578DC9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Jul 2022 00:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236167AbiGRW4a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Jul 2022 18:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235513AbiGRW42 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Jul 2022 18:56:28 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D33C32EEF;
        Mon, 18 Jul 2022 15:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658184987; x=1689720987;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=AwkwPQldquUPzSDxFclLs5qDGX60avTsY6bNpF8mwA4=;
  b=LZHUmeKbU6CPqi6EUJyuE1VaNRIXdwXRHVB47gL5V/TKlcOzdSX1of/3
   2FHuRgm0GFN+noFXKkEP43P646N368qfCpbKentMirj5N2hPTxopKOdAd
   0KRl6uyMIgFDJGi5NXexTMtzrK8JEGVVsYqvhojujydAUz24BV9OUwaxa
   0Oaw5PCfCsNTN+bBoOQ751dH3HkHR7BkzwKMa6w7mm/xajHOfxIXbjSmy
   GkYn1tn9FPiThCbGS0a9z+pfOGUz3JjeU0ZHTrK8h4R8kAgRZtq9LaAos
   0I2xdDQL3iKo/eddgmeoAeT86xJkB/F5y61Vv6qX+NbOZeRS7jWZXHNhC
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10412"; a="269363190"
X-IronPort-AV: E=Sophos;i="5.92,282,1650956400"; 
   d="scan'208";a="269363190"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2022 15:56:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,282,1650956400"; 
   d="scan'208";a="597427784"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by orsmga002.jf.intel.com with ESMTP; 18 Jul 2022 15:56:26 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 18 Jul 2022 15:56:26 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 18 Jul 2022 15:56:25 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Mon, 18 Jul 2022 15:56:25 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 18 Jul 2022 15:56:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CPbn60vqTnqmgkk4g0pObBz0M86fAgWUtTY+yjny7rUnSaePOz/1mf9lXIunJbm1Caze/JeA1IRTUve9e2doj0YyKol0kng9tXbEJb3NesjIo+BuKoS3ECkgsgVuXO55LqC14Cfj92ccXkKn+KR2cUgzn6VccvzgzAnIN+KwJ5+JbHbHuTGg3EslTCrtBLO0uTICIrpqLe982Rjrbj7GIYuVCHFB+r3b8GblswbpfyJIK28rtsa+I6wM2M7LOnTxSI3mrpdQKBTvabC/JatjKbKu/r3f6uNaHmTvxr+FkF55w6WZMGjuqqSoE34PGcnJsBD/cc++9cJpOm+4CObZ8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EIP3bxrUv1fQRGNTfetXQslHokHSpSXD+swDkuSxfU4=;
 b=M+BL86Q/cOHVFQc7/8RDKKqB9NuhDG/0vebP2oF6r6FdRghjyOMXc0bcejbmetLcoEn1ph85qzpCG6Tx/Rh78PP+Qrg5dJ7wCcF9rHm2kzxlFP7StpFZmEs348SH0ngnynGXM6hpfJiRz4okfp5F00FSMZEOgRWmXkDDCaZsZC8Usd/y7tkchl9UICOe6ixvR64kQnwkb7bHrHBnndutjNhDM3wdVVloUuSEmRgaiJeYjJrK9kww7gkqzYQ1LIFnXXwIT853LPJOwgNiqeksAJG/DyhKf72iLD4sAs8E1H3UpaG7Dm3WJdFwZvktzacTR+N2UOtIG1RxFCq4IkY99w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by CY4PR11MB1768.namprd11.prod.outlook.com
 (2603:10b6:903:11b::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.19; Mon, 18 Jul
 2022 22:56:23 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf%11]) with mapi id 15.20.5438.023; Mon, 18 Jul
 2022 22:56:23 +0000
Date:   Mon, 18 Jul 2022 15:56:21 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     "Darrick J. Wong" <djwong@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
CC:     "ruansy.fnst@fujitsu.com" <ruansy.fnst@fujitsu.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "jane.chu@oracle.com" <jane.chu@oracle.com>
Subject: Re: [RFC PATCH v6] mm, pmem, xfs: Introduce MF_MEM_REMOVE for unbind
Message-ID: <62d5e515de3a_929192941e@dwillia2-xfh.jf.intel.com.notmuch>
References: <20220410171623.3788004-1-ruansy.fnst@fujitsu.com>
 <20220714103421.1988696-1-ruansy.fnst@fujitsu.com>
 <62d05eb8e663c_1643dc294fa@dwillia2-xfh.jf.intel.com.notmuch>
 <YtXbD4e8mLHqWSwL@magnolia>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YtXbD4e8mLHqWSwL@magnolia>
X-ClientProxiedBy: BYAPR01CA0071.prod.exchangelabs.com (2603:10b6:a03:94::48)
 To MWHPR1101MB2126.namprd11.prod.outlook.com (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b30833be-9922-4b13-9cf6-08da6910bcbb
X-MS-TrafficTypeDiagnostic: CY4PR11MB1768:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TiBYhQxbeTzaqNreA+rdOM2GBXdn5c//VvkgUfYLw8gEWjTzjojIHKji0R/mSntxKPp+jKnbpf+xvfIjdvBphSE/1Ali+7JGaYa/gDS0yMZnua0UOC7omS7VlaQkYaaKkQ6GMBxHemPVPXkEBURGqyADU89qe8kw6l8M359d/lDetQe3aRdj+neXvtSfJ3JYPC5p7bPX3hDSm+L/h+OeRwT/6+XXQSQKd8tNmNwQuuO/cIBxJu1AItTAsBjnvvKsujID9rfgW+GYFwz8mAHvWPfTAHz7j+AEXrPf3vAroJtrULaDSgAMeJ+4URSKFxchK4nRN9fYRXnE8lElduI86l+QZ1Bvlmltd1RARHTpssxaNyY4nxgZGivv9dTAGkFgAp8DPYu12qclBric6ZGlimdvGgx+JdmKLU1c7htCekowMdW65F61P86x7/BYc4qTaUk9FkJZD9Yta1bzwCnpqc+Xqg4Wulv2v8+sPPX6j3z74TRYsf1t7/IbcSvpqd1j+1hPCqQCwRRiqnVRHiOiAhfGWfmfbEipIYF0A4inM/QC+md7TC+tSnJZbiaZQNG9PX+0K3BHSZL3ltxeIxaereZyahM7JVkRNb5rPjw0oXK0KzStifvXzBzZ3+c+nJJ1+yn4Acn6xIXGUabtrkvfpBRZe2gqrOZ4zuKh8P3akNYX64RMwM+5HGp7N1ffNveFNt/JqDEeOTPGawoAzP8Ti91bxZiTi+LLR+dpgFO11wi5GVEjAB6x2jjO7dP7eVlEWEGcwzAfjGNQJ9/38g/1K1GobiOs4Gt3Xp3R6uHQgQs4WGDok1kaq3p8+k6TN6wT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(346002)(136003)(39860400002)(396003)(366004)(8936002)(38100700002)(8676002)(66556008)(66946007)(4326008)(66476007)(6506007)(82960400001)(54906003)(110136005)(316002)(186003)(41300700001)(83380400001)(9686003)(26005)(2906002)(5660300002)(966005)(6486002)(86362001)(478600001)(7416002)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1j2bbgLAckfSVdVyJerHhmlDq3y7hxWddLxJ/FTSEwkBVk7MaK2mn+R49n0Q?=
 =?us-ascii?Q?MUkbSyZ1OqUCk/UebDUT9t6YVulr6DZcy9qrk9gOebBw1STTSAW3DLp1nVoL?=
 =?us-ascii?Q?inv32Ki2XfdPiTcGDEB3km66Yd9Mna74OawsXC9rgMvjjWbdN5KcWivmu1M/?=
 =?us-ascii?Q?Zw/1cpFGFl+rjW7pmfodHpkSoPqmUVbilp8lNmc2U2anVfbAOwEcxCHiSkk4?=
 =?us-ascii?Q?evwFCjPyd7bEoV2Vn/Ro7uT8ZOScdms1v8hAFGPMrs9PW+qbfKefdAdcs2wK?=
 =?us-ascii?Q?32N8ZshMznGiv5BIn8u2iLRliVVdWpnVvSQ//ISYjoSzkYGYWFG2poEkQN2j?=
 =?us-ascii?Q?nLqOo+ES4iqz5xunWKV5biooVtKB0SV7/ctSQc7kLOCGj7i1grFnwzrbMHgh?=
 =?us-ascii?Q?tRiZq4aVe6rYHkf1+Rb2F+IODMGuYp/7f9umEXKELQx8hG4lPWP1HIADhHuO?=
 =?us-ascii?Q?GQH+30aEUwYMnfxo1KcgPiIce6i3XUqrdijHam40U2IOLXt9pSQGNOq2VG0D?=
 =?us-ascii?Q?hicT0Gk+pgEhxFYRpSomX+v+M+uuX5GhTeGqzfpJcAjzrag/NecynCv8vjFO?=
 =?us-ascii?Q?nU/um3C1en4ljUtOUdfGd+gDOg3L7k8lVQYWZbQzrsAg9OiaEiXXFae/2gpC?=
 =?us-ascii?Q?R7gQ+GvbjRaM60i8jGXHcqLtFWEi5/7WO49fmIqrtYAxGAx1hCYDve14j5cE?=
 =?us-ascii?Q?e3POHhtviym5G+9abvS9DK+QOxTwRtiNgd6TrKRZmNtYkGKMWsMjMbX79aOv?=
 =?us-ascii?Q?kVL0OkeNEFZSi20GRvQdg96nVyTacYoY/Wnn75Ka4f4qEcdSCjC2Rmw6WYpD?=
 =?us-ascii?Q?Rk/icqCQWGOHUuKT/hQzndbh//4Cn8TdfejImJ688naSvRobxLKoFb+1y289?=
 =?us-ascii?Q?X3Z3JO/frkrLaVy0zsnw+c6qwDd8+ccMc5t/dY/3EP0BXWLLL84CZn1FZckz?=
 =?us-ascii?Q?35TeIEdFaD5f+vGodpaj9AJTR0NRuqT2HfKWEkuZdC2Hj1UyC5iHDPG2rzVE?=
 =?us-ascii?Q?8AtnGZwQr2Cc2EDRHLp6XXTIPh3UOihAgT7u0TWVjd+I13BmUbjdz15lRfar?=
 =?us-ascii?Q?Y64ft3zbLwu4QHfkjamcF2do1LRa8I4LEEjXOwlt/SMNlbvwkVt4EfXfSEgp?=
 =?us-ascii?Q?jfMzpXQ5RirHlbRxF1aZSivubz+xnC1ghqW/umlzIhLIaNlqH0fFXnd2Y2TI?=
 =?us-ascii?Q?Ix70zh2i2goTREJVaFsPuGoWQgC+LGwUyG2JNiYIK9q+iq1h/LBoZFNm7nx5?=
 =?us-ascii?Q?K6nuNeQ1W0ZS8Sfjkvs1pGPZVLKHGBRdW80JnR7E7mzVhgPeVk++PaJTyQ7x?=
 =?us-ascii?Q?h37VwF8J95LpUZMobXOuUnjMJqgEMBvlviBqX2tDeUqengJ5rxO9WUrrA5Sz?=
 =?us-ascii?Q?GdXaSIOrshupRwZtp82b+ica6MsKmPHGEP1kfiEUAFd1Nt2arm922f4WLJzV?=
 =?us-ascii?Q?mfXRCD/5Nzi6HTAtVjWSLWX8C1yiJT0c+VJeHt7CQSBFNdn+mecb3XmG1MYp?=
 =?us-ascii?Q?amDj0LFvJROKn572RXaMZlfHTn3SSHqJYpn2vRO6rmXM/aEuVJhVo9TSweg7?=
 =?us-ascii?Q?PsjVrv1EXMH1FWEkw7HDati/wRWW0ppTpDoBvZNdsEPoHvpwrYd+82ppkjF/?=
 =?us-ascii?Q?xw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b30833be-9922-4b13-9cf6-08da6910bcbb
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2022 22:56:23.4870
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hak7VjNaAZc869DeUuMpYaXsKgC54UnhUpnu5BYYdx3KAqLgoNDZCXMTaS/BN7jj99FlD8gIJpiUtGp8wakEFY1DiW+gQGNGSjslW8ZJbj4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1768
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Darrick J. Wong wrote:
> On Thu, Jul 14, 2022 at 11:21:44AM -0700, Dan Williams wrote:
> > ruansy.fnst@fujitsu.com wrote:
> > > This patch is inspired by Dan's "mm, dax, pmem: Introduce
> > > dev_pagemap_failure()"[1].  With the help of dax_holder and
> > > ->notify_failure() mechanism, the pmem driver is able to ask filesystem
> > > (or mapped device) on it to unmap all files in use and notify processes
> > > who are using those files.
> > > 
> > > Call trace:
> > > trigger unbind
> > >  -> unbind_store()
> > >   -> ... (skip)
> > >    -> devres_release_all()   # was pmem driver ->remove() in v1
> > >     -> kill_dax()
> > >      -> dax_holder_notify_failure(dax_dev, 0, U64_MAX, MF_MEM_PRE_REMOVE)
> > >       -> xfs_dax_notify_failure()
> > > 
> > > Introduce MF_MEM_PRE_REMOVE to let filesystem know this is a remove
> > > event.  So do not shutdown filesystem directly if something not
> > > supported, or if failure range includes metadata area.  Make sure all
> > > files and processes are handled correctly.
> > > 
> > > ==
> > > Changes since v5:
> > >   1. Renamed MF_MEM_REMOVE to MF_MEM_PRE_REMOVE
> > >   2. hold s_umount before sync_filesystem()
> > >   3. move sync_filesystem() after SB_BORN check
> > >   4. Rebased on next-20220714
> > > 
> > > Changes since v4:
> > >   1. sync_filesystem() at the beginning when MF_MEM_REMOVE
> > >   2. Rebased on next-20220706
> > > 
> > > [1]: https://lore.kernel.org/linux-mm/161604050314.1463742.14151665140035795571.stgit@dwillia2-desk3.amr.corp.intel.com/
> > > 
> > > Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> > > ---
> > >  drivers/dax/super.c         |  3 ++-
> > >  fs/xfs/xfs_notify_failure.c | 15 +++++++++++++++
> > >  include/linux/mm.h          |  1 +
> > >  3 files changed, 18 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/dax/super.c b/drivers/dax/super.c
> > > index 9b5e2a5eb0ae..cf9a64563fbe 100644
> > > --- a/drivers/dax/super.c
> > > +++ b/drivers/dax/super.c
> > > @@ -323,7 +323,8 @@ void kill_dax(struct dax_device *dax_dev)
> > >  		return;
> > >  
> > >  	if (dax_dev->holder_data != NULL)
> > > -		dax_holder_notify_failure(dax_dev, 0, U64_MAX, 0);
> > > +		dax_holder_notify_failure(dax_dev, 0, U64_MAX,
> > > +				MF_MEM_PRE_REMOVE);
> > >  
> > >  	clear_bit(DAXDEV_ALIVE, &dax_dev->flags);
> > >  	synchronize_srcu(&dax_srcu);
> > > diff --git a/fs/xfs/xfs_notify_failure.c b/fs/xfs/xfs_notify_failure.c
> > > index 69d9c83ea4b2..6da6747435eb 100644
> > > --- a/fs/xfs/xfs_notify_failure.c
> > > +++ b/fs/xfs/xfs_notify_failure.c
> > > @@ -76,6 +76,9 @@ xfs_dax_failure_fn(
> > >  
> > >  	if (XFS_RMAP_NON_INODE_OWNER(rec->rm_owner) ||
> > >  	    (rec->rm_flags & (XFS_RMAP_ATTR_FORK | XFS_RMAP_BMBT_BLOCK))) {
> > > +		/* Do not shutdown so early when device is to be removed */
> > > +		if (notify->mf_flags & MF_MEM_PRE_REMOVE)
> > > +			return 0;
> > >  		xfs_force_shutdown(mp, SHUTDOWN_CORRUPT_ONDISK);
> > >  		return -EFSCORRUPTED;
> > >  	}
> > > @@ -174,12 +177,22 @@ xfs_dax_notify_failure(
> > >  	struct xfs_mount	*mp = dax_holder(dax_dev);
> > >  	u64			ddev_start;
> > >  	u64			ddev_end;
> > > +	int			error;
> > >  
> > >  	if (!(mp->m_sb.sb_flags & SB_BORN)) {
> > >  		xfs_warn(mp, "filesystem is not ready for notify_failure()!");
> > >  		return -EIO;
> > >  	}
> > >  
> > > +	if (mf_flags & MF_MEM_PRE_REMOVE) {
> > > +		xfs_info(mp, "device is about to be removed!");
> > > +		down_write(&mp->m_super->s_umount);
> > > +		error = sync_filesystem(mp->m_super);
> > > +		up_write(&mp->m_super->s_umount);
> > 
> > Are all mappings invalidated after this point?
> 
> No; all this step does is pushes dirty filesystem [meta]data to pmem
> before we lose DAXDEV_ALIVE...
> 
> > The goal of the removal notification is to invalidate all DAX mappings
> > that are no pointing to pfns that do not exist anymore, so just syncing
> > does not seem like enough, and the shutdown is skipped above. What am I
> > missing?
> 
> ...however, the shutdown above only applies to filesystem metadata.  In
> effect, we avoid the fs shutdown in MF_MEM_PRE_REMOVE mode, which
> enables the mf_dax_kill_procs calls to proceed against mapped file data.
> I have a nagging suspicion that in non-PREREMOVE mode, we can end up
> shutting down the filesytem on an xattr block and the 'return
> -EFSCORRUPTED' actually prevents us from reaching all the remaining file
> data mappings.
> 
> IOWs, I think that clause above really ought to have returned zero so
> that we keep the filesystem up while we're tearing down mappings, and
> only call xfs_force_shutdown() after we've had a chance to let
> xfs_dax_notify_ddev_failure() tear down all the mappings.
> 
> I missed that subtlety in the initial ~30 rounds of review, but I figure
> at this point let's just land it in 5.20 and clean up that quirk for
> -rc1.

Sure, this is a good baseline to incrementally improve.

> 
> > Notice that kill_dev_dax() does unmap_mapping_range() after invalidating
> > the dax device and that ensures that all existing mappings are gone and
> > cannot be re-established. As far as I can see a process with an existing
> > dax mapping will still be able to use it after this runs, no?
> 
> I'm not sure where in akpm's tree I find kill_dev_dax()?  I'm cribbing
> off of:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/tree/fs/xfs/xfs_notify_failure.c?h=mm-stable

https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/tree/drivers/dax/bus.c?h=mm-stable#n381

Where the observation is that when device-dax is told that the device is
going away it invalidates all the active mappings to that single
character-device-inode. The hope being that in the fsdax case all the
dax-mapped filesystem inodes would experience the same irreversible
invalidation as the device is exiting.
