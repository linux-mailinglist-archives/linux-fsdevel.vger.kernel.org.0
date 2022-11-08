Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98F5B6218EE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Nov 2022 17:00:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234607AbiKHQAM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Nov 2022 11:00:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234346AbiKHQAI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Nov 2022 11:00:08 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B766A1A380
        for <linux-fsdevel@vger.kernel.org>; Tue,  8 Nov 2022 07:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667923152;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+7O/cdVA9cRWQClu+6yWqTBX+v+ngyo9UGXM4aHQHz0=;
        b=IBmCEE0RrECwZgD7/VV4bVCH2Rbpvaw1X9ZPTf3Q62tGEkkNvgeCj4VyFo55lmloTs3l5b
        gLn80F64a+Dley7Mbeiy6avOtOJXHQU4EUJUFn9fz0soTI4iqSe2Ne3+VNOrX7mP3XdK4a
        8RcK9jGHcRgRlN+CS27JYEl86pYMuW4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-641-ilJCerraMtCxfVDjkarK6A-1; Tue, 08 Nov 2022 10:59:11 -0500
X-MC-Unique: ilJCerraMtCxfVDjkarK6A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 09905811E81;
        Tue,  8 Nov 2022 15:59:11 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.37.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 492082166B29;
        Tue,  8 Nov 2022 15:59:09 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <084d78a4-6052-f2ec-72f2-af9c4979f5dc@linux.alibaba.com>
References: <084d78a4-6052-f2ec-72f2-af9c4979f5dc@linux.alibaba.com> <166757987929.950645.12595273010425381286.stgit@warthog.procyon.org.uk> <166757988611.950645.7626959069846893164.stgit@warthog.procyon.org.uk>
To:     JeffleXu <jefflexu@linux.alibaba.com>
Cc:     dhowells@redhat.com, willy@infradead.org,
        Jeff Layton <jlayton@kernel.org>, linux-cachefs@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] netfs: Fix dodgy maths
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2363339.1667923148.1@warthog.procyon.org.uk>
Date:   Tue, 08 Nov 2022 15:59:08 +0000
Message-ID: <2363340.1667923148@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

JeffleXu <jefflexu@linux.alibaba.com> wrote:

> > Fix the dodgy maths in netfs_rreq_unlock_folios().  start_page could be
> > inside the folio, in which case the calculation of pgpos will be come up
> > with a negative number (though for the moment rreq->start is rounded down
> > earlier and folios would have to get merged whilst locked)
> 
> Hi, the patch itself seems fine. Just some questions about the scenario.
> 
> 1. "start_page could be inside the folio" Is that because
> .expand_readahead() called from netfs_readahead()? Since otherwise,
> req-start is always aligned to the folio boundary.

At the moment, rreq->start is always coincident with the start of the first
folio in the collection because we always read whole folios - however, it
might be best to assume that this might not always hold true if it's simple to
fix the maths to get rid of the assumption.

> 2. If start_page is indeed inside the folio, then only the trailing part
> of the first folio can be covered by the request, and this folio will be
> marked with uptodate, though the beginning part of the folio may have
> not been read from the cache. Is that expected? Or correct me if I'm wrong.

For the moment there's no scenario where this arises; I think we need to wait
until we have a scenario and then see how we'll need to juggle the flags.

David

