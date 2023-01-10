Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D7EA66437D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jan 2023 15:43:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232812AbjAJOnT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Jan 2023 09:43:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238330AbjAJOm4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Jan 2023 09:42:56 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAEF51CB2B
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Jan 2023 06:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673361732;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q7HvhAaAWNKOBG0AiE5jaW5da5KSq68kVSGiHSUvN0c=;
        b=gBp1TpjwGrGImH0QKmg3xkI8fsPZus6xlvdd45oSvuyxz76uVWmVQkcnqFsTPTcSpJOaKL
        o94wjng+ojvmbpRmYm5gvCA7lJubWl2GWV49GAZSsifIN1uTTjl+mFQpspmcpy/l42MO6f
        jcpAjBm474Ekfo/Nduj5IvIjvPCxT8E=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-519-WbUP3gRIOfqrYIs8gRKVrg-1; Tue, 10 Jan 2023 09:42:07 -0500
X-MC-Unique: WbUP3gRIOfqrYIs8gRKVrg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 62CF31C08790;
        Tue, 10 Jan 2023 14:42:06 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.87])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 14E3B422FE;
        Tue, 10 Jan 2023 14:42:04 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20230109172500.bd4z2incticapm7x@quack3>
References: <20230109172500.bd4z2incticapm7x@quack3> <d86e6340-534c-c34c-ab1d-6ebacb213bb9@kernel.dk> <167305160937.1521586.133299343565358971.stgit@warthog.procyon.org.uk> <167305166150.1521586.10220949115402059720.stgit@warthog.procyon.org.uk> <1880793.1673257404@warthog.procyon.org.uk>
To:     Jan Kara <jack@suse.cz>
Cc:     dhowells@redhat.com, Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 7/7] iov_iter, block: Make bio structs pin pages rather than ref'ing if appropriate
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2155892.1673361724.1@warthog.procyon.org.uk>
Date:   Tue, 10 Jan 2023 14:42:04 +0000
Message-ID: <2155893.1673361724@warthog.procyon.org.uk>
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

Jan Kara <jack@suse.cz> wrote:

> ... So filesystems really need DIO reads to use FOLL_PIN instead of FOLL_GET
> and consequently we need to pass information to bio completion function how
> page references should be dropped.

That information would be available in the bio struct with this patch if
necessary, though transcribed into a combination of BIO_* flags instead off
FOLL_* flags.

I wonder if there's the possibility of the filesystem that generated the bio
nicking the pages out of the bio and putting them itself.

David

