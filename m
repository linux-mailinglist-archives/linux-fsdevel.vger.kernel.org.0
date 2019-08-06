Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C93ED82DF8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2019 10:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbfHFIoG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Aug 2019 04:44:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:60346 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726713AbfHFIoG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Aug 2019 04:44:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C4ACEAC97;
        Tue,  6 Aug 2019 08:44:04 +0000 (UTC)
Date:   Tue, 6 Aug 2019 10:43:57 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Brendan Gregg <bgregg@netflix.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Hansen <chansen3@cisco.com>, dancol@google.com,
        fmayer@google.com, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>, joelaf@google.com,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>, kernel-team@android.com,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Mike Rapoport <rppt@linux.ibm.com>, minchan@kernel.org,
        namhyung@google.com, paulmck@linux.ibm.com,
        Robin Murphy <robin.murphy@arm.com>,
        Roman Gushchin <guro@fb.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>, surenb@google.com,
        Thomas Gleixner <tglx@linutronix.de>, tkjos@google.com,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v4 4/5] page_idle: Drain all LRU pagevec before idle
 tracking
Message-ID: <20190806084357.GK11812@dhcp22.suse.cz>
References: <20190805170451.26009-1-joel@joelfernandes.org>
 <20190805170451.26009-4-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190805170451.26009-4-joel@joelfernandes.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 05-08-19 13:04:50, Joel Fernandes (Google) wrote:
> During idle tracking, we see that sometimes faulted anon pages are in
> pagevec but are not drained to LRU. Idle tracking considers pages only
> on LRU. Drain all CPU's LRU before starting idle tracking.

Please expand on why does this matter enough to introduce a potentially
expensinve draining which has to schedule a work on each CPU and wait
for them to finish.

> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  mm/page_idle.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/mm/page_idle.c b/mm/page_idle.c
> index a5b00d63216c..2972367a599f 100644
> --- a/mm/page_idle.c
> +++ b/mm/page_idle.c
> @@ -180,6 +180,8 @@ static ssize_t page_idle_bitmap_read(struct file *file, struct kobject *kobj,
>  	unsigned long pfn, end_pfn;
>  	int bit, ret;
>  
> +	lru_add_drain_all();
> +
>  	ret = page_idle_get_frames(pos, count, NULL, &pfn, &end_pfn);
>  	if (ret == -ENXIO)
>  		return 0;  /* Reads beyond max_pfn do nothing */
> @@ -211,6 +213,8 @@ static ssize_t page_idle_bitmap_write(struct file *file, struct kobject *kobj,
>  	unsigned long pfn, end_pfn;
>  	int bit, ret;
>  
> +	lru_add_drain_all();
> +
>  	ret = page_idle_get_frames(pos, count, NULL, &pfn, &end_pfn);
>  	if (ret)
>  		return ret;
> @@ -428,6 +432,8 @@ ssize_t page_idle_proc_generic(struct file *file, char __user *ubuff,
>  	walk.private = &priv;
>  	walk.mm = mm;
>  
> +	lru_add_drain_all();
> +
>  	down_read(&mm->mmap_sem);
>  
>  	/*
> -- 
> 2.22.0.770.g0f2c4a37fd-goog

-- 
Michal Hocko
SUSE Labs
