Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06BFF67C7C5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jan 2023 10:50:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236834AbjAZJu3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Jan 2023 04:50:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236830AbjAZJuZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Jan 2023 04:50:25 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33FA55D90C
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Jan 2023 01:49:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674726577;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EG/449qSmt5dxUptSk+N35YPkCWa7qDSTbYqeA0hffw=;
        b=jOmgHidM5+7lK+7AyjK6cm0hUW9Si64ImzedYnF8GWfp8y8DkimjWX+9Y/zcovtpK18/G/
        LoGZnWNvvOtpsT+wpr9mv0X1QubXAiKxYCYHdpli6PQThbn8HAa7gvq8MfhLp2tzzhXbka
        hatWI9aJDNTkFuDlYRJ3uwdmyW9Yrx8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-571-_19ox34JNBWf8p6rKRDejQ-1; Thu, 26 Jan 2023 04:49:30 -0500
X-MC-Unique: _19ox34JNBWf8p6rKRDejQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 87602830F51;
        Thu, 26 Jan 2023 09:49:29 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.97])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6ED69492B01;
        Thu, 26 Jan 2023 09:49:27 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <af0e448a-9559-32c0-cc59-10b159459495@redhat.com>
References: <af0e448a-9559-32c0-cc59-10b159459495@redhat.com> <20230125210657.2335748-1-dhowells@redhat.com> <20230125210657.2335748-2-dhowells@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     dhowells@redhat.com, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v10 1/8] iov_iter: Define flags to qualify page extraction.
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2613248.1674726566.1@warthog.procyon.org.uk>
Date:   Thu, 26 Jan 2023 09:49:26 +0000
Message-ID: <2613249.1674726566@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

David Hildenbrand <david@redhat.com> wrote:

> Just a note that the usage of new __bitwise types instead of "unsigned" is
> encouraged for flags.
> 
> See rmap_t in include/linux/rmap.h as an example.

Hmmm...  rmap_t really ought to be unsigned int.

David

