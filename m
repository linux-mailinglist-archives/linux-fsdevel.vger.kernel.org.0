Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B83457D7B6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jul 2022 02:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233628AbiGVA1e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Jul 2022 20:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbiGVA1c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Jul 2022 20:27:32 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E65E6774B2;
        Thu, 21 Jul 2022 17:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658449651; x=1689985651;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=PhBRaxbl4x+CkDzSLAEdt3l4klqBkxfiZFiYCBqLEso=;
  b=hzyAzOHHtAlYftyn+GbmUcNp1fJSaVfcP5+ZE4wwFDaoN44Jj6F3xQmo
   WZ8znuVpnB2wISD9Y6pLj/qAlJ5nU15rOeA7IKOYqtPPejFQZnhJf2/ys
   YK7ZzdTeVagov6v8xWCxnuAjfqXkjJM9Jjh2ZvSb3SQXjm3KtYEVs4PBB
   74/ZGNLZhiZX9AAnaVxb7kq4Kg0hzzrso9TIyhkswuwLNEIrIRz/tCQG4
   F7cwhjDbangIl4oTZk0hLm6SyQG1tTnAxFd+c52GGKfm5k8mVi+1Hz+9u
   A+OIY8JNEhZe04zZm6ipiXQwGzBgNKowUPp3oftT6QFLkdtP/dJC1TX0I
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10415"; a="266977560"
X-IronPort-AV: E=Sophos;i="5.93,184,1654585200"; 
   d="scan'208";a="266977560"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 17:27:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,184,1654585200"; 
   d="scan'208";a="688103606"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by FMSMGA003.fm.intel.com with ESMTP; 21 Jul 2022 17:27:31 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 21 Jul 2022 17:27:30 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 21 Jul 2022 17:27:30 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Thu, 21 Jul 2022 17:27:30 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 21 Jul 2022 17:27:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TpVLN//LzswCdV83Y+x9IfOG6/0S5swoXHJ2MpJSIfDBZiWFbHDEM3GD3H4w36h2+pPtIrzR86cCbAtFC60iKCeKKv+wPqGzBWCuQbxaZHnJ0yLAHJjj1I0VxPNAnnCZALhkk991GE7h8AEze1yBO+hlvPnP3psb4cJuQcdWkl2IqHz7hpnXHTfqOHyH6RcmBxlci/YaNZ3YKXbazUR44OfaGCPkAIq6ZjoBgpQem+zbdmO3XMnjViriG9Okq9YKsR/hjQv5CmsqcgpSIqPuBeVgVaaFP/F4j2LMnx5RxktYpUhKbCG8XzblWqSelTqSEPVxUqvcAXaIWj1RWwmb4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nTc7J0ErhLQLMIV/WQ9OEht7ctCDgFUdubbgKfg3QiQ=;
 b=hEYDunuZ59ER8YnyLXuNyh+KwK0Ygb1NG2EovNns+qKS5PXbxcVJRifW9SG58fBJBvBlhgQwN4/8c1ZtEKNLmpViCcBPCPWjNY28Pgjx8iTQAoJR+dLW6E5JHIxN1U1XRPTPSjDdIH+THiXJ4GMEHEInRtNlj+xxFMnjhtadW79EPcbXSiiHNsRYYRH+Ag7jNdQZF8MN+38My2zkeroBIlGK10XplXLaa+bf+8MOUTQPqR+r67iIZgSiOVB0Iu/8mTf5SHhEuJFPrf5jf9JsDQRYycyl2YnWWKMs7ejkVz2IQvVXSdofHta/WWRF9mO33Zds43rsYc8b10mFE2zdbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by BYAPR11MB3461.namprd11.prod.outlook.com
 (2603:10b6:a03:7b::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.19; Fri, 22 Jul
 2022 00:27:23 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf%11]) with mapi id 15.20.5458.019; Fri, 22 Jul
 2022 00:27:23 +0000
