Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78F9B56BC0C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Jul 2022 17:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238696AbiGHO7e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Jul 2022 10:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238300AbiGHO7d (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Jul 2022 10:59:33 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A19CE222A6;
        Fri,  8 Jul 2022 07:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657292372; x=1688828372;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=E/H562D3QhBhUJ+HMoF5eoxUW2k/gtNocdrczIt9hFw=;
  b=JyCmhg7xqdhVPedczckJlx6Td9esEUJ7cW8MvPkA8XuUA5XDUx9IXs8c
   EqiLrWQMv8yF3genwct075IvguJp7cW2sxk2r2EPhQa7sfCfNjSkq4doI
   Cac4NUNv+5taBo7JgcW4QqaAu0PYUegdjBPL3ya0rGm6z875hgDwsHZAR
   UeaUAWY52pX5rG9aRSUiOCR5hykYVq078/KVimAyvhrJy82l6sOKKbPCY
   WNZ3wkk7weFVRRRsepMxrh46gDIC6+18dVIMMJM7kVyAn8l7NTWg6CBUV
   7aNH18k2/9HZQSddrudLGLlqS+ddwrUQ2ZYlo218AASIyqyXZcnaSxJd7
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10401"; a="348281348"
X-IronPort-AV: E=Sophos;i="5.92,255,1650956400"; 
   d="scan'208";a="348281348"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2022 07:59:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,255,1650956400"; 
   d="scan'208";a="594142670"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga002.jf.intel.com with ESMTP; 08 Jul 2022 07:59:31 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 8 Jul 2022 07:59:31 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 8 Jul 2022 07:59:30 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Fri, 8 Jul 2022 07:59:30 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.43) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Fri, 8 Jul 2022 07:59:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MS9T9DMdlzirZtUTAvJazMLAaoWXwrl0d0e6srzvg+hD0brgS9NNQevmsTWP0P2bsCrDh04xd3MyrglzlNKVBh6EhnudYRLADMac7DEP9vcJMxBhnD2b2v73eOOmeWcOB0udhSP6euEJ1vrEwSquDtBhTBJRO9jRkEPGU4ppN9wFPUuTB8RWtt6+cgmiRcrEorT2QAgQzftJRRA5+SOD9FU6dh6m1clqKG2Fs4p43uySZ+rrFSE9jjYVuJ4THn2affliMD0HRJFtbK9UHtywp4jPBkihP0B1IHZleTT8r0mn8agpWZy3lmGPVD72CKEGGyGUGM1pz3Vvx0GSoMus0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kApPxoeEfymezVZwW1KGxfpOWKZMw7opwy+3J9Bu0vM=;
 b=Rj0qsyh11Nv5NgEnl1PGxArSYTIMzY3QmkrUtG6NtEhmxvwEDYMws/eU5qRBl/D9qYM97wgJiqcdKMS5gL8eO7nsoE4S4Wxae3VuohCgriBQZzPw7l4zZwdRzpGk+U/fU0hzbDtKYhYwuC2ms8ch1Lk1gdmIeP/iHvfdSswsZhM5IMeRSFZGnPV0GYEzXukgsFKE5/TXi9iEqjD7amCdEnT9M1DWeuDB+5RzHO2jOP+T8wmY45zYjwji0uRUX5WT5NgjN3nO6snGNvOW4dM0ksrW01WH7xzcz6fveQQXLsF1Bx8JmpfdMo+Uq3TS8aEnwd3qlQA/e9lwHv2vGydeeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6311.namprd11.prod.outlook.com (2603:10b6:8:a6::21) by
 BL1PR11MB5383.namprd11.prod.outlook.com (2603:10b6:208:318::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Fri, 8 Jul
 2022 14:59:28 +0000
Received: from DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::f188:57e2:349e:51da]) by DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::f188:57e2:349e:51da%9]) with mapi id 15.20.5417.020; Fri, 8 Jul 2022
 14:59:28 +0000
Date:   Fri, 8 Jul 2022 07:59:22 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC PATCH 1/3] xarray: Introduce devm_xa_init()
Message-ID: <YshGSgHiAiu9QwiZ@iweiny-desk3>
References: <20220705232159.2218958-1-ira.weiny@intel.com>
 <20220705232159.2218958-2-ira.weiny@intel.com>
 <YshE/pwSUBPAeybU@casper.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YshE/pwSUBPAeybU@casper.infradead.org>
