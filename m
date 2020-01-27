Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D20E414AB57
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jan 2020 21:52:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbgA0Uwy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jan 2020 15:52:54 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:55146 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbgA0Uwy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jan 2020 15:52:54 -0500
Received: by mail-pj1-f65.google.com with SMTP id dw13so6146pjb.4;
        Mon, 27 Jan 2020 12:52:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FAvjESqfHP0fRix1omPJhQlHaWmPxKT1qAt5Io3Ecl0=;
        b=Xrxs/PB39/S+H1IW0+72Sfz/DhvnxYqqn2qJ9YlbcVC9r1TiItpscPOkGQebWqPqNb
         qN29FKoS9z+zGCshkF3ZhfH1C7sukU5sq/SY3iRNNBnifo84tvPcHJF+PrxosvEW6f7e
         0gKup7VweMRIX2jAaOy75EgPOiejG83Mp8X3k2L7FN5CGZssT+Qm/yO++Lb+XBk//8nm
         Li66s5WTX54iZ2aOJDbzkymJGtVmtJIsjb1G4ciPJWAG0X/g7RtQUWNBCMYTNL+PVLO8
         TpSlpocHuuDdA8OK/AHwfRWOv2yUVeTg/gmUv5d0ZbKBgFY4hdjpx4ksZ6FV42vqXMbM
         tP3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FAvjESqfHP0fRix1omPJhQlHaWmPxKT1qAt5Io3Ecl0=;
        b=lX8z+8g5nL4NrWTfTptCH5HTsgtUYpBjwuqNPlHzEy5rlrLZ4PGkxA9eMY+UNCV/Pc
         KA5XsR5quwWlOSFFCvqPAJJNWXgzlDCK2KMTjH7VVDykqrKoNb9AU2VmerD41CDNJ8t8
         WV43qd25+PT6Oa7CVbvKu2DfbVPWi//vgakUCU8h+s7mZY8/qxH4MDzOHQLSMpGFrGb3
         MvMWWTmh4ZTTOJ3st/xDMnh8dogdXy4fElrh/H22Cv3+l4/v+nvoKlwt+avUJTOLj2vu
         zq9oPjLdnAdmPU2hcE8EylRMjSJhBcuf+hiRZfD4T2t8fDRiCLjomepjqv5+pmk88imk
         Q/Dg==
X-Gm-Message-State: APjAAAWsgeJh29qpfiO2kri4BmJVv84z+rIalsTR5nIs/LeVjQKmYWPi
        N/xgnJk0ntkGjSa5qF5GXvY=
X-Google-Smtp-Source: APXvYqziiwBxEqM+qUPCXXYIJEjli9/gHs667J01IfZYGmcZtgdT4LyE0M0MXDptNU+hyPY434XtzA==
X-Received: by 2002:a17:90a:17c2:: with SMTP id q60mr534633pja.111.1580158372874;
        Mon, 27 Jan 2020 12:52:52 -0800 (PST)
Received: from Ryzen-7-3700X.localdomain ([192.200.24.85])
        by smtp.gmail.com with ESMTPSA id y197sm17641232pfc.79.2020.01.27.12.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 12:52:52 -0800 (PST)
Date:   Mon, 27 Jan 2020 13:52:47 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jonathan Corbet <corbet@lwn.net>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Shuah Khan <shuah@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH 2/3] mm/gup_benchmark: support pin_user_pages() and
 related calls
Message-ID: <20200127205247.GA578@Ryzen-7-3700X.localdomain>
References: <20200125021115.731629-1-jhubbard@nvidia.com>
 <20200125021115.731629-3-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200125021115.731629-3-jhubbard@nvidia.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi John,

