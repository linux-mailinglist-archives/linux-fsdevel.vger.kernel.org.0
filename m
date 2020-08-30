Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0CE25708E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Aug 2020 22:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbgH3UoC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 30 Aug 2020 16:44:02 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:10824 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbgH3UoB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 30 Aug 2020 16:44:01 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f4c0f130002>; Sun, 30 Aug 2020 13:41:55 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sun, 30 Aug 2020 13:44:00 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sun, 30 Aug 2020 13:44:00 -0700
Received: from [10.2.61.194] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 30 Aug
 2020 20:44:00 +0000
Subject: Re: [PATCH v2 2/3] iov_iter: introduce iov_iter_pin_user_pages*()
 routines
To:     Al Viro <viro@zeniv.linux.org.uk>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, <linux-xfs@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>
References: <20200829080853.20337-1-jhubbard@nvidia.com>
 <20200829080853.20337-3-jhubbard@nvidia.com>
 <20200830201705.GV1236603@ZenIV.linux.org.uk>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <86b4af1b-12c1-4e01-3663-e87eb551c25b@nvidia.com>
Date:   Sun, 30 Aug 2020 13:44:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200830201705.GV1236603@ZenIV.linux.org.uk>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1598820115; bh=VpXWPapMvQEi4/NaEs92wBWmsY7/i8I/51IItbed+yc=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=JoJTBvi4j3NiX8QlotO9XwFW+WadrSTY53plUvJlG458WCiiZ0d8cFbYb6GDFJ1HT
         FrB7mA6enVZ6v2s35eh8bY/SQyDzJF81f278lMCqjUsGtQdLMfOSkN+PmH8B9qI9Z4
         rrxqZ5a9DmmBtGiuk7KlZ9GqeC3XjTjq+q+5JleCZNSUoEzhog+Z5Rkj17aAJ/D87p
         k/KdUIByXkFSGvyOKDYBERQ1ZjA5GAqgPJ18/KIiX6E6r2N83asmT/IbE4m0jQpxme
         1/g0f/tFQOPzlckT49nG1NIz2wDHNJx6fKhLboWOud33LT+CFcd211t6wln4NGUkiG
         94S9chEHiwPXQ==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/30/20 1:17 PM, Al Viro wrote:
...
>> Why: In order to incrementally change Direct IO callers from calling
>> get_user_pages_fast() and put_page(), over to calling
>> pin_user_pages_fast() and unpin_user_page(), there need to be mid-level
>> routines that specifically call one or the other systems, for both page
>> acquisition and page release.
> 
> Hmm...  Do you plan to kill iov_iter_get_pages* off, eventually getting
> rid of that use_pup argument?
> 

Yes. That is definitely something I'm interested in doing, and in fact,
I started to write words to that effect into the v1 cover letter. I lost
confidence at the last minute, after poking around the remaining call
sites (which are mostly network file systems, plus notably io_uring),
and wondering if I really understood what the hell I was doing. :)

So I decided to reduce the scope of the proposal, until I got some
feedback. Which I now have!

Looking at this again, I see that there are actually *very* few
ITER_KVEC and ITER_BVEC callers, so...yes, maybe this can all be
collapsed down to calling the new functions, which would always use pup,
and lead to the simplification you asked about.

Any advance warnings, advice, design thoughts are definitely welcome
here.


thanks,
-- 
John Hubbard
NVIDIA
