Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87620164FC8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2020 21:24:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgBSUY2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Feb 2020 15:24:28 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:3914 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbgBSUY2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Feb 2020 15:24:28 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e4d99340000>; Wed, 19 Feb 2020 12:23:16 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 19 Feb 2020 12:24:27 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 19 Feb 2020 12:24:27 -0800
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 19 Feb
 2020 20:24:27 +0000
Subject: Re: [PATCH v6 07/19] mm: Put readahead pages in cache earlier
To:     Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linux-btrfs@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, <linux-ext4@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <cluster-devel@redhat.com>, <ocfs2-devel@oss.oracle.com>,
        <linux-xfs@vger.kernel.org>
References: <20200217184613.19668-1-willy@infradead.org>
 <20200217184613.19668-12-willy@infradead.org>
 <e3671faa-dfb3-ceba-3120-a445b2982a95@nvidia.com>
 <20200219144117.GP24185@bombadil.infradead.org>
 <20200219145246.GA29869@infradead.org>
 <20200219150103.GQ24185@bombadil.infradead.org>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <a5f8ba4c-8413-2633-9523-5b5941c0762b@nvidia.com>
Date:   Wed, 19 Feb 2020 12:24:26 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200219150103.GQ24185@bombadil.infradead.org>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1582143796; bh=Stnn+zSSGNCFbZ988J4GuiCkm17Qbq44jVcYhuJTWJc=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=PoUTRdSyZJ3hX2dxzQISosJ/wVYoveMKl+7atg1sDrOWdAAaYMtdVxq7QyYHhh7xe
         EvTmBI7/rq4HLGscXS8LPXNBnQ1Jix4flhNHGsxk201kSI8sMpgUmQGRpk7I9BpUhS
         +KjQiwXIyu9koQoSyGAly8ElawI2qpwAoJWQDFM4pVRo/Z9yKmG/dGB+jg0mlia4Y2
         aAY4dZzfwP+DRcHOuBWJl3IdIgHWxdpwgzTmZEfGVW+WOZbqKq5bU129bePvvI5bU1
         dYKswZNLebiNLPAg01grHG4u36LomMBF2QsjP/hPLPNASaXyUhQMXbUJhq2V3Ktwp6
         cwNUY5UNidflg==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/19/20 7:01 AM, Matthew Wilcox wrote:
> On Wed, Feb 19, 2020 at 06:52:46AM -0800, Christoph Hellwig wrote:
>> On Wed, Feb 19, 2020 at 06:41:17AM -0800, Matthew Wilcox wrote:
>>> #define readahead_for_each(rac, page)                                   \
>>>         while ((page = readahead_page(rac)))
>>>
>>> No more readahead_next() to forget to add to filesystems which don't use
>>> the readahead_for_each() iterator.  Ahem.


Yes, this looks very clean. And less error-prone, which I definitely
appreciate too. :)


>>
>> And then kill readahead_for_each and open code the above to make it
>> even more obvious?
> 
> Makes sense.
> 

Great!


thanks,
-- 
John Hubbard
NVIDIA
