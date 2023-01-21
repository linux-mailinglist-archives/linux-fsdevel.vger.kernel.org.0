Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3C4B6764E3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Jan 2023 08:15:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjAUHP0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 Jan 2023 02:15:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjAUHPZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 Jan 2023 02:15:25 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0BCF6E0F6
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Jan 2023 23:15:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674285323; x=1705821323;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=QprPyQm7Y6ypy/K67arBPrrfKEULSmPBZp2Po7Dyq70=;
  b=Vc+fWwxOpo7qRM5vPxfndc5StaaqHLMb6kefCVBzjB43JtNj2LE2+FCX
   HGjYpLZIL4fQBInnqb/vQdIbaVQ1wQv3Rjvz/Tbmn3o54NKWxqf4v4tW/
   31Copi1vOdDfSBZJaG1EIPjonIWWUPZMRSOKEqyrcmXm0/4uGew1elHmt
   7BVtqaIj8Ru4U1ebcC5EZxSX0ZGq574+C+Xod6ynkOh0qau5d/d0m6A86
   ViZEwodP7cVc/fC+OHOtcavSJVE0RNMuK2jtNgVaPOTVhXTQEKbkDgdKL
   FVm58RHdgXj6bFEbjBfh4gMo30vtRBCDqTjc3GDUwFGON/E7Qkm0PHcCa
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="323454414"
X-IronPort-AV: E=Sophos;i="5.97,234,1669104000"; 
   d="scan'208";a="323454414"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 23:15:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="768963162"
X-IronPort-AV: E=Sophos;i="5.97,234,1669104000"; 
   d="scan'208";a="768963162"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga002.fm.intel.com with ESMTP; 20 Jan 2023 23:15:23 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 20 Jan 2023 23:15:22 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 20 Jan 2023 23:15:22 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 20 Jan 2023 23:15:22 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 20 Jan 2023 23:15:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QBUs5s+lWsAkwOgwun2fu2tDUD3E+3mjOlZb1jgpWO6RZ4lztEcNaABrnmsaD240AoYu6Sfv9UWFrYVkeoKRwFg9ud4YyrvsQrljRH3hJeqZis2BlaKtUTTrVGE/e7RMY7F9rnwCqyQWVIi7zbBWOTeU6+sDKlb9edBg5EE60hL7uST6KGLH3YaIraPBbMR56t8Lzcj9GXtIT8CTu6X/Bz/QM4tvG5ofOz1w/PafQXnKFtONvWmPPT5C7hAcl+1pjHA76Lqx+CpMb4Rqv0iltbcdWIJ4oVPG1vYvJw4x0wWZo0WBUfJcW3Mige3KEI+61iNNRGA+r8O3cPqYLztagQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pQEXk/RLWzELdtFz+m9nuwbMfKv0x6TxQYCkNtEZj1A=;
 b=VAg4nVTDCpa3L9ulb+dCoWQtSQqzQWFq8scfq/XhCSkVXQG0w3ZGwTyEyOYFU+FS8QZ47oVXQs6O2OsZocL4xdr3CyALsQMOV8wV8JcPN5akPNM/8KZK/uTSBdalG3grqbZYbmjRJP+te30UDjsPbkmR2hMqe5hK+mApkDqX4vO5f6V+6fwDDj5iBp1KcX01N6yMpMP8PSA/sI6d7ukpLtys9gmMOIhrmpvlFMuO3q4ikdIJPbwbFGbmOZWqBTupmeEJI3PdEAAhIX8QdL3+KzjKyXVb9RbYWUbw2lRYMp/Tbl9L26Pla59btA9zLgeEmBWSGh5sE6V1nL0ZgqOXGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by IA1PR11MB6418.namprd11.prod.outlook.com (2603:10b6:208:3aa::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Sat, 21 Jan
 2023 07:15:20 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6851:3db2:1166:dda6]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6851:3db2:1166:dda6%7]) with mapi id 15.20.6002.027; Sat, 21 Jan 2023
 07:15:20 +0000
