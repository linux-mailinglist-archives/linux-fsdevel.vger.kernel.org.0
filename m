Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECF4063CE3E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Nov 2022 05:12:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232474AbiK3EMc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Nov 2022 23:12:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232385AbiK3EM3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Nov 2022 23:12:29 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E5A1F2F4;
        Tue, 29 Nov 2022 20:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669781546; x=1701317546;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=FCe+ggnPOTosDVHXgqL2aUHH69GmXEhCPa+Zjcy7Mos=;
  b=JmNQHmHijcWbn3x9SiBDcJW5oStxj1nYV7mrCzIV9Npos7P2PWtnBOmR
   8+lzXaM0TxvWNPnKbu1AhRlc0nQ7i3o/p8YBMCX9HuohQ3d7oboXORSa2
   gQADraUtRnjnnQUj5T2Wy4p28+PgzTDyjXEYT1S9MZlTlMZj5GbZyWwlV
   Zumlt90Dh3QS9xq39WC5x3tgveTifrKtOY742ojIqjTGGC5RAiEQjhux/
   vsLVOHJIGfP7MuSZ2HCn+GmPE4MbnfeW6Ib5RGWlqzQXQJQWTO/Q/5nQD
   BpqtV0qvgbJDEGmsLpCCKiDoS5IFNskBXsYRGXjKi6EoA00QtISw0kM8B
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="312914291"
X-IronPort-AV: E=Sophos;i="5.96,205,1665471600"; 
   d="scan'208";a="312914291"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 20:12:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="621731957"
X-IronPort-AV: E=Sophos;i="5.96,205,1665471600"; 
   d="scan'208";a="621731957"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga006.jf.intel.com with ESMTP; 29 Nov 2022 20:12:25 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 29 Nov 2022 20:12:25 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 29 Nov 2022 20:12:24 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 29 Nov 2022 20:12:24 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.103)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 29 Nov 2022 20:12:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VwcVfYMney+BBlXg5XmNkgkNU+8+qiG3VN1OBwKMT3seq818Ln0rrO07J+CBijvwCXTeYQtabNEY3tTRom31Hc2pGY4CqpyXMP4OGGGSUGPzYPGpWjj2Gzutc4VBNF/sDYYfxqLCe4WcVbGbljiVMG5drA1MKoN0GLnloXm4Zk5j3zvTLWk8efuB+yoX3OZ3UzbqFWYlo/zpkj4CvYwxuVHG1NK7qvkRnFmlEKzJrIJpNfxtBncfQ4PbFMUawOjCZ6BMxssfWMMOgbfsjemajjfSoylFAVDiGwplJBhuwM54x0uJ1LDYbvud9bIBGy/4NU74chyoCRx7/7GyJoJOaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sLauvTcUWy2xIET4K7aV4UT93X67B6eNLQBShcJRWR0=;
 b=QGGKfCw7gGbBuYeIltbv725pK5qrQo2PT3l2Qnl+tL4ypTW3LE0KV9ouIMkQHnT1z+LLbDWXs9ocdS5IJaVVPObhg5gAzeBD1mPFw83Q3u8/lnQ7yC5SgfTYXWH3y6FnWPONEEUJDVfV2O/uAfOfk8nAu3/gf+/gK9f9kui0955aaFO4OlYH53E5dKbeUy0BkwsOkKMFK0cywLDLpyr9GW+Ekt8rDS2yyVlIFfLzIulzpZQtFkPyakttsNSYuCVX2k1MB9kK3LaNczsRpVwO+Wzsfoqjpqpnrv1nBUgkvyJuPFsBGZrfUfTbGSbuAQoE/+lY02BZ85a5RAm/r5fJYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by CY8PR11MB7799.namprd11.prod.outlook.com
 (2603:10b6:930:78::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.6; Wed, 30 Nov
 2022 04:12:22 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b%9]) with mapi id 15.20.5857.023; Wed, 30 Nov 2022
 04:12:22 +0000
Date:   Tue, 29 Nov 2022 20:12:16 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>
CC:     <djwong@kernel.org>, <david@fromorbit.com>,
        <dan.j.williams@intel.com>
Subject: RE: [PATCH 1/2] fsdax,xfs: fix warning messages at
 dax_[dis]associate_entry()
Message-ID: <6386d82011018_c95729485@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <1669301694-16-1-git-send-email-ruansy.fnst@fujitsu.com>
 <1669301694-16-2-git-send-email-ruansy.fnst@fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1669301694-16-2-git-send-email-ruansy.fnst@fujitsu.com>
X-ClientProxiedBy: SJ0PR05CA0080.namprd05.prod.outlook.com
 (2603:10b6:a03:332::25) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|CY8PR11MB7799:EE_
