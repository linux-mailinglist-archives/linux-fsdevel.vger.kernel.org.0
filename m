Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 400AC3B0784
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jun 2021 16:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbhFVOjH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Jun 2021 10:39:07 -0400
Received: from mga12.intel.com ([192.55.52.136]:4926 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231246AbhFVOjF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Jun 2021 10:39:05 -0400
IronPort-SDR: uWrofRyHQt88knhKBKxSZODwu559Hg7Q1JuTL12uRgntl+hduL2ftzM3FFnKkKqulRtIIPdIP1
 kMtztOqA1dGw==
X-IronPort-AV: E=McAfee;i="6200,9189,10023"; a="186754520"
X-IronPort-AV: E=Sophos;i="5.83,291,1616482800"; 
   d="scan'208";a="186754520"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2021 07:36:48 -0700
IronPort-SDR: gvzceX3q2U48XWtETJ8dWs+IlBV1Z663ZBzcoUuC6UBwUdxUVUSGBCKInGedNvSBfff8TOMOvc
 pIQVcS8/G9ZQ==
X-IronPort-AV: E=Sophos;i="5.83,291,1616482800"; 
   d="scan'208";a="423337744"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2021 07:36:43 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lvhW3-004UlQ-NH; Tue, 22 Jun 2021 17:36:39 +0300
Date:   Tue, 22 Jun 2021 17:36:39 +0300
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
Subject: Re: [PATCH v5 1/4] fs: introduce helper d_path_unsafe()
Message-ID: <YNH1d0aAu1WRiua1@smile.fi.intel.com>
References: <20210622140634.2436-1-justin.he@arm.com>
 <20210622140634.2436-2-justin.he@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210622140634.2436-2-justin.he@arm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 22, 2021 at 10:06:31PM +0800, Jia He wrote:
> This helper is similar to d_path() except that it doesn't take any
> seqlock/spinlock. It is typical for debugging purposes. Besides,
> an additional return value *prenpend_len* is used to get the full
> path length of the dentry, ingoring the tail '\0'.
> the full path length = end - buf - prepend_length - 1

Missed period at the end of sentence.

> Previously it will skip the prepend_name() loop at once in
> __prepen_path() when the buffer length is not enough or even negative.
> prepend_name_with_len() will get the full length of dentry name
> together with the parent recursively regardless of the buffer length.

> If someone invokes snprintf() with small but positive space,
> prepend_name_with_len() moves and copies the string partially.
> 
> More than that, kasprintf() will pass NULL _buf_ and _end_ as the
> parameters. Hence return at the very beginning with false in this case.

These two paragraphs are talking about printf() interface, while patch has
nothing to do with it. Please, rephrase in a way that it doesn't refer to the
particular callers. Better to mention them in the corresponding printf()
patch(es).

...

>   * prepend_name - prepend a pathname in front of current buffer pointer
> - * @buffer: buffer pointer
> - * @buflen: allocated length of the buffer
> + * @p: prepend buffer which contains buffer pointer and allocated length

>   * @name:   name string and length qstr structure

Indentation issue btw, can be fixed in the same patch.

>   *
>   * With RCU path tracing, it may race with d_move(). Use READ_ONCE() to

Shouldn't this be a separate change with corresponding Fixes tag?

...

> +/**
> + * d_path_unsafe - return the full path of a dentry without taking
> + * any seqlock/spinlock. This helper is typical for debugging purposes.

Seems you ignored my comment, or forget to test, or compile test with kernel
doc validator enabled doesn't show any issues. If it's the latter, we have to
fix kernel doc validator.

TL;DR: describe parameters as well.

> + */

...

> +	struct path root;
> +	struct mount *mnt = real_mount(path->mnt);
> +	DECLARE_BUFFER(b, buf, buflen);

Can wee keep this in reversed xmas tree order?


-- 
With Best Regards,
Andy Shevchenko


