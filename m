Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76EF86662B4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jan 2023 19:22:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238344AbjAKSV1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Jan 2023 13:21:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235725AbjAKSVO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Jan 2023 13:21:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75B613724A
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Jan 2023 10:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673461226;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T37CrOqOXpI4z+GZ/E4PVC5qfTmSIj95zZprjxSan00=;
        b=PfqS7170+l4ufHhrDF5stVR13FdYJH5rkDsP72wg3N28cOLN8hTiPW1i7xGyWJzMY2wYXN
        MoU7DAV3+6tdF9CXQO0XhcCCjRYFlEQmLqXGY2huAT4dEwExIcTVtouu6+qyhY5AdACuQh
        8kP84WOUYjygwmVIIH9ZkUR+RzUcrmo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-170-ahchqIz4Mb-XMmMJ4KZAuA-1; Wed, 11 Jan 2023 13:20:23 -0500
X-MC-Unique: ahchqIz4Mb-XMmMJ4KZAuA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 86088857F82;
        Wed, 11 Jan 2023 18:20:22 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.87])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 09245422A9;
        Wed, 11 Jan 2023 18:20:20 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <185a206e3b0.2e1071428037.6356107010427889199@siddh.me>
References: <185a206e3b0.2e1071428037.6356107010427889199@siddh.me> <20230111161934.336743-1-code@siddh.me> <2433039.1673455048@warthog.procyon.org.uk>
To:     Siddh Raman Pant <code@siddh.me>
Cc:     dhowells@redhat.com, "mauro carvalho chehab" <mchehab@kernel.org>,
        "randy dunlap" <rdunlap@infradead.org>,
        "jonathan corbet" <corbet@lwn.net>,
        "fabio m. de francesco" <fmdefrancesco@gmail.com>,
        "eric dumazet" <edumazet@google.com>,
        "christophe jaillet" <christophe.jaillet@wanadoo.fr>,
        "eric biggers" <ebiggers@kernel.org>,
        "keyrings" <keyrings@vger.kernel.org>,
        "linux-security-module" <linux-security-module@vger.kernel.org>,
        "linux-fsdevel" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] kernel/watch_queue: NULL the dangling *pipe, and use it for clear check
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2438919.1673461220.1@warthog.procyon.org.uk>
Date:   Wed, 11 Jan 2023 18:20:20 +0000
Message-ID: <2438920.1673461220@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Siddh Raman Pant <code@siddh.me> wrote:

> All tests in tests/ pass except features/builtin_trusted, which
> fails even without the patch. (Failure log: https://pastebin.com/SGgAbzXp)

Don't worry about that one.  That requires some kernel preparation.

David

