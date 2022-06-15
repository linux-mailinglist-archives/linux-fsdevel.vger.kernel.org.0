Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A519A54D324
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jun 2022 22:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346644AbiFOU6P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jun 2022 16:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349526AbiFOU6I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jun 2022 16:58:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81CF0CE29;
        Wed, 15 Jun 2022 13:58:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 24B46B81BEC;
        Wed, 15 Jun 2022 20:57:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93D21C3411A;
        Wed, 15 Jun 2022 20:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1655326677;
        bh=iTyZFbAyEthLHEZJwJ5w60OvPz4a+y6uV9Z+W/TBOzQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KWaMhHUEZznBK0roFeYgsmy3jjQqaYXHTqTiKI3kqNKtVv5dhddmC2s4x5kHay4lQ
         NJM37klyT3xEsTZ+JfjfljDQqTQFMKQJWULWKoBOMKh5/u8d3O/dSt+C5wxnSfJng2
         NAdBQqntW91ikFD+megJOZjB83AfzfHM3KnOsWd0=
Date:   Wed, 15 Jun 2022 13:57:56 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     <kernel@axis.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] mm/smaps: add Pss_Dirty
Message-Id: <20220615135756.ddc3341239b739d5f1f88da6@linux-foundation.org>
In-Reply-To: <20220615071252.1153408-1-vincent.whitchurch@axis.com>
References: <20220615071252.1153408-1-vincent.whitchurch@axis.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 15 Jun 2022 09:12:52 +0200 Vincent Whitchurch <vincent.whitchurch@axis.com> wrote:

> Pss is the sum of the sizes of clean and dirty private pages, and the
> proportional sizes of clean and dirty shared pages:
> 
>  Private = Private_Dirty + Private_Clean
>  Shared_Proportional = Shared_Dirty_Proportional + Shared_Clean_Proportional
>  Pss = Private + Shared_Proportional
> 
> The Shared*Proportional fields are not present in smaps, so it is not
> possible to determine how much of the Pss is from dirty pages and how
> much is from clean pages.  This information can be useful for measuring
> memory usage for the purpose of optimisation, since clean pages can
> usually be discarded by the kernel immediately while dirty pages cannot.
> 
> The smaps routines in the kernel already have access to this data, so
> add a Pss_Dirty to show it to userspace.  Pss_Clean is not added since
> it can be calculated from Pss and Pss_Dirty.
> 
> ...
>
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -406,6 +406,7 @@ struct mem_size_stats {
>  	u64 pss_anon;
>  	u64 pss_file;
>  	u64 pss_shmem;
> +	u64 pss_dirty;
>  	u64 pss_locked;
>  	u64 swap_pss;
>  };
> @@ -427,6 +428,7 @@ static void smaps_page_accumulate(struct mem_size_stats *mss,
>  		mss->pss_locked += pss;
>  
>  	if (dirty || PageDirty(page)) {
> +		mss->pss_dirty += pss;
>  		if (private)
>  			mss->private_dirty += size;
>  		else
> @@ -820,6 +822,7 @@ static void __show_smap(struct seq_file *m, const struct mem_size_stats *mss,
>  		SEQ_PUT_DEC(" kB\nPss_Shmem:      ",
>  			mss->pss_shmem >> PSS_SHIFT);
>  	}
> +	SEQ_PUT_DEC(" kB\nPss_Dirty:      ", mss->pss_dirty >> PSS_SHIFT);
>  	SEQ_PUT_DEC(" kB\nShared_Clean:   ", mss->shared_clean);
>  	SEQ_PUT_DEC(" kB\nShared_Dirty:   ", mss->shared_dirty);
>  	SEQ_PUT_DEC(" kB\nPrivate_Clean:  ", mss->private_clean);

Well it's certainly simple.

Can you please update Documentation/ABI/testing/procfs-smaps_rollup and
Documentation/filesystems/proc.rst, resend?

