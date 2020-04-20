Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6C781B183B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Apr 2020 23:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbgDTVTM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Apr 2020 17:19:12 -0400
Received: from mga14.intel.com ([192.55.52.115]:57830 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726021AbgDTVTL (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Apr 2020 17:19:11 -0400
IronPort-SDR: +kFQLJz3JbzohDVGfJn8HZNRlJTptPxYSr3IzO8RHzY7G5UqMbW6oYNLhtPQQPLE8K8nI+WxDh
 POUDLBDQwd6A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2020 14:19:10 -0700
IronPort-SDR: N+UnUbuQt2NFXNexHyrJRjVokIjWea2GWPhSfgYmGBB4Z2iIrJFrtFA38tYn9lnTcwYduYX+uU
 NvoSwysYb2hQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,407,1580803200"; 
   d="scan'208";a="255071506"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga003.jf.intel.com with ESMTP; 20 Apr 2020 14:19:08 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jQdot-0027ua-1f; Tue, 21 Apr 2020 00:19:11 +0300
Date:   Tue, 21 Apr 2020 00:19:11 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, pmladek@suse.com,
        rostedt@goodmis.org, sergey.senozhatsky@gmail.com,
        linux@rasmusvillemoes.dk
Subject: Re: [PATCH 03/15] print_integer: new and improved way of printing
 integers
Message-ID: <20200420211911.GC185537@smile.fi.intel.com>
References: <20200420205743.19964-1-adobriyan@gmail.com>
 <20200420205743.19964-3-adobriyan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420205743.19964-3-adobriyan@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 20, 2020 at 11:57:31PM +0300, Alexey Dobriyan wrote:
> Time honored way to print integers via vsnprintf() or equivalent has
> unavoidable slowdown of parsing format string. This can't be fixed in C,
> without introducing external preprocessor.
> 
> seq_put_decimal_ull() partially saves the day, but there are a lot of
> branches inside and overcopying still.
> 
> _print_integer_*() family of functions is meant to make printing
> integers as fast as possible by deleting format string parsing and doing
> as little work as possible.
> 
> It is based on the following observations:
> 
> 1) memcpy is done in forward direction
> 	it can be done backwards but nobody does that,
> 
> 2) digits can be extracted in a very simple loop which costs only
> 	1 multiplication and shift (division by constant is not division)
> 
> All the above asks for the following signature, semantics and pattern of
> printing out beloved /proc files:
> 
> 	/* seq_printf(seq, "%u %llu\n", A, b); */
> 
> 	char buf[10 + 1 + 20 + 1];
> 	char *p = buf + sizeof(buf);
> 
> 	*--p = '\n';
> 	p = _print_integer_u64(p, B);
> 	*--p = ' ';
> 	p = _print_integer_u32(p, A);
> 
> 	seq_write(seq, p, buf + sizeof(buf) - p);
> 
> 1) stack buffer capable of holding the biggest string is allocated.
> 
> 2) "p" is pointer to start of the string. Initially it points past
> 	the end of the buffer WHICH IS NOT NUL-TERMINATED!
> 
> 3) _print_integer_*() actually prints an integer from right to left
> 	and returns new start of the string.
> 
> 			     <--------|
> 				123
> 				^
> 				|
> 				+-- p
> 
> 4) 1 character is printed with
> 
> 	*--p = 'x';
> 
> 	It generates very efficient code as multiple writes can be
> 	merged.
> 
> 5) fixed string is printed with
> 
> 	p = memcpy(p - 3, "foo", 3);
> 
> 	Complers know what memcpy() does and write-combine it.
> 	4/8-byte writes become 1 instruction and are very efficient.
> 
> 6) Once everything is printed, the result is written to seq_file buffer.
> 	It does only one overflow check and 1 copy.
> 
> This generates very efficient code (and small!).
> 
> In regular seq_printf() calls, first argument and format string are
> constantly reloaded. Format string will most likely with [rip+...] which
> is quite verbose.
> 
> seq_put_decimal_ull() will do branches (and even more branches
> with "width" argument)
> 

> 	TODO
> 	benchmark with mainline because nouveau is broken for me -(
> 	vsnprintf() changes make the code slower

Exactly main point of this exercise. I don't believe that algos in vsprintf.c
are too dumb to use division per digit (yes, division by constant which is not
power of two is a heavy operation).


> +noinline
> +char *_print_integer_u32(char *p, u32 x)
> +{
> +	do {
> +		*--p = '0' + (x % 10);
> +	} while (x /= 10);
> +	return p;
> +}

> +noinline
> +char *_print_integer_u64(char *p, u64 x)
> +{
> +	while (x >= 100 * 1000 * 1000) {
> +		u32 r;
> +
> +		x = div_u64_rem(x, 100 * 1000 * 1000, &r);
> +		p = memset(p - 8, '0', 8);
> +		(void)_print_integer_u32(p + 8, r);
> +	}
> +	return _print_integer_u32(p, x);
> +}

-- 
With Best Regards,
Andy Shevchenko


