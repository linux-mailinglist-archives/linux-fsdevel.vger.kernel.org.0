Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7701F2508AE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Aug 2020 21:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgHXTCa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Aug 2020 15:02:30 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:19347 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbgHXTCa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Aug 2020 15:02:30 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f440e880000>; Mon, 24 Aug 2020 12:01:28 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 24 Aug 2020 12:02:30 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 24 Aug 2020 12:02:30 -0700
Received: from [10.2.58.8] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 24 Aug
 2020 19:02:29 +0000
Subject: Re: [PATCH 5/5] fs/ceph: use pipe_get_pages_alloc() for pipe
To:     Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, <linux-xfs@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <ceph-devel@vger.kernel.org>, <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20200822042059.1805541-1-jhubbard@nvidia.com>
 <20200822042059.1805541-6-jhubbard@nvidia.com>
 <048e78f2b440820d936eb67358495cc45ba579c3.camel@kernel.org>
 <c943337b-1c1e-9c85-4ded-39931986c6a3@nvidia.com>
 <af70d334271913a6b09bfd818bc3d81eef5a19b2.camel@kernel.org>
 <20200824185400.GE17456@casper.infradead.org>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <16ccf2d8-824f-8c8b-201c-95da8790c524@nvidia.com>
Date:   Mon, 24 Aug 2020 12:02:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200824185400.GE17456@casper.infradead.org>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/24/20 11:54 AM, Matthew Wilcox wrote:
> On Mon, Aug 24, 2020 at 02:47:53PM -0400, Jeff Layton wrote:
>> Ok, I'll plan to pick it up providing no one has issues with exporting that symbol.
> 
> _GPL, perhaps?
> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
	t=1598295688; bh=TGtHrKY9YE9vgbD3P6YUTHn7yhP+gCmFr3Z8XIdh17s=;
	h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
	 User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
	 X-ClientProxiedBy:Content-Type:Content-Language:
	 Content-Transfer-Encoding;
	b=KWZ+bMZ8RXIxd4CMBL8Dn6hn0ggsojx1vJaaueo+/+Xwe0yKBa+bMZfnn1XUDWvJs
	 KMZJ22FgEdc+HO/8Mx0JKVQsLfKj74dwj3kGjs1z0KA5Vcnx93pzd/iMXDFhClf3uz
	 KmyGEdar0p6poBaBOlsapOb59acP6ot16rhi7ZbTch+7ErO/Rupx6VinU1A2Ydc3OP
	 mBYXZqz35DZ/H5eqhoE84MuOFj8Ti/Wpen637pLLa5dmtXjSMRmYTQXMRygUmQXdaw
	 g9XLuqaxKRxp2lnuoVdFK0T90Hfu/71T+S8asZZYhH9zHY2Wzhgp1VkR07ZtXmMNqI
	 W/lB00RAVtj3Q==

I looked at that, and the equivalent iov_iter_get_pages* and related stuff was
just EXPORT_SYMBOL, so I tried to match that. But if it needs to be _GPL then
that's fine too...

thanks,
-- 
John Hubbard
NVIDIA
