Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 560A0548384
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jun 2022 11:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240697AbiFMJTb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jun 2022 05:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239790AbiFMJT0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jun 2022 05:19:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A942315A03
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jun 2022 02:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655111964;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w+/GwuuQGFS111woXNsLKjQljVwtMltJeO1V2zF9Vjo=;
        b=OXfG0gHHepiYL44lqwJxL1RmwGMvuYK+GXgNrEi0PSfMWis5kAG2SfhNxR+nEGJ0JlFDBg
        7XNceyuyUm+MYNDkDXad0thlTFGAkNcUQesp83fw60yKaQjgL5uEBNlr1ZlmKvNKIxzia1
        MHPjLqode15kaFi+YIuxOcdsrUJkjN4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-619-t37ddbngOHOr1NtMTjiYhg-1; Mon, 13 Jun 2022 05:19:21 -0400
X-MC-Unique: t37ddbngOHOr1NtMTjiYhg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2B90A101E9BE;
        Mon, 13 Jun 2022 09:19:21 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.62])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 201EC492CA2;
        Mon, 13 Jun 2022 09:19:19 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <YqSQ++8UnEW0AJ2y@zeniv-ca.linux.org.uk>
References: <YqSQ++8UnEW0AJ2y@zeniv-ca.linux.org.uk> <YqRyL2sIqQNDfky2@debian> <YqSGv6uaZzLxKfmG@zeniv-ca.linux.org.uk> <YqSMmC/UuQpXdxtR@zeniv-ca.linux.org.uk>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     dhowells@redhat.com, Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Mike Marshall <hubcap@omnibond.com>,
        Gao Xiang <xiang@kernel.org>, linux-afs@lists.infradead.org,
        v9fs-developer@lists.sourceforge.net, devel@lists.orangefs.org,
        linux-erofs@lists.ozlabs.org, linux-cachefs@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: mainline build failure due to 6c77676645ad ("iov_iter: Fix iter_xarray_get_pages{,_alloc}()")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1075695.1655111958.1@warthog.procyon.org.uk>
Date:   Mon, 13 Jun 2022 10:19:18 +0100
Message-ID: <1075696.1655111958@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Al Viro <viro@zeniv.linux.org.uk> wrote:

> The reason we can't overflow on multiplication there, BTW, is that we have
> nr <= count, and count has come from weirdly open-coded
> 	DIV_ROUND_UP(size + offset, PAGE_SIZE)
> IMO we'd better make it explicit, so how about the following:
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

It seems reasonable.

Reviewed-by: David Howells <dhowells@redhat.com>

