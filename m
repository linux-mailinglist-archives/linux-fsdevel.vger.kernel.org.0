Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73ACEAAE8A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2019 00:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389873AbfIEWc3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Sep 2019 18:32:29 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:43054 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732639AbfIEWc2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Sep 2019 18:32:28 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.1 #3 (Red Hat Linux))
        id 1i60I9-0001pN-0U; Thu, 05 Sep 2019 22:31:49 +0000
Date:   Thu, 5 Sep 2019 23:31:48 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Jeff Layton <jlayton@kernel.org>,
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
Message-ID: <20190905223148.GS1131@ZenIV.linux.org.uk>
References: <20190904201933.10736-1-cyphar@cyphar.com>
 <20190904201933.10736-2-cyphar@cyphar.com>
 <20190905180750.GQ1131@ZenIV.linux.org.uk>
 <20190905182303.7f6bxpa2enbgcegv@wittgenstein>
 <20190905182801.GR1131@ZenIV.linux.org.uk>
 <20190905195618.pwzgvuzadkfpznfz@yavin.dot.cyphar.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190905195618.pwzgvuzadkfpznfz@yavin.dot.cyphar.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 06, 2019 at 05:56:18AM +1000, Aleksa Sarai wrote:
> On 2019-09-05, Al Viro <viro@zeniv.linux.org.uk> wrote:
> > On Thu, Sep 05, 2019 at 08:23:03PM +0200, Christian Brauner wrote:
> > 
> > > Because every caller of that function right now has that limit set
> > > anyway iirc. So we can either remove it from here and place it back for
> > > the individual callers or leave it in the helper.
> > > Also, I'm really asking, why not? Is it unreasonable to have an upper
> > > bound on the size (for a long time probably) or are you disagreeing with
> > > PAGE_SIZE being used? PAGE_SIZE limit is currently used by sched, perf,
> > > bpf, and clone3 and in a few other places.
> > 
> > For a primitive that can be safely used with any size (OK, any within
> > the usual 2Gb limit)?  Why push the random policy into the place where
> > it doesn't belong?
> > 
> > Seriously, what's the point?  If they want to have a large chunk of
> > userland memory zeroed or checked for non-zeroes - why would that
> > be a problem?
> 
> Thinking about it some more, there isn't really any r/w amplification --
> so there isn't much to gain by passing giant structs. Though, if we are
> going to permit 2GB buffers, isn't that also an argument to use
> memchr_inv()? :P

I'm not sure I understand the last bit.  If you look at what copy_from_user()
does on misaligned source/destination, especially on architectures that
really, really do not like unaligned access...

Case in point: alpha (and it's not unusual in that respect).  What it boils
down to is
	copy bytes until the destination is aligned
	if source and destination are both aligned
		copy word by word
	else
		read word by word, storing the mix of two adjacent words
	copy the rest byte by byte

The unpleasant case (to and from having different remainders modulo 8) is
basically

	if (count >= 8) {
		u64 *aligned = (u64 *)(from & ~7);
		u64 *dest = (u64 *)to;
		int bitshift = (from & 7) * 8;
		u64 prev, next;

		prev = aligned[0];
		do {   
			next = aligned[1];
			prev <<= bitshift;
			prev |= next >> (64 - bitshift);
			*dest++ = prev;
			aligned++;  
			prev = next;
			from += 8;
			to += 8;
			count -= 8;
		} while (count >= 8);
	}

Now, mix that with "... and do memchr_inv() on the copy to find if we'd
copied any non-zeroes, nevermind where" and it starts looking really
ridiculous.

We should just read the fscking source, aligned down to word boundary
and check each word being read.  The first and the last ones - masked.
All there is to it.  On almost all architectures that'll work well
enough; s390 might want something more elaborate (there even word-by-word
copies are costly, but I'd suggest talking to them for details).

Something like bool all_zeroes_user(const void __user *p, size_t count)
would probably be a sane API...
