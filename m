Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0B2581A23
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jul 2022 21:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239766AbiGZTMC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jul 2022 15:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232019AbiGZTMB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Jul 2022 15:12:01 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC4A3244E;
        Tue, 26 Jul 2022 12:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658862720; x=1690398720;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=H7zE73x1erGrfC/uKzGd5QDMFvxIOMFYlOuwssKTE9E=;
  b=eYAYUyBbFFJ26J+X+5hVs8UDaGAvt+0hNlzMtYRfXrkVGmdPFtB3FT1v
   N/04atRmJu4yBN1zwmXpDNQzVK7td+R+wNJ+FZG/LsugAjBoX1KNMmKIT
   Fodp2rpcPaZjh1z6QD+bqPbD/GkUHNmFRZtkYKmA0PjkPkJ8MPY26l5Qn
   urRE7GkEl0kEJJblDHl4yVh7Lmulq92nuzYL+CTSaqUxm+eP1XAtzlQFo
   R9yc1xYfkWwc36nF8hONpRACDPtkJDGOqQPO8sMuQZPAS9E3nA+J+1d7e
   qK7pIKhI3ohDdQdSKKlea8B/o4eHxBx7Rm8PfaLt65pog7kz2RZe5wRQj
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10420"; a="374334105"
X-IronPort-AV: E=Sophos;i="5.93,194,1654585200"; 
   d="scan'208";a="374334105"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2022 12:12:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,194,1654585200"; 
   d="scan'208";a="575619413"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by orsmga006.jf.intel.com with ESMTP; 26 Jul 2022 12:12:00 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 26 Jul 2022 12:12:00 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 26 Jul 2022 12:11:57 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Tue, 26 Jul 2022 12:11:57 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.102)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Tue, 26 Jul 2022 12:11:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hpSbYcyA6k5R792ipLf9x3uW3sqVWHn6AjTSwbamjA08vwjjfez/oxSO1UD0/vmJbN4GqpIe+KcV6eFIHZpHefCbv6fO5OZbLQfUqazGArPQxpXsf6yrrKe7FrUVuwb+2AGT5IGYDzLYbAK7fnlNjhB9mpGzQ5gg/JL1Po5NJzokDum5wqYLTsUdJbbsVDExQrs8MnJheeV4jqVS5o811t7Hn+PlxIhmEbUeAbyCBx6yl4KKsYvFIQlLYisEmVulA1D73XFKrGrVjvdoUk02MfgsWetP0B6gQSX05Gobv0d04hfkr9YgGp1gACRwLFM50uw2MTHwachEGS1AOVXL9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nuWeRXNIXLlZOyZIlmceY4f5bEyCxke6Cimyz3roXEI=;
 b=acfK5+Zq+nmrxkP385OdSaaKf8NULaQf+z7QzVLo9vD4IcxEK44sm1dg3fQcwwrd3SvSxg/VnzeqiiYLCuZlICIutRm8W9txHC7upl30W+mx4tFr7qGnQJrN5bI5Q4Y8DjVapM24Vkd77dOb77/QkCqUqh4R9kqmdxiDMeVwlR4EOobwVlE1pjRiqDjmLO6hsBzJYFoEzJoRl6aiPZirg/+0qqDSCHPFYdbFKgYkGTGlYnaFRg2682qeAtjEPQOIhPKfAZAwcRKDaMfKXvhr2CbQ63mBvl55UEL47UtIT/li0Ro2grVQAJjPnsG2Oek+9YOu4wqcsv44JpxH5bv7Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6311.namprd11.prod.outlook.com (2603:10b6:8:a6::21) by
 BYAPR11MB2789.namprd11.prod.outlook.com (2603:10b6:a02:cc::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5458.22; Tue, 26 Jul 2022 19:11:55 +0000
Received: from DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::1168:74bf:ff5d:68db]) by DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::1168:74bf:ff5d:68db%7]) with mapi id 15.20.5458.025; Tue, 26 Jul 2022
 19:11:55 +0000
