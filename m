Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86B9A75FB0F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jul 2023 17:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbjGXPoz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jul 2023 11:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjGXPoy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jul 2023 11:44:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7CA10D
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jul 2023 08:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690213452;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8GyEE2LRs2/NufDXzm3a3Uj5OTnKsHjyZ7MI7G6a/wM=;
        b=MbW+Y0VDLBlJTEvpi0KOAb5jke71CinS0Equ8RNbfrKrv0Ig7u02AkLZmC+z4N/FtDhOPG
        yY9svYufIE4cykj9LWT6KAR4AXaPPu65JlyaQhKj2CS0D+sAkfW6/KLIAVa7j3f1qJB0z8
        Mi1asGLSTR1kVhpuPA9l4ush6HoeS7o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-633-mFyLxJVmPo26-LDlQZGELw-1; Mon, 24 Jul 2023 11:44:09 -0400
X-MC-Unique: mFyLxJVmPo26-LDlQZGELw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 05B2F800B35;
        Mon, 24 Jul 2023 15:44:09 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.205])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 32E8AC2C7D3;
        Mon, 24 Jul 2023 15:44:08 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAASaF6yKxWaW6me0Y+vSEo0qUm_LTyL5CPVka75EPg_yq4MO9g@mail.gmail.com>
References: <CAASaF6yKxWaW6me0Y+vSEo0qUm_LTyL5CPVka75EPg_yq4MO9g@mail.gmail.com> <7854000d2ce5ac32b75782a7c4574f25a11b573d.1689757133.git.jstancek@redhat.com> <64434.1690193532@warthog.procyon.org.uk>
To:     Jan Stancek <jstancek@redhat.com>
Cc:     dhowells@redhat.com, kuba@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        brauner@kernel.org, viro@zeniv.linux.org.uk
Subject: Re: [PATCH] splice, net: Fix splice_to_socket() for O_NONBLOCK socket
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <10686.1690213447.1@warthog.procyon.org.uk>
Date:   Mon, 24 Jul 2023 16:44:07 +0100
Message-ID: <10687.1690213447@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jan Stancek <jstancek@redhat.com> wrote:

> On Mon, Jul 24, 2023 at 12:12 PM David Howells <dhowells@redhat.com> wrote:
> >
> > Jan Stancek <jstancek@redhat.com> wrote:
> >
> > > LTP sendfile07 [1], which expects sendfile() to return EAGAIN when
> > > transferring data from regular file to a "full" O_NONBLOCK socket,
> > > started failing after commit 2dc334f1a63a ("splice, net: Use
> > > sendmsg(MSG_SPLICE_PAGES) rather than ->sendpage()").
> > > sendfile() no longer immediately returns, but now blocks.
> > >
> > > Removed sock_sendpage() handled this case by setting a MSG_DONTWAIT
> > > flag, fix new splice_to_socket() to do the same for O_NONBLOCK sockets.
> >
> > Does this actually work correctly in all circumstances?
> >
> > The problem might come if you have a splice from a non-rewindable source
> > through a temporary pipe (eg. sendfile() using splice_direct_to_actor()).
> 
> I assumed this was safe, since sendfile / splice_direct_to_actor()
> requires input to be seekable.

Ah!  The test isn't where I was looking for it (in sendfile()) - it's in
splice_direct_to_actor().

I wonder if it's worth making that explicit in do_sendfile() as the
requirement doesn't hold if the output is a pipe (though in such a case,
there's an explicit buffer, so it's not actually a problem).

Anyway, did you want to post this to netdev too so that the networking tree
picks it up?  Feel free to add:

Acked-by: David Howells <dhowells@redhat.com>

