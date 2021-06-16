Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF3573A9750
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jun 2021 12:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232303AbhFPKdB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Jun 2021 06:33:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29346 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231769AbhFPKdA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Jun 2021 06:33:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623839454;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c4y6kj+428wwTUGNhZ1FsmPykm/3ZLz6Zk7Y/QMtNQw=;
        b=X/Atll6pOP6xNdsnkJ0T2hRxLOSVGqKDDBEDIgGBJH1lmeT176TGVIyZ+4GuTuifX3c2CS
        /2xQNHMw0fTP/zj+spMSqurKdvH4edzvjY9K0OBkKDt4hYblY8nUFauIADHSSPx70em/Dt
        0CN5wMGxIFZXxKRYxXVQxyzCy7IrA3Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-516-2yPl4CptPQymnvnTjP118Q-1; Wed, 16 Jun 2021 06:30:51 -0400
X-MC-Unique: 2yPl4CptPQymnvnTjP118Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 75BB58015F5;
        Wed, 16 Jun 2021 10:30:49 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-118-65.rdu2.redhat.com [10.10.118.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0E5CE5D6AD;
        Wed, 16 Jun 2021 10:30:46 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20210614201435.1379188-27-willy@infradead.org>
References: <20210614201435.1379188-27-willy@infradead.org> <20210614201435.1379188-1-willy@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     dhowells@redhat.com, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>
Subject: Re: [PATCH v11 26/33] mm/writeback: Add folio_wait_writeback()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <815892.1623839446.1@warthog.procyon.org.uk>
Date:   Wed, 16 Jun 2021 11:30:46 +0100
Message-ID: <815893.1623839446@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox (Oracle) <willy@infradead.org> wrote:

> +	struct page *page = &folio->page;

Isn't that a layering violation?  Should it be something like:

	struct page *page = folio_head();

or:

	struct page *page = folio_subpage(0);

maybe?

