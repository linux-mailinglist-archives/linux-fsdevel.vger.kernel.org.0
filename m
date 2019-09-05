Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10649AA0AE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2019 12:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387675AbfIEK6u (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Sep 2019 06:58:50 -0400
Received: from merlin.infradead.org ([205.233.59.134]:44004 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732028AbfIEK6u (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Sep 2019 06:58:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+Sinl1C05/gcXMERfRM/CU0CjBg4xK+OsBSdZDx7CWA=; b=IjEDEzxQ6IOLkFjkqA8G4weVr
        2ix5c/aN4vGafnJXRf8rm/lgF5V/h8pr9d+f7e8f9OSp80GpF3zbO7SWy+3CyteSdnLqJ6Ic01Eck
        Qw45hjOn6CGILdH7NYdlX3QNlS6oBhbtjqOQIJ4pNdWA6KkcZlyOT+79D27wNXhjHRMhibB3VXOyP
        sAJWusCKmntCRiDFHFAB8StBwMoFAeeUSuWFHvMRXj5LbGacMCNuzaOlSVL9EYzyssCtUNWwPs/OK
        0uzjRDmNrV/qRN36OfkME7aOIHLiHj9z0OGY4db+OtNKgaMRhA1yiHliWNZazO5KpD60UvZM6wqyK
        PFVlbiYIA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i5pSc-00065U-Lb; Thu, 05 Sep 2019 10:57:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C8326303121;
        Thu,  5 Sep 2019 12:57:12 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B4C5529E3BB8C; Thu,  5 Sep 2019 12:57:49 +0200 (CEST)
Date:   Thu, 5 Sep 2019 12:57:49 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
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
        linux-xtensa@linux-xtensa.org, sparclinux@vger.kernel.org,
        patrick.bellasi@arm.com
Subject: Re: [PATCH v12 01/12] lib: introduce copy_struct_{to,from}_user
 helpers
Message-ID: <20190905105749.GW2386@hirez.programming.kicks-ass.net>
References: <20190904201933.10736-1-cyphar@cyphar.com>
 <20190904201933.10736-2-cyphar@cyphar.com>
 <20190905073205.GY2332@hirez.programming.kicks-ass.net>
 <20190905092622.tlb6nn3uisssdfbu@yavin.dot.cyphar.com>
 <20190905094305.GJ2349@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190905094305.GJ2349@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 05, 2019 at 11:43:05AM +0200, Peter Zijlstra wrote:
> On Thu, Sep 05, 2019 at 07:26:22PM +1000, Aleksa Sarai wrote:
> > On 2019-09-05, Peter Zijlstra <peterz@infradead.org> wrote:
> > > On Thu, Sep 05, 2019 at 06:19:22AM +1000, Aleksa Sarai wrote:
> > > > +/**
> > > > + * copy_struct_to_user: copy a struct to user space
> > > > + * @dst:   Destination address, in user space.
> > > > + * @usize: Size of @dst struct.
> > > > + * @src:   Source address, in kernel space.
> > > > + * @ksize: Size of @src struct.
> > > > + *
> > > > + * Copies a struct from kernel space to user space, in a way that guarantees
> > > > + * backwards-compatibility for struct syscall arguments (as long as future
> > > > + * struct extensions are made such that all new fields are *appended* to the
> > > > + * old struct, and zeroed-out new fields have the same meaning as the old
> > > > + * struct).
> > > > + *
> > > > + * @ksize is just sizeof(*dst), and @usize should've been passed by user space.
> > > > + * The recommended usage is something like the following:
> > > > + *
> > > > + *   SYSCALL_DEFINE2(foobar, struct foo __user *, uarg, size_t, usize)
> > > > + *   {
> > > > + *      int err;
> > > > + *      struct foo karg = {};
> > > > + *
> > > > + *      // do something with karg
> > > > + *
> > > > + *      err = copy_struct_to_user(uarg, usize, &karg, sizeof(karg));
> > > > + *      if (err)
> > > > + *        return err;
> > > > + *
> > > > + *      // ...
> > > > + *   }
> > > > + *
> > > > + * There are three cases to consider:
> > > > + *  * If @usize == @ksize, then it's copied verbatim.
> > > > + *  * If @usize < @ksize, then kernel space is "returning" a newer struct to an
> > > > + *    older user space. In order to avoid user space getting incomplete
> > > > + *    information (new fields might be important), all trailing bytes in @src
> > > > + *    (@ksize - @usize) must be zerored
> > > 
> > > s/zerored/zero/, right?
> > 
> > It should've been "zeroed".
> 
> That reads wrong to me; that way it reads like this function must take
> that action and zero out the 'rest'; which is just wrong.
> 
> This function must verify those bytes are zero, not make them zero.
> 
> > > >                                          , otherwise -EFBIG is returned.
> > > 
> > > 'Funny' that, copy_struct_from_user() below seems to use E2BIG.
> > 
> > This is a copy of the semantics that sched_[sg]etattr(2) uses -- E2BIG for
> > a "too big" struct passed to the kernel, and EFBIG for a "too big"
> > struct passed to user-space. I would personally have preferred EMSGSIZE
> > instead of EFBIG, but felt using the existing error codes would be less
> > confusing.
> 
> Sadly a recent commit:
> 
>   1251201c0d34 ("sched/core: Fix uclamp ABI bug, clean up and robustify sched_read_attr() ABI logic and code")
> 
> Made the situation even 'worse'.

And thinking more about things; I'm not convinced the above patch is
actually right.

Do we really want to simply truncate all the attributes of the task?

And should we not at least set sched_flags when there are non-default
clamp values applied?

See; that is I think the primary bug that had chrt failing; we tried to
publish the default clamp values as !0.
