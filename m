Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2432233DEF3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Mar 2021 21:38:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbhCPUiX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Mar 2021 16:38:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40286 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231397AbhCPUiN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Mar 2021 16:38:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615927092;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CMarB3VddjXNLrXwgBbm1Z1YjzBsISepgPDMYK+ct2o=;
        b=FTI1QrdMrtJ91Vjn3PqxhcI+loiGLwhdsxdVihOumGeyHTn+r1dFjefOgdBc+dstd62IXV
        8gXlfODbpJ3bCgrsiVfCNZ0tGuApouJ2+vuqIjK/9u6sVE8ZB/EQWInhlAQRAN7I8D4VEn
        f9pcQFgih0+EP2jOv56t0Vzup5xU1jY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-204-TKLQWn3DPmW8oUP28nVqjQ-1; Tue, 16 Mar 2021 16:38:11 -0400
X-MC-Unique: TKLQWn3DPmW8oUP28nVqjQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6E5511B18BC1;
        Tue, 16 Mar 2021 20:38:08 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-118-152.rdu2.redhat.com [10.10.118.152])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 807582BFE7;
        Tue, 16 Mar 2021 20:38:01 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20210316190707.GD3420@casper.infradead.org>
References: <20210316190707.GD3420@casper.infradead.org> <161539526152.286939.8589700175877370401.stgit@warthog.procyon.org.uk> <161539528910.286939.1252328699383291173.stgit@warthog.procyon.org.uk>
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
Content-ID: <3313318.1615927080.1@warthog.procyon.org.uk>
Date:   Tue, 16 Mar 2021 20:38:00 +0000
Message-ID: <3313319.1615927080@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> wrote:

> So ... a page with both flags cleared should have a refcount of N.
> A page with one or both flags set should have a refcount of N+1.
> ...
> How is a poor filesystem supposed to make that true?  Also btrfs has this
> problem since it uses private_2 for its own purposes.

It's simpler if it's N+2 for both patches set.  Btw, patch 13 adds that - and
possibly that should be merged into an earlier patch.

David

