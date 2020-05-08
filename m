Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0631CB1EF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 May 2020 16:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727945AbgEHOkA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 May 2020 10:40:00 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:46523 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727911AbgEHOj7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 May 2020 10:39:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588948798;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hEKOJFeBe0XhjAsTACvee48OxZfeBzXxgNIQnHiBGQA=;
        b=Gl4lNuj7Ki9pavwxpT7H1K3PsTz9f9XvJI3PAsJqmdFwhxlzQJrrVkeWprMV/N67y4bQ8j
        Mt/W21+61NlFx5L5A01EcezdhZ2E+zJ2DzWuBm8tzlAeJx0aawbnTxdzJccdHHT+QhZrJE
        1DXe4LFBr1KhzSPKr06oPKYBS4DYP84=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-204-uSDcl7BqPWCt8KdWQCXcuA-1; Fri, 08 May 2020 10:39:54 -0400
X-MC-Unique: uSDcl7BqPWCt8KdWQCXcuA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2D86B464;
        Fri,  8 May 2020 14:39:52 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-118-225.rdu2.redhat.com [10.10.118.225])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 42DCE707A6;
        Fri,  8 May 2020 14:39:49 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <713141.1588775072@warthog.procyon.org.uk>
References: <713141.1588775072@warthog.procyon.org.uk> <20200506110942.GL16070@bombadil.infradead.org> <20200505115946.GF16070@bombadil.infradead.org> <158861203563.340223.7585359869938129395.stgit@warthog.procyon.org.uk> <158861253957.340223.7465334678444521655.stgit@warthog.procyon.org.uk> <683739.1588751878@warthog.procyon.org.uk>
Cc:     dhowells@redhat.com, Matthew Wilcox <willy@infradead.org>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Jeff Layton <jlayton@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 54/61] afs: Wait on PG_fscache before modifying/releasing a page
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1040570.1588948788.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Fri, 08 May 2020 15:39:48 +0100
Message-ID: <1040571.1588948788@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:

> ITER_MAPPING relies on the mapping to maintain the pointers to the pages=
 so
> that it can find them rather than being like ITER_BVEC where there's a
> separate list.
> =

> Truncate removes the pages from the mapping - at which point ITER_MAPPIN=
G can
> no longer find them.

It looks like ITER_MAPPING is fine with truncate, provided the invalidatio=
n
waits for the iterator to complete first:

	int truncate_inode_page(struct address_space *mapping, struct page *page)
	{
		VM_BUG_ON_PAGE(PageTail(page), page);

		if (page->mapping !=3D mapping)
			return -EIO;

		truncate_cleanup_page(mapping, page);
		delete_from_page_cache(page);
		return 0;
	}

In which case, ->invalidatepage() needs to wait for PG_fscache.

Similarly, it looks like ->releasepage() is fine, provided it waits for
PG_fscache also.

If I have to use ITER_BVEC, what's the advisability of using vmalloc() to
allocate the bio_vec array for a transient op?  Such an array can referenc=
e up
to 1MiB on a 64-bit machine with 4KiB non-compound pages if it only alloca=
tes
up to a single page.  I'm wondering what the teardown cost is, though, if =
all
the corresponding PTEs have to be erased from all CPUs.

David

