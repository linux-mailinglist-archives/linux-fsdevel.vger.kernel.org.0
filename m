Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB95A7AFE0E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Sep 2023 10:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbjI0ITG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Sep 2023 04:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbjI0ITB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Sep 2023 04:19:01 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12FE6B3;
        Wed, 27 Sep 2023 01:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695802738; x=1727338738;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=BhJuXf+HfZdrA91V6qpDJV0svqzrWtPlNIa4QWBk6D0=;
  b=OX28zieA2KkiRKc1PAVmqwiI9Ousd/hiJhwWoNlm3s5Eq62lJ2V54Km5
   4yI+4DGqAPo2zPzQwacdQM0MEiYvLfTqqe2Imzb1xLo2xfW5NOMcm1wDE
   vQ7YEwMmv6rMVSyL6Wt+Z9Rj6/ifcHX6VBArHTmPa9SL+E5dVylFORsmW
   950UYPMsnUltSr6zq+QY9tSeCvSWvUjLiFWYKmZp11AVLBA2F+LYZnTKn
   8lr/baFC+HEnFqA5T06jyrfISO/whz5uxtZEs2nu9mcQDxRBE5x6gG5Pr
   n0mhGz6LkLJE7I1jtvNyRll1khiCE3hbRoIJFQg9J4GWsuJo2G5OdHTbu
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="445894424"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="445894424"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 01:17:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="922692328"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="922692328"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Sep 2023 01:17:46 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 27 Sep 2023 01:17:46 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 27 Sep 2023 01:17:46 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 27 Sep 2023 01:17:46 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.43) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 27 Sep 2023 01:17:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ThFRtwxZps1fTq6DpPIekHusg6n1PTxizBIoKf6rZb5Dr664qvhVwbj1k3Ugotw2slQXGcVvMaH19LxZwCxg/Nkj1ifvGkKuDu6O5GEd64Q76CAHEESh20OjvKYQEDAzO9w+G/LLOpDEldylidb/cclWaCor6FGg1FazFaKvJlvqthdj1j5Dw0Mn3e5V0CzYOBEnBtssUwGu/vbfLSQp0aBZnls5F42pAnC22WRJf6suo3R8WjDpreqGAYxMwDtfqLXQQER0TxOydJq/Mf6tqPlMOe0RKturmyCVa83ScAWusw+Y+YFc4wm2vos5xYW0W7K94WIbnFwSX5xCtlBimg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wTe78kfc4SEV/7rQyb1fDwnsJ9wxa/m/jgdXPpMueWk=;
 b=KgDqX9jZxoKd96CoEi85XyDzCch/Ji2WWb2iGcfZAVo/kdX01+90jn6+extkmv8xbzaMnNYinKVID6YjqddJlTPGqKWG/M3po/v+Pw/3HzptW23OyLpsg9RHd+FgjyRcwRboJIIRlh4UaXOKqFJbSLRQjfbn9/oygXlPie4QJ68gcr+Pyuo4WhuatsHzEdmZYxOe2gaU5yTKP+K0WIxfokhpq/yQYS9dnHzREhajPJW2VBjfi/fzUKbMSnDkdPoYY0D+2XIkApGcaB1sCmjFnloX7rBxeObGFWMxAUVgSIfnhFe1YhqtULIVvUEi/0E8x1tfw4n8w5QkL2JOOCsL/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA1PR11MB8197.namprd11.prod.outlook.com (2603:10b6:208:446::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.31; Wed, 27 Sep
 2023 08:17:38 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992%5]) with mapi id 15.20.6792.026; Wed, 27 Sep 2023
 08:17:38 +0000
Date:   Wed, 27 Sep 2023 01:17:35 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        <linux-fsdevel@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <linux-xfs@vger.kernel.org>, <linux-mm@kvack.org>
CC:     <dan.j.williams@intel.com>, <willy@infradead.org>, <jack@suse.cz>,
        <akpm@linux-foundation.org>, <djwong@kernel.org>,
        <mcgrof@kernel.org>
Subject: RE: [PATCH v14] mm, pmem, xfs: Introduce MF_MEM_PRE_REMOVE for unbind
Message-ID: <6513e51eecf18_91c1e294f5@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230629081651.253626-3-ruansy.fnst@fujitsu.com>
 <20230828065744.1446462-1-ruansy.fnst@fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230828065744.1446462-1-ruansy.fnst@fujitsu.com>
