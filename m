Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC331250ECD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Aug 2020 04:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727943AbgHYCN3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Aug 2020 22:13:29 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:8803 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725850AbgHYCN3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Aug 2020 22:13:29 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f4473510001>; Mon, 24 Aug 2020 19:11:29 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 24 Aug 2020 19:13:28 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 24 Aug 2020 19:13:28 -0700
Received: from [10.2.53.36] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 25 Aug
 2020 02:13:28 +0000
Subject: Re: [PATCH 0/5] bio: Direct IO: convert to pin_user_pages_fast()
To:     Al Viro <viro@zeniv.linux.org.uk>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, Jeff Layton <jlayton@kernel.org>,
        <linux-xfs@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-block@vger.kernel.org>, <ceph-devel@vger.kernel.org>,
        <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>
References: <20200822042059.1805541-1-jhubbard@nvidia.com>
 <20200825015428.GU1236603@ZenIV.linux.org.uk>
 <20200825020700.GV1236603@ZenIV.linux.org.uk>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <26bf92af-a7ab-b53f-45dd-9e3d7a1340ec@nvidia.com>
Date:   Mon, 24 Aug 2020 19:13:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200825020700.GV1236603@ZenIV.linux.org.uk>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1598321489; bh=GIRbiEa7azLOIxon4iO5FS/T0uGJkiVpYwweEhJNBpo=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=UmGWTkcrZ9y1HwcrElFPjcGx3VjBPiGha3uyULxM2OY1I/bwLKzfacmPOQxQ9GyZK
         HaJxO8iWVCSV2SjHo2+oV6rNZVVtuNWVw3a/vVVyVbIVd8RMrpp+UP3P0Qbcvs7Hml
         dV1gOlzPwkqYsdvsO7kr1skfGk6S+1fTD2GPIOmac0RirS4lQih9RBp5lKrfB9SntS
         5OPL4gnMZFbN6Ed6wHZJHy3HjGvuuzSoREEObkE/ig7JZyF0FotPHyFHVAx1B88Jo5
         NSgr+DaOPpw0gqM8+krNIZpyhHdQJ6bP6DwweQCl+lwB3zfKhGjKRQYKeWO2jKZ41E
         RM8alNM34Jb2g==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/24/20 7:07 PM, Al Viro wrote:
> On Tue, Aug 25, 2020 at 02:54:28AM +0100, Al Viro wrote:
>> On Fri, Aug 21, 2020 at 09:20:54PM -0700, John Hubbard wrote:
>>
>>> Direct IO behavior:
>>>
>>>      ITER_IOVEC:
>>>          pin_user_pages_fast();
>>>          break;
>>>
>>>      ITER_KVEC:    // already elevated page refcount, leave alone
>>>      ITER_BVEC:    // already elevated page refcount, leave alone
>>>      ITER_PIPE:    // just, no :)
>>
>> Why?  What's wrong with splice to O_DIRECT file?
> 
> Sorry - s/to/from/, obviously.
> 
> To spell it out: consider generic_file_splice_read() behaviour when
> the source had been opened with O_DIRECT; you will get a call of
> ->read_iter() into ITER_PIPE destination.  And it bloody well
> will hit iov_iter_get_pages() on common filesystems, to pick the
> pages we want to read into.
> 
> So... what's wrong with having that "pin" primitive making sure
> the pages are there and referenced by the pipe?
> 

(our emails crossed) OK, yes, let me hook that up. I was just unaware
of that flow, I'll go off and figure it out.

Thanks for looking at this!

thanks,
-- 
John Hubbard
NVIDIA
