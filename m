Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4585D7A1640
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Sep 2023 08:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232366AbjIOGjq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Sep 2023 02:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232231AbjIOGjp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Sep 2023 02:39:45 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C7A2701;
        Thu, 14 Sep 2023 23:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694759978; x=1726295978;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=SqEO1q33yHRvCpHPoQpO8Nj7ZsCMuLR2UvC+IIj4eKE=;
  b=l0qGsJU5pYHZg+KVysM3yj0jWiXOtuK2BPxcf+nVMnXae+yW5+vpXlDm
   U7XcrrAboHpOoxw0xTD3fEylWReO7AvUPRBVbyyZNb76mM1Qq3NfkzssR
   P5a19B2LDOimhauXGP2Tgwe+vPqE5T6nQy3Zxn92pesFUSuDRZRW22Biu
   vfDpteT8Jb6Ufji4jZCAxiCMwcYrpqeF3OGBMdslT6OkX/XRKkZ3fCcfT
   IFoOQDhEvqzUYL0usAlnGJaIhlgoCGZLhXG8Mm6zPqsHSdX8iIed88DZr
   9MIHGBoY96+NBQGnSEKq/EqpxPLuvSJvC5Vo0SbaYDod8aMvntUmBfPEM
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="358587469"
X-IronPort-AV: E=Sophos;i="6.02,148,1688454000"; 
   d="scan'208";a="358587469"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 23:39:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="888119276"
X-IronPort-AV: E=Sophos;i="6.02,148,1688454000"; 
   d="scan'208";a="888119276"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Sep 2023 23:38:57 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 14 Sep 2023 23:39:31 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 14 Sep 2023 23:39:30 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 14 Sep 2023 23:39:30 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.107)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 14 Sep 2023 23:39:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KltgjbSqvZSu3M/hO7dvoFGAZkcC9X4bRkTqhmdO5OCVN1RFHgybXvDZ19RCaSDgFrI4GKOAsgnpDNdVsYfzy9y7881ky168jCCFlIa1YrgEBIvzuuvVnniB72GWLYEBuhRaqxUQosntstf2SzAk5cWnype+5Gma8xu6f1ink06kctIqtiR0MvBN+jRqCVU399LHALodWZrfN0yMZwSwJ6An771aBx/WrqZnaT9zWgoBnnhMHXdBD5xd7DgBshaNON7CXsvyJxb9wDfmjYWeGbQsuCv5Er08U6sTTNUZ2774G694FQMtKRAi14LmKsrODwFgWQ3Ug1R7eS7sKZ2Gsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uDNWp7dMCdOr1KSS0slekM3Q8lsOC0AP//2RE6MPJ4w=;
 b=aXQ3gutK4pJgSvQL6XR10qgDqLAA2YyXkYxZG47A4MzXE0Csc4dIW65R5u3SD9lMKL3rWM5+SBXb/naPwHc9s9MKsn9tQMMnhC0YEb5yuASkGAUl40qnwE0OFd4b2Un+HoVnyGcqORWio3sFR/GmkgTF3CnoNZJ7p49JAkRnAiJDeBoabQcRibVbMMZ9ElgitkoIIRy6H4aoemwNf709wGtnJixA5X6NjBebLSVFkFp8BjYRutYMNAgpHzSkspXtr1C7DG+TBPSuQDVYDkWdqITKeDGqLP7Zc2mYpXdueWoHtdwzBB4aASy6ebrIfBh3hlwHu0/qmvlzdbubM+bQjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5966.namprd11.prod.outlook.com (2603:10b6:8:71::6) by
 DS0PR11MB7579.namprd11.prod.outlook.com (2603:10b6:8:14d::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6768.34; Fri, 15 Sep 2023 06:39:22 +0000
Received: from DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::5e79:2d52:51e:f602]) by DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::5e79:2d52:51e:f602%6]) with mapi id 15.20.6768.029; Fri, 15 Sep 2023
 06:39:21 +0000
Date:   Fri, 15 Sep 2023 14:11:18 +0800
From:   Yan Zhao <yan.y.zhao@intel.com>
To:     Sean Christopherson <seanjc@google.com>
CC:     Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Huacai Chen <chenhuacai@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Anup Patel <anup@brainfault.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, <kvm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kvmarm@lists.linux.dev>,
        <linux-mips@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
        <kvm-riscv@lists.infradead.org>, <linux-riscv@lists.infradead.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Chao Peng <chao.p.peng@linux.intel.com>,
        Fuad Tabba <tabba@google.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Anish Moorthy <amoorthy@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        Xu Yilun <yilun.xu@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Ackerley Tng <ackerleytng@google.com>,
        Maciej Szmigiero <mail@maciej.szmigiero.name>,
        David Hildenbrand <david@redhat.com>,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>,
        Wang <wei.w.wang@intel.com>,
        "Liam Merwick" <liam.merwick@oracle.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [RFC PATCH v12 14/33] KVM: Add KVM_CREATE_GUEST_MEMFD ioctl()
 for guest-specific backing memory
