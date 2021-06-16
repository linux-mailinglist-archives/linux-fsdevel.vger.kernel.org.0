Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E96EC3A9712
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jun 2021 12:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232250AbhFPKTr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Jun 2021 06:19:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51778 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231971AbhFPKTr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Jun 2021 06:19:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623838660;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qyoOUTk8nfkIXeAKs3WKvDVDV9scEihFb5jE//3k8go=;
        b=c6tTol5muX8s7D49SiHYR1l2kNZCwbhvxX75K/PZQq75gka4UzlBqIAlztag5ZRTh3GPLF
        x6+oEw4NwqdGyqHkqx7UpdQ6AxgPo86NxuhBbhCL4tL+Qsng4pjouhCdhI3LpuntBaDh/d
        SIYY9c6HzxydCNuo8G4Wjm4xgw2qbuc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-270-U0YNV_yJN2SvVoF3GZkpUA-1; Wed, 16 Jun 2021 06:17:39 -0400
X-MC-Unique: U0YNV_yJN2SvVoF3GZkpUA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 16C09A40C2;
        Wed, 16 Jun 2021 10:17:38 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-118-65.rdu2.redhat.com [10.10.118.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2A24E10023B5;
        Wed, 16 Jun 2021 10:17:36 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20210614201435.1379188-20-willy@infradead.org>
References: <20210614201435.1379188-20-willy@infradead.org> <20210614201435.1379188-1-willy@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     dhowells@redhat.com, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>
Subject: Re: [PATCH v11 19/33] mm/filemap: Add folio_lock()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <815045.1623838655.1@warthog.procyon.org.uk>
Date:   Wed, 16 Jun 2021 11:17:35 +0100
Message-ID: <815046.1623838655@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox (Oracle) <willy@infradead.org> wrote:

> This is like lock_page() but for use by callers who know they have a folio.
> Convert __lock_page() to be __folio_lock().  This saves one call to
> compound_head() per contended call to lock_page().
> 
> Saves 455 bytes of text; mostly from improved register allocation and
> inlining decisions.  __folio_lock is 59 bytes while __lock_page was 79.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Jeff Layton <jlayton@kernel.org>
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Reviewed-by: William Kucharski <william.kucharski@oracle.com>

Reviewed-by: David Howells <dhowells@redhat.com>