Date:   Tue, 26 Jul 2022 12:11:50 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     Viacheslav Dubeyko <slava@dubeyko.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] hfsplus: Convert kmap() to kmap_local_page() in bitmap.c
Message-ID: <YuA8dgXPoDklBryE@iweiny-desk3>
References: <20220724205007.11765-1-fmdefrancesco@gmail.com>
 <A2FB0201-8342-481B-A60C-32A2B0494D33@dubeyko.com>
 <Yt7Y6so92vXTOI+Q@casper.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Yt7Y6so92vXTOI+Q@casper.infradead.org>
X-ClientProxiedBy: BY3PR04CA0017.namprd04.prod.outlook.com
 (2603:10b6:a03:217::22) To DM4PR11MB6311.namprd11.prod.outlook.com
 (2603:10b6:8:a6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 58f4d84b-dc3b-4942-329e-08da6f3ab445
X-MS-TrafficTypeDiagnostic: BYAPR11MB2789:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ga/WVkB5pfVZIcb5ciG/7AaJ9krQI7LMidrivGxVIUPCIoszxZ57d1VcQujiV2Y1vvk/2xjFThlkvLea3OtLU9mntgCU2XgJfoKbGu9sBtokWGPg2KHJ7MUbVSDksGi1vA0wkJ/s6K0723ddNGUmuU+ZTO3bt0Leo6Eopi9RP/SXliDmnrJNwuXNGrMKDjn/+jc8PfjiNojCDftIUwJRbd8tutzog+lTyC7r4zfJG/3ygLKlX6L2bWVXw4zpBAuepKxNvUdwzSLLoPL20SnLuie8G4BnhT2sj/1sxsdhONpsHrKhwd7ZbQvLCErGJ9jJERI2uIfYmVZseIEFkRN/K+WbwezqrMGdiXpUhjJe+IPJ3lOKxLFR9rJja37jUFO2eEv9+XQUr+kIKUh80PrwfebEkKzGMHYMQ3K1SH8vrVRvz+abc+j0cQImu2doECoS6qnzierPKDB5sSdkir3v4ONorL0lGJ+NeEdfj82+QyciqOxz29AV0XNNKjMgLts0uYXZE4PlzPw+wKHS4pfuEZwYT1skP17So1gyJvcb0kL6H07zXHCobZJF325oOyW3gqdMBF7YeudRzixAw6XUFnWBxt8Y7MJb5zi67UIcHD/VSskqodUtlLDpE54I4jKqdFihHvbpWVpAU4peb+IWXMJrKjev3+IAGeuadQstA1s5R1wl/SRKb6SgShu4RZK/RyFgFz9TK/xujn9kA4VAQlY2TC+BsiW6gM886/CEK2c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6311.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(39860400002)(376002)(136003)(396003)(346002)(366004)(66556008)(4326008)(66476007)(8676002)(54906003)(6916009)(66946007)(316002)(86362001)(5660300002)(33716001)(4744005)(8936002)(44832011)(2906002)(186003)(41300700001)(478600001)(82960400001)(38100700002)(9686003)(6512007)(26005)(6666004)(6506007)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AagS/wwxKGhBZMZW1OxcukdWosNH2IAzR4Q0KCjRBctkPO94j2T00On6CK6R?=
 =?us-ascii?Q?vNh1N4RQnouN6txoH3DlmrHYyv9P7bCdF0Ws3pxvTrcCV3/R7OEw7emGeHG9?=
 =?us-ascii?Q?GnziZyEJibqtBqlRQydnTxVtw569Rm43iQR8YHkkzUJjG4vuoSsjurPUxzWQ?=
 =?us-ascii?Q?/ZEUbrx/dWH2ujD7/1O6lp7IDZF9S2Gkl3fHj2EjdmkMrATiOsY26QnqZXUg?=
 =?us-ascii?Q?qpRhVcjvfFY44JlQ3yzoQZVn/4PBxUaVpjxW7uPJf07vjYfNbtB/l3yBafMz?=
 =?us-ascii?Q?4G9IACIQ2DcxXpN0HhlIM1HmZbe9+OPywPdoky6AjhDT2ZejrS0Txo1Cc0VQ?=
 =?us-ascii?Q?5xmneMEVlOSvOF/EH7h87pugOH9hEYETGnOcbkK3wcGl9tAALeSzMmhHJSFt?=
 =?us-ascii?Q?K4rf6wT9GPmANNihA+5X1LqIJ8nFM6Pl0YdaI2frvJd5OFM9kEU/vteYKfkL?=
 =?us-ascii?Q?mODbH9cPWjJmsfiFQfb1IH4tSMitLX3yQPAF5AHNKYS1pHm7ciaajvrckC9p?=
 =?us-ascii?Q?KqIbmUZkEjMYKbomH6+7EcXpSzpmfmF6sh6DWU4fG1r0xxDBMVgV0cs/Q46Y?=
 =?us-ascii?Q?GBbrOEF4QPRlgHzieH2ve2UTGZ6DyMntkom8pWoFUWTzT8/SUiP9dq/FVFQm?=
 =?us-ascii?Q?GJnc9XzWd20WUrbML+WQisyHpG4rM6qVmaR+Ha6bId6OGB+ZiqsPks63+VZT?=
 =?us-ascii?Q?XPoc16Fa3Cpq98qntEp1taQ3eCe2Jo1PQ7E8r0QDb2lJG32Tl6smZv/MeS7L?=
 =?us-ascii?Q?j8fn3ObvQCz6cyOcHXjIDwRJDsfzv9TNz4r81K8EHFz654bP60ATcAFXqO+1?=
 =?us-ascii?Q?F5Qt1w8HTEtKQmPYF6TCrRZe92N7l/SDTDa/3KGvYzbtrn8gVzO0i+Y+wN4k?=
 =?us-ascii?Q?5cS71uDTbnpwWCQTgD3ONQyVPStD10B47f7HAuLZ9GrCkM9/hmujHWzJUyJP?=
 =?us-ascii?Q?v0To02QYkbuTSOaDFK9p8UzYOlJVkipN3+yJAu0PsvlX8/8+y1g/2Dr39Pz1?=
 =?us-ascii?Q?pkBj9Hr7CV4BsY32Yg6ONFT9uNp9fde7oSjgnagd4ebrLUAGnkzeiZKdaDjr?=
 =?us-ascii?Q?A4EpzH0Qu1qeyNQHPCkozOGJ4XTl/vS3Ruh2OjD+ajRdHYjZqiBftuy64GP7?=
 =?us-ascii?Q?ApTRObz8b/0obQaDx+rmydk3j0hg5WL3DUo+yeu/Ws7HmkI/93XPRBVJBTYK?=
 =?us-ascii?Q?GLF/sPk9jO3Bdhl8ubqGBExTYrk67upjzo2YMSCzo57bFFUZIp8Eiqx7E0sd?=
 =?us-ascii?Q?g6aKnggin1851OkC0N6APtTAFTRUp+o81/2V2KZC8JDzbM3uLxHvgroIuvkL?=
 =?us-ascii?Q?/4HbXSS2dFHp/4wVNZACAMySl0lRCj0cYmC4ZFnwA8A3fPinJX15oyhPbpVy?=
 =?us-ascii?Q?VPBA74TMxnoqHC8vt6hRRgBliXrqCUBtavqlTzQYqvE/wHLi0zaTXI1n0vK8?=
 =?us-ascii?Q?IdkKd/DD9MJaVgTjcLG6ZVeeRWCxUoGt6yWTNDwy2dFr3/wnxukbZBVxkXaP?=
 =?us-ascii?Q?KFqovS5ABzSfC05SqfcZ+4pIpjT9RWUJs7RWw9vBAv0+4xifQRkJrq/btCDv?=
 =?us-ascii?Q?1icj9kH1vCtOAX1zrCEQiPdtlNASu7Xs2F3Zx/fZ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 58f4d84b-dc3b-4942-329e-08da6f3ab445
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6311.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2022 19:11:55.0660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PlTAXi14G9/xqfnKCZ5KKPmrXMdLLK6E2RBB60FYhJHDNmgjQB7FGDeVLp4p/ZMTPxAHoshBfcAiAT6qwSjGrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2789
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 25, 2022 at 06:54:50PM +0100, Matthew Wilcox wrote:
> On Mon, Jul 25, 2022 at 10:17:13AM -0700, Viacheslav Dubeyko wrote:
> > Looks good. Maybe, it makes sense to combine all kmap() related modifications in HFS+ into
> > one patchset?
> 
> For bisection, I'd think it best to leave them separate?

I'm not quite sure I understand why putting the individual patches into a
series makes bisection easier?  It does make sense to keep individual patches.

Ira
