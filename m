Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 457BD3F5FEF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Aug 2021 16:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237701AbhHXOMn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Aug 2021 10:12:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29010 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237681AbhHXOMm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Aug 2021 10:12:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629814318;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=B7csfGznQ1Q++PNssOARKkoGks0RWXUGuEYc3/fzXSM=;
        b=QoaABb7RWe7h4PeBmswgsFMI9vGZze3X/RuxV85wfWB7rP6R0mPkWa5er5eEGy326q+eY5
        9z+HD7bokUK2/IkmjZOfG4pQVzma0nfzRxZKNuvuLttRW85zoKobGoVq48tAnxN9rbv9TE
        RA0Y1xFID/wTmWVCvZQlpcEW9zhoUko=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-47-6t25SUB3PRaCvUt6qPogYw-1; Tue, 24 Aug 2021 10:11:54 -0400
X-MC-Unique: 6t25SUB3PRaCvUt6qPogYw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 046971082921;
        Tue, 24 Aug 2021 14:11:53 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.86])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AC8415C25A;
        Tue, 24 Aug 2021 14:11:46 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <YST8OcVNy02Rivbm@casper.infradead.org>
References: <YST8OcVNy02Rivbm@casper.infradead.org> <162981147473.1901565.1455657509200944265.stgit@warthog.procyon.org.uk> <162981151155.1901565.7010079316994382707.stgit@warthog.procyon.org.uk>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     dhowells@redhat.com, Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net, devel@lists.orangefs.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] folio: Add a function to get the host inode for a folio
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1951629.1629814305.1@warthog.procyon.org.uk>
Date:   Tue, 24 Aug 2021 15:11:45 +0100
Message-ID: <1951630.1629814305@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> wrote:

> > +static inline struct inode *folio_inode(struct folio *folio)
> > +{
> > +	return folio_file_mapping(folio)->host;
> 
> You're contradicting yourself here.  If you're allowed to call this
> function for swap cache pages, then the documentation needs to change.
> If you're not, then we can just use folio->mapping->host.

Um.  I don't know.  I'll do the latter, then, for now.

David

