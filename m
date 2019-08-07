Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0008567B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2019 01:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389008AbfHGXcK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Aug 2019 19:32:10 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:4118 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729624AbfHGXcJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Aug 2019 19:32:09 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d4b5f7a0000>; Wed, 07 Aug 2019 16:32:10 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 07 Aug 2019 16:32:08 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 07 Aug 2019 16:32:08 -0700
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 7 Aug
 2019 23:32:08 +0000
Subject: Re: [PATCH 1/3] mm/mlock.c: convert put_page() to put_user_page*()
To:     Michal Hocko <mhocko@kernel.org>, <john.hubbard@gmail.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jerome Glisse <jglisse@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Daniel Black <daniel@linux.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
References: <20190805222019.28592-1-jhubbard@nvidia.com>
 <20190805222019.28592-2-jhubbard@nvidia.com>
 <20190807110147.GT11812@dhcp22.suse.cz>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <01b5ed91-a8f7-6b36-a068-31870c05aad6@nvidia.com>
Date:   Wed, 7 Aug 2019 16:32:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190807110147.GT11812@dhcp22.suse.cz>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1565220730; bh=Vo6bQKtkk9LxLaQR6PE8mmqutIpc3NqGB6BA5P1fNgE=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=NrRvMjgZ026fJhY2X/UVob3ZUP7VbfQoX2fWC4rqAKy0rtWi8DdQ+dGpT9myh/Ups
         oQZ4iC5DhOS8fMX9OAOKdFdxT2+r22p977v74zrvGliO+4rYDr3xwzKQhhiD8261DI
         uWhhf3tl3zC3GIqtP7JRMFJvIf4rxZN5JgKREREk5KOERB6yo6bMNu88R4p5JniTVQ
         Ax29c0PctE88ki6fi9CXmAw1JGVRX10gWo12j1SVWJZ5rPCcUjzZjJhHpqbg9efdQP
         Kg7RC5y9sZF55OYmo73TeO6nKcqchTY2J4u2YycHEXaXJTEPbGcR6Y9t62fH1Tyy9A
         GpxiBAiRmC1Dg==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/7/19 4:01 AM, Michal Hocko wrote:
> On Mon 05-08-19 15:20:17, john.hubbard@gmail.com wrote:
>> From: John Hubbard <jhubbard@nvidia.com>
>>
>> For pages that were retained via get_user_pages*(), release those pages
>> via the new put_user_page*() routines, instead of via put_page() or
>> release_pages().
> 
> Hmm, this is an interesting code path. There seems to be a mix of pages
> in the game. We get one page via follow_page_mask but then other pages
> in the range are filled by __munlock_pagevec_fill and that does a direct
> pte walk. Is using put_user_page correct in this case? Could you explain
> why in the changelog?
> 

Actually, I think follow_page_mask() gets all the pages, right? And the
get_page() in __munlock_pagevec_fill() is there to allow a pagevec_release() 
later.

But I still think I mighthave missed an error case, because the pvec_putback
in __munlock_pagevec() is never doing put_user_page() on the put-backed pages.

Let me sort through this one more time and maybe I'll need to actually
change the code. And either way, comments and changelog will need some notes, 
agreed.

thanks,
-- 
John Hubbard
NVIDIA

