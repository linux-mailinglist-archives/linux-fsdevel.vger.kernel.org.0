Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5083A9700
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jun 2021 12:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbhFPKPn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Jun 2021 06:15:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37956 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231769AbhFPKPn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Jun 2021 06:15:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623838417;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Epg4Aq9j6BS03XI6rIbhlaLoVsEvmsA7hfwNMTbOESg=;
        b=Yo3OP5PYIvePaalbdm24AOOthRpmmPx3XY55nofX6hkOxzmxNWHHQ+awqLn01pKc/6B9C/
        W7eM/dDqTnFuWKGNbmTWU6JdjlNKQwL3HG/Sd3wACsLR0QgcS9nsxc6WTCSSJc1uFiPlwA
        OnDXU5awafObGH3dpuGjQA+MMT2JCi0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-570-g_KlpE6VP0iGvZFxgW_Kbw-1; Wed, 16 Jun 2021 06:13:36 -0400
X-MC-Unique: g_KlpE6VP0iGvZFxgW_Kbw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B007AEC1A0;
        Wed, 16 Jun 2021 10:13:34 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-118-65.rdu2.redhat.com [10.10.118.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B33095D6AD;
        Wed, 16 Jun 2021 10:13:32 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20210614201435.1379188-19-willy@infradead.org>
References: <20210614201435.1379188-19-willy@infradead.org> <20210614201435.1379188-1-willy@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     dhowells@redhat.com, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        William Kucharski <william.kucharski@oracle.com>
Subject: Re: [PATCH v11 18/33] mm/filemap: Add folio_unlock()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <814786.1623838411.1@warthog.procyon.org.uk>
Date:   Wed, 16 Jun 2021 11:13:31 +0100
Message-ID: <814787.1623838411@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox (Oracle) <willy@infradead.org> wrote:

> Convert unlock_page() to call folio_unlock().  By using a folio we
> avoid a call to compound_head().  This shortens the function from 39
> bytes to 25 and removes 4 instructions on x86-64.  Because we still
> have unlock_page(), it's a net increase of 16 bytes of text for the
> kernel as a whole, but any path that uses folio_unlock() will execute
> 4 fewer instructions.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Jeff Layton <jlayton@kernel.org>
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reviewed-by: William Kucharski <william.kucharski@oracle.com>

Reviewed-by: David Howells <dhowells@redhat.com>

