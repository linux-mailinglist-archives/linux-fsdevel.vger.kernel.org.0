Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53EC37B3B2F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Sep 2023 22:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232923AbjI2UUp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Sep 2023 16:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjI2UUo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Sep 2023 16:20:44 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03256113;
        Fri, 29 Sep 2023 13:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696018842; x=1727554842;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=xhoGppBdOF6pavMTyYUI01OxAD7hXvdF2wnR6eoNxPs=;
  b=OWnBDcktgFfIeJDVRBsSsrseLtaSs+2j/cqXoMij8V6XmizwggmUqylO
   xqT35KnDKVYeh7MxM/ylUpG4/yoWVNfv70nsG3lsedEyFwsWz5oAMz6vB
   +PogbIlt+Xapkyfd4u1w098+hvzktnbnhleKuUoWVfMfOqVh1mQXjxFVN
   hhZmXcKcYOM1pH4vlHsQmtdLpQAIZWG3g04Lh8zxjgkQnJW+wDRr1iYwM
   z/Ea3f5z5aClINsCHkoQ3pDpU1v0EHIZFdlOs4Tt6Hc0FWcG1ZA2G5DBN
   o+MfjeqWmoq+zv/8hECzxB59KhS5OJnUdvEu8W3rEcYPWupFkGvq1Ny3p
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="3927888"
X-IronPort-AV: E=Sophos;i="6.03,188,1694761200"; 
   d="scan'208";a="3927888"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 11:31:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="865780153"
X-IronPort-AV: E=Sophos;i="6.03,188,1694761200"; 
   d="scan'208";a="865780153"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Sep 2023 11:31:06 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 29 Sep 2023 11:31:06 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 29 Sep 2023 11:31:06 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 29 Sep 2023 11:31:06 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.106)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 29 Sep 2023 11:31:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SGkSAXzbCKGD7lIsL0WKVQLVwLBokFWVDte6wWDYERN0RfYeL1D/+9NTcO6GN2MYwFNVcEbhS7HPMFTBuxV4aQbWSIswyb/HrkHs0DNgj1EvcdDblpRn4hreSUEXFaQqxsNe4DWb9nAwDxAhFQxjlRN8CSOSZRzn2tLUkw75siEw8iK95hz/v847cw3y4uUWw7mVqY1a3JkxKFMs+K7La0OsIPTCR1ekXCX86yoPS++ydll/kfyey6kysXs5rlaGKqPzLvu5VcpqCgxEbNX169FETjvUmrepPMAJyKVBO8YuFIVRLKg0zUVu2jtmhvyE22qB8DZYzaJ7l0upYeAeZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M62S3QvgKXxMg+GiDPMxARiLjoIN8N7Nyx5ON/x0UCk=;
 b=MiPdU06dETWah2upBSHEatP/4kHW9wypW1z7ryuFvcJLHIH6cQrUD5bB41Ylqou/rHa/+cpmBMqD3ZDdgW19abFrcRMFc82fFFmsR57GsSGqE8cU6ywR7epW7A9ffLHP4lxpxSNNSBZ2ptRY2MZzAmyZUOm6zKMpLg4CVTYmW8fBfxuVA9PjuCJ5LRV6EHBOXzYInK1lUE/YIQy5OxaJISTWPFsKrU3WLKGAjDpmf7vfrPO1XIM55Bj9EP4IoZzCeH4oxE9+TAvgJVJO6hSLCig5CB3KWwb8hYkY3SfEHTPifAHeNi+3ARTjKdcSSzNgA5mT/VF2eHB7tDfrabQQzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CH3PR11MB7763.namprd11.prod.outlook.com (2603:10b6:610:145::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.26; Fri, 29 Sep
 2023 18:31:03 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992%5]) with mapi id 15.20.6838.024; Fri, 29 Sep 2023
 18:31:03 +0000
Date:   Fri, 29 Sep 2023 11:31:00 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        <linux-fsdevel@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <linux-xfs@vger.kernel.org>, <linux-mm@kvack.org>
CC:     <dan.j.williams@intel.com>, <willy@infradead.org>, <jack@suse.cz>,
        <akpm@linux-foundation.org>, <djwong@kernel.org>,
        <mcgrof@kernel.org>, <chandanbabu@kernel.org>
