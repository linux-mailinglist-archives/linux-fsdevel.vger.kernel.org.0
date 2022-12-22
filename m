Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96993653BB5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Dec 2022 06:17:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbiLVFRr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Dec 2022 00:17:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235153AbiLVFRH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Dec 2022 00:17:07 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B14186B7;
        Wed, 21 Dec 2022 21:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671686033; x=1703222033;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=gjDOTrejfvU1JS+kyRfSzyrPM6HthrD4LYyGBfTHWgU=;
  b=VNWMvRqHlqkk+GwV1cM6bSSBJKIFrMlSV8mhiEG+B6kurRtTzUjWXP0W
   43OaVO9NKI5ntLIxOnXEZxsd8uQxDZTrsmfoKOPcwSxEc3vr9uiNIf5QH
   iChhlLnCqTf0IM0ylxNIMIGagkljnStXIFniM36V4Ty2xQRs9uDioII1I
   h5CpCGf77HuV8IftniPu84D7QoyyNbIp5u+xaBp5ywV8K5n3ANLqyG43I
   wpUksi0vp7QqZjeYlvj/jwNWDyFvABCmIXbY4uT5QdP84JP5/piaRDpM2
   Tkha3MtLZBb/pxYr0GI8IRUIxjEhEqFMhedmaieUyvzki338sWMvE3MYD
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10568"; a="321228018"
X-IronPort-AV: E=Sophos;i="5.96,264,1665471600"; 
   d="scan'208";a="321228018"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2022 21:13:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10568"; a="645080042"
X-IronPort-AV: E=Sophos;i="5.96,264,1665471600"; 
   d="scan'208";a="645080042"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga007.jf.intel.com with ESMTP; 21 Dec 2022 21:13:52 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 21 Dec 2022 21:13:52 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 21 Dec 2022 21:13:51 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 21 Dec 2022 21:13:51 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 21 Dec 2022 21:13:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZP0njF6WAmqS7cFjy/VdNEIObt1kkKHyMO8yb6DjMPCBGZEDSy8YQ+uP7ZnIAKLShk05aMW6sGNYlciPInooc9An9Rc/1bGta/ZP6Z53XtGuYs3E6w+Gfg2ugRQi1ARwhzPrl66SYcfohqhXg2ceO6qUVjw7k7ZOjsCmcvQK8JZZUksTav/3nUNq0Cgu+0HKDCODo6zDrfDEOW5cS0jv76rjGjLC8dyI4JlwPzc9x8fA3wYil0mNoBLhfPsawS5KHpD+ApnrqsKlXcAGyTHOvczGdas5hSmXYGwCNLNxVsi1Kp0Vnsi2Xa+2Or5cDNSJLWFCG00onPTbl/KONtoiTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s8b608D77EZGKNyl200jVR8vldWynzDDunqC7STo9tQ=;
 b=INBJazG1zn3TBbnKc0mIN0vY+FtL7ylRYTpxour0EH1Chy/cbLvWJvW4Q/2D6shZ0/YcQ+e75Fmrz73unenjJY14agtnwiQwHKbD7CNo0cNVEmXcare0wymuTTwIWh/U+qRwxjwdhqTI1w+RW4xGdWS+qkF7BXEetBqz10NyR7IHSvWAhYBAJgJEvIuTnNbwgOLfVM5hkgWZLj5FnOyJT8x0eFXkiftei9HlgsnSsdHUHyyGOvNHKdDUwWKv1TdG4HbpVsTIcbLosjHMk+sM9Rj70XiDXuBZXWOZgPvoyYEPwVm5YIYyGolvJRpYYVO3YcQ6+7JIiTBP/aM5EHFavA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by CY8PR11MB7265.namprd11.prod.outlook.com (2603:10b6:930:98::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Thu, 22 Dec
 2022 05:13:47 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::288d:5cae:2f30:828b]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::288d:5cae:2f30:828b%6]) with mapi id 15.20.5924.016; Thu, 22 Dec 2022
 05:13:47 +0000
Date:   Wed, 21 Dec 2022 21:13:43 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
CC:     Evgeniy Dushistov <dushistov@mail.ru>,
        Al Viro <viro@zeniv.linux.org.uk>,
        <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v4 2/3] fs/ufs: Change the signature of ufs_get_page()
Message-ID: <Y6Pnh98KZj0D+FUR@iweiny-desk3>
References: <20221221172802.18743-1-fmdefrancesco@gmail.com>
 <20221221172802.18743-3-fmdefrancesco@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221221172802.18743-3-fmdefrancesco@gmail.com>
