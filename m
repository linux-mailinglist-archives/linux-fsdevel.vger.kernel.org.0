Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA4BF49058D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jan 2022 10:58:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238410AbiAQJ5u (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Jan 2022 04:57:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25249 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233824AbiAQJ5t (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Jan 2022 04:57:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642413468;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=0ko6OUF03NtREbd4Ba6uZksPkCXStJRahIx6FjvF3q4=;
        b=jWn3QqEg5BuZtO+23jFO8LqD5oIQTKwI34WqczINW9vKJfINLSsF8+hy7NFHk/znu9P+2m
        7FMWK79rRqo9x9oDbNhAC2nbXd2dvOngS38ezWMgQ+W0t15WHPeZblMU35vK4AIkngO8vK
        /EObuplR13OTyF7n5IfWuJSq9v1WZPk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-300-In4HevWtNs-JnAKOIck5mg-1; Mon, 17 Jan 2022 04:57:42 -0500
X-MC-Unique: In4HevWtNs-JnAKOIck5mg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B59F7100C663;
        Mon, 17 Jan 2022 09:57:38 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.165])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1D7227B9E5;
        Mon, 17 Jan 2022 09:57:17 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
cc:     dhowells@redhat.com, Anna Schumaker <anna.schumaker@netapp.com>,
        Dave Wysochanski <dwysocha@redhat.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@kernel.org>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Marc Dionne <marc.dionne@auristor.com>,
        Matthew Wilcox <willy@infradead.org>,
        Omar Sandoval <osandov@osandov.com>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Steve French <sfrench@samba.org>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Peter Zijlstra <peterz@infradead.org>,
        ceph-devel@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-cachefs@redhat.com, linux-cifs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-nfs@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Out of order read() completion and buffer filling beyond returned amount
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2752207.1642413437.1@warthog.procyon.org.uk>
Date:   Mon, 17 Jan 2022 09:57:17 +0000
Message-ID: <2752208.1642413437@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Al, Linus,

Do you have an opinion on whether it's permissible for a filesystem to write
into the read() buffer beyond the amount it claims to return, though still
within the specified size of the buffer?

I'm working on common DIO routines for 9p, afs, ceph and cifs in netfs lib,
and I can see that at least three of those four filesystems either can or must
split a read, possibly being required to distribute across multiple servers.

If a filesystem was to emit multiple read RPCs in parallel, there is the
possibility that they would complete out of order - particularly if they go to
multiple servers.

Would it be a violation of the way the read() family of syscalls work to write
the data into the buffers out of order, and then abandon the extra data
written at the end if one of the RPCs returned a short read?  We would have
clobbered some of the buffer that we haven't said we've modified.

For buffered reads, it's not a problem as we can fill the pagecache out of
order with no issue.

David

