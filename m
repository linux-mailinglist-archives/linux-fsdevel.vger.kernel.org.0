Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F210728D6D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 May 2019 00:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388496AbfEWWuV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 May 2019 18:50:21 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:9797 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387546AbfEWWuV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 May 2019 18:50:21 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ce723ac0005>; Thu, 23 May 2019 15:50:20 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 23 May 2019 15:50:19 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 23 May 2019 15:50:19 -0700
Received: from [10.110.48.28] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 23 May
 2019 22:50:14 +0000
Subject: Re: [PATCH 1/1] infiniband/mm: convert put_page() to put_user_page*()
To:     Ira Weiny <ira.weiny@intel.com>
CC:     Jason Gunthorpe <jgg@mellanox.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        "Mike Marciniszyn" <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Christian Benvenuti <benve@cisco.com>,
        "Jan Kara" <jack@suse.cz>
References: <20190523072537.31940-1-jhubbard@nvidia.com>
 <20190523072537.31940-2-jhubbard@nvidia.com>
 <20190523172852.GA27175@iweiny-DESK2.sc.intel.com>
 <20190523173222.GH12145@mellanox.com>
 <fa6d7d7c-13a3-0586-6384-768ebb7f0561@nvidia.com>
 <20190523190423.GA19578@iweiny-DESK2.sc.intel.com>
 <0bd9859f-8eb0-9148-6209-08ae42665626@nvidia.com>
 <20190523223701.GA15048@iweiny-DESK2.sc.intel.com>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <050f56d0-1dda-036e-e508-3a7255ac7b59@nvidia.com>
Date:   Thu, 23 May 2019 15:50:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190523223701.GA15048@iweiny-DESK2.sc.intel.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1558651820; bh=pnD2mPom1537ot4zdnaJYiSqU3krtz3ITZMHoUjrO54=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=PL1hqSFGAyha/HZ79WcNqF63aQObWkwaPlneBIGP0b7M7mgvTnxDuamjPTAyGfKF1
         yHMeLk26WEhfP2v931D1xU4W3M3kiwYQmBfLraEzR5YZXcfsobgtoJPyyLH4+6FTSu
         jnQhcgabwqiWxG7558a5TO0DHh6plvrU70wZ6snBovpECiJdOYn4l86CCwmo3NDu3O
         3UXNZap6nUALoyxA2W+ylo2ndYIsR8f9oF+z0OhfOamlbdOLOBUEnQFBZGiQWt1HUc
         6E7eSVdsS34aUe5ZN9gIcZVR9Y/B0Sxsb590oa3FJ9NZuUjjM8XRY+0vmapyQQB2fM
         PPK57wDeZu70A==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/23/19 3:37 PM, Ira Weiny wrote:
[...] 
> I've dug in further and I see now that release_pages() implements (almost the
> same thing, see below) as put_page().
> 
> However, I think we need to be careful here because put_page_testzero() calls
> 
> 	page_ref_dec_and_test(page);
> 
> ... and after your changes it will need to call ...
> 
> 	page_ref_sub_return(page, GUP_PIN_COUNTING_BIAS);
> 
> ... on a GUP page:
> 
> So how do you propose calling release_pages() from within put_user_pages()?  Or
> were you thinking this would be temporary?

I was thinking of it as a temporary measure, only up until, but not including the
point where put_user_pages() becomes active. That is, the point when put_user_pages
starts decrementing GUP_PIN_COUNTING_BIAS, instead of just forwarding to put_page().

(For other readers, that's this patch:

    "mm/gup: debug tracking of get_user_pages() references"

...in https://github.com/johnhubbard/linux/tree/gup_dma_core )

> 
> That said, there are 2 differences I see between release_pages() and put_page()
> 
> 1) release_pages() will only work for a MEMORY_DEVICE_PUBLIC page and not all
>    devmem pages...
>    I think this is a bug, patch to follow shortly.
> 
> 2) release_pages() calls __ClearPageActive() while put_page() does not
> 
> I have no idea if the second difference is a bug or not.  But it smells of
> one...
> 
> It would be nice to know if the open coding of put_page is really a performance
> benefit or not.  It seems like an attempt to optimize the taking of the page
> data lock.
> 
> Does anyone have any information about the performance advantage here?
> 
> Given the changes above it seems like it would be a benefit to merge the 2 call
> paths more closely to make sure we do the right thing.
> 

Yes, it does. Maybe best to not do the temporary measure, then, while this stuff
gets improved. I'll look at your other patch...


thanks,
-- 
John Hubbard
NVIDIA
