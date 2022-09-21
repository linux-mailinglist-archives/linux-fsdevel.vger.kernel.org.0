Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACC0E5E56D1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Sep 2022 01:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbiIUXpe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Sep 2022 19:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbiIUXpc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Sep 2022 19:45:32 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B159F77F;
        Wed, 21 Sep 2022 16:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663803931; x=1695339931;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ORMcI/FMK9/bE9uv94dXDrDP+EXd0wTQ1XsR726t/+k=;
  b=chPhhoDBSqDHyUdiKtm3odoXbgFzwGW2X+eCdqK8PBM/1kEca2RFXCsh
   bPqJ09vQ0ZHHhT3vXZ4GichY6cnqbdiWfvVsXYUmiNysKRvKhUxNenmFy
   w0k88xJ+YBNe+04hM0fZ8w9FV3x1mmV/LjBC8AbdaDhpIzc8gOP8fyEqr
   rRMujSgpjzFCPqJTXGv0E578pmihuL1r2VzWW3vADLP0dzNXMBJxgQ0re
   GOA9MBwPP93HynkoH0iyl9Ge5+eaTEbbgkZUWANaCjF/qA5x9qQF6xSx9
   v45l+ntaPezDFKyMWAM4PBDXIB5NB4EsnGnCcFUsfb1KoNCyeFa3LJ+kf
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10477"; a="297754843"
X-IronPort-AV: E=Sophos;i="5.93,334,1654585200"; 
   d="scan'208";a="297754843"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 16:45:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,334,1654585200"; 
   d="scan'208";a="745168589"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga004.jf.intel.com with ESMTP; 21 Sep 2022 16:45:30 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 21 Sep 2022 16:45:31 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 21 Sep 2022 16:45:30 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 21 Sep 2022 16:45:30 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.103)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 21 Sep 2022 16:45:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OSSYYDF1+R3SlkCjdeN0L+yh3pDv5XmV6efYaqX3PEopmB1ihVkwiQylk1yoNvIZgLFuYlX2/Uv9S+FppCFQ+FOIwmwrrtGB4kMT0gBi+2Mne5qVj5vmE1o6eNZO63khLASwpDi4nPiRFW3TmsEl4SBuJMYZvEQyXFo7LqkU+1lcf0JeJpa9aNOzeXbR+lVaQuaETUOMedAEaBxja6LM1GyHMWCqrHeu/M4jquvva7f+Fl9Sikhnfg0Vv2uJ+cdoYRZ3vKSGEvdeJucC6HSJp0873wx84OcLZaI5SPV3SlnBSOfm0wUdxQyOKXIlYmOR4yK6cdaoBgludfI1Dp8eJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s8zUTMnRCyJ3pJXuMdUqEYG2T1UykC5ygGGpbeWPsTs=;
 b=DLZEiUalTrpTOOQK4mgyY/UV50Yvhx1AyYwMfZLed8h2cvOp0t9BLQpAP0OMPrwnr35513JDFDNkq1vxl//BNe5H4sheBBbhn54Y+EjcVOnmXAOl0Scmmwp8FbE2Y9ioAZe0cnoMqQ+Zh8Rk5HwEC1bJ0Eg+lxy7XGBByEPJrVpXpFDU6sX1YDkd8vQQ0sue6crOuKf9XbPRld44RKxQNKn48OXleku3O//acEQBdRNdZyziFX3ph4q5stjDDBr+othCMR3eITNr8QJqpjQetCntI/QcnpSmiJDA79DWEXcYtDpGmdO4YuUcb6rEFiP3DTIsZHnVTXw1v4EtaTegGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by SJ1PR11MB6204.namprd11.prod.outlook.com
 (2603:10b6:a03:459::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.16; Wed, 21 Sep
 2022 23:45:25 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12%6]) with mapi id 15.20.5654.017; Wed, 21 Sep 2022
 23:45:25 +0000
Date:   Wed, 21 Sep 2022 16:45:22 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Alistair Popple <apopple@nvidia.com>
CC:     <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>,
        "Jan Kara" <jack@suse.cz>, "Darrick J. Wong" <djwong@kernel.org>,
        "Christoph Hellwig" <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        <linux-fsdevel@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <linux-xfs@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH v2 16/18] mm/memremap_pages: Support initializing pages
 to a zero reference count
Message-ID: <632ba212e32bb_349629451@dwillia2-xfh.jf.intel.com.notmuch>
References: <166329930818.2786261.6086109734008025807.stgit@dwillia2-xfh.jf.intel.com>
 <166329940343.2786261.6047770378829215962.stgit@dwillia2-xfh.jf.intel.com>
 <YyssywF6HmZrfqhD@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YyssywF6HmZrfqhD@nvidia.com>