X-MS-Office365-Filtering-Correlation-Id: 57bad7e4-f8bb-40a4-1dac-08dad289147d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q1P6af0sCHy3RzA710KQxVd1SoX/EMBiMeq8dCQn5qwv/yE+baLKGUkY+oi12rVMSWfJxKONiv2mgrKOYDGmPoiqUGqxS6AiJqIighIaud6CJJa6ra9GaJ6tvY48B/tlsO1yL6kvavjUOtcHblLLVu5JxIcOhHmsB4G4XnMJTOtfn/8tGTCgeQdGtx4FyGWo0LsHYjIkUraDcjbf6ivbFPeYn8CVMzTxOyORaR2GQ5T6IG3hA/1PC702LknH8Hcg7hQ1y521MwHQVJWWfOHI3bgdY6cOgVVgUSYZZ2+8bGNbjpS1oazF8dPqqqY2XW+nCTIh2z2T3ZoFGH+QpzmSltlm1xKVc7/vhHPQqUVHwR7zrtrT8pQjcoehk2SJWwe1ng+6QLD4PGLk7ZsjIYJ4ART8R8zgVcBzNjICU7Ko6FjRj6mgFdvzKWTSvqw77ywv23aWbHyQ5hHR7kO3qdRDx0ZtKa9IMHKFxq6WH3ET7kNID7QKKEkwnV4lTQ12AuX1twDWu1MUppSNjRtq6+XRJgPyQ6AzYawD3gNy96U4lDGTNE3P1rMcSvlQ1m7Ncy5GG8h6mbCFWKIwzmloSiFO6cc6En84txSyK72zl8y4c/k1P3GhICwSbvNSncL9myp/CpkIHXQM5teE8Qpt0K+4rA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(376002)(396003)(366004)(346002)(136003)(451199015)(38100700002)(83380400001)(86362001)(2906002)(82960400001)(41300700001)(15650500001)(5660300002)(66476007)(8936002)(6506007)(6512007)(4326008)(186003)(107886003)(26005)(6666004)(9686003)(8676002)(316002)(6486002)(478600001)(66946007)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VnZIwVQWtpFTgVQspypLuI1Jihny1VGKjkf03w4kKnm/5f4WmO0vvRi9IiKT?=
 =?us-ascii?Q?iSI7XmAKXfwmPODODpxrP9GDxLfHiV3dGwRmlsgJE9rrEylv65TsBuanSYRu?=
 =?us-ascii?Q?qWyw9b3//dvl4lTrUREZ5WdJP2v1YohFwiwaNlgIH5PedJU4Vr05LOuFotDk?=
 =?us-ascii?Q?JhwBadrLESI2vkYXutj4XN47jEKh5lJtG29sLJmVBjSP34Tv/YpQS4H0M4X+?=
 =?us-ascii?Q?8hMqexNMbdEnpEVinbSqfr2l6LDPk9R4aOstnGJlA7lUa8WyYUujtzwAFjya?=
 =?us-ascii?Q?/DUXJdPffTs82RDjvCBQNT6BazbfAXdZkpqsrEuSg0+mAqt/iGhgQrEPdEJj?=
 =?us-ascii?Q?iX46k7eHVW/5cLkuoj1MVLSytJcyAN/9hpP+GXrYluc9+6ZToQ3CbRMiaRav?=
 =?us-ascii?Q?KSM4mKE/2z7XdIR5j2NXV5CxZg8U5wURiwgJj2Vf4x6+cHUUwQzZ/PmPEfnm?=
 =?us-ascii?Q?u359H2Sha+3xTPDFOE/mixr82s+d0OguoGlhdGDrgYaeg8dROMIyHzNF76Yy?=
 =?us-ascii?Q?/HaC45njxnyyEAetrtS+oDidoFomB5+QiUgsFr3ReKGmPqxdGbUt3tepDZG+?=
 =?us-ascii?Q?QFCDOZl5TprrQ5FFeJuuOO/ezjz2AP36Jbymu5cREIAdJcSvpXkgO+FctwmQ?=
 =?us-ascii?Q?eqSV7XyrB6xagskieQyURXDi921dkr/EnVZYWY5mlAsCOUY43ChXPOUd7ege?=
 =?us-ascii?Q?P1VbEtwDtIXKaEbv10lwmIrfMp/i0Q9aKi7BrME82VxNzM+KiGprkeUszvU7?=
 =?us-ascii?Q?SedJKBDRNS13wZIG4r3kY+o2CvNeGJ6RYI+c87ks9ih4ElM/GKC5aY33iyJp?=
 =?us-ascii?Q?p/G9/AsLl3UCKOlcLwTJsGasz6vpDPLI6O3QsSB0W6d0s6lAltm+/eBSskhE?=
 =?us-ascii?Q?lbtW9knRnZ/Lyj5pvhe/eMowLjqcS7O7bhIR+uUw/n1RkuFj2v0Kr+lZjj+K?=
 =?us-ascii?Q?6L3LgrRZ/Y9GdH78RxXSOVA6G+W29nLQ7npgr6ZYKJuL89vEz7Puo8t/bopc?=
 =?us-ascii?Q?nsMxq6KjCjx8aex7MYfJ7bqqsRNa4b84L3akVNSoC+gBNEyZK08A4kNmdmFn?=
 =?us-ascii?Q?0V4bvE1wOV5aVqu+i9z56zfR8Sth487zJ8QXI660GPV5vRtb6Oq1tC8J0V3r?=
 =?us-ascii?Q?PXiTjYkX2VRKqKArsVj+FzgkTkhY88cJseWd0zq5VTYPsZCedroSpI2f5L6k?=
 =?us-ascii?Q?aT464FqqrsutnD82P7Xe412AqhHNHfAS9UKuQFGbMiDQJz5XmtEgqHw3XDit?=
 =?us-ascii?Q?DxZmK38CpynxDgwJYjbl9Ig8QfXOOriY35schB2xboIMQkqmRE2VkiZ9oai0?=
 =?us-ascii?Q?ZLlarn936hQIMid/5v9d1XyIf2PJXWFGEeA8wGmfKTmlqVpTwH0B7SgCF421?=
 =?us-ascii?Q?qDitLNVpjr3skzC8r8RhtEsYjRvefMf0bpTYkTn/oRRegEysC68Pdu9JvvIl?=
 =?us-ascii?Q?MAU7Wutsdl1ZpMIBIpRIPo66bTv9dNJb5Bu2X5LOXwN3EkPtLBy3KD+o7VxH?=
 =?us-ascii?Q?tbSZE5BZmqCw+At0JCUCuo11dLAQMUP71DXzH/Pcxi9cLRwgfHgssObU+Oh8?=
 =?us-ascii?Q?9TovpXyV0IeVQVEbFX1gO8Xl8qSaFUjMCmHbpXfbuNSypRSqptJnDaN+QhC3?=
 =?us-ascii?Q?Gg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 57bad7e4-f8bb-40a4-1dac-08dad289147d
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2022 04:12:22.4317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jKHp0hxkqD32aLjdba5LQ79MiCaNSpoAzzSMkeU8qKNvfagVmNgihBi36z02FsPG/m1AbCYs0wDmU+RsrPWjtYqF1HanfcMlJJ16UXLXvPk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7799
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Shiyang Ruan wrote:
> This patch fixes the warning message reported in dax_associate_entry()
> and dax_disassociate_entry().

