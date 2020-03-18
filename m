Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D79A41895DB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Mar 2020 07:33:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbgCRGdn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Mar 2020 02:33:43 -0400
Received: from mail-eopbgr700059.outbound.protection.outlook.com ([40.107.70.59]:38177
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726478AbgCRGdm (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Mar 2020 02:33:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n50VMFgH3Shz4NGwGVgjz5PmJT74gvBFe/ry47YxC7DHUx7Ibd5ZBa6901TlbQJe+YXcv+cQ1KdAXEw7tO8klzPOHEwyBTvlfRbvAJY24AkNWmjYbwd0eyMsqrj98dLCsKrI8AKIG+5mCIrWDUwwGZxjs9sB51Uu5EbhkZa9KpuGVXDrZLFQ6PBTrzjSVT47r8butixDIXV0E/Is5wrlg9/iI7BA3J90M1UCH6bgnSnX7SN1KNlYDrxNQQzI2/q2eaF87FbZfcc8+cQ7py427o73lCATNXty2kxLPczAQVh/mFSTDMcpCDTD32GaDFzrc4tdl/mywF6nLhRrIumXQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w04c/3tOf92t6L/TOjaruS/dXSLXiKGPYNLFYSrBw3U=;
 b=B29csWoq1Kb4OJMuSVXIfuFMEJVM4PdpF+HWVQgab6dVxIQsEnZX/rwz2i3h2xC0fAdLH4NqpsLHN8WpgAY9hlQ3ItixuISM/DOsdPSON+MFInI+w6Qp58EdgpvrQMGhkJZZcvi9u7ttKbiUnf9eFanB+/CXW0U6dIgrgoXltJbTg06z/MOpNTuaRqj52vXRLmckb295Dp12ErUmBDnV7jcX/1VDBJbMro/k4oLmryL92SO+eFiIvM/QbjU/E2mAwLi9eF7BE04aIkE31tIGkS1l34cHzFDerf7b/aMDPuuGXFnKS9OTmYsuWZF/Oe7qRRRvYfVx7Dw6FGkSMu3uhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w04c/3tOf92t6L/TOjaruS/dXSLXiKGPYNLFYSrBw3U=;
 b=iJfnktd49EocqPOJTDbtaMifxAIFmDslq/Nd1b1DHeNPwTNOPHSpFR50jhZhySxvpwLwxWvCKgMsXI3CTe3gOjAugeYTY7GsSuLWdLAMAj/hcwj3kkmWEYLrFpcg0S61iszaY965mnU/yXcCu9BN3y9rw9xwLXVizJf1Ipi5KXs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Zhe.He@windriver.com; 
Received: from SN6PR11MB3360.namprd11.prod.outlook.com (2603:10b6:805:c8::30)
 by SN6PR11MB2767.namprd11.prod.outlook.com (2603:10b6:805:5a::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.22; Wed, 18 Mar
 2020 06:33:39 +0000
Received: from SN6PR11MB3360.namprd11.prod.outlook.com
 ([fe80::d852:181d:278b:ba9d]) by SN6PR11MB3360.namprd11.prod.outlook.com
 ([fe80::d852:181d:278b:ba9d%5]) with mapi id 15.20.2814.021; Wed, 18 Mar 2020
 06:33:39 +0000
Subject: Re: disk revalidation updates and OOM
To:     Christoph Hellwig <hch@lst.de>
Cc:     jack@suse.cz, Jens Axboe <axboe@kernel.dk>,
        viro@zeniv.linux.org.uk, bvanassche@acm.org, keith.busch@intel.com,
        tglx@linutronix.de, mwilck@suse.com, yuyufen@huawei.com,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <93b395e6-5c3f-0157-9572-af0f9094dbd7@windriver.com>
 <20200310074018.GB26381@lst.de>
 <75865e17-48f8-a63a-3a29-f995115ffcfc@windriver.com>
 <20200310162647.GA6361@lst.de>
 <f48683d9-7854-ba5f-da3a-7ef987a539b8@windriver.com>
 <20200311155458.GA24376@lst.de>
 <18bbb6cd-578e-5ead-f2cd-a8a01db17e29@windriver.com>
 <20200316113746.GA15930@lst.de>
 <4215351e-89ac-4969-1d52-e2ff5c064d7d@windriver.com>
 <20200317124244.GA12316@lst.de>
From:   He Zhe <zhe.he@windriver.com>
Message-ID: <d6feccb0-6dfc-22e6-1e3d-e6bd8562e5eb@windriver.com>
Date:   Wed, 18 Mar 2020 14:33:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200317124244.GA12316@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: HK0PR01CA0054.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::18) To SN6PR11MB3360.namprd11.prod.outlook.com
 (2603:10b6:805:c8::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.175] (60.247.85.82) by HK0PR01CA0054.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.17 via Frontend Transport; Wed, 18 Mar 2020 06:33:34 +0000
X-Originating-IP: [60.247.85.82]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d287d5d0-378f-4ac3-25eb-08d7cb064b1b
X-MS-TrafficTypeDiagnostic: SN6PR11MB2767:
X-Microsoft-Antispam-PRVS: <SN6PR11MB27676458180C82F69CCF7DC58FF70@SN6PR11MB2767.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 03468CBA43
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(136003)(376002)(396003)(366004)(346002)(39850400004)(199004)(2906002)(53546011)(86362001)(6486002)(26005)(36756003)(52116002)(16526019)(186003)(31686004)(15650500001)(66946007)(956004)(5660300002)(4326008)(2616005)(7416002)(478600001)(6666004)(6706004)(31696002)(316002)(66476007)(8936002)(81166006)(8676002)(81156014)(6916009)(66556008)(16576012)(78286006);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR11MB2767;H:SN6PR11MB3360.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: windriver.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U9ZWk9Oe4J6rJM6s389qmsBSes4VvvR1/oXKGiMWMpdgjaFbqj1ja4yCWPRQ8l+0T3q46PUqtsDCy0V7AB76vlb9lrikmtZgDjFGT0kGYs3olNXwuiKhYNsjJl8QSk0daXqfL3BmbcYhz7D7tLTy22d3z08Pzu+qrc087SHpfRVg6Vb/syMyY1ktcnpILp1Zt4MJtphiaUwHaIvDIlX6MjpSiM4mChCSn+Ns2RbZkme10XDmEpgapmAO5juvuIMcl/4l/kuqT+44FJmEClWyl1DVEvtgw8YVpYN0ofJiUNF2Zvzwj+7aIx6BUdzhB82jFyd+0OOZGhpQwTlTAedyoq3jYmsb5PrTYDMKJiu+LxvwmpG0lmsLPitj119aMxNksZADiQpQan2fkhlJEAGSBvWPzetYT0M0HHDwbds7pDHjTEk3jABPMlt7OrVPw090MfZBNwwZyfcTxeeIHM9rHFe6KckBkPcdRl0zjUdlyFFi4Q8Q7g7Dv1YFuh+MdtEE+d2CVK8P9hNBnwkHxzLRFO9RsF7m0i5WIrWdJHKTs1o=
X-MS-Exchange-AntiSpam-MessageData: HaRE2citDk1aMpQdHE851HvOIoOH+W+N2HIds2maVmLtPakIqrWKAnKK2YIuIsLWIsf3eLbjf4u2W1Ozvgj+pqON1Obw6NJqhrXM5pMDg/7c+A7IdxIAwPgmNc31ilC25U1utcqR8aEUHtvR3UX3pQ==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d287d5d0-378f-4ac3-25eb-08d7cb064b1b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2020 06:33:39.0884
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7kKNQvi7MvbkweSNlmyL+PeZhQ298kaxF9k9AeW19+Aa3ZzL5S3AXHbrYDTSVhfmVqJpGp4KD2Xt/FnkYXLs9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2767
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 3/17/20 8:42 PM, Christoph Hellwig wrote:
> On Tue, Mar 17, 2020 at 04:50:11PM +0800, He Zhe wrote:
>>>> With my build fix applied, the issue is triggered since 142fe8f.
>>>> And I can see the endless loop of invalidate and revalidate...
>>> Thanks.  Can you test the patch below that restores the previous
>>> rather odd behavior of not clearing the capacity to 0 if partition
>>> scanning is not enabled?
>> This fixes the issue. I also validated it on v5.6-rc6.
> Can you check this slight variant that only skips the capacity
> change for removable devices given that IIRC you reported the problem
> with a legacy ide-cd device?

Tested. This also works.

Zhe

>
>
> diff --git a/fs/block_dev.c b/fs/block_dev.c
> index 69bf2fb6f7cd..3212ac85d493 100644
> --- a/fs/block_dev.c
> +++ b/fs/block_dev.c
> @@ -1520,10 +1520,14 @@ int bdev_disk_changed(struct block_device *bdev, bool invalidate)
>  	if (ret)
>  		return ret;
>  
> -	if (invalidate)
> -		set_capacity(disk, 0);
> -	else if (disk->fops->revalidate_disk)
> -		disk->fops->revalidate_disk(disk);
> +	if (invalidate) {
> +		if (!(disk->flags & GENHD_FL_REMOVABLE) ||
> +		    disk_part_scan_enabled(disk))
> +			set_capacity(disk, 0);
> +	} else {
> +		if (disk->fops->revalidate_disk)
> +			disk->fops->revalidate_disk(disk);
> +	}
>  
>  	check_disk_size_change(disk, bdev, !invalidate);
>  

