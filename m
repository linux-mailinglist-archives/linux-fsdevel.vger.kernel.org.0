Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B766256BCC7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Jul 2022 17:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238775AbiGHO51 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Jul 2022 10:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238715AbiGHO5V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Jul 2022 10:57:21 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A68222E6A6;
        Fri,  8 Jul 2022 07:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657292240; x=1688828240;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=BlCbNv//G5wonEjuFEOr9LXu9pG6cHzidLkXdoEBXoM=;
  b=HBCkiGkg4DjOYKpLTz7I3Q4FI2zZC4RsnSvzvtQPoGnRpV1HK41qsGJM
   2D18FaqenrH8vX9CYiriJFMnyGBkB3ESAnzL3kyBYsNe6UDH/dtJf/7qv
   DVOrIw6METiu2eOi9Vacl5HgxNGCeP3m3LdxI9UzZK0jgc8ijCA0yYV4m
   j/dqY2mtYo9cmHkaiRNp8Tj/P0+Ofy4gfSkyu915dAXCAAzGWGw0j2hEK
   6VPG1cB8gRZjDlVgu623C/n+ojwyqhESZ4ShEg7xwY7M0kq+eC1BEgs9K
   zaDMmtuzNDWcSEFerz3tS/olGMFMHdbp69/Yttw/ysIhRD0Pys4BcPHR4
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10401"; a="264710018"
X-IronPort-AV: E=Sophos;i="5.92,255,1650956400"; 
   d="scan'208";a="264710018"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2022 07:57:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,255,1650956400"; 
   d="scan'208";a="591586727"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga007.jf.intel.com with ESMTP; 08 Jul 2022 07:57:19 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 8 Jul 2022 07:57:19 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 8 Jul 2022 07:57:18 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Fri, 8 Jul 2022 07:57:18 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Fri, 8 Jul 2022 07:57:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UXgXkAkoTagiCzJDWVH5KGfgSBYOChAFFI9ZLlD3EMMxtiJ8Zx0K2mdSsOzANZ682WxG+vLxBizSgbYcIuat/lrAMfAELNncEimU9YNE1ewkJ+WQixIVf1f8Yr4fGZqb5mpUpkNQyXvV+e0PQF/BhVG9osQWuObft3w0rS9VgYw+XkiyP/dOuqI34sdLnKCAdAF5n8R7mJhGIvwPHemZbEdLmj0Pu8/UwYp/6vQsIK4BmPJu1bKoRnflPAT9UJfnh7Av1pIBFcr/w68ouYAXcXfVpsm0mJQMZdMURx+8OAS8VQiclUzZFiO1R0yefoDKOap9HVjHDYc+K2DuXJo1Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ya9jEp7f9EOdLJa0HPoaWIuX1K4a0NAC+Ea04bEV8cg=;
 b=Ol73mwOaBaUZZbrswLXqqxl9LSsnqCR+w0FsfpyivbPnYZ9eqT2RqOHzr79o1dZBJdKPtS9XO7EQ++dcVJ3S+fHM3aLMHqktC7TBBLSJ3oUGJFevkwt41UKRg665CgZwomAmXoDgNklQw2CTHnABiIjofPoPkY29HsVpoEY7fIR3jI2SyEczs73kOdx72hhbE61uBtqCfueUUNdMNo8drSNZ//sjzPg9maJitOWG5q9PY+DpV/gwqUwZ06jgrFqJMHFm8o4H5frvxaj8eDYL1WdvcKWNvYKHIkZa+b3U+zxY/VbBF/MzbMvBtrv90jTtfM4W2N2aim42vTWAarTWrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6311.namprd11.prod.outlook.com (2603:10b6:8:a6::21) by
 BN6PR11MB1458.namprd11.prod.outlook.com (2603:10b6:405:d::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5417.15; Fri, 8 Jul 2022 14:57:16 +0000
Received: from DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::f188:57e2:349e:51da]) by DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::f188:57e2:349e:51da%9]) with mapi id 15.20.5417.020; Fri, 8 Jul 2022
 14:57:16 +0000
Date:   Fri, 8 Jul 2022 07:57:10 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     Bjorn Helgaas <helgaas@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC PATCH 2/3] pci/doe: Use devm_xa_init()
Message-ID: <YshFxnBZGUPN5LoC@iweiny-desk3>
References: <20220705232159.2218958-3-ira.weiny@intel.com>
 <20220707160646.GA306751@bhelgaas>
 <YshC+Jaua01dPQak@iweiny-desk3>
 <YshED+nm7LdcmL75@casper.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YshED+nm7LdcmL75@casper.infradead.org>