X-ClientProxiedBy: BY5PR17CA0061.namprd17.prod.outlook.com
 (2603:10b6:a03:167::38) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|CY8PR11MB7265:EE_
X-MS-Office365-Filtering-Correlation-Id: 5db47e37-526d-409e-8fa6-08dae3db4e22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R1SPRMRx3IKBnFW14rymWwIaV9ZjJVTnORiD1rfHfDx4IaPzRfD5aGVthvlg5/PG5KV2wMQejVuevM3jtwjoGimQeWkRQCKbD5YuVgMbXb3WH5Ja9T9iCukKku2SFl1Y0nF11yfB1okgJSqRn8GnL9Kilfsj3YrWDtM0C4KGdbjZ9GViGHhnXNi31WdP7vGtyYYWuVZutbzyVc1DTknHh7vAx9FtXiin4KgweM0C2+8+BLIW8S3nv1d4RzyJiSW1Yv9KVBTGsnAr4OXwxV09XJr05CLUNLZjcf1fRXlH5SXcV9okmOD+HkcYXN5G4nuwTq8PSFA4cues5xMmUpmQJXp6Qah6ugylfz6jaoOcvBa+NGEsigKfPr25RXq8BPMOC+0FsllpSyMXmJFSG7L+xKQgQyBzi9+y6KxeopS63vHld+1pxRbGuy30k67UeTN0A65+/dtBIad36ZfUWn1dom8izFKryX4Zg6t7cG/lczgnFrR+z5N8Sq2FQpXYCmkF9wIB62NhjDrD/Y/yYiRT3nGabBvUL1gia61iEKjb/maK6BvaqeWCXAM/gHaGMc/+qAO2S2ODMKpb4vyZGgFkpE4l2pBWVkL8CARRaUGqGRj+0W3PihNXZLjVK5m6xmTnJtcJiZXM0uTaxnHyFGZwMQ2SmxZpj0/ncKVnXF3ARpG2PJ1AXbrsuT2EIy5r5gru
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39860400002)(396003)(376002)(136003)(346002)(366004)(451199015)(6486002)(6506007)(478600001)(66476007)(26005)(9686003)(66556008)(186003)(6916009)(86362001)(66946007)(316002)(6512007)(54906003)(6666004)(8676002)(8936002)(4326008)(5660300002)(82960400001)(2906002)(41300700001)(38100700002)(44832011)(33716001)(83380400001)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?P+ILRYTz4TqCusH0DmE92DL9AxWS2D61/oRFuK81mIVy8WLqh9yQ4mIjCG+y?=
 =?us-ascii?Q?FPBQ5b4zVT6AFumHxSs2KkZSSSoywQfqYCBnKmaGxfFSVPFtl/dwzt2r7Juz?=
 =?us-ascii?Q?kxPA5ktgYGR/0E9DJ2hTtyJNoqb30XXZkiWTk5roFWKQC8maMRwPVLSxc2R+?=
 =?us-ascii?Q?+oBCxNxhqiEyIomWnYTBGBTCUDkwuc1RbV6azgrDDiZjxnL3n+kK2ZMh4Bbr?=
 =?us-ascii?Q?Esvppcc/T6uEWV5CsSsCsSPQnpHonrEzBlev/PEn2F/beeaDddGmu2vayzRz?=
 =?us-ascii?Q?kgtGqwsggrqX4cCL+ija+CqNf9+Xz5jxnmT+nzCozAs22L5xHKCRi5zeV+E6?=
 =?us-ascii?Q?J9gqAAdYaRz8CChTNFHeMHiN6EngmZFX8ZH15LWink3JnuXwTeEHXyp4kV+t?=
 =?us-ascii?Q?QSbzQ3l4ZMMKaR4rDYbuucEY01bHlpZXi+inNYWk1FLJTYwyJZ5hRg3uKQcR?=
 =?us-ascii?Q?/hxT8TWkzrj5Mewrdh+wxMWc1XJ4/deqDzc51LuLNYUAXHcl8cQKkXtexL/i?=
 =?us-ascii?Q?OXXfHALu3pVDUTrmCu8oie1MUsa53oVzhdYZSfrOeZ4FeeqoQez0i0WU2Wfz?=
 =?us-ascii?Q?3cN8Zw2fkkLrg+LyUJQOiMKtMCFcP+dAbGq+BLGYDxXj3px9I2cyuDjHftzi?=
 =?us-ascii?Q?sR5RAy2MymjNQ/llkuWvJMGWrZY7ziTEiFoC1RXUnzs6Sblq90mZrZHe/DCA?=
 =?us-ascii?Q?Q6FnHn+3wWGc9RLgqjJ/6U1NYmVDivOpP+zHaRp0FoP7mQ0EjQj4lG+Gj6o5?=
 =?us-ascii?Q?yiZqeHvK44qKMfaMX1VwtIjUzbNGJZ2WVgq6oj7TwOuOHIlwH5zNFAgIvkxU?=
 =?us-ascii?Q?UC72+p2CVthfPo1AX9ZO62pIsqwgvfMVe3K4P6IQHLAF7gbRMvXvd2S2szG+?=
 =?us-ascii?Q?3MmUWQGe2l7eFiJSfXJBZ2LzqlV7lJr7j638hmPP6Im1T4b1nXNOCVCaR8U/?=
 =?us-ascii?Q?GBpS7zmRwYwGVAN2iHUEUuqxKUCe1pnkNlRb59pYYRsG37nkpwPF1I5U7XmQ?=
 =?us-ascii?Q?Z7w7fJoxtFwPM46/FH/4mIqQOOSbKKNOhhj+8ijcowMXcil59GBzZMgpdxyo?=
 =?us-ascii?Q?xqIufSS2ZOnUi3/DRz5LH4bj4ndVUMXLD63I9MmKpQ1k1dQWLfRhZAaunPe2?=
 =?us-ascii?Q?B+ucZj9XrCt+ithmiJQ0VpHU89j4FeIQ/wMoy85r9aNcutexOvZuMn0wiXzJ?=
 =?us-ascii?Q?Vsz+BHdBX65JIY2iZiGRxBWKpoI2hpn4EAZbquiBeapUO9buvBBR8/8l/ONT?=
 =?us-ascii?Q?Yg4bBFyod10PJkbAWOxR1WIXJw3jQ95Z9LKHREnOhL0FahjUwrV5PehRSP/s?=
 =?us-ascii?Q?hUw/cdxGlLoJXq1EOyHhi+uRmiUdFvr/BGeaFnoRcZUsqmxdEbeRFMyd3KE1?=
 =?us-ascii?Q?F8bRrMelP6YXVuTusMKjUK7U0jymDg63wNOBDm+mIQ/jISLf4vZLG2SxAILa?=
 =?us-ascii?Q?SewNLOLxF2hf5n0cJx01r57qtcCqAVUNR3vZYb3qBZLNH4JHX+vZfGA3dzRa?=
 =?us-ascii?Q?21FL603PzjgxDEcRo+4KTb1KeCE61mfj9ns07R8cRZR5yuKNRBUaK8srl/xO?=
 =?us-ascii?Q?FFDgzCLO+pz3WrnMnuboG0MfHSmgZKJjzfYiuY2O?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5db47e37-526d-409e-8fa6-08dae3db4e22
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2022 05:13:47.6451
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LtStDiDZV1ePWqGHeE5WBcuCGNu/ebSwUrVgdfCpCvwbG+xxRLimrJyRuRSOTG9+SR9D51msN/I55Y681Gou0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7265
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 21, 2022 at 06:28:01PM +0100, Fabio M. De Francesco wrote:
> Change the signature of ufs_get_page() in order to prepare this function
> to the conversion to the use of kmap_local_page(). Change also those call
> sites which are required to conform its invocations to the new
> signature.
> 
> Cc: Ira Weiny <ira.weiny@intel.com>
> Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
>  fs/ufs/dir.c | 49 +++++++++++++++++++++----------------------------
>  1 file changed, 21 insertions(+), 28 deletions(-)
> 
> diff --git a/fs/ufs/dir.c b/fs/ufs/dir.c
> index 69f78583c9c1..9fa86614d2d1 100644
> --- a/fs/ufs/dir.c
> +++ b/fs/ufs/dir.c
> @@ -185,7 +185,7 @@ static bool ufs_check_page(struct page *page)
>  	return false;
>  }
>  
> -static struct page *ufs_get_page(struct inode *dir, unsigned long n)
> +static void *ufs_get_page(struct inode *dir, unsigned long n, struct page **p)
>  {
>  	struct address_space *mapping = dir->i_mapping;
>  	struct page *page = read_mapping_page(mapping, n, NULL);
> @@ -195,8 +195,10 @@ static struct page *ufs_get_page(struct inode *dir, unsigned long n)
>  			if (!ufs_check_page(page))
>  				goto fail;
>  		}
> +		*p = page;
> +		return page_address(page);
>  	}
> -	return page;
> +	return ERR_CAST(page);
>  
>  fail:
>  	ufs_put_page(page);
> @@ -227,15 +229,12 @@ ufs_next_entry(struct super_block *sb, struct ufs_dir_entry *p)
>  
>  struct ufs_dir_entry *ufs_dotdot(struct inode *dir, struct page **p)
>  {
> -	struct page *page = ufs_get_page(dir, 0);
> -	struct ufs_dir_entry *de = NULL;
> +	struct ufs_dir_entry *de = ufs_get_page(dir, 0, p);

I don't know why but ufs_get_page() returning an address read really odd to me.
But rolling around my head alternative names nothing seems better than this.

>  
> -	if (!IS_ERR(page)) {
> -		de = ufs_next_entry(dir->i_sb,
> -				    (struct ufs_dir_entry *)page_address(page));
> -		*p = page;
> -	}
> -	return de;
> +	if (!IS_ERR(de))
> +		return ufs_next_entry(dir->i_sb, de);
> +	else
> +		return NULL;
>  }
>  
>  /*
> @@ -273,11 +272,10 @@ struct ufs_dir_entry *ufs_find_entry(struct inode *dir, const struct qstr *qstr,
>  		start = 0;
>  	n = start;
>  	do {
> -		char *kaddr;
> -		page = ufs_get_page(dir, n);
> -		if (!IS_ERR(page)) {
> -			kaddr = page_address(page);
> -			de = (struct ufs_dir_entry *) kaddr;
> +		char *kaddr = ufs_get_page(dir, n, &page);
> +
> +		if (!IS_ERR(kaddr)) {
> +			de = (struct ufs_dir_entry *)kaddr;
>  			kaddr += ufs_last_byte(dir, n) - reclen;
>  			while ((char *) de <= kaddr) {
>  				if (ufs_match(sb, namelen, name, de))
> @@ -328,12 +326,10 @@ int ufs_add_link(struct dentry *dentry, struct inode *inode)
>  	for (n = 0; n <= npages; n++) {
>  		char *dir_end;
>  
> -		page = ufs_get_page(dir, n);
> -		err = PTR_ERR(page);
> -		if (IS_ERR(page))
> -			goto out;
> +		kaddr = ufs_get_page(dir, n, &page);
> +		if (IS_ERR(kaddr))
> +			return PTR_ERR(kaddr);
>  		lock_page(page);
> -		kaddr = page_address(page);
>  		dir_end = kaddr + ufs_last_byte(dir, n);
>  		de = (struct ufs_dir_entry *)kaddr;
>  		kaddr += PAGE_SIZE - reclen;
> @@ -395,7 +391,6 @@ int ufs_add_link(struct dentry *dentry, struct inode *inode)
>  	/* OFFSET_CACHE */
>  out_put:
>  	ufs_put_page(page);
> -out:
>  	return err;
>  out_unlock:
>  	unlock_page(page);
> @@ -429,6 +424,7 @@ ufs_readdir(struct file *file, struct dir_context *ctx)
>  	unsigned chunk_mask = ~(UFS_SB(sb)->s_uspi->s_dirblksize - 1);
>  	bool need_revalidate = !inode_eq_iversion(inode, file->f_version);
>  	unsigned flags = UFS_SB(sb)->s_flags;
> +	struct page *page;

