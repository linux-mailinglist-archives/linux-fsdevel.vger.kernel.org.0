Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87B783E7C71
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Aug 2021 17:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243261AbhHJPhk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Aug 2021 11:37:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33290 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243270AbhHJPhi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Aug 2021 11:37:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628609836;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xkG9+GiNQSXsS2mvGI0+8aTZHN1rekkxhVtTcaqev5g=;
        b=B4zp0p6AeLNKfS7LzmEbqBx1fkPyTRyj/FaI0NeR9DVG+NdNSBHFrqfVSLRpTtVZGiVogD
        YhUzm62AdKaAmVX1eC0yEnY8R/82Rt67ZZe+dadJFKX8625SdL5HblF4UZAsZ+5zo7ysvn
        ToftFHkpZs+uDLj7m4ml1yLzSXh/Vtc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-168-xbRcxe2POzqqOpaWoKs11w-1; Tue, 10 Aug 2021 11:37:12 -0400
X-MC-Unique: xbRcxe2POzqqOpaWoKs11w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 25E5F100CCB8;
        Tue, 10 Aug 2021 15:37:11 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.22.32.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 294EF7E205;
        Tue, 10 Aug 2021 15:37:09 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20210715033704.692967-26-willy@infradead.org>
References: <20210715033704.692967-26-willy@infradead.org> <20210715033704.692967-1-willy@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     dhowells@redhat.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>
Subject: Re: [PATCH v14 025/138] mm/writeback: Add folio_wait_writeback()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1796580.1628609828.1@warthog.procyon.org.uk>
Date:   Tue, 10 Aug 2021 16:37:08 +0100
Message-ID: <1796581.1628609828@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox (Oracle) <willy@infradead.org> wrote:

> wait_on_page_writeback_killable() only has one caller, so convert it to
> call folio_wait_writeback_killable().  For the wait_on_page_writeback()
> callers, add a compatibility wrapper around folio_wait_writeback().
> 
> Turning PageWriteback() into folio_test_writeback() eliminates a call
> to compound_head() which saves 8 bytes and 15 bytes in the two
> functions.  Unfortunately, that is more than offset by adding the
> wait_on_page_writeback compatibility wrapper for a net increase in text
> of 7 bytes.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Jeff Layton <jlayton@kernel.org>
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Reviewed-by: William Kucharski <william.kucharski@oracle.com>

Reviewed-by: David Howells <dhowells@redhat.com>