X-ClientProxiedBy: SJ0PR03CA0352.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::27) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|SJ1PR11MB6204:EE_
X-MS-Office365-Filtering-Correlation-Id: b272ddf2-72b3-4f2b-52f2-08da9c2b5b3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nBg7Z47wEq3VXw+tghMu8/U7SHgGaA3AQhpwdJioPdMGxmhREfDETzUVNWbD+EeQlr94odY+4xLvnqIoSxAU+Yqt/jZxXRB3qrPvbFeGRw8jIsAd3GJ2gWVqCTfGAFal7H2CScGkVr+DWOtnToA28ZmQpIuh5XQ+rcleKbQybDqfv78zc8bc4aYWy9KrSnHC7pQIe33xh9Sgnt6L1W7b9/uGz7FRkjYjvrTtQUwFOEtUvMNPYRqV6tmHXNChqluMy7z90C09WF42gqTiKFJp58oipjgS7N+UA7s+7pPjCzRsvyBZf2eKzvPdFxqZ7yIqX3svVN0AP1CZL6nRowD8LWNMZ1SLQ0KWT/X/chyo5CGw9YzUbAIqQpnQ0gNdHao+IHd5sKWjQigi1WuIeGk9CYPLYBmOY+ttifnaxJb/OzolJL+aGxdP6h4lEfwmkUFLOsWL95WGoA4oxzpxBcDgG7kMWS2DF++jUDyZhZzRXqJ+q5SpsQCWtLhbvPgDB/JVAQYG7ziNe1MbCfZ1hc/A2XDx6W0k9JVw5kDBEbugrjgyplyA0JDkMwVqNLLa7OB5uUpKGAvzuBt/bu8n5cRA92r0Sw9hcWK7tDsqPG86ByjjuaMvzrsoANnRd586XsjK5AZ23xMvX06pyK1zIzPLllQC9iS9aRNTql/uDzbPIwWSETuTLJT3J9pXvptgNoaHSorTXvoC1fuP4Nl9nwfKMA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(136003)(376002)(396003)(39860400002)(346002)(451199015)(8676002)(6486002)(8936002)(82960400001)(38100700002)(186003)(83380400001)(7416002)(6506007)(41300700001)(478600001)(6512007)(110136005)(86362001)(54906003)(316002)(26005)(9686003)(5660300002)(6666004)(66946007)(66556008)(4326008)(66476007)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+1ufcVv4foL0LBQqu+uGRdxCUrj+tgbXplBOOaCp4BXv1ugrNocgPg+Ho+y0?=
 =?us-ascii?Q?Y+VQin6Wkz41P5rZ+NoMvmnelN48X51kyaFeW0YvlyKgpdVSGz7Dyf+r3dY/?=
 =?us-ascii?Q?cr8zgCiiXuGqLj0+KlhEeXUB/IxPUglqcAc5z6Q75MIzjFtdG9vdmV8zantN?=
 =?us-ascii?Q?cu7IxuyzNquk59SrHURnpsvG0L7PGk66lOhCIHl2vnQexdTkAEOArKRUES6V?=
 =?us-ascii?Q?moKcuqpwj6K528gEERt+K1GUb15jFJhiiIwekZphc3aiqzmvf0BYfQMO/KUR?=
 =?us-ascii?Q?5Ir7IwtkzQfMdnhUHOjxZ77gGg7W9Pedexocb0DzhElRZ8f2j+nlUs750cJy?=
 =?us-ascii?Q?PMVLU0l4ld88gY4R4kpgbGEPiWU8sje6U2KBoEl4usZdd6BP68GUsRlBOO5r?=
 =?us-ascii?Q?hYiFAC4LFqoLAAVwZHAq0r1ptojHMRhwsns1yoO/jtURhh2EULU6DAGQaTJC?=
 =?us-ascii?Q?XChnHiu+myH+JXB5taUYdqSwuqaa/65rcEGz3Rm/yd8VH8b+cWn7fyC+5RqX?=
 =?us-ascii?Q?d96xcWdL7TGL/4Ugc2sswOFZiOXalD3mFdJdG0efpG0aEqpytfLNpVIlTVbP?=
 =?us-ascii?Q?BoopLuYoWvXjwe3w3N1j0k2nKbaa3RExE9vPvg6G9w1hDeeZ0VIzvIsKJEuv?=
 =?us-ascii?Q?Jv2jOYkxLtrrqIAsZYW44ukpI7OqC3WYuKo0PnIht1cP5PSBMK5nn4chS1D1?=
 =?us-ascii?Q?Ff28S4OBsJWLd/NTWJ3DESsa/rJekYOt7xt7rQbc+rAl88+C652JSagfcyV2?=
 =?us-ascii?Q?+SSKVfMduV3EzUrgCceM2h9RffkxF8q2YReHcfhGT8uuNNRXl0bXEsX3y/04?=
 =?us-ascii?Q?xg0/JphsEk0XB/NNYltsFmiUaNfF46h8Q/Gdk4LiYeRRuc0YNJGtePvvmbM1?=
 =?us-ascii?Q?oOXzGSeU40fKWMQWkRUVu618/nDhnlNGIRx65l0xN3ug9XCHvCo0VOxKSZ3s?=
 =?us-ascii?Q?fzbM/EnTVe9Srn8jOfie68/z91AFRnfTHzAHFs02YucYJclm0MAPfIkU4Pwv?=
 =?us-ascii?Q?Fc9lhk+CcjIHVw7noKE4IccA7WhzIGG1xYFF99ljlgiyb1BG+azZeIrqbjiA?=
 =?us-ascii?Q?78a6ZYnZqDt5XynK+XNvZQf1NJkwfQ7MGJU/EZ5GoSX/M8odrSL9X9qIVDg+?=
 =?us-ascii?Q?YgA7vukHMy+QP2MH27geGB2SR+XSu19BVFx3eJ8f1Ocx97rs71yWm5FbWGMo?=
 =?us-ascii?Q?y88vyX04+p7D9SGK2H1DfET4hgoIwVuGlylrV+y2iQLsR0Ga4Evm0ucqhDlL?=
 =?us-ascii?Q?48FEkulswnpJ4fbx8mM5uBhW433A9gvMizUaiVpC66ao734ZdOC7KeQLJV04?=
 =?us-ascii?Q?VIzIFsy3HsqmD2wFyQiis5ok7KRBHZ0vAXM3Ilty5mcEdRc6hy8BjlPJyzSL?=
 =?us-ascii?Q?IFnnzYED9SmBAvcpZDdjNu3jmT15aq3XJE4tGYxFV4yx3a5mdjxOQPCbJVz+?=
 =?us-ascii?Q?VozGeypWO+aN3aCDZrdAyC8ZTVQmF4Zb98iW7s/3IDO6U7ZbQcwi7XdusRpd?=
 =?us-ascii?Q?ImLBlh5GuReEHWtpKFMMe8fs4jmOufTfNdft0AX/PwbvJjSauDDl2gXkGctR?=
 =?us-ascii?Q?PsQ9Q7F69j8nenD2iGbjUINW6TI59niHgblx44UNsK6HwRASpz9vFi6tB+jZ?=
 =?us-ascii?Q?dQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b272ddf2-72b3-4f2b-52f2-08da9c2b5b3c
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2022 23:45:25.6740
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9aVLIipQFRNwafm9jkG2Xzx0sXhewxlBCuyhKufaIWC+bOIpC5uYpNZ18NurL1VxK9Rj6m75W08sRBvwO0cJmd3gFxkPAtsX3eyrS0qx15g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6204
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jason Gunthorpe wrote:
> On Thu, Sep 15, 2022 at 08:36:43PM -0700, Dan Williams wrote:
> > The initial memremap_pages() implementation inherited the
> > __init_single_page() default of pages starting life with an elevated
> > reference count. This originally allowed for the page->pgmap pointer to
> > alias with the storage for page->lru since a page was only allowed to be
> > on an lru list when its reference count was zero.
> > 
> > Since then, 'struct page' definition cleanups have arranged for
> > dedicated space for the ZONE_DEVICE page metadata, and the
> > MEMORY_DEVICE_{PRIVATE,COHERENT} work has arranged for the 1 -> 0
> > page->_refcount transition to route the page to free_zone_device_page()
> > and not the core-mm page-free. With those cleanups in place and with
> > filesystem-dax and device-dax now converted to take and drop references
> > at map and truncate time, it is possible to start MEMORY_DEVICE_FS_DAX
> > and MEMORY_DEVICE_GENERIC reference counts at 0.
> > 
> > MEMORY_DEVICE_{PRIVATE,COHERENT} still expect that their ZONE_DEVICE
> > pages start life at _refcount 1, so make that the default if
> > pgmap->init_mode is left at zero.
> 
> I'm shocked to read this - how does it make any sense?

