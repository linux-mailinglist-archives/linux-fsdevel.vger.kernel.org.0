Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D757114A9B9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jan 2020 19:18:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727228AbgA0SSi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jan 2020 13:18:38 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:7100 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbgA0SSh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jan 2020 13:18:37 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e2f296e0000>; Mon, 27 Jan 2020 10:18:22 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 27 Jan 2020 10:18:36 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 27 Jan 2020 10:18:36 -0800
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 27 Jan
 2020 18:18:36 +0000
Subject: Re: [PATCH 1/3] mm/gup: track FOLL_PIN pages
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Shuah Khan <shuah@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, <linux-doc@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-rdma@vger.kernel.org>, <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
References: <20200125021115.731629-1-jhubbard@nvidia.com>
 <20200125021115.731629-2-jhubbard@nvidia.com>
 <20200127130020.4p56lh32twui5563@box>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <c6fc7d3a-48a8-c8a7-fe39-be7a45cb292a@nvidia.com>
Date:   Mon, 27 Jan 2020 10:18:36 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200127130020.4p56lh32twui5563@box>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1580149102; bh=5eonkyJqWEmrIE7dpZRdx62cpfiZscrBXWaEjD3sZTo=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=I6wIgOsgRDFtKKhI3bODVhfF0GXc0gG+t2XGSjEBKhDoxolKPIdDGcknU1jZRIC3k
         KvhPzWceTRxxrWNYszZc+EPPwsRs1zg8q8ZFlvCvbIp1c+O8bHsWpZkIsV8EU1CCuX
         TN5gCJhMB5hI9/v+NZFHARPLXgWvJtFzXygKSYSohS1t7NkV6ahnMsrf7Xg2EhY+z+
         uGUJb4u88rwZBbQvrl7MZqB3H5N+0p/gKWusE27Mh66vlVnC76v8RuJLpRIVDpClfQ
         /5yjt3tpAI2KxmS2i+D5kFN3F+rzxXd3/AI8EJmgh12Wm/Zw9EpWZXhpZHOAAJMujo
         UmCiF1/qGbnoA==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/27/20 5:00 AM, Kirill A. Shutemov wrote:
> On Fri, Jan 24, 2020 at 06:11:13PM -0800, John Hubbard wrote:
>>  12 files changed, 577 insertions(+), 171 deletions(-)
> 
> Can we get it split? There's too much going on to give meaningful review.
> 

Sure, I'll split it up, it has gotten quite large for one patch.

thanks,
-- 
John Hubbard
NVIDIA
