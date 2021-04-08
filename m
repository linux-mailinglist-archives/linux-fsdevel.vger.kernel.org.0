Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9631358905
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Apr 2021 17:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231918AbhDHP54 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Apr 2021 11:57:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54267 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231655AbhDHP5z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Apr 2021 11:57:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617897464;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NinlbVPhwGdJcoVcBt2udn4w5X18/v4CvahbnKLeeMI=;
        b=NEdeqkDHiTCWJJwaZxmkSrX/82crujOncZicm/U1g2O2KiPxUtDQwgSRpHdduYvi8paM+w
        2KpRuzyOlPja2/pba5L/L3g+U1eLfDts5DYyuRhlmlAnNVVaoBZcFwQl5ymSC1OyyFiyo5
        xLkxwnSmSzVKWi6CleVnNHQKHylabfY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-413-0tkXerksNmuLEQR_9ITDFg-1; Thu, 08 Apr 2021 11:57:42 -0400
X-MC-Unique: 0tkXerksNmuLEQR_9ITDFg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D1B2A107ACC7;
        Thu,  8 Apr 2021 15:57:39 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-119-35.rdu2.redhat.com [10.10.119.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3DE165C1C4;
        Thu,  8 Apr 2021 15:57:32 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20210408145057.GN2531743@casper.infradead.org>
References: <20210408145057.GN2531743@casper.infradead.org> <161789062190.6155.12711584466338493050.stgit@warthog.procyon.org.uk> <161789066013.6155.9816857201817288382.stgit@warthog.procyon.org.uk>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>, linux-mm@kvack.org,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@redhat.com>,
        David Wysochanski <dwysocha@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 02/30] mm: Add set/end/wait functions for PG_private_2
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <46016.1617897451.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Thu, 08 Apr 2021 16:57:31 +0100
Message-ID: <46017.1617897451@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Here's a partial change, but we still need to deal with the assumption tha=
t
page_has_private() makes that its output can be used to count the number o=
f
refs held for PG_private *and* PG_private_2 - which isn't true for my code
here.

David
---
commit e7c28d83b84b972c3faa0dd86020548aa50eda75
Author: David Howells <dhowells@redhat.com>
Date:   Thu Apr 8 16:33:20 2021 +0100

    netfs: Fix PG_private_2 helper functions to consistently use compound_=
head()

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index ef511364cc0c..63ca6430aef5 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -699,6 +699,7 @@ void page_endio(struct page *page, bool is_write, int =
err);
  */
 static inline void set_page_private_2(struct page *page)
 {
+	page =3D compound_head(page);
 	get_page(page);
 	SetPagePrivate2(page);
 }
diff --git a/mm/filemap.c b/mm/filemap.c
index 0ce93c8799ca..46e0321ba87a 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1461,6 +1461,7 @@ EXPORT_SYMBOL(end_page_private_2);
  */
 void wait_on_page_private_2(struct page *page)
 {
+	page =3D compound_head(page);
 	while (PagePrivate2(page))
 		wait_on_page_bit(page, PG_private_2);
 }
@@ -1481,6 +1482,7 @@ int wait_on_page_private_2_killable(struct page *pag=
e)
 {
 	int ret =3D 0;
 =

+	page =3D compound_head(page);
 	while (PagePrivate2(page)) {
 		ret =3D wait_on_page_bit_killable(page, PG_private_2);
 		if (ret < 0)

