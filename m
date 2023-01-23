Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C29CB677785
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jan 2023 10:39:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbjAWJjh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Jan 2023 04:39:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbjAWJjg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Jan 2023 04:39:36 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D21616311
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jan 2023 01:38:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674466731;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ixSJusIFQ4NVoWX42WPNCvu85KHc9tvBEAxhegQcVhQ=;
        b=MWaRlY0pLtDIB2y+t5MY3lSE9UyE4vCbHfCO/4fk9Tk09nmYRN6nUTuFo2xf3jPuB7RhlA
        o2/ZAQtsfn8o3hG2HKoBjzSyYVpzsHUACSgCCvoKLSyV7ayYtTWc+1KGlpjs1mM5jb+Wql
        XhgsEvLx6xjDUb7sCllGcucfUB7r78w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-493-SYChFTcDOrG4mOHNetySMw-1; Mon, 23 Jan 2023 04:38:48 -0500
X-MC-Unique: SYChFTcDOrG4mOHNetySMw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 98F61802BEE;
        Mon, 23 Jan 2023 09:38:47 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1054A492C3C;
        Mon, 23 Jan 2023 09:38:45 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <Y8vi8/sCvOxvLzzc@infradead.org>
References: <Y8vi8/sCvOxvLzzc@infradead.org> <20230120175556.3556978-1-dhowells@redhat.com> <20230120175556.3556978-5-dhowells@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     dhowells@redhat.com, Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v7 4/8] block: Rename BIO_NO_PAGE_REF to BIO_PAGE_REFFED and invert the meaning
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3668656.1674466725.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Mon, 23 Jan 2023 09:38:45 +0000
Message-ID: <3668657.1674466725@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
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

> ... I've put together a version of this series that implements this and =
my
> other suggestions here:
> =

> http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/dio-pin-=
pages
> =

> This also tests fine with xfs and btrfs and nvme passthrough I/O.

That looks okay.  Do you need to put a Co-developed-by tag on the "block:
invert BIO_NO_PAGE_REF" patch?

Should I take that set of patches and send it on to Linus when the window
opens?  Or should it go through the block tree?

David

