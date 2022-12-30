Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6796593E8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Dec 2022 01:50:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234198AbiL3AuY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Dec 2022 19:50:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiL3AuX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Dec 2022 19:50:23 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7211A167CE;
        Thu, 29 Dec 2022 16:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672361422; x=1703897422;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ejcfDN4zlmZLW/lnq7/zQXDdkSH+5ljWPcGN1IpqBa0=;
  b=kELOiF38XJtLT1MG+ZbBctE+t3ByMbuBkIhUMMXPA3G1xT7kmbHhv1ph
   amLzp5ilstGU+HDqeIPL7OnmNozDa/9cKL8s3RsvjVwdURxQvv83OLx7c
   Dy6eAwOuOVg1yru+fF5YvNXOl2bAR+KSxSBuMQqpgYBgiZwbgwMpCWLAs
   cgNUtdJ2dFEWaV+s5Q8X4w1aZKc7Qi5MtoX2tEOtCr6MVEQFg+mmPr8P/
   y4bZ+nZj34K3IjHovI4R8G/BrYUiCj5b5GrA5ZpmQfViw0zMiPhB5+4Wn
   3eCxp/7NmUFu7sITCGZd0Yr6kusC8tOD8yYHOdwZIT8xjPJvE35UEO998
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10575"; a="300827562"
X-IronPort-AV: E=Sophos;i="5.96,285,1665471600"; 
   d="scan'208";a="300827562"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2022 16:50:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10575"; a="653751749"
X-IronPort-AV: E=Sophos;i="5.96,285,1665471600"; 
   d="scan'208";a="653751749"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga002.jf.intel.com with ESMTP; 29 Dec 2022 16:50:21 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 29 Dec 2022 16:50:21 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 29 Dec 2022 16:50:20 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 29 Dec 2022 16:50:20 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 29 Dec 2022 16:50:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bd8YZgRQQe1kbejE5gPEPDLpd6xOrzfrfCmeGk5mNf/7pi5kCm0grqs4xA5bTSzKsutdlFds7c9bL1rfpiX+qk0cs4IPf884AZTUjAckHQOvKPM7XfKVRcS5aq+ZFQ0donOn/Fyzfhng9bhCRLS+M3rJ8iexCQKMWgkAYxaXQLjHVZtnzBRsHTCvWFZHsULliD0G3oXavfLN+K3M+KhVD2pGtSpsmTLOqY2SfFDA8IRqVOVceu7qumJ05yCCkCjXuvWm4P6N5JzQbkozLBzl66QGzjVowLAZGlBY2gJ6r9AihM9BOBL8xOKFtVbP4en4uDo0mZnpFgAO/HPVhC3Cfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HUeCL/p4pFE4SI5ur47JUJR4kqsdLtcVYeoH1kEvqiM=;
 b=FRXf1/ctQ61LKq35jWKrq9KyURXHtRW04HyYaZ7JOXnGrwY2V79Yc//VMrxPWJ6HR56O4QfgK/AjJm4/pT6DqK6duIvNaL5iAK4WDNBGZ1DVHtmLPZxfSVkSlLZjxXdPFj2D+12RqrWbQQd1mVYxpKqR89t/8wyjnCYb4QkAq7wYhg+nLnA+wZvxT7om9IB0E31033i+kil9wYjPUAnl0CTVdzcSx2UEtjYvyFnK8Oijsnh3OUngra8seEEWv7B/Ho9Y0hry5VJVYNeVLkgcq8xZXevgEXcZpZQQdjbJC+hMjEiEfaPi68xj28xKYvnBiCwVzOX3OaXECOpTXCpnKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by MN2PR11MB4615.namprd11.prod.outlook.com (2603:10b6:208:263::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.16; Fri, 30 Dec
 2022 00:50:11 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::288d:5cae:2f30:828b]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::288d:5cae:2f30:828b%7]) with mapi id 15.20.5944.016; Fri, 30 Dec 2022
 00:50:11 +0000
Date:   Thu, 29 Dec 2022 16:50:07 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
CC:     Evgeniy Dushistov <dushistov@mail.ru>,
        Al Viro <viro@zeniv.linux.org.uk>,
        <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v5 3/4] fs/ufs: Use ufs_put_page() in ufs_rename()
Message-ID: <Y641v67DTBgo3Sjn@iweiny-desk3>
References: <20221229225100.22141-1-fmdefrancesco@gmail.com>
 <20221229225100.22141-4-fmdefrancesco@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221229225100.22141-4-fmdefrancesco@gmail.com>
X-ClientProxiedBy: SJ0PR05CA0117.namprd05.prod.outlook.com
 (2603:10b6:a03:334::32) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|MN2PR11MB4615:EE_
