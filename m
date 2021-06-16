Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7740C3A96A9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jun 2021 11:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231836AbhFPJ5u (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Jun 2021 05:57:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29781 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231524AbhFPJ5u (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Jun 2021 05:57:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623837344;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PW5xGLzUsFmJGFg8n6b8tOo3AhHdABWtaYtdWOZ63Io=;
        b=Z8bVFyHxqcPN3VyeuIGcfGqySzOehiRHwkrJuht1JPqurn+1OiCTyZx2qN8hnyX74XnrJR
        BxiealeCgHWaanhDCd4v9bxWmY0xwh7xb2ZoQfH+lQHs14IC3GiWNbzlbE9IW1qKzGonsC
        leTyIz1xldB7oFRZ9qlhmxbVqosw8+Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-597-EJSygrDEP-St_lD6GR0wtw-1; Wed, 16 Jun 2021 05:55:42 -0400
X-MC-Unique: EJSygrDEP-St_lD6GR0wtw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EBF898042AC;
        Wed, 16 Jun 2021 09:55:40 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-118-65.rdu2.redhat.com [10.10.118.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B4FF460853;
        Wed, 16 Jun 2021 09:55:38 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20210614201435.1379188-8-willy@infradead.org>
References: <20210614201435.1379188-8-willy@infradead.org> <20210614201435.1379188-1-willy@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     dhowells@redhat.com, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Zi Yan <ziy@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>
Subject: Re: [PATCH v11 07/33] mm: Add folio_put()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <813596.1623837337.1@warthog.procyon.org.uk>
Date:   Wed, 16 Jun 2021 10:55:37 +0100
Message-ID: <813597.1623837337@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox (Oracle) <willy@infradead.org> wrote:

> If we know we have a folio, we can call folio_put() instead of put_page()
> and save the overhead of calling compound_head().  Also skips the
> devmap checks.
> 
> This commit looks like it should be a no-op, but actually saves 684 bytes
> of text with the distro-derived config that I'm testing.  Some functions
> grow a little while others shrink.  I presume the compiler is making
> different inlining decisions.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Jeff Layton <jlayton@kernel.org>
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Reviewed-by: William Kucharski <william.kucharski@oracle.com>

Reviewed-by: David Howells <dhowells@redhat.com>

