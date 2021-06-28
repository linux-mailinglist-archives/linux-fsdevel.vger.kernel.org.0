Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 867073B5AE7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jun 2021 11:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232450AbhF1JJH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Jun 2021 05:09:07 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:56948 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232329AbhF1JJG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Jun 2021 05:09:06 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 210F020237;
        Mon, 28 Jun 2021 09:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1624871200; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BhGvCEpkVZywJS343m5vqWq8ImMUiwm2JU9sNziZH8c=;
        b=cSEN3S4EIkcrsvwhNFt7a4VDpxjrc8i9FT5YrYxVHEWuk9GaGNPwBD3FtmgWJzYrF6Qmgm
        /el2dxPFcWB/SGsQaaLbcjDoZZ7LZardysUkSyVXnlG+OUhbPG2nss3TXDEC4NvohvDxTR
        4cGXoGEO1EfwRFsZFn6Yrx4/DNLko+I=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id A626DA3B8E;
        Mon, 28 Jun 2021 09:06:39 +0000 (UTC)
Date:   Mon, 28 Jun 2021 11:06:39 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Justin He <Justin.He@arm.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Eric Biggers <ebiggers@google.com>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>, nd <nd@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 1/4] fs: introduce helper d_path_unsafe()
Message-ID: <YNmRH3K4j+ZadHVw@alley>
References: <20210623055011.22916-1-justin.he@arm.com>
 <20210623055011.22916-2-justin.he@arm.com>
 <AM6PR08MB43762FF7E76E4C7A0CD36314F7039@AM6PR08MB4376.eurprd08.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM6PR08MB43762FF7E76E4C7A0CD36314F7039@AM6PR08MB4376.eurprd08.prod.outlook.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 2021-06-28 05:13:51, Justin He wrote:
