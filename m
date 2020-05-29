Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF5621E76A0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 May 2020 09:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725993AbgE2H2W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 May 2020 03:28:22 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:17869 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgE2H2V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 May 2020 03:28:21 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ed0b9400000>; Fri, 29 May 2020 00:26:56 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 29 May 2020 00:28:21 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 29 May 2020 00:28:21 -0700
Received: from [10.2.62.53] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 29 May
 2020 07:28:20 +0000
Subject: Re: Question: "Bare" set_page_dirty_lock() call in vhost.c
To:     Jan Kara <jack@suse.cz>
CC:     Linux-MM <linux-mm@kvack.org>, <linux-fsdevel@vger.kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>
References: <3b2db4da-9e4e-05d1-bf89-a261f0eb6de0@nvidia.com>
 <20200529070343.GL14550@quack2.suse.cz>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <6680c2d2-4b45-0e83-96e0-e7d3d421c571@nvidia.com>
Date:   Fri, 29 May 2020 00:28:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200529070343.GL14550@quack2.suse.cz>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1590737216; bh=gKHq8sZZl10FvnWlIThaTlMuX+nOHNtKN/6tfQJLkjg=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=FdD/WjFm/dalaRZIqCTxNrPs4XD8Y0wu3t6tJ71Dmq7TSd5FqTIAVpMyO0AmU3ktb
         RYQXa9KGNsVyc1t9UZqksGmCtmzlU47bkdF+A/cL2kCnF6IX73l3jY9cYbb08bdg5E
         axyQAqmVNnB8EfjGim59OM/QgxFd00NfrlnroUjPu2uwWK6/5DqeqpJLMOevSVlVmo
         /Ldf8ACJqNAT/UEwM0+wCgMVUPTU8ULnMitqPk9kXqwY2dGLzOdPQ3FwhpHW+6CE2D
         lz5nJaIJIfdpVpxwVfZ+ANhTO/PSCN8a5aRi1CBwJsqnUTjiiIHwaLbV2/QHVDDga/
         YyVDnP4NjIsxw==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020-05-29 00:03, Jan Kara wrote:
...
>> ...which actually is the the case that pin_user_pages*() is ultimately
>> helping to avoid, btw. But in this case, it's all code that runs on a
>> CPU, so no DMA or DIO is involved. But still, the "bare" use of
>> set_page_dirty_lock() seems like a problem here.
> 
> I agree that the site like above needs pin_user_pages(). The problem has
> actually nothing to do with kmap_atomic() - that actually doesn't do
> anything interesting on x86_64. The moment GUP_fast() returns, page can be
> unmapped from page tables and written back so this site has exactly same
> problems as any other using DMA or DIO. As we discussed earlier when
> designing the patch set, the problem is really with GUP reference being
> used to access page data. And the method of access (DMA, CPU access, GPU
> access, ...) doesn't really matter...
> 
> 								Honza

Awesome, I was really starting to wonder what I was missing. This all
makes perfect sense, thanks.

Maybe I'll add a "Case 5" to Documentation/core-api/pin_user_pages.rst,
to cover this sort of situation. It's not completely obvious from the
first four cases, that this code is exposed to that problem.


thanks,
-- 
John Hubbard
NVIDIA
