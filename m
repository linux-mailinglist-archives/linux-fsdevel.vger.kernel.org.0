Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACE19258193
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Aug 2020 21:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729395AbgHaTJS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Aug 2020 15:09:18 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:10110 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727993AbgHaTJS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Aug 2020 15:09:18 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f4d4acf0000>; Mon, 31 Aug 2020 12:09:03 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 31 Aug 2020 12:09:17 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 31 Aug 2020 12:09:17 -0700
Received: from [10.2.61.194] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 31 Aug
 2020 19:09:13 +0000
Subject: Re: [PATCH v3 3/3] bio: convert get_user_pages_fast() -->
 pin_user_pages_fast()
To:     Ira Weiny <ira.weiny@intel.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        "Ilya Dryomov" <idryomov@gmail.com>, Jens Axboe <axboe@kernel.dk>,
        <linux-xfs@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-block@vger.kernel.org>, <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20200831071439.1014766-1-jhubbard@nvidia.com>
 <20200831071439.1014766-4-jhubbard@nvidia.com>
 <20200831165222.GD1422350@iweiny-DESK2.sc.intel.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <35f751d4-bae4-e91e-d5f1-ddc38e2091ba@nvidia.com>
Date:   Mon, 31 Aug 2020 12:09:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200831165222.GD1422350@iweiny-DESK2.sc.intel.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1598900943; bh=hmlm7qZUmqe8ZIX2tGp4tRD8QX+HOSHwmnTYYOtpD7o=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=ksPuWCmcI3fUby20QQ0e06U1xsnQvObWtkl1QqqrjT6r9MT4nLTq2sY7Hx53H/xPd
         K3REe7NKoue3je9odo7fYIpnsM1yCMJJf3rC9HFhWsAmclzlYtdLwFD79uiVTEvuhX
         XuL6fbEr5SFGg1oF85YrW6EnLPMuyfcS2RqoXZk4QG2OZisogf6GaqjWrJ0FuSLKaN
         cUcfChhysPRi9lDrSsGadFMV82UWrm7C7lBbarJGsVQ7k2/O1iqW7ME46kNkgtrGYw
         nM0FWNhyHT/Vorx+AlvG7SLjqoagaQ9FLNF9Wemd+xSYuP/9SlVBkZWa3zVhgtXWZW
         ef492fMyHwtrA==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/31/20 9:52 AM, Ira Weiny wrote:
> On Mon, Aug 31, 2020 at 12:14:39AM -0700, John Hubbard wrote:
>> @@ -1113,8 +1113,8 @@ int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
>>   		} else {
>>   			if (is_bvec)
>>   				ret = __bio_iov_bvec_add_pages(bio, iter);
>> -			else
>> -				ret = __bio_iov_iter_get_pages(bio, iter);
>> +		else
>> +			ret = __bio_iov_iter_get_pages(bio, iter);
> 
> Why the white space change?
> 

Yikes, that's an oversight, and...yes, it goes all the way back to v1.
Thanks for spotting it!

There is not supposed to be any diff at all, in that region of code.
I'll restore the hunk to its rightful, undisturbed state, in v4.


thanks,
-- 
John Hubbard
NVIDIA
