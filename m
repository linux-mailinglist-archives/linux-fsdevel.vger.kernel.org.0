Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E630228D79
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 May 2019 00:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388526AbfEWWyN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 May 2019 18:54:13 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:14711 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387693AbfEWWyN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 May 2019 18:54:13 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ce7248f0000>; Thu, 23 May 2019 15:54:07 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 23 May 2019 15:54:11 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 23 May 2019 15:54:11 -0700
Received: from [10.110.48.28] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 23 May
 2019 22:54:08 +0000
Subject: Re: [PATCH 1/1] infiniband/mm: convert put_page() to put_user_page*()
From:   John Hubbard <jhubbard@nvidia.com>
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
 <050f56d0-1dda-036e-e508-3a7255ac7b59@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <6a18af65-7071-2531-d767-42ba74ad82c4@nvidia.com>
Date:   Thu, 23 May 2019 15:54:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <050f56d0-1dda-036e-e508-3a7255ac7b59@nvidia.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1558652047; bh=O/RiGmoYGRmC02sjlkIu6qvEn5MHd+ORmeaARAOsB+c=;
        h=X-PGP-Universal:Subject:From:To:CC:References:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=hOjBNbxmo0Oua+svsnfjV4ODR+jjb3kNvpchAZldU4CjYjIIRn76kDjdTnLmZWS/Q
         rTepf8lEmxnjtuHNh6CwoqckUUQWi5NM6Bzy/QtAzpqAyI4rCnP1ihCjCufoUDn4JM
         w87ysqq3taZlo9/bkfNVXF8tMnsv/6JwLwp1TY0us7ggJQu2tS1lCfzEbyHYapAsdm
         82gMkvowgkra8cxbWzoj/m+QlJQl0G9muFCquiUNeV+GNpegaXHpUGgM+FPmV0ZeTD
         1+bD8kWAHnGrJho7YtPlzT81sgio8SilaAgeKlDcYXGWeE+iv7CbDwd0LC5tHm3wwE
         1xBP0KgrUEWtg==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/23/19 3:50 PM, John Hubbard wrote:
> [...] 
> I was thinking of it as a temporary measure, only up until, but not including the
> point where put_user_pages() becomes active. That is, the point when put_user_pages
> starts decrementing GUP_PIN_COUNTING_BIAS, instead of just forwarding to put_page().
> 
> (For other readers, that's this patch:
> 
>     "mm/gup: debug tracking of get_user_pages() references"
> 
> ...in https://github.com/johnhubbard/linux/tree/gup_dma_core )
> 

Arggh, correction, I meant this patch:

    "mm/gup: track gup-pinned pages"

...sorry for any confusion there.

thanks,
-- 
John Hubbard
NVIDIA

