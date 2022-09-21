Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A2A95C026B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Sep 2022 17:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231809AbiIUPwa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Sep 2022 11:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiIUPvb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Sep 2022 11:51:31 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 576299CCEE;
        Wed, 21 Sep 2022 08:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663775358; x=1695311358;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=CrBLGfeCiI/VyIA6T5Stp4k3eOKwhB5Y+I3X/dOi7HY=;
  b=T4XAhCmqtJCxEpFZWtMvbMjXWwYpK/TmWUUeKhnidO4Fjz9Sc7JK76/I
   yxtfWSzWk6iR7n5/RSwt2H/cdZFqz2FoA3OGRDlAiZLCMgSYnRBlfmRVd
   yxbPhLvYc5/Yc+5WhlHlFcJugiyNUfzk6rWRkAKibDVcQvdNwBvfrSTdo
   /3JSUbegtDQcAMhb+CKWE9pIDLYHMoMpmMZ8bSQaB0g39sDCNdDCGmtlq
   pBwHFhbGlLYuszAnLNe9L8ImHMde0WFz66kxI0htXdR8SxBCnrk7KIJzc
   LarEFNe73ymctfL/pY0GGHfDccn5axfUOMoUc7DfZxsckkHZNlPSXoTt+
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10477"; a="287114858"
X-IronPort-AV: E=Sophos;i="5.93,333,1654585200"; 
   d="scan'208";a="287114858"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 08:48:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,333,1654585200"; 
   d="scan'208";a="619405380"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga002.jf.intel.com with ESMTP; 21 Sep 2022 08:48:28 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 21 Sep 2022 08:48:28 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 21 Sep 2022 08:48:27 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 21 Sep 2022 08:48:27 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 21 Sep 2022 08:48:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HIr2hcV/9eqMm8JMCDrVO48mKueXwu6jN5X6f4pyACOTYOc5hJQTPlfQzFG9pSd2UbFq/IMXdYRyrO8KbnyfVncVIKh67bj7ObwIqtF5+8yF1ClmLURwK240myQIvjYkaNyvyelQvRR7nkbFeAepzIT1sBymoBordOwS2ARHU19mQ9eqtZo/H+agO5e6k78rstcgYvdPef5YAOGJDGEa6OmoL01M5uShzFeyxtcrFQWgMkPgbeANWEUbMroLSAI/zqQfsIcdFMiTSzCRW8ErgxDY0LllZStLAAOdPwygUaCrWRKQqGuUbgUQJfk+yRRwAmXMJyD6l1ofwRshjCXDkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iVw9YfXiPasIvNAsMtmJHQyY2u3FVNp4EpyzxgG7QmM=;
 b=WMZULLZkiFOgrupd50iCqgmT1A+E19jwme6VNMXFGWh2T5LshhpE1OK+Jlux8vGSW7a+3gElod0asLlhKmYZHak9D07KRBFNdYciu1ag73RdmV5elqCcnixe93aOeJakStLriQaa3PdA8vXaWRfpflvqq9mYRfjaQ5bvy/xjYBlb6bM5CM6et5gkQ4ZRib/6c1JsVBT6eK/dY2Cyazwh5vxZ83JfyNvJKcSoJlsBQN1IGbWp+rdEeKZhRfb4BQwnShxN+bNmeFOgI4szRcvbF4xGfsp3OR5Td97UeTeTw1jDCS9O7RJAhEmE8+Lx6Yj0Vg5swdRgVLEheUjAw9x+dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by BL1PR11MB5956.namprd11.prod.outlook.com
 (2603:10b6:208:387::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.18; Wed, 21 Sep
 2022 15:48:25 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12%6]) with mapi id 15.20.5654.017; Wed, 21 Sep 2022
 15:48:25 +0000
Date:   Wed, 21 Sep 2022 08:48:22 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>,
        "Jan Kara" <jack@suse.cz>, "Darrick J. Wong" <djwong@kernel.org>,
        "Christoph Hellwig" <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        <linux-fsdevel@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <linux-xfs@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH v2 15/18] devdax: Use dax_insert_entry() +
 dax_delete_mapping_entry()
Message-ID: <632b3246548ff_66d1a29431@dwillia2-xfh.jf.intel.com.notmuch>
References: <166329930818.2786261.6086109734008025807.stgit@dwillia2-xfh.jf.intel.com>
 <166329939733.2786261.13946962468817639563.stgit@dwillia2-xfh.jf.intel.com>
 <YysbXPnA3Z6AzWCw@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YysbXPnA3Z6AzWCw@nvidia.com>