> Hi Andy, Petr
> 
> > -----Original Message-----
> > From: Jia He <justin.he@arm.com>
> > Sent: Wednesday, June 23, 2021 1:50 PM
> > To: Petr Mladek <pmladek@suse.com>; Steven Rostedt <rostedt@goodmis.org>;
> > Sergey Senozhatsky <senozhatsky@chromium.org>; Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com>; Rasmus Villemoes
> > <linux@rasmusvillemoes.dk>; Jonathan Corbet <corbet@lwn.net>; Alexander
> > Viro <viro@zeniv.linux.org.uk>; Linus Torvalds <torvalds@linux-
> > foundation.org>
> > Cc: Peter Zijlstra (Intel) <peterz@infradead.org>; Eric Biggers
> > <ebiggers@google.com>; Ahmed S. Darwish <a.darwish@linutronix.de>; linux-
> > doc@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> > fsdevel@vger.kernel.org; Matthew Wilcox <willy@infradead.org>; Christoph
> > Hellwig <hch@infradead.org>; nd <nd@arm.com>; Justin He <Justin.He@arm.com>
> > Subject: [PATCH v2 1/4] fs: introduce helper d_path_unsafe()
> > 
> > This helper is similar to d_path() except that it doesn't take any
> > seqlock/spinlock. It is typical for debugging purposes. Besides,
> > an additional return value *prenpend_len* is used to get the full
> > path length of the dentry, ingoring the tail '\0'.
> > the full path length = end - buf - prepend_length - 1.
> > 
> > Previously it will skip the prepend_name() loop at once in
> > __prepen_path() when the buffer length is not enough or even negative.
> > prepend_name_with_len() will get the full length of dentry name
> > together with the parent recursively regardless of the buffer length.
> > 
> > Suggested-by: Matthew Wilcox <willy@infradead.org>
> > Signed-off-by: Jia He <justin.he@arm.com>
> > ---
> >  fs/d_path.c            | 122 ++++++++++++++++++++++++++++++++++++++---
> >  include/linux/dcache.h |   1 +
> >  2 files changed, 116 insertions(+), 7 deletions(-)
> > 
> > diff --git a/fs/d_path.c b/fs/d_path.c
> > index 23a53f7b5c71..7a3ea88f8c5c 100644
> > --- a/fs/d_path.c
> > +++ b/fs/d_path.c
> > @@ -33,9 +33,8 @@ static void prepend(struct prepend_buffer *p, const char
> > *str, int namelen)
> > 
> >  /**
> >   * prepend_name - prepend a pathname in front of current buffer pointer
> > - * @buffer: buffer pointer
> > - * @buflen: allocated length of the buffer
> > - * @name:   name string and length qstr structure
> > + * @p: prepend buffer which contains buffer pointer and allocated length
> > + * @name: name string and length qstr structure
> >   *
> >   * With RCU path tracing, it may race with d_move(). Use READ_ONCE() to
> >   * make sure that either the old or the new name pointer and length are
> > @@ -68,9 +67,84 @@ static bool prepend_name(struct prepend_buffer *p,
> > const struct qstr *name)
> >  	return true;
> >  }
> > 
> > +/**
> > + * prepend_name_with_len - prepend a pathname in front of current buffer
> > + * pointer with limited orig_buflen.
> > + * @p: prepend buffer which contains buffer pointer and allocated length
> > + * @name: name string and length qstr structure
> > + * @orig_buflen: original length of the buffer
> > + *
> > + * p.ptr is updated each time when prepends dentry name and its parent.
> > + * Given the orginal buffer length might be less than name string, the
> > + * dentry name can be moved or truncated. Returns at once if !buf or
> > + * original length is not positive to avoid memory copy.
> > + *
> > + * Load acquire is needed to make sure that we see that terminating NUL,
> > + * which is similar to prepend_name().
> > + */
> > +static bool prepend_name_with_len(struct prepend_buffer *p,
> > +				  const struct qstr *name, int orig_buflen)
> > +{
> > +	const char *dname = smp_load_acquire(&name->name); /* ^^^ */
> > +	int dlen = READ_ONCE(name->len);
> > +	char *s;
> > +	int last_len = p->len;
> > +
> > +	p->len -= dlen + 1;
> > +
> > +	if (unlikely(!p->buf))
> > +		return false;
> > +
> > +	if (orig_buflen <= 0)
> > +		return false;
> > +
> > +	/*
> > +	 * The first time we overflow the buffer. Then fill the string
> > +	 * partially from the beginning
> > +	 */
> > +	if (unlikely(p->len < 0)) {
> > +		int buflen = strlen(p->buf);
> > +
> > +		/* memcpy src */
> > +		s = p->buf;
> > +
> > +		/* Still have small space to fill partially */
> > +		if (last_len > 0) {
> > +			p->buf -= last_len;
> > +			buflen += last_len;
> > +		}
> > +
> > +		if (buflen > dlen + 1) {
> > +			/* Dentry name can be fully filled */
> > +			memmove(p->buf + dlen + 1, s, buflen - dlen - 1);
> > +			p->buf[0] = '/';
> > +			memcpy(p->buf + 1, dname, dlen);
> > +		} else if (buflen > 0) {
> > +			/* Can be partially filled, and drop last dentry */
> > +			p->buf[0] = '/';
> > +			memcpy(p->buf + 1, dname, buflen - 1);
> > +		}
> > +
> > +		return false;
> > +	}
> > +
> > +	s = p->buf -= dlen + 1;
> > +	*s++ = '/';
> > +	while (dlen--) {
> > +		char c = *dname++;
> > +
> > +		if (!c)
> > +			break;
> > +		*s++ = c;
> > +	}
> > +	return true;
> > +}
> > +
> >  static int __prepend_path(const struct dentry *dentry, const struct mount
> > *mnt,
> >  			  const struct path *root, struct prepend_buffer *p)
> >  {
> > +	int orig_buflen = p->len;
> > +
> >  	while (dentry != root->dentry || &mnt->mnt != root->mnt) {
> >  		const struct dentry *parent = READ_ONCE(dentry->d_parent);
> > 
> > @@ -97,8 +171,7 @@ static int __prepend_path(const struct dentry *dentry,
> > const struct mount *mnt,
> >  			return 3;
> > 
> >  		prefetch(parent);
> > -		if (!prepend_name(p, &dentry->d_name))
> > -			break;
> > +		prepend_name_with_len(p, &dentry->d_name, orig_buflen);
> 
> I have new concern here.
> Previously,  __prepend_path() would break the loop at once when p.len<0.
> And the return value of __prepend_path() was 0.
> The caller of prepend_path() would typically check as follows:
>   if (prepend_path(...) > 0)
>   	do_sth();
> 
> After I replaced prepend_name() with prepend_name_with_len(),
> the return value of prepend_path() is possibly positive
> together with p.len<0. The behavior is different from previous.

I do not feel qualified to make decision here.I do not have enough
experience with this code.

Anyway, the new behavior looks correct to me. The return values
1, 2, 3 mean that there was something wrong with the path. The
new code checks the entire path which looks correct to me.

We only need to make sure that all callers handle this correctly.
Both __prepend_path() and prepend_path() are static so that
the scope is well defined.

If I did not miss something, all callers handle this correctly:

   + __d_patch() ignores buf when prepend_patch() > 0

   + d_absolute_path() and d_path() use extract_string(). It ignores
     the buffer when p->len < 0

   + SYSCALL_DEFINE2(getcwd, char __user *, buf, unsigned long, size)
     ignores the path as well. It is less obvious because it is done
     this way:

		len = PATH_MAX - b.len;
		if (unlikely(len > PATH_MAX))
			error = -ENAMETOOLONG;

     The condition (len > PATH_MAX) is true when b.len is negative.


Best Regards,
Petr
