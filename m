Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3063B16A6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jun 2021 11:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbhFWJSk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Jun 2021 05:18:40 -0400
Received: from mga03.intel.com ([134.134.136.65]:28254 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229833AbhFWJSh (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Jun 2021 05:18:37 -0400
IronPort-SDR: MWDb4sVHSf+/bxn5C2jYdb9SzEXLSMm90pY5gFkQAAhhvvC3+7pqBI6fl4HY4wVbauawivm7kB
 0arplk1Rxefw==
X-IronPort-AV: E=McAfee;i="6200,9189,10023"; a="207267619"
X-IronPort-AV: E=Sophos;i="5.83,293,1616482800"; 
   d="scan'208";a="207267619"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2021 02:16:19 -0700
IronPort-SDR: nR4vg6G/TC9WdS1fhqF0Ckg4oLkq3z69gTz4q9LGfBnQsLskdHMeNGDlGxg3vaY+6IhXzyxg4A
 RWCLvhwdcCFg==
X-IronPort-AV: E=Sophos;i="5.83,293,1616482800"; 
   d="scan'208";a="406623987"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2021 02:16:15 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lvyzQ-004hcu-Pv; Wed, 23 Jun 2021 12:16:08 +0300
Date:   Wed, 23 Jun 2021 12:16:08 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jia He <justin.he@arm.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Eric Biggers <ebiggers@google.com>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>, nd@arm.com
Subject: Re: [PATCH v2 3/4] lib/test_printf.c: split write-beyond-buffer
 check in two
Message-ID: <YNL72KwP8oyNzons@smile.fi.intel.com>
References: <20210623055011.22916-1-justin.he@arm.com>
 <20210623055011.22916-4-justin.he@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210623055011.22916-4-justin.he@arm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 23, 2021 at 01:50:10PM +0800, Jia He wrote:
> From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> 
> Before each invocation of vsnprintf(), do_test() memsets the entire
> allocated buffer to a sentinel value. That buffer includes leading and
> trailing padding which is never included in the buffer area handed to
> vsnprintf (spaces merely for clarity):
> 
>   pad  test_buffer      pad
>   **** **************** ****
> 
> Then vsnprintf() is invoked with a bufsize argument <=
> BUF_SIZE. Suppose bufsize=10, then we'd have e.g.
> 
>  |pad |   test_buffer    |pad |
>   **** pizza0 **** ****** ****
>  A    B      C    D           E
> 
> where vsnprintf() was given the area from B to D.
> 
> It is obviously a bug for vsnprintf to touch anything between A and B
> or between D and E. The former is checked for as one would expect. But
> for the latter, we are actually a little stricter in that we check the
> area between C and E.
> 
> Split that check in two, providing a clearer error message in case it
> was a genuine buffer overrun and not merely a write within the
> provided buffer, but after the end of the generated string.
> 
> So far, no part of the vsnprintf() implementation has had any use for
> using the whole buffer as scratch space, but it's not unreasonable to
> allow that, as long as the result is properly nul-terminated and the
> return value is the right one. However, it is somewhat unusual, and
> most %<something> won't need this, so keep the [C,D] check, but make
> it easy for a later patch to make that part opt-out for certain tests.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Tested-by: Jia He <justin.he@arm.com>
> Signed-off-by: Jia He <justin.he@arm.com>
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> ---
>  lib/test_printf.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/test_printf.c b/lib/test_printf.c
> index ec0d5976bb69..d1d2f898ebae 100644
> --- a/lib/test_printf.c
> +++ b/lib/test_printf.c
> @@ -78,12 +78,17 @@ do_test(int bufsize, const char *expect, int elen,
>  		return 1;
>  	}
>  
> -	if (memchr_inv(test_buffer + written + 1, FILL_CHAR, BUF_SIZE + PAD_SIZE - (written + 1))) {
> +	if (memchr_inv(test_buffer + written + 1, FILL_CHAR, bufsize - (written + 1))) {
>  		pr_warn("vsnprintf(buf, %d, \"%s\", ...) wrote beyond the nul-terminator\n",
>  			bufsize, fmt);
>  		return 1;
>  	}
>  
> +	if (memchr_inv(test_buffer + bufsize, FILL_CHAR, BUF_SIZE + PAD_SIZE - bufsize)) {
> +		pr_warn("vsnprintf(buf, %d, \"%s\", ...) wrote beyond buffer\n", bufsize, fmt);
> +		return 1;
> +	}
> +
>  	if (memcmp(test_buffer, expect, written)) {
>  		pr_warn("vsnprintf(buf, %d, \"%s\", ...) wrote '%s', expected '%.*s'\n",
>  			bufsize, fmt, test_buffer, written, expect);
> -- 
> 2.17.1
> 

-- 
With Best Regards,
Andy Shevchenko