NIT: Does page now leave the scope of the for loop?

>  
>  	UFSD("BEGIN\n");
>  
> @@ -439,16 +435,14 @@ ufs_readdir(struct file *file, struct dir_context *ctx)
>  		char *kaddr, *limit;
>  		struct ufs_dir_entry *de;

Couldn't that be declared here?

Regardless I don't think this is broken.

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

>  
> -		struct page *page = ufs_get_page(inode, n);
> -
> -		if (IS_ERR(page)) {
> +		kaddr = ufs_get_page(inode, n, &page);
> +		if (IS_ERR(kaddr)) {
>  			ufs_error(sb, __func__,
>  				  "bad page in #%lu",
>  				  inode->i_ino);
>  			ctx->pos += PAGE_SIZE - offset;
>  			return -EIO;
>  		}
> -		kaddr = page_address(page);
>  		if (unlikely(need_revalidate)) {
>  			if (offset) {
>  				offset = ufs_validate_entry(sb, kaddr, offset, chunk_mask);
> @@ -595,12 +589,11 @@ int ufs_empty_dir(struct inode * inode)
>  	for (i = 0; i < npages; i++) {
>  		char *kaddr;
>  		struct ufs_dir_entry *de;
> -		page = ufs_get_page(inode, i);
>  
> -		if (IS_ERR(page))
> +		kaddr = ufs_get_page(inode, i, &page);
> +		if (IS_ERR(kaddr))
>  			continue;
>  
> -		kaddr = page_address(page);
>  		de = (struct ufs_dir_entry *)kaddr;
>  		kaddr += ufs_last_byte(inode, i) - UFS_DIR_REC_LEN(1);
>  
> -- 
> 2.39.0
> 
