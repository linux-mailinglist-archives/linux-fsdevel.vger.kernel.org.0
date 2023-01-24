Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 790A1679BCE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 15:28:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234895AbjAXO2w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 09:28:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234765AbjAXO2v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 09:28:51 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A10CDC9
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jan 2023 06:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674570483;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hIS1K7niUqS6nIphS79ng1X59kXY7sWKmEnTl9Ur8D0=;
        b=Ox1N+6T5aqi7gLyVG2O16sbjqDTeuNDeUB+vv+WDACEirWD+J7NZvrXh0pI4ueyRRiWmjw
        iyq5TK3VfOOpxYOcnQqk5IXd+zhFsvnm6u1JgpdmzX/WWFpeyHnn5rb9W/LZxy7AeEUHbA
        i6xQG4W1+cgcvxxdY3W4ZbYiuhWrMmE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-510-YAv3yGWgMmi0PtpnGZgFIw-1; Tue, 24 Jan 2023 09:27:56 -0500
X-MC-Unique: YAv3yGWgMmi0PtpnGZgFIw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 082C03C0D861;
        Tue, 24 Jan 2023 14:27:56 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.97])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 691D0C15BA0;
        Tue, 24 Jan 2023 14:27:54 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <Y8/n1AdBwbYqp8lX@nvidia.com>
References: <Y8/n1AdBwbYqp8lX@nvidia.com> <Y8/kfPEp1GkZKklc@nvidia.com> <Y8/hhvfDtVcsgQd6@nvidia.com> <Y8/ZekMEAfi8VeFl@nvidia.com> <20230123173007.325544-1-dhowells@redhat.com> <20230123173007.325544-11-dhowells@redhat.com> <31f7d71d-0eb9-2250-78c0-2e8f31023c66@nvidia.com> <84721e8d-d40e-617c-b75e-ead51c3e1edf@nvidia.com> <852117.1674567983@warthog.procyon.org.uk> <852914.1674568628@warthog.procyon.org.uk> <859142.1674569510@warthog.procyon.org.uk>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     dhowells@redhat.com, John Hubbard <jhubbard@nvidia.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        linux-mm@kvack.org
Subject: Re: [PATCH v8 10/10] mm: Renumber FOLL_PIN and FOLL_GET down
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <864108.1674570473.1@warthog.procyon.org.uk>
Date:   Tue, 24 Jan 2023 14:27:53 +0000
Message-ID: <864109.1674570473@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jason Gunthorpe <jgg@nvidia.com> wrote:

> My point was to change that to take a 'bool unpin' because FOLL_PIN is
> not to be used outside gup.c

I need a 3-state wrapper.  But if I can't do it in gup.c, then I'll have to do
it elsewhere.  As Christoph says, most of the places will only be pinned or
not-pinned.  The whole point was to avoid generating new constants when
existing constants would do.

David.

