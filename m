Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0523F584B1B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Jul 2022 07:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234329AbiG2FaG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Jul 2022 01:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiG2FaE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Jul 2022 01:30:04 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6ECF7D798;
        Thu, 28 Jul 2022 22:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659072603; x=1690608603;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=65lutXwR82vlbd6BkQYFiUVNizzeZdhZc7RJSTidSdc=;
  b=huRUxMx3i2YxHyijt/+HIzuYEeCntlOTbcqdVSHRMZIEzZSAXYNpO7D/
   15vCcQWUCcChm2sKbaQmrsR0/B50oMlMvHYYWg/FfN3EH7/yLeGKgW26K
   vnXsoEDZQRnDcdkDD3FF59Y3UoOCDLsaTc44oVgdQIOuxaiyrwpm+1t9j
   WfzGzCgxiiqYwcLfauJfrY45yXom6bGJUhZGjdG/cI/8yRryUKb8+5Hlb
   p91W4ZCNglKo3bYk3z30OcfSlsl4rpBMszxkOCga/bG7aN9heXxq5yDcR
   91XQzKD/IWWt5Huv15ZED0NLw3jrSNzMkFBTmA+ts5NZhQH4s8TxKqc1E
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10422"; a="286244792"
X-IronPort-AV: E=Sophos;i="5.93,200,1654585200"; 
   d="scan'208";a="286244792"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2022 22:30:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,200,1654585200"; 
   d="scan'208";a="601172208"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by orsmga002.jf.intel.com with ESMTP; 28 Jul 2022 22:30:03 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 28 Jul 2022 22:30:02 -0700
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 28 Jul 2022 22:30:02 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Thu, 28 Jul 2022 22:30:02 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.107)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Thu, 28 Jul 2022 22:30:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JURus6uFHJc90fSPwhRZ5drnQ14+w7yXcr4k/9c1d0EJRM/xzmAB9CL19QUYHKYy2cFN6TrEEzGbrq4Qc9XkMDUj7A9shV/BBTn/WkUYoodZKDWmUc86UWc6Ev0pFzfL73dGYcYD4XnWYNpdFA2Uv0t1XisJ73Wwerr7yL+SVEbZ2yzmeSY46N3da/g6+9M7wp6toAgr9pf7VCA8PAwJFGsXJKoxqzSkRtxrgTX0YEJYU8ebzEdp87da+wGl1ug93gR//6sy7FvBikncRyAN9fLwWIiB9waIU3IMEZYIFfIEyLqJP2NnfEZLc4ZL1FZVwRsOevRSAAcqSUXwypLDCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zVk4pidyhBBRkytDsabaHMeIi8eC0eIEQbVZPXK7wzg=;
 b=Y3i8WOdPwdvLdvGrvq9FVE739ZTZhvXdZHyGgZOC2JCBmYR4DX5e5Rb6iKZeF/oDIel5a/1TlornCYurYzn8wBNtlpATkVMQEKQU0ZB6/rD+vkYkbYUUctBpo5QoO66Qi7G6CXuGAmRRHL3YrkWSf0Fy026kwBV7rNH1B/pgZA3uJjM+EAW66LQeTGT601tvdXEgGERP1X11WArHRW6P+tweasXwDSL/TuGeIPyjrWUFlfwcN8YKeGDCCVFDRJNoFgi5xmlnoDGLgQwo2kfGu6sUrRqfDYncayNFHEbLAwuuTod9FYRWpwaifEAWSPSN8o8F4Jlzl2JCLwxsZrpT2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com (2603:10b6:a03:458::8)
 by CY5PR11MB6487.namprd11.prod.outlook.com (2603:10b6:930:31::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Fri, 29 Jul
 2022 05:30:00 +0000
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::35b8:ff0a:4f99:419c]) by SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::35b8:ff0a:4f99:419c%6]) with mapi id 15.20.5458.024; Fri, 29 Jul 2022
 05:30:00 +0000
Date:   Fri, 29 Jul 2022 13:29:50 +0800
From:   Oliver Sang <oliver.sang@intel.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Kuniyuki Iwashima <kuniyu@amazon.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>, <lkp@lists.01.org>,
        <lkp@intel.com>, dri-devel <dri-devel@lists.freedesktop.org>
