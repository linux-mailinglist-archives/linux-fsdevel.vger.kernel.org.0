Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 457F717EC55
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Mar 2020 23:53:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbgCIWxL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Mar 2020 18:53:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45859 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727397AbgCIWxK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Mar 2020 18:53:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583794390;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2rI8BG2LwE/WAlwyan0GLFodPzv/0iZV/5EOQthjqaU=;
        b=DeV68icCbacGft4Dt+OxIDnxsuXVXE6ZXETMszsOqNUhIw/0L2ogdjaw/M2osDwj3bgtDm
        qWs6tFAvG6oZC28kKIW7Ek8YDyezDcfspCqoQl8aOgCVdJS8gfh3d9KjGSSv6gEz6s2RqS
        4hKelJ0uv59ay8kQ4evIG11xkqlSh18=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-341-0io6CmWXN42H4XZTVuBR1g-1; Mon, 09 Mar 2020 18:53:02 -0400
X-MC-Unique: 0io6CmWXN42H4XZTVuBR1g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1C654107ACC7;
        Mon,  9 Mar 2020 22:52:59 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-182.rdu2.redhat.com [10.10.120.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 55D9673892;
        Mon,  9 Mar 2020 22:52:54 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20200309200238.GB28467@miu.piliscsaba.redhat.com>
References: <20200309200238.GB28467@miu.piliscsaba.redhat.com> <158376244589.344135.12925590041630631412.stgit@warthog.procyon.org.uk>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     dhowells@redhat.com, torvalds@linux-foundation.org,
        viro@zeniv.linux.org.uk, Theodore Ts'o <tytso@mit.edu>,
        Stefan Metzmacher <metze@samba.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs@vger.kernel.org, linux-api@vger.kernel.org,
        raven@themaw.net, mszeredi@redhat.com, christian@brauner.io,
        jannh@google.com, darrick.wong@oracle.com, kzak@redhat.com,
        jlayton@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/14] VFS: Filesystem information [ver #18]
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <537181.1583794373.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Mon, 09 Mar 2020 22:52:53 +0000
Message-ID: <537182.1583794373@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Miklos Szeredi <miklos@szeredi.hu> wrote:

> >  (1) It can be targetted.  It makes it easy to query directly by path =
or
> >      fd, but can also query by mount ID or fscontext fd.  procfs and s=
ysfs
> >      cannot do three of these things easily.
> =

> See above: with the addition of open(path, O_PATH) it can do all of thes=
e.

That's a horrible interface.  To query a file by path, you have to do:

	fd =3D open(path, O_PATH);
	sprintf(procpath, "/proc/self/fdmount/%u/<attr>");
	fd2 =3D open(procpath, O_RDONLY);
	read(fd2, ...);
	close(fd2);
	close(fd);

See point (3) about efficiency also.  You're having to open *two* files.

> >  (2) Easier to provide LSM oversight.  Is the accessing process allowe=
d to
> >      query information pertinent to a particular file?
> =

> Not quite sure why this would be easier for a new ad-hoc interface than =
for
> the well established filesystem API.

You're right.  That's why fsinfo() uses standard pathwalk where possible,
e.g.:

	fsinfo(AT_FDCWD, "/path/to/file", ...);

or a fairly standard fd-querying interface:

	fsinfo(fd, "", { resolve_flags =3D RESOLVE_EMPTY_PATH },  ...);

to query an open file descriptor.  These are well-established filesystem A=
PIs.

Where I vary from this is allowing direct specification of a mount ID also=
,
with a special flag to say that's what I'm doing:

	fsinfo(AT_FDCWD, "23", { flags =3D FSINFO_QUERY_FLAGS_MOUNT },  ...);

> >  (7) Don't have to create/delete a bunch of sysfs/procfs nodes each ti=
me a
> >      mount happens or is removed - and since systemd makes much use of
> >      mount namespaces and mount propagation, this will create a lot of
> >      nodes.
> =

> This patch creates a single struct mountfs_entry per mount, which is 48b=
ytes.

fsinfo() doesn't create any.  Furthermore, it seems that mounts get multip=
lied
8-10 times by systemd - though, as you say, it's not necessarily a great d=
eal
of memory.

> Now onto the advantages of a filesystem based API:
> =

>  - immediately usable from all programming languages, including scripts

This is not true.  You can't open O_PATH from shell scripts, so you can't
query things by path that you can't or shouldn't open (dev file paths, for
example; symlinks).

I imagine you're thinking of something like:

	{
		id=3D`cat /proc/self/fdmount/5/parent_mount`
	} 5</my/path/to/my/file

but what if /my/path/to/my/file is actually /dev/foobar?

I've had a grep through the bash sources, but can't seem to find anywhere =
that
uses O_PATH.

>  - same goes for future extensions: no need to update libc, utils, langu=
age
>    bindings, strace, etc...

Applications and libraries using these attributes would have to change any=
way
to make use of additional information.

But it's not a good argument since you now have to have text parsers that
change over time.

David

