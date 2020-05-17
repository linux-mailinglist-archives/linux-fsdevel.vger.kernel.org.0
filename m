Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EAF41D6DDD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 May 2020 00:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbgEQWhF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 17 May 2020 18:37:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21771 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726550AbgEQWhF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 17 May 2020 18:37:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589755024;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R6DBtpMAn3ekiwiyAskbqzCTE2dKTfdjjBHrVuQWSx4=;
        b=DB+3QeZo7NLRokjCEDUd288kzPbBlZT/4TTz6y9jZifZ9YnUEn8BYdYG44/25F+yIk0YRV
        YZ+7mB95VN7BSxQZJNVuMFZIEgZncAmzpxIE2JM71NIJ+FCYGByMxapXSHp0qIlK3gXeYq
        jrEN2H90/lHN+8Smd/tGbRejPMU9f48=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-75-ZTKbhoElMFOsXiTYA5qa7g-1; Sun, 17 May 2020 18:37:01 -0400
X-MC-Unique: ZTKbhoElMFOsXiTYA5qa7g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F2D01461;
        Sun, 17 May 2020 22:36:58 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-95.rdu2.redhat.com [10.10.112.95])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C1D4A5C1C8;
        Sun, 17 May 2020 22:36:57 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20200517210811.GQ16070@bombadil.infradead.org>
References: <20200517210811.GQ16070@bombadil.infradead.org> <158974686528.785191.2525276665446566911.stgit@warthog.procyon.org.uk>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     dhowells@redhat.com, torvalds@linux-foundation.org,
        linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] afs: Don't unlock fetched data pages until the op completes successfully
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <796666.1589755017.1@warthog.procyon.org.uk>
Date:   Sun, 17 May 2020 23:36:57 +0100
Message-ID: <796667.1589755017@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> wrote:

> > +	if (req->page_done)
> > +		for (req->index = 0; req->index < req->nr_pages; req->index++)
> > +			req->page_done(req);
> > +
> 
> I'd suggest doing one call rather than N and putting the page iteration
> inside the callback.  But this patch is appropriate for this late in
> the -rc series, just something to consider for the future.

My rewrite of the fscache stuff changes this bit of the code anyway, and makes
it one call which may start a write out to the cache.

David

