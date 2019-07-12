Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C90B966FB8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jul 2019 15:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbfGLNKg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Jul 2019 09:10:36 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:38300 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727059AbfGLNKg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Jul 2019 09:10:36 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hlvJN-0007n9-6P; Fri, 12 Jul 2019 13:10:05 +0000
Date:   Fri, 12 Jul 2019 14:10:05 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Eric Biederman <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, Tycho Andersen <tycho@tycho.ws>,
        David Drysdale <drysdale@google.com>,
        Chanho Min <chanho.min@lge.com>,
        Oleg Nesterov <oleg@redhat.com>, Aleksa Sarai <asarai@suse.de>,
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
Subject: Re: [PATCH v9 01/10] namei: obey trailing magic-link DAC permissions
Message-ID: <20190712131005.GM17978@ZenIV.linux.org.uk>
References: <20190706145737.5299-1-cyphar@cyphar.com>
 <20190706145737.5299-2-cyphar@cyphar.com>
 <20190712041454.GG17978@ZenIV.linux.org.uk>
 <20190712122017.xkowq2cjreylpotm@yavin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190712122017.xkowq2cjreylpotm@yavin>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 12, 2019 at 10:20:17PM +1000, Aleksa Sarai wrote:
> On 2019-07-12, Al Viro <viro@zeniv.linux.org.uk> wrote:
> > On Sun, Jul 07, 2019 at 12:57:28AM +1000, Aleksa Sarai wrote:
> > > @@ -514,7 +516,14 @@ static void set_nameidata(struct nameidata *p, int dfd, struct filename *name)
> > >  	p->stack = p->internal;
> > >  	p->dfd = dfd;
> > >  	p->name = name;
> > > -	p->total_link_count = old ? old->total_link_count : 0;
> > > +	p->total_link_count = 0;
> > > +	p->acc_mode = 0;
> > > +	p->opath_mask = FMODE_PATH_READ | FMODE_PATH_WRITE;
> > > +	if (old) {
> > > +		p->total_link_count = old->total_link_count;
> > > +		p->acc_mode = old->acc_mode;
> > > +		p->opath_mask = old->opath_mask;
> > > +	}
> > 
> > Huh?  Could somebody explain why traversals of NFS4 referrals should inherit
> > ->acc_mode and ->opath_mask?
> 
> I'll be honest -- I don't understand what set_nameidata() did so I just
> did what I thought would be an obvious change (to just copy the
> contents). I thought it was related to some aspect of the symlink stack
> handling.

No.  It's handling of (very rare) nested pathwalk.  The only case I can think
of is handling of NFS4 referrals - they are triggered by ->d_automount()
and include NFS4 mount.  Which does internal pathwalk of its own, to get
to the root of subtree being automounted.

NFS has its own recursion protection on that path (no deeper nesting than
one level of referral traversals), but there some nesting is inevitable;
we do get another nameidata instance on stack.  And for nd_jump_link() we
need to keep track of the innermost one.

For symlinks nothing of that sort happens - they are dealt with on the same
struct nameidata.  ->total_link_count copying is there for one reason only -
we want the total amount of symlinks traversed during the pathwalk (including
the referral processing, etc.) to count towards MAXSYMLINKS check.  It could've
been moved from nameidata to task_struct, but it's cheaper to handle it that
way.

Again, nesting is *rare*.

> In that case, should they both be set to 0 on set_nameidata()? This will
> mean that fd re-opening (or magic-link opening) through a
> set_nameidata() would always fail.

Huh?  set_nameidata() is done for *all* instances - it's pretty much the
constructor of that object (and restore_nameidata() - a destructor).
Everything goes through it.

And again, I'm not sure we want these fields in nameidata - IMO they belong
in open_flags.  Things like e.g. stat() don't need them at all.

Incidentally, O_PATH opening of symlinks combined with subsequent procfs
symlink traversals is worth testing - that's where the things get subtle
and that's where it's easy to get in trouble on modifications.
