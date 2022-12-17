Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE2264FD11
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Dec 2022 00:40:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbiLQXkG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 17 Dec 2022 18:40:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiLQXkE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 17 Dec 2022 18:40:04 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D232BFD;
        Sat, 17 Dec 2022 15:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671320403; x=1702856403;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=uyGg/O0AErkhsARyN5rJ6h5Q7ntE2Ln5p81fG+DeuGs=;
  b=hKzNWwOqFboao9CEh/JqrgTNpAhkID3MDpl7GK5cxGKvEP2m9DFY55BI
   L3IMk9/idDRDf6J+XZJOLZZIMuP+B/ngHwliOC1dfuz9uunIYNK6GIVvV
   iiXJ2wSBy7ECCs7h4Wv25tzJ+GuMWyHkGnvGlBt8IglMBBvekRo9HWy3J
   6aM7BNMfp+m3YSuKJZTlVJX0FOlV3U2V3DE5FHPKduDfY8b+tnn5svTA0
   Fb1otzVI6Dr9MMM/jVLNbbmFdehBNrWiAqY+EGBFC29NrdN2MXZEv91HN
   BqSeJniTichvmZTiaR1tMEhoe8BLTdQkM4OdZFHbRLcjC7/DssokyaUoN
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10564"; a="321050832"
X-IronPort-AV: E=Sophos;i="5.96,253,1665471600"; 
   d="scan'208";a="321050832"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2022 15:40:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10564"; a="774515644"
X-IronPort-AV: E=Sophos;i="5.96,253,1665471600"; 
   d="scan'208";a="774515644"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga004.jf.intel.com with ESMTP; 17 Dec 2022 15:40:03 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sat, 17 Dec 2022 15:40:02 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sat, 17 Dec 2022 15:40:02 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Sat, 17 Dec 2022 15:40:02 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Sat, 17 Dec 2022 15:40:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a9T1gDZmBX9hDp0inq5ZjBv+0i0RW5GI8MFj3nu2bqRFcivq3PY7+8kq3wO4jHFJd0M3iR4fhgxGgBxpti0CyRJunfTVbvDQT5/c3WsELBeJ5CQY4prD6APmy4yl2qqdu5gm1vYpsGOXx/XKOaQbwXxacIAPkqYSBgkCPQylztsh7Z2NyztRN+Km2J91M8JqAUNHG7Cy9OX/VVi8shVeMpUrS5kNrv+ZqQqbq863nuN4lN+BQly25E6379Ro4e5+G/DLTyS6kUZybXMHu/5E8SB5zsEwOBDx8lucsn8lr2b9fh2JN9Pb2OsadexdVjaj76ulocsg3sBkboKnEvOTRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y7MVjWnm6CSm0iCHXBt0sXNcL9ZH2rWPAV9M1aWhy1w=;
 b=NlbfXpL4QH6hJyORrowcX2CBNOW4fuc3lDNtPuhy6zBB9FBiHjvWPIztze++YouqskK6QS4JVzqL5EY8csjXPQINfNdfF8tE+YldECIo8RepbDEWG4iY6lAE0u0XtVfLVnG4xLS9+/Ggy7iIn+LiLqQdnk77rULnpOq5Mgiw1eZfaTlK20sZp8I+49EImRWfvPlCSK5UKH2uRqJCRxfvmLbqUb8GM1M/IgZ3uIxaaZz7XXnpCRedIwiO4iPBlwGHky/YswAO1TCyijREnxP4L+WT1aAl35R2WuMvE/1k0Jlpn/G3r45vx6eUcxgpmD1kT5CA8di5MXGntYPxFBj9yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by CH0PR11MB5265.namprd11.prod.outlook.com (2603:10b6:610:e0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Sat, 17 Dec
 2022 23:39:59 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::288d:5cae:2f30:828b]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::288d:5cae:2f30:828b%6]) with mapi id 15.20.5924.011; Sat, 17 Dec 2022
 23:39:59 +0000
