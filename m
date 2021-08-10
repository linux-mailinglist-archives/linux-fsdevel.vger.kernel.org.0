Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6F63E7C5A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Aug 2021 17:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243223AbhHJPde (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Aug 2021 11:33:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33395 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243182AbhHJPd1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Aug 2021 11:33:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628609584;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Zkbo7tVPU5rdtYR09GqUwrCkfbSUVb255s4YcI/Pzm8=;
        b=QIpZVwa76mZga0zbd6agrJgfcuvLCN23CnWdd0uidOpu71CUcwV+F/PKN4hMFcX11Vo44O
        oO3PSZQ9RaVUKRNEOfhRqyNuURLpfIXx5D02Kbbcqw9Emn+Ut7CtSH0EKDS4PZRCePihg6
        a1r3Gz7ResSwnj5TMQThUuYT6YCb0Gw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-P6aQ7iMBMGS_FvCHulTrXg-1; Tue, 10 Aug 2021 11:33:01 -0400
X-MC-Unique: P6aQ7iMBMGS_FvCHulTrXg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 26359802C88;
        Tue, 10 Aug 2021 15:33:00 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.22.32.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4CB3A5C25A;
        Tue, 10 Aug 2021 15:32:58 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20210715033704.692967-20-willy@infradead.org>
References: <20210715033704.692967-20-willy@infradead.org> <20210715033704.692967-1-willy@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     dhowells@redhat.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>
Subject: Re: [PATCH v14 019/138] mm/filemap: Add folio_lock_killable()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1796350.1628609577.1@warthog.procyon.org.uk>
Date:   Tue, 10 Aug 2021 16:32:57 +0100
Message-ID: <1796351.1628609577@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox (Oracle) <willy@infradead.org> wrote:

> This is like lock_page_killable() but for use by callers who
> know they have a folio.  Convert __lock_page_killable() to be
> __folio_lock_killable().  This saves one call to compound_head() per
> contended call to lock_page_killable().
> 
> __folio_lock_killable() is 19 bytes smaller than __lock_page_killable()
> was.  filemap_fault() shrinks by 74 bytes and __lock_page_or_retry()
> shrinks by 71 bytes.  That's a total of 164 bytes of text saved.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Jeff Layton <jlayton@kernel.org>
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Reviewed-by: William Kucharski <william.kucharski@oracle.com>

Reviewed-by: David Howells <dhowells@redhat.com>

