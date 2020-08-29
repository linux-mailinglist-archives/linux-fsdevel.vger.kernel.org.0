Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE3C8256A7E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Aug 2020 23:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbgH2V50 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 29 Aug 2020 17:57:26 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:19505 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726944AbgH2V5Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 29 Aug 2020 17:57:25 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f4acf180000>; Sat, 29 Aug 2020 14:56:41 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sat, 29 Aug 2020 14:57:25 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sat, 29 Aug 2020 14:57:25 -0700
Received: from [10.2.61.161] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 29 Aug
 2020 21:57:24 +0000
Subject: Re: [PATCH v2 1/3] mm/gup: introduce pin_user_page()
To:     Christoph Hellwig <hch@infradead.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, <linux-xfs@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>
References: <20200829080853.20337-1-jhubbard@nvidia.com>
 <20200829080853.20337-2-jhubbard@nvidia.com>
 <20200829145421.GA12470@infradead.org>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <2940f38d-be50-cc9d-efac-b472b90c86ad@nvidia.com>
Date:   Sat, 29 Aug 2020 14:57:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200829145421.GA12470@infradead.org>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1598738201; bh=7Q1/OAnms/oRZyYL7465ix/aRv+f5NiBpJz0hCn9ZYE=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=gypQg0n7SzMSd5HEKKPYBT9ldWQ7/EDP++LfytWaJ2yd9NnfX4CfA+7OPw8mB7VFm
         dXur8PsxCX5urTWyvtSIJEp6/Tg7ecETtVLJUBEpF8iCoxihRBtHqi969qvETp2JBA
         43k3Rsr4d64DpvH38i+4Q19DCDxBHRzHnzF2uOZYAukuH3NtKGPYYrptOw8h6Td/9q
         MMiqpKL5wSXvPX1kFy9Stiy49k8wc5C0giqrjkSkGJprYEQMoPPHlpsHNopZQoFTZE
         +FwGSgCVpjEE4Q0k7jSriGrl3yhZbR8DjgRY98IDp14/V76iIe6dm4vZQdQXhYlEc0
         OTj7Phdw14kmw==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/29/20 7:54 AM, Christoph Hellwig wrote:
> On Sat, Aug 29, 2020 at 01:08:51AM -0700, John Hubbard wrote:
>> pin_user_page() is the FOLL_PIN equivalent of get_page().
>>
>> This was always a missing piece of the pin/unpin API calls (early
>> reviewers of pin_user_pages() asked about it, in fact), but until now,
>> it just wasn't needed. Finally though, now that the Direct IO pieces in
>> block/bio are about to be converted to use FOLL_PIN, it turns out that
>> there are some cases in which get_page() and get_user_pages_fast() were
>> both used. Converting those sites requires a drop-in replacement for
>> get_page(), which this patch supplies.
> 
> I find the name really confusing vs pin_user_pages*, as it suggests as
> single version of the same.  It also seems partially wrong, at least
> in the direct I/O case as the only thing pinned here is the zero page.
> 
> So maybe pin_kernel_page is a better name together with an explanation?
> Or just pin_page?
> 

Yes. Both its behavior and use are closer to get_page() than it is to
get_user_pages(). So pin_page() is just right.


thanks,
-- 
John Hubbard
NVIDIA
