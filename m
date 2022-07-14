Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA5665754D6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Jul 2022 20:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240598AbiGNSWF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Jul 2022 14:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240623AbiGNSVx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Jul 2022 14:21:53 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB6CA691D2;
        Thu, 14 Jul 2022 11:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657822913; x=1689358913;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=6vDKSPSBtwB+0kL7ja4/WtKq73QvcoQST4NE/aGzpTw=;
  b=eAjXufDp3VYtKjq58+usZrX+MXl1o9Ijrbihv7UCNmUSzu/uA9p3wzCp
   ISSE8AwIDf8IWl9Piftu/2E394FJ3kZ+fA1Z31D6eWdechhRJ4mEVSVyu
   fZr4FjxkP3S9XnxgQIyPHaKfCMwhhMGhTADHWO+vAklZPfMMuZyxz9kxU
   nzVZ6ke4rzFGoaaN1Zr2yidN2LSCQdtTHDFJR5/RUONSXr0udZVNjC1Eq
   NBHAm5DLveAQ83mwXG+EAeGoU8PVSp/qU4eLvx3kX43o/uxP8Zsw47Yxk
   MsFkCcguEZzECzpBrrUeWJUBYcHGNoqJTY0Cz3QGc+mveJRbOFRDlLQum
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10408"; a="347277154"
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="347277154"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 11:21:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="653989487"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by fmsmga008.fm.intel.com with ESMTP; 14 Jul 2022 11:21:51 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 14 Jul 2022 11:21:51 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 14 Jul 2022 11:21:50 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 14 Jul 2022 11:21:50 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.47) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 14 Jul 2022 11:21:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K3+IagfPwxIjSVBLNlTJWkZ27HEdB6KBioBi4C0T+Fg1s8LcJxNlEEHI+GtXWNbGHSV12VkzCDiK9X7EfQATelDm/iR2gSQrTUlJd5Pt48bCXCPrzitk1dCpVrf9KXVhZ+NCU1DuIkH2MloGYeiz2ZW8VwCn51pa+Wg0u829qC/asIE7v28EdnWcWztTNvSv7vfRDGzyQwqQb7CGKgY13QrYJQJl8Iz8p7hF7Raac+Cn7CWN3HTcUbOL86WBShDvvsOoBRKN9UZ2Cmk1v2Wt7MgfcW41l8uVOKaqyv36ltlSEHFXcrfiHkxVtp9L/sJ5AARLazcSn3subducC8v+YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=clGwws9tiUG1V06uohL0+U5pwhO6+axGCcvIBSbCVcU=;
 b=Uh1upwS8PLaywevKBs8q8J4mgnWvZgfzmzSjcKA7CUBKC+3JDTfsve3LvwJF+uSsMOWW6SKNucQoXXqxnmCB1pFnLdsyfvZT9ql22xI15ila5ESVSqBKQ1M7pgFayFJKn0xZF/I73b/D2XD9+gWUyYX0wa54qcWW+YGHSf6Z3fRE7xBRYzZ2KIfTVcoe8nnGp4oeifmeGbg9/rZcpDwnwlOp4lRzvGd0kC0xxbydUnIPDyg1uQIXI8iK2Q8B2hJhGkJgtihfLRoVYehautMJoQjv7TUey8J34oATLxil54Y2C+NdvcPzmBaoIUtp27gotYE1vsbkNc3IyugzyOP/ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by IA1PR11MB6169.namprd11.prod.outlook.com
 (2603:10b6:208:3eb::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Thu, 14 Jul
 2022 18:21:47 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf%11]) with mapi id 15.20.5438.014; Thu, 14 Jul
 2022 18:21:47 +0000
Date:   Thu, 14 Jul 2022 11:21:44 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     "ruansy.fnst@fujitsu.com" <ruansy.fnst@fujitsu.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
CC:     "djwong@kernel.org" <djwong@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "jane.chu@oracle.com" <jane.chu@oracle.com>
Subject: RE: [RFC PATCH v6] mm, pmem, xfs: Introduce MF_MEM_REMOVE for unbind
Message-ID: <62d05eb8e663c_1643dc294fa@dwillia2-xfh.jf.intel.com.notmuch>
References: <20220410171623.3788004-1-ruansy.fnst@fujitsu.com>
 <20220714103421.1988696-1-ruansy.fnst@fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220714103421.1988696-1-ruansy.fnst@fujitsu.com>