On Fri, Jan 24, 2020 at 06:11:14PM -0800, John Hubbard wrote:
> Up until now, gup_benchmark supported testing of the
> following kernel functions:
> 
> * get_user_pages(): via the '-U' command line option
> * get_user_pages_longterm(): via the '-L' command line option
> * get_user_pages_fast(): as the default (no options required)
> 
> Add test coverage for the new corresponding pin_*() functions:
> 
> * pin_user_pages_fast(): via the '-a' command line option
> * pin_user_pages():      via the '-b' command line option
> 
> Also, add an option for clarity: '-u' for what is now (still) the
> default choice: get_user_pages_fast().
> 
> Also, for the commands that set FOLL_PIN, verify that the pages
> really are dma-pinned, via the new is_dma_pinned() routine.
> Those commands are:
> 
>     PIN_FAST_BENCHMARK     : calls pin_user_pages_fast()
>     PIN_BENCHMARK          : calls pin_user_pages()
> 
> In between the calls to pin_*() and unpin_user_pages(),
> check each page: if page_dma_pinned() returns false, then
> WARN and return.
> 
> Do this outside of the benchmark timestamps, so that it doesn't
> affect reported times.
> 
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>  mm/gup_benchmark.c                         | 70 ++++++++++++++++++++--
>  tools/testing/selftests/vm/gup_benchmark.c | 15 ++++-
>  2 files changed, 79 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/gup_benchmark.c b/mm/gup_benchmark.c
> index 8dba38e79a9f..3d5fb765e4e6 100644
> --- a/mm/gup_benchmark.c
> +++ b/mm/gup_benchmark.c
> @@ -8,6 +8,8 @@
>  #define GUP_FAST_BENCHMARK	_IOWR('g', 1, struct gup_benchmark)
>  #define GUP_LONGTERM_BENCHMARK	_IOWR('g', 2, struct gup_benchmark)
>  #define GUP_BENCHMARK		_IOWR('g', 3, struct gup_benchmark)
> +#define PIN_FAST_BENCHMARK	_IOWR('g', 4, struct gup_benchmark)
> +#define PIN_BENCHMARK		_IOWR('g', 5, struct gup_benchmark)
>  
>  struct gup_benchmark {
>  	__u64 get_delta_usec;
> @@ -19,6 +21,47 @@ struct gup_benchmark {
>  	__u64 expansion[10];	/* For future use */
>  };
>  
> +static void put_back_pages(int cmd, struct page **pages, unsigned long nr_pages)

We received a Clang build report on this patch because the use of
PIN_FAST_BENCHMARK and PIN_BENCHMARK in the switch statement below will
overflow int; this should be unsigned int to match the cmd parameter in
the ioctls.

The report can be read here if you care for it:

https://groups.google.com/d/msg/clang-built-linux/gyGayC_dnis/D1celSStEgAJ

Cheers,
Nathan

> +{
> +	int i;
> +
> +	switch (cmd) {
> +	case GUP_FAST_BENCHMARK:
> +	case GUP_LONGTERM_BENCHMARK:
> +	case GUP_BENCHMARK:
> +		for (i = 0; i < nr_pages; i++)
> +			put_page(pages[i]);
> +		break;
> +
> +	case PIN_FAST_BENCHMARK:
> +	case PIN_BENCHMARK:
> +		unpin_user_pages(pages, nr_pages);
> +		break;
> +	}
> +}
> +
> +static void verify_dma_pinned(int cmd, struct page **pages,
> +			      unsigned long nr_pages)
> +{
> +	int i;
> +	struct page *page;
> +
> +	switch (cmd) {
> +	case PIN_FAST_BENCHMARK:
> +	case PIN_BENCHMARK:
> +		for (i = 0; i < nr_pages; i++) {
> +			page = pages[i];
> +			if (WARN(!page_dma_pinned(page),
> +				 "pages[%d] is NOT dma-pinned\n", i)) {
> +
> +				dump_page(page, "gup_benchmark failure");
> +				break;
> +			}
> +		}
> +		break;
> +	}
> +}
> +
>  static int __gup_benchmark_ioctl(unsigned int cmd,
>  		struct gup_benchmark *gup)
>  {
> @@ -66,6 +109,14 @@ static int __gup_benchmark_ioctl(unsigned int cmd,
>  			nr = get_user_pages(addr, nr, gup->flags, pages + i,
>  					    NULL);
>  			break;
> +		case PIN_FAST_BENCHMARK:
> +			nr = pin_user_pages_fast(addr, nr, gup->flags,
> +						 pages + i);
> +			break;
> +		case PIN_BENCHMARK:
> +			nr = pin_user_pages(addr, nr, gup->flags, pages + i,
> +					    NULL);
> +			break;
>  		default:
>  			kvfree(pages);
>  			ret = -EINVAL;
> @@ -78,15 +129,22 @@ static int __gup_benchmark_ioctl(unsigned int cmd,
>  	}
>  	end_time = ktime_get();
>  
> +	/* Shifting the meaning of nr_pages: now it is actual number pinned: */
> +	nr_pages = i;
> +
>  	gup->get_delta_usec = ktime_us_delta(end_time, start_time);
>  	gup->size = addr - gup->addr;
>  
> +	/*
> +	 * Take an un-benchmark-timed moment to verify DMA pinned
> +	 * state: print a warning if any non-dma-pinned pages are found:
> +	 */
> +	verify_dma_pinned(cmd, pages, nr_pages);
> +
>  	start_time = ktime_get();
> -	for (i = 0; i < nr_pages; i++) {
> -		if (!pages[i])
> -			break;
> -		put_page(pages[i]);
> -	}
> +
> +	put_back_pages(cmd, pages, nr_pages);
> +
>  	end_time = ktime_get();
>  	gup->put_delta_usec = ktime_us_delta(end_time, start_time);
>  
> @@ -105,6 +163,8 @@ static long gup_benchmark_ioctl(struct file *filep, unsigned int cmd,
>  	case GUP_FAST_BENCHMARK:
>  	case GUP_LONGTERM_BENCHMARK:
>  	case GUP_BENCHMARK:
> +	case PIN_FAST_BENCHMARK:
> +	case PIN_BENCHMARK:
>  		break;
>  	default:
>  		return -EINVAL;
> diff --git a/tools/testing/selftests/vm/gup_benchmark.c b/tools/testing/selftests/vm/gup_benchmark.c
> index 389327e9b30a..43b4dfe161a2 100644
> --- a/tools/testing/selftests/vm/gup_benchmark.c
> +++ b/tools/testing/selftests/vm/gup_benchmark.c
> @@ -18,6 +18,10 @@
>  #define GUP_LONGTERM_BENCHMARK	_IOWR('g', 2, struct gup_benchmark)
>  #define GUP_BENCHMARK		_IOWR('g', 3, struct gup_benchmark)
>  
> +/* Similar to above, but use FOLL_PIN instead of FOLL_GET. */
> +#define PIN_FAST_BENCHMARK	_IOWR('g', 4, struct gup_benchmark)
> +#define PIN_BENCHMARK		_IOWR('g', 5, struct gup_benchmark)
> +
>  /* Just the flags we need, copied from mm.h: */
>  #define FOLL_WRITE	0x01	/* check pte is writable */
>  
> @@ -40,8 +44,14 @@ int main(int argc, char **argv)
>  	char *file = "/dev/zero";
>  	char *p;
>  
> -	while ((opt = getopt(argc, argv, "m:r:n:f:tTLUwSH")) != -1) {
> +	while ((opt = getopt(argc, argv, "m:r:n:f:abtTLUuwSH")) != -1) {
>  		switch (opt) {
> +		case 'a':
> +			cmd = PIN_FAST_BENCHMARK;
> +			break;
> +		case 'b':
> +			cmd = PIN_BENCHMARK;
> +			break;
>  		case 'm':
>  			size = atoi(optarg) * MB;
>  			break;
> @@ -63,6 +73,9 @@ int main(int argc, char **argv)
>  		case 'U':
>  			cmd = GUP_BENCHMARK;
>  			break;
> +		case 'u':
> +			cmd = GUP_FAST_BENCHMARK;
> +			break;
>  		case 'w':
>  			write = 1;
>  			break;
> -- 
> 2.25.0
> 
