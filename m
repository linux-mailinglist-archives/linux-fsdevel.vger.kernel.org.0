Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1C33740BAF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 10:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234089AbjF1Iis (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 04:38:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36120 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235054AbjF1Ie5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 04:34:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687941246;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RjkXOAcXJsWorvAWQyGHVPdzkYuSbwrxzjDE0hFjQ5U=;
        b=bN34WAAGeXhI01bkZct9ZKIM2jjA7V3L/zwaxljj2Ia7kqe2AZ7CpjRD+q6jXhYMdH1zdB
        0S4v5Gb487irJ2fDglAcg7JKWnCCS1ROBHBvYuQcze9cuAQyNmreBivffGVMgHZ3LlZena
        p99Rq9qBcgsxGLShA47nk1fQuvhTzjE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-57-F6C9V_KENXCaJ16ytABrhA-1; Wed, 28 Jun 2023 02:30:52 -0400
X-MC-Unique: F6C9V_KENXCaJ16ytABrhA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 883581011630;
        Wed, 28 Jun 2023 06:30:51 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A3D462017DC6;
        Wed, 28 Jun 2023 06:30:50 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <ZJq6nJBoX1m6Po9+@casper.infradead.org>
References: <ZJq6nJBoX1m6Po9+@casper.infradead.org> <ec804f26-fa76-4fbe-9b1c-8fbbd829b735@mattwhitlock.name> <ZJp4Df8MnU8F3XAt@dread.disaster.area>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     dhowells@redhat.com, Dave Chinner <david@fromorbit.com>,
        Matt Whitlock <kernel@mattwhitlock.name>,
        linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [Reproducer] Corruption, possible race between splice and FALLOC_FL_PUNCH_HOLE
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3299542.1687933850.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Wed, 28 Jun 2023 07:30:50 +0100
Message-ID: <3299543.1687933850@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> wrote:

> > > Expected behavior:
> > > Punching holes in a file after splicing pages out of that file into =
a pipe
> > > should not corrupt the spliced-out pages in the pipe buffer.

I think this bit is the key.  Why would this be the expected behaviour?  A=
s
you say, splice is allowed to stuff parts of the pagecache into a pipe and
these may get transferred, say, to a network card at the end to transmit
directly from.  It's a form of direct I/O.  If someone has the pages mmapp=
ed,
they can change the data that will be transmitted; if someone does a write=
(),
they can change that data too.  The point of splice is to avoid the copy -=
 but
it comes with a tradeoff.

David

