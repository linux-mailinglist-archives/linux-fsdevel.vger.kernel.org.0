Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E25A587F40
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Aug 2022 17:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233482AbiHBPt7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Aug 2022 11:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234193AbiHBPtt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Aug 2022 11:49:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6D7C715FF2
        for <linux-fsdevel@vger.kernel.org>; Tue,  2 Aug 2022 08:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659455387;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cQqbHCG8ZH5ChVYrNhYb9JE5XK21Qe8P59arDR90TjQ=;
        b=ApXgiWuTIVjIJoiYKrK8qDGIyvD6lYE9H1YZn9x3idjFxsisi+n1iZ06JahYdSmnS1VaZW
        LPZr4B9E6hHBe2tFjYp7NGGNiN9tMzHoegTn9lsXduz1+hKkzO95TnN4xkF6w7qviBazOY
        tEFdj0JnFagWDnlI5ZQoZhmgXRtaqJU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-417-jgTRQev1OmeX1lRJ88FI-Q-1; Tue, 02 Aug 2022 11:49:44 -0400
X-MC-Unique: jgTRQev1OmeX1lRJ88FI-Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 06EA51C14484;
        Tue,  2 Aug 2022 15:49:44 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.10])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5D46F2026D4C;
        Tue,  2 Aug 2022 15:49:43 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAB9dFdsSHwVo6j=+z=4yiTRSJiOeKpFB4QHf6fqrLRuuAa3+JQ@mail.gmail.com>
References: <CAB9dFdsSHwVo6j=+z=4yiTRSJiOeKpFB4QHf6fqrLRuuAa3+JQ@mail.gmail.com> <165911277121.3745403.18238096564862303683.stgit@warthog.procyon.org.uk> <165911278430.3745403.16526310736054780645.stgit@warthog.procyon.org.uk>
To:     Marc Dionne <marc.dionne@auristor.com>
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-fsdevel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] afs: Fix access after dec in put functions
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3457235.1659455382.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Tue, 02 Aug 2022 16:49:42 +0100
Message-ID: <3457236.1659455382@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Marc Dionne <marc.dionne@auristor.com> wrote:

> > -       trace_afs_server(server, r - 1, atomic_read(&server->active), =
reason);
> > +       trace_afs_server(server->debug_id, r - 1, a, reason);
> =

> Don't you also want to copy server->debug_id into a local variable here?

Bah.  Yes.

David