Date:   Fri, 20 Jan 2023 23:15:17 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Matthew Wilcox <willy@infradead.org>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>
CC:     Ira Weiny <ira.weiny@intel.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: Re: [RFC] memcpy_from_folio()
Message-ID: <63cb9105105ce_bd04c29434@iweiny-mobl.notmuch>
References: <Y8qr8c3+SJLGWhUo@casper.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y8qr8c3+SJLGWhUo@casper.infradead.org>
X-ClientProxiedBy: BYAPR07CA0063.namprd07.prod.outlook.com
 (2603:10b6:a03:60::40) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|IA1PR11MB6418:EE_
X-MS-Office365-Filtering-Correlation-Id: 4de5d485-9077-4cd8-6ec1-08dafb7f4111
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mz3xaKPpnCgnXHe5O1MuBGE8spblcDUSU0w57rbJH7DwS6RuUkKfy+ma3JIi2lOMWS3yax8nHijrvMqjAcRPGFsPie5u8jt9FjkGGc0nl2CG2bqaMQvnoxNamuBIV1BjkH0sGVO/REWaBXsHj+L9G5LoBwtZsE5l9+7vbetk2xbUD+1zB8h2rApTj0LpJvgP1NynF0FLGLXwVC42iG7vGSSD16LaQvd2cJRd2cDNpVrzmZ6NnEAuMfunyVI0ccHCr3/OiUB/ViqB5f/9IADBuTJqKXPglikJ2gBx6W7ibq1uBRs2rpPx0T681kBrQQRizPwm3vcnmDajjpYt82ZRi4zZmw1a+zCy37QsOF92X1TYFZ7hbjUy+LBycOfgIkKpCJcQpf/YVknsEi3VEIXZ/s693GEwnmttmXdW/kVpV3863xsCP9345FwCKOGe22mCc0DkhNqSzJPTPWfkQVk2Gg6XYZsZjJp6k2k9xNCZCoUWYw3hx2zCuPkRUkEP/6cWfZcRtDO4/Y1NyoCQcr0srgouJOgIUs/eaYgvijVU6vj1jLKEXmwz87xktrs/JW/o0aPU2TkvKmReAQk6o87fsF8N2UTuem/XdRxBBNEGh1TIL3aUpH7vze2wVwa3KYiFhF1e4g5VgflFsGtE3yqxRw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(376002)(396003)(136003)(39860400002)(346002)(451199015)(82960400001)(38100700002)(86362001)(4326008)(66476007)(66946007)(66556008)(8676002)(41300700001)(6506007)(44832011)(316002)(5660300002)(8936002)(83380400001)(2906002)(478600001)(6486002)(54906003)(6512007)(186003)(6666004)(9686003)(26005)(66899015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0OQL07A18snNYbG5MoBDGWkUUzk3GN84v4+og5rs32yKVfFz3HAckkzE0H7c?=
 =?us-ascii?Q?chNwnH+24vQQ+sK4XYeMrsx66bLNQVegV53LIBxTmrTUazCgqz3BisWMmM/U?=
 =?us-ascii?Q?novGEIAEvrdH+hRBL6ALTuRQy60vNxlJwjzO80yfz4TzMKfkfI38DOR2ZKLx?=
 =?us-ascii?Q?e9vhCHXLV1+zjw4hD3FROM+lyX5/TWCc1e4RSqTytENEs2Ya93gSQdBlZhae?=
 =?us-ascii?Q?mzRrtnvbBj1OmgiHn8dXYqUwHr13zOnoKdYz4u/cleo3FcDV1xJbal/IWAUK?=
 =?us-ascii?Q?aBOAK/N9H7ZyC/UzMZSEl3G38tw3vDitbzgrDPQoDkK1FQDO/wWG3a36lDWl?=
 =?us-ascii?Q?81TYarC+IQxau3Uz/ssj3pSlmZGpy4UQ4UC+m9IcpG/Wq9hjesN1a6sI12LR?=
 =?us-ascii?Q?uVgBe8aZYesTbUI2r66T+RsoUPLU4FP4++gzgnc8zhK6sH7cv7w7MJydLj1m?=
 =?us-ascii?Q?/HUKHuOCHK5Mbauq1hoM83Ay+OkVZ4mRz9gFR5h4zaexpOwu5x0tM2cm/J2O?=
 =?us-ascii?Q?xZNOEYtspuDNSb87NHhUrKUpkfvdxNdKsq6YjmbKU4irhgT+Z+g1U6YAkMkj?=
 =?us-ascii?Q?+f26wR9EvTwTf7aM7/o/A7Nf0PTCFtTRYvoLdiUstKaRutERgCs5rjgBWd1W?=
 =?us-ascii?Q?omKuWR23gQXdKot7zJUQ6JESwGL1BgzBXoPav+LZEetVvTeR6sAKTwTirroj?=
 =?us-ascii?Q?31iFwr4Z1OyvQymjdWdFOIyRXez/xkLyqwFAXU53AGbWypD3jT69l9Dzv/mN?=
 =?us-ascii?Q?DEmK+1rtsfpLHf88ANzfW7PqY/0njWgiwNEz1rUZ6im2AV6CiCT6SzfUduAZ?=
 =?us-ascii?Q?1eSlfZnwkuyEN8LlqDSxINOkQ2ieWEzp/YPZUmKAKFGb5NQSibQNiEaZF3Qy?=
 =?us-ascii?Q?lsIGfYLu7xbHxctOlBhV2JoQaB7cn3oeQ7FHVzOfS3QHjnaaLG7gjDJcbVWY?=
 =?us-ascii?Q?XCnN4ncHQsvFYHeZxMVjPdnyXpoeZu6SCXAcksdOglIzcbblWRv+hhY9bVaV?=
 =?us-ascii?Q?kdi6MiKXoppcZpDMwMnf5JegmL97ArPGoaxviE7x/4hEudfqOa2aeBuOkhe2?=
 =?us-ascii?Q?fHdHGgsv2hNDy5GsNJKR+COaAJkMxYXpYpjMLrRIpWAoCckSWA6oDR6WhYTc?=
 =?us-ascii?Q?sUqxFXQfKTr6wDZlUoKX/bouFVpohBgHKYRsJDHY4bQXNEHRozSCQ+gAduOm?=
 =?us-ascii?Q?9V256fatXc+YpxpVszgKjk/bBsMwqdUi1x0pswn8+Sk395mniH+A56VeWP1W?=
 =?us-ascii?Q?zbWFJ2OZw69vERkUXQ/rhM0LcliohFeAtb8WR1GwmDca6FfNULrjWmCRYFQI?=
 =?us-ascii?Q?n/zRPC3A8pGTcBPjxWIvkpQ0tdzcReYUFkx3OzDIe6VIS7yNeSPkCnMES7S/?=
 =?us-ascii?Q?jmEZy0hNll6hmynoxRzCO4WKJfCTxQ+1pbKzs/zumefxNAhYgZSMVdSPS9h7?=
 =?us-ascii?Q?dTbOzgsYZA18hI3672Y5huVaRkABP27HFrjHIxpmIzuqNw6Bp+00mMhvMs/a?=
 =?us-ascii?Q?/6qqoSGvO5HA1FEaPAW1TPS23s77zkSC2keCYO8J6C6d2Il8BdWVMDgieHUH?=
 =?us-ascii?Q?3uZJzJRR8WtFfU2sgLaRdeLB9G5qe5AZ2SdqnnaM?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4de5d485-9077-4cd8-6ec1-08dafb7f4111
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2023 07:15:19.9613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s51PnBx4L20WByWThMYfodq7XcOzMoLT3sZqAeSyvPwmIJ70pR6uvfTJYKjZggbhmwOK4WafS98pWJKCGdmZug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6418
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox wrote:
> I think I have a good folio replacement for memcpy_from_page().  One of
> the annoying things about dealing with multi-page folios is that you
> can't kmap the entire folio, yet on systems without highmem, you don't
> need to.  It's also somewhat annoying in the caller to keep track
> of n/len/offset/pos/...
> 
> I think this is probably the best option.  We could have a loop that
> kmaps each page in the folio, but that seems like excessive complexity.

Why?  IMO better to contain the complexity of highmem systems into any
memcpy_[to,from]_folio() calls then spread them around the kernel.

> I'm happy to have highmem systems be less efficient, since they are
> anyway.  Another potential area of concern is that folios can be quite
> large and maybe having preemption disabled while we copy 2MB of data
> might be a bad thing.  If so, the API is fine with limiting the amount
> of data we copy, we just need to find out that it is a problem and
> decide what the correct limit is, if it's not folio_size().

Why not map the pages only when needed?  I agree that keeping preemption
disabled for a long time is a bad thing.  But kmap_local_page does not
disable preemption, only migration.

Regardless any looping on the maps is going to only be on highmem systems
and we can map the pages only if/when needed.  Synchronization of the folio
should be handled by the caller.  So it is fine to all allow migration
during memcpy_from_folio().

So why not loop through the pages only when needed?

> 
>  fs/ext4/verity.c           |   16 +++++++---------
>  include/linux/highmem.h    |   29 +++++++++++++++++++++++++++++
>  include/linux/page-flags.h |    1 +
>  3 files changed, 37 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/ext4/verity.c b/fs/ext4/verity.c
> index e4da1704438e..afe847c967a4 100644
> --- a/fs/ext4/verity.c
> +++ b/fs/ext4/verity.c
> @@ -42,18 +42,16 @@ static int pagecache_read(struct inode *inode, void *buf, size_t count,
>  			  loff_t pos)
>  {
>  	while (count) {
> -		size_t n = min_t(size_t, count,
> -				 PAGE_SIZE - offset_in_page(pos));
> -		struct page *page;
> +		struct folio *folio;
> +		size_t n;
>  
> -		page = read_mapping_page(inode->i_mapping, pos >> PAGE_SHIFT,
> +		folio = read_mapping_folio(inode->i_mapping, pos >> PAGE_SHIFT,
>  					 NULL);

Is this an issue with how many pages get read into the page
cache?  I went off on a tangent thinking this read the entire folio into
the cache.  But I see now I was wrong.  If this is operating page by page
why change this function at all?

> -		if (IS_ERR(page))
> -			return PTR_ERR(page);
> -
> -		memcpy_from_page(buf, page, offset_in_page(pos), n);
> +		if (IS_ERR(folio))
> +			return PTR_ERR(folio);
>  
> -		put_page(page);
> +		n = memcpy_from_file_folio(buf, folio, pos, count);
> +		folio_put(folio);
>  
>  		buf += n;
>  		pos += n;
> diff --git a/include/linux/highmem.h b/include/linux/highmem.h
> index 9fa462561e05..9917357b9e8f 100644
> --- a/include/linux/highmem.h
> +++ b/include/linux/highmem.h
> @@ -414,6 +414,35 @@ static inline void memzero_page(struct page *page, size_t offset, size_t len)
>  	kunmap_local(addr);
>  }
>  
> +/**
> + * memcpy_from_file_folio - Copy some bytes from a file folio.
> + * @to: The destination buffer.
> + * @folio: The folio to copy from.
> + * @pos: The position in the file.
> + * @len: The maximum number of bytes to copy.
> + *
> + * Copy up to @len bytes from this folio.  This may be limited by PAGE_SIZE

I have a problem with 'may be limited'.  How is the caller to know this?
Won't this propagate a lot of checks in the caller?  Effectively replacing
one complexity in the callers for another?

> + * if the folio comes from HIGHMEM, and by the size of the folio.
> + *
> + * Return: The number of bytes copied from the folio.
> + */
> +static inline size_t memcpy_from_file_folio(char *to, struct folio *folio,
> +		loff_t pos, size_t len)
> +{
> +	size_t offset = offset_in_folio(folio, pos);
> +	char *from = kmap_local_folio(folio, offset);
> +
> +	if (folio_test_highmem(folio))
> +		len = min(len, PAGE_SIZE - offset);
> +	else
> +		len = min(len, folio_size(folio) - offset);
> +
> +	memcpy(to, from, len);

Do we need flush_dcache_page() for the pages?

I gave this an attempt today before I realized read_mapping_folio() only
reads a single page.  :-(

How does memcpy_from_file_folio() work beyond a single page?  And in that
case what is the point?  The more I think about this the more confused I
get.

Ira
