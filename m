Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE1AE46BCAB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Dec 2021 14:32:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237184AbhLGNfy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Dec 2021 08:35:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:34414 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237180AbhLGNfw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Dec 2021 08:35:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638883942;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NKYPfQIjnZc9GgFyi3oXFUCuNFUgD0ub6Q8m1fQmeU4=;
        b=RHqGSa/hUXpZFkbkJHihmBlXYrSnlWY+I6ylfvtYw+N6KRPYw/bnkYAHaseRJDf1D81wEc
        zvJWIGTq907hZ494gNrPdky6iuvtP2TwAbQEsSxXmUBaJupUKMtmJkG6Ly+aMF+w7FGW+x
        TcV7E406sKmLtzwpfvNm5Igu1jhpWHI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-39-I5v9qoEqNRKlR7yAVqqH4g-1; Tue, 07 Dec 2021 08:32:17 -0500
X-MC-Unique: I5v9qoEqNRKlR7yAVqqH4g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1DA461006AA2;
        Tue,  7 Dec 2021 13:32:16 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ACC5B60843;
        Tue,  7 Dec 2021 13:32:14 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <Ya9eDiFCE2fO7K/S@casper.infradead.org>
References: <Ya9eDiFCE2fO7K/S@casper.infradead.org> <163887597541.1596626.2668163316598972956.stgit@warthog.procyon.org.uk>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     dhowells@redhat.com, jack@suse.cz, jlayton@kernel.org,
        linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netfs: Fix lockdep warning from taking sb_writers whilst holding mmap_lock
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1602526.1638883933.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Tue, 07 Dec 2021 13:32:13 +0000
Message-ID: <1602527.1638883933@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> wrote:

> On Tue, Dec 07, 2021 at 11:19:35AM +0000, David Howells wrote:
> > Taking sb_writers whilst holding mmap_lock isn't allowed and will resu=
lt in
> > a lockdep warning like that below.  The problem comes from cachefiles
> > needing to take the sb_writers lock in order to do a write to the cach=
e,
> > but being asked to do this by netfslib called from readpage, readahead=
 or
> > write_begin[1].
> =

> Isn't it taking sb_writers _on a different filesystem_?  So there's not
> a real deadlock here, just a need to tell lockdep that this is a
> different subclass of lock?

Jann thinks it can be turned into a real deadlock.  See the link I put in =
the
patch description:

> > Link: https://lore.kernel.org/r/20210922110420.GA21576@quack2.suse.cz/=
 [1]

David

