Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 345C43B1695
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jun 2021 11:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbhFWJRa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Jun 2021 05:17:30 -0400
Received: from mga02.intel.com ([134.134.136.20]:10430 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230109AbhFWJR3 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Jun 2021 05:17:29 -0400
IronPort-SDR: pDYcOQpaICIBdF5nXwuMg84KeDntFcDiFTpCv7BdRHBxyJj/f94v2Rv5gzNuETV1NlZpY2++lO
 lZ7lZzrPC0Mg==
X-IronPort-AV: E=McAfee;i="6200,9189,10023"; a="194365959"
X-IronPort-AV: E=Sophos;i="5.83,293,1616482800"; 
   d="scan'208";a="194365959"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2021 02:15:03 -0700
IronPort-SDR: QTCrY2/uZS/S33R68erMlwME/oA/hQ2PKXj+baFV/MK+DVQU5hA9srQVTcaUNMIY/f8SYRuyp0
 z1hgqEuMoCeg==
X-IronPort-AV: E=Sophos;i="5.83,293,1616482800"; 
   d="scan'208";a="556083384"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2021 02:14:59 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lvyyF-004hbq-Ag; Wed, 23 Jun 2021 12:14:55 +0300
Date:   Wed, 23 Jun 2021 12:14:55 +0300
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
Subject: Re: [PATCH v2 2/4] lib/vsprintf.c: make '%pD' print the full path of
 file
Message-ID: <YNL7j2GfSbUCetZ0@smile.fi.intel.com>
References: <20210623055011.22916-1-justin.he@arm.com>
 <20210623055011.22916-3-justin.he@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210623055011.22916-3-justin.he@arm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 23, 2021 at 01:50:09PM +0800, Jia He wrote:
> Previously, the specifier '%pD' is for printing dentry name of struct
> file. It may not be perfect (by default it only prints one component.)
> 
> As suggested by Linus [1]:
> > A dentry has a parent, but at the same time, a dentry really does
> > inherently have "one name" (and given just the dentry pointers, you
> > can't show mount-related parenthood, so in many ways the "show just
> > one name" makes sense for "%pd" in ways it doesn't necessarily for
> > "%pD"). But while a dentry arguably has that "one primary component",
> > a _file_ is certainly not exclusively about that last component.
> 
> Hence change the behavior of '%pD' to print the full path of that file.
> 
> If someone invokes snprintf() with small but positive space,
> prepend_name_with_len() moves or truncates the string partially. More
> than that, kasprintf() will pass NULL @buf and @end as the parameters,
> and @end - @buf can be negative in some case. Hence make it return at
> the very beginning with false in these cases.
> 
> Precision is never going to be used with %p (or any of its kernel
> extensions) if -Wformat is turned on.

...

> +	char *p;
> +	const struct path *path;
> +	int prepend_len, widen_len, dpath_len;

Reversed xmas tree order?

-- 
With Best Regards,
Andy Shevchenko