Date:   Sat, 17 Dec 2022 15:39:56 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
CC:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        <reiserfs-devel@vger.kernel.org>, Jan Kara <jack@suse.cz>,
        <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 0/8] Convert reiserfs from b_page to b_folio
Message-ID: <Y55TTKG2tgWL7UsQ@iweiny-mobl>
References: <20221216205348.3781217-1-willy@infradead.org>
 <11295613.F0gNSz5aLb@suse>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <11295613.F0gNSz5aLb@suse>
X-ClientProxiedBy: BY5PR13CA0001.namprd13.prod.outlook.com
 (2603:10b6:a03:180::14) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|CH0PR11MB5265:EE_
X-MS-Office365-Filtering-Correlation-Id: 08e2d942-1caa-4227-50eb-08dae08802da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ciS8MShTrdAqc0sInDWt5kpkpqtJHOHSOEQbYzgZpOhNEYgpIaLEMuWQsglcjKyRkI53106f8FIQIIFGBpptw3eLorWc+albS1MljapYWTbf6QUYbgamktQFVj0wn7LlCdU3rvBpFPLYtfgwYZdXIqt8CRnmBQhrIDh8Z2zjYEXV5LsOy7UBiewW+9w79Ju7Wc2Kz0acD5005CQQAKxh39cgDXzLzA1tRnnlIud/X0JgCdNx2Zak4Z/QaF/RBgMlhtEnC+g2MuKorAu3ssxm+tXYhG9dG7CDqa3xyBvRuhCLsOG2vUXQIFvIGoPUm1NuKpuwctFUjH2rVxvicsqoY7F7LlICABQwCvfeqluRbdwAHuBUoeX/+FKyHKBFoGqwXg9ToFNQNcDKHYkfeJWampx7P7xtwj/JttGBRWjNPQVDupxLzd4dIDDXhMTuO6CDSoJp/dJkHA2SNBEylI1YQk/NCCfhT2mqZzti1O7Jj8aRJJRtTgGg4Pnq837iZoXNQ8tmKsL7tFPBTHBRlgxskzQSHOCZXC7NQd8v5LTShX9y/C8TRkFT3bWrt1U0sBNDtpDN4gvaUygLtOFYCNQ1gFEvb8Ah9Gw5h5tK67JNKz6LjrkjLtJ1NOOhvcmHttUWpEpE0FKXgRH2KhIIJ1yfr4Fpa5wZ6Bwpp7brTI5wiPA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(366004)(396003)(376002)(136003)(346002)(39860400002)(451199015)(82960400001)(38100700002)(66899015)(41300700001)(8936002)(5660300002)(66476007)(8676002)(66556008)(4326008)(66946007)(33716001)(83380400001)(478600001)(6486002)(316002)(6916009)(54906003)(2906002)(44832011)(26005)(186003)(9686003)(6512007)(86362001)(6666004)(6506007)(966005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?exzYjr8gTr9tuvdtjfz71zsYi997KChIBfmbTM77N/h/GQqT/H03+/ck4K?=
 =?iso-8859-1?Q?p/0C9l597xHNuLzgecM0DCcuCGTz1Ruj8a692VQWto0MZLxP04Kd5kedUh?=
 =?iso-8859-1?Q?k2tcjC+Fw5uSb+OTidwUwBjDIPCXic2yBHCDKPmJ+FVf9/2MXSiMNBtm2/?=
 =?iso-8859-1?Q?tXnsUysGOz8NhQKZwrKrYwAlgmU1aJE6GhY9n4ZAFoZBKuJnwh3/pf4jzZ?=
 =?iso-8859-1?Q?db7X+Fg2QBu3hSxr6xDOiiyq9tPCvdw6IxvJo3KluTvzOuBR3Zd7HmZz1h?=
 =?iso-8859-1?Q?ZeVqaNkr7/lbNUiniRW4oDjO2WipxGIpd+vTl9w9cc6I7mR+WG2JJFEoMs?=
 =?iso-8859-1?Q?SmZ20y+OHvwLhDO4K8J8dyiKgd+RBZsPTZpEC12MfHSlGwqNB8pPOGrsAh?=
 =?iso-8859-1?Q?8hX80LB+m9xRA2bToyXYNzfwJmvbYAWFSt9hvX/4i3AQNfAy6+958Ohljh?=
 =?iso-8859-1?Q?BPsOJlfn0vS+SE5tiMoTBRW79jmg3cdFwQKxWOMH2YXIELZoZ0GpgzlkHJ?=
 =?iso-8859-1?Q?xaf+ZxRCO/JZlD8li/MInLgKBOOCilrGnzL5XCNZ/xthij0ZXRgAXqvPCn?=
 =?iso-8859-1?Q?Ax2dn7/1m20MPGTArRRuZD0cR/W5r8Pqc8KcFSi0AnuJX3FgUFQAduQSWe?=
 =?iso-8859-1?Q?p1T7uv1mxbiD7UyVl5AABEwRENy9egNwTf8YA+cV/sUvYgyb9+7zxaEJYA?=
 =?iso-8859-1?Q?PFzY4uKvNIoneIn//Vq4iicOGTl1vOB/GEtFc2+KaadSUxzBHVdVNjwiCF?=
 =?iso-8859-1?Q?SLWB56+HTFcNhzrAqFsSl8LrMZIHVbtoVRJTHqNjecIyOFKMyZ7Apoho+g?=
 =?iso-8859-1?Q?4+reYS676sHmV+LaOytDNzZwMZpnJD9CzPIB8AFs4kSyiskAhTrhPoIZA2?=
 =?iso-8859-1?Q?R4gW7AyREadxcPweILrzuRHSC0z5dLreFpY0CgGZnInPm4nbiEP5CBlQ/G?=
 =?iso-8859-1?Q?UpQUvSK9Ww/11w5WqMitojnSRdcskVz0ok68aKMYOGjTe4bNS33pGosqf/?=
 =?iso-8859-1?Q?2JAr95eoON2vLOh+fqWvZL14c4VqoNo1Zqa8CBLUSYKbyWUa7Wdfx1KWvl?=
 =?iso-8859-1?Q?1ggPJ2D8ZXww6vh9Hekny6zUK5fHO/rdv/tBrlcDCPVYC5+mGI2rfrqsGo?=
 =?iso-8859-1?Q?T7AipZICRwZvKjDG5xZgbogjgEL8ur9l958o8XT0/SPf/qZsmCBfK20H6M?=
 =?iso-8859-1?Q?VEae1Yma09miorYklx+joDrMq4nNh4zuiePsWSyPSwrHdxil28p/uLXJDw?=
 =?iso-8859-1?Q?R0zGGapSmljvdVdRA/F+Wx6zcMP/wWyPqyb5JB2PoXiOqLx2d44n50Pzhj?=
 =?iso-8859-1?Q?i+x2O24Xc//7VmF+zg7CC/kNTdWBvZCRMDmCm+vg82gtSlLhK00D5TBBJi?=
 =?iso-8859-1?Q?QQ4yGEDsyqOe5EJ99LF37TyN0DulXXF/nSo+nEdIrsh/Zlh7R6NV53Gefh?=
 =?iso-8859-1?Q?1SN+jJorc/JCkRC/2Xeh1mY4CfEMjZvpeqC11HLDgf3GmG0BlzB2iT37za?=
 =?iso-8859-1?Q?Gn3TjHL03PfKREqABezuCUROOk48qhbmHNeXG64OMDP1nrHkrpy5VNIz4C?=
 =?iso-8859-1?Q?a91p7ktRCBywfcpE7fuIzOfaFaWBNf8qh6yo9BX2t5ec+qPgrIl0TmzezM?=
 =?iso-8859-1?Q?Vf94ZKR9s/EnlsqdFGexdH4rVPGqEIIAsb?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 08e2d942-1caa-4227-50eb-08dae08802da
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2022 23:39:59.5788
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vcleajBrd3cLbyXfsANTUjc042lAxMFVsfhkAjtSfM+P0tzPIRY/byHSSpQscAS9F/VIBgAmhJsCWQh/fetCXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5265
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Dec 17, 2022 at 09:43:11PM +0100, Fabio M. De Francesco wrote:
> On venerdì 16 dicembre 2022 21:53:39 CET Matthew Wilcox (Oracle) wrote:
> > These patches apply on top of
> > https://lore.kernel.org/linux-fsdevel/20221215214402.3522366-1-willy@infradead
> > .org/
> > 
> > The non-trivial ones mostly revolve around uses of kmap()/kmap_atomic(),
> > so review from the experts on those would be welcome.
> 
> I took a quick look at your conversions and they made me recall that months 
> ago you converted to kmap_local_folio() a previous conversion from kmap() to 
> kmap_local_page() in ext2_get_page(): commit 37ce0b319b287 ("ext2: Use a folio 
> in ext2_get_page()").
> 
> So I just saw kmap_local_folio again. Unfortunately, because of my 
> inexperience,  I'm not able to see why we should prefer the use of this 
> function instead of kmap_local_page().
> 
> Can you please tell me why and when we should prefer kmap_local_folio() in 
> those cases too where kmap_local_page() can work properly? I'm asking because 
> these days I'm converting other *_get_page() from kmap() (including the series 
> to fs/ufs that I sent today).

Fabio kmap_local_folio() works on folios and handles determining which page in
the folio is the correct one to map.

AFAICT (from a quick grep) fs/ufs does not have folio support.  I am sure
Mathew would appreciate converting fs/ufs to folios if you have the time and
want to figure it out.

Ira

> 
> > If these all look
> > good to people, I can pass them off to Andrew for the 6.3 merge window.
> > 
> > Running xfstests against reiserfs gives me 313/701 failures before and
> > after this set of patches.
> 
> It has happened several times to me too. Some patches of mine have failures 
> from xfstests whose amounts and types don't change with or without my changes.
> 
> Several of them have already been merged. I guess that if they don't add 
> further failures everything is alright.
> 
> However, something is broken for sure... xfstests or the filesystems? :-/ 
> 
> Thanks,
> 
> Fabio
> 
> > I don't have a huge amount of confidence
> > that we're really getting good coverage from that test run!
> > 
> > Matthew Wilcox (Oracle) (8):
> >   reiserfs: use b_folio instead of b_page in some obvious cases
> >   reiserfs: use kmap_local_folio() in _get_block_create_0()
> >   reiserfs: Convert direct2indirect() to call folio_zero_range()
> >   reiserfs: Convert reiserfs_delete_item() to use kmap_local_folio()
> >   reiserfs: Convert do_journal_end() to use kmap_local_folio()
> >   reiserfs: Convert map_block_for_writepage() to use kmap_local_folio()
> >   reiserfs: Convert convert_tail_for_hole() to use folios
> >   reiserfs: Use flush_dcache_folio() in reiserfs_quota_write()
> > 
> >  fs/reiserfs/inode.c           | 73 +++++++++++++++++------------------
> >  fs/reiserfs/journal.c         | 12 +++---
> >  fs/reiserfs/prints.c          |  4 +-
> >  fs/reiserfs/stree.c           |  9 +++--
> >  fs/reiserfs/super.c           |  2 +-
> >  fs/reiserfs/tail_conversion.c | 19 ++++-----
> >  6 files changed, 59 insertions(+), 60 deletions(-)
> > 
> > --
> > 2.35.1
> 
> 
> 
> 
