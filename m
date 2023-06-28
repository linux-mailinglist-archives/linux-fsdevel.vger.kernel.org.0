Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC40E741802
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 20:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbjF1S2Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 14:28:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48069 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230401AbjF1S2Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 14:28:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687976854;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/rj34s/fUvdigcX1+hTWUHyuQ+LEjY4NckG6dmprRpg=;
        b=TIwNwMz/E8WAiuR4YRn5spqSuDsmjYWR7hk1GnCd6q5wdpQLsi/j8AatXXgfkKoZnvjdQL
        CN4IrxbkK82Ckbb/Ic7+dTDJd8DYY1UKWt6OmWUBbJl+kVp0q26hgHXsu1cdMO+RLpykPg
        TvwDJSgfLp4ZJBPU7EOPpfgxs/0ev9Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-418-bojcX7VlMZea6izeeIl3XA-1; Wed, 28 Jun 2023 14:27:28 -0400
X-MC-Unique: bojcX7VlMZea6izeeIl3XA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 10096800CAC;
        Wed, 28 Jun 2023 18:27:28 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2D804111F3B0;
        Wed, 28 Jun 2023 18:27:27 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <a60594ef-ff85-498f-a1c4-0fcb9586621c@mattwhitlock.name>
References: <a60594ef-ff85-498f-a1c4-0fcb9586621c@mattwhitlock.name> <ZJq6nJBoX1m6Po9+@casper.infradead.org> <ec804f26-fa76-4fbe-9b1c-8fbbd829b735@mattwhitlock.name> <ZJp4Df8MnU8F3XAt@dread.disaster.area> <3299543.1687933850@warthog.procyon.org.uk>
To:     Matt Whitlock <kernel@mattwhitlock.name>
Cc:     dhowells@redhat.com, Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [Reproducer] Corruption, possible race between splice and FALLOC_FL_PUNCH_HOLE
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3695108.1687976846.1@warthog.procyon.org.uk>
Date:   Wed, 28 Jun 2023 19:27:26 +0100
Message-ID: <3695109.1687976846@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matt Whitlock <kernel@mattwhitlock.name> wrote:

> In other words, the currently implemented behavior is appropriate for
> SPLICE_F_MOVE, but it is not appropriate for ~SPLICE_F_MOVE.

The problems with SPLICE_F_MOVE is that it's only applicable to splicing *out*
of a pipe.  By the time you get that far the pages can already be corrupted by
a shared-writable mmap or write().

David

