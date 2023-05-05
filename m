Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 777A56F7AFA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 May 2023 04:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbjEECcT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 May 2023 22:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbjEECcS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 May 2023 22:32:18 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEA8B11D93;
        Thu,  4 May 2023 19:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683253936; x=1714789936;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=zOSr303cjIwUHTena+VqXOZ0bAVitmgIR0pWUOXirFc=;
  b=G7iZPiGzzPimvd0AipsdfjcoxS3+H81xNvzko4f9OqHfKFvp9W7jhuqr
   9LQI+qwO3bu31fnwSaIWl6hs9JhjWQJGTpok1cam97Z/XMjxz3WEPC/5I
   XrY8ZJ9BCso2q759Qfo13eR5+dbTSikbGbyoP0vWgjBxlyYsdrAd4CRLO
   vCgSP8hJ86doLkhe0tsIbyth9IEngChvAS29/JB5/we4/cbOrbPVNRVUr
   /zzha5u/VQQM7BwlVs6S2mrre1bqXBt656vrMNFlwuoUdtqQ6w+gTbt3o
   Vms5cVB4ahXMMm/kO0x5YN9krCDZtQFqkhLs/JoFvWzhKEuSHMy1b0Uyl
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10700"; a="333530669"
X-IronPort-AV: E=Sophos;i="5.99,250,1677571200"; 
   d="scan'208";a="333530669"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2023 19:32:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10700"; a="674822099"
X-IronPort-AV: E=Sophos;i="5.99,250,1677571200"; 
   d="scan'208";a="674822099"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga006.jf.intel.com with ESMTP; 04 May 2023 19:32:15 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 4 May 2023 19:32:15 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 4 May 2023 19:32:15 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 4 May 2023 19:32:15 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 4 May 2023 19:32:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HQJdfdNf9jFloj4C+BEZaprdZZ7aj9pPTASCXYI62pUl59YLlOqpvlSlzdadQDSiNcp/3JoV6uMmrdXK7vuFIQQB2MKV6DpRx41JDnxbHk8XPHbYRYRiCrXBUFvPHABMXSWAO3q903eumxBK++1SHSsORImhFAL5Km6kvAWrQHNFyc88DPKCSVdRxz15gRIWwuMCH9KzeYXvdvj2GTxFDXB8hzcmac3wIrUuUPmzmNhpxzqG0QRKrIjMmmD/lIWJeWCF9a7M1pXpiUrxGsBATgE60EXMijiuf/z4OKci8oiEFJ+iKPPfRfoTZ5jHcDp/7VQi7geblVZv0uvZzDwIpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cbX9+DBmRkFwWYLQAfqbaEcz0nY7O4i8J8tqJ3zpcVg=;
 b=IE1LcHdMElbbI8218Z/X+U/M1g0FA0RJIwJsL1M1I6Qosv3SPafAmJD2PQhKQ9vfU+I6g+mPabC60S0aMfRz2Gi5vdkzFIK6cO2fYs3cxDYnQoN6czMjtIUqm7oddiadn4tVftY0ZNkJ5ARdYnLeODbAQIjIu4ONIOqalcD8ov8TMUoHSEa3tBre8ARd5FeV8cKfo3Ni+1jwScWZrCTZQtnfaTCqgBFKwvxAQMdbxmSZUTEnfcN9nVpkpuKX2EZGK39I6Dp9O/YbkXPBsm8Z2wvRT9r2lXTXstANajYIt1+VBBU6C5kxMxy7eHqrlDthj45QA+q55LcrTWxgoUXvQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB7572.namprd11.prod.outlook.com (2603:10b6:510:27b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.20; Fri, 5 May
 2023 02:32:08 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%7]) with mapi id 15.20.6363.026; Fri, 5 May 2023
 02:32:07 +0000
Date:   Thu, 4 May 2023 19:32:04 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jane Chu <jane.chu@oracle.com>, <dan.j.williams@intel.com>,
        <vishal.l.verma@intel.com>, <dave.jiang@intel.com>,
        <ira.weiny@intel.com>, <willy@infradead.org>,
        <viro@zeniv.linux.org.uk>, <brauner@kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
Subject: RE: [PATCH v3] dax: enable dax fault handler to report
 VM_FAULT_HWPOISON
Message-ID: <64546aa46676f_2ec5d294d1@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230505011747.956945-1-jane.chu@oracle.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230505011747.956945-1-jane.chu@oracle.com>
X-ClientProxiedBy: SJ0PR03CA0076.namprd03.prod.outlook.com
 (2603:10b6:a03:331::21) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB7572:EE_
