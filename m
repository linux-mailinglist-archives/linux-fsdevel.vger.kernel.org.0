Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E87477B980
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Aug 2023 15:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbjHNNOJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Aug 2023 09:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbjHNNOE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Aug 2023 09:14:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B13C9E71
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Aug 2023 06:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692018798;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=isiG484zzCuLoyRUFKL6De9VKMSnc0IGGZzsm/pASx8=;
        b=Gvi2NFBkB2dzc3mhb9hd1TMfh2k2WiPIyc1eUn4dRlgbOOTvlJDxq7OX+SBJ/SmrHPaxHx
        zS+QLo5pj314NH1tVyDIQGmjFhBD/7BLConm3BE/O91uuOWL7cSO5emH202lBA/IEAbgQs
        ZtoeMJTTneQTFTyjdYOaSzH8gbTsPSA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-611-ZaxUL9r3NBeKF3Hn7XEVaQ-1; Mon, 14 Aug 2023 09:13:13 -0400
X-MC-Unique: ZaxUL9r3NBeKF3Hn7XEVaQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C4DAB85D063;
        Mon, 14 Aug 2023 13:13:12 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.13])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4236D2026D68;
        Mon, 14 Aug 2023 13:13:10 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAHk-=whsKN50RfZAP4EL12djwvMiWYKTca_5AYxPnHNzF7ffvg@mail.gmail.com>
References: <CAHk-=whsKN50RfZAP4EL12djwvMiWYKTca_5AYxPnHNzF7ffvg@mail.gmail.com> <3710261.1691764329@warthog.procyon.org.uk> <CAHk-=wi1QZ+zdXkjnEY7u1GsVDaBv8yY+m4-9G3R34ihwg9pmQ@mail.gmail.com> <3888331.1691773627@warthog.procyon.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dhowells@redhat.com, Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Christian Brauner <christian@brauner.io>,
        Matthew Wilcox <willy@infradead.org>, jlayton@kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] iov_iter: Convert iterate*() to inline funcs
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4032544.1692018789.1@warthog.procyon.org.uk>
Date:   Mon, 14 Aug 2023 14:13:09 +0100
Message-ID: <4032545.1692018789@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> wrote:

> 
> So I think you need to remove the changes you did to
> memcpy_from_iter(). The old code was an explicit conditional of direct
> calls:
> 
>         if (iov_iter_is_copy_mc(i))
>                 return (void *)copy_mc_to_kernel(to, from, size);
>         return memcpy(to, from, size);
> 
> and now you do that
> 
>                                    iov_iter_is_copy_mc(i) ?
>                                    memcpy_from_iter_mc : memcpy_from_iter);
> 
> to pass in a function pointer.
> 
> Not ok. Not ok at all. It may look clever, but function pointers are
> bad. Avoid them like the plague.

Yeah.  I was hoping that the compiler would manage to inline that, but it just
does an indirect call.  I'm trying to avoid passing the iterator as that makes
things bigger.  I think I can probably share the extra argument used for
passing checksums.

David

