Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06F66163582
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2020 22:52:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbgBRVwu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Feb 2020 16:52:50 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:1176 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbgBRVwu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Feb 2020 16:52:50 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e4c5ca30001>; Tue, 18 Feb 2020 13:52:35 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 18 Feb 2020 13:52:49 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 18 Feb 2020 13:52:49 -0800
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 18 Feb
 2020 21:52:48 +0000
Subject: Re: [PATCH v6 01/19] mm: Return void from various readahead functions
To:     Matthew Wilcox <willy@infradead.org>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linux-btrfs@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, <linux-ext4@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <cluster-devel@redhat.com>, <ocfs2-devel@oss.oracle.com>,
        <linux-xfs@vger.kernel.org>
References: <20200217184613.19668-1-willy@infradead.org>
 <20200217184613.19668-2-willy@infradead.org>
 <29d2d7ca-7f2b-7eb4-78bc-f2af36c4c426@nvidia.com>
 <20200218212115.GG24185@bombadil.infradead.org>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <df31e4a4-fe1a-5826-c8e1-c66e5197e071@nvidia.com>
Date:   Tue, 18 Feb 2020 13:52:48 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200218212115.GG24185@bombadil.infradead.org>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1582062755; bh=qfpwxWjoJAxZXMl/fVWRFqa8SVkCAfNTchKU/DsPf1w=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=L8ru848XvUIfOJO/JXhX+NAXu7iIY1KJSx3RiY9Om4rla5Ao2A9lF+RAEJasJvP5L
         owCBjoiopItYsoex90j53Y8mnM3ktiY1MMNo8HH+kjWAdu7/XAWRA5giE/2/cgeZo1
         UzfV3lbbxYSMkVntSf7SjA5oxNk59bYCkEmDWiuTjVcx3LjHjGBJkIBzlgkhs4ZBhL
         oBrJEGs94r8uGApZIYHqfv60ijxl2jPOY76N6V1bK0kLceuPY9FEScpmq72aOxPBeV
         O9bOSJy3x3CRdtcl3DfnYeEMl70MqfhK4trIMvG7AasW+TbAnle4v8IFOUmWPDmYWd
         rkWaM8EskmDKw==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/18/20 1:21 PM, Matthew Wilcox wrote:
> On Tue, Feb 18, 2020 at 01:05:29PM -0800, John Hubbard wrote:
>> This is an easy review and obviously correct, so:
>>
>>     Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> 
> Thanks
> 
>> Thoughts for the future of the API:
>>
>> I will add that I could envision another patchset that went in the
>> opposite direction, and attempted to preserve the information about
>> how many pages were successfully read ahead. And that would be nice
>> to have (at least IMHO), even all the way out to the syscall level,
>> especially for the readahead syscall.
> 
> Right, and that was where I went initially.  It turns out to be a
> non-trivial aount of work to do the book-keeping to find out how many
> pages were _attempted_, and since we don't wait for the I/O to complete,
> we don't know how many _succeeded_, and we also don't know how many
> weren't attempted because they were already there, and how many weren't
> attempted because somebody else has raced with us and is going to attempt
> them themselves, and how many weren't attempted because we just ran out
> of memory, and decided to give up.
> 
> Also, we don't know how many pages were successfully read, and then the
> system decided to evict before the program found out how many were read,
> let alone before it did any action based on that.
> 


That is even worse than I initially thought. :)


> So, given all that complexity, and the fact that nobody actually does
> anything with the limited and incorrect information we tried to provide
> today, I think it's fair to say that anybody who wants to start to do
> anything with that information can delve into all the complexity around
> "what number should we return, and what does it really mean".  In the


Yes, and now that you mention it, it's really tough to pick a single number
that answers the right questions that the user space caller might have. whew.


> meantime, let's just ditch the complexity and pretense that this number
> means anything.
> 

Definitely. Thanks for the notes here.


thanks,
-- 
John Hubbard
NVIDIA