X-ClientProxiedBy: BY5PR17CA0040.namprd17.prod.outlook.com
 (2603:10b6:a03:167::17) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d592c3fe-6727-4e02-ec94-08da65c5b67c
X-MS-TrafficTypeDiagnostic: IA1PR11MB6169:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V63goFcl5uJ4etIiNfaUu3gkBWGcQd3Ogble5fCW18QOgQm85oNswqxtN7uY6T1TCxWIwXkBt5hYPk1xroBfBh2lHvv0qz5VHMPdtzyIIPL1+4MtYnywIcUhk9TMH6hx/8IpQhq2mSSaVoegfLAHXwnPJwydYeL+g+KImwUzOhJPxL5inWgPuddnL7qpQyTSkdRWi12TNRYK5BPkhF2oj6A+XsHN05C5aX/f1/rj6tOOHeBcS17qgZZCxWt76BLdXWrnexKKwl7u/e3TKYMlpndu/Z1NBgN02436cxcm8HP09jbkRb3UryTf0kdcx+wEMEdm0c/83cppUpet4sM2XzWB90sK/zNkhdpYTqUcppzIoz17Deugs5mkHrx9ocLixPhcnQS35t+u1GFfpU9YoLBvW8zcZQekH6xr/v0t603HNs6ZVxmOEfMZCJiiss9N/jNesxn10LiqCZZH21EGDMa4mphJff0FB+qVz7V4ioOVtA6A1MzlFBdHvVQ0NxZtu3LANkTlXkazJWwxzMF6rQDTTkpkYOpqwc5T8Z+siPRCzJguQUP/yWIQenOAsZtVuPA9frD+XEYvMKxSKAuxVAVFkn6N7qGWURlnUa1CsYMqMt0+jpTZvoGE3OR5b87P2Q01U+Sa7FoSGVnJznZzcOReQ7nx64qBsJmwWfcwKzeHxZXgS3ik/kizlB9811pDWD7nStGhPCGJrEuS9EJsL8a2NCXPd0ESFHnQbHGFBZl6tcsqn+jIC26c54rtwAeCzyn5T1pJ/c4zzgkwZIlvHeb/lfqHmojqdRlgdBPjiy0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(366004)(39860400002)(396003)(376002)(346002)(8936002)(5660300002)(7416002)(8676002)(4326008)(2906002)(83380400001)(86362001)(38100700002)(82960400001)(966005)(6486002)(478600001)(66946007)(110136005)(54906003)(66476007)(316002)(186003)(66556008)(6506007)(6666004)(41300700001)(6512007)(9686003)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?v7Z77dRSvLV9xguhdNVMaIsm25FHaliYApNlM7xE58VUFoO2f4eIOZrhIvUI?=
 =?us-ascii?Q?MWo8Q/rZcSOu8RmJJ1o3ul1X16ebHOjXxXChnOA82szoNLB12aoiahjwifnW?=
 =?us-ascii?Q?RDgMXSlp5zAOKHd26lXnZAj9luMqPmPDsGKzPgLUaHYNFA9useaFMS2ad0PZ?=
 =?us-ascii?Q?mWmB6YLFUSZIqkDNTF+6cnGF3bWmv0vTLWEuq30s5q3Q8S6hjKZH/Y/q4d2o?=
 =?us-ascii?Q?nNTkn0qSWQ9duCUGrRcDQca3FQjbpf27eBicJk/C6cnquwDo14BPDzDXOKDl?=
 =?us-ascii?Q?U8/UWI7MRS2SJ+ggZeuNHt2N61Z3DpkW7xo2ae5AAqdhtm+7GvHPa42M2vWm?=
 =?us-ascii?Q?dM3VtKbUkiyNUvJABsRCG1iir3F1mf4dVZYJFko25/TRsYI3n4I6qf/P16eQ?=
 =?us-ascii?Q?mXJUarD4wXBS+qzfJKkr8B967j0Gb1pz8mIJWXkkbHYfepPBsOI88wFkhnu6?=
 =?us-ascii?Q?ON8lANOSnsQ7+TGSAXkfTTL9NWPvQYu4c2bjLQmsxZR1IL5qoud+yPRjxWGq?=
 =?us-ascii?Q?kskz75IwpG8b7SkzQGoppB9E0J/jKG05Mk+3Lw07rVVOwJMebHou3Iqftroz?=
 =?us-ascii?Q?3NChVVZso5VpsFLYStVseSqvos4mVmKaWQ0u7UtH52UJmWB8rkYzfxBMr0hM?=
 =?us-ascii?Q?2pFDU/5R5WaGubvojdBvoJvH02AyIZkqAypfbk5Y/M2Pyaw5d1yDkaCxywEG?=
 =?us-ascii?Q?0lIHs9EYDwzWx9MmV6CaKaEbA0UUV/Ta5FB6Cqnv+jIl96kxDGWDM0VTND6V?=
 =?us-ascii?Q?/fZ2cA6ClbthfSM1FcAKbrQTmMGQ74HmyY9fMixUL4VXsRpSqTPMjl0jWP5J?=
 =?us-ascii?Q?l1qOJCMX9aPaVOHdz007TDR09LMXP/OlYqTBfRdHViOr54uedx7ypW/G/9Xr?=
 =?us-ascii?Q?mqURn8X7IICGvIrz0mY7GA8csYQuR24QtGa/AtS7lYVlNFbsR/S23MJYA/cL?=
 =?us-ascii?Q?y3g/N7Q3wpLq7LNoupXLJbKrWG2Dbg20kdPJRyi1gXbEjUtPpjCn9AEdwEKZ?=
 =?us-ascii?Q?dn7cK1Da/bKZ4UcMPQ7u/enxFj9cQeboxDcEHvgvFcKyczE8CQj0yodRxaIR?=
 =?us-ascii?Q?tpTKWMT1gXYI2GDsdgGal7Ugwd8gotZnpudYOiPzYmG781d+yTO7EGKO3nNo?=
 =?us-ascii?Q?q2SP72030yhQsu29xRVPbiwmDwCHLziCoYfmujGKN7Kl34umBKc/Z5T3fA3z?=
 =?us-ascii?Q?PC8Exy7H39jV3HfOTa+1548QhGYauaOgoTcTBpLnWH5yEBc2fU3cpfh6SA/K?=
 =?us-ascii?Q?RAqL76JJcbLvDbUAgSbIdFvYzokl2MfNw9SVmP9gMN0ZfNvm9D9Eqrk+VTmz?=
 =?us-ascii?Q?gFV1jFyqVbPeyDhWo8DVxVARwWui7UOO911uS0eQR1apGbyzMBSXm1WPWgXZ?=
 =?us-ascii?Q?lljg7VVuC1zymMkOxDR6RNAUKIJv5WSWEMc5lZwcE2moCwOxLUDuh4B7nueR?=
 =?us-ascii?Q?sS2A1sdkqQCXeFTbG/rURkaaaKVvNZe8XWDCUJ8aEHteieWvTDuSJdzB/N94?=
 =?us-ascii?Q?9IcT3mudvU/T7M7TU+Dczh7xrqvgoNI0dN1ScmHbFRNuzJbty76NCvzQQ2WX?=
 =?us-ascii?Q?9YjPuTacslr8057Om2rHl2W3dAykzkIsP+0sTK96cF8GNOzzCJQ++vzpeabX?=
 =?us-ascii?Q?bQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d592c3fe-6727-4e02-ec94-08da65c5b67c
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2022 18:21:47.2355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oIlp0v8zRAqhheKRsqvgNlefPQIMH8s6FCxCVdD06hOznqnMUU8RCVuf8bfthxYRjtahQhiXKgfG7+AczmB4rgcw2lBW7cZf0dfr5zZitjo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6169
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

