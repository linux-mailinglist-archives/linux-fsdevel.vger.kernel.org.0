Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE4E44819F1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Dec 2021 07:33:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236483AbhL3GdB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Dec 2021 01:33:01 -0500
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:47827 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236346AbhL3Gc7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Dec 2021 01:32:59 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R801e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0V0JrawZ_1640845976;
Received: from 30.21.164.60(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0V0JrawZ_1640845976)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 30 Dec 2021 14:32:57 +0800
Message-ID: <1aaf9c11-0d8e-b92d-5c92-46e50a6e8d4e@linux.alibaba.com>
Date:   Thu, 30 Dec 2021 14:33:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: mmotm 2021-12-29-20-07 uploaded (mm/damon)
To:     Randy Dunlap <rdunlap@infradead.org>, akpm@linux-foundation.org,
        broonie@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au,
        SeongJae Park <sj@kernel.org>
References: <20211230040740.SbquJAFf5%akpm@linux-foundation.org>
 <a57f9bc4-2c1b-f819-17a6-2e1d2f9dd173@infradead.org>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <a57f9bc4-2c1b-f819-17a6-2e1d2f9dd173@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On 12/30/2021 2:27 PM, Randy Dunlap wrote:
> Hi--
> 
> On 12/29/21 20:07, akpm@linux-foundation.org wrote:
>> The mm-of-the-moment snapshot 2021-12-29-20-07 has been uploaded to
>>
>>     https://www.ozlabs.org/~akpm/mmotm/
>>
>> mmotm-readme.txt says
>>
>> README for mm-of-the-moment:
>>
>> https://www.ozlabs.org/~akpm/mmotm/
>>
>> This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
>> more than once a week.
>>
>> You will need quilt to apply these patches to the latest Linus release (5.x
>> or 5.x-rcY).  The series file is in broken-out.tar.gz and is duplicated in
>> https://ozlabs.org/~akpm/mmotm/series
>>
>> The file broken-out.tar.gz contains two datestamp files: .DATE and
>> .DATE-yyyy-mm-dd-hh-mm-ss.  Both contain the string yyyy-mm-dd-hh-mm-ss,
>> followed by the base kernel version against which this patch series is to
>> be applied.
> 
> 
> On i386:
> 
> ../mm/damon/vaddr.c: In function ‘damon_hugetlb_mkold’:
> ../mm/damon/vaddr.c:402:17: warning: unused variable ‘h’ [-Wunused-variable]
>    struct hstate *h = hstate_vma(vma);

Ah, thanks for report, I think below changes can fix the warning. And 
I'll send a new version to address this warning.

diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index bcdc602..25bff8a 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -397,7 +397,6 @@ static void damon_hugetlb_mkold(pte_t *pte, struct 
mm_struct *mm,
                                 struct vm_area_struct *vma, unsigned 
long addr)
  {
         bool referenced = false;
-       struct hstate *h = hstate_vma(vma);
         pte_t entry = huge_ptep_get(pte);
         struct page *page = pte_page(entry);

@@ -414,7 +413,7 @@ static void damon_hugetlb_mkold(pte_t *pte, struct 
mm_struct *mm,
         }

  #ifdef CONFIG_MMU_NOTIFIER
-       if (mmu_notifier_clear_young(mm, addr, addr + huge_page_size(h)))
+       if (mmu_notifier_clear_young(mm, addr, addr + 
huge_page_size(hstate_vma(vma))))
                 referenced = true;
  #endif /* CONFIG_MMU_NOTIFIER */
