Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C929B75F2E5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jul 2023 12:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjGXKVU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jul 2023 06:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232507AbjGXKUo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jul 2023 06:20:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C8746A65
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jul 2023 03:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690193537;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XJJqbAsGZ2ehnnTZu14c2K+SnyqCmDMTRhvoD60EmdU=;
        b=WvsoVKqmSPYSsmBGxBJiNIelvLjhXLmNoBcYqxh793gssTUVeMNsmeJEsjYwMT1q6yu2li
        ih2Uw2WeSf8As1sxw2b55eu8r+vJjqCWsMmqsSaRO5DQCkViN02Rzov6a6USKdYwMw3/aQ
        F3g00CCiJmw1guMz/gTQ3UGmErbnfco=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-9-b8po-l80PvyskH4PwWe_jA-1; Mon, 24 Jul 2023 06:12:14 -0400
X-MC-Unique: b8po-l80PvyskH4PwWe_jA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 930D7185A793;
        Mon, 24 Jul 2023 10:12:13 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.116])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C0FA240BB42;
        Mon, 24 Jul 2023 10:12:12 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <7854000d2ce5ac32b75782a7c4574f25a11b573d.1689757133.git.jstancek@redhat.com>
References: <7854000d2ce5ac32b75782a7c4574f25a11b573d.1689757133.git.jstancek@redhat.com>
To:     Jan Stancek <jstancek@redhat.com>
Cc:     dhowells@redhat.com, kuba@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        brauner@kernel.org, viro@zeniv.linux.org.uk
Subject: Re: [PATCH] splice, net: Fix splice_to_socket() for O_NONBLOCK socket
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <64433.1690193532.1@warthog.procyon.org.uk>
Date:   Mon, 24 Jul 2023 11:12:12 +0100
Message-ID: <64434.1690193532@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
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

> LTP sendfile07 [1], which expects sendfile() to return EAGAIN when
> transferring data from regular file to a "full" O_NONBLOCK socket,
> started failing after commit 2dc334f1a63a ("splice, net: Use
> sendmsg(MSG_SPLICE_PAGES) rather than ->sendpage()").
> sendfile() no longer immediately returns, but now blocks.
> 
> Removed sock_sendpage() handled this case by setting a MSG_DONTWAIT
> flag, fix new splice_to_socket() to do the same for O_NONBLOCK sockets.

Does this actually work correctly in all circumstances?

The problem might come if you have a splice from a non-rewindable source
through a temporary pipe (eg. sendfile() using splice_direct_to_actor()).

David

