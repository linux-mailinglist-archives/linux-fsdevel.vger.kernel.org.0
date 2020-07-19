Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D97A2250F9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jul 2020 11:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbgGSJwF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Jul 2020 05:52:05 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:57740 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726464AbgGSJwD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Jul 2020 05:52:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595152322;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mknWuDNTSPVA5tuUznaF/9X4S4nuMwQxpbXQ5+3goe4=;
        b=KTNUbDob46tg9SJK7KzWkduacmY2eOFp9p4cWPefWh8xV/H29cBNiB36A068Zcny5RdTeK
        y9gpO9xNrG1oTtDOnP2Pv1Pcn4CAGvNeRpNgWqThWxYnMIOrGBKHZJCemWPx7anQQIvN/p
        rryJvEu+SWR9hPemHmiDTseufKW+MAU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-138-nURWLhFwNNyG7fNENd1CWQ-1; Sun, 19 Jul 2020 05:52:00 -0400
X-MC-Unique: nURWLhFwNNyG7fNENd1CWQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 940D580183C;
        Sun, 19 Jul 2020 09:51:58 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-32.rdu2.redhat.com [10.10.112.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8F9481A90F;
        Sun, 19 Jul 2020 09:51:52 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
In-Reply-To: <20200719014436.GG2786714@ZenIV.linux.org.uk>
References: <20200719014436.GG2786714@ZenIV.linux.org.uk> <159465784033.1376674.18106463693989811037.stgit@warthog.procyon.org.uk> <159465785214.1376674.6062549291411362531.stgit@warthog.procyon.org.uk>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     dhowells@redhat.com, Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@redhat.com>,
        Dave Wysochanski <dwysocha@redhat.com>,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/32] iov_iter: Add ITER_MAPPING
From:   David Howells <dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3417.1595152311.1@warthog.procyon.org.uk>
Date:   Sun, 19 Jul 2020 10:51:51 +0100
Message-ID: <3418.1595152311@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Al Viro <viro@zeniv.linux.org.uk> wrote:

> My main problem here is that your iterate_mapping() assumes that STEP is
> safe under rcu_read_lock(), with no visible mentioning of that fact.

Yeah, that's probably the biggest objection to this.

> Note, BTW, that iov_iter_for_each_range() quietly calls user-supplied
> callback in such context.

And calls kmap(), but should probably use kmap_atomic().  git grep doesn't
show any users of this, so can it be removed?

> Incidentally, do you ever have different steps for bvec and mapping?

Yes:

	csum_and_copy_from_iter_full()
	iov_iter_npages()
	iov_iter_get_pages()
	iov_iter_get_pages_alloc()

But I've tried to use the internal representation struct for bvec where I can
rather than inventing a new one.

David

