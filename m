Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38B7518B19F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Mar 2020 11:37:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbgCSKht (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Mar 2020 06:37:49 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:59953 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727009AbgCSKht (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Mar 2020 06:37:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584614267;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CiofkCH/sv7+7rpU6YsJXFWeq/w+9dcTqMLo0EbVExc=;
        b=CK6NauoXI0Z63pckSz1EJg+hyCd+MygVolTHycTgOZr35DfTpEoCbe8AGdOOrgW6BAw9CK
        h3qfyyWJcHeT23ccKfmGyCAUSJYSSY6cci5KgryR4fpDcIKlgx+EcDRYwhB2QewLVzBe0V
        se9+mHy+sPggjiyAje65N7HtEB3cMes=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-285-cUdAiS5ZN1Sq4KuQlxE-7w-1; Thu, 19 Mar 2020 06:37:44 -0400
X-MC-Unique: cUdAiS5ZN1Sq4KuQlxE-7w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BBCD5107ACC4;
        Thu, 19 Mar 2020 10:37:41 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-113-126.rdu2.redhat.com [10.10.113.126])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C3A2117B91;
        Thu, 19 Mar 2020 10:37:37 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAJfpeguaiicjS2StY5m=8H7BCjq6PLxMsWE3Mx_jYR1foDWVTg@mail.gmail.com>
References: <CAJfpeguaiicjS2StY5m=8H7BCjq6PLxMsWE3Mx_jYR1foDWVTg@mail.gmail.com> <158454408854.2864823.5910520544515668590.stgit@warthog.procyon.org.uk>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     dhowells@redhat.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux NFS list <linux-nfs@vger.kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Linux API <linux-api@vger.kernel.org>,
        linux-ext4@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Ian Kent <raven@themaw.net>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Karel Zak <kzak@redhat.com>, Jeff Layton <jlayton@redhat.com>,
        linux-fsdevel@vger.kernel.org,
        LSM <linux-security-module@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/13] VFS: Filesystem information [ver #19]
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3085879.1584614257.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Thu, 19 Mar 2020 10:37:37 +0000
Message-ID: <3085880.1584614257@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Miklos Szeredi <miklos@szeredi.hu> wrote:

> >  (2) It's more efficient as we can return specific binary data rather =
than
> >      making huge text dumps.  Granted, sysfs and procfs could present =
the
> >      same data, though as lots of little files which have to be
> >      individually opened, read, closed and parsed.
> =

> Asked this a number of times, but you haven't answered yet:  what
> application would require such a high efficiency?

Low efficiency means more time doing this when that time could be spent do=
ing
other things - or even putting the CPU in a powersaving state.  Using an
open/read/close render-to-text-and-parse interface *will* be slower and le=
ss
efficient as there are more things you have to do to use it.

Then consider doing a walk over all the mounts in the case where there are
10000 of them - we have issues with /proc/mounts for such.  fsinfo() will =
end
up doing a lot less work.

> I strongly feel that mount info belongs in the latter category

I feel strongly that a lot of stuff done through /proc or /sys shouldn't b=
e.

Yes, it's nice that you can explore it with cat and poke it with echo, but=
 it
has a number of problems: security, atomiticity, efficiency and providing =
an
round-the-back way to pin stuff if not done right.

> >  (3) We wouldn't have the overhead of open and close (even adding a
> >      self-contained readfile() syscall has to do that internally
> =

> Busted: add f_op->readfile() and be done with all that.   For example
> DEFINE_SHOW_ATTRIBUTE() could be trivially moved to that interface.

Look at your example.  "f_op->".  That's "file->f_op->" I presume.

You would have to make it "i_op->" to avoid the open and the close - and f=
or
things like procfs and sysfs, that's probably entirely reasonable - but be=
ar
in mind that you still have to apply all the LSM file security controls, j=
ust
in case the backing filesystem is, say, ext4 rather than procfs.

> We could optimize existing proc, sys, etc. interfaces, but it's not
> been an issue, apparently.

You can't get rid of or change many of the existing interfaces.  A lot of =
them
are effectively indirect system calls and are, as such, part of the fixed
UAPI.  You'd have to add a parallel optimised set.

> >  (6) Don't have to create/delete a bunch of sysfs/procfs nodes each ti=
me a
> >      mount happens or is removed - and since systemd makes much use of
> >      mount namespaces and mount propagation, this will create a lot of
> >      nodes.
> =

> Not true.

This may not be true if you roll your own special filesystem.  It *is* tru=
e if
you do it in procfs or sysfs.  The files don't exist if you don't create n=
odes
or attribute tables for them.

> > The argument for doing this through procfs/sysfs/somemagicfs is that
> > someone using a shell can just query the magic files using ordinary te=
xt
> > tools, such as cat - and that has merit - but it doesn't solve the
> > query-by-pathname problem.
> >
> > The suggested way around the query-by-pathname problem is to open the
> > target file O_PATH and then look in a magic directory under procfs
> > corresponding to the fd number to see a set of attribute files[*] laid=
 out.
> > Bash, however, can't open by O_PATH or O_NOFOLLOW as things stand...
> =

> Bash doesn't have fsinfo(2) either, so that's not really a good argument=
.

I never claimed that fsinfo() could be accessed directly from the shell.  =
For
you proposal, you claimed "immediately usable from all programming languag=
es,
including scripts".

> Implementing a utility to show mount attribute(s) by path is trivial
> for the file based interface, while it would need to be updated for
> each extension of fsinfo(2).   Same goes for libc, language bindings,
> etc.

That's not precisely true.  If you aren't using an extension to an fsinfo(=
)
attribute, you wouldn't need to change anything[*].

If you want to use an extension - *even* through a file based interface - =
you
*would* have to change your code and your parser.

And, no, extending an fsinfo() attribute would not require any changes to =
libc
unless libc is using that attribute[*] and wants to access the extension.

[*] I assume that in C/C++ at least, you'd use linux/fsinfo.h rather than =
some
    libc version.

[*] statfs() could be emulated this way, but I'm not sure what else libc
    specifically is going to look at.  This is more aimed at libmount amon=
gst
    other things.

David

