Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01EE616879A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2020 20:44:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727184AbgBUToe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Feb 2020 14:44:34 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:15668 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726443AbgBUTod (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Feb 2020 14:44:33 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e5033120000>; Fri, 21 Feb 2020 11:44:18 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 21 Feb 2020 11:44:32 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 21 Feb 2020 11:44:32 -0800
Received: from [10.2.166.200] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 21 Feb
 2020 19:44:32 +0000
Subject: Re: [PATCH v7 11/24] mm: Move end_index check out of readahead loop
To:     Matthew Wilcox <willy@infradead.org>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linux-btrfs@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, <linux-ext4@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <cluster-devel@redhat.com>, <ocfs2-devel@oss.oracle.com>,
        <linux-xfs@vger.kernel.org>
References: <20200219210103.32400-1-willy@infradead.org>
 <20200219210103.32400-12-willy@infradead.org>
 <e6ef2075-b849-299e-0f11-c6ee82b0a3c7@nvidia.com>
 <20200221153537.GE24185@bombadil.infradead.org>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <1fd052ce-cd5e-60ce-e494-cbf6427d3ed3@nvidia.com>
Date:   Fri, 21 Feb 2020 11:41:28 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200221153537.GE24185@bombadil.infradead.org>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1582314258; bh=pQKOwwEmNmp5lZ+eX1Ols5QNnW+OORTLQJDMCsPxtEc=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=lYdo4NH8M7SXphPat6doJg0oOA1V6kLXukQ7JIEh5FVkfFb0/CxKOhHQdMiRNYy87
         Q6EhPR2Fph1xqpiZaGm+fIV8Ra4pJE8E5H2Ofj6LlTy0+Qb+/+y64EhZcbjIYXrOqI
         IXR7s2kX4Yi3hnWXNuj2sU2+Joh83jXJxvw8pHXSeKQS/7ccswnLmpLkros2lxWTg/
         2U8B/Ar6NYNMOQFqfCj3j5XpjUwSHVdi0BMHCh2YVMnazsUm42RddLEt+ZRAKHCaXa
         IlYO+1WyQ2QxlFvwnZy2R5xtgMwusy7sT9ZlwHQi2bqndUATGT9KLiH14aMZETjP0i
         ow4Jt857PEIiA==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/21/20 7:35 AM, Matthew Wilcox wrote:
> On Thu, Feb 20, 2020 at 07:50:39PM -0800, John Hubbard wrote:
>> This tiny patch made me pause, because I wasn't sure at first of the exact
>> intent of the lines above. Once I worked it out, it seemed like it might
>> be helpful (or overkill??) to add a few hints for the reader, especially since
>> there are no hints in the function's (minimal) documentation header. What
>> do you think of this?
>>
>> 	/*
>> 	 * If we can't read *any* pages without going past the inodes's isize
>> 	 * limit, give up entirely:
>> 	 */
>> 	if (index > end_index)
>> 		return;
>>
>> 	/* Cap nr_to_read, in order to avoid overflowing the ULONG type: */
>> 	if (index + nr_to_read < index)
>> 		nr_to_read = ULONG_MAX - index + 1;
>>
>> 	/* Cap nr_to_read, to avoid reading past the inode's isize limit: */
>> 	if (index + nr_to_read >= end_index)
>> 		nr_to_read = end_index - index + 1;
> 
> A little verbose for my taste ... How about this?


Mine too, actually. :)  I think your version below looks good.


thanks,
-- 
John Hubbard
NVIDIA

> 
>          end_index = (isize - 1) >> PAGE_SHIFT;
>          if (index > end_index)
>                  return;
>          /* Avoid wrapping to the beginning of the file */
>          if (index + nr_to_read < index)
>                  nr_to_read = ULONG_MAX - index + 1;
>          /* Don't read past the page containing the last byte of the file */
>          if (index + nr_to_read >= end_index)
>                  nr_to_read = end_index - index + 1;
> 