Subject: RE: [PATCH v15] mm, pmem, xfs: Introduce MF_MEM_PRE_REMOVE for unbind
Message-ID: <651717e48168b_c558e29423@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230828065744.1446462-1-ruansy.fnst@fujitsu.com>
 <20230928103227.250550-1-ruansy.fnst@fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230928103227.250550-1-ruansy.fnst@fujitsu.com>
X-ClientProxiedBy: MW4PR04CA0139.namprd04.prod.outlook.com
 (2603:10b6:303:84::24) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CH3PR11MB7763:EE_
X-MS-Office365-Filtering-Correlation-Id: 5eb5d1ad-a7ae-4383-881d-08dbc11a3cac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WzPL7ScoUDzYoZpKuR3DvjZ4u971T2ziFUx02XQj5qKWSpqfKKZGif7vNSsg8V0ADtFSRor1oYywgsok1Hy7H7tkr69NZsWeb1TCjXiBLbZgR8OYbDVR6pn8AgPynPe/kFU1VEoCjpTXxtaGsvPgxIq9rbZ/MZ9shVTQGQibHHh4TVeIyaUWuLRyzwiplYQGAAtTQwGk4w0zyYTNoJNKPjUBcHuN2sqkIQ3ZcLlMEEMjG7X5khMindjeMSHFKWwWgXiwp7Jg8HLp7aJQda80VN3jTBHSFxxg+uE4m/xc2tCkde+e9B4hzqgae0EUyFVjV8qkWw3D0wf4OMIYXQBfIAm1BhvphYmCXEjhd7EW27+/bY9ITfR51pF4uOxD6P1t9fJGmv/3F1u58GgGlMlS0AVpH2y/rN0vYa7pTwnAQIx/zcSwr9RSX+ZkAcZC9IHi7cV88R3IapqLc/LuuHVC8IFhlkw3yeci03/dOlf8jYKmkhFLZ0hs/36dt4TgLqca20pcQFt34wsgOfaWYgZLD8mkoBtgKzAd4kDg5jv79p5eqvYp17+WB/hQT9iuslsNxGbpmlycZLZQnD8nZu8xkRAl3iG7IlXYZKLikTUQDoBe93uqhyDeIX83UhpSgfvqnbdSK8BjUqjYqRdrlQPaDQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(366004)(136003)(346002)(376002)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(6506007)(6486002)(6512007)(9686003)(82960400001)(38100700002)(86362001)(4326008)(26005)(2906002)(7416002)(83380400001)(966005)(478600001)(8936002)(316002)(66556008)(8676002)(41300700001)(66476007)(5660300002)(66946007)(18704003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hzLMiePjrAOSrj/CuAqJgLi5L/oKzFBk6imxvFkxL5yIbd71f4VLzkYiyc7o?=
 =?us-ascii?Q?1XsDqKXcVF6h1N9HqehzBSaccBK84gzRUTpeiSSYaChQPn0prqsUYIIlqThM?=
 =?us-ascii?Q?9eHsRCifxw3L5/HPEJCP/Ehdk4MpFC3QCJq7hLIV/9atRAvC0onv/6H/cVYp?=
 =?us-ascii?Q?B13pDakAFLMX/ptJ2k344V5uzsowyFvUsHfyxqh6hkaqviEgF+QyWJIKVbV9?=
 =?us-ascii?Q?AIVLNYG/b3otyTxaQTByZCHv89qa9N+c4mtfLvVYvVK7RYceUuZXQL4mxobu?=
 =?us-ascii?Q?8HxYeUgceJHwFLpAlKset8YFylJG4Xug6xO+Wndpw2YGFdIypVcBfzS0OrjL?=
 =?us-ascii?Q?XRhi4MFhpB484WyRsmRk6ZP16SQwaULFqbYkmSYDvYRRPhMouC6kO5wbmWHC?=
 =?us-ascii?Q?JYU6TYaf+pboBtqAPrTcXOrRzI+F1L+1NC1VH+hXtLhvDfri5wcAySH32iT8?=
 =?us-ascii?Q?56/42m+nQXSiSACXZs/EwPSPh34FKvsjQhc9xxNZCddI/8nnzhmrSPHRW/3I?=
 =?us-ascii?Q?iPYuI/1hvY6N4v4N3/WqKXmg7c+Ud2hjcrC99Na/t/a8JvFDVyVNrt3X9JVM?=
 =?us-ascii?Q?OL87EiehMaAFjzfVFmcM3F20VAXa/Da7oc64rCKRJiyH/jxhybcOOq3rPTaX?=
 =?us-ascii?Q?Zb+7abncKIwGzTW3+V7NyjMTPDPEOaWZpyKGKGgEeGAZVtZsQby34ECAFt8u?=
 =?us-ascii?Q?GG5SosYdv3WMj1y2Irj3Hqui1gKAtkpSd+cHDru7LBeTyeqsryITiWrr8jPt?=
 =?us-ascii?Q?RCfLZvAzE+BKxlEP8DsDyQykU5xg+rVQFIXnf0SsrVnaAv2jY967EA71wh1n?=
 =?us-ascii?Q?wKsz0Ea1jVt3PlN10dKmU/H7atEl1PlTth27hzEsPjFiIkcwE+ZaGxsH3JmO?=
 =?us-ascii?Q?zA2yH84gzjNNofou6Ng8PJgnujtpwS3ckSjKNW0cSRSEgWqna6bi/d+vpD9l?=
 =?us-ascii?Q?3zWLYWu3wL3MRRVGEcd+5FOIXKUfxaBtITwO4gIaRC9ohGdDtw3J2XB4UVUP?=
 =?us-ascii?Q?Y4suab75os5ubi4tph64OYjiBkQ347vCVE1V9CUtxBA52EhRobAOqZEePahk?=
 =?us-ascii?Q?FkA4FxE5jjsutiyhgWmQwZfyIO3NpPNOtkxEclGBIYlkU3KSWnZBRIy5OsHr?=
 =?us-ascii?Q?TkvhJsUHUynO14Y8llPGBgpkb11WhNqui+CR+Wzn/DoaBDl+CT+fWwnf6Gq7?=
 =?us-ascii?Q?weWSab21MwrI6fXMcb1lRisNRS/LuLLJ5zFr90pBB/Pu5usnLwIPZW5Z0+22?=
 =?us-ascii?Q?yUdVh4GMMS0sJYzU8dZmm0Xj3ozLU2Mn1m1lUuwW80obh3uuBeeGsvqrdLCR?=
 =?us-ascii?Q?uungLIQ32PGzQ1ApPZJyiKyYR583GZ/ICNvnAq6/p5JRBtFpIzT+FV1cjDYh?=
 =?us-ascii?Q?3aKm4WC7qSgWV9WBA5Xk2r2TcQRRcO2n9k/olXbaJsCJpcAh5zjg0A7bV0NZ?=
 =?us-ascii?Q?CyCwAgfjGd+zcqUlXIPtMv9iKXgs6m/x6bLz2ZhpqPaSOi6QNkobY8TNbN5V?=
 =?us-ascii?Q?4m641C4dXqtWlWUYSLhiBvEdOQLUQE0/6e1qxXX0mXFiDglI4rLImoWe1EyI?=
 =?us-ascii?Q?hMes7ch5I4ftAGhaPMFpNCW78de1ii38ZRgAe0pHCs6gToLnRF21MG2fK8wG?=
 =?us-ascii?Q?Dw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5eb5d1ad-a7ae-4383-881d-08dbc11a3cac
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 18:31:03.5652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M58XmqjnOQfanpIzxrUOvWf87RiMB7336nUDzwraUIbW+O+4Z8aIQN5mntQqdDZSDwdHLxMZd1JirmvxvZc52b0NtNa19NJFSof0LixoClE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7763
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
> Changes since v14:
>  1. added/fixed code comments per Dan's comments
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
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> Acked-by: Dan Williams <dan.j.williams@intel.com>

This version address my feedback you can upgrade that Acked-by: to

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
