Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58B3815609B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2020 22:14:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbgBGVOl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Feb 2020 16:14:41 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:19037 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727031AbgBGVOl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Feb 2020 16:14:41 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e3dd3030000>; Fri, 07 Feb 2020 13:13:39 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 07 Feb 2020 13:14:39 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 07 Feb 2020 13:14:39 -0800
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 7 Feb
 2020 21:14:38 +0000
Subject: Re: [PATCH v5 01/12] mm: dump_page(): better diagnostics for compound
 pages
From:   John Hubbard <jhubbard@nvidia.com>
To:     Matthew Wilcox <willy@infradead.org>
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
        LKML <linux-kernel@vger.kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
References: <20200207033735.308000-1-jhubbard@nvidia.com>
 <20200207033735.308000-2-jhubbard@nvidia.com>
 <20200207172746.GE8731@bombadil.infradead.org>
 <3477bf65-64dc-7854-6720-589f7fcdac07@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <56cd46b1-1b11-4353-9434-78d512d50449@nvidia.com>
Date:   Fri, 7 Feb 2020 13:14:38 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <3477bf65-64dc-7854-6720-589f7fcdac07@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1581110019; bh=E3GmveWPSSbsdDLhLFqFk5JXHlvotQhFoJQGu+g7DmY=;
        h=X-PGP-Universal:Subject:From:To:CC:References:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=ZdmfPjVo/C2NEbdRItfd1rOG/JxoMZQRbFATOkrxsZjcd0aS/alUZJAljkLhNvdru
         /JzZ7ih7vA8q+m8B/Rq2+lKKgv69kEtG5mRk1KE8e4W9Nv6kW2yY+9/+8ZhawMV2j8
         i4/zU41iysChmRnG+ON8gqJp39Hud4XlSGZ5HaEOsrXhHq2kPMbmrvG/O8dcEyzVsS
         T8WZoU21GJUVt+7UlEy1J/qvvv/hxPng7TNdJCsSgClrNOGQoZolNRAi67a3dq2Rvk
         GoQINEZD+wlx0wjwR0NHK+rPBHZkD5Z7hhBXa+fRAqx+Ut61TWREleaxBKzCZ57mqO
         Tff1t1Tt3tR2Q==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/7/20 1:05 PM, John Hubbard wrote:
...

> Seeing as how I want to further enhance dump_page() slightly for this series (to 
> include the 3rd struct page's hpage_pincount), would you care to send this as a 
> formal patch that I could insert into this series, to replace patch 5?
> 

ahem, make that "to replace patch 1", please. Too many 5's in the subject lines for 
me, I guess. :)

thanks,
-- 
John Hubbard
NVIDIA