X-ClientProxiedBy: BYAPR01CA0026.prod.exchangelabs.com (2603:10b6:a02:80::39)
 To MWHPR1101MB2126.namprd11.prod.outlook.com (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|BL1PR11MB5956:EE_
X-MS-Office365-Filtering-Correlation-Id: 10bf5bf9-15c1-4348-ca1b-08da9be8b838
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7B1EWQC1M5Y1iEXzkVDF6YBjJg6rmU3GYvVOvHu+3s3NJCoRzsnY8w0WLFBuDXFY1mx/vkX9P74icWRCtVu7UbApN6I6ADMjnReDqu3uY8PIEtHVPgafmqAW5XKgcI+KahbcA99K0dP4vjPEvaCh++x4XaydEO5u00YSUlQwRURLuStiYvOodlSCZqRq3EdJ5HPoSS1R4/91BPBX5yXTzV7+Y1JdDveLaN5A6Vr07LbbtTob2fm/Kx524aiJ5UOZ+lb55AC66GZTPgndYBPnUq55jNnPRbAz74lmzrQTMeGHk7nLzBOTuRGtSQ2lPJGx/qrpqLtKtwWBXH/vUYyxBFg/cThwkMwUz4AuqM7+csmbm7++lEdeqWnx+OxAZPvY37ot68v3xkBXUWkEQVeYYxxJS6B8J+3sNWi/8pSwz1gAEBu2biTgpX4U5iAB/IxRNZ8u/U3xzebuQIKIsFd396pDuyOW51JdocbY9FoMt4QqUDHCnb6VbiicoSAcL3v8N2RTaSmOW401UkzR3IZqFOtXMpjGn0TF0azhN3sSXAsuTnf+aEgZ753TPuPWXKyPi8J+Vqc2/dTeHObvPjn6huPpx7G60Ds8xAVUYn986P8iWUXFqE4+0yE2m3C1b9BV8eHymYRJVV5LKYN2PALbIEXUYj9xhv2HxlAbORGg/WO6eY5Gx/JyQwFDChbQ8Ai40IXJt2o7cuhtsUEV+nKZbw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(376002)(136003)(39860400002)(346002)(451199015)(6666004)(6506007)(7416002)(86362001)(6512007)(41300700001)(9686003)(26005)(186003)(82960400001)(478600001)(38100700002)(6486002)(66556008)(5660300002)(66946007)(316002)(8676002)(8936002)(2906002)(4326008)(54906003)(66476007)(83380400001)(110136005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?V/hOwmhHi3v4DuOgodnU7govA71BYACuyb7blXjEvZFejtV+3VdU2jTZ1DA9?=
 =?us-ascii?Q?+V74DXAvCuV/5I66zGvNkyqaO57EDUmEXB5UB2P8hmR5cfW250hPdZN0E3If?=
 =?us-ascii?Q?0LZQy903T0/4qLB8vgovDVtypgT4EcMIEEIGXAMRpZGnT9pfGMzvz/zneAgT?=
 =?us-ascii?Q?duRaO0CSKldb+LL1uKtUM0kvKsegQfCgXB2EIlpXFmJS/QVnx9flkvgqwgBS?=
 =?us-ascii?Q?YiHmNFME/XY9kBkRE5dCzlFXV/TFtM6G1iiRexg3dx5ga0u/ly4088RAT/7J?=
 =?us-ascii?Q?YKX5QgQmtObKqdFInSDa12BL6MHriPAf+j4BCm+jAiT5UMV+H9LEgBv7pvdF?=
 =?us-ascii?Q?ohfqYFF+NJk9T4EsdfgNBiFRodxxg/2ADOvDX1SIxTkFYdL/jeGWzvzkW6Ky?=
 =?us-ascii?Q?RdPgQVei0dGe4YcXILLUUk5I4ns92VZpVpV0oECqa4qQH5Im6qMHOtysd4V9?=
 =?us-ascii?Q?px3h/qSXBshdhbds0ao+sP3Ihhh4+9DxrCqtLZBRURlEfz0Ethi7P1F58myS?=
 =?us-ascii?Q?cnynIieJMoP5fNP5k5aebiIJbR6ksM2TDK7EubXzOq56SxyjaHAzzeB89Ggf?=
 =?us-ascii?Q?TIAFrTZKoJ1dyJNfrDFjo029qwygybNONYhE4UPdgok/uPy5yOJlRBFAlDrX?=
 =?us-ascii?Q?plx0Xu26InD6HLydaaS4YNcK9XhG9w00GEZxBB1mXW7z9W7o9rxmNIx+OhD6?=
 =?us-ascii?Q?lSaBSPrxSBRpIaYBGyuDpzqsUYncp2ojbgqN69gG/3HWBP7l/i//9GhZXdm5?=
 =?us-ascii?Q?hf8UpcGZskXDx0Mb7FbMTrkFzz4D6rL8n/1Md1FMeLYf96K9JLoUy+uNu4pT?=
 =?us-ascii?Q?qj8vLFi7tIn3TYuwQtUf2eeL5UHzBcfItOFndZPQqwL4flMxLrn8mOSj5skm?=
 =?us-ascii?Q?lGFsc7bxwAKYlU4wRwOAhBrP3TpA/bXm0hTw0sTem1Vki+ZHxvisbjB5/Uj+?=
 =?us-ascii?Q?sROhvSXWQ1nN+zAwRKammWuTa2kK97INMasi5uuUk6nX8vYLzaPFUb0ASSCN?=
 =?us-ascii?Q?qdQqTMk0VaHrFBWjUmTQwcpelA7qfiS9QxtddViIklA+Pw+6SzOhUmn+KQ4P?=
 =?us-ascii?Q?9k+4lBE2UJ1xMvhLFrLTDZMTKpHaD5tGEm47OQwQUZb2H3X7YfeUVIH7wWn9?=
 =?us-ascii?Q?aEp6SkAIyqhVtjK1mxq1CO9EBtHM0Y0665aovkNvTnGt/l+5KOWXorcPPz0Z?=
 =?us-ascii?Q?xoPvb9QY6dqpd8PwJpNjzPEKRwh+1Wy8qUwgFdbakVDH5y11AmbokjrfjnbG?=
 =?us-ascii?Q?KiT+w9EeEn8B54Dvpt6Wl/uBkfEMHdp5kO4uiiohXwyaAGj1KBfiReLq5gft?=
 =?us-ascii?Q?WmH2XSMvUpZHWx9XpRhHHER8ZVy+WJARdAWpD5XGtF/AU61pqpjtR+dW0n1n?=
 =?us-ascii?Q?Gf/jvZmhqFjOg1OFrF5Ow2r9L0vDpUWCTvjkbLUNVZc4NUX18a+LF549h27v?=
 =?us-ascii?Q?i5d+Z4KSYpO5k1LG1zNh5IZdNf0ulZtxfArB06wBXtUQhadXiS2wZFyjHr9K?=
 =?us-ascii?Q?T7frvfoMboh7/YYwhT9io4VM7MAgw8GVjM/QrmEioevsUoHGHR62TkOLTao6?=
 =?us-ascii?Q?4Jim4UCb9FPoFxYt9IhWGM9JQus3rO+BXBSvIe1+Lml5980aDWlUVBFBwAXb?=
 =?us-ascii?Q?6w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 10bf5bf9-15c1-4348-ca1b-08da9be8b838
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2022 15:48:25.3356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CdFO8xc9qHMv0wX4iD7Gp8Lm70qVgIKpz3bYwLjl+BdnYQJw2CxdaJ0ytTUyoDflEyJ6sSyySeB67UYyKi9iu2CLxZ6ZpeXYF/1DchsELXI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5956
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jason Gunthorpe wrote:
> On Thu, Sep 15, 2022 at 08:36:37PM -0700, Dan Williams wrote:
> > Track entries and take pgmap references at mapping insertion time.
> > Revoke mappings (dax_zap_mappings()) and drop the associated pgmap
> > references at device destruction or inode eviction time. With this in
> > place, and the fsdax equivalent already in place, the gup code no longer
> > needs to consider PTE_DEVMAP as an indicator to get a pgmap reference
> > before taking a page reference.
> > 
> > In other words, GUP takes additional references on mapped pages. Until
> > now, DAX in all its forms was failing to take references at mapping
> > time. With that fixed there is no longer a requirement for gup to manage
> > @pgmap references. However, that cleanup is saved for a follow-on patch.
> 
> A page->pgmap must be valid and stable so long as a page has a
> positive refcount. Once we fixed the refcount GUP is automatically
> fine. So this explanation seems confusing.

I think while trying to describe the history I made this patch
description confusing.

> If dax code needs other changes to maintain that invarient it should
> be spelled out what those are and why, but the instant we fix the
> refcount we can delete the stuff in gup.c and everywhere else.

How about the following, note that this incorporates new changes I have
in flight after Dave pointed out the problem DAX has with page pins
versus inode lifetime:

---

The fsdax core now manages pgmap references when servicing faults that
install new mappings, and elevates the page reference until it is
zapped. It coordinates with the VFS to make sure that all page
references are dropped before the hosting inode goes out of scope
(iput_final()).

In order to delete the unnecessary pgmap reference taking in mm/gup.c
devdax needs to move to the same model.
