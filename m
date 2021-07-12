Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93FFE3C5D20
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jul 2021 15:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbhGLNXr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jul 2021 09:23:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40945 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230187AbhGLNXq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jul 2021 09:23:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626096058;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lPbnClPcI3p3suga88iSzUoRbrrUHKr+tNs6YbPYxPg=;
        b=RUgN0Jxmo8CX0LdrpCI1iVCqWKaNPnwDF6rN8OkOEkO8N9Q0lpPBTTBE82rqMfWFZZzi1r
        kUHIoHybba9u3Un+A2x9M/lnP1EBD162/pXW9x1QeMSuSRY7ek9uvp6079i8oXulI4wyPv
        lgk6nY3h+zfHlw7IrcZIfjqh/uNE7pk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-516-4yt6oCxUNL-qZPYO4GUdUQ-1; Mon, 12 Jul 2021 09:20:56 -0400
X-MC-Unique: 4yt6oCxUNL-qZPYO4GUdUQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0600F1023F40;
        Mon, 12 Jul 2021 13:20:56 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-118-19.rdu2.redhat.com [10.10.118.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2ADD81971B;
        Mon, 12 Jul 2021 13:20:55 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAH2r5mvm5ZTyGmyuNzxWhc5ynb5LpjtdADtHVjFeF46Q5MUsFQ@mail.gmail.com>
References: <CAH2r5mvm5ZTyGmyuNzxWhc5ynb5LpjtdADtHVjFeF46Q5MUsFQ@mail.gmail.com>
To:     Steve French <smfrench@gmail.com>
Cc:     dhowells@redhat.com, CIFS <linux-cifs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: confusing fscache path
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3136370.1626096054.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Mon, 12 Jul 2021 14:20:54 +0100
Message-ID: <3136371.1626096054@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Steve French <smfrench@gmail.com> wrote:

> The path from fscache_uncache_all_inode_pages is:
>    fscache_uncache_all_inode_pages-->__fscache_uncache_all_inode_pages
> (line 132 of fs/fscache/page.c) -->__fscache_uncache_page (locks on
> line 1120 and then on line 1141 "goto done" without unlocking it)

This bit, you mean?

	if (TestClearPageFsCache(page) &&
	    object->cache->ops->uncache_page) {
		/* the cache backend releases the cookie lock */
		fscache_stat(&fscache_n_cop_uncache_page);
		object->cache->ops->uncache_page(object, page);
		fscache_stat_d(&fscache_n_cop_uncache_page);
		goto done;
	}

Note the comment.

Here's the unlock:

	void cachefiles_uncache_page(struct fscache_object *_object, struct page =
*page)
		__releases(&object->fscache.cookie->lock)
	{
		struct cachefiles_object *object;

		object =3D container_of(_object, struct cachefiles_object, fscache);

		_enter("%p,{%lu}", object, page->index);

		spin_unlock(&object->fscache.cookie->lock);
	}

David

