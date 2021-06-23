Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5C83B1683
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jun 2021 11:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbhFWJNT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Jun 2021 05:13:19 -0400
Received: from mga06.intel.com ([134.134.136.31]:64028 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229833AbhFWJNT (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Jun 2021 05:13:19 -0400
IronPort-SDR: lX/3ZRXaokTnCMmFEgHbOGWeh7n4/DaGtmYnBA7kMbr/wf43b1VSmcJDUdoGsBCpSr5yp1/U1y
 lnUQoSetO31Q==
X-IronPort-AV: E=McAfee;i="6200,9189,10023"; a="268365302"
X-IronPort-AV: E=Sophos;i="5.83,293,1616482800"; 
   d="scan'208";a="268365302"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2021 02:10:45 -0700
IronPort-SDR: hxXNz0tyEQrcK4vGZgRlb1Z2ZzfLzU/qRksGlt9+s+57wqqsRXAv7zL9nawXi9U9LD8bHWElKc
 gQ50VUPkFy5g==
X-IronPort-AV: E=Sophos;i="5.83,293,1616482800"; 
   d="scan'208";a="474074292"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2021 02:10:41 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lvyu5-004hYo-62; Wed, 23 Jun 2021 12:10:37 +0300
Date:   Wed, 23 Jun 2021 12:10:37 +0300
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
Subject: Re: [PATCH v2 1/4] fs: introduce helper d_path_unsafe()
Message-ID: <YNL6jcrN42YjDWpB@smile.fi.intel.com>
References: <20210623055011.22916-1-justin.he@arm.com>
 <20210623055011.22916-2-justin.he@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210623055011.22916-2-justin.he@arm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 23, 2021 at 01:50:08PM +0800, Jia He wrote:
> This helper is similar to d_path() except that it doesn't take any
> seqlock/spinlock. It is typical for debugging purposes. Besides,
> an additional return value *prenpend_len* is used to get the full
> path length of the dentry, ingoring the tail '\0'.
> the full path length = end - buf - prepend_length - 1.
> 
> Previously it will skip the prepend_name() loop at once in
> __prepen_path() when the buffer length is not enough or even negative.
> prepend_name_with_len() will get the full length of dentry name
> together with the parent recursively regardless of the buffer length.

...

>  /**
>   * prepend_name - prepend a pathname in front of current buffer pointer
> - * @buffer: buffer pointer
> - * @buflen: allocated length of the buffer
> - * @name:   name string and length qstr structure
> + * @p: prepend buffer which contains buffer pointer and allocated length
> + * @name: name string and length qstr structure
>   *
>   * With RCU path tracing, it may race with d_move(). Use READ_ONCE() to
>   * make sure that either the old or the new name pointer and length are

This should be separate patch. You are sending new version too fast...
Instead of speeding up it will slow down the review process.

...

> +	const char *dname = smp_load_acquire(&name->name); /* ^^^ */

I have commented on the comment here. What does it mean for mere reader?

> +	int dlen = READ_ONCE(name->len);
> +	char *s;
> +	int last_len = p->len;

Reversed xmas tree order, please.

The rule of thumb is when you have gotten a comment against a piece of code,
try to fix all similar places at once.

...

> @@ -108,8 +181,7 @@ static int __prepend_path(const struct dentry *dentry, const struct mount *mnt,
>   * prepend_path - Prepend path string to a buffer
>   * @path: the dentry/vfsmount to report
>   * @root: root vfsmnt/dentry
> - * @buffer: pointer to the end of the buffer
> - * @buflen: pointer to buffer length
> + * @p: prepend buffer which contains buffer pointer and allocated length
>   *
>   * The function will first try to write out the pathname without taking any
>   * lock other than the RCU read lock to make sure that dentries won't go away.

Kernel doc fix should be in a separate patch.


-- 
With Best Regards,
Andy Shevchenko


