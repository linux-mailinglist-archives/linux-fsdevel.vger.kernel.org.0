Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 427ED7368D8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jun 2023 12:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbjFTKIW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jun 2023 06:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbjFTKIP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jun 2023 06:08:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47976A2
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jun 2023 03:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687255642;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mnUIleGLnJnV1R5zNo2NApBTcaLL4wPyP/w4+xH/thE=;
        b=LU8wF+rugnh9fS3ipJEmxreY3ZuLs7A+IPfOWAZDQyCn5Le/MrdL7h4vsnSXiRzVO8OklF
        tJtIwQCMzR0nfPFb8XdJkZEMcMouehUhZfo6nh5LoN5TjP/8zBjZaWT6CHbEXjTlsw2eu5
        woER/6Nw5tAXUALVoK9gWfLNKlpvGO4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-354-aMBqZ9_kPkqieAhNWuteVQ-1; Tue, 20 Jun 2023 06:07:21 -0400
X-MC-Unique: aMBqZ9_kPkqieAhNWuteVQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AE1F0810BB2;
        Tue, 20 Jun 2023 10:07:20 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0AD83200A398;
        Tue, 20 Jun 2023 10:07:19 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CANT5p=qDON8uO9z92xEcP16kvRdHrf84owmcb20MGZnOxT_xmg@mail.gmail.com>
References: <CANT5p=qDON8uO9z92xEcP16kvRdHrf84owmcb20MGZnOxT_xmg@mail.gmail.com>
To:     Shyam Prasad N <nspmangalore@gmail.com>
Cc:     dhowells@redhat.com, Matthew Wilcox <willy@infradead.org>,
        Steve French <smfrench@gmail.com>,
        CIFS <linux-cifs@vger.kernel.org>, linux-fsdevel@vger.kernel.org
Subject: Re: Hang seen with the latest mainline kernel
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1238459.1687255639.1@warthog.procyon.org.uk>
Date:   Tue, 20 Jun 2023 11:07:19 +0100
Message-ID: <1238460.1687255639@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Shyam Prasad N <nspmangalore@gmail.com> wrote:

> [Mon Jun 19 16:05:49 2023]  invalidate_inode_pages2+0x17/0x30
> [Mon Jun 19 16:05:49 2023]  cifs_invalidate_mapping+0x57/0x90 [cifs]
> [Mon Jun 19 16:05:49 2023]  cifs_revalidate_mapping+0xd5/0x130 [cifs]
> [Mon Jun 19 16:05:49 2023]  cifs_revalidate_dentry+0x32/0x40 [cifs]
> [Mon Jun 19 16:05:49 2023]  cifs_d_revalidate+0xa3/0x220 [cifs]
> [Mon Jun 19 16:05:49 2023]  lookup_fast+0xfc/0x1c0
> [Mon Jun 19 16:05:49 2023]  walk_component+0x39/0x240
> [Mon Jun 19 16:05:49 2023]  path_lookupat+0xb2/0x2f0
> [Mon Jun 19 16:05:49 2023]  filename_lookup+0x16f/0x340

You don't have a deadlock between two inode locks, do you?  The one on the
parent dir and the one on whatever is being invalidated.

Or between invalidate and a write.  It doesn't seem that it should be that,
since in both cases it should take the inode lock first and then PG_lock.

There's the possibility that we missed unlocking a page after splitting a
read or a write.

What's the testcase like?  Would it be feasible to trace page activity on smb
pages?  I have a patch to restrict the page count tracing to just trace the
page lock flag that I might be able to adapt.

David