Message-ID: <ZQP1hiV7c9UGLRfu@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20230914015531.1419405-1-seanjc@google.com>
 <20230914015531.1419405-15-seanjc@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230914015531.1419405-15-seanjc@google.com>
X-ClientProxiedBy: SI2PR01CA0045.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::19) To DS7PR11MB5966.namprd11.prod.outlook.com
 (2603:10b6:8:71::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5966:EE_|DS0PR11MB7579:EE_
X-MS-Office365-Filtering-Correlation-Id: d124c74f-f70b-4ed2-14b3-08dbb5b67e12
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NIw6hxPN7hhBAwhQDNNnvuWA0tTTlfsknANlXPjN1o5gOZqRlV8YdrIyZzqH8NN9levkV850Cj54z6tqYwGRz9SYmOBv/GUkHELzzppgdRb60ClSk3OmoidRr3buiJ51DR7cVXChrnGs7qn0IGggHWMFF0jEwjhGRISwslLCqGIEYe2+E9UopaazZr34Cp55W/V4nH4iWX87lAXo6D9nvbA/WSwSf4IGgZSrG4o+UmkW6sYzdgJ2O1SYVE3ms4Z9hJGvPwH2CoOJaiRKMVubtPkpe7YUrWpQiVsIOnRcfpglRVPR3/XsCy2z9WFY1R3AxFUjNXrAi2+mYeDAQa1oG2qf0p5klAd+vkAdy8O/Sf0vy1UYwoWAtyq5kP4RN3951pvKEJ6fWfFsda6yxgXBNqYeeX0uxcAPDjGVGzydTfFRpN4BXfNee1s3mlnKxz3Z2th7Q52nWOMIpP4Oybcnw26yn3eLNfuRq5jFMCCfRPMXAmVYd2TqXWTRt54Xs/YQCOd2irtRctHrdII+IPni9toZq83BHsXwAvvm7E23Dn3/RW5zk9Dm391WIx0kRt4Z
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB5966.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(39860400002)(396003)(136003)(376002)(186009)(451199024)(1800799009)(7416002)(66556008)(7406005)(3450700001)(5660300002)(83380400001)(82960400001)(38100700002)(4326008)(8676002)(86362001)(8936002)(2906002)(54906003)(41300700001)(6916009)(316002)(66476007)(66946007)(6512007)(6506007)(6666004)(26005)(6486002)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Wze4+W/RB4/agTl5gWPVTYnm7jRXog5N7Pzs+NwlVnosfVw7k6YCOLuIeI/K?=
 =?us-ascii?Q?ry9nDTGa8oA+wPPsan04I3GsR6wFeq66jJrBpX3xNhpDgbY7D/WXMxs+VKE4?=
 =?us-ascii?Q?dGAKTiCi6BQT0id2+AIKGlbD+NAVajhQ/GCDfMw8R8cLe32ZMJctzI7BPK3J?=
 =?us-ascii?Q?z/bkd55mxAnQF414ImG2QITX6r1oJw1poGcUCTKSDkfjbHU5BAiIipYl3ePu?=
 =?us-ascii?Q?gBlfv4ME/6c0w9lKeQdw8+m5q6U3WG7HTeOO28q/FYMUOraMZU6wGZiHbXn/?=
 =?us-ascii?Q?k28EUQDeMF4bYGs6podOCCmq1gKtTOGCnkqqR6mfBECOIaClq5aE4xHOS5P8?=
 =?us-ascii?Q?4+gN5f8R/NcKM6G+yV/0cH9GlP3/PYN73uSTtaa3ipV9CdPkGJ1Y2n/e+q2Q?=
 =?us-ascii?Q?/0po363cayO+oTB91nYmvYOhWaRzUY5Eq4Y2TnMl6x5ghMrT3zwbndpBCWHL?=
 =?us-ascii?Q?F1BX3HVNz0giQ3Aw5Gx+lIKvTA0f8UgmrtNIo0N7T7zQ5CuPYVWHoNnpRDZZ?=
 =?us-ascii?Q?N8JU2uYGuaMzbBMYl1NuPyUtZsx6iY8qkuP8BrVU4DAuF/weGxgcXGIDzHb+?=
 =?us-ascii?Q?ijy144yKiHoN26vbJjHoOHQmCmW0jOZ6xI7ngxSB82fphh3RB/IZ6blmjzRS?=
 =?us-ascii?Q?68FblHwKvOSHStd1yooKmpVmfqx5N89nbLZ6IziDLMPgtGhNY40RDYs8eGRu?=
 =?us-ascii?Q?FISP5NjNdmOCT3juQ3iaXWbDGqZVrIbW4Qa0t9EIfGEbFeGnhh8FI6NKO2Dz?=
 =?us-ascii?Q?cFLWM17HtsgtYEGZH3A3cSiQgjy9fqjkGEFvhPTW/wW1YkrzGT9+iGXsLRIH?=
 =?us-ascii?Q?xGiZ0fXGb4WgLkirkkJClitjKYj+VldJfNk0w0J5JzLw1rEJGh8Ni6c/uCZe?=
 =?us-ascii?Q?S2oPymoujixMdhCaw4V2c/n6jrsQDO+XNOQZHwon+0VSE4biCM4p7csQEYYv?=
 =?us-ascii?Q?YZvFf7mdLWSO2bfGFvlkPPgcJIBz4hYJthCvdI+4vwPKPgRmhrX+GFsSnhMb?=
 =?us-ascii?Q?3SKMFCix2wZseYIcewz/K8zmGJ1vpWaQQdfIJj/zJ8+Kp+hMHGNpTqFKL/rN?=
 =?us-ascii?Q?4nj+rzqpiqhrP4xBYblP1JcHFJyNj568pD04TZ4lAx19WHJOE4TkJi18RgpK?=
 =?us-ascii?Q?c7/0xzYep0eSocp+m/M1b8s6vTBF28sUUJbxkUaxAcWTqheMILT8wjnsJHhw?=
 =?us-ascii?Q?Y5PCtsOFdye764j50/F/BSTfJq1KEnhm4860s2nrc8F/SBiobVWMprEN+VQ4?=
 =?us-ascii?Q?90n6izs8C+pHXbDcq4fLnJfgtMXbQG5hs5NlWOh8KQI3I/ZISoHuUGN4kqJK?=
 =?us-ascii?Q?QZMtqQkQ0FzkYP4efo0Ld6MDyIBsYJEBskEtGPQNcpmB84lhghliNDe1nG1h?=
 =?us-ascii?Q?+vig59cKYh9KyBBOZkyb0hFLtom326jcv+i+5ICfNXZOB++yhh+KCXzZ0nPY?=
 =?us-ascii?Q?ist9qBU3LADPAHgCia7dmLFZAoM54dVHPa9vmAXCdqgFJxGMJqWVofPU9DLJ?=
 =?us-ascii?Q?0a0Dal8UjCGO0hZuCRr2AftXwfWSAhNq3Vxv23WOVCtk9VY1TUx3lMqzdWkf?=
 =?us-ascii?Q?1FFfaI1eSbKeH5YrlJnpMXeCslPr74qMWylEXVdx?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d124c74f-f70b-4ed2-14b3-08dbb5b67e12
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5966.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 06:39:21.3299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zOtdxo02B1MFVYtli7VKhZzLljLay4z3HQvUoFRWGMO7xKB7vP+zTct6RAamwt1pPe6gs3+PewYRyF8/i4ElKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7579
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 13, 2023 at 06:55:12PM -0700, Sean Christopherson wrote:
> +static struct folio *kvm_gmem_get_folio(struct file *file, pgoff_t index)
> +{
> +	struct folio *folio;
> +
> +	/* TODO: Support huge pages. */
> +	folio = filemap_grab_folio(file->f_mapping, index);
> +	if (IS_ERR_OR_NULL(folio))
> +		return NULL;
> +
> +	/*
> +	 * Use the up-to-date flag to track whether or not the memory has been
> +	 * zeroed before being handed off to the guest.  There is no backing
> +	 * storage for the memory, so the folio will remain up-to-date until
> +	 * it's removed.
> +	 *
> +	 * TODO: Skip clearing pages when trusted firmware will do it when
> +	 * assigning memory to the guest.
> +	 */
> +	if (!folio_test_uptodate(folio)) {
> +		unsigned long nr_pages = folio_nr_pages(folio);
> +		unsigned long i;
> +
> +		for (i = 0; i < nr_pages; i++)
> +			clear_highpage(folio_page(folio, i));
> +
> +		folio_mark_uptodate(folio);
> +	}
> +
> +	/*
> +	 * Ignore accessed, referenced, and dirty flags.  The memory is
> +	 * unevictable and there is no storage to write back to.
> +	 */
> +	return folio;
> +}
If VFIO wants to map a private page, is it required to call this function for PFN?

