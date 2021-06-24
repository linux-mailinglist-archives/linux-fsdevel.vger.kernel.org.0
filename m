Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2546E3B2CD4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jun 2021 12:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232272AbhFXKuf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Jun 2021 06:50:35 -0400
Received: from mga12.intel.com ([192.55.52.136]:40968 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232254AbhFXKue (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Jun 2021 06:50:34 -0400
IronPort-SDR: pBGr1bc1vInlTQAPtpuc7mlvw3x7pufkzoAaH2P31bHBRsd0ZEJv3IjU+K+U5R1wbdh+gD2WUY
 20Wq6Nw7sZkQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10024"; a="187132570"
X-IronPort-AV: E=Sophos;i="5.83,296,1616482800"; 
   d="scan'208";a="187132570"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2021 03:48:14 -0700
IronPort-SDR: eEghCN/Qvia56WaoGh3LGi+jefvIHH1Kk8fQi7G0evpIAh7cBuF62uih7BxUW5iBA/D+5as8au
 couLtI9FV+IA==
X-IronPort-AV: E=Sophos;i="5.83,296,1616482800"; 
   d="scan'208";a="624148275"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2021 03:48:10 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lwMty-004ycA-BM; Thu, 24 Jun 2021 13:48:06 +0300
Date:   Thu, 24 Jun 2021 13:48:06 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Jia He <justin.he@arm.com>, Steven Rostedt <rostedt@goodmis.org>,
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
Message-ID: <YNRi5tZFjjpI2Fi3@smile.fi.intel.com>
References: <20210622140634.2436-1-justin.he@arm.com>
 <20210622140634.2436-2-justin.he@arm.com>
 <YNH1d0aAu1WRiua1@smile.fi.intel.com>
 <YNRP3QjSK8ayzCzC@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNRP3QjSK8ayzCzC@alley>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 24, 2021 at 11:26:53AM +0200, Petr Mladek wrote:
> On Tue 2021-06-22 17:36:39, Andy Shevchenko wrote:
> > On Tue, Jun 22, 2021 at 10:06:31PM +0800, Jia He wrote:
> > > This helper is similar to d_path() except that it doesn't take any
> > > seqlock/spinlock. It is typical for debugging purposes. Besides,
> > > an additional return value *prenpend_len* is used to get the full
> > > path length of the dentry, ingoring the tail '\0'.
> > > the full path length = end - buf - prepend_length - 1
> > 
> > Missed period at the end of sentence.
> > 
> > > Previously it will skip the prepend_name() loop at once in
> > > __prepen_path() when the buffer length is not enough or even negative.
> > > prepend_name_with_len() will get the full length of dentry name
> > > together with the parent recursively regardless of the buffer length.
> > 
> > > If someone invokes snprintf() with small but positive space,
> > > prepend_name_with_len() moves and copies the string partially.
> > > 
> > > More than that, kasprintf() will pass NULL _buf_ and _end_ as the
> > > parameters. Hence return at the very beginning with false in this case.
> > 
> > These two paragraphs are talking about printf() interface, while patch has
> > nothing to do with it. Please, rephrase in a way that it doesn't refer to the
> > particular callers. Better to mention them in the corresponding printf()
> > patch(es).
> 
> The two paragraphs are actually repeated in the 2nd
> patch. Unfortunately, they do not make sense there either because they
> comment code that is modified in this patch.
> 
> We could describe it here a generic way. For example:
> 
>   prepend_name_with_len() moves and copies the path when the given
>   buffer is not big enough. It cuts off the end of the path.
>   It returns immediately when there is no buffer at all.

Yes, that's my point, but sorry if I made it unclear.

-- 
With Best Regards,
Andy Shevchenko


