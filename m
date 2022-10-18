Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 688CE601F8D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Oct 2022 02:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232178AbiJRA0X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Oct 2022 20:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231847AbiJRA0E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Oct 2022 20:26:04 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E0E1D0CA
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Oct 2022 17:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666052617; x=1697588617;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=W3ZUeT8g/HxUenu3hSs+Lh9UMcMKEfy767LCjx/eR4E=;
  b=Y3UdUpMOq55GsIh3n8nXIbw429ibK0HQl9aUgIzb1xfTkY+rv6E/i4Lj
   FEIrV1oC8r1gGq1RLLNEZYMikJPw++sgBIDhGjR+3dIk0L1waLHuswCsJ
   /YAzhgKyNTf6CP2+EZduaFxh8ODieFTXhXx4eNSZ6HZPjMtZ6YmOQLc6O
   n9wHQ0VKChRUkivhKBBeElx97ryCS0vd/d6LGUv+/dRGwRpHjUOXBNf38
   yDBodHoJcF8v6LgxJ/QbDfwR5S5kH8fC51T+Rj6P+yyU9vVNB0aTPfgE1
   pY5dXlWies6iFtrdl4WDc/AlvcQK00QyDW/QeZCXrQ3X7nGxr9/7zRlwc
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="303568888"
X-IronPort-AV: E=Sophos;i="5.95,192,1661842800"; 
   d="scan'208";a="303568888"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2022 17:20:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="579566539"
X-IronPort-AV: E=Sophos;i="5.95,192,1661842800"; 
   d="scan'208";a="579566539"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga003.jf.intel.com with ESMTP; 17 Oct 2022 17:20:05 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 17 Oct 2022 17:20:05 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 17 Oct 2022 17:20:04 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 17 Oct 2022 17:20:04 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 17 Oct 2022 17:20:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ONY9uwOoa6527at8s0AyKHZ44q97r2waiJAcnJ08n7ouw4EwDtwKjD7uL5RKRVVW+hIVxmRTh7beAMmpD16UaZpbrm6+akL2c4Weu9qqbYQCSnP5XvyMMw0iKG2CvsqaTOgOh3VTtCTFtWKwCmWgAEA4GwFWbBSQ6WZJunQ/D6i/Feqzrgircls3pJwk0LlRdMChXA9adSzMM9u3grVqgZmXqDU7P/t60KTmHS2OuxpIUvEGeNuupLtc9UcOIwfNMKYg4LfX2c0OKwPbn2IfhCZOGRWLebOJDmczYoUzfExV62HWJqNHd9shpj9OXXbAp/MiBnaRlkH43D6WiHnucA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8FIifDGZpNIyBYcW58aaQH98AkiRgRYL4qgFdIFEvjo=;
 b=J8V+3HEW0Otw7pb/SV5TkC6db8NhV45GCGn6bz9T5LwYFV0aJglF8F2unyiD/YxgGMyMm5GDqYY1XaxAdCh6E/e0lNIDTtD1jQxJEfsgXLyt9r31jSuCegrCchsqKus+HP7PBPF605pAgkiYX0RR6AbdHKNhtHEV5LZ6OV/r3LO0I5J8JWIRySRc1XpT90WEXU7C8/h0To/V2/BzhQ7pPNhO1EDwQazrAOBp8wljK+V3yjUz1c1caf63bYtv+Pf2W48k46G/oGH02ah24G5r6Gz9YSFX8WctQJE6u1Muh+8egrZsj46iDAiXITJFDGES+47RawboExF9JQex7R824A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by DS0PR11MB7336.namprd11.prod.outlook.com
 (2603:10b6:8:11f::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32; Tue, 18 Oct
 2022 00:20:02 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::7d5a:684d:99f7:4e83]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::7d5a:684d:99f7:4e83%12]) with mapi id 15.20.5723.033; Tue, 18 Oct
 2022 00:20:01 +0000
Date:   Mon, 17 Oct 2022 17:19:59 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Alistair Popple <apopple@nvidia.com>, <linux-mm@kvack.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>, <david@fromorbit.com>,
        <nvdimm@lists.linux.dev>, <akpm@linux-foundation.org>,
        <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v3 10/25] fsdax: Introduce pgmap_request_folios()
