Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD6D6D736B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Apr 2023 06:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236855AbjDEEgk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Apr 2023 00:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjDEEgj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Apr 2023 00:36:39 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60C8E1BDA;
        Tue,  4 Apr 2023 21:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680669397; x=1712205397;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Ykj8Gtx06InM3bbDfsbaaLv3Pw0h8xN9oRTBUZMrt5M=;
  b=Dwhvln4Z5QG2G/bWiKPAgStNLodScEU9P7I2mAC8CdvstrAr1ujA9b1L
   QF+C9h92ajeEYDBODE+Jc/LMSPz8012vCGvMGaf4qI5oIfsWrz1pxHER7
   lGny9CwaHeMgfCkGckiIrXinNUigWOSPBwk5rN0wemaB19YHxPrr/nQfd
   kOoaI8tKpwhovrvkDDiM3cFGbT0QYklLc60OAI3Md0xRF2imSpjbFo/Ci
   LTRBSA+ec3tcZ9H3+S1wQuxQAAevK9mWQSsouAXMcRH04wd21rsEuMna9
   6Ie67B00wB+EixoxnVY/1mx7ZLwfYj83r1nncr9RR9v6M/4ywO+KHOL1u
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="342386336"
X-IronPort-AV: E=Sophos;i="5.98,319,1673942400"; 
   d="scan'208";a="342386336"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2023 21:36:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="751139097"
X-IronPort-AV: E=Sophos;i="5.98,319,1673942400"; 
   d="scan'208";a="751139097"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga008.fm.intel.com with ESMTP; 04 Apr 2023 21:36:36 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 4 Apr 2023 21:36:35 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 4 Apr 2023 21:36:35 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 4 Apr 2023 21:36:35 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Tue, 4 Apr 2023 21:36:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C4wm8o58XAU8hM/QRenUkivLqxHbGglZBwemGyJshb4FL12iAxRETzcBWR18wA1f8fxM7T+Sug+PI6fnIEY5k/22n18971wN1QhL6Fv99WwUkeK5Tlhvz6hikSwGHuazjLg9UBTGB6/AFCeNQ0zqOedbV3hd9tHneXMHAlVNT9yrYErX4A3IjrLWLn3NGgep1uxV0BU6ovVjyHrzdRwgEpqzLzyso7Nuy4h07s447wbOZpgem2epEsQFap67R5EAcCwVKQk9C/HFuhyl7OKAOLYt4WroK6RGYP4SQqtggDbCQ4GK2ho4D3QBSePT8ZWD5bdmhu5dX9jIHkLLFG3kbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j+DL7+3dvnjgmv1tDd4STpagpjh6XX+l3fdprSa0EBc=;
 b=HNb+n0yWmtUuPsT0FZQyz/wQWi85qpgq5rOgV0OfghiKUcPbnaEcrth/oRGxZ30J44SzhLYOn9WWvUlZLFWUoRuW6BSRzLmbbvUXPkEzeO3LnSGOej2HHfhBqNOUMuOuCtKiM5v2HFsE9xzeo/SvXaew8L/RlWUHPUzOaAE6RxCO8qdpN8n7FsxYwCNJX5wfehviSHLyiSRAOeLYclygIUY9beGoet/Uf9OLyFl8JdkQskocxeE/mmgPe4CTcI7kmcWhfutJEUPB0alRsOdcjAWyFLGsWSLLX6TWFqnFKlSFJWv4/9Qa/8gZ9xdhoLnV7sOubjrId2dfdrHJDi82ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB6553.namprd11.prod.outlook.com (2603:10b6:510:1a7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.30; Wed, 5 Apr
 2023 04:36:28 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ffa1:410b:20b3:6233]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ffa1:410b:20b3:6233%5]) with mapi id 15.20.6254.033; Wed, 5 Apr 2023
 04:36:28 +0000
Date:   Tue, 4 Apr 2023 21:36:25 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     "Darrick J. Wong" <djwong@kernel.org>,
        Shiyang Ruan <ruansy.fnst@fujitsu.com>
