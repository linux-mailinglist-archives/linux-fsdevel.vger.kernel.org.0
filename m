Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1FCF5AF3CE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Sep 2022 20:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbiIFSiF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Sep 2022 14:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbiIFSh7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Sep 2022 14:37:59 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F9A19AFE3
        for <linux-fsdevel@vger.kernel.org>; Tue,  6 Sep 2022 11:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662489473; x=1694025473;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=oWR8+Rh8PqA+0m6oOqgTi/QGieZZh5uopHSaUujyH9s=;
  b=Rcdv+VfqGF6NECzupXL4IsQ9EgH65BmYifxHp+LlDCpjzd+beZhROtxc
   NVGxJc6xJmwi8gVMhwQ+L6GaKfr6FmUxv47Gz5x5wXnIxZNmjEP92uVHH
   4BobGB1xl+0oRBICD+bZxHgcQYEdD3mN8iDNjsoCs0dDtTuVl+ggWUcvs
   jbSr+X0bPeEHPE0LoWl4yFoOQ7IAMFe6ilyLBpNlxvpGYm21x5YysDtlW
   GhiwVNNrWRyoU3J9EUZWhNRTPFyVS1tSlsa9jeBiN+kUmV1DDSZIylc+P
   mYdSZtI28WVdsDrJPKatWkV+k0diJfPbrGyE6usVLcuQAR5w0mZceXDs2
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="283671174"
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="283671174"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 11:37:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="859355386"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga006.fm.intel.com with ESMTP; 06 Sep 2022 11:37:41 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 6 Sep 2022 11:37:41 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 6 Sep 2022 11:37:41 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 6 Sep 2022 11:37:41 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.109)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 6 Sep 2022 11:37:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OefwO3XcLISA9vNPN9x761PgCcnmTokSihH7xdJqCnZGrnrVRPZArAvaicAL+qZn0DLOo8q7viKfX3dJar0Gp1bdyXir9PuhXS2i+ayq8JGzwnYmWe63h9DS8mF3F5iWW9tZ/MK26lnAWxxNG3GbVxy9hprtQI1y1CwhbQ13A4EX4HSdt0ZADLQ1nqhO7+SMnQRF/Se10KdBoMXAZnnApVxGE/pNarbRqcSxgmuhC29Na/jhGwHIlDT+P06zMpvhZBadt0S15f1xSg7l87WR5jmyTVkinU7noEvJ4tFGfbz2Fo0U4IJhpSYqwpU+8spef0J2jHNbyBMcmfOBZZYXFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X8yH32IzjlQn4AorD1w11UQKjnf+Rxuu6aGrqoB0aZU=;
 b=NKCJANAprJ1fJLbcjTlKwFJuKBuDKdm1/ZFsRyFJq9SLd62M0FG6yNvSvCPwYj7lFARGI8Ubpw3Z5WXIQnDjh1c5VvW97sRJhjs5nmGeRHYIms/DTxwMlM7KKL1c5uLsCjTLIu16qPsK0GXCn8tOlZq2918ZPsBkqr+ffH4v222WtJ37+bzbbXEARTPRS90fSqTUJsnLr4nEI5GQv9fWg3nsR8T5kN8rxGdALRmxl2KXsJlQKAR9/ZTp+hD/eq3HHzL3avfn3IZ4M5nVKwGfFvIdpur1fFTcvUQ7g93XpJSWJ4uGkblh/KUxgNLOtieXoZsmG4YMwRWYPse8z9Tqew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by PH7PR11MB6474.namprd11.prod.outlook.com
 (2603:10b6:510:1f2::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.17; Tue, 6 Sep
 2022 18:37:39 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12%6]) with mapi id 15.20.5588.017; Tue, 6 Sep 2022
 18:37:39 +0000
Date:   Tue, 6 Sep 2022 11:37:36 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <akpm@linux-foundation.org>, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <djwong@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>, <linux-mm@kvack.org>,
        <nvdimm@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 00/13] Fix the DAX-gup mistake
Message-ID: <631793709f2d3_166f29415@dwillia2-xfh.jf.intel.com.notmuch>
References: <166225775968.2351842.11156458342486082012.stgit@dwillia2-xfh.jf.intel.com>
 <YxdFmXi/Zdr8Zi3q@nvidia.com>
 <6317821d1c465_166f29417@dwillia2-xfh.jf.intel.com.notmuch>
 <YxeDjTq526iS15Re@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YxeDjTq526iS15Re@nvidia.com>
