Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E89243FDCD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Oct 2021 16:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231610AbhJ2OFs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Oct 2021 10:05:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27239 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229692AbhJ2OFr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Oct 2021 10:05:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635516198;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UAO5hlBNRIsi6HHTbgauN8V1YNxASqG4MUTjtXwDRGE=;
        b=Y8AmLnA+D2zkO7aTWrP+JbDv85yfqKC8fyV+oQ9lYVqBMvs0J7opiDGw88zZQI3kpDjqat
        G3UpyrkTEne77ij/KbM2yRrsDnJySI3fpFoPlxO0nJR/ELHUiOQuTgctTaSTKPqJefqUl9
        nFWFZWL1y/+LyO74V4kMzmw+qXKo/30=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-34-6oVbE3goM2C8LodwzHbb4Q-1; Fri, 29 Oct 2021 10:03:15 -0400
X-MC-Unique: 6oVbE3goM2C8LodwzHbb4Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C248236304;
        Fri, 29 Oct 2021 14:03:11 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5727F79452;
        Fri, 29 Oct 2021 14:02:37 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <163363944839.1980952.3311507543724895463.stgit@warthog.procyon.org.uk>
References: <163363944839.1980952.3311507543724895463.stgit@warthog.procyon.org.uk> <163363935000.1980952.15279841414072653108.stgit@warthog.procyon.org.uk>
Cc:     dhowells@redhat.com, Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        linux-cifs@vger.kernel.org, linux-cachefs@redhat.com,
        Jeff Layton <jlayton@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 07/10] cifs: (untested) Move to using the alternate fallback fscache I/O API
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1876664.1635516156.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Fri, 29 Oct 2021 15:02:36 +0100
Message-ID: <1876665.1635516156@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:

> Move cifs/smb to using the alternate fallback fscache I/O API instead of
> the old upstream I/O API as that is about to be deleted.  The alternate =
API
> will also be deleted at some point in the future as it's dangerous (as i=
s
> the old API) and can lead to data corruption if the backing filesystem c=
an
> insert/remove bridging blocks of zeros into its extent list[1].
> =

> The alternate API reads and writes pages synchronously, with the intenti=
on
> of allowing removal of the operation management framework and thence the
> object management framework from fscache.
> =

> The preferred change would be to use the netfs lib, but the new I/O API =
can
> be used directly.  It's just that as the cache now needs to track data f=
or
> itself, caching blocks may exceed page size...
> =

> Changes
> =3D=3D=3D=3D=3D=3D=3D
> ver #2:
>   - Changed "deprecated" to "fallback" in the new function names[2].

I've managed to test this now.  There was a bug in it, fixed by the follow=
ing
incremental change:

--- a/fs/cifs/fscache.h
+++ b/fs/cifs/fscache.h
@@ -75,7 +75,7 @@ static inline int cifs_readpage_from_fscache(struct inod=
e *inode,
 static inline void cifs_readpage_to_fscache(struct inode *inode,
 					    struct page *page)
 {
-	if (PageFsCache(page))
+	if (CIFS_I(inode)->fscache)
 		__cifs_readpage_to_fscache(inode, page);
 }
 =


It shouldn't be using PageFsCache() here.  That's only used to indicate th=
at
an async DIO is in progress on the page, but since we're using the synchro=
nous
fallback API, that should not happen.  Also, it's no longer used to indica=
te
that a page is being cached and trigger writeback that way.

David