Can you include the xfstest test number and a snippet of the warning
message.

> 1. reset page->mapping and ->index when refcount counting down to 0.
> 2. set IOMAP_F_SHARED flag when iomap read to allow one dax page to be
> associated more than once for not only write but also read.
> 3. should zero the edge (when not aligned) if srcmap is HOLE or
> UNWRITTEN.
> 4. iterator of two files in dedupe should be executed side by side, not
> nested.
> 5. use xfs_dax_write_iomap_ops for xfs zero and truncate. 

Do these all need to be done at once, or is this 5 patches?

> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> ---
>  fs/dax.c           | 114 ++++++++++++++++++++++++++-------------------
>  fs/xfs/xfs_iomap.c |   6 +--
>  2 files changed, 69 insertions(+), 51 deletions(-)
> 
> diff --git a/fs/dax.c b/fs/dax.c
> index 1c6867810cbd..5ea7c0926b7f 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -398,7 +398,7 @@ static void dax_disassociate_entry(void *entry, struct address_space *mapping,
>  		WARN_ON_ONCE(trunc && page_ref_count(page) > 1);
>  		if (dax_mapping_is_cow(page->mapping)) {
>  			/* keep the CoW flag if this page is still shared */
> -			if (page->index-- > 0)
> +			if (page->index-- > 1)

I think this wants either a helper function to make it clear that
->index is being used as a share count, or go ahead and rename that
field in this context with something like:

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 910d880e67eb..1a409288f39d 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -103,7 +103,10 @@ struct page {
                        };
                        /* See page-flags.h for PAGE_MAPPING_FLAGS */
                        struct address_space *mapping;
-                       pgoff_t index;          /* Our offset within mapping. */
+                       union {
+                               pgoff_t index;          /* Our offset within mapping. */
+                               unsigned long share;
+                       };
                        /**
                         * @private: Mapping-private opaque data.
                         * Usually used for buffer_heads if PagePrivate.