Subject: Re: [fs/lock]  0064b3d9f9:
 BUG:kernel_NULL_pointer_dereference,address
Message-ID: <YuNwTtT9gWLdUZiF@xsang-OptiPlex-9020>
References: <Yt/oonNim732exkh@xsang-OptiPlex-9020>
 <7614df1720c5cd5b35fc18d14114d1aba2144f98.camel@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7614df1720c5cd5b35fc18d14114d1aba2144f98.camel@kernel.org>
X-ClientProxiedBy: SG2PR01CA0132.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::36) To SJ1PR11MB6297.namprd11.prod.outlook.com
 (2603:10b6:a03:458::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d27cac98-c328-4b0c-689d-08da7123614b
X-MS-TrafficTypeDiagnostic: CY5PR11MB6487:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1YQsNUi3PDyfcTRWLA2YTI4bXB6ezUugUC+33PlhJUz/lPRcb5pcJdzFNUvZsJrjy5r8Kvac2wYfk3kvhcUkPWL3h5CxuPWNAQIX8Nhj63IhV8xy+ojdcK4NwIcIVJ5jXkPEVQTcNBHggrL5LyE94o0vMS61FJOktnGy9pfL0O0A/3G+qpJkVYk2nH/RbByUUxl9rd2Vc8VYnHE1nJc6YFlG3yxkWJPHyeEgoM+bLBFT0iwafWwjD4z9B6fmf5nhzXLqezQr8/nmN7SN8Lgk5QNbTvwmVgI9jznoDUbHsx6z4knFXZx0iI0SkqG2GbbWUGaokgV/cNItLvyOuTFgAWAWmjgspEQmPbQOAseAEkANqmSV4sATrmAOMUgyPeI0yrN75EJ30tdohw+BF5y+7s51/NI2vGy62te/Rk2UA/3QRbC/9y5cLpyP3WGDZvi1rF9D6ZBCKtY0emeYAK4HgOxK35ASEclQm2Ix8oZawySFriVtLpoaMfmYitCVDHNa7YV86nxIc9GCAoEHtNhaz4HkFH9CtbxEdp9ssO/mGRbtt2WmgvpO5nidq9iT4l9qE2P1fdCkgYjslrQFMTawg6A85yvC/tsMiwI7U+FjJXO3TVCiK4aUNLZ98YwCA0DX2iZX6nz8fS6G5qNVsFcva6mRQHNecUtMPR8Zboliqq56UVxmY8NYlTeQX2C1AAv6TxPXzi8TeTrp5LmiMN+/zmW9IA4c7QRhnxp+oQmp1ViWKr/88BU4I1XTb0L0LWzbwo22yVa+vzev4XbphKPXxSSiEh6s1VacMv0DlbCBj/i4BOcOcRZ2OkADsyNG0cqZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6297.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(136003)(39860400002)(366004)(346002)(376002)(396003)(83380400001)(82960400001)(186003)(316002)(41300700001)(86362001)(54906003)(6486002)(478600001)(966005)(33716001)(66556008)(45080400002)(38100700002)(6916009)(5660300002)(6512007)(9686003)(26005)(66476007)(8936002)(66946007)(8676002)(44832011)(2906002)(6506007)(4326008)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tcczkSibafL0s7JCPaWZakmP+V/knrahJrdQxYBSQD7+cdszumjaUb38/TfO?=
 =?us-ascii?Q?bGWljvDQeoL5n0Im/+OcrD6W8Vjpnbls4tVY2cIZ6VmLYAq0pchDwXatekzM?=
 =?us-ascii?Q?vN3bUhyxWzSAoLfg8mSyiIbsdkFv6iTmWfqZolNnXl6/Xgr1Y++vZ3INYwdQ?=
 =?us-ascii?Q?CC/sdH83NGNHMP4v/7IvTjNGilDoL5sfh/ZRNRjMJIrTDZOCqIvuduInNGXF?=
 =?us-ascii?Q?1IvbSuuspWLdcl4XwSzbsnRN9QoBt2KzntU7gfDZ9sNRNafuKppYltgiMS1+?=
 =?us-ascii?Q?a76i4wCd4XdE3fTEeeq5JGTXkhoSuAB4x1fOchu35DNCj4Z1vzuZU/YHJjXl?=
 =?us-ascii?Q?2b0WacrcGEHYPohl3mNa11h2E8xb0i5yEoQQbPE27nzg32XxZSGnYrqJQMMq?=
 =?us-ascii?Q?4v4lWskxNUcKT4aD4oNfGd3Y03W+cjAnMMuU2wgrpxc1KA9JaYuPqmmKfWdx?=
 =?us-ascii?Q?5OK5vAMp3SyrYEbPVlCwlMuY2EdyLeXhRwP2CPMmlWjZQXMrv+yMeYS/ULRr?=
 =?us-ascii?Q?2i4B5D7gPkaK5u0D7QgFpZNrIwkCYMAHGYJ1N1xGjadIgfU0skq3u9lsxwx0?=
 =?us-ascii?Q?8JOfzKVA0j6rjusbCUDmXg4yJHGMx8eVUAzFmFX4HM99Jk+oj1SILEdVAk1m?=
 =?us-ascii?Q?U0HyyP4VCrBlifx0YgQtpnQ85VVWQi/Kbgxc8fYxzLk1RImr20c/yTBcgazq?=
 =?us-ascii?Q?1vFdd1qx/dP236VCVrq1ZJez1mVIguiLr+MYhMNPrd6/tRbdpdCwubtKR/od?=
 =?us-ascii?Q?iT2IliaQOGt713EjV6nuLoqb5Uv5j2AcjgCKaAilOKfrHtV2ra2bROKRRZ1K?=
 =?us-ascii?Q?wELrBHpvv6ZXQQ0zZ5m5jx2yjW4x+MKnGKpcUBULdpb28+Mr5leM2WXA0GdW?=
 =?us-ascii?Q?+MmU/hTKEyIo63fhBRpj2OEriy9j3OOhmwPQ3mX1XOfvpste4zYZ8f+NagEz?=
 =?us-ascii?Q?8S5rcdDVKCL5ix2atC4zcq9tVmjTtpZYrJg88t45uExMGYJGiqoO/o9GWFBI?=
 =?us-ascii?Q?b9Z4lDBQMbDHKdvm9fVsuD/FVgcv5Md+kxurZJNLI1MFMukxKAv0x733nhxu?=
 =?us-ascii?Q?Pa16U8y9jpPpkmS5BLmaNsTkTCRcn03tZ61uumqb/cQ1VP09maCpxEY6LaYe?=
 =?us-ascii?Q?l5FzLaAidqn7k6HJZvmBm274AJPCeknB5Yt4PKfIYCxBwfkY3hHpIoyeTs+a?=
 =?us-ascii?Q?BLCKL5r8avJTW/5f88GI/kh0YiNfhPu7poRYQp2HzeEbL+4Rcnvv3C05EgQy?=
 =?us-ascii?Q?hawmrf8gIQeeehScfqAT/YO5Kj44113lVSfzwY6/fQxMq9KqRo3v+uFr6J7I?=
 =?us-ascii?Q?O/BIZatQYxLH/TAXqJVW68+D4ATAQGwngCH0ADNC+xdqSj3oVRivcLC+Bsze?=
 =?us-ascii?Q?nTkvMTtwVcD7NoeOdtXNBPsGLkwZYH64oO1BowqOsrAH9AW7ZlAWAXi/varc?=
 =?us-ascii?Q?Gy0cTLI/76jJXXBOYvLvAzN/umTh1tHuxRFRTkFiNNlA9414a+2rf7NHAWK1?=
 =?us-ascii?Q?xOkCchLb0Cq8ccmg9SQXAlOqzb0MdKbewdkbUzpbt23WssWpb0hnKYN2s+G2?=
 =?us-ascii?Q?ZZQ5eJKT5HKJKpHMb3yqZrGZMLicHi9yBG+StWGqf3pxnmAketC6HLvG8kBL?=
 =?us-ascii?Q?Mw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d27cac98-c328-4b0c-689d-08da7123614b
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6297.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2022 05:29:59.9753
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 84PHlsmKJj9ei0rOLrQJw4t3+sxKKG5E4LjV8Z+1KvsWHjnS53/5NOfPGiIaZkRrk+lvVQq2wdxbEQhiXm2CyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6487
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Jeff, and all,

we should say Sorry that, after more checks, we confirmed this report is a
false positive.
the initial investigation points out it could be caused by the way we use
clang. we will do more study and send report to clang team if necessary.

please just ignore this report. thanks

On Tue, Jul 26, 2022 at 09:55:31AM -0400, Jeff Layton wrote:
> (cc'ing dri-devel)
> 
> This looks like it died down in the DRM code. It seems doubtful that the
> flock code would be affecting this, but let me know if I'm incorrect
> here.
> 
> Thanks,
> Jeff
> 
> On Tue, 2022-07-26 at 21:14 +0800, kernel test robot wrote:
> > Greeting,
> > 
> > FYI, we noticed the following commit (built with clang-15):
> > 
> > commit: 0064b3d9f96f3dc466e44a6fc716910cea56dbbf ("fs/lock: Rearrange ops in flock syscall.")
> > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> > 
> > in testcase: boot
> > 
> > on test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 4G
> > 
> > caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> > 
> > 
> > 
> > If you fix the issue, kindly add following tag
> > Reported-by: kernel test robot <oliver.sang@intel.com>
> > 
> > 
> > [    3.564403][    T1] BUG: kernel NULL pointer dereference, address: 00000b2c
> > [    3.565351][    T1] #PF: supervisor read access in kernel mode
> > [    3.565351][    T1] #PF: error_code(0x0000) - not-present page
> > [    3.565351][    T1] *pde = 00000000
> > [    3.565351][    T1] Oops: 0000 [#1]
> > [    3.565351][    T1] CPU: 0 PID: 1 Comm: swapper Tainted: G                T 5.19.0-rc6-00004-g0064b3d9f96f #1
> > [    3.565351][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-debian-1.16.0-4 04/01/2014
> > [ 3.565351][ T1] EIP: drm_atomic_helper_setup_commit (??:?) 
> > [ 3.565351][ T1] Code: 45 ec eb b5 89 d8 83 c4 0c 5e 5f 5b 5d 31 c9 31 d2 c3 90 90 90 90 90 90 90 55 89 e5 53 57 56 83 ec 38 89 55 d4 89 c2 8b 40 04 <8b> 88 2c 07 00 00 89 4d c4 83 b8 30 05 00 00 00 89 55 ec 0f 8e fa
> > All code
> > ========
> >    0:	45 ec                	rex.RB in (%dx),%al
> >    2:	eb b5                	jmp    0xffffffffffffffb9
> >    4:	89 d8                	mov    %ebx,%eax
> >    6:	83 c4 0c             	add    $0xc,%esp
> >    9:	5e                   	pop    %rsi
> >    a:	5f                   	pop    %rdi
> >    b:	5b                   	pop    %rbx
> >    c:	5d                   	pop    %rbp
> >    d:	31 c9                	xor    %ecx,%ecx
> >    f:	31 d2                	xor    %edx,%edx
> >   11:	c3                   	retq   
> >   12:	90                   	nop
> >   13:	90                   	nop
> >   14:	90                   	nop
> >   15:	90                   	nop
> >   16:	90                   	nop
> >   17:	90                   	nop
> >   18:	90                   	nop
> >   19:	55                   	push   %rbp
> >   1a:	89 e5                	mov    %esp,%ebp
> >   1c:	53                   	push   %rbx
> >   1d:	57                   	push   %rdi
> >   1e:	56                   	push   %rsi
> >   1f:	83 ec 38             	sub    $0x38,%esp
> >   22:	89 55 d4             	mov    %edx,-0x2c(%rbp)
> >   25:	89 c2                	mov    %eax,%edx
> >   27:	8b 40 04             	mov    0x4(%rax),%eax
> >   2a:*	8b 88 2c 07 00 00    	mov    0x72c(%rax),%ecx		<-- trapping instruction
> >   30:	89 4d c4             	mov    %ecx,-0x3c(%rbp)
> >   33:	83 b8 30 05 00 00 00 	cmpl   $0x0,0x530(%rax)
> >   3a:	89 55 ec             	mov    %edx,-0x14(%rbp)
> >   3d:	0f                   	.byte 0xf
> >   3e:	8e fa                	mov    %edx,%?
> > 
> > Code starting with the faulting instruction
> > ===========================================
> >    0:	8b 88 2c 07 00 00    	mov    0x72c(%rax),%ecx
> >    6:	89 4d c4             	mov    %ecx,-0x3c(%rbp)
> >    9:	83 b8 30 05 00 00 00 	cmpl   $0x0,0x530(%rax)
> >   10:	89 55 ec             	mov    %edx,-0x14(%rbp)
> >   13:	0f                   	.byte 0xf
> >   14:	8e fa                	mov    %edx,%?
> > [    3.565351][    T1] EAX: 00000400 EBX: 401ebc64 ECX: 414f8750 EDX: 401ebc64
> > [    3.565351][    T1] ESI: 401ebc64 EDI: 414f8750 EBP: 401ebbc8 ESP: 401ebb84
> > [    3.565351][    T1] DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 0068 EFLAGS: 00010206
> > [    3.565351][    T1] CR0: 80050033 CR2: 00000b2c CR3: 02e5b000 CR4: 000406d0
> > [    3.565351][    T1] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
> > [    3.565351][    T1] DR6: fffe0ff0 DR7: 00000400
> > [    3.565351][    T1] Call Trace:
> > [ 3.565351][ T1] ? __lock_acquire (lockdep.c:?) 
> > [ 3.565351][ T1] ? drm_atomic_helper_async_commit (??:?) 
> > [ 3.565351][ T1] ? drm_atomic_helper_commit (??:?) 
> > [ 3.565351][ T1] ? drm_get_format_info (??:?) 
> > [ 3.565351][ T1] ? drm_internal_framebuffer_create (??:?) 
> > [ 3.565351][ T1] ? lock_is_held_type (??:?) 
> > [ 3.565351][ T1] ? drm_mode_addfb2 (??:?) 
> > [ 3.565351][ T1] ? sched_clock (??:?) 
> > [ 3.565351][ T1] ? drm_mode_addfb (??:?) 
> > [ 3.565351][ T1] ? drm_client_framebuffer_create (??:?) 
> > [ 3.565351][ T1] ? drm_fb_helper_generic_probe (drm_fb_helper.c:?) 
> > [ 3.565351][ T1] ? __drm_fb_helper_initial_config_and_unlock (drm_fb_helper.c:?) 
> > [ 3.565351][ T1] ? drm_fbdev_client_hotplug (drm_fb_helper.c:?) 
> > [ 3.565351][ T1] ? drm_fbdev_generic_setup (??:?) 
> > [ 3.565351][ T1] ? vkms_init (vkms_drv.c:?) 
> > [ 3.565351][ T1] ? drm_sched_fence_slab_init (vkms_drv.c:?) 
> > [ 3.565351][ T1] ? do_one_initcall (??:?) 
> > [ 3.565351][ T1] ? drm_sched_fence_slab_init (vkms_drv.c:?) 
> > [ 3.565351][ T1] ? tick_program_event (??:?) 
> > [ 3.565351][ T1] ? error_context (??:?) 
> > [ 3.565351][ T1] ? trace_hardirqs_on (??:?) 
> > [ 3.565351][ T1] ? irqentry_exit (??:?) 
> > [ 3.565351][ T1] ? sysvec_apic_timer_interrupt (??:?) 
> > [ 3.565351][ T1] ? handle_exception (init_task.c:?) 
> > [ 3.565351][ T1] ? parse_args (??:?) 
> > [ 3.565351][ T1] ? error_context (??:?) 
> > [ 3.565351][ T1] ? parse_args (??:?) 
> > [ 3.565351][ T1] ? do_initcall_level (main.c:?) 
> > [ 3.565351][ T1] ? rest_init (main.c:?) 
> > [ 3.565351][ T1] ? do_initcalls (main.c:?) 
> > [ 3.565351][ T1] ? do_basic_setup (main.c:?) 
> > [ 3.565351][ T1] ? kernel_init_freeable (main.c:?) 
> > [ 3.565351][ T1] ? kernel_init (main.c:?) 
> > [ 3.565351][ T1] ? ret_from_fork (??:?) 
> > [    3.565351][    T1] Modules linked in:
> > [    3.565351][    T1] CR2: 0000000000000b2c
> > [    3.565351][    T1] ---[ end trace 0000000000000000 ]---
> > [ 3.565351][ T1] EIP: drm_atomic_helper_setup_commit (??:?) 
> > [ 3.565351][ T1] Code: 45 ec eb b5 89 d8 83 c4 0c 5e 5f 5b 5d 31 c9 31 d2 c3 90 90 90 90 90 90 90 55 89 e5 53 57 56 83 ec 38 89 55 d4 89 c2 8b 40 04 <8b> 88 2c 07 00 00 89 4d c4 83 b8 30 05 00 00 00 89 55 ec 0f 8e fa
> > All code
> > ========
> >    0:	45 ec                	rex.RB in (%dx),%al
> >    2:	eb b5                	jmp    0xffffffffffffffb9
> >    4:	89 d8                	mov    %ebx,%eax
> >    6:	83 c4 0c             	add    $0xc,%esp
> >    9:	5e                   	pop    %rsi
> >    a:	5f                   	pop    %rdi
> >    b:	5b                   	pop    %rbx
> >    c:	5d                   	pop    %rbp
> >    d:	31 c9                	xor    %ecx,%ecx
> >    f:	31 d2                	xor    %edx,%edx
> >   11:	c3                   	retq   
> >   12:	90                   	nop
> >   13:	90                   	nop
> >   14:	90                   	nop
> >   15:	90                   	nop
> >   16:	90                   	nop
> >   17:	90                   	nop
> >   18:	90                   	nop
> >   19:	55                   	push   %rbp
> >   1a:	89 e5                	mov    %esp,%ebp
> >   1c:	53                   	push   %rbx
> >   1d:	57                   	push   %rdi
> >   1e:	56                   	push   %rsi
> >   1f:	83 ec 38             	sub    $0x38,%esp
> >   22:	89 55 d4             	mov    %edx,-0x2c(%rbp)
> >   25:	89 c2                	mov    %eax,%edx
> >   27:	8b 40 04             	mov    0x4(%rax),%eax
> >   2a:*	8b 88 2c 07 00 00    	mov    0x72c(%rax),%ecx		<-- trapping instruction
> >   30:	89 4d c4             	mov    %ecx,-0x3c(%rbp)
> >   33:	83 b8 30 05 00 00 00 	cmpl   $0x0,0x530(%rax)
> >   3a:	89 55 ec             	mov    %edx,-0x14(%rbp)
> >   3d:	0f                   	.byte 0xf
> >   3e:	8e fa                	mov    %edx,%?
> > 
> > Code starting with the faulting instruction
> > ===========================================
> >    0:	8b 88 2c 07 00 00    	mov    0x72c(%rax),%ecx
> >    6:	89 4d c4             	mov    %ecx,-0x3c(%rbp)
> >    9:	83 b8 30 05 00 00 00 	cmpl   $0x0,0x530(%rax)
> >   10:	89 55 ec             	mov    %edx,-0x14(%rbp)
> >   13:	0f                   	.byte 0xf
> >   14:	8e fa                	mov    %edx,%?
> > 
> > 
> > To reproduce:
> > 
> >         # build kernel
> > 	cd linux
> > 	cp config-5.19.0-rc6-00004-g0064b3d9f96f .config
> > 	make HOSTCC=clang-15 CC=clang-15 ARCH=i386 olddefconfig prepare modules_prepare bzImage modules
> > 	make HOSTCC=clang-15 CC=clang-15 ARCH=i386 INSTALL_MOD_PATH=<mod-install-dir> modules_install
> > 	cd <mod-install-dir>
> > 	find lib/ | cpio -o -H newc --quiet | gzip > modules.cgz
> > 
> > 
> >         git clone https://github.com/intel/lkp-tests.git
> >         cd lkp-tests
> >         bin/lkp qemu -k <bzImage> -m modules.cgz job-script # job-script is attached in this email
> > 
> >         # if come across any failure that blocks the test,
> >         # please remove ~/.lkp and /lkp dir to run from a clean state.
> > 
> > 
> > 
> 
> -- 
> Jeff Layton <jlayton@kernel.org>
