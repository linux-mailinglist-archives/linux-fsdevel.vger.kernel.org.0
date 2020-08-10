Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6972240AC7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Aug 2020 17:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbgHJPsX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Aug 2020 11:48:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37862 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726334AbgHJPsV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Aug 2020 11:48:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597074500;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=d/FqTzD6Anemh3gFgcLo0ThBd0ys9n4r95cTlaSJ7w8=;
        b=drqUcVzXYePzzrTKop+aIWuZ0nHqmUHqnOGFkfdLMJU/666D1un8fbZ0y2LinSGNJ08Hu4
        ok1lBJbZ8TqCgQduKMD/TAKPFJ+psFEracIFTRSvwNFl0bZW4WVOYn+dG2O1Cb/7efNZ4X
        XBZ3NLqQ4xKAI+eAwijGNLBNqhzMkYw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-283-BblU8oHRP1W5aFMWkcTb1w-1; Mon, 10 Aug 2020 11:48:19 -0400
X-MC-Unique: BblU8oHRP1W5aFMWkcTb1w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9A55980046C;
        Mon, 10 Aug 2020 15:48:16 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-113-69.rdu2.redhat.com [10.10.113.69])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BCC8C7B92F;
        Mon, 10 Aug 2020 15:48:09 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAH2r5msKipj1exNUDaSUN7h0pjanOenhSg2=EWYMv_h15yKtxg@mail.gmail.com>
References: <CAH2r5msKipj1exNUDaSUN7h0pjanOenhSg2=EWYMv_h15yKtxg@mail.gmail.com> <447452.1596109876@warthog.procyon.org.uk> <1851200.1596472222@warthog.procyon.org.uk> <667820.1597072619@warthog.procyon.org.uk>
To:     Steve French <smfrench@gmail.com>
Cc:     dhowells@redhat.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@redhat.com>,
        Dave Wysochanski <dwysocha@redhat.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs <linux-nfs@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] fscache rewrite -- please drop for now
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <672168.1597074488.1@warthog.procyon.org.uk>
Date:   Mon, 10 Aug 2020 16:48:08 +0100
Message-ID: <672169.1597074488@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Steve French <smfrench@gmail.com> wrote:

> cifs.ko also can set rsize quite small (even 1K for example, although
> that will be more than 10x slower than the default 4MB so hopefully no
> one is crazy enough to do that).

You can set rsize < PAGE_SIZE?

> I can't imagine an SMB3 server negotiating an rsize or wsize smaller than
> 64K in today's world (and typical is 1MB to 8MB) but the user can specify a
> much smaller rsize on mount.  If 64K is an adequate minimum, we could change
> the cifs mount option parsing to require a certain minimum rsize if fscache
> is selected.

I've borrowed the 256K granule size used by various AFS implementations for
the moment.  A 512-byte xattr can thus hold a bitmap covering 1G of file
space.

David

