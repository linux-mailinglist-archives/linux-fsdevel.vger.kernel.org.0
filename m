Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31E92567970
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Jul 2022 23:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232052AbiGEVlK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Jul 2022 17:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiGEVlI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Jul 2022 17:41:08 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4196186F7;
        Tue,  5 Jul 2022 14:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657057268; x=1688593268;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=8ftsSd45hVDBeOMfPO7DS7JhzJKfCJ4VlmyX1v2b9Ow=;
  b=JSGLbmHNy4/IZrFvP0cwjQVdVg5K+Cx7x2hpRk8fcWWcG4JIcGv4ZTgO
   dYn8kB+FRN7fxwGR36eZ2xtU/I6a29IZgGaDy2ZpAEXKn6nPOQZkTWq0+
   1gCp3YGUJ1Uei4rb3+G9IPR7x5pqzngIay6XakrLcGf/mhVaa+q6hPpZd
   CTDzH+s0ReoWXyyaWG1E8/kJN8qX8oIJLIKpnZEkvywh2xM99vmpZYz2N
   VcUozyRG3J1oUzlaRPGa8YQ7TZ/zNZJaEURy0jB3iPhA9a5f6FP2OLjhl
   6honY1duEJ+4LQyGtVTDwuchlG6vo+fR5YaPDgxVajNcpcQknzk4+TdpL
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="347505712"
X-IronPort-AV: E=Sophos;i="5.92,247,1650956400"; 
   d="scan'208";a="347505712"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 14:41:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,247,1650956400"; 
   d="scan'208";a="543121606"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga003.jf.intel.com with ESMTP; 05 Jul 2022 14:41:07 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 5 Jul 2022 14:41:07 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 5 Jul 2022 14:41:06 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 5 Jul 2022 14:41:06 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.47) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 5 Jul 2022 14:41:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MjfZ8We2eZSjhIwj++GXaLNPjOrr0YPIjJ8O8KJIydPICw0A1SsbCSFS73fe+0cLqB/xAKiBxzroDI2N7ojNbpq1WPeW0YKI+bStFlAwfCdOA6xjs3GiYExag8yTbVJxxyiJxo8PMZ844Z+ktFuhwqbm0Hwyw/SHrgrNBfiwYja9OePhCyZrZcPk5vrEYRGRLBqHssJIi1rxI7i5FgRIq0uHzr2WfJG3FnSsHhfWBGu6W5hiZxUZkp2jqdJRj4Guax2BHIwU/CtCgyAflZhnN6bEwCPhQsxmy8KVLv6Xdk7LwDeuyIdd39I/luYLVOnFade1C/TfXdovrknmRw6bgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LfjvDog0JH10KLxCXSvbxwBpQN8e48n+sTXsw6ZU87U=;
 b=WFjrYLBMIw2F59cXcUgpPVQ3/Blmshc0VKgnUdc9TAQJn1BdTP/cyp0I6WyYFSQ/jeghJcRGgwh94DVHIsdtWCaCGZg/EynLG/tbIpOD5IGtR0xSWCKkVHgBMrlBUC5zt+Z0PEQoJBDy+cgREYtu2jtOa6PJPJgY98JvOHeaR0lF+hhfzlLxNiqPfREbCAVV3z8lBCkUhe18Ci2RtPVjx5FPZCJtJ9+sEys5V05DzyFpw6gbsP9C5AHuNDFQawneWx0Z7bLCTTb1ranLaoHEyjgFoC7pv2OUzJWW1a9NTQlmGfXohRJNxUFjsw/kE87liJ/SICP1yQzPdqbIFTKfWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6311.namprd11.prod.outlook.com (2603:10b6:8:a6::21) by
 SA2PR11MB4811.namprd11.prod.outlook.com (2603:10b6:806:11d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Tue, 5 Jul
 2022 21:41:05 +0000
Received: from DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::f188:57e2:349e:51da]) by DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::f188:57e2:349e:51da%7]) with mapi id 15.20.5395.021; Tue, 5 Jul 2022
 21:41:05 +0000
Date:   Tue, 5 Jul 2022 14:40:59 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
CC:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] zonefs: Call page_address() on page acquired with
 GFP_KERNEL flag