X-ClientProxiedBy: SJ0PR13CA0127.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::12) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a591bcaf-b094-459d-bf3b-08da9036e032
X-MS-TrafficTypeDiagnostic: PH7PR11MB6474:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 71eiQsZlbjUTvDQ4ZW4AI5OBqKbq8X+WQOk6K0+SULQAwLiczRufANWW77tDTQ62E4bndNB8WndRqTy0FUeKxVaBiCVIl/Ii529a9F8LDV+Ib54dcygzZ5dhk7pSkLR6rHqtFr1RdfUraaPPcXSOcpHzd+SrgOCFigRVO1ueZzMHyq9HG8YvCKFszvlxwY9BgvwI+OgEsnBbtvGtJtEt48B/44uuLBInfDKJHe81fO+kY2BNsJteRNR6lJw1M9Hx1iSOIw8NdnwSI+3mXJ0+AayCPYXoxfPsmPJJj2FWIwPb/qAAJxndAhG4g9gCcQ18i4MnEb5m2vTvM9luMXvH2KTzqazl5tSbqFRsUW7me2xaC5s6w2HkhjWaeAQuxDwLitWAF5mPlyjemPcUConsWkFUh+M4eefUlZLVGPin6Zs0Prjwpn5G/SSPuqhcs4J1fvvTPUIRU4Hzfg7p4XyOK7KtkeHN+lrsU0Xm4219sLfn9jZ8kFuid+dXpHNt/hN54XUSfe19+hWFZ9+7FRQ2oFKBLLRfZxVdkQXcs/zdHSgpTo3vZqBK7j5kKlWQQzE8L6KnNn/GOiFtGRrOVzDo0F2OUM3NdZV4pOijT3+z66QlBm2SZgH2k8y5GJrDOb75XHoDBIJdkVbKC1xr1kqqa/I/eJKbTLPiLCM1jG9RrZ115N1pjgBYvDsF/7pu3S6tNc4okZCj+KKMiXa7Oq4/rg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(396003)(346002)(366004)(376002)(39860400002)(6512007)(26005)(8936002)(9686003)(186003)(5660300002)(7416002)(478600001)(86362001)(6666004)(41300700001)(6486002)(6506007)(82960400001)(66946007)(4744005)(66476007)(54906003)(38100700002)(83380400001)(110136005)(2906002)(4326008)(8676002)(316002)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GnHiMGvhEZVZBCCVKkakbl5oQk3WndTxJdXdyegj/KuPGnTkTitTUKBsdXhO?=
 =?us-ascii?Q?MYCYCscY6rZhsQ1m5VoRrCWQ+/tOTQdUpaIaUbGX7+CLp+McGagN1RgAnbnT?=
 =?us-ascii?Q?kooqwXbkCk8UFQNh7peBy+ZLcAuRsxjC/jMmvpxBTfcLYHeK9hDB0VV5Nh6X?=
 =?us-ascii?Q?cqDUKB1cd4SlwF++D4Z8+sZETpFVhG4XK21h0iGoir26akLSdiJadUCyR4+i?=
 =?us-ascii?Q?kxUT4vpfoPh4xN5bjGJQHOIDv53KZWR+lJsmf0GUyDIexAH9alffnV7K/diu?=
 =?us-ascii?Q?bD/iE5XP+eRLTBCKvoLJtRjYOFNZU08FOYBq/uI40czkaX9OnPgk49B13s7h?=
 =?us-ascii?Q?irbIC8bheehDCKqaYteBMJ3UL9pqr2EUqwIWpAY6k9EpA/aLzwKRmYnQ7S4j?=
 =?us-ascii?Q?NgdIGP05HbKBXCJp7Y3eGrZadE9Yhq+UgnQpfKCxuAZEz0MBPJxpofVJHZxD?=
 =?us-ascii?Q?BGIQwTQLdZTRqmyHwIRXlzvAk2ezCDpj1WH5WcM3aFBUXVvM7hkrrkAreh7Q?=
 =?us-ascii?Q?QsTVNQPOC0u6s5Vu5e0LoCLQk0Aj4MnQ0pXTRDVrnAyJo2fnZcThlIsxIDUo?=
 =?us-ascii?Q?lSQ17v1uUgrYKGz9G0PaqkH3/SxHVxXc+0GOp27vGtoTOvYR21HwspDYuVPL?=
 =?us-ascii?Q?ESfwE7R8vDwvo3IzudhC6nF3KLHw7QWX7zib3jEdSogLt8rAaE8YdnkjxPSx?=
 =?us-ascii?Q?QF+0PUfzWomMlDP+F018bDjhQQt4zIEyk3VBHjFQ5rrfyAQuLe0tkQSCYiCv?=
 =?us-ascii?Q?sVAtc5avNzFxZtmoWJ/EEs6XC5nrELHtuP6lKJiddSQG+c3xoEbnqFyg1WcF?=
 =?us-ascii?Q?aIJcrkYipT/yurMu9ti3Aby5iuVacj8JHiuYRMRo5ed0POer87K+wijq5Nfk?=
 =?us-ascii?Q?uMeczBp4WnBFM4+nNMAdD7TKJIHIQMb4duM77iaBiFGZuAXQCycMmZshSOvM?=
 =?us-ascii?Q?4Q50PFeEVYomehqEa4F6CvFhHbXRR/GHdVdaCWwmLlF1j41jvOg9079ttGKW?=
 =?us-ascii?Q?LWSoyMjNx/l4f52ONCT2hJym7fihKj/8YxMbAKOsVQWL3Q1fZqP3Jh7nrqBM?=
 =?us-ascii?Q?me2MnMIoc2XSZbPPW7y3yBNvAkfE7QSkXglRmN+BDX9ikpANMuIwtThRA3Al?=
 =?us-ascii?Q?dNaerTDeQAr4i493d6pM/Zurh2ql+rKcntSSgyZLffiybsJOrjHm18ybCaI/?=
 =?us-ascii?Q?DyD9qskufepyr35ebBdl9KLlVzjfFj++aKb2SafWNJKUqgPLkxF8+JwlJYTG?=
 =?us-ascii?Q?5rFZHOUA2ZvLCBid1gEDRwnohic0yIcyFdbfLfPl7xrFa4im3y/aV77DTIq6?=
 =?us-ascii?Q?lLPgQTacD+rwo1oEEfeY144K+TzcOnp/BVAatXerFRYs0OcQ6FAiJlhec/DQ?=
 =?us-ascii?Q?wBUokFcTfSmT0xoThz1mWxPXYtDuBktLxUmVXVWBUuwr+Ej/pt+G2Sh2QYHb?=
 =?us-ascii?Q?J10erChnEpsLW/fd/2qGDY2y6+SyZl+N+qeZKu/BBxR7mqkBKlC17v5WF5OS?=
 =?us-ascii?Q?+pEHm86rFZrm1ciSc9dokAbE1PzziUXDZ9ljXresBVlCaS2FH6KN1ZBDcofO?=
 =?us-ascii?Q?KiK0BNnSfn37uJEVjhyE6vx3t7OzM6/VJFpuBWVFcSIAbIuArI4jmtOJrnt0?=
 =?us-ascii?Q?XQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a591bcaf-b094-459d-bf3b-08da9036e032
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2022 18:37:39.2120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SZIVv0iUl/RVj3zpqnKXkjxNL6iqApMCWmsUfddWypyYgApdEfbzu2EUPH5E3vWXkutNE00t3ZUDPwlK/t3/Ww9qWoMKF5GC0FoIHxMwSW8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6474
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jason Gunthorpe wrote:
> On Tue, Sep 06, 2022 at 10:23:41AM -0700, Dan Williams wrote:
> 
> > > Can we continue to have the weird page->refcount behavior and still
> > > change the other things?
> > 
> > No at a minimum the pgmap vs page->refcount problem needs to be solved
> > first.
> 
> So who will do the put page after the PTE/PMD's are cleared out? In
> the normal case the tlb flusher does it integrated into zap..

AFAICS the zap manages the _mapcount not _refcount. Are you talking
about page_remove_rmap() or some other reference count drop?

> Can we safely have the put page in the fsdax side after the zap?

The _refcount is managed from the lifetime insert_page() to
truncate_inode_pages(), where for DAX those are managed from
dax_insert_dentry() to dax_delete_mapping_entry().

I think that is sufficient modulo the gap you identified where I was not
accounting for additional _refcount increases outside of gup while the
DAX entry is live.
