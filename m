Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8822F2EB6F0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Jan 2021 01:39:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbhAFAjC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Jan 2021 19:39:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727170AbhAFAjC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Jan 2021 19:39:02 -0500
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 840ECC061574;
        Tue,  5 Jan 2021 16:38:21 -0800 (PST)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kwwpv-007DLx-34; Wed, 06 Jan 2021 00:38:03 +0000
Date:   Wed, 6 Jan 2021 00:38:03 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Stephen Brennan <stephen.s.brennan@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>,
        Eric Biederman <ebiederm@xmission.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v4] proc: Allow pid_revalidate() during LOOKUP_RCU
Message-ID: <20210106003803.GA3579531@ZenIV.linux.org.uk>
References: <20210104232123.31378-1-stephen.s.brennan@oracle.com>
 <20210105055935.GT3579531@ZenIV.linux.org.uk>
 <20210105165005.GV3579531@ZenIV.linux.org.uk>
 <20210105195937.GX3579531@ZenIV.linux.org.uk>
 <87a6tnge5k.fsf@stepbren-lnx.us.oracle.com>
 <CAHC9VhQnQW8RvTzyb4MTAvGZ7b=AHJXS8PzD=egTcpdDz73Yzg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhQnQW8RvTzyb4MTAvGZ7b=AHJXS8PzD=egTcpdDz73Yzg@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 05, 2021 at 07:00:59PM -0500, Paul Moore wrote:

> > > Incidentally, LSM_AUDIT_DATA_DENTRY in mainline is *not* safe wrt
> > > rename() - for long-named dentries it is possible to get preempted
> > > in the middle of
> > >                 audit_log_untrustedstring(ab, a->u.dentry->d_name.name);
> > > and have the bugger renamed, with old name ending up freed.  The
> > > same goes for LSM_AUDIT_DATA_INODE...
> >
> > In the case of proc_pid_permission(), this preemption doesn't seem
> > possible. We have task_lock() (a spinlock) held by ptrace_may_access()
> > during this call, so preemption should be disabled:
> >
> > proc_pid_permission()
> >   has_pid_permissions()
> >     ptrace_may_access()
> >       task_lock()
> >       __ptrace_may_access()
> >       | security_ptrace_access_check()
> >       |   ptrace_access_check -> selinux_ptrace_access_check()
> >       |     avc_has_perm()

		... which does not hit either LSM_AUDIT_DATA_DENTRY nor
LSM_AUDIT_DATA_INODE.  It's really an unrelated issue.

> > preemption enabled). However, it seems like there's another issue here.
> > avc_audit() seems to imply that slow_avc_audit() would sleep:
> >
> > static inline int avc_audit(struct selinux_state *state,
> >                             u32 ssid, u32 tsid,
> >                             u16 tclass, u32 requested,
> >                             struct av_decision *avd,
> >                             int result,
> >                             struct common_audit_data *a,
> >                             int flags)
> > {
> >         u32 audited, denied;
> >         audited = avc_audit_required(requested, avd, result, 0, &denied);
> >         if (likely(!audited))
> >                 return 0;
> >         /* fall back to ref-walk if we have to generate audit */
> >         if (flags & MAY_NOT_BLOCK)
> >                 return -ECHILD;
> >         return slow_avc_audit(state, ssid, tsid, tclass,
> >                               requested, audited, denied, result,
> >                               a);
> > }
> >
> > If there are other cases in here where we might sleep, it would be a
> > problem to sleep with the task lock held, correct?

It can sleep - with LSM_AUDIT_DATA_INODE, which is precisely what
selinux_inode_permission() is hitting.

> I would expect the problem here to be the currently allocated audit
> buffer isn't large enough to hold the full audit record, in which case
> it will attempt to expand the buffer by a call to pskb_expand_head() -
> don't ask why audit buffers are skbs, it's awful - using a gfp flag
> that was established when the buffer was first created.  In this
> particular case it is GFP_ATOMIC|__GFP_NOWARN, which I believe should
> be safe in that it will not sleep on an allocation miss.
> 
> I need to go deal with dinner, so I can't trace the entire path at the
> moment, but I believe the potential audit buffer allocation is the
> main issue.

Nope.  dput() in dump_common_audit_data(), OTOH, is certainly not
safe.  OTTH, it's not really needed there - see vfs.git #work.audit
for (untested) turning that sucker non-blocking.  I hadn't tried
a followup that would get rid of the entire AVC_NONBLOCKING thing yet,
but I suspect that it should simplify the things in there nicely...
