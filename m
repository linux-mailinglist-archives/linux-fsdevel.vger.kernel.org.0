Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0201D360B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 May 2020 18:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbgENQK0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 May 2020 12:10:26 -0400
Received: from mail-bn7nam10on2066.outbound.protection.outlook.com ([40.107.92.66]:18930
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726073AbgENQK0 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 May 2020 12:10:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KbJeJcgB992WZ5JB9XXGxAcYlYoNzFTiLfjyGptEK6VtZ84wOj7DT4U8Gc96H7QnVjxiC9Zk83LshGEuPrgsWYlXa3yy8CULRPyjREZ3q2AFnFNj+1cCPCMsWIgSx8bEY9IiOWSa/WL1cr6y1Yc1u/5vggFqgfKupjhTgMmMzg/vZ2nLm/Isl85RzZvkrk+nNN8jDijMo7snVIBIjMBLTL/vVrh/aWYRbj/YCikAR/vJTcOp0Jb5NbUd2pPSH8KouhTxV1TyR1wdM5Pl6dVruuC/Szl0r5VVpNij5WMmmReSIIiACx6pMdapiOKH2EOS4GsEW2R7oiOGLouH/tk1Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e3nNYRLH6vluAwha3d4UNpCRbchEXPYLjd/OKgBerW8=;
 b=nvFZaQVuhkm9FBw/4ziN79bgyI+cCA3DD95b5Is/DzECJCf6P7w64ojypaDFQPGRkCNOvtWXJRlUOs/uEtjmc9k6ui19KxYykS2rwk7R1uV3TGkguCHMiQljFJCb8RTRmce93TGDElBz+Dy3wEhSzxIdKXlumvHwLvXIMnHx0hMDLTojhox7u9udDzRvxkh4ebryGo/0QAsTLsOZsvvTo5dsRWNNfkdcTLJs+RBs/nyNPylki3x3J7oFKEdyIw/5YxPlgjajp/6igLGU7Dwmxb6shSETqO3gNt27QO2JceIFyPAIGG7F6+bNh3zULBfRMkJASCwzVJpolIiDkChD8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e3nNYRLH6vluAwha3d4UNpCRbchEXPYLjd/OKgBerW8=;
 b=qBhTSfeTNG3w18+yaF4wiZv+vvpR3MHvXcfzjJQDppI8aa5HNbvRyk2wk4t4Rj4M+L+kw2Dgjg9iNL8wMuV+zgyTmHRIotuVuBoWwbHzzHnZ62jSwtDwjE7aYaNFQLQ6xcwiSTZVQlZb1scebTCINmcIiN7PlrwRMvIeijqh8g8=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from BY5PR11MB4241.namprd11.prod.outlook.com (2603:10b6:a03:1ca::13)
 by BY5PR11MB4006.namprd11.prod.outlook.com (2603:10b6:a03:188::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20; Thu, 14 May
 2020 16:10:22 +0000
Received: from BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::21d0:98fe:1248:b562]) by BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::21d0:98fe:1248:b562%7]) with mapi id 15.20.3000.016; Thu, 14 May 2020
 16:10:22 +0000
Subject: Re: BUG:loop:blk_update_request: I/O error, dev loop6, sector 49674
 op 0x9:(WRITE_ZEROES)
To:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-block@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <dac81506-0065-ee64-fcd1-c9f1d002b4fb@windriver.com>
 <c51460e0-1abb-799d-9ee9-de9c39315eda@windriver.com>
 <8f3eeb22-2e85-aa3f-6287-b3c467d39a8e@kernel.dk>
 <20200513164119.GD1984748@magnolia>
