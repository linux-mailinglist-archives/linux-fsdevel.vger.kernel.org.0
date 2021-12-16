Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25E48477991
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Dec 2021 17:47:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239633AbhLPQrs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Dec 2021 11:47:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:44368 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239575AbhLPQrr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Dec 2021 11:47:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639673266;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H4QQrv5yHw8uvREotMjEQW9H2R0fBtaao4kUBQhmBFY=;
        b=ShUoagyzoXq1A3uSaQjY8ZLWIgz9nIrO80DAZlOEtfKTEOmoxCiWf5ScC3RyXDvRKAe265
        JSdx79ZU3h0bOBuviqZndtyn5CfFeAdrplEdA80v0koCs1xPMG1W6LM0sSjkJNDbiiATly
        1/294mMLXGfP5nvmsPg/ot/QvapGGAA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-263-6-Ukhu7bM6ieiGRqMNkqew-1; Thu, 16 Dec 2021 11:47:42 -0500
X-MC-Unique: 6-Ukhu7bM6ieiGRqMNkqew-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 75392801ADC;
        Thu, 16 Dec 2021 16:47:39 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.122])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8E6B51037F51;
        Thu, 16 Dec 2021 16:47:33 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAHk-=wi0H5vmka1_iWe0+Yc6bwtgWn_bEEHCMYsPHYtNJKZHCQ@mail.gmail.com>
References: <CAHk-=wi0H5vmka1_iWe0+Yc6bwtgWn_bEEHCMYsPHYtNJKZHCQ@mail.gmail.com> <163967073889.1823006.12237147297060239168.stgit@warthog.procyon.org.uk> <163967169723.1823006.2868573008412053995.stgit@warthog.procyon.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     dhowells@redhat.com, linux-cachefs@redhat.com,
        Jeff Layton <jlayton@kernel.org>,
        Marc Dionne <marc.dionne@auristor.com>,
        linux-afs@lists.infradead.org,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Omar Sandoval <osandov@osandov.com>,
        JeffleXu <jefflexu@linux.alibaba.com>,
        "open list:NFS, SUNRPC, AND..." <linux-nfs@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 56/68] afs: Handle len being extending over page end in write_begin/write_end
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1828148.1639673252.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Thu, 16 Dec 2021 16:47:32 +0000
Message-ID: <1828149.1639673252@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> wrote:

> > With transparent huge pages, in the future, write_begin() and write_en=
d()
> > may be passed a length parameter that, in combination with the offset =
into
> > the page, exceeds the length of that page.  This allows
> > grab_cache_page_write_begin() to better choose the size of THP to allo=
cate.
> =

> I still think this is a fundamental bug in the caller. That
> "explanation" is weak, and the whole concept smells like week-old fish
> to me.

You really should ask Willy about this as it's multipage folio-related.

AIUI, because the page/folio may be allocated inside ->write_begin(),
generic_perform_write() tells the filesystem how much it has been asked to
write and then the folio allocation can be made to fit that.

However, at this time, ->write_begin() and ->write_end() have a page point=
er
(or pointer-to-pointer), not a folio pointer, in their signature, so the
filesystem has to convert between them.

I'm working on write helpers for netfslib that absorb this out of the
filesystems that use it into its own take on generic_perform_write(), ther=
eby
eliminating the need for ->write_begin and ->write_end.  I have this kind =
of
working for afs and 9p at the moment and am looking at ceph, but there's a=
 way
to go yet.  I believe iomap does the same for block-based filesystems that=
 use
it (such as xfs).

I think Willy's aim is to get rid of ->write_begin and ->write_end entirel=
y.

David

