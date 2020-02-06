Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C20BE153DED
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2020 05:40:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbgBFEkX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Feb 2020 23:40:23 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:13704 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727773AbgBFEkX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Feb 2020 23:40:23 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e3b987c0000>; Wed, 05 Feb 2020 20:39:24 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 05 Feb 2020 20:40:22 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 05 Feb 2020 20:40:22 -0800
Received: from [10.2.168.158] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 6 Feb
 2020 04:40:22 +0000
Subject: Re: [PATCH 8/8] xarray: Don't clear marks in xas_store()
To:     Matthew Wilcox <willy@infradead.org>
CC:     Jan Kara <jack@suse.cz>, <linux-fsdevel@vger.kernel.org>,
        <linux-mm@kvack.org>
References: <20200204142514.15826-1-jack@suse.cz>
 <20200204142514.15826-9-jack@suse.cz>
 <8ea2682b-7240-dca3-b123-2df7d0c994ba@nvidia.com>
 <20200206022144.GU8731@bombadil.infradead.org>
 <01e577b2-3349-15bc-32c7-b556e9f08536@nvidia.com>
 <20200206042801.GV8731@bombadil.infradead.org>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <7bf969b8-2230-8a2e-8994-226ad670bc9d@nvidia.com>
Date:   Wed, 5 Feb 2020 20:37:23 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200206042801.GV8731@bombadil.infradead.org>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1580963964; bh=gjQaiIBmF9SnsAAKQuqtdURhQ+0psLUB7KBSUQDgUrM=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=at5Qeu+2U65rL3b7NVnhUmdbCNqMJdwMtBhU1zqBORMlgPZ+mTWtPaAPRR95RGCcX
         YxSrYmQi+7aJmmEINoKhA0E2VRUTBYDjXSq+RdJn13Tb6lhQhNHK1N7HWPH5cYfriQ
         Ozwe258BV81Kftfy/BoagmQ84guZ5VuwpunD20g1jYUFIvv5eqctzd/n1DxR7AOAUP
         rk5meBrqga4ryYcqwlmUfElUWI6MuD6dbIwmJkUCReKKWHk/fa72i7UpofuptGVxYZ
         X2B2WXIbYWGqZYRFNeRpyjSrwdvFTGAuwbdzb3B/zbjRPlyRQLBr1TO9rWR5HXh+VD
         V5Am/8qnXTIvw==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/5/20 8:28 PM, Matthew Wilcox wrote:
> On Wed, Feb 05, 2020 at 07:48:57PM -0800, John Hubbard wrote:
>> You can then set entries using xa_store() and get entries
>> using xa_load().  xa_store will overwrite any entry with the
>> new entry and return the previous entry stored at that index.  You can
>> use xa_erase(), instead of calling xa_store() with a
>> ``NULL`` entry followed by xas_init_marks().  There is no difference between
>> an entry that has never been stored to and one that has been erased. Those,
>> in turn, are the same as an entry that has had ``NULL`` stored to it and
>> also had its marks erased via xas_init_marks().
> 
> There's a fundamental misunderstanding here.  If you store a NULL, the
> marks go away.  There is no such thing as a marked NULL entry.  If you
> observe such a thing, it can only exist through some kind of permitted
> RCU race, and the entry must be ignored.  If you're holding the xa_lock,
> there is no way to observe a NULL entry with a search mark set.


aha, the key point. Thanks for explaining it.

thanks,
-- 
John Hubbard
NVIDIA

> 
> What Jan is trying to do is allow code that knows what it's doing
> the ability to say "Skip clearing the marks for performance reasons.
> The marks are already clear."
> 
> I'm still mulling over the patches from Jan.  There's something I don't
> like about them, but I can't articulate it in a useful way yet.  I'm on
> board with the general principle, and obviously the xas_for_each_marked()
> bug needs to be fixed.
> 
