Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD3C153C33
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2020 00:59:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727570AbgBEX6z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Feb 2020 18:58:55 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:1731 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727170AbgBEX6z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Feb 2020 18:58:55 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e3b56af0001>; Wed, 05 Feb 2020 15:58:39 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 05 Feb 2020 15:58:54 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 05 Feb 2020 15:58:54 -0800
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 5 Feb
 2020 23:58:53 +0000
Subject: Re: [PATCH v4 10/12] mm/gup: /proc/vmstat: pin_user_pages (FOLL_PIN)
 reporting
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
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        <linux-doc@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>
References: <20200204234117.2974687-1-jhubbard@nvidia.com>
 <20200204234117.2974687-11-jhubbard@nvidia.com>
 <20200205114325.4e2f5aghsusihpap@box>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <2b0656a2-3402-f376-7440-481124485bde@nvidia.com>
Date:   Wed, 5 Feb 2020 15:58:53 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200205114325.4e2f5aghsusihpap@box>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1580947120; bh=eQdMCwCy4bdZgoj0Xg2Rpo0F1Zl0hA5DYDsmhvn66Ys=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=q8siZ3RTxc5+A5vd839fLbpWstbJCB342l+V3JAD86hC7sc5zMybGJEIdeHlaUU3t
         nt8p/HHnGlgEewmi2wqwV82PDvMFaUnROFOaGq9E5VdAJm/UCuV7cJ32B4j83bSfCa
         b0qRd+rlKh8rW1cH1wfGJX7k6E4MlDKxO8ghq9VhtIHXcXE1P9K0Vfp6hfaL7BB/yk
         c+zr+tqiK/XwRrfuETL1mOclWclbyz8VtlwdPzJDt5tePy+r7ECX6WrKoKFwCgffdn
         tGYMGpuSkou9GRX9fLICp7SCBSrnz4AfS/bFdxbr8zqNaT7QLqEXY/KpjurVchpJA1
         7sHUH/d9y79qw==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/5/20 3:43 AM, Kirill A. Shutemov wrote:
> On Tue, Feb 04, 2020 at 03:41:15PM -0800, John Hubbard wrote:
>> Now that pages are "DMA-pinned" via pin_user_page*(), and unpinned via
>> unpin_user_pages*(), we need some visibility into whether all of this is
>> working correctly.
>>
>> Add two new fields to /proc/vmstat:
>>
>>     nr_foll_pin_acquired
>>     nr_foll_pin_released
>>
>> These are documented in Documentation/core-api/pin_user_pages.rst.
>> They represent the number of pages (since boot time) that have been
>> pinned ("nr_foll_pin_acquired") and unpinned ("nr_foll_pin_released"),
>> via pin_user_pages*() and unpin_user_pages*().
>>
>> In the absence of long-running DMA or RDMA operations that hold pages
>> pinned, the above two fields will normally be equal to each other.
>>
>> Also: update Documentation/core-api/pin_user_pages.rst, to remove an
>> earlier (now confirmed untrue) claim about a performance problem with
>> /proc/vmstat.
>>
>> Also: updated Documentation/core-api/pin_user_pages.rst to rename the
>> new /proc/vmstat entries, to the names listed here.
>>
>> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> 
> Please, clarify semantics for huge page. An user may want to know if we
> count huge page as one pin-acquired or by number of pages.


OK, I've added this for the next version:


diff --git a/Documentation/core-api/pin_user_pages.rst b/Documentation/core-api/pin_user_pages.rst
index 5776ad1ed5e4..2e939ff10b86 100644
--- a/Documentation/core-api/pin_user_pages.rst
+++ b/Documentation/core-api/pin_user_pages.rst
@@ -211,6 +211,33 @@ since the system was booted, via two new /proc/vmstat entries: ::
     /proc/vmstat/nr_foll_pin_acquired
     /proc/vmstat/nr_foll_pin_released
 
+Under normal conditions, these two values will be equal unless there are any
+long-term [R]DMA pins in place, or during pin/unpin transitions.
+
+* nr_foll_pin_acquired: This is the number of logical pins that have been
+  acquired since the system was powered on. For huge pages, the head page is
+  pinned once for each page (head page and each tail page) within the huge page.
+  This follows the same sort of behavior that get_user_pages() uses for huge
+  pages: the head page is refcounted once for each tail or head page in the huge
+  page, when get_user_pages() is applied to a huge page.
+
+* nr_foll_pin_released: The number of logical pins that have been released since
+  the system was powered on. Note that pages are released (unpinned) on a
+  PAGE_SIZE granularity, even if the original pin was applied to a huge page.
+  Becaused of the pin count behavior described above in "nr_foll_pin_acquired",
+  the accounting balances out, so that after doing this::
+
+    pin_user_pages(huge_page);
+    for (each page in huge_page)
+        unpin_user_page(page);
+
+...the following is expected::
+
+    nr_foll_pin_released == nr_foll_pin_acquired
+
+(...unless it was already out of balance due to a long-term RDMA pin being in
+place.)
+
 Other diagnostics
 =================
 


thanks,
-- 
John Hubbard
NVIDIA

> 
> Otherwise looks good (given Jan concern is addressed).
> 
