Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ADBF343E8F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Mar 2021 11:57:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbhCVK5A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Mar 2021 06:57:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51951 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230439AbhCVK4i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Mar 2021 06:56:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616410598;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QWqNRl3St0myqfYb/YgoRI1vcQ7ggUTH0MpgdoanYXM=;
        b=Dx0WgpMK72PEo6sA0hWuOWE4QE6KMA/B7sSmIdR1trGTqvLTEUL06awviPnnyaMOO6+/9M
        DXuPWygiYOUtAUJQVpu9IDXpsX/O3VJvrtRYpOD05ehymOsg4vf55Gv9uFvli5m7JZFDyD
        D6hAIAIRsyKiaC0Y3n4w+d7IeoZN/xU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-552-FCLoq-t8N6KUPH3xmAXDmQ-1; Mon, 22 Mar 2021 06:56:36 -0400
X-MC-Unique: FCLoq-t8N6KUPH3xmAXDmQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 34BE081622;
        Mon, 22 Mar 2021 10:56:34 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-58.rdu2.redhat.com [10.10.112.58])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7152A54478;
        Mon, 22 Mar 2021 10:56:27 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20210321105309.GG3420@casper.infradead.org>
References: <20210321105309.GG3420@casper.infradead.org> <161539526152.286939.8589700175877370401.stgit@warthog.procyon.org.uk> <161539528910.286939.1252328699383291173.stgit@warthog.procyon.org.uk>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     dhowells@redhat.com, Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>, linux-mm@kvack.org,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@redhat.com>,
        David Wysochanski <dwysocha@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 02/28] mm: Add an unlock function for PG_private_2/PG_fscache
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1885295.1616410586.1@warthog.procyon.org.uk>
Date:   Mon, 22 Mar 2021 10:56:26 +0000
Message-ID: <1885296.1616410586@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> wrote:

> That also brings up that there is no set_page_private_2().  I think
> that's OK -- you only set PageFsCache() immediately after reading the
> page from the server.  But I feel this "unlock_page_private_2" is actually
> "clear_page_private_2" -- ie it's equivalent to writeback, not to lock.

How about I do the following:

 (1) Add set_page_private_2() or mark_page_private_2() to set the PG_fscache_2
     bit.  It could take a ref on the page here.

 (2) Rename unlock_page_private_2() to end_page_private_2().  It could drop
     the ref on the page here, but that then means I can't use
     pagevec_release().

 (3) Add wait_on_page_private_2() an analogue of wait_on_page_writeback()
     rather than wait_on_page_locked().

 (4) Provide fscache synonyms of the above.

David

