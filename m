Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 598E6633DD5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Nov 2022 14:38:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233591AbiKVNiI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Nov 2022 08:38:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233183AbiKVNiF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Nov 2022 08:38:05 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 126C265859
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Nov 2022 05:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669124227;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1dWvNrreQ//p1hYgd4mqv1o3a3/SDy+15g4X7BGwYuE=;
        b=PxzPrg95GlxWVXzgp+WFCZ69cXB3rl/DW5a06hxtT54O1KTmPyNHlyvLWgF9PWs4ZLqMrN
        UFPxCU2MM+v3VzQNDv/gzrTYlzaCkf2bSkXuM+V5v0VtVyorLsf6egT8/MS9S74cYcsRCu
        vfgC84teNS2FKHvZRzeVfqKt5EnKDak=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-552-kmflS9rnOyGDOch6wHKwgg-1; Tue, 22 Nov 2022 08:37:04 -0500
X-MC-Unique: kmflS9rnOyGDOch6wHKwgg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 249911C05EA2;
        Tue, 22 Nov 2022 13:37:01 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.14])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E0BCF40C83AD;
        Tue, 22 Nov 2022 13:36:59 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <Y3zFzdWnWlEJ8X8/@infradead.org>
References: <Y3zFzdWnWlEJ8X8/@infradead.org> <166869687556.3723671.10061142538708346995.stgit@warthog.procyon.org.uk> <166869689451.3723671.18242195992447653092.stgit@warthog.procyon.org.uk>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     dhowells@redhat.com, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/4] iov_iter: Add a function to extract a page list from an iterator
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <824668.1669124217.1@warthog.procyon.org.uk>
Date:   Tue, 22 Nov 2022 13:36:57 +0000
Message-ID: <824669.1669124217@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:

> > +EXPORT_SYMBOL(iov_iter_extract_pages);
> 
> get_user_pages_fast, pin_user_pages_fast are very intentionally
> EXPORT_SYMBOL_GPL, which should not be bypassed by an iov_* wrapper.

Ah, but I'm intending to replace:

	EXPORT_SYMBOL(iov_iter_get_pages2);
	EXPORT_SYMBOL(iov_iter_get_pages_alloc2);

which *aren't* marked _GPL, so you need to argue that one with Al.

David

