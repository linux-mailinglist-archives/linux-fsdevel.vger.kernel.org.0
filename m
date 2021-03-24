Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F10C73476D5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Mar 2021 12:11:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232072AbhCXLKs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Mar 2021 07:10:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43096 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231455AbhCXLKV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Mar 2021 07:10:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616584220;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2DNg0xv2HxdydFNzDyeZn0f3yeYvD0sRJV54oqKQbcQ=;
        b=QY9fUQRtOFfnwOQUgMqc66CG8/wW/D4RFSae7bSvD1ieKl/8dmMnOHA+47r5vhBoNRemvn
        OoPgQ5os6hDeN3R2FK1uWSyO1BRi+bKAFOcfWvzEWThuGAMZwpwbOlHBIM3QVFVf5ngnTu
        ZQzn7bg1zec0U3EvsXK9OAY/2oPqTys=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-458-O-23OW31PDCuIrwmZFrBzQ-1; Wed, 24 Mar 2021 07:10:13 -0400
X-MC-Unique: O-23OW31PDCuIrwmZFrBzQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5420887A82A;
        Wed, 24 Mar 2021 11:10:12 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-58.rdu2.redhat.com [10.10.112.58])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 857A87A8CB;
        Wed, 24 Mar 2021 11:10:11 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAOg9mSSEVE3PGs2E9ya5_B6dQkoH6n2wGAEW_wWSEvw0LurWuQ@mail.gmail.com>
References: <CAOg9mSSEVE3PGs2E9ya5_B6dQkoH6n2wGAEW_wWSEvw0LurWuQ@mail.gmail.com> <CAOg9mSTQ-zNKXQGBK9QEnwJCvwqh=zFLbLJZy-ibGZwLve4o0w@mail.gmail.com> <20210201130800.GP308988@casper.infradead.org> <CAOg9mSSd5ccoi1keeiRfkV+esekcQLxer9_1iZ-r9bQDjZLfBg@mail.gmail.com>
To:     Mike Marshall <hubcap@omnibond.com>
Cc:     dhowells@redhat.com, Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC PATCH v2] implement orangefs_readahead
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2884396.1616584210.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Wed, 24 Mar 2021 11:10:10 +0000
Message-ID: <2884397.1616584210@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Mike Marshall <hubcap@omnibond.com> wrote:

> /* allocate an array of bio_vecs. */
> bvs =3D kzalloc(npages * (sizeof(struct bio_vec)), GFP_KERNEL);
>

Better to use kcalloc() here as it has overflow checking.

> /* hook the bio_vecs to the pages. */
> for (i =3D 0; i < npages; i++) {
> bvs[i].bv_page =3D pages[i];
> bvs[i].bv_len =3D PAGE_SIZE;
> bvs[i].bv_offset =3D 0;
> }
> =

> iov_iter_bvec(&iter, READ, bvs, npages, npages * PAGE_SIZE);
> =

> /* read in the pages. */
> ret =3D wait_for_direct_io(ORANGEFS_IO_READ, inode, &offset, &iter,
> npages * PAGE_SIZE, inode->i_size, NULL, NULL, file);
> =

> /* clean up. */
> for (i =3D 0; i < npages; i++) {
> SetPageUptodate(bvs[i].bv_page);
> unlock_page(bvs[i].bv_page);
> put_page(bvs[i].bv_page);
> }
> kfree(pages);
> kfree(bvs);
> }

Could you try ITER_XARRAY instead of ITER_BVEC:

	https://lore.kernel.org/linux-fsdevel/161653786033.2770958.14154191921867=
463240.stgit@warthog.procyon.org.uk/T/#u

Setting the iterator looks like:

	iov_iter_xarray(&iter, READ, &mapping->i_pages,
			offset, npages * PAGE_SIZE);

The xarray iterator will handle THPs, but I'm not sure if bvecs will.

Cleanup afterwards would look something like:

	static void afs_file_read_done(struct afs_read *req)
	{
		struct afs_vnode *vnode =3D req->vnode;
		struct page *page;
		pgoff_t index =3D req->pos >> PAGE_SHIFT;
		pgoff_t last =3D index + req->nr_pages - 1;

		XA_STATE(xas, &vnode->vfs_inode.i_mapping->i_pages, index);

		if (iov_iter_count(req->iter) > 0) {
			/* The read was short - clear the excess buffer. */
			_debug("afterclear %zx %zx %llx/%llx",
			       req->iter->iov_offset,
			       iov_iter_count(req->iter),
			       req->actual_len, req->len);
			iov_iter_zero(iov_iter_count(req->iter), req->iter);
		}

		rcu_read_lock();
		xas_for_each(&xas, page, last) {
			page_endio(page, false, 0);
			put_page(page);
		}
		rcu_read_unlock();

		task_io_account_read(req->len);
		req->cleanup =3D NULL;
	}

David

