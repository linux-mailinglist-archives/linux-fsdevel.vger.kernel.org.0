Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66494148AD0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2020 15:59:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388476AbgAXO7C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jan 2020 09:59:02 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:51614 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387704AbgAXO7C (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jan 2020 09:59:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579877941;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BWoZ+zBogNKio10gnvI0VlupcEo0YcGdSxX1SnP4a38=;
        b=PHq9XK6AM8UwFKEvAg3ed2x61aMVG9IJxSrVJkK4/9x3YRc59XcpEw7PkEA1G0Vk+H+ArZ
        NR4cB3f9LP0Ssrg/rzyGiPBKz9ICo3fZeq0mN/Hu3h8eTBYqFVdq/n1ZUohMGh3BC7jqBb
        /DZYXMGZvebZD/djqcw0volzTsRVYPs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-22-hsJKDylHOVSmGyg0OUnwfA-1; Fri, 24 Jan 2020 09:58:53 -0500
X-MC-Unique: hsJKDylHOVSmGyg0OUnwfA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5C268DBE8;
        Fri, 24 Jan 2020 14:58:41 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-49.rdu2.redhat.com [10.10.120.49])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 932AF867E4;
        Fri, 24 Jan 2020 14:58:38 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20200124112109.GK4675@bombadil.infradead.org>
References: <20200124112109.GK4675@bombadil.infradead.org> <20200122193306.GB4675@bombadil.infradead.org> <3577430.1579705075@warthog.procyon.org.uk> <3785795.1579777499@warthog.procyon.org.uk>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     dhowells@redhat.com, Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] iov_iter: Add ITER_MAPPING
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <911589.1579877917.1@warthog.procyon.org.uk>
Date:   Fri, 24 Jan 2020 14:58:37 +0000
Message-ID: <911590.1579877917@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Okay, so this then?

#define iterate_mapping(i, n, __v, skip, STEP) {		\
	struct page *page;					\
	size_t wanted = n, seg, offset;				\
	loff_t start = i->mapping_start + skip;			\
	pgoff_t index = start >> PAGE_SHIFT;			\
								\
	XA_STATE(xas, &i->mapping->i_pages, index);		\
								\
	rcu_read_lock();						\
	for (page = xas_load(&xas); page; page = xas_next(&xas)) {	\
		if (xas_retry(&xas, page))				\
			continue;					\
		if (WARN_ON(xa_is_value(page)))				\
			break;						\
		if (WARN_ON(PageHuge(page)))				\
			break;						\
		__v.bv_page = find_subpage(page, xas.xa_index);		\
		offset = (i->mapping_start + skip) & ~PAGE_MASK;	\
		seg = PAGE_SIZE - offset;			\
		__v.bv_offset = offset;				\
		__v.bv_len = min(n, seg);			\
		(void)(STEP);					\
		n -= __v.bv_len;				\
		skip += __v.bv_len;				\
		if (n == 0)					\
			break;					\
	}							\
	rcu_read_unlock();					\
	n = wanted - n;						\
}

> We could also have an ITER_XARRAY which you just pass &mapping->i_pages
> to.  I don't think you use any other part of the mapping, so that would
> be a more generic version that is equally efficient.

I could give that a go.  Out of interest, are there any other users of xarray
that might use it that don't have a mapping handy?

David

