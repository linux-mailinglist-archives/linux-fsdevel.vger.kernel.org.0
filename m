Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3110166F5A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jul 2019 14:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbfGLM4P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Jul 2019 08:56:15 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:38082 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727096AbfGLM4P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Jul 2019 08:56:15 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hlv5c-0007Pc-Mt; Fri, 12 Jul 2019 12:55:52 +0000
Date:   Fri, 12 Jul 2019 13:55:52 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Christian Brauner <christian@brauner.io>,
        David Drysdale <drysdale@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, Tycho Andersen <tycho@tycho.ws>,
        Chanho Min <chanho.min@lge.com>,
        Oleg Nesterov <oleg@redhat.com>, Aleksa Sarai <asarai@suse.de>,
        containers@lists.linux-foundation.org, linux-alpha@vger.kernel.org,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH v9 05/10] namei: O_BENEATH-style path resolution flags
Message-ID: <20190712125552.GL17978@ZenIV.linux.org.uk>
References: <20190706145737.5299-1-cyphar@cyphar.com>
 <20190706145737.5299-6-cyphar@cyphar.com>
 <20190712043341.GI17978@ZenIV.linux.org.uk>
 <20190712105745.nruaftgeat6irhzr@yavin>
 <20190712123924.GK17978@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190712123924.GK17978@ZenIV.linux.org.uk>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 12, 2019 at 01:39:24PM +0100, Al Viro wrote:
> On Fri, Jul 12, 2019 at 08:57:45PM +1000, Aleksa Sarai wrote:
> 
> > > > @@ -2350,9 +2400,11 @@ static const char *path_init(struct nameidata *nd, unsigned flags)
> > > >  			s = ERR_PTR(error);
> > > >  		return s;
> > > >  	}
> > > > -	error = dirfd_path_init(nd);
> > > > -	if (unlikely(error))
> > > > -		return ERR_PTR(error);
> > > > +	if (likely(!nd->path.mnt)) {
> > > 
> > > Is that a weird way of saying "if we hadn't already called dirfd_path_init()"?
> > 
> > Yes. I did it to be more consistent with the other "have we got the
> > root" checks elsewhere. Is there another way you'd prefer I do it?
> 
> "Have we got the root" checks are inevitable evil; here you are making the
> control flow in a single function hard to follow.
> 
> I *think* what you are doing is
> 	absolute pathname, no LOOKUP_BENEATH:
> 		set_root
> 		error = nd_jump_root(nd)
> 	else
> 		error = dirfd_path_init(nd)
> 	return unlikely(error) ? ERR_PTR(error) : s;
> which should be a lot easier to follow (not to mention shorter), but I might
> be missing something in all of that.

PS: if that's what's going on, I would be tempted to turn the entire
path_init() part into this:
	if (flags & LOOKUP_BENEATH)
		while (*s == '/')
			s++;
in the very beginning (plus the handling of nd_jump_root() prototype
change, but that belongs with nd_jump_root() change itself, obviously).
Again, I might be missing something here...
