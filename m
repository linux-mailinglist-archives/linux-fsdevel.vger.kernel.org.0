Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F83835884C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Apr 2021 17:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232231AbhDHP0B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Apr 2021 11:26:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44764 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232246AbhDHP0A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Apr 2021 11:26:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617895548;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CGwlC/hESn7y7qGIlb10fpokHrJdwvIGgWjnr/18nGE=;
        b=I+zo/4BaGVwZakF8DwJcYla6797fbfBG7J9KutDUqo68VAdyrK1Rg5azBkL4uKh0hJdn5u
        7TJgpfq97v8cw1FUjQylNSPSaxIAyOmoACKhCEZyqbUQ2pWeSFQDuRQ507yFwjVoSLJ8Zh
        x0Qeg07Ah3OIt3PqA4GgaBOtqLF/Hc4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-61-fI44sw60N3C0hNH1bdmEJA-1; Thu, 08 Apr 2021 11:25:45 -0400
X-MC-Unique: fI44sw60N3C0hNH1bdmEJA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D75CE8189C8;
        Thu,  8 Apr 2021 15:25:41 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-119-35.rdu2.redhat.com [10.10.119.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7DD1710013C1;
        Thu,  8 Apr 2021 15:25:35 +0000 (UTC)
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
Content-ID: <14839.1617895534.1@warthog.procyon.org.uk>
Date:   Thu, 08 Apr 2021 16:25:34 +0100
Message-ID: <14840.1617895534@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> wrote:

> > +void end_page_private_2(struct page *page)
> > +{
> > +	page = compound_head(page);
> > +	VM_BUG_ON_PAGE(!PagePrivate2(page), page);
> > +	clear_bit_unlock(PG_private_2, &page->flags);
> > +	wake_up_page_bit(page, PG_private_2);
> 
> ... but when we try to end on a tail, we actually wake up the head ...

Question is, should I remove compound_head() here or add it into the other
functions?

David

