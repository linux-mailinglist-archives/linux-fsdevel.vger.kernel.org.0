Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2B44421668
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Oct 2021 20:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238549AbhJDS3Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Oct 2021 14:29:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44253 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238408AbhJDS3Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Oct 2021 14:29:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633372055;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BXPoHU6ns0CE8QSkfAtin/P5zZIxIbMWZfw6WB1a8eA=;
        b=Gd8nv1DiFvM8++3qUBRvqLxK6O9gpE69h8CzW8hFxCoI+8klHcV3oxdLdtEZ8G/m+iro39
        WBCPGnzjn/ii3vI0iJlmjUwgNH5x8r5L5xGMYhYecjEBxk14YvUwXbKbVgJvEco+pHHQ16
        AneTWBZpcBb3MM1/QQUriXdEj8lXb1E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-147-MaYLzM-vOM-wZ2hso8tqSQ-1; Mon, 04 Oct 2021 14:27:34 -0400
X-MC-Unique: MaYLzM-vOM-wZ2hso8tqSQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 135B584A5E5;
        Mon,  4 Oct 2021 18:27:33 +0000 (UTC)
Received: from madcap2.tricolour.ca (unknown [10.3.128.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 21D2319723;
        Mon,  4 Oct 2021 18:27:20 +0000 (UTC)
Date:   Mon, 4 Oct 2021 14:27:18 -0400
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Eric Paris <eparis@parisplace.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Paris <eparis@redhat.com>, linux-fsdevel@vger.kernel.org,
        Aleksa Sarai <cyphar@cyphar.com>
Subject: Re: [PATCH v4 3/3] audit: add OPENAT2 record to list how
Message-ID: <20211004182718.GE3977594@madcap2.tricolour.ca>
References: <cover.1621363275.git.rgb@redhat.com>
 <d23fbb89186754487850367224b060e26f9b7181.1621363275.git.rgb@redhat.com>
 <CAHC9VhQdzdpwUZEKxeV6VuMJpmGJHf-kXtYP8WMKLBhfLXL9xg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhQdzdpwUZEKxeV6VuMJpmGJHf-kXtYP8WMKLBhfLXL9xg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021-10-04 12:08, Paul Moore wrote:
> On Wed, May 19, 2021 at 4:02 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> >
> > Since the openat2(2) syscall uses a struct open_how pointer to communicate
> > its parameters they are not usefully recorded by the audit SYSCALL record's
> > four existing arguments.
> >
> > Add a new audit record type OPENAT2 that reports the parameters in its
> > third argument, struct open_how with fields oflag, mode and resolve.
> >
> > The new record in the context of an event would look like:
> > time->Wed Mar 17 16:28:53 2021
> > type=PROCTITLE msg=audit(1616012933.531:184): proctitle=73797363616C6C735F66696C652F6F70656E617432002F746D702F61756469742D7465737473756974652D737641440066696C652D6F70656E617432
> > type=PATH msg=audit(1616012933.531:184): item=1 name="file-openat2" inode=29 dev=00:1f mode=0100600 ouid=0 ogid=0 rdev=00:00 obj=unconfined_u:object_r:user_tmp_t:s0 nametype=CREATE cap_fp=0 cap_fi=0 cap_fe=0 cap_fver=0 cap_frootid=0
> > type=PATH msg=audit(1616012933.531:184): item=0 name="/root/rgb/git/audit-testsuite/tests" inode=25 dev=00:1f mode=040700 ouid=0 ogid=0 rdev=00:00 obj=unconfined_u:object_r:user_tmp_t:s0 nametype=PARENT cap_fp=0 cap_fi=0 cap_fe=0 cap_fver=0 cap_frootid=0
> > type=CWD msg=audit(1616012933.531:184): cwd="/root/rgb/git/audit-testsuite/tests"
> > type=OPENAT2 msg=audit(1616012933.531:184): oflag=0100302 mode=0600 resolve=0xa
> > type=SYSCALL msg=audit(1616012933.531:184): arch=c000003e syscall=437 success=yes exit=4 a0=3 a1=7ffe315f1c53 a2=7ffe315f1550 a3=18 items=2 ppid=528 pid=540 auid=0 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=ttyS0 ses=1 comm="openat2" exe="/root/rgb/git/audit-testsuite/tests/syscalls_file/openat2" subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 key="testsuite-1616012933-bjAUcEPO"
> >
> > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > Link: https://lore.kernel.org/r/d23fbb89186754487850367224b060e26f9b7181.1621363275.git.rgb@redhat.com
> > ---
> >  fs/open.c                  |  2 ++
> >  include/linux/audit.h      | 10 ++++++++++
> >  include/uapi/linux/audit.h |  1 +
> >  kernel/audit.h             |  2 ++
> >  kernel/auditsc.c           | 18 +++++++++++++++++-
> >  5 files changed, 32 insertions(+), 1 deletion(-)
> 
> ...
> 
> > diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
> > index cd2d8279a5e4..67aea2370c6d 100644
> > --- a/include/uapi/linux/audit.h
> > +++ b/include/uapi/linux/audit.h
> > @@ -118,6 +118,7 @@
> >  #define AUDIT_TIME_ADJNTPVAL   1333    /* NTP value adjustment */
> >  #define AUDIT_BPF              1334    /* BPF subsystem */
> >  #define AUDIT_EVENT_LISTENER   1335    /* Task joined multicast read socket */
> > +#define AUDIT_OPENAT2          1336    /* Record showing openat2 how args */
> 
> As a heads-up, I had to change the AUDIT_OPENAT2 value to 1337 as the
> 1336 value is already in use by AUDIT_URINGOP.  It wasn't caught
> during my initial build test as the LSM/audit io_uring patches are in
> selinux/next and not audit/next, it wasn't until the kernel-secnext
> build was merging everything for its test run that the collision
> occurred.  I'll be updating the audit/next tree with the new value
> shortly.

I was expecting a conflict, so thanks for the heads up, Paul.

Steve: This affects the audit userspace support for this patchset
previously published 2021-05-19 as:
	https://github.com/rgbriggs/audit-userspace/tree/ghau-openat2

The update is here:
	https://github.com/rgbriggs/audit-userspace/tree/ghau-openat2.v2

And a PR has been created:
	https://github.com/linux-audit/audit-userspace/pull/219

> paul moore

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635

