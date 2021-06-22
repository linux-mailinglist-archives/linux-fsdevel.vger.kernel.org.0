Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA0793B07AF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jun 2021 16:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231942AbhFVOpt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Jun 2021 10:45:49 -0400
Received: from mga01.intel.com ([192.55.52.88]:26689 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231348AbhFVOpr (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Jun 2021 10:45:47 -0400
IronPort-SDR: JvxdboJduOZzcOvkStKygDkllBNviuRSYQYs2L7J8wUnftwG0aghZfhCcBmznTOlhxbN/9D7Tf
 OTqRmg01B/pg==
X-IronPort-AV: E=McAfee;i="6200,9189,10023"; a="228622060"
X-IronPort-AV: E=Sophos;i="5.83,291,1616482800"; 
   d="scan'208";a="228622060"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2021 07:43:31 -0700
IronPort-SDR: ie/QTvcNByYrO2GfHoQjFDlUsv+4qABJGxJUy/8WK4lyiMjH25LM187Hlfz9JZ9jBpEeHzGHZo
 8D7X+Pe/xuXw==
X-IronPort-AV: E=Sophos;i="5.83,291,1616482800"; 
   d="scan'208";a="639126745"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2021 07:43:27 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lvhcZ-004Upi-15; Tue, 22 Jun 2021 17:43:23 +0300
Date:   Tue, 22 Jun 2021 17:43:23 +0300
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
Subject: Re: [PATCH v5 0/4] make '%pD' print the full path of file
Message-ID: <YNH3C6P9i7xvapav@smile.fi.intel.com>
References: <20210622140634.2436-1-justin.he@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210622140634.2436-1-justin.he@arm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 22, 2021 at 10:06:30PM +0800, Jia He wrote:
> Background
> ==========
> Linus suggested printing the full path of file instead of printing
> the components as '%pd'.
> 
> Typically, there is no need for printk specifiers to take any real locks
> (ie mount_lock or rename_lock). So I introduce a new helper d_path_fast
> which is similar to d_path except it doesn't take any seqlock/spinlock.
> 
> This series is based on Al Viro's d_path cleanup patches [1] which
> lifted the inner lockless loop into a new helper. 
> 
> Link: https://lkml.org/lkml/2021/5/18/1260 [1]
> 
> Test
> ====
> The cases I tested:
> 1. print '%pD' with full path of ext4 file
> 2. mount a ext4 filesystem upon a ext4 filesystem, and print the file
>    with '%pD'
> 3. all test_print selftests, including the new '%14pD' '%-14pD'

> 4. kasnprintf

I believe you are talking about kasprintf().


> Changelog
> =========
> v5:
> - remove the RFC tag

JFYI, when we drop RFC we usually start the series from v1.

> - refine the commit msg/comments(by Petr, Andy)
> - make using_scratch_space a new parameter of the test case 

Thanks for the update, I have found few minor things, please address them and
feel free to add
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> v4:
> - don't support spec.precision anymore for '%pD'
> - add Rasmus's patch into this series
>  
> v3:
> - implement new d_path_unsafe to use [buf, end] instead of stack space for
>   filling bytes (by Matthew)
> - add new test cases for '%pD'
> - drop patch "hmcdrv: remove the redundant directory path" before removing rfc.
> 
> v2: 
> - implement new d_path_fast based on Al Viro's patches
> - add check_pointer check (by Petr)
> - change the max full path size to 256 in stack space
> 
> v1: https://lkml.org/lkml/2021/5/8/122
> 
> 
> Jia He (3):
>   fs: introduce helper d_path_unsafe()
>   lib/vsprintf.c: make '%pD' print the full path of file
>   lib/test_printf.c: add test cases for '%pD'
> 
> Rasmus Villemoes (1):
>   lib/test_printf.c: split write-beyond-buffer check in two
> 
>  Documentation/core-api/printk-formats.rst |   5 +-
>  fs/d_path.c                               | 104 +++++++++++++++++++++-
>  include/linux/dcache.h                    |   1 +
>  lib/test_printf.c                         |  54 ++++++++---
>  lib/vsprintf.c                            |  40 ++++++++-
>  5 files changed, 184 insertions(+), 20 deletions(-)
> 
> -- 
> 2.17.1
> 

-- 
With Best Regards,
Andy Shevchenko


