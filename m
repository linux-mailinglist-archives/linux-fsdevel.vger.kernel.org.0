Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47F4A14A81E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jan 2020 17:32:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbgA0Qcu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jan 2020 11:32:50 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:39176 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726173AbgA0Qct (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jan 2020 11:32:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580142768;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=acerTmkt9MrRw3hrdmoRuF2JZHiXd5F9RUaO+9oi+NM=;
        b=JLE84qwj2VfTcmLXSLV/40sJJmlaKyHHkPnfjZwXg5LHPWkXPtirvMGV2hrjK0+bC6WXrF
        TSPPROG0SWYJepolIOxRJSwe3kstgDxq73xhtglIKUIAvAsAzz8EV04J9a9XpQKGixLnyM
        XMuuS7s67v+VQddYN/4+tc4ie6bYhYo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-233-m-TBYEO8MYSG4Dy6f6lWHg-1; Mon, 27 Jan 2020 11:32:46 -0500
X-MC-Unique: m-TBYEO8MYSG4Dy6f6lWHg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 02F908010EC;
        Mon, 27 Jan 2020 16:32:45 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-99.rdu2.redhat.com [10.10.120.99])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9425886433;
        Mon, 27 Jan 2020 16:32:42 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAOQ4uxicFmiFKz7ZkHYuzduuTDaCTDqo26fo02-VjTMmQaaf+A@mail.gmail.com>
References: <CAOQ4uxicFmiFKz7ZkHYuzduuTDaCTDqo26fo02-VjTMmQaaf+A@mail.gmail.com> <14196.1575902815@warthog.procyon.org.uk> <CAOQ4uxj7RhrBnWb3Lqi3hHLuXNkVXrKio398_PAEczxfyW7HsA@mail.gmail.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     dhowells@redhat.com, lsf-pc@lists.linux-foundation.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jeff Layton <jlayton@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] How to make disconnected operation work?
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1477631.1580142761.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Mon, 27 Jan 2020 16:32:41 +0000
Message-ID: <1477632.1580142761@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Amir Goldstein <amir73il@gmail.com> wrote:

> My thinking is: Can't we implement a stackable cachefs which interfaces
> with fscache and whose API to the netfs is pure vfs APIs, just like
> overlayfs interfaces with lower fs?

In short, no - doing it with pure the VFS APIs that we have is not that si=
mple
(yes, Solaris does it with a stacking filesystem, and I don't know anythin=
g
about the API details, but there must be an auxiliary API).  You need to
handle:

 (1) Remote invalidation.  The netfs needs to tell the cache layer
     asynchronously about remote modifications - where the modification ca=
n
     modify not just file content but also directory structure, and even f=
ile
     data invalidation may be partial.

 (2) Unique file group matching.  The info required to match a group of fi=
les
     (e.g. an NFS server, an AFS volume, a CIFS share) is not necessarily
     available through the VFS API - I'm not sure even the export API make=
s
     this available since it's built on the assumption that it's exporting
     local files.

 (3) File matching.  The info required to match a file to the cache is not
     necessarily available through the VFS API.  NFS has file handles, for
     example; the YFS variant of AFS has 96-bit 'inode numbers'.  (This mi=
ght
     be done with the export API - it that's counted so).  Further, the fi=
le
     identifier may not be unique outside the file group.

 (4) Coherency management.  The netfs must tell the cache whether or not t=
he
     data contained in the cache is valid.  This information is not
     necessarily available through the VFS APIs (NFS change IDs, AFS data
     version, AFS volume sync info).  It's also highly filesystem specific=
.

It might also have security implications for netfs's that handle their own
security (such as AFS does), but that might fall out naturally.

> As long as netfs supports direct_IO() (all except afs do) then the activ=
e page
> cache could be that of the stackable cachefs and network IO is always
> direct from/to cachefs pages.

What about objects that don't support DIO?  Directories, symbolic links an=
d
automount points?  All of these things are cacheable objects with AFS.

And speaking of automount points - how would you deal with those beyond si=
mply
caching the contents?  Create a new stacked instance over it?  How do you =
see
the automount point itself?

I see that the NFS FH encoder doesn't handle automount points.

> If netfs supports export_operations (all except afs do), then indexing
> the cache objects could be done in a generic manner using fsid and
> file handle, just like overlayfs index feature works today.

FSID isn't unique and doesn't exist for all filesystems.  Two NFS servers,=
 for
example, can give you the same FSID, but referring to different things.  A=
FS
has a textual cell name and a volume ID that you need to combine; it doesn=
't
have an FSID.

This may work for overlayfs as the FSID can be confined to a particular
overlay.  However, that's not what we're dealing with.  We would be talkin=
g
about an index that potentially covers *all* the mounted netfs.

Also, from your description that sounds like a bug in overlayfs.  If the
overlain NFS tree does a referral to a different server, you no longer hav=
e a
unique FSID or a unique FH within that FSID so your index is broken.

> Would it not be a maintenance win if all (or most of) the fscache logic
> was yanked out of all the specific netfs's?

Actually, it may not help enormously with disconnected operation.  A certa=
in
amount of the logic probably has to be implemented in the netfs as each ne=
tfs
provides different facilities for managing this.

Yes, it gets some of the I/O stuff out - but I want to move some of that d=
own
into the VM if I can and librarifying the rest should take care of that.

> Can you think of reasons why the stackable cachefs model cannot work
> or why it is inferior to the current fscache integration model with netf=
s's?

Yes.  It's a lot more operationally expensive and it's harder to use.  The
cache driver would also have to get a lot bigger, but that would be
reasonable.

Firstly, the expense: you have to double up all the inodes and dentries th=
at
are in use - and that's not counting the resources used inside the cache
itself.

Secondly, the administration: I'm assuming you're suggesting the way I thi=
nk
Solaris does it and that you have to make two mounts: firstly you mount th=
e
netfs and then you mount the cache over it.  It's much simpler if you just
need make the netfs mount only and then that goes and uses the cache if it=
's
available - it's also simple to bring the cache online after the fact mean=
ing
you can even cache applied retroactively to a root filesystem.

You also have the issue of what happens if someone bind-mounts the netfs m=
ount
and mounts the cache over only one of the views.  Now you have a coherency
management problem that the cache cannot see.  It's only visible to the ne=
tfs,
but the netfs doesn't know about the cache.

There's also file locking.  Overlayfs doesn't support file locking that I =
can
see, but NFS, AFS and CIFS all do.


Anyway, you might be able to guess that I'm really against using stackable
filesystems for things like this and like UID shifting.  I think it adds m=
ore
expense and complexity than it's necessarily worth.

I was more inclined to go with unionfs than overlayfs and do the filesyste=
m
union in the VFS as it ought to be cheaper if you're using it (whereas
overlayfs is cheaper if you're not).

One final thing - even if we did want to switch to an stacked approach, we
might still have to maintain the current way as people use it.

David