CC:     <linux-fsdevel@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <linux-xfs@vger.kernel.org>, <linux-mm@kvack.org>,
        <dan.j.williams@intel.com>, <willy@infradead.org>, <jack@suse.cz>,
        <akpm@linux-foundation.org>
Subject: Re: [PATCH v11 2/2] mm, pmem, xfs: Introduce MF_MEM_REMOVE for unbind
Message-ID: <642cfac98978d_21a8294cd@dwillia2-xfh.jf.intel.com.notmuch>
References: <1679996506-2-1-git-send-email-ruansy.fnst@fujitsu.com>
 <1679996506-2-3-git-send-email-ruansy.fnst@fujitsu.com>
 <20230404174517.GF109974@frogsfrogsfrogs>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230404174517.GF109974@frogsfrogsfrogs>
X-ClientProxiedBy: BYAPR01CA0025.prod.exchangelabs.com (2603:10b6:a02:80::38)
 To PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB6553:EE_
X-MS-Office365-Filtering-Correlation-Id: f6d0ad75-3d1b-4386-8331-08db358f5204
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +XJUg97k3eYE/ujedkHKkvBofmeL4rPQ+TKQGuxuA0LFQ83q0xo4KghXQUFcAUz5vHMT8rLp+gVxhcYvyWRnFcUrLf2Ss9sZN9YTA0U/r3TdkZDT87qiwHUp5vHMxGeVO/zKtj9R39i0qqkXNxQCgJ5UNZl/CuCQAmbHkAYpQ4chAqBcujjAFsigpEw8HPZzyiNmCWRZ0lMo8Vnvl2FrJ8ymAU7WTTXqnlpaHGNBiqmCRK+BLFkSWWggKWU31SygKFEsoustP2o9X3Ab03XPOoPtW44CW7UrVWrOifMZxa2c1WBLYaEYnF1efKT9vdbpnQRgSQTTjHCZendwFrl5ZzNvTgKtDExLeBFRUYEMYH913jhVz5iK6q431goVew4+Et+ifEa9FYdJYt4T03PZTw3rY4jAGuSF1jmXYiIl3W1KHWEDRM9THb2oMnsy5qq+xAtJjMbR25Ocx2curIS8eBSEG2hHLCkvqBsITCjIxGzcWr1UubNY7s9J6T9rRzvh6z32KuqRN4A6NPPPZor6suGAxHL5YgyX5zx5c17p+uZZ1Ta3e2Qp5FmhRZ1eJ89HhmohA8QNiXdfB4LpR8Vbng==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(136003)(39860400002)(396003)(376002)(451199021)(186003)(9686003)(6512007)(6506007)(26005)(6666004)(110136005)(478600001)(38100700002)(66476007)(86362001)(66556008)(316002)(66946007)(4326008)(82960400001)(8676002)(83380400001)(2906002)(41300700001)(5660300002)(6486002)(966005)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?A1vKZiJI+3t0+TlPYsR/VQ7VBaclH6cT2+y9JKMiHSIfM0WQkW1UjTq6SvN3?=
 =?us-ascii?Q?UAT5lbavFtgj9kHkYkRDpDHWaIWEhJpfL/0wyRQOxi7Obq0EjReRDQBWa7Ho?=
 =?us-ascii?Q?FlPNYgLEa3UcTh1y3bzd4O6cWNllUaK7S51d3KiXt1s0A8A6Wq8TPbYI2awU?=
 =?us-ascii?Q?Nj+nJgQr8ARjOiHwP6YU3iswiotqxZVMeAxcRrRNor4yxLdYtqXD9BUR4oZ9?=
 =?us-ascii?Q?+3df22/7QQjgZAmo5wfgEF4psdfEI7v0IX9GHsNKyi9ElX2LFtzRb9YUvB+Y?=
 =?us-ascii?Q?EOZ5p4flgVWsCkbJAEJ6JIjOpxeqBtbFMlfnREOieNsevrUY4FCA/DwDSn8B?=
 =?us-ascii?Q?nt7yocDC1nn5dw7ity0QxywAEuJBHr+GRFX6P1Og+E4W2IL3Zx3U/STxRcW4?=
 =?us-ascii?Q?PO9FNt/QH6g7Oy3s3GnrIzoGcTrFfP3y6sPY4p+NHecLpfPBZz0bznu1zdFi?=
 =?us-ascii?Q?pFrQyLUzVigVQGzor/b3f2QXu/vL/cLwPdn1ntwW1hq6XmFmuzjaszR8T6oG?=
 =?us-ascii?Q?5NrGzcMaBClWlZccY2aCE9xEOc/jq3+C4ZvklSTW9TAYmr7Q8WV81mz7Jzf+?=
 =?us-ascii?Q?3f5LGuUGGCo3haWKblDPnYnjgaxCKoQ69bWXNESHhaU48Skk65y3Qftb9NMg?=
 =?us-ascii?Q?+GOdoMid51ZTqyaHYHrt1TRN8aQp8qFAp01bVcQtB22/vdNT3LvZzXALL8g4?=
 =?us-ascii?Q?zBFYpZJAAD/H0VWZyC3oXgeEWM08bq2R7l8pi1EQyUG9ytUn+VZnd+z5H+Rn?=
 =?us-ascii?Q?HySCqTmmbpfOUNueCSyh+VTPPbdcxgjCnx5MuJTLfQu01Wh6eKGnm6VyjGyL?=
 =?us-ascii?Q?4d8j6XIGJgCBxZ+vJkYHIJRpaZxN0i9T9RGI3dPgaw/6D8h45DNfJUlayaik?=
 =?us-ascii?Q?Y8dfQOGm0nMiPVzLq7KqcYVFN4I1192giNIMtyCT3wKz5cQGyYTeaLrxAxO/?=
 =?us-ascii?Q?6TxeRPxvYafvGqOaI1QUKMEaTVA+dKxVNxODTYoVEuhDtummd/b7dvctopi1?=
 =?us-ascii?Q?Yv0npP9ShcD/eognyBz8Au6rBFtg1mhyNIOz2lhxdSZLZtulrGUjQ0jAB9k6?=
 =?us-ascii?Q?90geGQBCL7esFZge66TpsS8h3pZ+8CFavvdYEPGDKbZoyyjVpc6n7RPPyKzJ?=
 =?us-ascii?Q?Km2QynSmvCdaP49lpbUaYhwFMofmly7N7oGmBxdZ4YFyKAjeIzxwH9LSfgPR?=
 =?us-ascii?Q?8eBGy6cnrSgEVpCglAyaITA+h7Pf6iw65cDoVseZpg9c0FhRiazICruCaKzH?=
 =?us-ascii?Q?A9LWzs+B79g1hdnJNwg7OZdvBdU/oK/DHdXfLo6n9WDt6eDKEMn45tX6go8z?=
 =?us-ascii?Q?veHH06WGSKOv+TqYsmAmlWxCbOAmjkdlSRNYQe/pBI8r8WrDOtFimTJSQJ05?=
 =?us-ascii?Q?TzWVFRAD1XvbvJcP2C2nUEw2NBSPsUnNnCUKbUevXTJK49s0aMlI79ZjtJkQ?=
 =?us-ascii?Q?Zm2ji5WGrJS/iiDTFrK1620WRnmyqN9BUv98vkIghByINlP/OyiKg7k95kt8?=
 =?us-ascii?Q?rnFS0TpU1daz1SUVK7pDHavQ7AnqPD8rgWE1RJ/gIb04xh2JQIoIO928VZm4?=
 =?us-ascii?Q?J33VyhV7r8WRBoHdHMoh/vTMoX41aI9Eq8f5rWhekfwk7A5Gn69718rvTIJH?=
 =?us-ascii?Q?tw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f6d0ad75-3d1b-4386-8331-08db358f5204
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2023 04:36:27.7998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vnluUMUdE+AVfC6m8S12/9dp2dXG3Xp2g6+Zsvx7vB4pIZlCeYYyFR7TMVJ1Uur+3OX1/fReK1fVH4WQ2OHVxFqsxzCl3+eI014AliqTT3M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6553
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Darrick J. Wong wrote:
> On Tue, Mar 28, 2023 at 09:41:46AM +0000, Shiyang Ruan wrote:
> > This patch is inspired by Dan's "mm, dax, pmem: Introduce
> > dev_pagemap_failure()"[1].  With the help of dax_holder and
> > ->notify_failure() mechanism, the pmem driver is able to ask filesystem
> > (or mapped device) on it to unmap all files in use and notify processes
> > who are using those files.
> > 
> > Call trace:
> > trigger unbind
> >  -> unbind_store()
> >   -> ... (skip)
> >    -> devres_release_all()
> >     -> kill_dax()
> >      -> dax_holder_notify_failure(dax_dev, 0, U64_MAX, MF_MEM_PRE_REMOVE)
> >       -> xfs_dax_notify_failure()
> >       `-> freeze_super()
> >       `-> do xfs rmap
> >       ` -> mf_dax_kill_procs()
> >       `  -> collect_procs_fsdax()    // all associated
> >       `  -> unmap_and_kill()
> >       ` -> invalidate_inode_pages2() // drop file's cache
> >       `-> thaw_super()
> > 
> > Introduce MF_MEM_PRE_REMOVE to let filesystem know this is a remove
> > event.  Freeze the filesystem to prevent new dax mapping being created.
> > And do not shutdown filesystem directly if something not supported, or
> > if failure range includes metadata area.  Make sure all files and
> > processes are handled correctly.  Also drop the cache of associated
> > files before pmem is removed.
> > 
> > [1]: https://lore.kernel.org/linux-mm/161604050314.1463742.14151665140035795571.stgit@dwillia2-desk3.amr.corp.intel.com/
> > 
> > Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> > ---
> >  drivers/dax/super.c         |  3 +-
> >  fs/xfs/xfs_notify_failure.c | 56 +++++++++++++++++++++++++++++++++----
> >  include/linux/mm.h          |  1 +
> >  mm/memory-failure.c         | 17 ++++++++---
> >  4 files changed, 67 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/dax/super.c b/drivers/dax/super.c
> > index c4c4728a36e4..2e1a35e82fce 100644
> > --- a/drivers/dax/super.c
> > +++ b/drivers/dax/super.c
> > @@ -323,7 +323,8 @@ void kill_dax(struct dax_device *dax_dev)
> >  		return;
> >  
> >  	if (dax_dev->holder_data != NULL)
> > -		dax_holder_notify_failure(dax_dev, 0, U64_MAX, 0);
> > +		dax_holder_notify_failure(dax_dev, 0, U64_MAX,
> > +				MF_MEM_PRE_REMOVE);
> >  
> >  	clear_bit(DAXDEV_ALIVE, &dax_dev->flags);
> >  	synchronize_srcu(&dax_srcu);
> > diff --git a/fs/xfs/xfs_notify_failure.c b/fs/xfs/xfs_notify_failure.c
> > index 1e2eddb8f90f..1b4eff43f9b5 100644
> > --- a/fs/xfs/xfs_notify_failure.c
> > +++ b/fs/xfs/xfs_notify_failure.c
> > @@ -22,6 +22,7 @@
> >  
> >  #include <linux/mm.h>
> >  #include <linux/dax.h>
> > +#include <linux/fs.h>
> >  
> >  struct xfs_failure_info {
> >  	xfs_agblock_t		startblock;
> > @@ -73,10 +74,16 @@ xfs_dax_failure_fn(
> >  	struct xfs_mount		*mp = cur->bc_mp;
> >  	struct xfs_inode		*ip;
> >  	struct xfs_failure_info		*notify = data;
> > +	struct address_space		*mapping;
> > +	pgoff_t				pgoff;
> > +	unsigned long			pgcnt;
> >  	int				error = 0;
> >  
> >  	if (XFS_RMAP_NON_INODE_OWNER(rec->rm_owner) ||
> >  	    (rec->rm_flags & (XFS_RMAP_ATTR_FORK | XFS_RMAP_BMBT_BLOCK))) {
> > +		/* The device is about to be removed.  Not a really failure. */
> > +		if (notify->mf_flags & MF_MEM_PRE_REMOVE)
> > +			return 0;
> >  		notify->want_shutdown = true;
> >  		return 0;
> >  	}
> > @@ -92,10 +99,18 @@ xfs_dax_failure_fn(
> >  		return 0;
> >  	}
> >  
> > -	error = mf_dax_kill_procs(VFS_I(ip)->i_mapping,
> > -				  xfs_failure_pgoff(mp, rec, notify),
> > -				  xfs_failure_pgcnt(mp, rec, notify),
> > -				  notify->mf_flags);
> > +	mapping = VFS_I(ip)->i_mapping;
> > +	pgoff = xfs_failure_pgoff(mp, rec, notify);
> > +	pgcnt = xfs_failure_pgcnt(mp, rec, notify);
> > +
> > +	/* Continue the rmap query if the inode isn't a dax file. */
> > +	if (dax_mapping(mapping))
> > +		error = mf_dax_kill_procs(mapping, pgoff, pgcnt,
> > +				notify->mf_flags);
> > +
> > +	/* Invalidate the cache anyway. */
> > +	invalidate_inode_pages2_range(mapping, pgoff, pgoff + pgcnt - 1);
> > +
> >  	xfs_irele(ip);
> >  	return error;
> >  }
> > @@ -164,11 +179,25 @@ xfs_dax_notify_ddev_failure(
> >  	}
> >  
> >  	xfs_trans_cancel(tp);
> > +
> > +	/* Unfreeze filesystem anyway if it is freezed before. */
> > +	if (mf_flags & MF_MEM_PRE_REMOVE) {
> > +		error = thaw_super(mp->m_super);
> > +		if (error)
> > +			return error;
> 
> If someone *else* wanders in and thaws the fs, you'll get EINVAL here.
> 
> I guess that's useful for knowing if someone's screwed up the freeze
> state on us, but ... really, don't you want to make sure you've gotten
> the freeze and nobody else can take it away?
> 
> I think you want the kernel-initiated freeze proposed by Luis here:
> https://lore.kernel.org/linux-fsdevel/20230114003409.1168311-4-mcgrof@kernel.org/
> 
> Also: Is Fujitsu still pursuing pmem products?  Even though Optane is
> dead?  I'm no longer sure of what the roadmap is for all this fsdax code
> and whatnot.

First, I need to spend more time on DAX patches, I have let CXL
monopolize too much of my time and you've relied reviewed these when you
have other XFS things to worry about.

As for the future of fsdax / pmem, I had written this up earlier:

https://lore.kernel.org/all/62ef05515b085_1b3c29434@dwillia2-xfh.jf.intel.com.notmuch/

That said, I would feel better if there were examples to point at doing
"PMEM over CXL" in the market. Maybe there are and I have missed them.

There are examples of vendors doing combined CXL memory with NVME flash,
but the CXL in that case seems to just be a way to move DMA buffers
closer to the device, not something more interesting like a
hardware-accelerated page-cache / pmem device.

For now the kernel is ready for PMEM CXL devices per the specification
(drivers/cxl/pmem.c).

Now, all that said the motivation for this patch is a bit different in
that it solves an architectural problem with the way current pmem
devices are shutdown and the missing step to properly evacuate usage of
'struct page' metadata that may be active on that device. So while CXL
hotplug is a practical trigger for this, it can also be achieved without
hardware via:

echo "namespaceX.Y" > /sys/bus/nd/drivers/nd_pmem/unbind

...to hot remove an in use namespace / volume. The observation is that
before the pmem driver can assume that it can rip active pages away from
the system it needs to tell anyone that cares about those page
disappearing to abandon their interest and shutdown. So the idea is for
surprise shutdown failures to tell dax-filesystems that all of the pmem
is going away at once.
