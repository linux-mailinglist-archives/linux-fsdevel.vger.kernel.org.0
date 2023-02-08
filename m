Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCCB268FA37
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Feb 2023 23:22:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232420AbjBHWW6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Feb 2023 17:22:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231906AbjBHWW5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Feb 2023 17:22:57 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F760252BD;
        Wed,  8 Feb 2023 14:22:55 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id v13so419399eda.11;
        Wed, 08 Feb 2023 14:22:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fZrGQmCx7M8I538/uxkEeAKM0AP+vFbaSYYa4WZn5LM=;
        b=jwcQd+Vd/ZFK6qS29TU7c4K8ejZri73UlkOSeuG6KyaG3cdzdEPLRd5imadkMptaSL
         rA9J36JisG+j6S+lEgm+E73JrjikgizJ45abOgdNHePGCGIO+OnRn4ttUDHjHG7SrA9W
         BMx1ov5OnhkWaTlZBcbkCWICOj5KjSlaJethEd5nsR4huThx8+lzltQC+isnCKsdZtkc
         Sv2UOXCuKaRrqGCHuEnfGFKckVxu8lz8VqjPzLnzGEdWVzNQBWK2QlzEgIZYN0yEpjKJ
         T/HsCi9BF8Zft1NjnGmRW0DltXi+iZTEUrqciIT/IlaYozivvetbuZLJbzc2NooMKXAT
         hNKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fZrGQmCx7M8I538/uxkEeAKM0AP+vFbaSYYa4WZn5LM=;
        b=o8FaXZQ8E0A8yHxmGQEieE3VTdyMHjEhRm/NtFYS0bxkKCOtltAQa8kwD9Mu3mWiae
         uuLNvGu2pqIrnCs1h4NMZt2POl1GJH+412AL8BMEgx7VH0ZjUzm7DOCLpNfddvt0Ts2+
         RK+rE0ZybIMkE+b+a2wtzA+6F461Ye7zyAo2YdbFL36WCsUAPVt5c9nHk9aY4+KJCsil
         uRVO5psgjbq2c53s5kFpow6C4zjY5UoBzrdRMHDk6fAIV2KA9WLOdGYeLHxU3VGqSJyf
         FNYnJGcXWi22AOxaKcxA4wkmmir9ILqdR8kq1sRRhF1XV5gzPKij6x9Hw3+4/0yWjK3C
         /Dug==
X-Gm-Message-State: AO0yUKWLGueUv4L1LnQXWVgJcy04eMJUi1A+dWnMqwuqNljEmly2X12v
        5taVPQuSKN//C/2smAkC5mc=
X-Google-Smtp-Source: AK7set9vfHaHysr9sj0VdzcRm6rskIqHOWhgkmctn4yaV1/jw9WLwRZnOAhGCD+UsYzR3gbXLFuLJA==
X-Received: by 2002:a50:8a95:0:b0:4ab:1031:b60a with SMTP id j21-20020a508a95000000b004ab1031b60amr3492611edj.24.1675894973662;
        Wed, 08 Feb 2023 14:22:53 -0800 (PST)
Received: from grain.localdomain ([5.18.251.97])
        by smtp.gmail.com with ESMTPSA id y12-20020a056402270c00b0049668426aa6sm8426236edd.24.2023.02.08.14.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 14:22:46 -0800 (PST)
Received: by grain.localdomain (Postfix, from userid 1000)
        id 551D35A0020; Thu,  9 Feb 2023 01:22:45 +0300 (MSK)
Date:   Thu, 9 Feb 2023 01:22:45 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>,
        Andrei Vagin <avagin@gmail.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Yun Zhou <yun.zhou@windriver.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Alex Sierra <alex.sierra@amd.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>, kernel@collabora.com
Subject: Re: [PATCH v10 3/6] fs/proc/task_mmu: Implement IOCTL to get and/or
 the clear info about PTEs
Message-ID: <Y+QgtVSEl4w2NgtJ@grain>
References: <20230202112915.867409-1-usama.anjum@collabora.com>
 <20230202112915.867409-4-usama.anjum@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230202112915.867409-4-usama.anjum@collabora.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 02, 2023 at 04:29:12PM +0500, Muhammad Usama Anjum wrote:
...
Hi Muhammad! I'm really sorry for not commenting this code, just out of time and i
fear cant look with precise care at least for some time, hopefully other CRIU guys
pick it up. Anyway, here a few comment from a glance.

> +
> +static inline int pagemap_scan_output(bool wt, bool file, bool pres, bool swap,
> +				      struct pagemap_scan_private *p, unsigned long addr,
> +				      unsigned int len)
> +{

This is a big function and usually it's a flag to not declare it as "inline" until
there very serious reson to.

> +	unsigned long bitmap, cur = PAGEMAP_SCAN_BITMAP(wt, file, pres, swap);
> +	bool cpy = true;
> +	struct page_region *prev = &p->prev;
> +
> +	if (HAS_NO_SPACE(p))
> +		return -ENOSPC;
> +
> +	if (p->max_pages && p->found_pages + len >= p->max_pages)
> +		len = p->max_pages - p->found_pages;
> +	if (!len)
> +		return -EINVAL;
> +
> +	if (p->required_mask)
> +		cpy = ((p->required_mask & cur) == p->required_mask);
> +	if (cpy && p->anyof_mask)
> +		cpy = (p->anyof_mask & cur);
> +	if (cpy && p->excluded_mask)
> +		cpy = !(p->excluded_mask & cur);
> +	bitmap = cur & p->return_mask;
> +	if (cpy && bitmap) {

You can exit early here simply

	if (!cpy || !bitmap)
		return 0;

saving one tab for the code below.

> +		if ((prev->len) && (prev->bitmap == bitmap) &&
> +		    (prev->start + prev->len * PAGE_SIZE == addr)) {
> +			prev->len += len;
> +			p->found_pages += len;
> +		} else if (p->vec_index < p->vec_len) {
> +			if (prev->len) {
> +				memcpy(&p->vec[p->vec_index], prev, sizeof(struct page_region));
> +				p->vec_index++;
> +			}
> +			prev->start = addr;
> +			prev->len = len;
> +			prev->bitmap = bitmap;
> +			p->found_pages += len;
> +		} else {
> +			return -ENOSPC;
> +		}
> +	}
> +	return 0;
> +}
> +
> +static inline int export_prev_to_out(struct pagemap_scan_private *p, struct page_region __user *vec,
> +				     unsigned long *vec_index)
> +{

No need for inline either.

> +	struct page_region *prev = &p->prev;
> +
> +	if (prev->len) {
> +		if (copy_to_user(&vec[*vec_index], prev, sizeof(struct page_region)))
> +			return -EFAULT;
> +		p->vec_index++;
> +		(*vec_index)++;
> +		prev->len = 0;
> +	}
> +	return 0;
> +}
> +
> +static inline int pagemap_scan_pmd_entry(pmd_t *pmd, unsigned long start,
> +					 unsigned long end, struct mm_walk *walk)
> +{

Same, no need for inline. I've a few comments more in my mind will try to
collect them tomorrow.
