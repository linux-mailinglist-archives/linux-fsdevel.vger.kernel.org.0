Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1033466C5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Mar 2021 18:51:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbhCWRvR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Mar 2021 13:51:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48657 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231346AbhCWRvB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Mar 2021 13:51:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616521860;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LouRr+fCG0OmszLhP6L8WRvJgJF/XEnWkAzpMfXY6u4=;
        b=ZeCFpsYMf6XdBAaQcxlV1Ayo1Hp9Mm7pu+DTPf6MgkIOqT6vWfGmv60Bv6soXRh76RYjZQ
        Mr1492+Cu/+iK58eKojgV20Djq5dcjUfSi4NeAP0VHDywkbvpTjWytajjJAUa1Bw/mgqNE
        OqII3EX3JUC0PHcl5uivUJlWKROmZnQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-232-02Qt-z3bNpaoL_QStgOmuw-1; Tue, 23 Mar 2021 13:50:56 -0400
X-MC-Unique: 02Qt-z3bNpaoL_QStgOmuw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2F5D387A83E;
        Tue, 23 Mar 2021 17:50:55 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-58.rdu2.redhat.com [10.10.112.58])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C517C6E6FB;
        Tue, 23 Mar 2021 17:50:32 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <YFja/LRC1NI6quL6@cmpxchg.org>
References: <YFja/LRC1NI6quL6@cmpxchg.org> <20210320054104.1300774-1-willy@infradead.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     dhowells@redhat.com,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        linux-afs@lists.infradead.org
Subject: Re: [PATCH v5 00/27] Memory Folios
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2749828.1616521831.1@warthog.procyon.org.uk>
Date:   Tue, 23 Mar 2021 17:50:31 +0000
Message-ID: <2749829.1616521831@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Johannes Weiner <hannes@cmpxchg.org> wrote:

> So I fully agree with the motivation behind this patch. But I do
> wonder why it's special-casing the commmon case instead of the rare
> case. It comes at a huge cost. Short term, the churn of replacing
> 'page' with 'folio' in pretty much all instances is enormous.
> 
> And longer term, I'm not convinced folio is the abstraction we want
> throughout the kernel. If nobody should be dealing with tail pages in
> the first place, why are we making everybody think in 'folios'? Why
> does a filesystem care that huge pages are composed of multiple base
> pages internally? This feels like an implementation detail leaking out
> of the MM code. The vast majority of places should be thinking 'page'
> with a size of 'page_size()'. Including most parts of the MM itself.

I like the idea of logically separating individual hardware pages from
abstract bundles of pages by using a separate type for them - at least in
filesystem code.  I'm trying to abstract some of the handling out of the
network filesystems and into a common library plus ITER_XARRAY to insulate
those filesystems from the VM.

David

