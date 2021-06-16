Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9A43A95CA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jun 2021 11:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232157AbhFPJSM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Jun 2021 05:18:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22235 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231335AbhFPJSM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Jun 2021 05:18:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623834966;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T4+c2pc8J0kO0sEZOcAlXdb+PXp9r+TugMlu0OrZfbQ=;
        b=howEjtXFtd2cxDrHbeBo+wZMo7ZExWSR343XOX/0/Q001lobM8lmAbtohfCQAW8C0Q59Wz
        A8q+G6j5yydV/QISsjyw8F58TBX90d5C2zO5Bye/k3mpFZ1Jd8i7jwRDcOPPGL7oBVUfNf
        E2Ngx8h3l/c6Hj8+RugJqVbWX9pWxvM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-153-_HXbBplgNFKDDARh4oc90g-1; Wed, 16 Jun 2021 05:16:04 -0400
X-MC-Unique: _HXbBplgNFKDDARh4oc90g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EF662800D55;
        Wed, 16 Jun 2021 09:16:02 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-118-65.rdu2.redhat.com [10.10.118.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 43B485D6AD;
        Wed, 16 Jun 2021 09:16:01 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20210614201435.1379188-33-willy@infradead.org>
References: <20210614201435.1379188-33-willy@infradead.org> <20210614201435.1379188-1-willy@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     dhowells@redhat.com, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v11 32/33] fs/netfs: Add folio fscache functions
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <810721.1623834960.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Wed, 16 Jun 2021 10:16:00 +0100
Message-ID: <810722.1623834960@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox (Oracle) <willy@infradead.org> wrote:

>  /**
> - * set_page_fscache - Set PG_fscache on a page and take a ref
> - * @page: The page.
> + * folio_start_fscache - Start an fscache operation on a folio.
> + * @folio: The folio.
>   *
> - * Set the PG_fscache (PG_private_2) flag on a page and take the refere=
nce
> - * needed for the VM to handle its lifetime correctly.  This sets the f=
lag and
> - * takes the reference unconditionally, so care must be taken not to se=
t the
> - * flag again if it's already set.
> + * Call this function before an fscache operation starts on a folio.
> + * Starting a second fscache operation before the first one finishes is
> + * not allowed.

That's not correct.  It's only used for operations that write from the pag=
e to
disk.  Operations that read into the page are covered by the page lock.

> + * folio_end_fscache - End an fscache operation on a folio.
> ...
> + * Call this function after an fscache operation has finished.  This wi=
ll
> + * wake any sleepers waiting on this folio.

Ditto.

> + * folio_wait_fscache - Wait for an fscache operation on this folio to =
end.
> + * @folio: The folio.
>   *
> + * If an fscache operation is in progress on this folio, wait for it to
> + * finish.  Another fscache operation may start after this one finishes=
,
> + * unless the caller holds the folio lock.

Ditto.

Apart from that, it looks okay.

David

