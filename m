Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12EE937F5C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2019 23:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728127AbfFFVRS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jun 2019 17:17:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44388 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727915AbfFFVRS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jun 2019 17:17:18 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CC70644BC4;
        Thu,  6 Jun 2019 21:17:15 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-173.rdu2.redhat.com [10.10.120.173])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 572707838F;
        Thu,  6 Jun 2019 21:17:07 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CALCETrVuNRPgEzv-XY4M9m6sEsCiRHxPenN_MpcMYc1h26vVwQ@mail.gmail.com>
References: <CALCETrVuNRPgEzv-XY4M9m6sEsCiRHxPenN_MpcMYc1h26vVwQ@mail.gmail.com> <b91710d8-cd2d-6b93-8619-130b9d15983d@tycho.nsa.gov> <155981411940.17513.7137844619951358374.stgit@warthog.procyon.org.uk> <3813.1559827003@warthog.procyon.org.uk> <8382af23-548c-f162-0e82-11e308049735@tycho.nsa.gov> <0eb007c5-b4a0-9384-d915-37b0e5a158bf@schaufler-ca.com> <c82052e5-ca11-67b5-965e-8f828081f31c@tycho.nsa.gov> <07e92045-2d80-8573-4d36-643deeaff9ec@schaufler-ca.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     dhowells@redhat.com, Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB list <linux-usb@vger.kernel.org>, raven@themaw.net,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-block@vger.kernel.org, keyrings@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>
Subject: Re: [RFC][PATCH 00/10] Mount, FS, Block and Keyrings notifications [ver #3]
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <23610.1559855827.1@warthog.procyon.org.uk>
Date:   Thu, 06 Jun 2019 22:17:07 +0100
Message-ID: <23611.1559855827@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Thu, 06 Jun 2019 21:17:17 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Andy Lutomirski <luto@kernel.org> wrote:

> > > You are allowing arbitrary information flow between T and W above.  Who
> > > cares about notifications?
> >
> > I do. If Watched object is /dev/null no data flow is possible.
> > There are many objects on a modern Linux system for which this
> > is true. Even if it's "just a file" the existence of one path
> > for data to flow does not justify ignoring the rules for other
> > data paths.
> 
> Aha!
> 
> Even ignoring security, writes to things like /dev/null should
> probably not trigger notifications to people who are watching
> /dev/null.  (There are probably lots of things like this: /dev/zero,
> /dev/urandom, etc.)

Even writes to /dev/null might generate access notifications; leastways,
vfs_read() will call fsnotify_access() afterwards on success.

Whether or not you can set marks on open device files is another matter.

> David, are there any notification types that have this issue in your
> patchset?  If so, is there a straightforward way to fix it?

I'm not sure what issue you're referring to specifically.  Do you mean whether
writes to device files generate notifications?

> Generically, it seems like maybe writes to device nodes shouldn't trigger
> notifications since, despite the fact that different openers of a device
> node share an inode, there isn't necessarily any connection between them.

With the notification types I have currently implemented, I don't even notice
any accesses to a device file unless:

 (1) Someone mounts over the top of one.

 (2) The access triggers an I/O error or device reset or causes the device to
     be attached or detached.

 (3) Wangling the device causes some other superblock event.

 (4) The driver calls request_key() and that creates a new key.

> Casey, if this is fixed in general, do you have another case where the
> right to write and the right to read do not imply the right to
> communicate?
> 
> > An analogy is that two processes with different UIDs can open a file,
> > but still can't signal each other.
> 
> What do you mean "signal"?  If two processes with different UIDs can
> open the same file for read and write, then they can communicate with
> each other in many ways.  For example, one can write to the file and
> the other can read it.  One can take locks and the other can read the
> lock state.  They can both map it and use any number of memory access
> side channels to communicate.  But, of course, they can't send each
> other signals with kill().
> 
> If, however, one of these processes is using some fancy mechanism
> (inotify, dnotify, kqueue, fanotify, whatever) to watch the file, and
> the other one writes it, then it seems inconsistent to lie to the
> watching process and say that the file wasn't written because some
> security policy has decided to allow the write, allow the read, but
> suppress this particular notification.  Hence my request for a real
> example: when would it make sense to do this?

Note that fanotify requires CAP_SYS_ADMIN, but inotify and dnotify do not.

dnotify is applied to an open file, so it might be usable on a chardev such as
/dev/null, say.

David
