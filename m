Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE6F6A4603
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Feb 2023 16:25:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbjB0PZX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Feb 2023 10:25:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbjB0PZP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Feb 2023 10:25:15 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB1471E2B3
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Feb 2023 07:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677511468;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NWdwiI4PJ+IBncsrNHjeMLRPIquT5DILZIcxMXt8jUI=;
        b=KszvOPEh38FRysolVCGdtSjesXrBVZ28nATJ6Q+rkT0b2WbSde8voz+jihp/8BNVXCirvI
        W8eYtufgtaXPZtvYPgDWtuBkJADwOptAHZW3TFUK4i3jXLUzZPLq5WhN4pD9oC0R1BnHGO
        DLRIBndek3WJWMN4tMZ2AlpMhJYfTA4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-183-XHmEih5kMpWQMmNTXrNLrw-1; Mon, 27 Feb 2023 10:24:22 -0500
X-MC-Unique: XHmEih5kMpWQMmNTXrNLrw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 18B33830F81;
        Mon, 27 Feb 2023 15:24:22 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 13A182026D68;
        Mon, 27 Feb 2023 15:24:20 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <Y/zCB43mmeZ/vSbz@casper.infradead.org>
References: <Y/zCB43mmeZ/vSbz@casper.infradead.org> <2734058.1677507812@warthog.procyon.org.uk>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     dhowells@redhat.com, Miklos Szeredi <miklos@szeredi.hu>,
        Amit Shah <amit@kernel.org>, linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] splice: Prevent gifting of multipage folios
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2737654.1677511460.1@warthog.procyon.org.uk>
Date:   Mon, 27 Feb 2023 15:24:20 +0000
Message-ID: <2737655.1677511460@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> wrote:

> What should the Fixes: here be?  This was already possible with THPs
> (both anon and tmpfs backed) long before I introduced folios.

Good question.  How do I tell when THPs were introduced?  It looks like they
might predate git, looking at free_compound_page()'s comment.

David

