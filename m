Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC05242AA9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Aug 2020 15:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728038AbgHLNy4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Aug 2020 09:54:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54678 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727780AbgHLNy4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Aug 2020 09:54:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597240494;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1TkqhIHAzlrLj7I5xdhISZ7mj66OJ1mZ2fQ987mrYKM=;
        b=g/LYwh6tpsMyYnBcTk4BRCIhn3SxqTIrn/eFVvbrL2/CPbEYu1ke09jO//SbvMzg7Nkcb6
        4/engHAlnbjWC/Q0CVAQcAiJpnpxMTWyOzWyG+PBMm+zmsQI2WkgNdGvhQhzK0C0cDKim2
        agIEwTGZLe8y+r1nkJeyKwo4GvwRBMc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-222-LT3TPafRN1yp_5xqry4Ptg-1; Wed, 12 Aug 2020 09:54:52 -0400
X-MC-Unique: LT3TPafRN1yp_5xqry4Ptg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7C33291274;
        Wed, 12 Aug 2020 13:54:50 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-127.rdu2.redhat.com [10.10.120.127])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A17DF60BF3;
        Wed, 12 Aug 2020 13:54:47 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAHk-=wjzLmMRf=QG-n+1HnxWCx4KTQn9+OhVvUSJ=ZCQd6Y1WA@mail.gmail.com>
References: <CAHk-=wjzLmMRf=QG-n+1HnxWCx4KTQn9+OhVvUSJ=ZCQd6Y1WA@mail.gmail.com> <1842689.1596468469@warthog.procyon.org.uk> <1845353.1596469795@warthog.procyon.org.uk> <CAJfpegunY3fuxh486x9ysKtXbhTE0745ZCVHcaqs9Gww9RV2CQ@mail.gmail.com> <ac1f5e3406abc0af4cd08d818fe920a202a67586.camel@themaw.net> <CAJfpegu8omNZ613tLgUY7ukLV131tt7owR+JJ346Kombt79N0A@mail.gmail.com> <CAJfpegtNP8rQSS4Z14Ja4x-TOnejdhDRTsmmDD-Cccy2pkfVVw@mail.gmail.com> <20200811135419.GA1263716@miu.piliscsaba.redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dhowells@redhat.com, Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Karel Zak <kzak@redhat.com>,
        Jeff Layton <jlayton@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Christian Brauner <christian@brauner.io>,
        Lennart Poettering <lennart@poettering.net>,
        Linux API <linux-api@vger.kernel.org>,
        Ian Kent <raven@themaw.net>,
        LSM <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: file metadata via fs API (was: [GIT PULL] Filesystem Information)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <135550.1597240486.1@warthog.procyon.org.uk>
Date:   Wed, 12 Aug 2020 14:54:46 +0100
Message-ID: <135551.1597240486@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> wrote:

> IOW, if you do something more along the lines of
> 
>        fd = open(""foo/bar", O_PATH);
>        metadatafd = openat(fd, "metadataname", O_ALT);
> 
> it might be workable.

What is it going to walk through?  You need to end up with an inode and dentry
from somewhere.

It sounds like this would have to open up a procfs-like magic filesystem, and
walk into it.  But how would that actually work?  Would you create a new
superblock each time you do this, labelled with the starting object (say the
dentry for "foo/bar" in this case), and then walk from the root?

An alternative, maybe, could be to make a new dentry type, say, and include it
in the superblock of the object being queried - and let the filesystems deal
with it.  That would mean that non-dir dentries would then have virtual
children.  You could then even use this to implement resource forks...

Another alternative would be to note O_ALT and then skip pathwalk entirely,
but just use the name as a key to the attribute, creating an anonfd to read
it.  But then why use openat() at all?  You could instead do:

	metadatafd = openmeta(fd, "metadataname");

and save the page flag.  You could even merge the two opens and do:

	metadatafd = openmeta("foo/bar", "metadataname");

Why not even combine this with Miklos's readfile() idea:

	readmeta(AT_FDCWD, "foo/bar", "metadataname", buf, sizeof(buf));

and we're now down to one syscall and no fds and you don't even need a magic
filesystem to make it work.

There's another consideration too: Paths are not unique handles to mounts.
It's entirely possible to have colocated mounts.  We need to be able to query
all the mounts on a mountpoint.

David

