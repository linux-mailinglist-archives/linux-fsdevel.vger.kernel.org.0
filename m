Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0106D77E72F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Aug 2023 19:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345044AbjHPRDQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Aug 2023 13:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345056AbjHPRDM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Aug 2023 13:03:12 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B652103
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Aug 2023 10:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692205391; x=1723741391;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=w+mTyFSKieHmBhYERPtDxRQMijK1VuT8sq9GMsCP7SA=;
  b=m19USIEZOR2T2BJZ732WizoeUCWQdFNOR7HPeLy6Kq9mYaicOae384Ya
   f4A7WEfaOV2hHwIyg5lKodO+NKOdD1VpBiVy+fz8Q6MVnm/D1Oj+mO6G9
   8/7YgcMtcA7yfv2doGlCW0gCGW+nXETw3ZbtbJgqOkc8xl6DJs+OmM5R4
   kbxS5IckTLYkBsQDG1LRmSQ71UznVTIUIdazCmMdAfFDh/agmQUD1StaK
   YTgwPG1C2FCLKQlxOJ7uQ9dQfi4zeL2AiqXPXhvkfeAwS5KJOehniyjV+
   jEgEozkX8s05ddACjBDltPdHA+JkTdcsRBEdLoUIqHhakv9rUVeKUtb5Z
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="438940117"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="438940117"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 10:02:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="734301048"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="734301048"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga002.jf.intel.com with ESMTP; 16 Aug 2023 10:02:55 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 16 Aug 2023 10:02:54 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 16 Aug 2023 10:02:54 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 16 Aug 2023 10:02:54 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 16 Aug 2023 10:02:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ELrt3Osv5T/r7Q4ZFKBI7qQx3SASnFZ2YvkFfXwHY4NhPcd8kWzhcj8a6FG3mczgOpJeuMubrPjvRo6Q37MumBS8U5H5Q2hvTZvZcRhVIGs5+PqZx5CQHVhKcGPZXufqYcK9J8JQkbImDY8ZT9XYmRxxHxAFQ29iUIW3RzDf7JNGBc5+s+a+myUbtODhNyNmKEBZnKk3PE8WyaRNO2o0OvGxBfe0wmtJNywr8XkNRy1+FMULcSzArtq6ELGqgDgcDHQrkyQ97+MUjokQeIeJ9RMTyzf/VufvsGmPyYkkRFvyvMfBjBQkMDVyuVZDV4WfM8rhZ96Y6dO8ij7U6mQotQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6YwG9RoGotvZlFHYZKAomZMKGRfL9Bt8ybD9KPor2CE=;
 b=BCQNpX+Rs4zs8fZE3ljh0iIPXGOap9ojB6tU6F6t99WmEIct4WcCwKYpkZgtfjSVRwMIwJhjDWC3XHf4LaRLFhM8qlawJrpxJtjJsgBjb/p9bnhLtKRxZunSGT9N9RxYgVkUKE8jDPCY1JD56tWmWY28x551HscaS6aa2ml3au8sNpUzPwmhWpAF/K8TuBlYNM2sKTrSE+qh+ETR0fzJf1ZsJIjOhxAtIkxTUMyTPpm8VCMgKCC7fWKQFIYTVBqEXghHETBo7xiiw4q+enlN70P8XwJQwfwDgMhbBz5r9inusatEEvxG4l5vzTHkuILfYODt9ojtOlnr0wdKKiOHiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH0PR11MB5191.namprd11.prod.outlook.com (2603:10b6:510:3e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Wed, 16 Aug
 2023 17:02:51 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6da5:f747:ba54:6938]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6da5:f747:ba54:6938%6]) with mapi id 15.20.6678.025; Wed, 16 Aug 2023
 17:02:51 +0000
Date:   Wed, 16 Aug 2023 10:02:48 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Sumitra Sharma <sumitraartsy@gmail.com>
CC:     Ira Weiny <ira.weiny@intel.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        <linux-fsdevel@vger.kernel.org>
Subject: Re: Inbox vboxsf not working
Message-ID: <64dd0138c68f2_2a8edb294d5@iweiny-mobl.notmuch>
References: <CALPt=azKNntv31d510UMkYXbcrsOj08aODVozsoKhLY6Gd-fgg@mail.gmail.com>
 <2e4b6df9-8fdf-8188-42a1-c7adf28f2473@redhat.com>
 <ZNy2zDT6SSUxX9P1@sumitra>
 <2d29fd54-b8c9-6efc-49b2-c83c56463db7@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2d29fd54-b8c9-6efc-49b2-c83c56463db7@redhat.com>
