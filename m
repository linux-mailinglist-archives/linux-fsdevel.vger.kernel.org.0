Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3580A68A42D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Feb 2023 22:04:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233687AbjBCVEb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Feb 2023 16:04:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233010AbjBCVCs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Feb 2023 16:02:48 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A2AA9D47
        for <linux-fsdevel@vger.kernel.org>; Fri,  3 Feb 2023 13:00:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675458046;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aKXJEFVHJON2UjnvEtbejGTqV0qCsLQRv/6cKDxwOv0=;
        b=IYZO9kop/X+TSBucvZqx335IfOpoBcB813cXlamC9+xd6WUbJAjw6sveprapy5G4AYw8qh
        dFT0rMHi3vEBxLVmOu0xisJJPu2OZAMr5e1g+r1afQuLQBee4Bn4RBIpMrV6/Snaxpo868
        nkFMItbsb1lYHTFzALB2AHeXf2zJYBk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-230-9wiaw-oyMxyIbBUIK09_ZA-1; Fri, 03 Feb 2023 16:00:42 -0500
X-MC-Unique: 9wiaw-oyMxyIbBUIK09_ZA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8A4C8185A7A4;
        Fri,  3 Feb 2023 21:00:41 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.97])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 815FB492B15;
        Fri,  3 Feb 2023 21:00:39 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <Y9sJ7Nuubw1U4M6u@gondor.apana.org.au>
References: <Y9sJ7Nuubw1U4M6u@gondor.apana.org.au> <Y9ooW52m0Afnhj7Z@gondor.apana.org.au> <312908.1675262203@warthog.procyon.org.uk>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     dhowells@redhat.com, smfrench@gmail.com, viro@zeniv.linux.org.uk,
        nspmangalore@gmail.com, rohiths.msft@gmail.com, tom@talpey.com,
        metze@samba.org, hch@infradead.org, willy@infradead.org,
        jlayton@kernel.org, linux-cifs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        sfrench@samba.org, linux-crypto@vger.kernel.org
Subject: Re: [PATCH 05/12] cifs: Add a function to Hash the contents of an iterator
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2126749.1675458038.1@warthog.procyon.org.uk>
Date:   Fri, 03 Feb 2023 21:00:38 +0000
Message-ID: <2126750.1675458038@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Herbert Xu <herbert@gondor.apana.org.au> wrote:

> Were you also deleting shash code in another patch that wasn't
> cc'ed to me?

No, I don't want to change it this late into the dev cycle.  I can look at it
after the merge window.

David