X-ClientProxiedBy: BYAPR08CA0064.namprd08.prod.outlook.com
 (2603:10b6:a03:117::41) To DM4PR11MB6311.namprd11.prod.outlook.com
 (2603:10b6:8:a6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f3a35f9d-3a59-4eac-9b36-08da60f22639
X-MS-TrafficTypeDiagnostic: BN6PR11MB1458:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CKLfRgszjyfqh5vviIvybfguuN6cqXHVjtAgNhZNwSYQSIWUwTOoElwDHXK+xAd4FH920mE8uYwlijhO9NoXMCUcBQYD8WpXqFrcRlGiQrtnh/8d0qy1M9qCPv61Obkd6B+wh4FvwsZrA3keqx5mseYf9wYNZ4ud5qd03DO0wrz+tqzkVlnoxTfFXmUiLdcULcuXRMk8At17lb/hrPGw+Zz81XpPQAGIYoRarsr78+RGkQR7AyHauoTWSl2J6M46Nb1pnUC0DURz++Vri+0JNzGYhuttouwF3jH2irQTmFrwTQxPygLXHNztAodMedaiiF5iplTcmYmEG7I+9E3jBoa9AJcexAqX7lemo3RIYU6F4kF8vW4Z4c9CXhfvFOt5+Oe0GmfadIZfjSqgJsgB4CgdMt7EqtH0oSTHE2YXsmTQjMQfnTkc6rRBB6GPlMtMNB2DcnlroR+k92fZUB6ywRfzMp5nyNZFCMsBgAVaEwf6WGbn/1unmMBAd9n94cctBomdQhZREgTezaqhKHzKZn9202OyZs17PS8zVTcqqdxLZOMZyhegDOBZP2beWMhe/rWjsB3C5/tj68v8SYnmDx8Dn6ggne0SqVBXMJTykikrw2PFdWT3ZF00BMUSCFkWf9JAtU3jW28J+bonl8GVGA7mG0BPfQC5EQHsZImmZlOEJkMJVxNCtqzzEa4GaH8kArJYZ4kC1cTUK3bJNr70cJEtqSO/Pe6GpTXEqUe4gPKWvdM63xRon1FmcjTZUkeQ7ePBLSqj1fRKoVxudWxdJAyFL4xY4xpPBDW068e0zOWJGCDp0Uo/MIAOQsJPwGVd7IpWyhfsKtZWqj091wWregB29v02B2O8lSYv9G4LQ5pxM9+c7c8jes+LF5yAowOL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6311.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(396003)(346002)(136003)(376002)(366004)(39860400002)(66556008)(83380400001)(82960400001)(66476007)(86362001)(186003)(9686003)(966005)(38100700002)(8676002)(316002)(478600001)(8936002)(44832011)(5660300002)(2906002)(54906003)(6916009)(6486002)(6512007)(4326008)(41300700001)(6506007)(33716001)(66946007)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oU/UQDeLsKgI0dGHeuX0JknQXz/qNHRPQD4ueW0vsodDd3VaiI+CsLcSmkIC?=
 =?us-ascii?Q?+cjkUxEKkivGeZp4s0NWnneIhsoZimMZilyYrRUVSg7gRrN9zjYasjUr9dvD?=
 =?us-ascii?Q?NzuzTtWvdNVUBYGdwdiu14k8MTbDm6+NwtJFZuY68Af5d6aoSHKd7x7FQ4h1?=
 =?us-ascii?Q?BvB92EJ1QYZBt2DX2VN+i61+AALHFDArdIh1nW1tvLcH2wBnN0u6s9GhJx3z?=
 =?us-ascii?Q?EpAtGKjcUNQpMIV9jNElJ7JAJYH+2OAP3h1Mzt7V755EIufEpY0zh2PGDB3R?=
 =?us-ascii?Q?DBYC0zJYzFQApb7rCLOC3SlMO3sAYZ7TauuWS8tFYIHlXp2wjnbg9ATsowLV?=
 =?us-ascii?Q?k9WUI+AP+44OGycPwSfYQi0DfBRk2FgpPbFxDKe32P7zOPDDsNVJOUvVV0+7?=
 =?us-ascii?Q?f/nG+798feYqKaO1ZeWrwQYLzHG6Dh1OZMCfP0VQRetv4y/1q07nWyX+sIXC?=
 =?us-ascii?Q?/kpSDm9lxjYQ0XRIKqQzUKR+vmDAAyhip6MKvgeYRjEB0gCuiLI9kAQ1qJKo?=
 =?us-ascii?Q?Xg8GjfKNLUglPy33VSnDEqHW/CVIyuKRi4ZdYROZgMy7i6DFw7NzLoxw5XQI?=
 =?us-ascii?Q?8Wjif8xZR4OeneVBL6b8DIet43A/bLeCmtg2nQcsXd55tpqsq89OxKuD5uPj?=
 =?us-ascii?Q?5sgxYV3lPffPsHRe7eaZ8NeFRzgR4dpo07sMGjq+bhbtR3bK0ZC2cyFTHyhd?=
 =?us-ascii?Q?XtPZC26F6TaCu44JVEPjp/ZQaQ1qoNEL1iVN8mBWVOXzTeOTpyy7FnlnnjBt?=
 =?us-ascii?Q?wXTGGEkUtL5xw4phlaXEKfipdJhuP9BOxD0Skykgg9L0A/KCGu25FQaYf6mt?=
 =?us-ascii?Q?0RAV2IrsMnworfKEELGagrOz/3nXnfwfeKfKErECf1Cx9m39rX/RmZw5jqI9?=
 =?us-ascii?Q?OIYHNJYWtFcpJTGIRZrzJVn0B83BY3X9kx3Ha1fHZBlcAQr4GK7zs4prTRd0?=
 =?us-ascii?Q?5EXPp7FzE6dHBNxbjAzCFzb8dbV+f5L2DtzXgOV9ZfFcoq+zMBmByzVFIgEQ?=
 =?us-ascii?Q?vn4NfDKYLEyyq9Kzu3+/RqhuirF/miZdbI0eoB8l8SxJtyZkxcMNwEmHiXHo?=
 =?us-ascii?Q?ynBjMGq1ol4pxmY74lVcAbxUSPav57KYXYFP/0b+U+Z+lM4WtNjFUQGY0qpO?=
 =?us-ascii?Q?XE6N3UUEdSxoVfqiZx3fFENiPPAGOXOWEkuFc3Q/7uOxPAhhI4pa8HzIHOGs?=
 =?us-ascii?Q?2mJPPS2ndGb/XH+zFWI5mbZCuwzQnHabUX51Bsdy7VFdGLez5XgtZF8/Mm9U?=
 =?us-ascii?Q?l0dN0sRfHq6TLyJ0xzBdxS5ua5aeIfEh6WfM0OF/K/lEwPFqAKxlNgrqSz4B?=
 =?us-ascii?Q?xYz7UBOM3h2EmBLJDwgS+HSy8CmXVt3yQOP90ROw6XvPT1On/vUdGJZAbzqE?=
 =?us-ascii?Q?o/JTMwOxHrF3VXo3kMH0bz8PXUjBwEXie7Du0GI4kxDEfNS2NSIr8P5Xdz3O?=
 =?us-ascii?Q?rXgEGrVrHiKvYpj2LHzHh0hanG4dZyCxGk1TjCM2tPtKodhNcPsDXEnEn1O0?=
 =?us-ascii?Q?8kNatFgvv4WpcYjiqiV6JVltRlqGcgCHE9DOaWUyvKFzImXbAA4xIANHYwGX?=
 =?us-ascii?Q?qIkg90SF2XFBc0yxqsEJV0mJVM74lhoDQRkVyNuSHaop2xlob9GFUzywd0Nk?=
 =?us-ascii?Q?XvK0KM8I50zetUA8iR+XN/6braS85PBgrw16wuhhMFSR?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f3a35f9d-3a59-4eac-9b36-08da60f22639
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6311.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2022 14:57:16.6945
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z6TJl46NPlugqhvfNmW0kili1xWxvtkiGNyWpVNgxSMUU+QACeMGkMmwkzPLJ3JH1BQJ9wuVLnCWzSR14ciGGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1458
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 08, 2022 at 03:49:51PM +0100, Matthew Wilcox wrote:
> On Fri, Jul 08, 2022 at 07:45:12AM -0700, Ira Weiny wrote:
> > On Thu, Jul 07, 2022 at 11:06:46AM -0500, Bjorn Helgaas wrote:
> > > On Tue, Jul 05, 2022 at 04:21:58PM -0700, ira.weiny@intel.com wrote:
> > > > From: Ira Weiny <ira.weiny@intel.com>
> > > > 
> > > > The XArray being used to store the protocols does not even store
> > > > allocated objects.
> > > 
> > > I guess the point is that the doe_mb->prots XArray doesn't reference
> > > any other objects that would need to be freed when destroying
> > > doe_mb->prots?
> > 
> > Yes.
> > 
> > > A few more words here would make the commit log more
> > > useful to non-XArray experts.
> > 
> > I'll update this to be more clear in a V1 if it goes that far.  But to clarify
> > here; the protocol information is a u16 vendor id and u8 protocol number.  So
> > we are able to store that in the unsigned long value that would normally be a
> > pointer to something in the XArray.
> 
> Er.  Signed long.

Sorry I misspoke, xa_mk_value() takes an unsigned long.

> I can't find drivers/pci/doe.c in linux-next, so
> I have no idea if you're doing something wrong.

Sorry doe.c does not exist yet.  I came up with this idea while developing a
CXL series which is still in review.[0]

> But what you said here
> sounds wrong.

:-/

Can't I use xa_mk_value() to store data directly in the entry "pointer"?

From patch 3/9 in that series.[1]

+static void *pci_doe_xa_prot_entry(u16 vid, u8 prot)
+{
+	return xa_mk_value(((unsigned long)vid << 16) | prot);
+}

Both Dan and I thought this was acceptable in XArray?

Ira

[0] https://lore.kernel.org/linux-cxl/20220705154932.2141021-1-ira.weiny@intel.com/
[1] https://lore.kernel.org/linux-cxl/20220705154932.2141021-4-ira.weiny@intel.com/

