Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A43063A6813
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jun 2021 15:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234043AbhFNNjX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Jun 2021 09:39:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41261 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233767AbhFNNjV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Jun 2021 09:39:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623677838;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9zJYlNCno/HjzceWxClcR824bm7Ts8a212RDRVjhT0c=;
        b=gBXQVYqB9oYtIaiZeQ6O6l4egXJg/7rfRIF5+AGMtlCgkOOJVQggbpdFX1lal71O3cVQT/
        1wlEnE2k976Q+JcPnKEB8HxBAN7Ib5D/2nDjgvWREUlXSWmB7DHf8cu8oA4bA101LGJ9P+
        wzyMnUjQcDK0xnjhQ0QAML7AenwFNEw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-334-jQ-WAJl7P3umr7wuJSXvNg-1; Mon, 14 Jun 2021 09:37:16 -0400
X-MC-Unique: jQ-WAJl7P3umr7wuJSXvNg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4D6F91084F49;
        Mon, 14 Jun 2021 13:37:14 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-118-65.rdu2.redhat.com [10.10.118.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DD3D55D6B1;
        Mon, 14 Jun 2021 13:37:12 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <YMdZbsvBNYBtZDC2@casper.infradead.org>
References: <YMdZbsvBNYBtZDC2@casper.infradead.org> <162367681795.460125.11729955608839747375.stgit@warthog.procyon.org.uk> <162367682522.460125.5652091227576721609.stgit@warthog.procyon.org.uk>
To:     Matthew Wilcox <willy@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     dhowells@redhat.com, jlayton@kernel.org,
        linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] afs: Fix afs_write_end() to handle short writes
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <466589.1623677832.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Mon, 14 Jun 2021 14:37:12 +0100
Message-ID: <466590.1623677832@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> wrote:

> >  (1) If the page is not up to date, then we should just return 0
> >      (ie. indicating a zero-length copy).  The loop in
> >      generic_perform_write() will go around again, possibly breaking u=
p the
> >      iterator into discrete chunks.
> =

> Does this actually work?  What about the situation where you're reading
> the last page of a file and thus (almost) always reading fewer bytes
> than a PAGE_SIZE?

Al Viro made such a change for Ceph - and we're writing, not reading.

I was thinking that it would break if reading from a pipe, but Jeff pointe=
d
out that the iov_iter_advance() in generic_perform_write() uses the return
value of ->write_end() to advance the iterator.  So it might loop endlessl=
y,
but it doesn't appear it will corrupt your data.

David

