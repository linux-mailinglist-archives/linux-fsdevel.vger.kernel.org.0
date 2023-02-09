Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E896D6905B1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Feb 2023 11:52:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjBIKwJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Feb 2023 05:52:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbjBIKvr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Feb 2023 05:51:47 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60801BB9B
        for <linux-fsdevel@vger.kernel.org>; Thu,  9 Feb 2023 02:50:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675939838;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OrQQHtY7O4zrlVfEV1xBrch5kOsYqRzl4pw7MUIp6KA=;
        b=d87odPyEujs8zlekik1+QfBe02+NszOyqAOdU1iClOhZt0YoDwndpJK/rLIOrBQ7a9XtR4
        M1d+gYJOOMuctEG1VQoqvv/ggxjEsWyDMwfd3MODM9Ydhcjiuee8IZTNzndxfNvn11C8fg
        nt28qU9ae0pEtfrr/mS1KetTFEAiUwo=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-618-svFHyts6NsWU8Foqus1Plw-1; Thu, 09 Feb 2023 05:50:34 -0500
X-MC-Unique: svFHyts6NsWU8Foqus1Plw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7F9AC3C0F19E;
        Thu,  9 Feb 2023 10:50:33 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5534018EC1;
        Thu,  9 Feb 2023 10:50:31 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <Y+PLrOM05FMCiTIg@infradead.org>
References: <Y+PLrOM05FMCiTIg@infradead.org> <Y+MydH2HZ7ihITli@infradead.org> <20230207171305.3716974-1-dhowells@redhat.com> <20230207171305.3716974-2-dhowells@redhat.com> <176199.1675872591@warthog.procyon.org.uk>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     dhowells@redhat.com, Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org,
        syzbot+a440341a59e3b7142895@syzkaller.appspotmail.com,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v12 01/10] vfs, iomap: Fix generic_file_splice_read() to avoid reversion of ITER_PIPE
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <531131.1675939830.1@warthog.procyon.org.uk>
Date:   Thu, 09 Feb 2023 10:50:30 +0000
Message-ID: <531132.1675939830@warthog.procyon.org.uk>
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

Christoph Hellwig <hch@infradead.org> wrote:

> I defintively like the idea of killing ITER_PIPE.  Isn't the 16
> folios in a folio tree often much less than what we could fit into
> a single pipe buf?  Unless you have a file system that can use
> huge folios for buffered I/O and actually does this might significantly
> limit performance.

There's a loop there that repeats the filemap_get_pages() until either the
pipe is full or we hit EOF, the same as in filemap_read() (upon which this is
based).

I want to use filemap_get_pages() if I can as that does all the readahead
stuff.  What might be nice, though, is if I could tell it to return rather
than waiting for a folio to come uptodate if it has already returned a folio
so that I can push the other side of the splice along whilst the read is in
progress.

David