X-ClientProxiedBy: SJ0P220CA0012.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::24) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH0PR11MB5191:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c251ebd-97c7-45d3-77bb-08db9e7aa010
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9hCm3UqCqv9gOdTPH7nspwWnXfC40YyH3K3E4THPrL7FiGx4bn95RBAFS2FnPUOLrUlczuZCeCVUmAHIN4koRvpauVAi9JK3pND1qkMsaLeEVakITyxLfYc1wAeIpyGhZFfgysgzj1ZqHTNDHBURYGapPIP5xL1lXIev9wcIdfHgiuqlgSdZ81OjHsiARa+gZnlEeD+q1xGxFG03FUct1u7ZP8mTOMz0K3rtUhWRETeNO0VuqtoUl+bqNOcMQ7xqYXkLeBI+3Tylrv98gURhzCGg4K1Ct62jeLQl4CcNIYi5Rwqyiej6tgUX5RBYMf/ZcyipOQ4kgP07aZHDcLjTVUdtg6/ce2WSWhgRNoSCDbij6+QPbw08JWTogQ7lePq+Sg99M4cyNmDHWDf8EOXy1jolwCnfifEzrbkxhtE7IqAcIy5XhlC+NRbwJ8QJAvAyqrXbi0PMhj9tDthyGJGYUeGYqpiJbpVfsOo3zOtYjwHi252rSEHygzfW4QwHyFAVL0e/SQJTj0tM+pXOHlZZxjhq6FIWl1gxxbTVKoEYK9wVpP3EAl7/g+zjRY/OVgsi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(366004)(376002)(136003)(1800799009)(451199024)(186009)(316002)(54906003)(66946007)(110136005)(66476007)(66556008)(3480700007)(41300700001)(5660300002)(44832011)(38100700002)(8676002)(4326008)(8936002)(82960400001)(66899024)(2906002)(26005)(478600001)(86362001)(9686003)(6512007)(53546011)(6506007)(6666004)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BMBGqerXnQPLqYSoR7awOMy9HvyeN0KdwWM/sVAyfHI5wlq2jJn4x7YxtnzT?=
 =?us-ascii?Q?k155gLdPCYurmfj7oW2bInsaeIF85bNTLq9jLC48pEs7GUT6iUTt5eq8RdPc?=
 =?us-ascii?Q?17z0tvhRxM+aqQ/wWgLK23bIaHvZ/6OkbpIi9++kRoSS6IKjJ9DH8SeirnGi?=
 =?us-ascii?Q?RFQPanADmsXjK4U5DfDMkCCmKQH59ResTMTm62H4oZOjyG2lu4xiMWhC87yl?=
 =?us-ascii?Q?ltKN+t9/X1y4sHDJ0t9cYslSqad0/07Wn+sIec7BoaV8fOVZ8CAptkolxO2r?=
 =?us-ascii?Q?Ihng5DVc9xgwlNxWikpXn8EfW2dr6Lgd6pllqC/OHbcuXWm4Nyp1SbNlthdy?=
 =?us-ascii?Q?TiewrUNx70Oe1AMXvjoW0VquL2uCw9e5ZHeAr8l2F2wBq74M51A54ZmTBNNv?=
 =?us-ascii?Q?jkfEDsnGv6f5P6Ljoa2cdHnHuVg9DL+q0KCcRr+4+uJApYhi+CpEgYHk1ZEj?=
 =?us-ascii?Q?iNdbyJb8AY1lL+e8OXKdvRr9y+v0mhC7+JmVXpY9p2isU6QYLwwxju1+1MdF?=
 =?us-ascii?Q?cWi76ASRYaxZNYmVOoXMjmLY9dWekTPqDB/9WNN/xreJgKGgPE5ohynT4PWQ?=
 =?us-ascii?Q?TCLBD/znpS0WFQbGGqhlmVpIGr960cG3GgZwF0N19Xwf3nMQsWARofDz02gb?=
 =?us-ascii?Q?VwnlSwujLC/5XrQvtBAMKe9ajW7tUVj9xNL2eHojpzjV/3moiPSt8jXMHnJv?=
 =?us-ascii?Q?+j90FVuECkyHfuRBmAPJx6pgjbJVmcqf7RXIrTM/6LEg/4WxUybtUNGo+uxV?=
 =?us-ascii?Q?LzX9ek2X/tcpRlf8p8Q/rmxUJ30St59S/ljDAC9cMD/90u1AFzd6rAGDBn0V?=
 =?us-ascii?Q?pl1a9q8V2mD8FKpXdI7TmoEkgb2f6xs2LL1AmI/blvM5Zrnmfn3TX4dyTsaN?=
 =?us-ascii?Q?AVzXsXLqjWaEx3CgZLQgVcxjIKMQ04XRJhfUyKQMb+6o0uGd7T75XBLKq68T?=
 =?us-ascii?Q?9DadgY8T71eBvyHfvu8uTBhtkKOZl3CNjnP6w+KaMSqiaQOlaJHqSjghyt5g?=
 =?us-ascii?Q?bDpsVC+qvqXLQOci0D+a/DIyOWWgM6xLAbpoIY5WYzFQyfEh224Wj1JeuqS7?=
 =?us-ascii?Q?N1Tl63YveUFqpj7DkHcqyx4HH7+C/bKPjFl+0dULGGlBzefg3trjNPDDGYDm?=
 =?us-ascii?Q?luclAD/zJ/IosHNCkJCQh+bCSLjnQfDBmeYrZv9BheKfQmLP5EFEU//5/6Z6?=
 =?us-ascii?Q?xaNAWIIBhi+IvoLOeFSQCng7Pr817eHYTX4mS+LpZpR6a65tkAKRBBgLW7rB?=
 =?us-ascii?Q?LdWezUmVTVBuXajCzRrYstiRCF+Rvwdoh44zGfjx3PMxFNoakHMu7Ycz7JdO?=
 =?us-ascii?Q?k7MkjozVM++qnP4JR9vUAoARTOA/JziEHZlU/YdbOC/6wubSpABMYNr6kfPe?=
 =?us-ascii?Q?PfbbM0nVFh7Bh6KJltaEazR8S4nn+BEG0qXNJjqFllPhxvUUP4n4qw/X7lzv?=
 =?us-ascii?Q?nh6KJjSuRPSJZuzld2E2ZDXVel8yOxQM+21jhgbpb48kEcrHfXDIg6/9Z1W0?=
 =?us-ascii?Q?Q2DDBSQ0E7ZU67ohHWTdmRvA7UAGRH0lcUKDI2nw/ufdA1OSXfJRmap5d9/r?=
 =?us-ascii?Q?cw5kvxxTLOS8SxR+V03PSMTF9HjBy6A4moRen8GZ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c251ebd-97c7-45d3-77bb-08db9e7aa010
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 17:02:51.3150
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MuYNqZgn6qLHMX2CEp3PJSIKbc1pJsTiNBiuUMuQLi4qOz1eyTI0Q0Gh7wh2f/QktZGNWS//27Nlgvuv+XDM/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5191
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hans de Goede wrote:
> Hi,
> 
> On 8/16/23 13:45, Sumitra Sharma wrote:
> > On Wed, Aug 16, 2023 at 09:28:51AM +0200, Hans de Goede wrote:
> >> Hi Sumitra,
> >>

