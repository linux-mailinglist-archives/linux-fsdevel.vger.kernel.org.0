Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB12124F32A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Aug 2020 09:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726374AbgHXHgv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Aug 2020 03:36:51 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:4109 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgHXHgu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Aug 2020 03:36:50 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f436e040000>; Mon, 24 Aug 2020 00:36:36 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 24 Aug 2020 00:36:50 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 24 Aug 2020 00:36:50 -0700
Received: from [10.2.58.8] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 24 Aug
 2020 07:36:50 +0000
Subject: Re: [PATCH 4/5] bio: introduce BIO_FOLL_PIN flag
From:   John Hubbard <jhubbard@nvidia.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, Jeff Layton <jlayton@kernel.org>,
        <linux-xfs@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-block@vger.kernel.org>, <ceph-devel@vger.kernel.org>,
        <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>
References: <20200822042059.1805541-1-jhubbard@nvidia.com>
 <20200822042059.1805541-5-jhubbard@nvidia.com>
 <20200823062559.GA32480@infradead.org>
 <efa2519d-53b7-7b08-bf85-a5c2d725282c@nvidia.com>
Message-ID: <f1a9b9b8-3e88-04d1-d08e-bed77330dbd8@nvidia.com>
Date:   Mon, 24 Aug 2020 00:36:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <efa2519d-53b7-7b08-bf85-a5c2d725282c@nvidia.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1598254596; bh=fQ0+/D92POi8rmal7APmpF3lFhiWzQJgt3U4odcmElw=;
        h=X-PGP-Universal:Subject:From:To:CC:References:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=UV544x6f4CXUb/fHE54BG1U42/SuaxsG3R0ElzOYOUdOSMuiqvtCuidVYHHjzyIMy
         +TNKLp8WRtC1YPrGnUIyVO4l3Ak0txN7EYgioe8Tt1GLiT8i2AjHhTmC8tlqtb1OAF
         LQWM9jV5qpdGrvyseDbElmej/SjlKTTCqf4RMdJye+19uKyfGvjz6nhXwZ0l5NhIoc
         Rr8zAmc4r0GkKRkofYrevq6oCxI+6DulxvIH85AK9iXEgg16KKFYR1zrFK0gy8WQQL
         Fbwka4WzfAsKVD0tOuigoAm3Bn2ZziF69E2Kpf81igaHmnJnCr34NBtA7NTUh0tdab
         FVE3jqr/+vyHw==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/22/20 11:57 PM, John Hubbard wrote:
> On 8/22/20 11:25 PM, Christoph Hellwig wrote:
>> On Fri, Aug 21, 2020 at 09:20:58PM -0700, John Hubbard wrote:
>>> Add a new BIO_FOLL_PIN flag to struct bio, whose "short int" flags field
>>> was full, thuse triggering an expansion of the field from 16, to 32
>>> bits. This allows for a nice assertion in bio_release_pages(), that the
>>> bio page release mechanism matches the page acquisition mechanism.
>>>
>>> Set BIO_FOLL_PIN whenever pin_user_pages_fast() is used, and check for
>>> BIO_FOLL_PIN before using unpin_user_page().
>>
>> When would the flag not be set when BIO_NO_PAGE_REF is not set?
> 
> Well, I don't *think* you can get there. However, I've only been studying
> bio/block for a fairly short time, and the scattering of get_page() and
> put_page() calls in some of the paths made me wonder if, for example,
> someone was using get_page() to acquire ITER_BVEC or ITER_KVEC via
> get_page(), and release them via bio_release_pages(). It's hard to tell.
> 
> It seems like that shouldn't be part of the design. I'm asserting that
> it isn't, with this new flag. But if you're sure that this assertion is
> unnecessary, then let's just drop this patch, of course.
> 

Also, I should have done a few more subsystem conversions, before
concluding that BIO_FOLL_PIN was a good idea. Now, as I'm working through mopping
up those other subsystems, I see that nfs/direct.c for example does not have access
to a bio instance, and so the whole thing is not really a great move, at least not
for adding to the iov_iter_pin_user_pages*() APIs.

Let's just drop this patch, after all.


thanks,
-- 
John Hubbard
NVIDIA
