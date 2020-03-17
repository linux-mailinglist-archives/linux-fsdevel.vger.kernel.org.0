Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B05D7187B88
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Mar 2020 09:50:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725933AbgCQIuX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Mar 2020 04:50:23 -0400
Received: from mail-dm6nam11on2066.outbound.protection.outlook.com ([40.107.223.66]:6142
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725870AbgCQIuX (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Mar 2020 04:50:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NVLctBqTwMlYOw6JBzVzC6SaMWs9hv6/4u1iNwlFLf//ISwhQzpRkVaeLlbEoisufuBy9E+JBWMP+533akBP8xzI9F3lRuCHvImIzoX60LJGpSDIFPTkw3KL2tnBp84qoKeYpjbdKoSYv52pZjJrG6C2znYSt4tkqgoNubQkhvYVvnsnxD6NGXx8SZ30fzlemW6WqQ1gYlC1Zti8sfULEsyz4AiMUwRiBOYaOVz4G/ZB/t0p00aMNOW53DlqCNRlSSv+vRgMUdtcTrc2H706EPCDaQqU+B2rXUoe50g7BSWLfbgODMWo+HgJlcdLnll1SJ9rFut61ePUkeUOc9S20g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xsrjx/9yJ9OR7MAyKwrvLrdwVhlLPzQbxX+Yn9pbJ6c=;
 b=K68Q6bsGS0QHvVl2zTO44R9NqJO8Lwyq4HbtpN0X1zcmYOEy4Q7c77p0Tx7R5w2gqQ26wxUrl8vH20GfFd7OqGZvJFd+E16eZaX4UNuJEQ55FwxVdqU0o10ivRWpS6hjyt2b1tteepU4o4WmZsfYFiDh3Yaq3xzBMqu3/lEG7jhbtevXWeBtOORAOK3bWsPzYvi+nv9iDBeRG9/5pzApSE5HGuerN9JIxtzw9eQHt6Jb95+y210lszQZQsDG3ZwKc5vTq8u8g3t+m6wr/UtbLClVVvVAkOaWFiw1Hu8L8vo9+Z/IH0CORTHlom0s+CuCay3TFRWqZg+WuFhLQ/HwmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xsrjx/9yJ9OR7MAyKwrvLrdwVhlLPzQbxX+Yn9pbJ6c=;
 b=CxYQuGfYjjUTKQnA9Mcz+cF2MCr+QNME6+QXC4QFiiqyIqlimJ5iK02RaFiaseqHYBvWgu8c1sjS7rnNDRP22PuRzN0ShoYkkvGb29kAvrfC27lw2y1t9aHLvJQ+4hiYe8M78xDecq1iIFdudjvw42rMi3dTP7EngEYra10HaJA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Zhe.He@windriver.com; 
Received: from SN6PR11MB3360.namprd11.prod.outlook.com (2603:10b6:805:c8::30)
 by SN6PR11MB2880.namprd11.prod.outlook.com (2603:10b6:805:58::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.14; Tue, 17 Mar
 2020 08:50:19 +0000
Received: from SN6PR11MB3360.namprd11.prod.outlook.com
 ([fe80::d852:181d:278b:ba9d]) by SN6PR11MB3360.namprd11.prod.outlook.com
 ([fe80::d852:181d:278b:ba9d%5]) with mapi id 15.20.2814.021; Tue, 17 Mar 2020
 08:50:19 +0000
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
From:   He Zhe <zhe.he@windriver.com>
Message-ID: <4215351e-89ac-4969-1d52-e2ff5c064d7d@windriver.com>
Date:   Tue, 17 Mar 2020 16:50:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200316113746.GA15930@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: BYAPR01CA0067.prod.exchangelabs.com (2603:10b6:a03:94::44)
 To SN6PR11MB3360.namprd11.prod.outlook.com (2603:10b6:805:c8::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.175] (60.247.85.82) by BYAPR01CA0067.prod.exchangelabs.com (2603:10b6:a03:94::44) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.21 via Frontend Transport; Tue, 17 Mar 2020 08:50:16 +0000
X-Originating-IP: [60.247.85.82]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2f85771a-c97a-433e-9466-08d7ca503887
X-MS-TrafficTypeDiagnostic: SN6PR11MB2880:
X-Microsoft-Antispam-PRVS: <SN6PR11MB28804B46F0EE700781B533E68FF60@SN6PR11MB2880.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0345CFD558
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(39850400004)(136003)(366004)(199004)(956004)(2616005)(478600001)(6486002)(2906002)(5660300002)(31686004)(7416002)(52116002)(53546011)(8676002)(6706004)(81166006)(4326008)(8936002)(81156014)(31696002)(86362001)(26005)(66946007)(15650500001)(186003)(16526019)(66476007)(6666004)(66556008)(36756003)(16576012)(316002)(6916009)(78286006);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR11MB2880;H:SN6PR11MB3360.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: windriver.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Tzwe3+FcR8i0GebttUlZ1s7a3kQ2fkdknDoxLOwDSRhGE3QUDEz4JbVNVc/xWlvN5W4Glrm9Hitm5PFawVmGl763DAkK3+tnYOgUs7rkNpN4nyHrf4k/mfsmVHjXfyKktG1CdHI91W5tnzYC3JJ6U22L5e6W7dFTsKh0gQrun4zb3KOUUb08ppkTLjlm1oYX5h3dCzwo/EUHSk96ccusleHBizS179bvaEz2zgzH707bI8Ku93y8zy2kIKiLBTs4rBx4Ui76o5wqmK/0P/XJP62yTSEzT/PKp2LxyV/TTQthn9GoqKuClvsCx9hmx0gWuadsdgPrkJ8/pTpAg42ABqFzExwWy/E1RtZRHcGfdWYwjb5b7/HwnYzKWCYOffMWq6azk7lU7kY2AUYr9hJ0+0WqPR85A3wxhJ08IQj7UmgXmUFatGakeyt0icOF1kjjwnCumjRj5/y34ncMESDmEuCKTUl5iWm9Ba/i+y9JkAV4G0Ym5vjupMXrxA8AGbgm6hJzM/hwlXBTx+3IclaeXr4d7+nuDRjx9BYL62+M1j0=
X-MS-Exchange-AntiSpam-MessageData: 219+CEimlBmOL71wNoOQWbl3EKI9VjFJEmHxyyVYKgxPXdE0reCscsfTFEndjEJujTEzivmM1S50oaV0IHJ4r4SrpX/kT6ITcVPju1s2Otdw/ZFuyMjWZ7FUvtlAfamD3s9WZukPFyWdOQcSZrdQmQ==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f85771a-c97a-433e-9466-08d7ca503887
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2020 08:50:19.5325
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uF8D3WCKkRFMTUylZEC4EuVnFTlcxpD7bH3MxpZqqZrs4PNEStuu2S1B8T8DTbSMNJA5xMCY3z8Luzfj9r12Gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2880
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 3/16/20 7:37 PM, Christoph Hellwig wrote:
> On Mon, Mar 16, 2020 at 07:01:09PM +0800, He Zhe wrote:
>>> Do 142fe8f and 979c690d work with the build fix applied? (f0b870d
>>> shouldn't be interesting for this case).
>> Sorry for slow reply.
>>
>> With my build fix applied, the issue is triggered since 142fe8f.
>> And I can see the endless loop of invalidate and revalidate...
> Thanks.  Can you test the patch below that restores the previous
> rather odd behavior of not clearing the capacity to 0 if partition
> scanning is not enabled?

This fixes the issue. I also validated it on v5.6-rc6.

Thank you very much.

Zhe

>
>
> diff --git a/fs/block_dev.c b/fs/block_dev.c
> index 69bf2fb6f7cd..daac27f4b821 100644
> --- a/fs/block_dev.c
> +++ b/fs/block_dev.c
> @@ -1520,10 +1520,13 @@ int bdev_disk_changed(struct block_device *bdev, bool invalidate)
>  	if (ret)
>  		return ret;
>  
> -	if (invalidate)
> -		set_capacity(disk, 0);
> -	else if (disk->fops->revalidate_disk)
> -		disk->fops->revalidate_disk(disk);
> +	if (invalidate) {
> +		if (disk_part_scan_enabled(disk))
> +			set_capacity(disk, 0);
> +	} else {
> +		if (disk->fops->revalidate_disk)
> +			disk->fops->revalidate_disk(disk);
> +	}
>  
>  	check_disk_size_change(disk, bdev, !invalidate);
>  