Message-ID: <YsSv656Uc873foaA@iweiny-desk3>
References: <20220705142202.24603-1-fmdefrancesco@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220705142202.24603-1-fmdefrancesco@gmail.com>
X-ClientProxiedBy: SJ0PR03CA0236.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::31) To DM4PR11MB6311.namprd11.prod.outlook.com
 (2603:10b6:8:a6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f929b985-eaac-44ba-48b3-08da5ecf101f
X-MS-TrafficTypeDiagnostic: SA2PR11MB4811:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vK3+ijOacm4l9g/qtv3FX9ivqrrQDEV14yjfbvSyoxJGBuUu7dZMjqApgrvaTfsB0GZqfeUw55sQYw7Ek26SF7eHi+6SaxPDNVPgKzOenvNnGKm1a4LgyUTUeX3kEegyKxyts9X3+36tlgB0AtnkDxVorG5JmUVs3hY4EbBj+ytaoascu5p9ptbxUKkbvuwqxhimWg/chbiIZfpgtMiRj25mHGz06eQBwp7lvxs10TpI2c7nQ1ZwsUXC9MxEPDwzgq1ZPFGCa3PVRKLJESNwic+yYqy3VOxNE0P+BRjtzGj7zv60j5PHnxlVj54+LugB4ceHR/VeOT2vuBrQvfznAaTcC0Iy0/7ncZ17yNHcoub/ggp4zCivZmmW+alxkkJRX765sS0A+SGf03ryKAVMlrq/AZ4cCwL5tZ5fKlSSMXIvzksUU/k/UpqqglIF8g6P/A3qinZfuUpsRdmvYk5z2wKSlf9JB7zQDHFTL5TQ6Mnpf4/Zxd+Jo2emhmcoLFnSrGoQfQLYYxvfi95a3FHObu3i3KyWL8SxraJhD0+3Qf74SBE6D/J2mxAQ7x00Xw3FH+oScoAl6ah0npv1q7TLhJyCgsGZBKVPdjSvjUn2FYk2i25QQq5GcIpj7/YBc+nroxevMJ7inHixFx50brDJdhDvXXB4syS71NjwhxBr8ANIMiAkl62UQPCzJy+HExxeXarjbCx6gydiU5NAk98JB85yRYH/Vkqj74CKSjo41exBp5b5ss1G9j8uy8+fBncG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6311.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(39860400002)(366004)(136003)(396003)(346002)(376002)(66556008)(66476007)(66946007)(8936002)(316002)(8676002)(38100700002)(186003)(82960400001)(6486002)(4326008)(6666004)(6506007)(41300700001)(478600001)(6512007)(54906003)(6916009)(83380400001)(5660300002)(2906002)(86362001)(33716001)(44832011)(9686003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fZ44w4Aiwpi4i6S0o7bONXWAbCW2JX5RCaJNxVvM94lIpBVZycLydSb6Zc4r?=
 =?us-ascii?Q?V+TgBXF1E0roF+SZIntfqsxUfV6JpsIbkhKQB5gXFKvIvoDWkFKysLWwxvuu?=
 =?us-ascii?Q?g4A+7Yl5IQv5RJSJgVbONGQYP+Ik4FL0u4Cp3uhjK/Pzovx+AlxSvN1K9r4q?=
 =?us-ascii?Q?/thHH3l431moN5OwiyaaUXfZSJWNiqpyjTPG+vB4+wwxaFS23liIWf0DrXUo?=
 =?us-ascii?Q?VkHRDr/k7ZVvZWMGyeU6iR7LLcPINz5pNma7OSrGMOAqWz2l5oXGSAse7GXv?=
 =?us-ascii?Q?utHC5G1bsMZ56I95J7iP4EbtLebBLdSRjpMEig24I4ITfzOi5DpO9TPtiEMg?=
 =?us-ascii?Q?Vs+c8N6QtRHG++RoZFdGl0OxxfCdhr4u5/+UftCeBJdOFjN+7bfjF2x2njTv?=
 =?us-ascii?Q?/8kuzt66d9n8kMHr4EHuCUj1TWpSk2sOH4LXNhLVTCU7Bay5L08rMFUhAEWL?=
 =?us-ascii?Q?Vj3qgAMeAXl6rvffSOCX9jKWKAMRI3UadUKR5HbdYTXwjCJekb40RkWpjSUQ?=
 =?us-ascii?Q?SkFALHeLe5ieGXhmL6RggIEeUaH3qsMyJYewGymGJC+yugLaZL5XHc0v0zd1?=
 =?us-ascii?Q?X4myOb9CmSRWadctRkXzEclMYcL14HS+yW0jSDTG/bpzmKIus0XOmM0qvyJa?=
 =?us-ascii?Q?GtMJ3jebpnsplKcXMf7Tqe7FLIjGQzfwIG1hDIawuhqeiXI/+E6F1ahgyy+3?=
 =?us-ascii?Q?LVtii7gyKXMk9+qo/GpjtKaH9rXKGBsE73HgL31vmig2uz3eBTUZY1wYcqGA?=
 =?us-ascii?Q?8CKSg73Yhaz1MmOfnBvJx+8p8GOBsjjgQCqYaBEPeajnbGy3hF2q8+8/1Le3?=
 =?us-ascii?Q?/uhSTASzgZf8VTjlV9DxoZp9EZh5I0+TQo0PfVXxpiqRdeV3L93uRmh/gdJg?=
 =?us-ascii?Q?dGMW+Hbob8BZBGPp5kN5nFysCnVhobeZEGiEzQ0kZDUwT42Xrn5LTavc6x9E?=
 =?us-ascii?Q?QXC74gCbKwF/n9fD+YD/mlEb4semlXxpU9y4k8KAyZeF4Vwf2EsQaXaEzwth?=
 =?us-ascii?Q?S5Sz4dizb4nsnj1u2Losx9mXtT6PmO+oc5/3etYsd9SurKh/AkcphhMYnEp7?=
 =?us-ascii?Q?UOb8pT140jtd0H46IE1oJm3BVH+7Ba2ly+u45bhadKGbnfbDtXsTBks13VmY?=
 =?us-ascii?Q?4QuSIPemBAvYrOKr2u6hjfbTGcXncr+1K1AOfdHxEBICuVzme3lfxCMPpRdo?=
 =?us-ascii?Q?ZYwA3IeDkd/txZYlwqA4ezi/nyKbXqLblLv+GKFI+iZTtIN3WbfFlR53tPu+?=
 =?us-ascii?Q?uuCxxWoTstkTx5XA/rsvXu6bZR1uYuIEJZ37ZUIZxC16GkLyj4r2ch7PTVbG?=
 =?us-ascii?Q?CJdKUOqn1Avz7zAswst9p0OdP8fhDzP1em2fJFGPUKDVjo5ALF/55X6Q4LXY?=
 =?us-ascii?Q?NWvPfcwpBGrUb9OGGQUAo4DEWLPIVwTIPxLcdzGlC55gGpWvieq+sjc2Efzg?=
 =?us-ascii?Q?L59xhfweguXn1YTSPsDhmVAvW5D9hlnQtH48vkPhNWSEP5jpxSASjsLy7g+t?=
 =?us-ascii?Q?xn4lw9mz/q/If5Kb63OI1PRHmlaVAlXnim0ZiBw3lqhQegdD5LRv0/esSK7A?=
 =?us-ascii?Q?+yzKE7QLIR4jwDloe2kS0qmLKFANL7pumSLtYX6tf1sLKIlijYBEaB352f6u?=
 =?us-ascii?Q?uKVSf+Z2mFDAHQclVD/Diof+UK/1fy47VliRuwY+XPzW?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f929b985-eaac-44ba-48b3-08da5ecf101f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6311.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2022 21:41:05.0260
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wi4Lo3yboJZ5SGPLQXKvBY0ECjCBKCQRuOZGPFZtjHMJa35VZVR3+H7mldrHH+0ccYZc2X3gdIewMpkUuGdY5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4811
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 05, 2022 at 04:22:02PM +0200, Fabio M. De Francesco wrote:
> zonefs_read_super() acquires a page with alloc_page(GFP_KERNEL). That
> page cannot come from ZONE_HIGHMEM, thus there's no need to map it with
> kmap().
> 
> Therefore, use a plain page_address() on that page.
> 
> Suggested-by: Ira Weiny <ira.weiny@intel.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
>  fs/zonefs/super.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
> index 053299758deb..bd4e4be97a68 100644
> --- a/fs/zonefs/super.c
> +++ b/fs/zonefs/super.c
> @@ -1687,11 +1687,11 @@ static int zonefs_read_super(struct super_block *sb)
>  	if (ret)
>  		goto free_page;
>  
> -	super = kmap(page);
> +	super = page_address(page);
>  
>  	ret = -EINVAL;
>  	if (le32_to_cpu(super->s_magic) != ZONEFS_MAGIC)
> -		goto unmap;
> +		goto free_page;
>  
>  	stored_crc = le32_to_cpu(super->s_crc);
>  	super->s_crc = 0;
> @@ -1699,14 +1699,14 @@ static int zonefs_read_super(struct super_block *sb)
>  	if (crc != stored_crc) {
>  		zonefs_err(sb, "Invalid checksum (Expected 0x%08x, got 0x%08x)",
>  			   crc, stored_crc);
> -		goto unmap;
> +		goto free_page;
>  	}
>  
>  	sbi->s_features = le64_to_cpu(super->s_features);
>  	if (sbi->s_features & ~ZONEFS_F_DEFINED_FEATURES) {
>  		zonefs_err(sb, "Unknown features set 0x%llx\n",
>  			   sbi->s_features);
> -		goto unmap;
> +		goto free_page;
>  	}
>  
>  	if (sbi->s_features & ZONEFS_F_UID) {
> @@ -1714,7 +1714,7 @@ static int zonefs_read_super(struct super_block *sb)
>  				       le32_to_cpu(super->s_uid));
>  		if (!uid_valid(sbi->s_uid)) {
>  			zonefs_err(sb, "Invalid UID feature\n");
> -			goto unmap;
> +			goto free_page;
>  		}
>  	}
>  
> @@ -1723,7 +1723,7 @@ static int zonefs_read_super(struct super_block *sb)
>  				       le32_to_cpu(super->s_gid));
>  		if (!gid_valid(sbi->s_gid)) {
>  			zonefs_err(sb, "Invalid GID feature\n");
> -			goto unmap;
> +			goto free_page;
>  		}
>  	}
>  
> @@ -1732,14 +1732,12 @@ static int zonefs_read_super(struct super_block *sb)
>  
>  	if (memchr_inv(super->s_reserved, 0, sizeof(super->s_reserved))) {
>  		zonefs_err(sb, "Reserved area is being used\n");
> -		goto unmap;
> +		goto free_page;
>  	}
>  
>  	import_uuid(&sbi->s_uuid, super->s_uuid);
>  	ret = 0;
>  
> -unmap:
> -	kunmap(page);
>  free_page:
>  	__free_page(page);
>  
> -- 
> 2.36.1
> 