ruansy.fnst@fujitsu.com wrote:
> This patch is inspired by Dan's "mm, dax, pmem: Introduce
> dev_pagemap_failure()"[1].  With the help of dax_holder and
> ->notify_failure() mechanism, the pmem driver is able to ask filesystem
> (or mapped device) on it to unmap all files in use and notify processes
> who are using those files.
> 
> Call trace:
> trigger unbind
>  -> unbind_store()
>   -> ... (skip)
>    -> devres_release_all()   # was pmem driver ->remove() in v1
>     -> kill_dax()
>      -> dax_holder_notify_failure(dax_dev, 0, U64_MAX, MF_MEM_PRE_REMOVE)
>       -> xfs_dax_notify_failure()
> 
> Introduce MF_MEM_PRE_REMOVE to let filesystem know this is a remove
> event.  So do not shutdown filesystem directly if something not
> supported, or if failure range includes metadata area.  Make sure all
> files and processes are handled correctly.
> 
> ==
> Changes since v5:
>   1. Renamed MF_MEM_REMOVE to MF_MEM_PRE_REMOVE
>   2. hold s_umount before sync_filesystem()
>   3. move sync_filesystem() after SB_BORN check
>   4. Rebased on next-20220714
> 
> Changes since v4:
>   1. sync_filesystem() at the beginning when MF_MEM_REMOVE
>   2. Rebased on next-20220706
> 
> [1]: https://lore.kernel.org/linux-mm/161604050314.1463742.14151665140035795571.stgit@dwillia2-desk3.amr.corp.intel.com/
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> ---
>  drivers/dax/super.c         |  3 ++-
>  fs/xfs/xfs_notify_failure.c | 15 +++++++++++++++
>  include/linux/mm.h          |  1 +
>  3 files changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dax/super.c b/drivers/dax/super.c
> index 9b5e2a5eb0ae..cf9a64563fbe 100644
> --- a/drivers/dax/super.c
> +++ b/drivers/dax/super.c
> @@ -323,7 +323,8 @@ void kill_dax(struct dax_device *dax_dev)
>  		return;
>  
>  	if (dax_dev->holder_data != NULL)
> -		dax_holder_notify_failure(dax_dev, 0, U64_MAX, 0);
> +		dax_holder_notify_failure(dax_dev, 0, U64_MAX,
> +				MF_MEM_PRE_REMOVE);
>  
>  	clear_bit(DAXDEV_ALIVE, &dax_dev->flags);
>  	synchronize_srcu(&dax_srcu);
> diff --git a/fs/xfs/xfs_notify_failure.c b/fs/xfs/xfs_notify_failure.c
> index 69d9c83ea4b2..6da6747435eb 100644
> --- a/fs/xfs/xfs_notify_failure.c
> +++ b/fs/xfs/xfs_notify_failure.c
> @@ -76,6 +76,9 @@ xfs_dax_failure_fn(
>  
>  	if (XFS_RMAP_NON_INODE_OWNER(rec->rm_owner) ||
>  	    (rec->rm_flags & (XFS_RMAP_ATTR_FORK | XFS_RMAP_BMBT_BLOCK))) {
> +		/* Do not shutdown so early when device is to be removed */
> +		if (notify->mf_flags & MF_MEM_PRE_REMOVE)
> +			return 0;
>  		xfs_force_shutdown(mp, SHUTDOWN_CORRUPT_ONDISK);
>  		return -EFSCORRUPTED;
>  	}
> @@ -174,12 +177,22 @@ xfs_dax_notify_failure(
>  	struct xfs_mount	*mp = dax_holder(dax_dev);
>  	u64			ddev_start;
>  	u64			ddev_end;
> +	int			error;
>  
>  	if (!(mp->m_sb.sb_flags & SB_BORN)) {
>  		xfs_warn(mp, "filesystem is not ready for notify_failure()!");
>  		return -EIO;
>  	}
>  
> +	if (mf_flags & MF_MEM_PRE_REMOVE) {
> +		xfs_info(mp, "device is about to be removed!");
> +		down_write(&mp->m_super->s_umount);
> +		error = sync_filesystem(mp->m_super);
> +		up_write(&mp->m_super->s_umount);

Are all mappings invalidated after this point?

The goal of the removal notification is to invalidate all DAX mappings
that are no pointing to pfns that do not exist anymore, so just syncing
does not seem like enough, and the shutdown is skipped above. What am I
missing?

Notice that kill_dev_dax() does unmap_mapping_range() after invalidating
the dax device and that ensures that all existing mappings are gone and
cannot be re-established. As far as I can see a process with an existing
dax mapping will still be able to use it after this runs, no?
