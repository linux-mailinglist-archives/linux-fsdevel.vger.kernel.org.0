Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87E5D233146
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jul 2020 13:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbgG3Lvn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jul 2020 07:51:43 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:35525 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727776AbgG3Lvn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jul 2020 07:51:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596109901;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=XbbtDAwlbqFbl9LRgvVvqdOJ/w6Qt8l6sHZuVLApgCc=;
        b=UQD1Ik9n7l+3El0T+pzDeBH8w19lUMPzS13CBg2x5ZpnPA+R0reEsiQB6LIt6P7Ckbkk2x
        2QeCLY0E54N9mE5t/5H86zz0c6LDSwM8yg8MQQdXyur1kxkO69em2IevcfBIDVDL2uJHXL
        zu90CuHOZXDO2eAuMgkFdV4OH7rtnVo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-446-lpsWJq8MMBO5dqJYqQQUdg-1; Thu, 30 Jul 2020 07:51:37 -0400
X-MC-Unique: lpsWJq8MMBO5dqJYqQQUdg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0FB6D79EDC;
        Thu, 30 Jul 2020 11:51:34 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-32.rdu2.redhat.com [10.10.112.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ABF8B10002CA;
        Thu, 30 Jul 2020 11:51:16 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
cc:     dhowells@redhat.com, Alexander Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@redhat.com>,
        Dave Wysochanski <dwysocha@redhat.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Upcoming: fscache rewrite
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <447451.1596109876.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Thu, 30 Jul 2020 12:51:16 +0100
Message-ID: <447452.1596109876@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus, Trond/Anna, Steve, Eric,

I have an fscache rewrite that I'm tempted to put in for the next merge
window:

	https://lore.kernel.org/linux-fsdevel/159465784033.1376674.18106463693989=
811037.stgit@warthog.procyon.org.uk/

It improves the code by:

 (*) Ripping out the stuff that uses page cache snooping and kernel_write(=
)
     and using kiocb instead.  This gives multiple wins: uses async DIO ra=
ther
     than snooping for updated pages and then copying them, less VM overhe=
ad.

 (*) Object management is also simplified, getting rid of the state machin=
e
     that was managing things and using a much simplified thread pool inst=
ead.

 (*) Object invalidation creates a tmpfile and diverts new activity to tha=
t so
     that it doesn't have to synchronise in-flight ADIO.

 (*) Using a bitmap stored in an xattr rather than using bmap to find out =
if
     a block is present in the cache.  Probing the backing filesystem's
     metadata to find out is not reliable in modern extent-based filesyste=
ms
     as them may insert or remove blocks of zeros.  Even SEEK_HOLE/SEEK_DA=
TA
     are problematic since they don't distinguish transparently inserted
     bridging.

I've provided a read helper that handles ->readpage, ->readpages, and
preparatory writes in ->write_begin.  Willy is looking at using this as a =
way
to roll his new ->readahead op out into filesystems.  A good chunk of this
will move into MM code.

The code is simpler, and this is nice too:

 67 files changed, 5947 insertions(+), 8294 deletions(-)

not including documentation changes, which I need to convert to rst format
yet.  That removes a whole bunch more lines.

But there are reasons you might not want to take it yet:

 (1) It starts off by disabling fscache support in all the filesystems tha=
t
     use it: afs, nfs, cifs, ceph and 9p.  I've taken care of afs, Dave
     Wysochanski has patches for nfs:

	https://lore.kernel.org/linux-nfs/1596031949-26793-1-git-send-email-dwyso=
cha@redhat.com/

     but they haven't been reviewed by Trond or Anna yet, and Jeff Layton =
has
     patches for ceph:

	https://marc.info/?l=3Dceph-devel&m=3D159541538914631&w=3D2

     and I've briefly discussed cifs with Steve, but nothing has started t=
here
     yet.  9p I've not looked at yet.

     Now, if we're okay for going a kernel release with 4/5 filesystems wi=
th
     caching disabled and then pushing the changes for individual filesyst=
ems
     through their respective trees, it might be easier.

     Unfortunately, I wasn't able to get together with Trond and Anna at L=
SF
     to discuss this.

 (2) The patched afs fs passed xfstests -g quick (unlike the upstream code
     that oopses pretty quickly with caching enabled).  Dave and Jeff's nf=
s
     and ceph code is getting close, but not quite there yet.

 (3) Al has objections to the ITER_MAPPING iov_iter type that I added

	https://lore.kernel.org/linux-fsdevel/20200719014436.GG2786714@ZenIV.linu=
x.org.uk/

     but note that iov_iter_for_each_range() is not actually used by anyth=
ing.

     However, Willy likes it and would prefer to make it ITER_XARRAY inste=
ad
     as he might be able to use it in other places, though there's an issu=
e
     where I'm calling find_get_pages_contig() which takes a mapping (thou=
gh
     all it does is then get the xarray out of it).

     Instead I would have to use ITER_BVEC, which has quite a high overhea=
d,
     though it would mean that the RCU read lock wouldn't be necessary.  T=
his
     would require 1K of memory for every 256K block the cache wants to re=
ad;
     for any read >1M, I'd have to use vmalloc() instead.

     I'd also prefer not to use ITER_BVEC because the offset and length ar=
e
     superfluous here.  If ITER_MAPPING is not good, would it be possible =
to
     have an ITER_PAGEARRAY that just takes a page array instead?  Or, eve=
n,
     create a transient xarray?

 (4) The way object culling is managed needs overhauling too, but that's a
     whole 'nother patchset.  We could wait till that's done too, but its =
lack
     doesn't prevent what we have now being used.

Thoughts?

David