From:   "Xu, Yanfei" <yanfei.xu@windriver.com>
Message-ID: <14e2378f-1d0f-e4b6-d0e2-eb19f1b12c6c@windriver.com>
Date:   Fri, 15 May 2020 00:10:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <20200513164119.GD1984748@magnolia>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR01CA0022.prod.exchangelabs.com (2603:10b6:a02:80::35)
 To BY5PR11MB4241.namprd11.prod.outlook.com (2603:10b6:a03:1ca::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.160] (60.247.85.82) by BYAPR01CA0022.prod.exchangelabs.com (2603:10b6:a02:80::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.25 via Frontend Transport; Thu, 14 May 2020 16:10:20 +0000
X-Originating-IP: [60.247.85.82]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: da7af903-f2a8-41d6-16b8-08d7f8214dea
X-MS-TrafficTypeDiagnostic: BY5PR11MB4006:
X-Microsoft-Antispam-PRVS: <BY5PR11MB4006A8D482CF7BD21DCBD0BCE4BC0@BY5PR11MB4006.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 040359335D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xspELxsGdubapDnvlxpGRTHW3N8gBgUU1HIRjMWxShv4YE1Irbv0ETZyk1u3L061AA5weutSqGKyAQ45lXubyji7HQHrpFJSLDY03q6nbv7VO+5wmeW+njfzg22PqZFDReazlmPn/eRADYpHylnoi7dhDi5qMX17GuxxEWFF7J0Z/62VnT0GHxWZmBv7/OlFkrinSPb3bqaXVaVVtHTgKsXGNnNOCMwbmKMOemxp6M2HJaDCCpDqhhzLYKYQWtnUB92pUpZ4tA8/I5sGndslJzCw4s7p/p/5iBxaYDYkLBRNilEQYfgiea8Dv75K16mO3BytxoDi7RUJVrhM+cxCIaF6BsVt8kyMoRVXND8G4VGYYF2fXBXvD6JkUW6T9kIn7Z/Ua3EFCXnVfCqevfQ9zBhB4LKroNCeTE6JUnb32pUbt1q3BIGnLMUEYKGuOpuJFnt7N0abH0tzX0VJHaFeAa/U3jw2PvXEw51KodV13HFCqXtYnC0BiLNdQsyj1JTvVkN6VE+J8IsYVXkUUhuNCRJWoG6ao9n5VATQxFdnDyVugmViRLyu9usXIdNkpoQZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39850400004)(376002)(346002)(366004)(396003)(136003)(31686004)(2906002)(31696002)(66556008)(186003)(5660300002)(6706004)(316002)(86362001)(6486002)(8676002)(66946007)(16576012)(110136005)(66476007)(36756003)(4326008)(8936002)(52116002)(6666004)(16526019)(53546011)(2616005)(478600001)(26005)(54906003)(956004)(78286006)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: HJ7Sr14E5+4bq6G/jit+E5DPhXUQ7G9odOXIwSJrlmKR5PasADqi8j7UX0TQk/QGPouASDm0HoTrDdPAA0SEjaaUwTvMIZuorv6lTYpJ2hKjgHI4KsfRkffak1JMzVu4gJmcxQzZHzJJh7/3OlVyTZt5o2nu/jXN6jOejr5rO0dzOwEJ/xojKcVWnMOyu4914/XuKCzOJZ/Go9ropWw6ciRRrFtEEs1uOVoB8anivmdCz1uDa8L4XVYd12b7lDCb38SHiLYAafZUxQvn2+kBlNBNpykyyz97uJIOCPETQ2/7vgP4/pWo2Bnj/mqBUHCHhg6/YCpKHwNMO+ltngh/kf3/suxy80Kpdx45jgcdSKG4wYnOpER9IEvjL40RH5CMF3oTKiG6e8ErWviArU6dEdfc6iz64/rD+Bmwg3AAnmtoyN1Z170NhpTGeLmOvnhpcyiumKXIcqgBsbXKkyirTHXJOYgFNxkuTIoaR+NICAY=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da7af903-f2a8-41d6-16b8-08d7f8214dea
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2020 16:10:22.3309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JQ4Oe80aXUfTAx4DGGbmDP78qjJi2gGGGTzPQkwmwflbz5pgBeb3sG+BPfh88AOsh93UvtxSP7kfJ86DPW3mew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4006
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 5/14/20 12:41 AM, Darrick J. Wong wrote:
> [add fsdevel to cc]
> 
> On Tue, May 12, 2020 at 08:22:08PM -0600, Jens Axboe wrote:
>> On 5/12/20 8:14 PM, Xu, Yanfei wrote:
>>> Hi,
>>>
>>> After operating the /dev/loop which losetup with an image placed in**tmpfs,
>>>
>>> I got the following ERROR messages:
>>>
>>> ----------------[cut here]---------------------
>>>
>>> [  183.110770] blk_update_request: I/O error, dev loop6, sector 524160 op 0x9:(WRITE_ZEROES) flags 0x1000800 phys_seg 0 prio class 0
>>> [  183.123949] blk_update_request: I/O error, dev loop6, sector 522 op 0x9:(WRITE_ZEROES) flags 0x1000800 phys_seg 0 prio class 0
>>> [  183.137123] blk_update_request: I/O error, dev loop6, sector 16906 op 0x9:(WRITE_ZEROES) flags 0x1000800 phys_seg 0 prio class 0
>>> [  183.150314] blk_update_request: I/O error, dev loop6, sector 32774 op 0x9:(WRITE_ZEROES) flags 0x1000800 phys_seg 0 prio class 0
>>> [  183.163551] blk_update_request: I/O error, dev loop6, sector 49674 op 0x9:(WRITE_ZEROES) flags 0x1000800 phys_seg 0 prio class 0
>>> [  183.176824] blk_update_request: I/O error, dev loop6, sector 65542 op 0x9:(WRITE_ZEROES) flags 0x1000800 phys_seg 0 prio class 0
>>> [  183.190029] blk_update_request: I/O error, dev loop6, sector 82442 op 0x9:(WRITE_ZEROES) flags 0x1000800 phys_seg 0 prio class 0
>>> [  183.203281] blk_update_request: I/O error, dev loop6, sector 98310 op 0x9:(WRITE_ZEROES) flags 0x1000800 phys_seg 0 prio class 0
>>> [  183.216531] blk_update_request: I/O error, dev loop6, sector 115210 op 0x9:(WRITE_ZEROES) flags 0x1000800 phys_seg 0 prio class 0
>>> [  183.229914] blk_update_request: I/O error, dev loop6, sector 131078 op 0x9:(WRITE_ZEROES) flags 0x1000800 phys_seg 0 prio class 0
>>>
>>>
>>> I have found the commit which introduce this issue by git bisect :
>>>
>>>      commit :efcfec57[loop: fix no-unmap write-zeroes request behavior]
>>
>> Please CC the author of that commit too. Leaving the rest quoted below.
>>
>>> Kernrel version: Linux version 5.6.0
>>>
>>> Frequency: everytime
>>>
>>> steps to reproduce:
>>>
>>>    1.git clone mainline kernel
>>>
>>>    2.compile kernel with ARCH=x86_64, and then boot the system with it
>>>
>>>      (seems other arch also can reproduce it )
>>>
>>>    3.make an image by "dd of=/tmp/image if=/dev/zero bs=1M count=256"
>>>
>>>    *4.**place the image in tmpfs directory*
>>>
>>>    5.losetup /dev/loop6 /PATH/TO/image
>>>
>>>    6.mkfs.ext2 /dev/loop6
>>>
>>>
>>> Any comments will be appreciated.
> 
> Hm, you got IO failures here because shmem_fallocate doesn't support
> FL_ZERO_RANGE range.  That might not be too hard to add, but there's a
> broader problem of detecting fallocate support--
> 
> The loop driver assumes that if the file has an fallocate method then
> it's safe to set max_discard_sectors (and now max_write_zeroes_sectors)
> to UINT_MAX>>9.  There's currently no good way to detect which modes are
> supported by a filesystem's ->fallocate function, or to discover the
> required granularity.
> 
> Right now we tell application developers that the way to discover the
> conditions under which fallocate will work is to try it and see if they
> get EOPNOTSUPP.
> 
> One way to "fix" this would be to fix lo_fallocate to set RQF_QUIET if
> the filesystem returns EOPNOTSUPP, which gets rid of the log messages.
> We probably ought to zero out the appropriate max_*_sectors if we get
> EOPNOTSUPP.

Many thanks for your detailed reply:) No good method for detecting
fallocte support is a real problem. And the way to "fix" you mentioned
do is a good workaround for the current satuation.


Best regards,
Yanfei

> 
> --D
> 
>>>
>>>
>>> Thanks,
>>>
>>> Yanfei
>>>
>>>
>>>
>>>
>>>
>>
>>
>> -- 
>> Jens Axboe
>>
