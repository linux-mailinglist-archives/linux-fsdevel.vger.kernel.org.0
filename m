Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F18D56BC2B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Jul 2022 17:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238630AbiGHOvR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Jul 2022 10:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238536AbiGHOvO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Jul 2022 10:51:14 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A113E32;
        Fri,  8 Jul 2022 07:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657291873; x=1688827873;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=5tQW2MbZ9AnORcoWxbwmzPqFL63bgPCibOJl5fHhIRs=;
  b=cz6U3u/JJ/2b3+lqaN5EWXpRrO5EXun7vDJa9tDMcXz8ZIP5QcNfuTU8
   3x94YIS1bLKfuIK28k0y4oR56wOx7wh/qjqlwMHypaDuo9+j/VoutEH5G
   /iMikXmhn7ffGEyabFOV8hRiBZh6Bq/RzcA2uUl9nb3WDI+jqh0UvdgGM
   a2Uehz9x7AsVE+mFFIJ86Zj+X0jLvcEvmq2ThzSSXQdXc9UnuNhar7lh8
   fKzrDf/uUtL1ZCfiAi1Gacn3rbdf8z/shMmJeOhIdjIZsXuUxC9emFYCY
   KOHLQ+hn3E3EWa9usj8kPZJAALeCOPsY6JSK70vf4k+iyCZD4CtqqzFK9
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10401"; a="264075722"
X-IronPort-AV: E=Sophos;i="5.92,255,1650956400"; 
   d="scan'208";a="264075722"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2022 07:51:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,255,1650956400"; 
   d="scan'208";a="594140770"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga002.jf.intel.com with ESMTP; 08 Jul 2022 07:51:12 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 8 Jul 2022 07:51:11 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 8 Jul 2022 07:51:11 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Fri, 8 Jul 2022 07:51:11 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.46) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Fri, 8 Jul 2022 07:51:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EaJCKmpNlaj3Ge0/YJ0lRdaDvfPlhbQ8tusmX2EE2pxP2a34aAzCZo5mm07f32zvDeC0f9hi86Mp22phzcLR+JswbM1PG950as0bjafDXlKIazXsoushCfWY+Cny90kz4XuuBOFQoWwv8zg0Ry4CKNq9kJBXrvxKCVGxhhP4HGyYWPxzcjXFEhNa+e25tMfI4wGmQ2eFIcE11CTM+r/no6cWQo1G0sdnhBamZEU7jm0m4ZVRG+KyEW/sVDyoEXyi5JtjkB0IZz++Pxe7A6rg2uqtdWbzYNJrXv06PQtfq8Tdolv2CWjmrYavZSVfIEyZdFqOAZiAfDGA2pwSd6DSZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JobEICHC59j7GXEwgD9kf15xHqTG6jvrmt9hWwYxs5w=;
 b=djVttb/0CCPI8duENC2WZEO1gsZKJF6NUu9jYM+MbEVotkG7fT9UaGnusoTuNvLbVKCcUj4ExMlZccOlktOPb7uBibAjUzNVin2xG0xAPgntWeZENpxMmA6yHd1Scu1b0TVsIYKftXyA8Q18mc09+CGaM58M6mD7AsyI9uPaHQzPo0l0wtDZqDYvRH5I0QaXG3V7bH+Yks2BwF2luC6agE4wTyRgtUEKTwdm++eg7qX4NGJNg6hAf7G0fwJkZlBVu2ORrNr1SdUA/q+Bn3aZvEeuaHUSFRi8B0PM44GbudYrd9Fp2yPfr3atfSEDp4kmOJTsXbCuhMp9522tcrUjrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6311.namprd11.prod.outlook.com (2603:10b6:8:a6::21) by
 MN2PR11MB3694.namprd11.prod.outlook.com (2603:10b6:208:f7::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5395.15; Fri, 8 Jul 2022 14:51:09 +0000
Received: from DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::f188:57e2:349e:51da]) by DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::f188:57e2:349e:51da%9]) with mapi id 15.20.5417.020; Fri, 8 Jul 2022
 14:51:09 +0000
