Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4520C67E1B4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jan 2023 11:34:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231730AbjA0Keu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Jan 2023 05:34:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231656AbjA0Ket (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Jan 2023 05:34:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE2E1783C7
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Jan 2023 02:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674815645;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=u+/yFPPvsEZpmFbWdjFg8hLHUX6xZBa6WmoB9gZbRd4=;
        b=XKc1LtJqHw+23fr9XxauC/jB0Q8VabaUlUv4nQcj/nN4KQ/Xvr3Bh7mCexR7L78h2TtJ2S
        MiMxdvCGslN8U9SemHccPZC81pmkI1n0hiqaGpZHaS0NOycn1mngfWaFxYm9dd/IPOdySr
        AthBoMfxwnlJZt90f3T0bMN+vJYLknw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-397-kyQwVip6MDW_a75bkbbpNQ-1; Fri, 27 Jan 2023 05:34:01 -0500
X-MC-Unique: kyQwVip6MDW_a75bkbbpNQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ACCC28030DE;
        Fri, 27 Jan 2023 10:34:00 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.97])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AC0E82166B26;
        Fri, 27 Jan 2023 10:33:58 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <Y9Om95NlPTFiHMSj@gondor.apana.org.au>
References: <Y9Om95NlPTFiHMSj@gondor.apana.org.au>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     dhowells@redhat.com, smfrench@gmail.com, viro@zeniv.linux.org.uk,
        nspmangalore@gmail.com, rohiths.msft@gmail.com, tom@talpey.com,
        metze@samba.org, hch@infradead.org, willy@infradead.org,
        jlayton@kernel.org, linux-cifs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        sfrench@samba.org, linux-crypto@vger.kernel.org
Subject: Re: [RFC 06/13] cifs: Add a function to Hash the contents of an iterator
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2957462.1674815638.1@warthog.procyon.org.uk>
Date:   Fri, 27 Jan 2023 10:33:58 +0000
Message-ID: <2957463.1674815638@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Herbert Xu <herbert@gondor.apana.org.au> wrote:

> Please convert this to ahash.  The whole point of shash is to
> process *small* amounts of data that is not on an SG list.

Is ahash offloaded to another thread or hardware?

David