X-ClientProxiedBy: SJ0PR13CA0110.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::25) To DM4PR11MB6311.namprd11.prod.outlook.com
 (2603:10b6:8:a6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fd1dd41e-2214-4256-53f0-08da60f274b9
X-MS-TrafficTypeDiagnostic: BL1PR11MB5383:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2FBMT5oI0UzfhKquHBl0zfbx1VdAPFgqJ5AjvRDOtwpnYszWv+WsEUwO8vbxrfXBSJDB/rxtWo0SvUxIZ3MdlmRYRG0fFwxiDzjkiaxgDbPNWbiTL/Nd2+Bdgk5Mj7pKGoE/Dph0BlXFCoVqfRVDSDZH3f89+/ZW5BY74XgRj94LZmtX+oeg5vVBs/WL/39dXj54XqPB/xjYADSvEhbDc1sRk1lwi/gAEonMl+jBZj7dQfmiNKt5TFnS1VpUPJ1cOyz9FrAbl2VC6CVkIJGa3W8R6ffWXzGOeZLzxTMSt5u5cyNMMbmMz6vcBuddwGj1eM1FF899MgKyuZuaMV9Y2/d3y8LXPbtrHPPf5ZS0TxV7CzAXw5Q5xr6Sv1hRfI+bWbYgIZaO7rAriTr5XbxqlHD4I9yphkfwAw8NKTgQYB4g/D14Fk0zhnQFxvj50IS0aUgK3n8YFDYBbYTizndJrhTynfEleiXqyuvnYotRB6LBUSkgbRw3hIj5ZBqBBZvKZJxVKU1FCkyN0znelx47cinPR55opWfN2vYsGC0i8DJwTCLnXQQvZ911RCEqlNDQeu52FSdZ/JcqBcHLU675X275GcHzpeLju38C87JNEhrbnfw/Ogkbvs0aQ4o7JzMfFUWnuZDaFqMaRhQSU7POoi3MloN9I8Jva6a8Ad5PZrS2QFCr+ddiRkEZAT5VWW6tW3yUUl0zfAYpX2eWLQfpVdurq5XlSBhjNX6u3geBitApOz0cp/kcpbdrdNavVCWPyOy8qCz3qeWDOzeLRrc9yg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6311.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(136003)(396003)(39860400002)(366004)(346002)(376002)(86362001)(82960400001)(4326008)(8676002)(66476007)(66556008)(66946007)(38100700002)(33716001)(316002)(54906003)(6916009)(44832011)(8936002)(4744005)(186003)(2906002)(6506007)(6486002)(9686003)(478600001)(6512007)(41300700001)(6666004)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RSUuWlU9AgLx24MNqBl7GBgA3vuMpJ8qkL8Qk4E5kNR5BNz/Cxy7hQEkXMVK?=
 =?us-ascii?Q?O0em21APNEyvTFEvht6gCSI1v8El30MeywMAsC/Ug2dsM+qDmSkZ274fAzVH?=
 =?us-ascii?Q?CWIXrS3V82ag1pHCIZAjZvyIMoZwFct1ZHzthhdYmurJwT22xs/H+BmsgL+o?=
 =?us-ascii?Q?ADEszjxoY3p/BqbGr8Xj+Pz81J+q3WT2QOe9uE8jNVi2+bbOpbRBPyFHK4ju?=
 =?us-ascii?Q?HCHZlAZYH2RyFqtAp3Od4dB1XMru0J4mnIDPhve117r0eCdW2wlUN8xebVCp?=
 =?us-ascii?Q?HhmG5YxijDJGMWpYRbrzvPsl/X6JIwwescwMHMIKbfcAU2AtAKzOcSZAZ89b?=
 =?us-ascii?Q?bifO+4XvEX1X9juG4OOAm8KqNKsUH/ZRYhb8c6XOCMd+vvjc+IzpiG5D835y?=
 =?us-ascii?Q?Fdq1ngWs32+BpSTHJZbGXtAa0obGSHX8lTK4b8+nQP4b/rByRehlxLt+s+8N?=
 =?us-ascii?Q?EPF30rR2Cgu8vTAVPCcg2P2sunITT6ZxLLiHQ36puO1uh6tPwxCtzrsLs+vB?=
 =?us-ascii?Q?JgPZUJx4dS/18c9hqONktEISxNf/1zD1twieZ2GjHfWRNx8ndzXGmwe7mrPw?=
 =?us-ascii?Q?2NojpajuJPsFFAJ13ynZZKpsu3aAY9Zm1a8OpBGnJfuUvpCOvyHSpoTsbyVy?=
 =?us-ascii?Q?cZJF9FNwtvK7blQdjgh8oiq6K1ggC/eIdelILzRp8NrIi6S82yw892Xo24FX?=
 =?us-ascii?Q?7txP8fMtRCDZV/igCmeixv//vxWLy0dr9k2+0Qnr4E3/sd4gnHsLC4uayyx/?=
 =?us-ascii?Q?NPa3q0jL28NT9FSSuZTXHA8g+I7zrgGEX4j40aokC1bhys5NRj+EnRcgQauV?=
 =?us-ascii?Q?rpSRNtzk1EWVzhc3415/8Qa7hCco3Vgpx3ThXsgQRhRjMK9SYimRX+1DX4Ls?=
 =?us-ascii?Q?9grak9+c17sJqm2tKrse4hBTzysjx81/MddIf6xd4E7mKMOLp3O0M1qzSjlu?=
 =?us-ascii?Q?HxeYIeNB4nbV1fWJtAwAtPWUFi/qK4agZsJ59gRYKXWy/sSdAj/1uRS0+bA7?=
 =?us-ascii?Q?VkhXb7bn031LGdzCGn0kngTBd3RBS27hPrr/0U6+KgjaDuwUM1lYdK8VLqyZ?=
 =?us-ascii?Q?hdESV31B35QSxDGeilnH6lsJtIDWl4adLUOgRrKKpzbK6VHZumrHpZqIEVLU?=
 =?us-ascii?Q?gcyz42As//atjglsIFxYlfxIDF/cjpwYWWJFyOMZ329GlJfp9Y77MVXzJQIl?=
 =?us-ascii?Q?bal0ACUaOSm+9z5hoNd7JCBM396IER5wkgbJS73s4HX6W8XSrtCFz8tx0QBl?=
 =?us-ascii?Q?eqUP3xNi/Y4W6bNYbSmoHvS83PhXbW8KWpyAmTXAYexy1qtNJPvOQyIzS6rE?=
 =?us-ascii?Q?8jvtu4YnHlc/EEFGwv0yi4ZbhTRFkyy6rUSGNoTn2aum/GdjByFYAuNRJwlx?=
 =?us-ascii?Q?42lYyXifdH47d5X/ILA6a58TSk+oVACEc/u6FWzWe2LcG2awRyPh7bOYS+Yh?=
 =?us-ascii?Q?3/oaIO3EWV28bN90fp/jOlbwvHGqRVBxNVDUR7ktoHdWCeUYB8kHpidqk6dt?=
 =?us-ascii?Q?BElx9D6dmfWSiN5wo6iwCR7ky7VKomxXLyOS3AgtPAregpbicTNFFg96r5KV?=
 =?us-ascii?Q?p4EDAihOtksI87TfWCUbDttfy3uScFDuiBjr57jeo7gRPqL2FTNGYRslRjtT?=
 =?us-ascii?Q?Hv8MvquLdFba0w5B70no4KHLR7U8+URDmvkTAhXK+VIp?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fd1dd41e-2214-4256-53f0-08da60f274b9
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6311.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2022 14:59:28.4094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5w1mXOTjpceWkg0bBCVf7wBpPR1PKt4+t8DdeZGzi5lTHJAXyrYU6BTwr7D3BpDB+2AjQcQ2N1kbBuT6ujJu8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5383
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

On Fri, Jul 08, 2022 at 03:53:50PM +0100, Matthew Wilcox wrote:
> On Tue, Jul 05, 2022 at 04:21:57PM -0700, ira.weiny@intel.com wrote:
> > The main issue I see with this is defining devm_xa_init() in device.h.
> > This makes sense because a device is required to use the call.  However,
> > I'm worried about if users will find the call there vs including it in
> > xarray.h?
> 
> Honestly, I don't want users to find it.  This only makes sense if you're
> already bought in to the devm cult.  I worry people will think that
> they don't need to do anything else; that everything will be magically
> freed for them, and we'll leak the objects pointed to from the xarray.
> I don't even like having xa_destroy() in the API, because of exactly this.
> 

Fair enough.  Are you ok with the concept though?

Ira