X-ClientProxiedBy: MW4PR04CA0217.namprd04.prod.outlook.com
 (2603:10b6:303:87::12) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA1PR11MB8197:EE_
X-MS-Office365-Filtering-Correlation-Id: be345f9c-6b8c-4f7d-0089-08dbbf323639
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X1r6N2M1T29hcq9aJEfz0kUM4fZWThnLZa1UhPPeEYUzqWktPG47LpJGQW57PZUBJxicVV960OglkZ7mM6JWS85bl+e7Z0H8xMexuaSa2CwTDaqPWz1O6TSLSFZrjIBDh7IW9Td2AxV4xB1z5P6DDbGLHHO3pxUQI5/RgNjSppyNKFXDl5YC+sL+/XgMuJ13aB1YWa6sPhXhxYRW+Ykg9GDXKwaU+jU3t3nk5QSbM9QJMYNO4iVi2EUT8UAT5+B19kV0HQB7FCfJj/IBApxYNuv+66bS0adMRfmIyDwsOQfjovsVk3r2lSrx5OAJXeHwTUZk7B4eWrdNGHOk/8jFeKU3Q2rMauWxktCeGzWXflkixvN4jza7hYWh8li4okAdnNRmx8bzkAuoCdFG+aqiqHN8GWYcBD1nTP6aKHOmbD8l4cmn8oEYtbMQMYi3VYGHfR6PhGCwYtlKKdjjWZJnpRvvcgC9/UQ/9VHbxXWod1TAMkADExOQ7ALps3hbmYwr0hccbWnpwYKUigsr+xzMZz126XIm6CA4EvwoL9O0MMh1RKRXmP+xcGzDVtTdl6BYycRvKP+kj9ETWGJflSofN8l3440D2uhQJoEbCtgCOX2ykQMfF+QM90RonsvrbYrpntRaBz7puM/JYqVfALKRxg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(136003)(396003)(366004)(230922051799003)(186009)(1800799009)(451199024)(6666004)(66556008)(6486002)(6506007)(66476007)(66946007)(478600001)(966005)(8936002)(6512007)(8676002)(41300700001)(9686003)(5660300002)(4326008)(26005)(2906002)(83380400001)(316002)(7416002)(30864003)(86362001)(82960400001)(38100700002)(18704003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?I2MUHLb7h6V4TZ/pepmXBBiSA2MweXfC/m/UIV0YE9U/qlOpvzc7yzvFU83D?=
 =?us-ascii?Q?QWVhfH+zFx9Y31NQBF/L74Y3HdjKuY3cqSkLRV4AsFYp2SDFzqDU48tm+i1N?=
 =?us-ascii?Q?6jF9Vj4OJ5LjlEAB7VZQr5orbSCsXulMGQScI0jJY/S6dCJYhfseMhKLgf9k?=
 =?us-ascii?Q?MGwDI5vxxn4RkeXLCXVoynUQTICFANNozrs4dtaoydJg/lKqFUSPzOEYMV3x?=
 =?us-ascii?Q?5w0e5l4C5NyTRhdSMEF/RongNvgUgDXuqwWQf7K58h5UD9Sfpk++foXjBFbZ?=
 =?us-ascii?Q?7w6eqFqqZc2eG5OhA2pC6qx9hSpZA6gGI7xaoNq+uo1t4BB+knZEM1L5UGLQ?=
 =?us-ascii?Q?kP4gEnnnppShaFw/c75yLBX4NHmdX8w/eN8hFQh1suzaRHfwlOgwPJKPhtBy?=
 =?us-ascii?Q?JumPmRJhiDqiG1QKlovc4IrXEhWOA6MjaxcaAppMUHrBbcyrvgNjWYIoZxDj?=
 =?us-ascii?Q?IC5DSVh1hJaNmcKOCn93UNKNYGOtFpOWM5hmalqkTFrSeMZKOHaEnvHylvCj?=
 =?us-ascii?Q?s+Itv2kCMRFaMiIgrD+5caF8vXpI1gWAK23BbThGzuiQqfqq+esuBWvOQftp?=
 =?us-ascii?Q?j2/1o603/TMNLMcLwH3PM1SDNzsPGSh9BV4h2kDLTVhAK+WL8xzH1opN5Pou?=
 =?us-ascii?Q?e7gjsb+b/t/s+ARX9NM+/I3V9yZoFVaSdxsunZgFDcPW+ZValoqROz1cMeua?=
 =?us-ascii?Q?AOVRzhm1kAPYPQqYvKCqMw5z029SDHdB6OFkcTazvWpnn/Jq5d7TqJ9yntno?=
 =?us-ascii?Q?zEGhC/6UE6AkTiPbMNTigqNOKzMZ2m1+izrJiaMov2hzfeZJ3jHEVpcdkHpk?=
 =?us-ascii?Q?YGxw50yFgPgXYtl04g/G6r8hohhOP4WiEDL33au/UIHX4UahJMjv2LHxImD0?=
 =?us-ascii?Q?SqF/lwMNP7r81bCFZ9Bl8WeA+KTi2KO4Iagv4kYlB3r/HSc0nIzEsgbdclvI?=
 =?us-ascii?Q?0FuXQCEkiXSaH7350kKFKp09PcQaeiGfj9bCFCgfOpZixCxlg8tXzpV7Tj0I?=
 =?us-ascii?Q?l/qb6mfQhEbIPQGQaUaDnxlgpAed68ELnTARDKDxiHqkq8ADr+3QYDJSI/7T?=
 =?us-ascii?Q?8Ei/qsqN4N4CJm0TozYoWpyWMPouwAgtfqyqt1vsj+O0vBcB0ynueb4lR/dx?=
 =?us-ascii?Q?rKl5DHMWZ6MI94dcXU1aj70EoA3XgX4DckdckpDVtoui3MMATgSuPEdu9eck?=
 =?us-ascii?Q?b/0qngMytM2dP/Zjaf1cJTTjypskMw0Jt42viqGZJdSwqtgmzGaErDNz0Cg8?=
 =?us-ascii?Q?CQJ8RG9eU6YPKWhrH1HS8eZ4t4dGHYLR4iFeIpqAsMrwB1egEFaWnANnipV4?=
 =?us-ascii?Q?J7b0QepPzCV8zkhdkMX2sSjykt/023Xh8rsNDJS+MKj4ghYtBYGcD1uSPfUc?=
 =?us-ascii?Q?/8FOZrxg78DF07RhUw3avDkqaLe+cybJ6ctCRt/xM3i+4PXJESvkyP2Gsx4B?=
 =?us-ascii?Q?F3c4Ze1UfPYVIYi/LLwbaSyLkFqTFw2p6XUFMYmR58PaQ6Ss3rQOHybuc/9H?=
 =?us-ascii?Q?WQTZSXLZKW5mHyhpN7lo76+QRxk1KjLbKM4jOjURVoe64PlfcgB11daCUxHI?=
 =?us-ascii?Q?8xjW+RCPH7sBMUC0pOXSKrgKWazyvTXnrIh9eSowlBsTsxOW2YFmhVkd8E3P?=
 =?us-ascii?Q?dg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: be345f9c-6b8c-4f7d-0089-08dbbf323639
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 08:17:38.3792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MDp7qeiFcHHla1BbRP2KhqVJWwHCwrlfZimgIYEBU8S5TKgd1sy19Rpc6cl4kuM59lQF6jBM8T2PtyaItxm7z5cHvI72sGd5UTNnVzeJqS0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8197
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Shiyang Ruan wrote:
> ====
> Changes since v13:
>  1. don't return error if _freeze(FREEZE_HOLDER_KERNEL) got other error
> ====
> 
> Now, if we suddenly remove a PMEM device(by calling unbind) which
> contains FSDAX while programs are still accessing data in this device,
> e.g.:
> ```
>  $FSSTRESS_PROG -d $SCRATCH_MNT -n 99999 -p 4 &
>  # $FSX_PROG -N 1000000 -o 8192 -l 500000 $SCRATCH_MNT/t001 &
>  echo "pfn1.1" > /sys/bus/nd/drivers/nd_pmem/unbind
> ```
> it could come into an unacceptable state:
>   1. device has gone but mount point still exists, and umount will fail
>        with "target is busy"
>   2. programs will hang and cannot be killed
>   3. may crash with NULL pointer dereference

Thanks, this addresses my main concern that this new capability is needed
otherwise DAX regresses the survivability of the kernel when removing a
device from underneath the mounted filesystem compared to removing a
non-DAX capable block device.

> 
> To fix this, we introduce a MF_MEM_PRE_REMOVE flag to let it know that we
> are going to remove the whole device, and make sure all related processes
> could be notified so that they could end up gracefully.
> 
> This patch is inspired by Dan's "mm, dax, pmem: Introduce
> dev_pagemap_failure()"[1].  With the help of dax_holder and
> ->notify_failure() mechanism, the pmem driver is able to ask filesystem
> on it to unmap all files in use, and notify processes who are using
> those files.
> 
> Call trace:
> trigger unbind
>  -> unbind_store()
>   -> ... (skip)
>    -> devres_release_all()
>     -> kill_dax()
>      -> dax_holder_notify_failure(dax_dev, 0, U64_MAX, MF_MEM_PRE_REMOVE)
>       -> xfs_dax_notify_failure()
>       `-> freeze_super()             // freeze (kernel call)
>       `-> do xfs rmap
>       ` -> mf_dax_kill_procs()
>       `  -> collect_procs_fsdax()    // all associated processes
>       `  -> unmap_and_kill()
>       ` -> invalidate_inode_pages2_range() // drop file's cache
>       `-> thaw_super()               // thaw (both kernel & user call)
> 
> Introduce MF_MEM_PRE_REMOVE to let filesystem know this is a remove
> event.  Use the exclusive freeze/thaw[2] to lock the filesystem to prevent
> new dax mapping from being created.  Do not shutdown filesystem directly
> if configuration is not supported, or if failure range includes metadata
> area.  Make sure all files and processes(not only the current progress)
> are handled correctly.  Also drop the cache of associated files before
> pmem is removed.
> 
> [1]: https://lore.kernel.org/linux-mm/161604050314.1463742.14151665140035795571.stgit@dwillia2-desk3.amr.corp.intel.com/
> [2]: https://lore.kernel.org/linux-xfs/169116275623.3187159.16862410128731457358.stg-ugh@frogsfrogsfrogs/

I only have some questions and comment suggestions below, but otherwise
consider this:

Acked-by: Dan Williams <dan.j.williams@intel.com>

> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> ---
>  drivers/dax/super.c         |  3 +-
>  fs/xfs/xfs_notify_failure.c | 99 ++++++++++++++++++++++++++++++++++---
>  include/linux/mm.h          |  1 +
>  mm/memory-failure.c         | 17 +++++--
>  4 files changed, 109 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/dax/super.c b/drivers/dax/super.c
> index 0da9232ea175..f4b635526345 100644
> --- a/drivers/dax/super.c
> +++ b/drivers/dax/super.c
> @@ -326,7 +326,8 @@ void kill_dax(struct dax_device *dax_dev)
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
> index 4a9bbd3fe120..79586abc75bf 100644
> --- a/fs/xfs/xfs_notify_failure.c
> +++ b/fs/xfs/xfs_notify_failure.c
> @@ -22,6 +22,7 @@
>  
>  #include <linux/mm.h>
>  #include <linux/dax.h>
> +#include <linux/fs.h>
>  
>  struct xfs_failure_info {
>  	xfs_agblock_t		startblock;
> @@ -73,10 +74,16 @@ xfs_dax_failure_fn(
>  	struct xfs_mount		*mp = cur->bc_mp;
>  	struct xfs_inode		*ip;
>  	struct xfs_failure_info		*notify = data;
> +	struct address_space		*mapping;
> +	pgoff_t				pgoff;
> +	unsigned long			pgcnt;
>  	int				error = 0;
>  
>  	if (XFS_RMAP_NON_INODE_OWNER(rec->rm_owner) ||
>  	    (rec->rm_flags & (XFS_RMAP_ATTR_FORK | XFS_RMAP_BMBT_BLOCK))) {
> +		/* Continue the query because this isn't a failure. */
> +		if (notify->mf_flags & MF_MEM_PRE_REMOVE)
> +			return 0;
>  		notify->want_shutdown = true;
>  		return 0;
>  	}
> @@ -92,14 +99,60 @@ xfs_dax_failure_fn(
>  		return 0;
>  	}
>  
> -	error = mf_dax_kill_procs(VFS_I(ip)->i_mapping,
> -				  xfs_failure_pgoff(mp, rec, notify),
> -				  xfs_failure_pgcnt(mp, rec, notify),
> -				  notify->mf_flags);
> +	mapping = VFS_I(ip)->i_mapping;
> +	pgoff = xfs_failure_pgoff(mp, rec, notify);
> +	pgcnt = xfs_failure_pgcnt(mp, rec, notify);
> +
> +	/* Continue the rmap query if the inode isn't a dax file. */
> +	if (dax_mapping(mapping))
> +		error = mf_dax_kill_procs(mapping, pgoff, pgcnt,
> +					  notify->mf_flags);
> +
> +	/* Invalidate the cache in dax pages. */
> +	if (notify->mf_flags & MF_MEM_PRE_REMOVE)
> +		invalidate_inode_pages2_range(mapping, pgoff,
> +					      pgoff + pgcnt - 1);
> +
>  	xfs_irele(ip);
>  	return error;
>  }
>  
> +static int
> +xfs_dax_notify_failure_freeze(
> +	struct xfs_mount	*mp)
> +{
> +	struct super_block	*sb = mp->m_super;
> +	int			error;
> +
> +	error = freeze_super(sb, FREEZE_HOLDER_KERNEL);
> +	if (error)
> +		xfs_emerg(mp, "already frozen by kernel, err=%d", error);
> +
> +	return error;
> +}
> +
> +static void
> +xfs_dax_notify_failure_thaw(
> +	struct xfs_mount	*mp,
> +	bool			kernel_frozen)
> +{
> +	struct super_block	*sb = mp->m_super;
> +	int			error;
> +
> +	if (kernel_frozen) {
> +		error = thaw_super(sb, FREEZE_HOLDER_KERNEL);
> +		if (error)
> +			xfs_emerg(mp, "still frozen after notify failure, err=%d",
> +				error);
> +	}
> +
> +	/*
> +	 * Also thaw userspace call anyway because the device is about to be
> +	 * removed immediately.
> +	 */
> +	thaw_super(sb, FREEZE_HOLDER_USERSPACE);

I don't understand why this is not paired with a freeze in
xfs_dax_notify_failure_freeze()?

> +}
> +
>  static int
>  xfs_dax_notify_ddev_failure(
>  	struct xfs_mount	*mp,
> @@ -112,15 +165,29 @@ xfs_dax_notify_ddev_failure(
>  	struct xfs_btree_cur	*cur = NULL;
>  	struct xfs_buf		*agf_bp = NULL;
>  	int			error = 0;
> +	bool			kernel_frozen = false;
>  	xfs_fsblock_t		fsbno = XFS_DADDR_TO_FSB(mp, daddr);
>  	xfs_agnumber_t		agno = XFS_FSB_TO_AGNO(mp, fsbno);
>  	xfs_fsblock_t		end_fsbno = XFS_DADDR_TO_FSB(mp,
>  							     daddr + bblen - 1);
>  	xfs_agnumber_t		end_agno = XFS_FSB_TO_AGNO(mp, end_fsbno);
>  
> +	if (mf_flags & MF_MEM_PRE_REMOVE) {
> +		xfs_info(mp, "Device is about to be removed!");
> +		/*
> +		 * Freeze fs to prevent new mappings from being created.
> +		 * - Keep going on if others already hold the kernel forzen.
> +		 * - Keep going on if other errors too because this device is
> +		 *   starting to fail.
> +		 * - If kernel frozen state is hold successfully here, thaw it
> +		 *   here as well at the end.
> +		 */
> +		kernel_frozen = xfs_dax_notify_failure_freeze(mp) == 0;
> +	}
> +
>  	error = xfs_trans_alloc_empty(mp, &tp);
>  	if (error)
> -		return error;
> +		goto out;
>  
>  	for (; agno <= end_agno; agno++) {
>  		struct xfs_rmap_irec	ri_low = { };
> @@ -165,11 +232,23 @@ xfs_dax_notify_ddev_failure(
>  	}
>  
>  	xfs_trans_cancel(tp);
> +
> +	/*
> +	 * Determine how to shutdown the filesystem according to the
> +	 * error code and flags.
> +	 */

This comment is not adding any value. It would be better if it clarified
why why want_shutdown will be false in the pre-remove case?

>  	if (error || notify.want_shutdown) {
>  		xfs_force_shutdown(mp, SHUTDOWN_CORRUPT_ONDISK);
>  		if (!error)
>  			error = -EFSCORRUPTED;
> -	}
> +	} else if (mf_flags & MF_MEM_PRE_REMOVE)
> +		xfs_force_shutdown(mp, SHUTDOWN_FORCE_UMOUNT);
> +
> +out:
> +	/* Thaw the fs if it is frozen before. */
> +	if (mf_flags & MF_MEM_PRE_REMOVE)
> +		xfs_dax_notify_failure_thaw(mp, kernel_frozen);
> +
>  	return error;
>  }
>  
> @@ -197,6 +276,8 @@ xfs_dax_notify_failure(
>  
>  	if (mp->m_logdev_targp && mp->m_logdev_targp->bt_daxdev == dax_dev &&
>  	    mp->m_logdev_targp != mp->m_ddev_targp) {

Maybe a comment:

/* 
 * In the pre-remove case the failure notification is attempting to
 * trigger a force unmount, the expectation is that the device is still
 * present, but its removal is in progress and can not be cancelled,
 * proceed with accessing the log device.
 */

> +		if (mf_flags & MF_MEM_PRE_REMOVE)
> +			return 0;
>  		xfs_err(mp, "ondisk log corrupt, shutting down fs!");
>  		xfs_force_shutdown(mp, SHUTDOWN_CORRUPT_ONDISK);
>  		return -EFSCORRUPTED;
> @@ -210,6 +291,12 @@ xfs_dax_notify_failure(
>  	ddev_start = mp->m_ddev_targp->bt_dax_part_off;
>  	ddev_end = ddev_start + bdev_nr_bytes(mp->m_ddev_targp->bt_bdev) - 1;
>  
> +	/* Notify failure on the whole device. */
> +	if (offset == 0 && len == U64_MAX) {
> +		offset = ddev_start;
> +		len = bdev_nr_bytes(mp->m_ddev_targp->bt_bdev);
> +	}
> +
>  	/* Ignore the range out of filesystem area */
>  	if (offset + len - 1 < ddev_start)
>  		return -ENXIO;
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 2dd73e4f3d8e..a10c75bebd6d 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3665,6 +3665,7 @@ enum mf_flags {
>  	MF_UNPOISON = 1 << 4,
>  	MF_SW_SIMULATED = 1 << 5,
>  	MF_NO_RETRY = 1 << 6,
> +	MF_MEM_PRE_REMOVE = 1 << 7,
>  };
>  int mf_dax_kill_procs(struct address_space *mapping, pgoff_t index,
>  		      unsigned long count, int mf_flags);
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index e245191e6b04..e71616ccc643 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -683,7 +683,7 @@ static void add_to_kill_fsdax(struct task_struct *tsk, struct page *p,
>   */
>  static void collect_procs_fsdax(struct page *page,
>  		struct address_space *mapping, pgoff_t pgoff,
> -		struct list_head *to_kill)
> +		struct list_head *to_kill, bool pre_remove)
>  {
>  	struct vm_area_struct *vma;
>  	struct task_struct *tsk;
> @@ -691,8 +691,15 @@ static void collect_procs_fsdax(struct page *page,
>  	i_mmap_lock_read(mapping);
>  	read_lock(&tasklist_lock);
>  	for_each_process(tsk) {
> -		struct task_struct *t = task_early_kill(tsk, true);
> +		struct task_struct *t = tsk;
>  
> +		/*
> +		 * Search for all tasks while MF_MEM_PRE_REMOVE is set, because
> +		 * the current may not be the one accessing the fsdax page.
> +		 * Otherwise, search for the current task.
> +		 */
> +		if (!pre_remove)
> +			t = task_early_kill(tsk, true);
>  		if (!t)
>  			continue;
>  		vma_interval_tree_foreach(vma, &mapping->i_mmap, pgoff, pgoff) {
> @@ -1788,6 +1795,7 @@ int mf_dax_kill_procs(struct address_space *mapping, pgoff_t index,
>  	dax_entry_t cookie;
>  	struct page *page;
>  	size_t end = index + count;
> +	bool pre_remove = mf_flags & MF_MEM_PRE_REMOVE;
>  
>  	mf_flags |= MF_ACTION_REQUIRED | MF_MUST_KILL;
>  
> @@ -1799,9 +1807,10 @@ int mf_dax_kill_procs(struct address_space *mapping, pgoff_t index,
>  		if (!page)
>  			goto unlock;
>  
> -		SetPageHWPoison(page);
> +		if (!pre_remove)
> +			SetPageHWPoison(page);

This problably wants a comment like:

/*
 * The pre_remove case is revoking access, the memory is still good and
 * could theoretically be put back into service
 */

>  
> -		collect_procs_fsdax(page, mapping, index, &to_kill);
> +		collect_procs_fsdax(page, mapping, index, &to_kill, pre_remove);
>  		unmap_and_kill(&to_kill, page_to_pfn(page), mapping,
>  				index, mf_flags);
>  unlock:
> -- 
> 2.41.0
> 
