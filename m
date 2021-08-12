Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 583573EA4FD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Aug 2021 14:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237578AbhHLM5i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Aug 2021 08:57:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31736 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237350AbhHLM5h (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Aug 2021 08:57:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628773031;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mCn72IsR7SruuxmCk9O65PvV6CJhIOfP9bZiMHWXYvw=;
        b=ZQZogHzwBT5ynmxHl8I9uMNBbuoXMjZxrkWq4Bue2OmTV5zf4F3VivT+KhpcQ9WyHoMM8a
        q7SnBhGg98hV7PgY5LdeNaKrif97Ven8R2RRGN5A8L3XiAqBMiAYQwdt7Io05h5xogMZ3W
        3uzzVj6miB4bKuZ8sIfWaV+gmHdtQi8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-391-hBfPyN1kPIaWh0iRWiHLJw-1; Thu, 12 Aug 2021 08:57:10 -0400
X-MC-Unique: hBfPyN1kPIaWh0iRWiHLJw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D465E8799EC;
        Thu, 12 Aug 2021 12:57:08 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.22.32.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C811060C05;
        Thu, 12 Aug 2021 12:57:06 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20210812122104.GB18532@lst.de>
References: <20210812122104.GB18532@lst.de> <162876946134.3068428.15475611190876694695.stgit@warthog.procyon.org.uk> <162876947840.3068428.12591293664586646085.stgit@warthog.procyon.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     dhowells@redhat.com, willy@infradead.org,
        trond.myklebust@primarydata.com, darrick.wong@oracle.com,
        jlayton@kernel.org, sfrench@samba.org,
        torvalds@linux-foundation.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm: Make swap_readpage() for SWP_FS_OPS use ->direct_IO() not ->readpage()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3085431.1628773025.1@warthog.procyon.org.uk>
Date:   Thu, 12 Aug 2021 13:57:05 +0100
Message-ID: <3085432.1628773025@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christoph Hellwig <hch@lst.de> wrote:

> On Thu, Aug 12, 2021 at 12:57:58PM +0100, David Howells wrote:
> > Make swap_readpage(), when accessing a swap file (SWP_FS_OPS) use
> > the ->direct_IO() method on the filesystem rather then ->readpage().
> 
> ->direct_IO is just a helper for ->read_iter and ->write_iter, so please
> don't call it directly.  It actually is slowly on its way out, with at
> at least all of the iomap implementations not using it, as well as various
> other file systems.

[Note that __swap_writepage() uses ->direct_IO().]

Calling ->write_iter is probably a bad idea here.  Imagine that it goes
through, say, generic_file_write_iter(), then __generic_file_write_iter() and
then generic_file_direct_write().  It adds a number of delays into the system,
including:

	- Taking the inode lock
	- Removing file privs
	- Cranking mtime, ctime, file version
	  - Doing mnt_want_write
	  - Setting the inode dirty
	- Waiting on pages in the range that are being written 
	- Walking over the pagecache to invalidate the range
	- Redoing the invalidation (can't be skipped since page 0 is pinned)

that we might want to skip as they'll end up being done for every page swapped
out.

> > +	ki = kzalloc(sizeof(*ki), GFP_KERNEL);
> > +	if (!ki)
> > +		return -ENOMEM;
> 
> for the synchronous case we could avoid this allocation and just use
> arguments on stack.

True.

David