Message-ID: <634df12f1b142_7ddc294a9@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <166579181584.2236710.17813547487183983273.stgit@dwillia2-xfh.jf.intel.com>
 <166579187573.2236710.10151157417629496558.stgit@dwillia2-xfh.jf.intel.com>
 <877d0z0wsl.fsf@nvidia.com>
 <634db5c1f602_4da3294c3@dwillia2-xfh.jf.intel.com.notmuch>
 <Y0229P6z0E9Niw+9@nvidia.com>
 <634dc046bada2_4da329484@dwillia2-xfh.jf.intel.com.notmuch>
 <Y03r9wBs4Yk8LyC0@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y03r9wBs4Yk8LyC0@nvidia.com>
X-ClientProxiedBy: SJ0PR03CA0219.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::14) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|DS0PR11MB7336:EE_
X-MS-Office365-Filtering-Correlation-Id: 39343a6f-9d41-4363-5048-08dab09e7f82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QvUtZky9wQc9DzMLfXmHeBP/3GUZ54ZiEIfm9TSqmOgRY6y326R1/LcLSNppVVloRH2fS3CMJFRimQ2pygKx9WHl033nG7X6FPWEckRMrdRYdtTyuze/tH9CTeMTAwpihVsIJO79cKDgXgS4VYCGg6q982XNl7sYobk3TZfBLnlpye5fF2sN+UbTLzc8P6WZnh/5NIuB9PKzcY2dViE1IlSTVnQ02ZeJqYsEY4T0CjfuJFvGr7QNtYidp0ycSXZF8bzp1jhnMXGZS4VG/27CIj3wyJy9rdo6ztnICM7W5CbGupCJZr8jI7MIzHvVvRZt59TnMlU8d87YczHEPbbrculLI/eVOIyt6241auOGiYsBSKaUcfG/fz8OINrjw5iKc8nxWdB2/jzqFfhNWUCB9wX7CtO8os+AHxQrHPyrtzjSjtxghmIgfG7WKxwT+/dyTgewS17ieRt+bwTAjBIL0lsfeeILgo+tnGDXixi4AWmXC/DxRoyWKG/iEKSNWzwpUAGj+JrEaWEUlyznhn2Nv4RupmuJVDtZn9OXLurV5xX4rl+/Y+IcGL5r0PlbGJ19riuFq2z3qQDGqLsXsWuDbB2zRjQS+YG6dX/HMnCh90LAvc1aF3cjc9NShuJ4gTcXfx6KJMi+rBxErxTr03cj4GI6uKumHURadTkT8m0qtOa3ojRNyG7WlQlguW/dezI5mRM11Ij2AfumL7nw9kYCcg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(376002)(366004)(136003)(346002)(396003)(451199015)(9686003)(86362001)(82960400001)(41300700001)(8676002)(6512007)(4326008)(26005)(6506007)(8936002)(110136005)(7416002)(5660300002)(66476007)(66556008)(6486002)(478600001)(66946007)(54906003)(316002)(38100700002)(186003)(83380400001)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?f5JwDqC409rRS+tXB/+DM8tb+JBKy51GEqewpbdoh2/K+A7oUVbyXl5bLoAd?=
 =?us-ascii?Q?FZhmArjhWoyQA+yf8S8z+iOZB56JG2Oq2NgGlN6MTwC6gyvgL/NMo3ebFcq+?=
 =?us-ascii?Q?iFK//WjxtvZ51PMlFYWf8pLh6sVR/s/alKJGni6iCyjvX73zJ7Nl3IBgoOM8?=
 =?us-ascii?Q?Y8uhUbzPlA88E4ukp+XjtE+lGbsgIe+wyQ0Dga88xYQBaD4kwJt12fGvgS8v?=
 =?us-ascii?Q?GoDnpmAZiEXCg24PqLA4Hwkm5OnvYveO1eyM7gehZc3OIAUh+jo0kmQISUCf?=
 =?us-ascii?Q?slwGGy2cxZ0LamP49j6VqwyjiVTrFr+QHOL/DB3DMMOunDtKFjwKHlWL3z0m?=
 =?us-ascii?Q?NZCv1BfYn/Ssz83Oah27oC9ewcuYtZHP4QxcI+qhZE8Gdceiza1bCVEVuOcD?=
 =?us-ascii?Q?JVgzaymtSPfPk6ntQavHW4fcJ/ybmKF/J/0UG/xi8MYPtJprcB1VJZkVHCJ0?=
 =?us-ascii?Q?qwX58bS6uztOBB71CtGV7Du1YbqlwDaBSWCIEtXkxqZZUtmLDlNRL2PGYgXA?=
 =?us-ascii?Q?efl5Vmx31SMP4KbGcwCR2oGZLtbsCgLizI/SwF/eT+fuCsvTAlefO/AWDx2g?=
 =?us-ascii?Q?YQscdmKoDistSZC7uTTRxBeiC6f+NAFPRB/89s/s0HjP3gyyNBlYbHpL8UsN?=
 =?us-ascii?Q?TSPY4m2JEGMv1NwKveSTM0tZd1m+IEJQdLGqkwSAH1WC9IiC5+f5hmto2H89?=
 =?us-ascii?Q?Embb57i+JF0bbaLGAxLi2SfS0xaIdgFrIl3VE61FiilYzVy6rxMsYB5Q+Cbf?=
 =?us-ascii?Q?9L6ByDW4ciJqeN8YN6k3QFg1V8UkWNrxiScFLnsNRA6xerM2b0hHsA04WdyH?=
 =?us-ascii?Q?/OcwtBO3nPeq7PS+YHZeZOXYLVIWXfUpxs2jkko5SsoU3WB4Mw+E3/z1I9Rg?=
 =?us-ascii?Q?OVh20akDJkfT/HB/YQqTRUx+BxsQfsfHqLFYBPnbC4Q2iv8EK1Cufnul3oBz?=
 =?us-ascii?Q?mrLvMUFajT5QWjGiId8/nMBcccG0fRh5LxyTYOuYUdMlpw/hUB07xyMrQ/Rp?=
 =?us-ascii?Q?ro1XxiIGD+NVI+o5k/WkoYg8zkoqL6Pedc/IaxnjWhX4iTZnFvEUwfqNmWUE?=
 =?us-ascii?Q?h1CccK69oMnqqn2mJm9phrvRvlV48SStRwQ6J2mVulRxyW6Y3iTlnOls99KF?=
 =?us-ascii?Q?73MljrU4CW4Ofwi++wJ1waRLv326Aq6vxYxeHZWo9pQLnP5nSUO1Fo80hzAs?=
 =?us-ascii?Q?06bSjMCvr3nY5d7Dh3pkutfQs7Eng9pQSMi/yp9Qf/0moKZuKkX+H0mWwAyV?=
 =?us-ascii?Q?2QfouSFhKTeDYRer5jOq0dEA/wq8RrwjzP0mOXAlDeg+Gt7P5jiGyqXHRcCA?=
 =?us-ascii?Q?XVS0+bPFR5gMQxBqWr4ruQXABW8xZvpHdJrhTIG01g1/VKHs7RgtRpDSSr8Q?=
 =?us-ascii?Q?F5+ZNIghMUSXtxLFD3pcKuQ8VZobqMET36NCXLna4KkrZNk23MG3KXZWqfN8?=
 =?us-ascii?Q?UzyPN/Sl8s+iRYGhFj70f3t434YV7YegcEMHCrt8WpWSzrgPkY618ZINDasn?=
 =?us-ascii?Q?UITyo8SkChhUpJWDIZMwcwq960juLkrV7qEMFtG4EjM6ozwczgWcyOen5t/l?=
 =?us-ascii?Q?y4EcPGw7VWMC2pGQDu/bMCbdkFQcjDCVJKj1m4orXZQRr/LAE9mCZ69JDEfm?=
 =?us-ascii?Q?wA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 39343a6f-9d41-4363-5048-08dab09e7f82
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2022 00:20:01.8320
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F1Ecp388RcVjc+nRpd5mvFMCWGOuXwL/ffGvoUCMbIx85ufLqeQ6NIaJtp8Gajq+M6XmeFEfulSZCQYi3QrU/jzU+xbTx3vNSXJFumlfW3c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7336
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jason Gunthorpe wrote:
> On Mon, Oct 17, 2022 at 01:51:18PM -0700, Dan Williams wrote:
> 
> > > A good design is that nothing has a struct folio * unless it can also
> > > prove it has a non-zero refcount on it, and that is simply impossible
> > > for any caller at this point.
> > 
> > I agree that's a good design, and I think it is a bug to make this
> > request on anything but a zero-refcount folio, but plumbing pgmap
> > offsets to replace pfn_to_page() would require dax_direct_access() to
> > shift from a pfn lookup to a pgmap + offset lookup.
> 
> That is fair for this series, but maybe the other pgmap users shouldn't be
> converted to use this style of API?

That is also fair...

I think my main stumbling block is getting back to the pgmap from the
DAX code. However, I could move that to a dirty-hack that looks it up
via dax_direct_access()+pfn_to_page(), but keep the core request API
based on pgmap-offset.

I.e. it needs some access to a 0-referenced page, but it moves that wart
out-of-line of the main flow. Some of the non-DAX users might need this
hack as well unless I can figure out how to route back to the pgmap
without interrogating the pfn.

I'll try it incrementally to the current series to make things easier
for Andrew.
