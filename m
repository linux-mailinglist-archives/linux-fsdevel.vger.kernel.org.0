Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2E87AAFC0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2019 02:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391460AbfIFAPA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Sep 2019 20:15:00 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:44722 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391444AbfIFAPA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Sep 2019 20:15:00 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.1 #3 (Red Hat Linux))
        id 1i61tX-00047s-6A; Fri, 06 Sep 2019 00:14:31 +0000
Date:   Fri, 6 Sep 2019 01:14:31 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Christian Brauner <christian@brauner.io>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Eric Biederman <ebiederm@xmission.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, Tycho Andersen <tycho@tycho.ws>,
        David Drysdale <drysdale@google.com>,
        Chanho Min <chanho.min@lge.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Aleksa Sarai <asarai@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        containers@lists.linux-foundation.org, linux-alpha@vger.kernel.org,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH v12 01/12] lib: introduce copy_struct_{to,from}_user
 helpers
Message-ID: <20190906001431.GU1131@ZenIV.linux.org.uk>
References: <20190904201933.10736-1-cyphar@cyphar.com>
 <20190904201933.10736-2-cyphar@cyphar.com>
 <20190905180750.GQ1131@ZenIV.linux.org.uk>
 <20190905230003.bek7vqdvruzi4ybx@yavin.dot.cyphar.com>
 <20190905234944.GT1131@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190905234944.GT1131@ZenIV.linux.org.uk>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 06, 2019 at 12:49:44AM +0100, Al Viro wrote:
> On Fri, Sep 06, 2019 at 09:00:03AM +1000, Aleksa Sarai wrote:
> > > > +			return -EFAULT;
> > > > +	}
> > > > +	/* Copy the interoperable parts of the struct. */
> > > > +	if (__copy_to_user(dst, src, size))
> > > > +		return -EFAULT;
> > > 
> > > Why not simply clear_user() and copy_to_user()?
> > 
> > I'm not sure I understand what you mean -- are you asking why we need to
> > do memchr_inv(src + size, 0, rest) earlier?
> 
> I'm asking why bother with __ and separate access_ok().
> 
> > > 	if ((unsigned long)addr & 1) {
> > > 		u8 v;
> > > 		if (get_user(v, (__u8 __user *)addr))
> > > 			return -EFAULT;
> > > 		if (v)
> > > 			return -E2BIG;
> > > 		addr++;
> > > 	}
> > > 	if ((unsigned long)addr & 2) {
> > > 		u16 v;
> > > 		if (get_user(v, (__u16 __user *)addr))
> > > 			return -EFAULT;
> > > 		if (v)
> > > 			return -E2BIG;
> > > 		addr +=2;
> > > 	}
> > > 	if ((unsigned long)addr & 4) {
> > > 		u32 v;
> > > 		if (get_user(v, (__u32 __user *)addr))
> > > 			return -EFAULT;
> > > 		if (v)
> > > 			return -E2BIG;
> > > 	}
> > > 	<read the rest like you currently do>
> 
> Actually, this is a dumb way to do it - page size on anything
> is going to be a multiple of 8, so you could just as well
> read 8 bytes from an address aligned down.  Then mask the
> bytes you don't want to check out and see if there's anything
> left.
> 
> You can have readability boundaries inside a page - it's either
> the entire page (let alone a single word) being readable, or
> it's EFAULT for all parts.
> 
> > > would be saner, and things like x86 could trivially add an
> > > asm variant - it's not hard.  Incidentally, memchr_inv() is
> > > an overkill in this case...
> > 
> > Why is memchr_inv() overkill?
> 
> Look at its implementation; you only care if there are
> non-zeroes, you don't give a damn where in the buffer
> the first one would be.  All you need is the same logics
> as in "from userland" case
> 	if (!count)
> 		return true;
> 	offset = (unsigned long)from & 7
> 	p = (u64 *)(from - offset);
> 	v = *p++;
> 	if (offset) {	// unaligned
> 		count += offset;
> 		v &= ~aligned_byte_mask(offset); // see strnlen_user.c
> 	}
> 	while (count > 8) {
> 		if (v)
> 			return false;
> 		v = *p++;
> 		count -= 8;
> 	}
> 	if (count != 8)
> 		v &= aligned_byte_mask(count);
> 	return v == 0;
> 
> All there is to it...

... and __user case would be pretty much this with
	if (user_access_begin(from, count)) {
		....
		user_access_end();
	}
wrapped around the damn thing - again, see strnlen_user.c, with
	unsafe_get_user(v, p++, efault);
instead of those
	v = *p++;

Calling conventions might need some thinking - it might be
	* all read, all zeroes
	* non-zero found
	* read failed
so we probably want to map the "all zeroes" case to 0,
"read failed" to -EFAULT and "non-zero found" to something
else.  Might be positive, might be some other -E.... - not
sure if E2BIG (or EFBIG) makes much sense here.  Need to
look at the users...
