Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3659E231038
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jul 2020 18:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731623AbgG1Q6A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jul 2020 12:58:00 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:52006 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731531AbgG1Q57 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jul 2020 12:57:59 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R951e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07484;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0U457UhO_1595955471;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0U457UhO_1595955471)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 29 Jul 2020 00:57:54 +0800
Subject: Re: [PATCH] /proc/PID/smaps: Consistent whitespace output format
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20200728083207.17531-1-mkoutny@suse.com>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <03206c8c-0350-3b91-fb2d-2f25a6ff4f55@linux.alibaba.com>
Date:   Tue, 28 Jul 2020 09:57:50 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20200728083207.17531-1-mkoutny@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 7/28/20 1:32 AM, Michal Koutný wrote:
> The keys in smaps output are padded to fixed width with spaces.
> All except for THPeligible that uses tabs (only since
> commit c06306696f83 ("mm: thp: fix false negative of shmem vma's THP
> eligibility")).
> Unify the output formatting to save time debugging some naïve parsers.
> (Part of the unification is also aligning FilePmdMapped with others.)

I recalled someone else submitted similar patch before. But my memory is 
vague. Anyway it looks fine to me to make the parsers happy. Acked-by: 
Yang Shi <yang.shi@linux.alibaba.com>

>
> Signed-off-by: Michal Koutný <mkoutny@suse.com>
> ---
>   fs/proc/task_mmu.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index dbda4499a859..5066b0251ed8 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -786,7 +786,7 @@ static void __show_smap(struct seq_file *m, const struct mem_size_stats *mss,
>   	SEQ_PUT_DEC(" kB\nLazyFree:       ", mss->lazyfree);
>   	SEQ_PUT_DEC(" kB\nAnonHugePages:  ", mss->anonymous_thp);
>   	SEQ_PUT_DEC(" kB\nShmemPmdMapped: ", mss->shmem_thp);
> -	SEQ_PUT_DEC(" kB\nFilePmdMapped: ", mss->file_thp);
> +	SEQ_PUT_DEC(" kB\nFilePmdMapped:  ", mss->file_thp);
>   	SEQ_PUT_DEC(" kB\nShared_Hugetlb: ", mss->shared_hugetlb);
>   	seq_put_decimal_ull_width(m, " kB\nPrivate_Hugetlb: ",
>   				  mss->private_hugetlb >> 10, 7);
> @@ -816,7 +816,7 @@ static int show_smap(struct seq_file *m, void *v)
>   
>   	__show_smap(m, &mss, false);
>   
> -	seq_printf(m, "THPeligible:		%d\n",
> +	seq_printf(m, "THPeligible:    %d\n",
>   		   transparent_hugepage_enabled(vma));
>   
>   	if (arch_pkeys_enabled())