Date:   Thu, 21 Jul 2022 17:27:20 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Muchun Song <songmuchun@bytedance.com>,
        Matthew Wilcox <willy@infradead.org>,
        <akpm@linux-foundation.org>, <jhubbard@nvidia.com>,
        <william.kucharski@oracle.com>, <jack@suse.cz>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <ruansy.fnst@fujitsu.com>, <hch@infradead.org>
Subject: Re: [PATCH] mm: fix missing wake-up event for FSDAX pages
Message-ID: <62d9eee832950_1f5536294e4@dwillia2-xfh.jf.intel.com.notmuch>
References: <20220704074054.32310-1-songmuchun@bytedance.com>
 <YsLDGEiVSHN3Xx/g@casper.infradead.org>
 <YsLHUxNjXLOumaIy@FVFYT0MHHV2J.usts.net>
 <62ccded5298d8_293ff129437@dwillia2-xfh.notmuch>
 <20220721185116.GC6833@ziepe.ca>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220721185116.GC6833@ziepe.ca>
X-ClientProxiedBy: SJ0PR05CA0024.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::29) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ef40cc3c-4776-495b-cb20-08da6b78f21d
X-MS-TrafficTypeDiagnostic: BYAPR11MB3461:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QwrSmImzQd4PijNKfvkgSnJ5pVDbhDVoZDS3u5n3W50noa6KW77WLNOH7eH1Iim5R1TVihUiC2pYIH8Qb+dF1TcCWT/xiBytm2lWnwS9J4lBDacTjE/u8Fo+uCpRHrkjuiZY3uoW6EaY4n00pTMbx+VdyaT/ggJr3of3rZtP1YhwNZRK0b3GulFQTJTQESvWSCK+htzXC6vdCSc2BhU7EXcOugl86HWPUkpOIQJ7JttZs5kV/anCfz1fA8JPZUGvE7wtPDvr6GMpR+f04ktuNXtdxOKK2+QPBRpBH7HMHW3xlfDw2Di6EbqfCB7zzchlEIGTZMYQhZ5vHJUeyFXKU1CLpKRZZeOI84DGcDpyBTHrAw+yZLOq28+K8nTkFbE8tQ4P1sYZyKlSpY6OIaKF9U2CQwFVi0+84J++7+SCo2CASH0gd72PFdN8wk539SQUf65DyShtqyomj2vEQd/zgpYqEiImGmOgYNUB7VzgdIdlWTCa/uLgTcqKwMl5VMknwV4GTIiap1Phkpc2bzCYe6sl6BvfFAZkYANXj6YQWbNMZGgPH2w2Ah0EsfXExXl4HS1wTuEdrG/Z1XXLNm/HimMaeEcARm+V+Zb8D/Jt9Z/Bjok9jqmDkNuux+yLIif/enE6DR85enDwFHpkzuxjte8vqIxWF2zmv+CWbg6aRFYU29H1N6XDl/dV7BzXaXLLbYOrQamFgYMBWQn30avwWiRwWApfRSKDeFVesHKZJmj4oR6lyX7Amxw+zVNVdwp/lUjnVSb/Yz+dzA+EOwB9MVza5yzG1enqiy8IBYnx9lljes/awei3cpZFjnkiI+HS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(396003)(136003)(346002)(39860400002)(376002)(83380400001)(186003)(6486002)(41300700001)(478600001)(26005)(6512007)(966005)(6506007)(82960400001)(54906003)(5660300002)(86362001)(2906002)(4326008)(9686003)(8936002)(7416002)(110136005)(66476007)(8676002)(38100700002)(66946007)(316002)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Fg4x/th3B0ARkMkeYj3oPL2pelDilYH3yB1shdDPd51YvnSPyadj7LDKUwcJ?=
 =?us-ascii?Q?QhmOtIMoE4+HahQeNwy+PlckyLXjtbvuCAZ3yKs4vQuFn4gw0b46F0ruidV8?=
 =?us-ascii?Q?IemAyUNHm5/zyvPX7Pvcl6NxSFzl6eSRNnvHswa69Io0XhfvsUiHjgXqjZFa?=
 =?us-ascii?Q?nUf5smLUQEllJnXPplTPC4YvAkc6u5tkDK39y0ohuav8NUO2W00Q4VZWE8w2?=
 =?us-ascii?Q?hGS87XRVlxXZ7QCGeDOe/eVCzY0fd0+hD30CPi7/4UPW875aT+RN5082E/U2?=
 =?us-ascii?Q?dPYCrJ9EedltbL+lpPrPtH02fHUqeI3f6AUt4ltvNB/1rQKDLqUCek74Y/dQ?=
 =?us-ascii?Q?A6+8arm33eqx48S0NBG9RDPulzIHpic6v/lzFif426WMiFaHJ58uxUz35mMD?=
 =?us-ascii?Q?TzVGJTE0pAdhNZviJIW2S6+N857qtwA+4EW8VbxS+pjpIP5IvW+G0zumXoj3?=
 =?us-ascii?Q?YLvl8vQE5BCDf3Dwo4Uy6JvGdMq11FRHWjkl2xEGNlmbes7FYUdw2d2xXUzk?=
 =?us-ascii?Q?GFD9YvIH1EjCxY+IBnGONMm1ifmlj7S21ZBXXi7p4YNNqTKeckFQ/lRXT0Ku?=
 =?us-ascii?Q?XCHADu7Zne7mcEeWWQm4qEGC2qoVXkyqtvSir4MV92LcbWO0DcVukABQ+5xc?=
 =?us-ascii?Q?BJEdpQJLcFKdsUiN1i4GnodYfCWBEkfKK2P0JOyZ3wpawobaazUYn0ok6r16?=
 =?us-ascii?Q?uTWpqfuBnkql4Rwey61ZJs6oYbY4pzMjbG56zKz1yjI1FgSZ/QgiStuHutUL?=
 =?us-ascii?Q?TQVkV2fr1gThLqzjyBjG4FoZkE0qClDROKlr4Hu8fy4lW18/KQZakw8DCcpR?=
 =?us-ascii?Q?xLWOq4JoIwr7a1kDHpzIBWyJjR/dNDxjDpcF1lVUa81VjUQ2XDPwyIZihKKT?=
 =?us-ascii?Q?mQGnXxPqUxCsc3m4eRjSnhAWE7mNqUOk3bsqom+I3eTeOeOqp0367okkjnYt?=
 =?us-ascii?Q?KiG9b7QV1YIMwiRQKNlH9Foal3JMKAlNrpBhUUpUWPwEnDA6l+hklZGL61Cm?=
 =?us-ascii?Q?H4neQA3YMSV8e38Bl/P50T6/P3IRveN8fREm0HPWVIMLK+HbONP0WL7Ympc+?=
 =?us-ascii?Q?wmiky3CdTIhBsFjSKDG3HStbX51FuTRvmzsNhWfvvW0RTlWBSl1eTxtTzGHp?=
 =?us-ascii?Q?GI/KIacbxtfpkBPW+PKTUzpMyoNprmTvtY9d90F+d8isdOQOTLPcsnYaADit?=
 =?us-ascii?Q?QCFmA3uPqFreOthvuF/juQCxAQ/eN4+iT3wTmUSNns7o+SRI6jtNUukb+rJc?=
 =?us-ascii?Q?EER0oMT3pHdj4ShgYg3W4/+lm3KRJMuKh6GS6cpobLVqug3EByA8PWb89ZbV?=
 =?us-ascii?Q?Cr1Bb0LX3kUOW6TrV2Q94KT/c6vy/jsU5fX0JZ4rFhI7iSXsQETVi5S7buWm?=
 =?us-ascii?Q?lx6N3kX5EGzCFmPEgCNsu2dcMbahHFY/6HcGRhgCdDkPrmtl5QYxVbB1xuTU?=
 =?us-ascii?Q?r3IFptF4CZdGrYUKbh20TsMbucS4KhXspVKQAW8iDxeXu6sWlwc5rPto9Kci?=
 =?us-ascii?Q?TxTZv0ZF3BNXs0kGxn/dz2/IEeuPavCMksB2R1cniLuX9UAgsonGdxs5xt35?=
 =?us-ascii?Q?pNQ4I1HqpknilShh4JdwRrdwXzvGP+yqUI//z1SjVEGTBOpcGWQ0h2NAFuqB?=
 =?us-ascii?Q?pA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ef40cc3c-4776-495b-cb20-08da6b78f21d
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2022 00:27:23.0351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pZh1GfHbIp9ENgB9MyD9Cb2hfkmNnIHWCFYwnp9ndLzrVXMUcM6be+2RovHPJ4OR5hvn1C3PSk+5aaben2PEgamqxVPrnsgXBuejRZYBjRo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3461
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jason Gunthorpe wrote:
> On Mon, Jul 11, 2022 at 07:39:17PM -0700, Dan Williams wrote:
> > Muchun Song wrote:
> > > On Mon, Jul 04, 2022 at 11:38:16AM +0100, Matthew Wilcox wrote:
> > > > On Mon, Jul 04, 2022 at 03:40:54PM +0800, Muchun Song wrote:
> > > > > FSDAX page refcounts are 1-based, rather than 0-based: if refcount is
> > > > > 1, then the page is freed.  The FSDAX pages can be pinned through GUP,
> > > > > then they will be unpinned via unpin_user_page() using a folio variant
> > > > > to put the page, however, folio variants did not consider this special
> > > > > case, the result will be to miss a wakeup event (like the user of
> > > > > __fuse_dax_break_layouts()).
> > > > 
> > > > Argh, no.  The 1-based refcounts are a blight on the entire kernel.
> > > > They need to go away, not be pushed into folios as well.  I think
> > > 
> > > I would be happy if this could go away.
> > 
> > Continue to agree that this blight needs to end.
> > 
> > One of the pre-requisites to getting back to normal accounting of FSDAX
> > page pin counts was to first drop the usage of get_dev_pagemap() in the
> > GUP path:
> > 
> > https://lore.kernel.org/linux-mm/161604048257.1463742.1374527716381197629.stgit@dwillia2-desk3.amr.corp.intel.com/
> > 
> > That work stalled on notifying mappers of surprise removal events of FSDAX pfns.
> 
> We already talked about this - once we have proper refcounting the
> above is protected naturally by the proper refcounting. The reason it
> is there is only because the refcount goes to 1 and the page is
> re-used so the natural protection in GUP doesn't work.
> 
> We don't need surprise removal events to fix this, we need the FS side
> to hold a reference when it puts the pages into the PTEs..

Ah, true. Once the FS reference can make device removal hang on the open
references then that is good enough for fixing up the dax-page reference
count problem.

The notification to force the FS to drop its references is just a
behaviour improvment at that point.

> 
> > So, once I dig out from a bit of CXL backlog and review that effort the
> > next step that I see will be convert the FSDAX path to take typical
> > references vmf_insert() time. Unless I am missing a shorter path to get
> > this fixed up?
> 
> Yeah, just do this. IIRC Christoph already did all the infrastructure now,
> just take the correct references and remove the special cases that
> turn off the new infrastructure for fsdax.
> 
> When I looked at it a long while ago it seemd to require some
> understanding of the fsdax code and exactly what the lifecycle model
> was supposed to be there.

CXL development has reached a good break point for me to hop over and
take a look at this now.

Speaking of CXL, if you have any heartburn on that rework of
devm_request_free_mem_region(), let me know:

https://lore.kernel.org/all/62d97a89d66a1_17f3e82949e@dwillia2-xfh.jf.intel.com.notmuch/
