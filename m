Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24112490CED
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jan 2022 18:00:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241495AbiAQRAC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Jan 2022 12:00:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:20968 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241250AbiAQQ7m (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Jan 2022 11:59:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642438781;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jEMJ4JQFyg+gEDwX5klaVTKJLzkbLHEr8lRFSE5ROn4=;
        b=TQRqos+ewfJujEqLeK5PU16DEqFPTILevSa/5CeSE7NtJibEGRS/d8u8f3ks1kv/Q0QNq/
        YpzIsQfN3EDlB4owIeb+zewwqpx1zUwZaj1YsdLpi3+9ZNRiX1i7FCvppuVa9QKa7yoEcX
        mQFWan+FXbKWOLbTftOUHu+vhjKVuac=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-221-ksLxfNUSOuqezqYdVXnkeQ-1; Mon, 17 Jan 2022 11:59:38 -0500
X-MC-Unique: ksLxfNUSOuqezqYdVXnkeQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2889C83DD22;
        Mon, 17 Jan 2022 16:59:37 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.165])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0B1CE10A48A7;
        Mon, 17 Jan 2022 16:59:35 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <YeWdlR7nsBG8fYO2@casper.infradead.org>
References: <YeWdlR7nsBG8fYO2@casper.infradead.org> <164243678893.2863669.12713835397467153827.stgit@warthog.procyon.org.uk> <164243679615.2863669.15715941907688580296.stgit@warthog.procyon.org.uk>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     dhowells@redhat.com, ceph-devel@vger.kernel.org,
        jlayton@kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/3] ceph: Uninline the data on a file opened for writing
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2883818.1642438775.1@warthog.procyon.org.uk>
Date:   Mon, 17 Jan 2022 16:59:35 +0000
Message-ID: <2883819.1642438775@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> wrote:

> > +	if (folio_test_uptodate(folio))
> > +		goto out_put_folio;
> 
> Er ... if (!folio_test_uptodate(folio)), perhaps?  And is it even
> worth testing if read_mapping_folio() returned success?  I feel like
> we should take ->readpage()'s word for it that success means the
> folio is now uptodate.

Actually, no, I shouldn't need to do this since it comes out with the page
lock still held.

> > +	len = i_size_read(inode);
> > +	if (len >  folio_size(folio))
> 
> extra space.  Plus, you're hardcoding 4096 below, but using folio_size()
> here which is a bit weird to me.

As I understand it, 4096 is the maximum length of the inline data, not
PAGE_SIZE, so I have to be careful when doing a DIO read because it might
start after the data - and there's also truncate to consider:-/

I wonder if the uninlining code should lock the inode while it does it and the
truncation code should do uninlining too.

David

