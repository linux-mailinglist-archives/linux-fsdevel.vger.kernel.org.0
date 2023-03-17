Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 042126BF6B4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Mar 2023 00:56:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbjCQX4n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Mar 2023 19:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjCQX4m (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Mar 2023 19:56:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F1A7B381;
        Fri, 17 Mar 2023 16:56:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 66C8AB8273E;
        Fri, 17 Mar 2023 23:56:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB073C433D2;
        Fri, 17 Mar 2023 23:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1679097398;
        bh=3bZogyBb+BgWIc/n46yzkc9qQmL59iUbkTrU3RkHuwY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=egefDn2kg6gwEkYAefO4skRDz2AesInOi4UU1D//xOyrby31TQzzIVkT+wiVJpXzW
         ebkBW1+qtKePCory3KwBDEwwwKzWgngUqLLJ+cTTaqDdkHaF+Wdwnb5AXwJN5AURUG
         EpWgeT8M4ukdjKl66NLbiXQCWvOh5fGZ5gzfItXc=
Date:   Fri, 17 Mar 2023 16:56:37 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     =?UTF-8?B?VG9tw6HFoSBNdWRydcWIa2E=?= <tomas.mudrunka@gmail.com>
Cc:     Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] Add results of early memtest to /proc/meminfo
Message-Id: <20230317165637.6be5414a3eb05d751da7d19f@linux-foundation.org>
In-Reply-To: <CAH2-hcJicFJ0h76JzY2DoLNF+4Nk7vGtk8gQv8JWFikt6X-wfA@mail.gmail.com>
References: <CAH2-hcJicFJ0h76JzY2DoLNF+4Nk7vGtk8gQv8JWFikt6X-wfA@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 17 Mar 2023 20:30:01 +0100 Tomáš Mudruňka <tomas.mudrunka@gmail.com> wrote:

> Currently the memtest results were only presented in dmesg.
> This adds /proc/meminfo entry which can be easily used by scripts.
> 

/proc/meminfo is documented in Documentation/filesystems/proc.rst,
please.

meminfo is rather top-level and important.  Is this data sufficiently
important to justify a place there?

Please describe the value.  The use-case(s).  Why would people want
this?

> --- a/fs/proc/meminfo.c
> +++ b/fs/proc/meminfo.c
> @@ -6,6 +6,7 @@
>  #include <linux/hugetlb.h>
>  #include <linux/mman.h>
>  #include <linux/mmzone.h>
> +#include <linux/memblock.h>
>  #include <linux/proc_fs.h>
>  #include <linux/percpu.h>
>  #include <linux/seq_file.h>
> @@ -131,6 +132,18 @@ static int meminfo_proc_show(struct seq_file *m, void
> *v)
>   show_val_kb(m, "VmallocChunk:   ", 0ul);
>   show_val_kb(m, "Percpu:         ", pcpu_nr_pages());
> 
> +#ifdef CONFIG_MEMTEST
> + /* Only show 0 Bad memory when test was actually run.
> + * Make sure bad regions smaller than 1kB are not reported as 0.
> + * That way when 0 is reported we can be sure there actually was
> successful test */

Comment layout is unconventional.

> + if (early_memtest_done)
> + seq_printf(m, "EarlyMemtestBad:   %5lu kB\n",
> + (unsigned long) (
> + ((early_memtest_bad_size>0) && (early_memtest_bad_size>>10 <= 0))
> + ? 1
> + : early_memtest_bad_size>>10));

Coding style is unconventional (white spaces).

I expect this code would look much cleaner if some temporaries were used.

	if (early_memtest_done) {
		unsigned long size = 1;
		long sz =  early_memtest_bad_size  >> 10;

		if (early_memtest_bad_size > 0 && sz <= 0)
			size = sz;
		seq_printf(m, "EarlyMemtestBad:   %5lu kB\n", size)
	}

(or something like that, I didn't try hard)

I don't understand this logic anyway.  Why not just print the value of
early_memtest_bad_size>>10 and be done with it.


> +extern int early_memtest_done; /* How many memtest passes were done? */

The name implies a bool, but the comment says otherwise.

> start, phys_addr_t end)
>   memtest(pattern, this_start, this_end - this_start);
>   }
>   }
> + early_memtest_done++;

It's a counter, but it's used as a boolean.  Why not make it bool, and do

	early_memtest_done = true;

here?

Also, your email client is replacing tabs with spaces.