X-MS-Office365-Filtering-Correlation-Id: e368cb0a-0aa3-4719-6df0-08dae9ffce05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nf7UrPvSCSm7zxrve8Mo7WPUlocq7fqlixiKUby51lIH0F8sv8HxIKgzLuH5MqPU1RES6XOcLNiXFIiYd0mkBiuzo9ooYC7WKRIPPgM6p07mty7OPb9nGzNuJQatf9mvpC5Ty7SxnyHHeE/DCX6GPl5XrLRYvAYlY2e7u+lYbALvUBx4IrYGFJdZDJO8Q8G0o0chZkos2DnMwUREF9J95PRT4SlNtKtognAit+b8Rq0bPnyvkKCZ7ML9jUQZB+o3YRkPXoBIY98pJb3zA2Iq+U8dem8K/tO5nfbAV3U9oZzB4QBUddgpQ+tpX6XsEWoBZWoYAsh6rzujYWhuyW99BCV0TSjedwkASsQyqOUJx0OTJO77Bjs+Q1WKmSVnIf2fbYvIv17s21fdRcHeTs31INDxIoTCFcYxrGg/pdTBV34fULX5OZEl9m6otAk3Ktvy3BKWoKEce6fQktx3TTxwchc/NwMZUMTxLXSFockVhIvCkFAqX+xNigLh8Lav/u+Ak79H9L1yCueuZ8aRbNyNqiHS76Tbrm8gPOMsRX3Q5fAEO4pL2iyv/DiI9xDLNXaNMd4374UTNDrgobGOeLjttskYojOH2aBbr12989z2x1CRSkAPz5hy1AJchJZlvI90lnKdl6ER50AqRU1IMBvZWw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(396003)(366004)(376002)(136003)(39860400002)(346002)(451199015)(478600001)(6666004)(6512007)(186003)(26005)(6486002)(6506007)(83380400001)(9686003)(41300700001)(4326008)(82960400001)(8676002)(54906003)(33716001)(38100700002)(6916009)(44832011)(86362001)(8936002)(66556008)(66476007)(5660300002)(316002)(66946007)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XMfk7bTv+twuJ2qz9KfuJay6kxykf6nwkpMU0lbHJ5vODUhYw2nemCK/J+bM?=
 =?us-ascii?Q?fDFB49aafZdggwXVgaHIp3iiPuqRvq+3YCjJelcztTy1jrwryp7T1Yx38tKY?=
 =?us-ascii?Q?YzBfYQUbWlbHhsMMNKCEY3BH+g8CgdikY37IZ5/FBscAo+qVAdDs5uAjwLNC?=
 =?us-ascii?Q?HZr8jopzA2ELwc1wtlqdomGfh7+He+ohAqaiq1KWXOq+grh3ChLF6RFJvsXa?=
 =?us-ascii?Q?K1cDXznvGASrroj4RwHE/TWV4kUznODpEGFzYLKekGZxg1rrJb1Atk+8TQU3?=
 =?us-ascii?Q?m1sVdxwRX3Ku9Q4fWRDMxBgdZy9yqmITDw86Sr/BIBKaXDiNc9b5V051OVVz?=
 =?us-ascii?Q?hbRqMA0Vgd/XgEHPZT5yJ54hSsU5kNZGdw0/xn9DbAYYSLLE42fMwDGMA1As?=
 =?us-ascii?Q?yfDx+rRq7cAAbX2KEmPyBbQkWFlNVE6anymxjcVvvanL7s/9HbVIXrzdlkAU?=
 =?us-ascii?Q?fqJT5ty7Bhd9ewzPw795YcxzTo61nWrhRfUaKm/4z83ljZaInVqPe5/vPNmE?=
 =?us-ascii?Q?4BzGpWzZyuFbEoAfjWk/R6ScEykTxUzm95pYmANdDK2TAPzbuHYsTwvDtWEY?=
 =?us-ascii?Q?UHdaieFTrkqYBLrq6H5NhXVZouPl4nm0nGODykf/nqNu9+0iEEdQGBImy/lP?=
 =?us-ascii?Q?+qFrI5OOeXNTVe63E0jlMijwajGOcGlOVBYjsIJEI3FUv7LsHHEAmNtayq8M?=
 =?us-ascii?Q?oqfispQ5nxwio/jlpuqrYXoGFjMWIZSx06gytP0he8bdbJttJodJdaEneH1k?=
 =?us-ascii?Q?bevm00OjF85TZwwZ3mnANN/AT//PP9ADKA0L4kvT/2w2uKcCzxPGFJmshC05?=
 =?us-ascii?Q?ZWF/syOV/w9yx8bnrBUv2UP5zliR+kyWjZpoweMoq4e/VhYQxrB44mkYpKVo?=
 =?us-ascii?Q?7AeGa0LFAkgmxmKAKHSKQCd7l2qatOMgIaM/RFycFMwxwRwSMVzL8RghBbnp?=
 =?us-ascii?Q?uSa2yo3pvPw0WyPLpyWlJ5Xpz2OqAb/lg3Wt08EfPj8+MLrmHU15Np4hoExq?=
 =?us-ascii?Q?vutGLuF4s+EhTFOLI87La3oyFh6FD36ucDuhJjvPFUbTob6fj/A+dLDAlYja?=
 =?us-ascii?Q?6pHgm+MGhWZezCKD053SUaQaY3Jyt1Tc1bHzRex55XBnfG8P33Yc57yWsp1u?=
 =?us-ascii?Q?DHkzrq95m6Grs6Z+KH0sjYZsCd6AOULKLCRDP7vZO/x1WqXAr/eft+c2JvZ8?=
 =?us-ascii?Q?HGxiIShr+r3qaU8CA5FvZhxRpyyFs0DTDvSzmuc3MpvCy1FuQmKREPIVWzxY?=
 =?us-ascii?Q?Y1UcYoe1a8zQPSxgQuS7jBFo+yOrlOdYXXeZBG77znQZPLTSQp26kdHBvw79?=
 =?us-ascii?Q?2O8ZQWZX2sCJIMkuO/S01euW/hNsjs6jpxt+ULbyr4GOuTv/BKGBNS4UEYlD?=
 =?us-ascii?Q?FOBHAwGBEPT0FyIRohM9+0OxySaUloXfkY+SxLdEvw/Td1/M6XVS3HzfDyhs?=
 =?us-ascii?Q?vdHVOAzZsHSQSNZ39+crB/cVoh4tVuw9HCcfJBPO0mvGEFLtHHjWCO0Hw7YE?=
 =?us-ascii?Q?k1G0MyTnHha+uffViQBu3QvVuyNj6SA/8X7SBLo6glxtw6QkBVzV+4+aqb7Q?=
 =?us-ascii?Q?NmndEOcq9XMlmug3uFen7Hb62+hX8gAJZOflNw9W?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e368cb0a-0aa3-4719-6df0-08dae9ffce05
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2022 00:50:11.0460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s+/6nGL0gSSLrfF1/9fNOYGOcVnInvZp6fZ2+qErmcp0H11ZWC0i4JssRaMyIvOOZIxQWN5Gj0QNPELt8FjU4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4615
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 29, 2022 at 11:50:59PM +0100, Fabio M. De Francesco wrote:
> Use the ufs_put_page() helper in ufs_rename() instead of open-coding three
> kunmap() + put_page().
> 
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Suggested-by: Ira Weiny <ira.weiny@intel.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
>  fs/ufs/dir.c   | 2 +-
>  fs/ufs/namei.c | 9 +++------
>  fs/ufs/ufs.h   | 1 +
>  3 files changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/ufs/dir.c b/fs/ufs/dir.c
> index ae3b20354a28..0bfd563ab0c2 100644
> --- a/fs/ufs/dir.c
> +++ b/fs/ufs/dir.c
> @@ -61,7 +61,7 @@ static int ufs_commit_chunk(struct page *page, loff_t pos, unsigned len)
>  	return err;
>  }
>  
> -static inline void ufs_put_page(struct page *page)
> +inline void ufs_put_page(struct page *page)
>  {
>  	kunmap(page);
>  	put_page(page);
> diff --git a/fs/ufs/namei.c b/fs/ufs/namei.c
> index 29d5a0e0c8f0..486b0f2e8b7a 100644
> --- a/fs/ufs/namei.c
> +++ b/fs/ufs/namei.c
> @@ -307,8 +307,7 @@ static int ufs_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
>  		if (old_dir != new_dir)
>  			ufs_set_link(old_inode, dir_de, dir_page, new_dir, 0);
>  		else {
> -			kunmap(dir_page);
> -			put_page(dir_page);
> +			ufs_put_page(dir_page);
>  		}
>  		inode_dec_link_count(old_dir);
>  	}
> @@ -317,12 +316,10 @@ static int ufs_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
>  
>  out_dir:
>  	if (dir_de) {
> -		kunmap(dir_page);
> -		put_page(dir_page);
> +		ufs_put_page(dir_page);
>  	}
>  out_old:
> -	kunmap(old_page);
> -	put_page(old_page);
> +	ufs_put_page(old_page);
>  out:
>  	return err;
>  }
> diff --git a/fs/ufs/ufs.h b/fs/ufs/ufs.h
> index 550f7c5a3636..f7ba8df25d03 100644
> --- a/fs/ufs/ufs.h
> +++ b/fs/ufs/ufs.h
> @@ -98,6 +98,7 @@ extern struct ufs_cg_private_info * ufs_load_cylinder (struct super_block *, uns
>  extern void ufs_put_cylinder (struct super_block *, unsigned);
>  
>  /* dir.c */
> +extern void ufs_put_page(struct page *page);
>  extern const struct inode_operations ufs_dir_inode_operations;
>  extern int ufs_add_link (struct dentry *, struct inode *);
>  extern ino_t ufs_inode_by_name(struct inode *, const struct qstr *);
> -- 
> 2.39.0
> 
