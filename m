Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9203CFBFD2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2019 06:44:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726030AbfKNFoy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Nov 2019 00:44:54 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:33296 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbfKNFox (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Nov 2019 00:44:53 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iV7v2-0000Ln-Fm; Thu, 14 Nov 2019 05:43:48 +0000
Date:   Thu, 14 Nov 2019 05:43:48 +0000
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
        David Drysdale <drysdale@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, Tycho Andersen <tycho@tycho.ws>,
        Chanho Min <chanho.min@lge.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Aleksa Sarai <asarai@suse.de>,
        containers@lists.linux-foundation.org, linux-alpha@vger.kernel.org,
        linux-api@vger.kernel.org, libc-alpha@sourceware.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH v15 3/9] namei: LOOKUP_NO_XDEV: block mountpoint crossing
Message-ID: <20191114054348.GH26530@ZenIV.linux.org.uk>
References: <20191105090553.6350-1-cyphar@cyphar.com>
 <20191105090553.6350-4-cyphar@cyphar.com>
 <20191113013630.GZ26530@ZenIV.linux.org.uk>
 <20191114044945.ldedzjrb4s7i7irr@yavin.dot.cyphar.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191114044945.ldedzjrb4s7i7irr@yavin.dot.cyphar.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 14, 2019 at 03:49:45PM +1100, Aleksa Sarai wrote:
> On 2019-11-13, Al Viro <viro@zeniv.linux.org.uk> wrote:
> > On Tue, Nov 05, 2019 at 08:05:47PM +1100, Aleksa Sarai wrote:
> > 
> > > @@ -862,6 +870,8 @@ static int nd_jump_root(struct nameidata *nd)
> > >  void nd_jump_link(struct path *path)
> > >  {
> > >  	struct nameidata *nd = current->nameidata;
> > > +
> > > +	nd->last_magiclink.same_mnt = (nd->path.mnt == path->mnt);
> > >  	path_put(&nd->path);
> > >  
> > >  	nd->path = *path;
> > > @@ -1082,6 +1092,10 @@ const char *get_link(struct nameidata *nd)
> > >  		if (nd->flags & LOOKUP_MAGICLINK_JUMPED) {
> > >  			if (unlikely(nd->flags & LOOKUP_NO_MAGICLINKS))
> > >  				return ERR_PTR(-ELOOP);
> > > +			if (unlikely(nd->flags & LOOKUP_NO_XDEV)) {
> > > +				if (!nd->last_magiclink.same_mnt)
> > > +					return ERR_PTR(-EXDEV);
> > > +			}
> > >  		}
> > 
> > Ugh...  Wouldn't it be better to take that logics (some equivalent thereof)
> > into nd_jump_link()?  Or just have nd_jump_link() return an error...
> 
> This could be done, but the reason for stashing it away in
> last_magiclink is because of the future magic-link re-opening patches
> which can't be implemented like that without putting the open_flags
> inside nameidata (which was decided to be too ugly a while ago).
> 
> My point being that I could implement it this way for this series, but
> I'd have to implement something like last_magiclink when I end up
> re-posting the magic-link stuff in a few weeks.
> 
> Looking at all the nd_jump_link() users, the other option is to just
> disallow magic-link crossings entirely for LOOKUP_NO_XDEV. The only
> thing allowing them permits is to resolve file descriptors that are
> pointing to the same procfs mount -- and it's unclear to me how useful
> that really is (apparmorfs and nsfs will always give -EXDEV because
> aafs_mnt and nsfs_mnt are internal kernel vfsmounts).

I would rather keep the entire if (nd->flags & LOOKUP_MAGICLINK_JUMPED)
out of the get_link().  If you want to generate some error if
nd_jump_link() has been called, just do it right there.  The fewer
pieces of state need to be carried around, the better...

And as for opening them...  Why would you need full open_flags in there?
Details, please...
