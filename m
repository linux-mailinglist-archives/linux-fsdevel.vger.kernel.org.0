Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D887418344
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Sep 2021 17:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240433AbhIYPi3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 25 Sep 2021 11:38:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44594 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237309AbhIYPi3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 25 Sep 2021 11:38:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632584214;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rLKZok9/4QFXX13m/PZ+MsuZ2LJ/FPI7EhWhls6THyQ=;
        b=L3afK9FboPCEl88uBnhnM+ByGUr2TQ+t91Dy4h4F4ckWKy9Nwml7lOBP7PKToBNnE8IEuw
        Ul8V4jenCH4wRjnrWBX5OUpAtX1a/5ZKGIin7il4PDqRqzAaajPrOtlksZ+575ctuNpB4I
        IfhBu7omh/PhklVih2oqs2WWySNxw40=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-78-dHhCQ_9FN4ypFdInzvUEcA-1; Sat, 25 Sep 2021 11:36:50 -0400
X-MC-Unique: dHhCQ_9FN4ypFdInzvUEcA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1A7CC814270;
        Sat, 25 Sep 2021 15:36:48 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.44])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A401D1000358;
        Sat, 25 Sep 2021 15:36:42 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <YU84rYOyyXDP3wjp@casper.infradead.org>
References: <YU84rYOyyXDP3wjp@casper.infradead.org> <163250387273.2330363.13240781819520072222.stgit@warthog.procyon.org.uk> <163250396319.2330363.10564506508011638258.stgit@warthog.procyon.org.uk>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     dhowells@redhat.com, hch@lst.de, trond.myklebust@primarydata.com,
        Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, darrick.wong@oracle.com,
        viro@zeniv.linux.org.uk, jlayton@kernel.org,
        torvalds@linux-foundation.org, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 9/9] mm: Remove swap BIO paths and only use DIO paths
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2396105.1632584202.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Sat, 25 Sep 2021 16:36:42 +0100
Message-ID: <2396106.1632584202@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> wrote:

> On Fri, Sep 24, 2021 at 06:19:23PM +0100, David Howells wrote:
> > Delete the BIO-generating swap read/write paths and always use ->swap_=
rw().
> > This puts the mapping layer in the filesystem.
> =

> Is SWP_FS_OPS now unused after this patch?

Ummm.  Interesting question - it's only used in swap_set_page_dirty():

int swap_set_page_dirty(struct page *page)
{
	struct swap_info_struct *sis =3D page_swap_info(page);

	if (data_race(sis->flags & SWP_FS_OPS)) {
		struct address_space *mapping =3D sis->swap_file->f_mapping;

		VM_BUG_ON_PAGE(!PageSwapCache(page), page);
		return mapping->a_ops->set_page_dirty(page);
	} else {
		return __set_page_dirty_no_writeback(page);
	}
}


> Also, do we still need ->swap_activate and ->swap_deactivate?

f2fs does quite a lot of work in its ->swap_activate(), as does btrfs.  I'=
m
not sure how necessary it is.  cifs looks like it intends to use it, but i=
t's
not fully implemented yet.  zonefs and nfs do some checking, including hol=
e
checking in nfs's case.  nfs also does some setting up for the sunrpc
transport.

btrfs, cifs, f2fs and nfs all supply ->swap_deactivate() to undo the effec=
ts
of the activation.

David