I think what happened is that since memremap_pages() historically
produced pages with an elevated reference count that GPU drivers skipped
taking a reference on first allocation and just passed along an elevated
reference count page to the first user.

So either we keep that assumption or update all users to be prepared for
idle pages coming out of memremap_pages().

This is all in reaction to the "set_page_count(page, 1);" in
free_zone_device_page(). Which I am happy to get rid of but need from
help from MEMORY_DEVICE_{PRIVATE,COHERENT} folks to react to
memremap_pages() starting all pages at reference count 0.

> dev_pagemap_ops->page_free() is only called on the 1->0 transition, so
> any driver which implements it must be expecting pages to have a 0
> refcount.
> 
> Looking around everything but only fsdax_pagemap_ops implements
> page_free()

Right.

> So, how does it work? Surely the instant the page map is created all
> the pages must be considered 'free', and after page_free() is called I
> would also expect the page to be considered free.

The GPU drivers need to increment reference counts when they hand out
the page rather than reuse the reference count that they get by default.

> How on earth can a free'd page have both a 0 and 1 refcount??

This is residual wonkiness from memremap_pages() handing out pages with
elevated reference counts at the outset.

> eg look at the simple hmm_test, it threads pages on to the
> mdevice->free_pages list immediately after memremap_pages and then
> again inside page_free() - it is completely wrong that they would have
> different refcounts while on the free_pages list.

I do not see any page_ref_inc() in that test, only put_page() so it is
assuming non-idle pages at the outset.

> I would expect that after the page is removed from the free_pages list
> it will have its recount set to 1 to make it non-free then it will go
> through the migration.
> 
> Alistair how should the refcounting be working here in hmm_test?
> 
> Jason


