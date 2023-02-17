Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9E369A6A1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Feb 2023 09:09:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjBQIJ4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Feb 2023 03:09:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbjBQIJh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Feb 2023 03:09:37 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BA3A769A
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Feb 2023 00:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676621331;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oj3qHyJXPrt95ESZEYz+HIUZYia6cHmkbLgbrVa/onk=;
        b=IC7yu5wG4PMgT4w7WIW0LM7+ppjGawhppWfYQBKeUI3ET7mn1x9xeU7iEC3z3ylU8M73tn
        ieuR7rEUAg1fjDB77A0ZHy4FSoXGj1xaGUkD7fwyiTGawlJHzMNaxNBOJey80XblaHJMVc
        XmIuh4Ep0oQWT55VkGBk1x+4xWdpmaU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-17-QBH5zj9SMgCu1xXomTCUeQ-1; Fri, 17 Feb 2023 03:08:45 -0500
X-MC-Unique: QBH5zj9SMgCu1xXomTCUeQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C0B0E800B24;
        Fri, 17 Feb 2023 08:08:44 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 889A4492C14;
        Fri, 17 Feb 2023 08:08:42 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAH2r5msNJTdt7295xt=NVY7wUaWFycKMb_=7d9LySsGGwBTnjQ@mail.gmail.com>
References: <CAH2r5msNJTdt7295xt=NVY7wUaWFycKMb_=7d9LySsGGwBTnjQ@mail.gmail.com> <20230216214745.3985496-1-dhowells@redhat.com> <20230216214745.3985496-15-dhowells@redhat.com>
To:     Steve French <smfrench@gmail.com>
Cc:     dhowells@redhat.com, Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Tom Talpey <tom@talpey.com>,
        Stefan Metzmacher <metze@samba.org>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>, linux-cifs@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Steve French <sfrench@samba.org>, Paulo Alcantara <pc@cjr.nz>
Subject: Re: [PATCH 14/17] cifs: Change the I/O paths to use an iterator rather than a page list
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4008034.1676621321.1@warthog.procyon.org.uk>
Date:   Fri, 17 Feb 2023 08:08:41 +0000
Message-ID: <4008035.1676621321@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Steve French <smfrench@gmail.com> wrote:

> WARNING: Consider removing the code enclosed by this #if 0 and its #endif
> #627: FILE: fs/cifs/file.c:2609:
> +#if 0 // TODO: Remove for iov_iter support
> ...
> WARNING: Consider removing the code enclosed by this #if 0 and its #endif
> #1040: FILE: fs/cifs/file.c:3512:
> +#if 0 // TODO: Remove for iov_iter support
> 
> WARNING: Consider removing the code enclosed by this #if 0 and its #endif
> #1067: FILE: fs/cifs/file.c:3587:
> +#if 0 // TODO: Remove for iov_iter support
> 
> WARNING: Consider removing the code enclosed by this #if 0 and its #endif
> #1530: FILE: fs/cifs/file.c:4217:
> +#if 0 // TODO: Remove for iov_iter support
> 
> WARNING: Consider removing the code enclosed by this #if 0 and its #endif
> #1837: FILE: fs/cifs/file.c:4903:
> +#if 0 // TODO: Remove for iov_iter support

These chunks of code are removed in patch 16.  I did it this way to reduce the
size of patch 14.  I can merge 16 into 14 if you like.

David

