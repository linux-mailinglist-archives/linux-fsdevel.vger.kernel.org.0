Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7A9644BDD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Dec 2022 19:37:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbiLFShE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Dec 2022 13:37:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiLFSgo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Dec 2022 13:36:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E5FE4
        for <linux-fsdevel@vger.kernel.org>; Tue,  6 Dec 2022 10:35:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670351747;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BPCIfnbDBpjs4efIHZ8WUm5LDTwrZwzaxy+bAhXeEOE=;
        b=SuYDNXbU3smfVW+oXNUL7Hg1ZpgEvyBoQjfFw9xbv0esL8XJiS9zLAS0JpC60paJOu67XA
        fpN5D6og1uL9drknD9gdZbFOe17OUNvY2ELoANRm9nCaH0qi4KBgeFzcqkQ17sPXlITKm+
        UsEynXhffazUmaNZEyI5C+in3Po5ang=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-475-RMqL0D19PX-y6CNUMWUZug-1; Tue, 06 Dec 2022 13:35:42 -0500
X-MC-Unique: RMqL0D19PX-y6CNUMWUZug-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0EB94811E75;
        Tue,  6 Dec 2022 18:35:42 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9D27A492B04;
        Tue,  6 Dec 2022 18:35:40 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <0d62615c-57d1-922b-5ebc-32faabf33327@deltatee.com>
References: <0d62615c-57d1-922b-5ebc-32faabf33327@deltatee.com> <166997419665.9475.15014699817597102032.stgit@warthog.procyon.org.uk> <166997421646.9475.14837976344157464997.stgit@warthog.procyon.org.uk>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     dhowells@redhat.com, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Christoph Hellwig <hch@infradead.org>,
        Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/4] iov_iter: Add a function to extract a page list from an iterator
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1251302.1670351737.1@warthog.procyon.org.uk>
Date:   Tue, 06 Dec 2022 18:35:37 +0000
Message-ID: <1251303.1670351737@warthog.procyon.org.uk>
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

Logan Gunthorpe <logang@deltatee.com> wrote:

> If this is going to be a general replacement for iov_iter_get_pages()
> it's going to need to pass through gup_flags. My recent patchset added
> versions with these and I think it should be in during the next merge
> cycle. [1]

Cool.  Note that the current iov_iter_get_pages2() is broken, which is why Al
wanted a replacement.  It should not be taking a ref on the pages in an
XARRAY, BVEC or PIPE - and it should be pinning rather than getting a ref on
pages in IOVEC or UBUF if the buffer is being read into.  I'm guessing that
your changes move the latter decision to the caller?

David

