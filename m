Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 490B214D1A5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2020 21:02:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727540AbgA2UBw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Jan 2020 15:01:52 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:6546 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbgA2UBv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Jan 2020 15:01:51 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e31e4980000>; Wed, 29 Jan 2020 12:01:28 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 29 Jan 2020 12:01:48 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 29 Jan 2020 12:01:48 -0800
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 29 Jan
 2020 20:01:48 +0000
Subject: Re: [PATCH 0/3] mm/gup: track FOLL_PIN pages (follow on from v12)
To:     Leon Romanovsky <leon@kernel.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Shuah Khan <shuah@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, <linux-doc@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-rdma@vger.kernel.org>, <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20200125021115.731629-1-jhubbard@nvidia.com>
 <20200125162339.GA41770@unreal> <20200129054756.GB3326@unreal>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <7a15be06-d136-ff30-da91-413f0a6c8751@nvidia.com>
Date:   Wed, 29 Jan 2020 12:01:47 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200129054756.GB3326@unreal>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1580328088; bh=gkreWAfR1M+wLvQaa+HnNfcLQr5xiP6TxB2x+oFum4o=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=ippYGBsVdG9T4zX85tpivCTQKJit87UpTnxeUNDUsBjvxw+Z3Hx3W6lQzgZet3Xp9
         EM1+O2NRB9ZxGvEoO7itzfQUnAPIo9aOKxD07WpYwKDIDyQFZRHLADxdSfn8rG8ycN
         +Pn30KypxWRy19foPRQ6Nre4HHcjLtg2k0xYwI+EjXfIpKml7mA+1nZAh+gNpCFMBT
         dANWHhA7drtMu5P6H3QMnuWie3RZRYFb0Q2TyXxMG4P0rvlRtL6NtJqHHl/Qilz3vz
         UEznaHLnmYby2Lot0SMwG0KjACmYTn5Gba5q2JV1w5SpQGyqrL+ozBxsJfiDoI5Nyp
         0jjKX0dYdcq3A==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/28/20 9:47 PM, Leon Romanovsky wrote:
> On Sat, Jan 25, 2020 at 06:23:39PM +0200, Leon Romanovsky wrote:
>> On Fri, Jan 24, 2020 at 06:11:12PM -0800, John Hubbard wrote:
>>> Leon Romanovsky:
>>>
>>> If you get a chance, I'd love to have this short series (or even just
>>> the first patch; the others are just selftests) run through your test
>>> suite that was previously choking on my earlier v11 patchset. The huge
>>> page pincount limitations are removed, so I'm expecting a perfect test
>>> run this time!
>>>
>>
>> I added those patches to our regression and I will post the in the
>> couple of days.
> 
> Hi John,
> 
> The patches survived our RDMA verification night runs.
> 

Great! Thanks very much for running those. That's a pretty solid 
confirmation that the earlier patch *did* allow a huge page refcount
overflow, and that this approach avoids it. 

thanks,
-- 
John Hubbard
NVIDIA