X-MS-Office365-Filtering-Correlation-Id: cda8224b-aa23-48cc-5937-08db4d10ebda
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zkDSIb5QHsa6gfrfmqmmqPvNW9CtBM2BjwrZl1LiB0qWtmLWwTDIQvrYsxzb9fU5pa6/88C6wJUMpDDu7UrVuT3So5kByh9260MXOIxF+J5a9DJ3LtpwTBCfAwC8Jiy/jnxsp1ROiHyzwYoFVM2gOznoFk91UuNagiCDzP8MEvwL1hxEeLNtTdELc2n+Xe96T8F0wpY/1pvqeDN/qTqvEcpbmTIFYVABaW0udOP+nfmtqZhgyXxIwHzntjpTVuosSFBkGpNBs8CrGJNpHPmvdmvZCVScNnIbb5Fyf+Awz22nXHSkIXPh6TDvcbD2ZjOwA1X6StuowtkIwaqtAk/ERz2iskHCHHAiuxGluRrEFmlE66p/1erAdPkmG2DMSsNbP4pIF2b/nSVhQUsa6/8QC2IPdGy4I+VKwU6WlTLY2tX0OkoCttSArQpjIDBky/O5VOJwgqQ0BscILZE59m9GeoTtA9FVef5c30Getgt9hK2+wCPj/2EhxS/4GhFOosZBQ5v/mCqJLOtzH9jEIR7xa5LZ5MIcYRsvP/y4HjjsIKACdtugRe1NIpAMLS4JzM4Ajo5V1LBHfakwVWAC6RpyV1igPswxglQu3Zegfq34r9k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(346002)(366004)(376002)(39860400002)(451199021)(478600001)(6512007)(86362001)(186003)(38100700002)(2906002)(921005)(66476007)(66556008)(8936002)(82960400001)(66946007)(41300700001)(8676002)(316002)(5660300002)(83380400001)(6506007)(9686003)(26005)(6486002)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Jme//KVy4xfZ0qAGRzwOH90EmbZHYD/vUGdFISNjbVsV6MVRabciVWI1JVM3?=
 =?us-ascii?Q?x2bYW2i/PXIaeJYdKK9JczYxg525d0THBhg8BZMiSeLkHbgo3HrZL7qHNtF7?=
 =?us-ascii?Q?c5hTkaTwk0GALSIrOsn2jKnAy2Zu0RVd++COwKR0cpCWHdJALU/xCLdVvxMP?=
 =?us-ascii?Q?J8b0+be/3zSSaQ+A8ORNiMtHEISw9qkvqNfmBbZK9X7D69Ez6TjjmrTgDELe?=
 =?us-ascii?Q?YwcwFop/Ds6w+CRzwLVA01Ao0QMFhFpBFsgSf3dBBhAzrmji7Almt/xtKc/l?=
 =?us-ascii?Q?YZyqMLR0IfNtTzJfovFnEhmLkS+0gJLzP8vNNiw9diRNcRsSs5xM4ZseqkTs?=
 =?us-ascii?Q?R2p1lKXO7VzE3c07vQaZcRYhYlU6ZTNhBD+35IFAmsU8okklOeWEau153elE?=
 =?us-ascii?Q?AnPpiTrfZyGUXPC0Y8yQf0QCa599jJd8FEvSudz/S9NyPU8EyRQmBTT8DKRa?=
 =?us-ascii?Q?gv7Vmqnt4ei2bvk0WdIU94/ZPkTftxxDYUOlH3j2nKqkYWhBNX99EE7Qd08T?=
 =?us-ascii?Q?MCterTe2sfMxsXw11OdZdbNZQAwbCthK0y0IOHl5gLSx/gMeMbuId2rwCAUq?=
 =?us-ascii?Q?1W0LGOHc5DJWnnWhGmnFrZgUkCm/6SfefxHSn0FBO2D/UnEXvfCYl6B2kpUb?=
 =?us-ascii?Q?ueDtjwpMrdYQICE387k7FbeeVd/eaXNLdf6cXB51YXiPMx2+Tw4wrbf+KaMv?=
 =?us-ascii?Q?dIEzjbwj5ICg92kjtbb+/fm42tiek6CVP6ElpCK5LW/kBkvUTVtMnLbgjf1X?=
 =?us-ascii?Q?hC7jKVk1pr6w0ahFyElCZaniVEq1W13/v8xqScv4oRFJXvuzPq76EOrSnkPP?=
 =?us-ascii?Q?K1IXpVHK6pMC0uHvOODUvaGC4s50jUbPwxEwKXjaWW6NwooNRIttQ1/73Q7T?=
 =?us-ascii?Q?Ls9yNZE6khvQFKLDar8VkvtAnjDJaiphaWd9f1iV9PyiyHurX3+wWCyrIv5V?=
 =?us-ascii?Q?d3ivj4GRqIl3iwVwOPXxU1pF2JE3FWVpTJUuio/JgGsMWnMfjJR8R7V5jUx0?=
 =?us-ascii?Q?zBF/29mRJEWZV5GrgqNEjDzQPlJ/tH0vhDJfol/fbv/HIzKxD/frulpHs9Ne?=
 =?us-ascii?Q?7941FSPLvlrYMaDlA9HNyrcjs+ybwdinnb845QpwFWGrkoIJO6eECQLJEkTr?=
 =?us-ascii?Q?2qQjS0Mvq16S8zGvT9/wKg8VM7nERFH4b5kfPfAZERI6oOvAA7uztE9c9C6U?=
 =?us-ascii?Q?OveVtdlGG8AdRAxoFuvxX1IsB24AQC1a+ymF+Lfc8Vz0BEmlS8A1hAhXjq2i?=
 =?us-ascii?Q?pX96fa+CvtSERn4jQnk6fqzoPKclYNby8KwbzJg0M/rx8UE5g4LYJdYujsvp?=
 =?us-ascii?Q?et39fvrCR3lz2F4RqHyeGRwacgkaOfzA5OL0/r10/9aVQcYFGzFrrCP3j0dT?=
 =?us-ascii?Q?zE84Txc2h1wbZC9gUh739gPuqGwndirtixlQvUOBSmm+Q0OULY47/xHARdKj?=
 =?us-ascii?Q?mV6xlL3Ly9GVGExnWni5cquJDgrhbvSsaRKR7GwF8IngKR3B0DYJ09M1nLF2?=
 =?us-ascii?Q?ZLqa2ru5TFxxFo9D7oGonOHiG+ZX58xNo1Rc/o7rYqjaM33atOiRjxVEfnM3?=
 =?us-ascii?Q?BM1nDNQDihb3J+y7VKT7vn4YqwOu0nfKIrWKdORlTV+xI1OqvdQgHDN8epT2?=
 =?us-ascii?Q?9g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cda8224b-aa23-48cc-5937-08db4d10ebda
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 02:32:07.6467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CqIBtWPN1HwgZ8DIFHAvk7LqpU0MrBeDsEXpx157NKQ5+Dxih3TNwbCjZ3RJm2UwkaTKdUL1cnKoyabvuptFJblmDbiDHo9jLIB6OTEqBH0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7572
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jane Chu wrote:
> When multiple processes mmap() a dax file, then at some point,
> a process issues a 'load' and consumes a hwpoison, the process
> receives a SIGBUS with si_code = BUS_MCEERR_AR and with si_lsb
> set for the poison scope. Soon after, any other process issues
> a 'load' to the poisoned page (that is unmapped from the kernel
> side by memory_failure), it receives a SIGBUS with
> si_code = BUS_ADRERR and without valid si_lsb.
> 
> This is confusing to user, and is different from page fault due
> to poison in RAM memory, also some helpful information is lost.
> 
> Channel dax backend driver's poison detection to the filesystem
> such that instead of reporting VM_FAULT_SIGBUS, it could report
> VM_FAULT_HWPOISON.

