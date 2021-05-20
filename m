Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD66938B249
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 May 2021 16:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231687AbhETOzD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 May 2021 10:55:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:36254 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231418AbhETOzC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 May 2021 10:55:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1621522419; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=M8hqVgNQf+om50EjQbuWLvBSRMEEuDC2cfNombgOqIA=;
        b=tu3s2Wt5SshdfJXLmnHlL4WqWSI4s+yOHxwVBO4l8aV+a3YzJBruqkUV3bF4j5FE9IDyuy
        2JUPeVuDHwqzd4A9WTnznq7MDD5VcKOZ/ITIsQ4H8/7u7mybX2h1kGP7EyoAx1VT+/0YXH
        N/slWUMzz91Dblog3HCzXN6c5mhMO7g=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9B812ABE8;
        Thu, 20 May 2021 14:53:39 +0000 (UTC)
Date:   Thu, 20 May 2021 16:53:38 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Justin He <Justin.He@arm.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jonathan Corbet <corbet@lwn.net>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Eric Biggers <ebiggers@google.com>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 08/14] d_path: make prepend_name() boolean
Message-ID: <YKZ38jOCZUlpiqTS@alley>
References: <YKRfI29BBnC255Vp@zeniv-ca.linux.org.uk>
 <20210519004901.3829541-1-viro@zeniv.linux.org.uk>
 <20210519004901.3829541-8-viro@zeniv.linux.org.uk>
 <AM6PR08MB4376607691168C132AB2F558F72A9@AM6PR08MB4376.eurprd08.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM6PR08MB4376607691168C132AB2F558F72A9@AM6PR08MB4376.eurprd08.prod.outlook.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 2021-05-20 09:12:34, Justin He wrote:
> Hi Al
> 
> > -----Original Message-----
> > From: Al Viro <viro@ftp.linux.org.uk> On Behalf Of Al Viro
> > Sent: Wednesday, May 19, 2021 8:49 AM
> > To: Linus Torvalds <torvalds@linux-foundation.org>
> > Cc: Justin He <Justin.He@arm.com>; Petr Mladek <pmladek@suse.com>; Steven
> > Rostedt <rostedt@goodmis.org>; Sergey Senozhatsky
> > <senozhatsky@chromium.org>; Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com>; Rasmus Villemoes
> > <linux@rasmusvillemoes.dk>; Jonathan Corbet <corbet@lwn.net>; Heiko
> > Carstens <hca@linux.ibm.com>; Vasily Gorbik <gor@linux.ibm.com>; Christian
> > Borntraeger <borntraeger@de.ibm.com>; Eric W . Biederman
> > <ebiederm@xmission.com>; Darrick J. Wong <darrick.wong@oracle.com>; Peter
> > Zijlstra (Intel) <peterz@infradead.org>; Ira Weiny <ira.weiny@intel.com>;
> > Eric Biggers <ebiggers@google.com>; Ahmed S. Darwish
> > <a.darwish@linutronix.de>; open list:DOCUMENTATION <linux-
> > doc@vger.kernel.org>; Linux Kernel Mailing List <linux-
> > kernel@vger.kernel.org>; linux-s390 <linux-s390@vger.kernel.org>; linux-
> > fsdevel <linux-fsdevel@vger.kernel.org>
> > Subject: [PATCH 08/14] d_path: make prepend_name() boolean
> >
> > It returns only 0 or -ENAMETOOLONG and both callers only check if
> > the result is negative.  Might as well return true on success and
> > false on failure...
> >
> > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> > ---
> >  fs/d_path.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/fs/d_path.c b/fs/d_path.c
> > index 327cc3744554..83db83446afd 100644
> > --- a/fs/d_path.c
> > +++ b/fs/d_path.c
> > @@ -34,15 +34,15 @@ static void prepend(char **buffer, int *buflen, const
> > char *str, int namelen)
> >   *
> >   * Load acquire is needed to make sure that we see that terminating NUL.
> >   */
> > -static int prepend_name(char **buffer, int *buflen, const struct qstr
> > *name)
> > +static bool prepend_name(char **buffer, int *buflen, const struct qstr
> > *name)
> >  {
> >       const char *dname = smp_load_acquire(&name->name); /* ^^^ */
> >       u32 dlen = READ_ONCE(name->len);
> >       char *p;
> >
> >       *buflen -= dlen + 1;
> > -     if (*buflen < 0)
> > -             return -ENAMETOOLONG;
> > +     if (unlikely(*buflen < 0))
> > +             return false;
> 
> I don't object to this patch itself.
> Just wonder whether we need to relax the check condition of "*buflen < 0" ?
> 
> Given that in vsnprintf code path, sometimes the *buflen is < 0.
> 
> Please see https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/lib/vsprintf.c#n2698

IMHO, the patch is fine. It is likely some misunderstanding.
The above link points to:

2693	str = buf;
2694	end = buf + size;
2695
2696	/* Make sure end is always >= buf */
2697	if (end < buf) {
2698		end = ((void *)-1);
2699		size = end - buf;
2700	}

"end" points right behind the end of the buffer. It is later
used instead of the buffer size. The above code handles a potential
overflow of "buf + size". I causes that "end" will be 0xffffffff
in case of the overflow.

That said. vsnprintf() returns the number of characters which would
be generated for the given input. But only the "size" is written.
This require copying the characters one by one.

It is useful to see how many characters were lost. But I am not sure
if this ever worked for the dentry functions.

Best Regards,
Petr
