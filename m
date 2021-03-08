Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E664330C63
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Mar 2021 12:29:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231560AbhCHL3V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Mar 2021 06:29:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24361 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231497AbhCHL2z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Mar 2021 06:28:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615202934;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fl2MWGAcY5BbmiIvDIGebdX2XvBppoO5EAECGMxonAU=;
        b=PQDt82oN3U5nk8arqCfMOogHueYwT6Xi6/Eck7fvb4ryjZ10jA4TbsuDBNQq8/7E3mSeNA
        gziK67NhgH8DrcxxZfa+e7gzZ/i+hdDH8YrHFMwZxVWAiMu/znRqUSat9oK/LDEIrKpDiL
        kQ7ofahCF6iX6w4jrpeByphOm8/UgFY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-251-HhcYaZeaNNCawHZ5I0Rf6A-1; Mon, 08 Mar 2021 06:28:52 -0500
X-MC-Unique: HhcYaZeaNNCawHZ5I0Rf6A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EBF5F1018F74;
        Mon,  8 Mar 2021 11:28:49 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-79.rdu2.redhat.com [10.10.112.79])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6BF3E5D756;
        Mon,  8 Mar 2021 11:28:42 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAOQ4uxjYWprb7trvamCx+DaP2yn8HCaZeZx1dSvPyFH2My303w@mail.gmail.com>
References: <CAOQ4uxjYWprb7trvamCx+DaP2yn8HCaZeZx1dSvPyFH2My303w@mail.gmail.com> <2653261.1614813611@warthog.procyon.org.uk> <CAOQ4uxhxwKHLT559f8v5aFTheKgPUndzGufg0E58rkEqa9oQ3Q@mail.gmail.com> <517184.1615194835@warthog.procyon.org.uk>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     dhowells@redhat.com, linux-cachefs@redhat.com,
        Jeff Layton <jlayton@redhat.com>,
        David Wysochanski <dwysocha@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <dchinner@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-afs@lists.infradead.org,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        ceph-devel <ceph-devel@vger.kernel.org>,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>
Subject: Metadata writtenback notification? -- was Re: fscache: Redesigning the on-disk cache
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <584528.1615202921.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Mon, 08 Mar 2021 11:28:41 +0000
Message-ID: <584529.1615202921@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Amir Goldstein <amir73il@gmail.com> wrote:

> > But after I've written and sync'd the data, I set the xattr to mark th=
e
> > file not open.  At the moment I'm doing this too lazily, only doing it
> > when a netfs file gets evicted or when the cache gets withdrawn, but I
> > really need to add a queue of objects to be sealed as they're closed. =
 The
> > balance is working out how often to do the sealing as something like a
> > shell script can do a lot of consecutive open/write/close ops.
> =

> You could add an internal vfs API wait_for_multiple_inodes_to_be_synced(=
).
> For example, xfs keeps the "LSN" on each inode, so once the transaction
> with some LSN has been committed, all the relevant inodes, if not dirty,=
 can
> be declared as synced, without having to call fsync() on any file and wi=
thout
> having to force transaction commit or any IO at all.
> =

> Since fscache takes care of submitting the IO, and it shouldn't care abo=
ut any
> specific time that the data/metadata hits the disk(?), you can make use =
of the
> existing periodic writeback and rolling transaction commit and only ever=
 need
> to wait for that to happen before marking cache files "closed".
> =

> There was a discussion about fsyncing a range of files on LSFMM [1].
> In the last comment on the article dchinner argues why we already have t=
hat
> API (and now also with io_uring(), but AFAIK, we do not have a useful
> wait_for_sync() API. And it doesn't need to be exposed to userspace at a=
ll.
> =

> [1] https://lwn.net/Articles/789024/

This sounds like an interesting idea.  Actually, what I probably want is a
notification to say that a particular object has been completely sync'd to
disk, metadata and all.

I'm not sure that io_uring is particularly usable from within the kernel,
though.

> If I were you, I would try to avoid re-implementing a journaled filesyst=
em or
> a database for fscache and try to make use of crash consistency guarante=
es
> that filesystems already provide.
> Namely, use the data dependency already provided by temp files.
> It doesn't need to be one temp file per cached file.
> =

> Always easier said than done ;-)

Yes.

There are a number of considerations I have to deal with, and they're some=
what
at odds with each other:

 (1) I need to record what data I have stored from a file.

 (2) I need to record where I stored the data.

 (3) I need to make sure that I don't see old data.

 (4) I need to make sure that I don't see data in the wrong file.

 (5) I need to make sure I lose as little as possible on a crash.

 (6) I want to be able to record what changes were made in the event we're
     disconnected from the server.

For my fscache-iter branch, (1) is done with a map in an xattr, but I only
cache up to 1G in a file at the moment; (2), (4) and, to some extent (5), =
are
handled by the backing fs; (3) is handled by tagging the file and storing
coherency data in in an xattr (though tmpfiles are used on full invalidati=
on).
(6) is not yet supported.

For upstream, (1), (2), (4) and to some extent (5) are handled through the
backing fs.  (3) is handled by storing coherency data in an xattr and
truncating the file on invalidation; (6) is not yet supported.

However, there are some performance problems are arising in my fscache-ite=
r
branch:

 (1) It's doing a lot of synchronous metadata operations (tmpfile, truncat=
e,
     setxattr).

 (2) It's retaining a lot of open file structs on cache files.  Cachefiles
     opens the file when it's first asked to access it and retains that ti=
ll
     the cookie is relinquished or the cache withdrawn (the file* doesn't
     contribute to ENFILE/EMFILE but it still eats memory).

     I can mitigate this by closing much sooner, perhaps opening the file =
for
     each operation - but at the cost of having to spend time doing more o=
pens
     and closes.  What's in upstream gets away without having to do open/c=
lose
     for reads because it calls readpage.

     Alternatively, I can have a background file closer - which requires a=
n
     LRU queue.  This could be combined with a file "sealer".

     Deferred writeback on the netfs starting writes to the cache makes th=
is
     more interesting as I have to retain the interest on the cache object
     beyond the netfs file being closed.

 (3) Trimming excess data from the end of the cache file.  The problem wit=
h
     using DIO to write to the cache is that the write has to be rounded u=
p to
     a multiple of the backing fs DIO blocksize, but if the file is trunca=
ted
     larger, that excess data now becomes part of the file.

     Possibly it's sufficient to just clear the excess page space before
     writing, but that doesn't necessarily stop a writable mmap from
     scribbling on it.

 (4) Committing outstanding cache metadata at cache withdrawal or netfs
     unmount.  I've previously mentioned this: it ends up with a whole sle=
w of
     synchronous metadata changes being committed to the cache in one go
     (truncates, fallocates, fsync, xattrs, unlink+link of tmpfile) - and =
this
     can take quite a long time.  The cache needs to be more proactive in
     getting stuff committed as it goes along.

 (5) Attaching to an object requires a pathwalk to it (normally only two
     steps) and then reading various xattrs on it - all synchronous, but c=
an
     be punted to a background threadpool.

Amongst the reasons I was considering moving to an index and a single data=
file
is to replace the path-lookup step for each object and the xattr reads to
looking in a single file and to reduce the number of open files in the cac=
he
at any one time to around four.

David

