Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4AF3390472
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 May 2021 17:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234209AbhEYPCi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 May 2021 11:02:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28333 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234207AbhEYPCg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 May 2021 11:02:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621954866;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qc1y1QTC1cV947c5otyGJ64D+/LIRnXVey8bVzJq2lY=;
        b=OQf0pFZV6KKtHlqnYg/nXanPw4j7cigK80IeMny1Cb9Z9yohyZYSFlDqAm42p+2SFrct+H
        MNgGp4HHsNzpjuEBHe24hkEan3Uk0PcTIn51JuHGKeMRr+yl1TqhIfBp0rt1uYlxqlOTGn
        fPmhQOMnST5To7cNqVGGKiLDsTSDp3c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-384-KveZ0Jg6Pfqxjnx6-SlhZQ-1; Tue, 25 May 2021 11:00:55 -0400
X-MC-Unique: KveZ0Jg6Pfqxjnx6-SlhZQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 163B0C7440;
        Tue, 25 May 2021 15:00:54 +0000 (UTC)
Received: from madcap2.tricolour.ca (unknown [10.3.128.13])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5CB2E60CEB;
        Tue, 25 May 2021 15:00:41 +0000 (UTC)
Date:   Tue, 25 May 2021 11:00:38 -0400
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Eric Paris <eparis@parisplace.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Paris <eparis@redhat.com>, linux-fsdevel@vger.kernel.org,
        Aleksa Sarai <cyphar@cyphar.com>
Subject: Re: [PATCH v4 3/3] audit: add OPENAT2 record to list how
Message-ID: <20210525150038.GF2268484@madcap2.tricolour.ca>
References: <cover.1621363275.git.rgb@redhat.com>
 <d23fbb89186754487850367224b060e26f9b7181.1621363275.git.rgb@redhat.com>
 <20210520080318.owvsvvhh5qdhyzhk@wittgenstein>
 <CAHC9VhRmhtheudAjGyumunC5zfHMVjuuBvjXNZzYEByTJQRt9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhRmhtheudAjGyumunC5zfHMVjuuBvjXNZzYEByTJQRt9g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021-05-24 19:08, Paul Moore wrote:
> On Thu, May 20, 2021 at 4:03 AM Christian Brauner
> <christian.brauner@ubuntu.com> wrote:
> > On Wed, May 19, 2021 at 04:00:22PM -0400, Richard Guy Briggs wrote:
> > > Since the openat2(2) syscall uses a struct open_how pointer to communicate
> > > its parameters they are not usefully recorded by the audit SYSCALL record's
> > > four existing arguments.
> > >
> > > Add a new audit record type OPENAT2 that reports the parameters in its
> > > third argument, struct open_how with fields oflag, mode and resolve.
> > >
> > > The new record in the context of an event would look like:
> > > time->Wed Mar 17 16:28:53 2021
> > > type=PROCTITLE msg=audit(1616012933.531:184): proctitle=73797363616C6C735F66696C652F6F70656E617432002F746D702F61756469742D7465737473756974652D737641440066696C652D6F70656E617432
> > > type=PATH msg=audit(1616012933.531:184): item=1 name="file-openat2" inode=29 dev=00:1f mode=0100600 ouid=0 ogid=0 rdev=00:00 obj=unconfined_u:object_r:user_tmp_t:s0 nametype=CREATE cap_fp=0 cap_fi=0 cap_fe=0 cap_fver=0 cap_frootid=0
> > > type=PATH msg=audit(1616012933.531:184): item=0 name="/root/rgb/git/audit-testsuite/tests" inode=25 dev=00:1f mode=040700 ouid=0 ogid=0 rdev=00:00 obj=unconfined_u:object_r:user_tmp_t:s0 nametype=PARENT cap_fp=0 cap_fi=0 cap_fe=0 cap_fver=0 cap_frootid=0
> > > type=CWD msg=audit(1616012933.531:184): cwd="/root/rgb/git/audit-testsuite/tests"
> > > type=OPENAT2 msg=audit(1616012933.531:184): oflag=0100302 mode=0600 resolve=0xa
> > > type=SYSCALL msg=audit(1616012933.531:184): arch=c000003e syscall=437 success=yes exit=4 a0=3 a1=7ffe315f1c53 a2=7ffe315f1550 a3=18 items=2 ppid=528 pid=540 auid=0 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=ttyS0 ses=1 comm="openat2" exe="/root/rgb/git/audit-testsuite/tests/syscalls_file/openat2" subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 key="testsuite-1616012933-bjAUcEPO"
> > >
> > > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > > Link: https://lore.kernel.org/r/d23fbb89186754487850367224b060e26f9b7181.1621363275.git.rgb@redhat.com
> > > ---
> > >  fs/open.c                  |  2 ++
> > >  include/linux/audit.h      | 10 ++++++++++
> > >  include/uapi/linux/audit.h |  1 +
> > >  kernel/audit.h             |  2 ++
> > >  kernel/auditsc.c           | 18 +++++++++++++++++-
> > >  5 files changed, 32 insertions(+), 1 deletion(-)
> 
> ...
> 
> > > diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> > > index 3f59ab209dfd..faf2485323a9 100644
> > > --- a/kernel/auditsc.c
> > > +++ b/kernel/auditsc.c
> > > @@ -76,7 +76,7 @@
> > >  #include <linux/fsnotify_backend.h>
> > >  #include <uapi/linux/limits.h>
> > >  #include <uapi/linux/netfilter/nf_tables.h>
> > > -#include <uapi/linux/openat2.h>
> > > +#include <uapi/linux/openat2.h> // struct open_how
> > >
> > >  #include "audit.h"
> > >
> > > @@ -1319,6 +1319,12 @@ static void show_special(struct audit_context *context, int *call_panic)
> > >               audit_log_format(ab, "fd=%d flags=0x%x", context->mmap.fd,
> > >                                context->mmap.flags);
> > >               break;
> > > +     case AUDIT_OPENAT2:
> > > +             audit_log_format(ab, "oflag=0%llo mode=0%llo resolve=0x%llx",
> >
> > Hm, should we maybe follow the struct member names for all entries, i.e.
> > replace s/oflag/flags?
> 
> There is some precedence for using "oflags" to refer to "open" flags,
> my guess is Richard is trying to be consistent here.  I agree it's a
> little odd, but it looks like the right thing to me from an audit
> perspective; the audit perspective is a little odd after all :)

Thanks Paul.

I could have sworn I had a conversation with someone about this but I
can't find any of that evidence otherwise I'd paste it here.

With the help of our audit field dictionary we have some guidance of
what these new field names should be:
	https://github.com/linux-audit/audit-documentation/blob/main/specs/fields/field-dictionary.csv

The "flags" field is used for the mmap record (coincidentally in the
context diff), so should not be used here because it will cause issues
in the userspace parser.  The open syscall flags are listed with
"oflag".  Other flag fields are named after their domain.

The value field has a precedence of "val" that is not associated with
any particular domain and is alphanumeric.  Other value fields take the
name of their domain, so that was a possibility.

"resolve" would be a new field for which I have a note to add it to this
document if the patch is accepted.

> paul moore

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635