I do think it is interesting that this will start returning SIGBUS with
BUS_MCEERR_AR for stores whereas it is only signalled for loads in the
direct consumption path, but I can't think of a scenario where that
would confuse existing software.

> Change from v2:
>   Convert -EHWPOISON to -EIO to prevent EHWPOISON errno from leaking
> out to block read(2) - suggested by Matthew.

For next time these kind of changelog notes belong...

> Signed-off-by: Jane Chu <jane.chu@oracle.com>
> ---

...here after the "---".

>  drivers/nvdimm/pmem.c | 2 +-
>  fs/dax.c              | 4 ++--
>  include/linux/mm.h    | 2 ++
>  3 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
> index ceea55f621cc..46e094e56159 100644
> --- a/drivers/nvdimm/pmem.c
> +++ b/drivers/nvdimm/pmem.c
> @@ -260,7 +260,7 @@ __weak long __pmem_direct_access(struct pmem_device *pmem, pgoff_t pgoff,
>  		long actual_nr;
>  
>  		if (mode != DAX_RECOVERY_WRITE)
> -			return -EIO;
> +			return -EHWPOISON;
>  
>  		/*
>  		 * Set the recovery stride is set to kernel page size because
> diff --git a/fs/dax.c b/fs/dax.c
> index 2ababb89918d..18f9598951f1 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -1498,7 +1498,7 @@ static loff_t dax_iomap_iter(const struct iomap_iter *iomi,
>  
>  		map_len = dax_direct_access(dax_dev, pgoff, PHYS_PFN(size),
>  				DAX_ACCESS, &kaddr, NULL);
> -		if (map_len == -EIO && iov_iter_rw(iter) == WRITE) {
> +		if (map_len == -EHWPOISON && iov_iter_rw(iter) == WRITE) {
>  			map_len = dax_direct_access(dax_dev, pgoff,
>  					PHYS_PFN(size), DAX_RECOVERY_WRITE,
>  					&kaddr, NULL);
> @@ -1506,7 +1506,7 @@ static loff_t dax_iomap_iter(const struct iomap_iter *iomi,
>  				recovery = true;
>  		}
>  		if (map_len < 0) {
> -			ret = map_len;
> +			ret = (map_len == -EHWPOISON) ? -EIO : map_len;

This fixup leaves out several other places where EHWPOISON could leak as
the errno for read(2)/write(2). I think I want to see something like
this:

diff --git a/fs/dax.c b/fs/dax.c
index 2ababb89918d..ec17f9977bcb 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1077,14 +1077,13 @@ int dax_writeback_mapping_range(struct address_space *mapping,
 }
 EXPORT_SYMBOL_GPL(dax_writeback_mapping_range);
 
-static int dax_iomap_direct_access(const struct iomap *iomap, loff_t pos,
-               size_t size, void **kaddr, pfn_t *pfnp)
+static int __dax_iomap_direct_access(const struct iomap *iomap, loff_t pos,
+                                    size_t size, void **kaddr, pfn_t *pfnp)
 {
        pgoff_t pgoff = dax_iomap_pgoff(iomap, pos);
-       int id, rc = 0;
        long length;
+       int rc = 0;
 
-       id = dax_read_lock();
        length = dax_direct_access(iomap->dax_dev, pgoff, PHYS_PFN(size),
                                   DAX_ACCESS, kaddr, pfnp);
        if (length < 0) {
@@ -1113,6 +1112,36 @@ static int dax_iomap_direct_access(const struct iomap *iomap, loff_t pos,
        return rc;
 }
 
+static int dax_iomap_direct_access(const struct iomap *iomap, loff_t pos,
+                                  size_t size, void **kaddr, pfn_t *pfnp)
+{
+
+       int id;
+
+       id = dax_read_lock();
+       rc = __dax_iomap_direct_access(iomap, pos, size, kaddr, pfnp);
+       dax_read_unlock(id);
+
+       /* don't leak a memory access error code to I/O syscalls */
+       if (rc == -EHWPOISON)
+               return -EIO;
+       return rc;
+}
+
+static int dax_fault_direct_access(const struct iomap *iomap, loff_t pos,
+                                  size_t size, void **kaddr, pfn_t *pfnp)
+{
+
+       int id;
+
+       id = dax_read_lock();
+       rc = __dax_iomap_direct_access(iomap, pos, size, kaddr, pfnp);
+       dax_read_unlock(id);
+
+       /* -EHWPOISON return ok */
+       return rc;
+}
+
 /**
  * dax_iomap_copy_around - Prepare for an unaligned write to a shared/cow page
  * by copying the data before and after the range to be written.
@@ -1682,7 +1711,7 @@ static vm_fault_t dax_fault_iter(struct vm_fault *vmf,
                return pmd ? VM_FAULT_FALLBACK : VM_FAULT_SIGBUS;
        }
 
-       err = dax_iomap_direct_access(iomap, pos, size, &kaddr, &pfn);
+       err = dax_fault_direct_access(iomap, pos, size, &kaddr, &pfn);
        if (err)
                return pmd ? VM_FAULT_FALLBACK : dax_fault_return(err);
 


...and then convert all other callers of dax_direct_access() in that
file such that they are either calling:

dax_iomap_direct_access(): if caller wants EHWPOISON translated to -EIO and is ok
			   with internal locking
dax_fault_direct_access(): if caller wants EHWPOISON passed through and is 
			   ok with internal locking
__dax_iomap_direct_access(): if the caller wants to do its own EHWPOISON
			     translation and locking

>  			break;
>  		}
>  
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 1f79667824eb..e4c974587659 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3217,6 +3217,8 @@ static inline vm_fault_t vmf_error(int err)
>  {
>  	if (err == -ENOMEM)
>  		return VM_FAULT_OOM;
> +	else if (err == -EHWPOISON)
> +		return VM_FAULT_HWPOISON;
>  	return VM_FAULT_SIGBUS;
>  }
>  
> -- 
> 2.18.4
> 


