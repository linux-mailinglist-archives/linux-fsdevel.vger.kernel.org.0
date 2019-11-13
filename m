Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFAA5FA6F9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2019 04:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbfKMDAS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Nov 2019 22:00:18 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:40158 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbfKMDAS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Nov 2019 22:00:18 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iUisf-0001fa-C2; Wed, 13 Nov 2019 02:59:41 +0000
Date:   Wed, 13 Nov 2019 02:59:41 +0000
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
        Christian Brauner <christian.brauner@ubuntu.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, Tycho Andersen <tycho@tycho.ws>,
        David Drysdale <drysdale@google.com>,
        Chanho Min <chanho.min@lge.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Aleksa Sarai <asarai@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        containers@lists.linux-foundation.org, linux-alpha@vger.kernel.org,
        linux-api@vger.kernel.org, libc-alpha@sourceware.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH v15 5/9] namei: LOOKUP_IN_ROOT: chroot-like scoped
 resolution
Message-ID: <20191113025941.GE26530@ZenIV.linux.org.uk>
References: <20191105090553.6350-1-cyphar@cyphar.com>
 <20191105090553.6350-6-cyphar@cyphar.com>
 <20191113020307.GB26530@ZenIV.linux.org.uk>
 <20191113024414.wlmvtjstpnkxa36n@yavin.dot.cyphar.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191113024414.wlmvtjstpnkxa36n@yavin.dot.cyphar.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 13, 2019 at 01:44:14PM +1100, Aleksa Sarai wrote:
> On 2019-11-13, Al Viro <viro@zeniv.linux.org.uk> wrote:
> > On Tue, Nov 05, 2019 at 08:05:49PM +1100, Aleksa Sarai wrote:
> > 
> > > @@ -2277,12 +2277,20 @@ static const char *path_init(struct nameidata *nd, unsigned flags)
> > >  
> > >  	nd->m_seq = read_seqbegin(&mount_lock);
> > >  
> > > -	/* Figure out the starting path and root (if needed). */
> > > -	if (*s == '/') {
> > > +	/* Absolute pathname -- fetch the root. */
> > > +	if (flags & LOOKUP_IN_ROOT) {
> > > +		/* With LOOKUP_IN_ROOT, act as a relative path. */
> > > +		while (*s == '/')
> > > +			s++;
> > 
> > Er...  Why bother skipping slashes?  I mean, not only link_path_walk()
> > will skip them just fine, you are actually risking breakage in this:
> >                 if (*s && unlikely(!d_can_lookup(dentry))) {
> >                         fdput(f);
> >                         return ERR_PTR(-ENOTDIR);
> >                 }
> > which is downstream from there with you patch, AFAICS.
> 
> I switched to stripping the slashes at your suggestion a few revisions
> ago[1], and had (wrongly) assumed we needed to handle "/" somehow in
> path_init(). But you're quite right about link_path_walk() -- and I'd be
> more than happy to drop it.

That, IIRC, was about untangling the weirdness around multiple calls of
dirfd_path_init() and basically went "we might want just strip the slashes
in case of that flag very early in the entire thing, so that later the
normal logics for absolute/relative would DTRT".  Since your check is
right next to checking for absolute pathnames (and not in the very
beginning of path_init()), we might as well turn the check for
absolute pathname into *s == '/' && !(flags & LOOKUP_IN_ROOT) and be
done with that.
