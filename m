Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 025583B2B5B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jun 2021 11:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231752AbhFXJ3O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Jun 2021 05:29:14 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:59470 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbhFXJ3N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Jun 2021 05:29:13 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 0E5B11FD67;
        Thu, 24 Jun 2021 09:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1624526814; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RZyOP0C7F0XqPPPuvo2PjV5DVfUtOrFQsZ8R5CvApEg=;
        b=puUrylTGuwUK7U4t0meYfv/ls3Jneaz2guT1qMpP+itr7K9jYXbAFn6iv4Dfa4b24elcdf
        IKsOWMI1MPmcJsbaSit3TTUjwaldXaBlugSgATzAe41izPH8iRFB4wxWdgD+caLPj2w4UZ
        QG0p3exnzUZXxtnWgxyqq+qIfCyjadg=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 2EAA6A3BC5;
        Thu, 24 Jun 2021 09:26:51 +0000 (UTC)
Date:   Thu, 24 Jun 2021 11:26:53 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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
Message-ID: <YNRP3QjSK8ayzCzC@alley>
References: <20210622140634.2436-1-justin.he@arm.com>
 <20210622140634.2436-2-justin.he@arm.com>
 <YNH1d0aAu1WRiua1@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNH1d0aAu1WRiua1@smile.fi.intel.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 2021-06-22 17:36:39, Andy Shevchenko wrote:
> On Tue, Jun 22, 2021 at 10:06:31PM +0800, Jia He wrote:
> > This helper is similar to d_path() except that it doesn't take any
> > seqlock/spinlock. It is typical for debugging purposes. Besides,
> > an additional return value *prenpend_len* is used to get the full
> > path length of the dentry, ingoring the tail '\0'.
> > the full path length = end - buf - prepend_length - 1
> 
> Missed period at the end of sentence.
> 
> > Previously it will skip the prepend_name() loop at once in
> > __prepen_path() when the buffer length is not enough or even negative.
> > prepend_name_with_len() will get the full length of dentry name
> > together with the parent recursively regardless of the buffer length.
> 
> > If someone invokes snprintf() with small but positive space,
> > prepend_name_with_len() moves and copies the string partially.
> > 
> > More than that, kasprintf() will pass NULL _buf_ and _end_ as the
> > parameters. Hence return at the very beginning with false in this case.
> 
> These two paragraphs are talking about printf() interface, while patch has
> nothing to do with it. Please, rephrase in a way that it doesn't refer to the
> particular callers. Better to mention them in the corresponding printf()
> patch(es).

The two paragraphs are actually repeated in the 2nd
patch. Unfortunately, they do not make sense there either because they
comment code that is modified in this patch.

We could describe it here a generic way. For example:

  prepend_name_with_len() moves and copies the path when the given
  buffer is not big enough. It cuts off the end of the path.
  It returns immediately when there is no buffer at all.


Best Regards,
Petr
