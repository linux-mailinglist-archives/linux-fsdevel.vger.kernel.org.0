Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1CF56C0A6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Jul 2022 20:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238730AbiGHRb5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Jul 2022 13:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238646AbiGHRb4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Jul 2022 13:31:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E3613D1F;
        Fri,  8 Jul 2022 10:31:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D260062418;
        Fri,  8 Jul 2022 17:31:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20241C341C0;
        Fri,  8 Jul 2022 17:31:49 +0000 (UTC)
Date:   Fri, 8 Jul 2022 13:31:47 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Gang Li <ligang.bdlg@bytedance.com>
Cc:     mhocko@suse.com, akpm@linux-foundation.org, surenb@google.com,
        Ingo Molnar <mingo@redhat.com>, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        viro@zeniv.linux.org.uk, ebiederm@xmission.com,
        keescook@chromium.org, peterz@infradead.org, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, david@redhat.com,
        imbrenda@linux.ibm.com, adobriyan@gmail.com,
        yang.yang29@zte.com.cn, brauner@kernel.org,
        stephen.s.brennan@oracle.com, zhengqi.arch@bytedance.com,
        haolee.swjtu@gmail.com, xu.xin16@zte.com.cn,
        Liam.Howlett@Oracle.com, ohoono.kwon@samsung.com,
        peterx@redhat.com, arnd@arndb.de, shy828301@gmail.com,
        alex.sierra@amd.com, xianting.tian@linux.alibaba.com,
        willy@infradead.org, ccross@google.com, vbabka@suse.cz,
        sujiaxun@uniontech.com, sfr@canb.auug.org.au,
        vasily.averin@linux.dev, mgorman@suse.de, vvghjk1234@gmail.com,
        tglx@linutronix.de, luto@kernel.org, bigeasy@linutronix.de,
        fenghua.yu@intel.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 3/5] mm: add numa fields for tracepoint rss_stat
Message-ID: <20220708133147.20f3d887@gandalf.local.home>
In-Reply-To: <20220708082129.80115-4-ligang.bdlg@bytedance.com>
References: <20220708082129.80115-1-ligang.bdlg@bytedance.com>
        <20220708082129.80115-4-ligang.bdlg@bytedance.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri,  8 Jul 2022 16:21:27 +0800
Gang Li <ligang.bdlg@bytedance.com> wrote:

> --- a/include/trace/events/kmem.h
> +++ b/include/trace/events/kmem.h
> @@ -363,7 +363,8 @@ static unsigned int __maybe_unused mm_ptr_to_hash(const void *ptr)
>  	EM(MM_FILEPAGES)	\
>  	EM(MM_ANONPAGES)	\
>  	EM(MM_SWAPENTS)		\
> -	EMe(MM_SHMEMPAGES)
> +	EM(MM_SHMEMPAGES)	\
> +	EMe(MM_NO_TYPE)
>  
>  #undef EM
>  #undef EMe
> @@ -383,29 +384,41 @@ TRACE_EVENT(rss_stat,
>  
>  	TP_PROTO(struct mm_struct *mm,
>  		int member,
> -		long count),
> +		long member_count,
> +		int node,
> +		long node_count,
> +		long diff_count),
>  
> -	TP_ARGS(mm, member, count),
> +	TP_ARGS(mm, member, member_count, node, node_count, diff_count),
>  
>  	TP_STRUCT__entry(
>  		__field(unsigned int, mm_id)
>  		__field(unsigned int, curr)
>  		__field(int, member)
> -		__field(long, size)
> +		__field(long, member_size)
> +		__field(int, node)

Please swap the node and member_size fields. I just noticed that size
should have been before member in the original as well. Because it will
leave a 4 byte "hole" in the event due to alignment on 64 bit machines.

-- Steve

> +		__field(long, node_size)
> +		__field(long, diff_size)
>  	),
>  
>  	TP_fast_assign(
>  		__entry->mm_id = mm_ptr_to_hash(mm);
>  		__entry->curr = !!(current->mm == mm);
>  		__entry->member = member;
> -		__entry->size = (count << PAGE_SHIFT);
> +		__entry->member_size = (member_count << PAGE_SHIFT);
> +		__entry->node = node;
> +		__entry->node_size = (node_count << PAGE_SHIFT);
> +		__entry->diff_size = (diff_count << PAGE_SHIFT);
>  	),
>  
> -	TP_printk("mm_id=%u curr=%d type=%s size=%ldB",
> +	TP_printk("mm_id=%u curr=%d type=%s type_size=%ldB node=%d node_size=%ldB diff_size=%ldB",
>  		__entry->mm_id,
>  		__entry->curr,
>  		__print_symbolic(__entry->member, TRACE_MM_PAGES),
> -		__entry->size)
> +		__entry->member_size,
> +		__entry->node,
> +		__entry->node_size,
> +		__entry->diff_size)
>  	);
>  #endif /* _TRACE_KMEM_H */
>  