Date:   Fri, 8 Jul 2022 07:51:01 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC PATCH 1/3] xarray: Introduce devm_xa_init()
Message-ID: <YshEVcY7Le/Y6TR1@iweiny-desk3>
References: <20220705232159.2218958-2-ira.weiny@intel.com>
 <20220707161047.GA307158@bhelgaas>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220707161047.GA307158@bhelgaas>
X-ClientProxiedBy: BYAPR08CA0072.namprd08.prod.outlook.com
 (2603:10b6:a03:117::49) To DM4PR11MB6311.namprd11.prod.outlook.com
 (2603:10b6:8:a6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c6bbb08a-6d2d-43d2-c9d7-08da60f14b06
X-MS-TrafficTypeDiagnostic: MN2PR11MB3694:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZCwcc6aTNNlsLJr+GB2hMQAsF/9/efHLJd+5gO9MN1SF49sQNPxenJrwLHSiCLdDVjXA3rdJIsk5BI5i8unlbsWUympz1lqgTzyJVX2B4FIbzHaU99u3ecGISTda7MPPgMAVCsXgIChmD/AVnkaaI2nqSBBf0MrnWGYz/0kgTbGcYYhG0s1cmvNtB8TEb4UeN9oUXmGYoSrEMJHS9BLFYVEz4X/y6rH1M/8n6foWyjLFf8IOGmdP/x2NisSkAsfvWA0xuJko0L7EOUL0Ycl32W3zduTVyAM4hj+rw7jhz4YAry/J7PDByQ3RAoclecWiNK9eAB0BIlJ/r8VQWNE1YI+5CD9hP7kqy4r0fEJKXMGArOIS5lpiUhLdSeSngZTWjf3mvJe7EGiwZEpghhPjCZEbOeIXwXVZJAGn0Cqi1Mpxo0eci+TWOLhnBhysU1Y+fjwB8zDPEaINsA7LBayjqCDxy3TBy3Kp46UVofNVBQS25pPPD/xASt6S179YKmUPD/VGZRVJsYwKIS4Zmv6Nph6L22/4t84SOazsMuJTtxrsnxKnDrxXAubQNY2HTkA8gGkBqYQ8lw0NH+nC0c6heP9e/RCzigAMjqoPIW/WqW8sCKs991ubGXWJ1yhkUMFwZgFwIe25f515njTlanpSfiWKkjSutf9Ij1YIm3Lm4VTY+yITBox3/AaWTD18PPdSus7UOXqH4GCsiAlW04l7GGEalVCt60Vd7JfWlsQlGyw6BVKux7AxIG9QtKZQ4QKRDtjeOgAdGdMfLJmUpbKZog==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6311.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(346002)(376002)(396003)(39860400002)(136003)(366004)(6916009)(66946007)(4326008)(478600001)(66476007)(6512007)(54906003)(41300700001)(6666004)(6486002)(66556008)(8676002)(44832011)(82960400001)(38100700002)(8936002)(2906002)(316002)(33716001)(6506007)(9686003)(186003)(5660300002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?V7OiArv+B1TAA1LvNFD6Fh5EmLBEM9Ri0SundKCTk6RLXIi5Cd/Wexxmqa/0?=
 =?us-ascii?Q?HsoYbUKlgQ0QEKQmT8noZTUJAHKhEnE7Qd41e02DrAWs2HRm7PdlhTer7uWr?=
 =?us-ascii?Q?yDZ53u54FsvmNBSc0FMi1VZvLs0BuJocqj+Z7vnAQupyY7qevRs4dehvgtES?=
 =?us-ascii?Q?6B9hu4qlvNpGXsgWJSlnOnnHleakmzwAvXXc7pUJdn3xCuFeBtoV099c9Ri7?=
 =?us-ascii?Q?gRuZjzwMKB51wyzQa37tFLlctYlhCu61ATFDImy8eu9716JLZEozc10NfGgD?=
 =?us-ascii?Q?ueqs691pZ2VvaHQ53OurxRJZa8ELAGdhQZ0CPom9ot9LEeRc2/2QhJsw7awg?=
 =?us-ascii?Q?EHkOzoW/AH1Lk6i8/OPgNyPaZYuSJa7lTGfZcBBGMl8mPqmk2mq6xkFiTgPq?=
 =?us-ascii?Q?ie3llPMdph06doeRttstBM6tH7e0XrYWx7yG+TXgtsGhH0/8OHB3Cx6xhu3C?=
 =?us-ascii?Q?yI5gnF+ARE6moN+lM3EqdcYDUdHMF5O2VFF0xu7zygHWW9sPa8xN5jF/i9XL?=
 =?us-ascii?Q?hYpxo9x4MkYEPgvTgPFZOOTuBYuZkiwSoJBoULklLpZki55lN3fvWlYZZGEX?=
 =?us-ascii?Q?OakEAOgC8JArUAFh2oZXf7R3RpCQtowpz/2XN1N6JEDFNRFHvZ35Vhs12WNp?=
 =?us-ascii?Q?UfoWw8ij8PudwzL4tQpti/0C2Co7vDDa4lChKWhKS+oqEK5m6UtjFI4HGjys?=
 =?us-ascii?Q?WDZDiCfe4MHt4jczdM5BZGaNG08WZ087hQ6x1RgtAydednJRDRm8YnlvZpZ8?=
 =?us-ascii?Q?NNjLLWLQM0s0phpdv6+T9u8jMfn7SMzcJTpO68Bgn4+DJO4O6kkF4kG9uIOh?=
 =?us-ascii?Q?aMQbpA/hiVsbbu4kQG5ICqTtkO0Pu5cO+SluZow6LyiyzXl9hDuuPFf9OqUM?=
 =?us-ascii?Q?b3uAj8Ew1fHA0P32Riv5q+JsQMEMU0TNxKoy3CqdTJAT9WPD/WQP/LC9VRCw?=
 =?us-ascii?Q?HGIGYAQUGCfxTcJFFX9M6F0S6kWgJo6mKUA6qAp8QxxDFx+Rn+A2XfOcApLe?=
 =?us-ascii?Q?1fWnVAJT2GEbJEX1PHe3bgkofJFMcQS/8tftUZUJFYvOF3CyV7SF2kVN3wU5?=
 =?us-ascii?Q?mz7CKAQAY+J6uC6gkt67JydO39M5BbcjFOrv0AztqeinErrlG4pb0GuwIXGj?=
 =?us-ascii?Q?QYQH2gx8jy7+36/T0eTiFp74LTlULLewR2rXj8Ve+5uLAR9IZaQY5ynBH45M?=
 =?us-ascii?Q?9Vd4IlNNrpHRv4BIN+9R2Hg3+ARlYfe8Si9mKLcnwdGfFuZ9yOnnbkwuW1Ho?=
 =?us-ascii?Q?16MUnkdhlQugZaSKgjNVSTAFsJoQVWxw1FuLgWNV7gXG7BKDj7N5jHNb0aa9?=
 =?us-ascii?Q?dlQWZxE1OZnpAy/sKSZkjnci8MVApvalFaNBGM/nWLN2VpAUTAnpEEmRq5Xx?=
 =?us-ascii?Q?WTems9cJ2hwmCZWRGMN/JDzywEmzaAtMLTNhT4dTCAIu+Q6O1KhckMGHjmn9?=
 =?us-ascii?Q?z6fbcmYzEIzPya6LnvvIWbZVgV7g6uZC8ksiO/wNLAR1y6gzA3bvEbIfD/Yx?=
 =?us-ascii?Q?MX7Yrq4luHNv+N5Hym/ZKxi0PWFD/KH3+XkFzIpxRT7hl/hfVWSsCh99fWVE?=
 =?us-ascii?Q?rV3LTmq0ONSBqL8TTbNDGX9b3416Uw+kd5RmZW42x7pFkgmtR6CnBrsfndtp?=
 =?us-ascii?Q?v4GIsOWqkPy4Q7dK3VnREpW6RFUYCReGAp2fcStYud8f?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c6bbb08a-6d2d-43d2-c9d7-08da60f14b06
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6311.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2022 14:51:08.9717
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GYOipfK3P6qa4vaifmkCOQx4wy0Rmz+J7AiClakcPPstqySTPFceMwxhhYuLc3T3lX8sp7AuMmxyT2nh4b/FZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3694
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 07, 2022 at 11:10:47AM -0500, Bjorn Helgaas wrote:
> On Tue, Jul 05, 2022 at 04:21:57PM -0700, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > Many devices may have arrays of resources which are allocated with
> > device managed functions.  The objects referenced by the XArray are
> > therefore automatically destroyed without the need for the XArray.
> 
> "... without the need for the XArray" seems like it's missing
> something.
> 
> Should this say something like "... without the need for destroying
> them in the XArray destroy action"?

Yes that is true.  But what I was trying to say was that the objects have a
built in alias in the device managed infrastructure which will be used to free
that memory.  So the pointers stored in the XArray are not needed to destroy
them directly; for example by iterating through them with xa_for_each().

Thus the "without the need for the XArray".  I'll try and clarify more for V1.

So far it does not seem like there is any opposition to this but I'll give it a
few more days for anyone to object.

Ira

> 
> > Introduce devm_xa_init() which takes care of the destruction of the
> > XArray meta data automatically as well.
> > 
> > Cc: Dan Williams <dan.j.williams@intel.com>
> > Cc: Matthew Wilcox <willy@infradead.org>
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > 
> > ---
> > The main issue I see with this is defining devm_xa_init() in device.h.
> > This makes sense because a device is required to use the call.  However,
> > I'm worried about if users will find the call there vs including it in
> > xarray.h?
> > ---
> >  drivers/base/core.c    | 20 ++++++++++++++++++++
> >  include/linux/device.h |  3 +++
> >  2 files changed, 23 insertions(+)
> > 
> > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > index 2eede2ec3d64..8c5c20a62744 100644
> > --- a/drivers/base/core.c
> > +++ b/drivers/base/core.c
> > @@ -2609,6 +2609,26 @@ void devm_device_remove_groups(struct device *dev,
> >  }
> >  EXPORT_SYMBOL_GPL(devm_device_remove_groups);
> >  
> > +static void xa_destroy_cb(void *xa)
> > +{
> > +	xa_destroy(xa);
> > +}
> > +
> > +/**
> > + * devm_xa_init() - Device managed initialization of an empty XArray
> > + * @dev: The device this xarray is associated with
> > + * @xa: XArray
> > + *
> > + * Context: Any context
> > + * Returns: 0 on success, -errno if the action fails to be set
> > + */
> > +int devm_xa_init(struct device *dev, struct xarray *xa)
> > +{
> > +	xa_init(xa);
> > +	return devm_add_action(dev, xa_destroy_cb, xa);
> > +}
> > +EXPORT_SYMBOL(devm_xa_init);
> > +
> >  static int device_add_attrs(struct device *dev)
> >  {
> >  	struct class *class = dev->class;
> > diff --git a/include/linux/device.h b/include/linux/device.h
> > index 073f1b0126ac..e06dc63e375b 100644
> > --- a/include/linux/device.h
> > +++ b/include/linux/device.h
> > @@ -27,6 +27,7 @@
> >  #include <linux/uidgid.h>
> >  #include <linux/gfp.h>
> >  #include <linux/overflow.h>
> > +#include <linux/xarray.h>
> >  #include <linux/device/bus.h>
> >  #include <linux/device/class.h>
> >  #include <linux/device/driver.h>
> > @@ -978,6 +979,8 @@ int __must_check devm_device_add_group(struct device *dev,
> >  void devm_device_remove_group(struct device *dev,
> >  			      const struct attribute_group *grp);
> >  
> > +int devm_xa_init(struct device *dev, struct xarray *xa);
> > +
> >  /*
> >   * Platform "fixup" functions - allow the platform to have their say
> >   * about devices and actions that the general device layer doesn't
> > -- 
> > 2.35.3
> > 
