Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9EA5392A5F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 May 2021 11:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235675AbhE0JQF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 May 2021 05:16:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:42364 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235554AbhE0JQF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 May 2021 05:16:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1622106870; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wF0gVNjinmo0Hc0sps+4CX8PBKyxO99eUnpQyoVA9wM=;
        b=W/qOh1xTlNtrjaLmf+AL1hXvMsato1qiJBN2mBzHO0jBeKH7Ln3zzg/a9uaH3c8SswJ0j0
        HjRPf8OkDOVJjkaouS8NvT/SakvUPcG2WewQzWCLGc7Mw5XihX3wt/cCURrDdL3gGTMZA7
        F3d0KxnCtJlJ45Or6mhxloo6XWHvzJE=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 69D54AB71;
        Thu, 27 May 2021 09:14:30 +0000 (UTC)
Date:   Thu, 27 May 2021 11:14:29 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Justin He <Justin.He@arm.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@ftp.linux.org.uk>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Eric Biggers <ebiggers@google.com>, nd <nd@arm.com>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH RFC 2/3] lib/vsprintf.c: make %pD print full path for file
Message-ID: <YK9i9Y7LVTYgpad7@alley>
References: <20210508122530.1971-1-justin.he@arm.com>
 <20210508122530.1971-3-justin.he@arm.com>
 <YJkveb46BoFbXi0q@alley>
 <AM6PR08MB43764A5026A92DEF45EF8DBFF7239@AM6PR08MB4376.eurprd08.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM6PR08MB43764A5026A92DEF45EF8DBFF7239@AM6PR08MB4376.eurprd08.prod.outlook.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 2021-05-27 07:20:55, Justin He wrote:
> > > @@ -923,10 +924,17 @@ static noinline_for_stack
> > >  char *file_dentry_name(char *buf, char *end, const struct file *f,
> > >  			struct printf_spec spec, const char *fmt)
> > >  {
> > > +	const struct path *path = &f->f_path;
> > 
> > This dereferences @f before it is checked by check_pointer().
> > 
> > > +	char *p;
> > > +	char tmp[128];
> > > +
> > >  	if (check_pointer(&buf, end, f, spec))
> > >  		return buf;
> > >
> > > -	return dentry_name(buf, end, f->f_path.dentry, spec, fmt);
> > > +	p = d_path_fast(path, (char *)tmp, 128);
> > > +	buf = string(buf, end, p, spec);
> > 
> > Is 128 a limit of the path or just a compromise, please?
> > 
> > d_path_fast() limits the size of the buffer so we could use @buf
> > directly. We basically need to imitate what string_nocheck() does:
> > 
> >      + the length is limited by min(spec.precision, end-buf);
> >      + the string need to get shifted by widen_string()
> > 
> > We already do similar thing in dentry_name(). It might look like:
> > 
> > char *file_dentry_name(char *buf, char *end, const struct file *f,
> > 			struct printf_spec spec, const char *fmt)
> > {
> > 	const struct path *path;
> > 	int lim, len;
> > 	char *p;
> > 
> > 	if (check_pointer(&buf, end, f, spec))
> > 		return buf;
> > 
> > 	path = &f->f_path;
> > 	if (check_pointer(&buf, end, path, spec))
> > 		return buf;
> > 
> > 	lim = min(spec.precision, end - buf);
> > 	p = d_path_fast(path, buf, lim);
> 
> After further think about it, I prefer to choose pass stack space instead of _buf_.
> 
> vsnprintf() should return the size it requires after formatting the string.
> vprintk_store() will invoke 1st vsnprintf() will 8 bytes to get the reserve_size.
> Then invoke 2nd printk_sprint()->vscnprintf()->vsnprintf() to fill the space.
> 
> Hence end-buf is <0 in the 1st vsnprintf case.

Grr, you are right, I have completely missed this. I felt that there
must had been a catch but I did not see it.

> If I call d_path_fast(path, buf, lim) with _buf_ instead of stack space, the
> logic in prepend_name should be changed a lot. 
> 
> What do you think of it?

I wonder if vsprintf() could pass a bigger static buffer
when (str >= end). I would be safe if the dentry API only writes
to the buffer and does not depend on reading what has already
been written there. Then it will not matter that it is shared
between more vsprintf() callers.

It is a dirty hack. I do not have a good feeling about it. Of course,
a better solution would be when some dentry API just returns
the required size in this case.

Anyway, the buffer on stack would be more safe. It looks like a good
compromise. We could always improve it when it is not good enough in
the real life.

Best Regards,
Petr