[snip]

> > 
> > Hi Hans,
> > 
> > Can you please specify what you mean by "vbox guest functionality"? Are you talking about the guest addition utilities which VirtualBox offers and about which you warned not to install them? [*]
> 
> Yes.
> 
> Virtualbox consists of 2 parts:
> 
> 1. The hypervisor / hw-emulator on which virtual-machines run. This hypervisor itself runs on the host.
> 
> 2. The guest addition utilities which can be installed inside a guest / virtual-machine running on top of VirtualBox. These allow things like copy and pasting between the guest and host and sharing  a folder on the host with the guest.
> 
> The host always uses out of tree kernel-modules.

Hans,

Thanks for this clarification.  This is my fault for leading Sumitra to
believe that the in tree modules could replace the guest additions for the
VirtualBox hypervisor.

> 
> The guest can use the in tree kernel modules.
> 
> > How can I make the in-tree vbox modules run?
> 
> You can use these and specifically the vboxsf and vboxguest modules by
> installing Fedora 38 Workstation x86_64 as a virtualbox *guest* / inside
> a virtualbox vm and then share a folder on the host with the guest.
> 

I took your original email to mean that some in tree modules could be out
of sync with the interfaces used by code coming from Oracle.

I'm curious are there also out of tree modules for the guest support?

Thank you again,
Ira
