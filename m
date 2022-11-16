Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBB2762C554
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Nov 2022 17:49:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239107AbiKPQtg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Nov 2022 11:49:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239097AbiKPQtP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Nov 2022 11:49:15 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCD5259FE0
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Nov 2022 08:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668617090;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Vn9m3rj2kqdem1WbACb6Q4QajYOE526df9uBU7hO3xU=;
        b=JPAnKNnY9p6os96q3CefMiePx2gU72l1xfSP49NQkTcwyH5naYAyVkDMSdZVb7n3MYQa+O
        kDWNLyoGydyY7WcyQ3m2gqC5gS/+E0SnlHZL/jFPiKb58wtlyUp2UamD43H6bA9Fcs7/sX
        GhfX0hA+Gun8GXQdMCfl90u7TtSm8Gw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-635-_qfa9JPVNk-CInVU9MSmhQ-1; Wed, 16 Nov 2022 11:44:46 -0500
X-MC-Unique: _qfa9JPVNk-CInVU9MSmhQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 08AD38027EB;
        Wed, 16 Nov 2022 16:44:45 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9B39E2028CE4;
        Wed, 16 Nov 2022 16:44:42 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <c4f8959b-15c5-b32f-18fc-8befb4f75da2@samba.org>
References: <c4f8959b-15c5-b32f-18fc-8befb4f75da2@samba.org> <166855224228.1998592.2212551359609792175.stgit@warthog.procyon.org.uk> <3609b064-175c-fc18-cd1a-e177d0349c58@samba.org> <CAKYAXd-Eym2D+92Vh=W=-LLVZ+WLVuvLZxqjJiUGZSykBpQdkg@mail.gmail.com>
To:     Stefan Metzmacher <metze@samba.org>
Cc:     dhowells@redhat.com, Namjae Jeon <linkinjeon@kernel.org>,
        smfrench@gmail.com, tom@talpey.com, Long Li <longli@microsoft.com>,
        linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cifs: Fix problem with encrypted RDMA data read
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3387132.1668617079.1@warthog.procyon.org.uk>
Date:   Wed, 16 Nov 2022 16:44:39 +0000
Message-ID: <3387133.1668617079@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Stefan Metzmacher <metze@samba.org> wrote:

> But the core of it is a client security problem, shown in David's capture in
> frame 100.

Does the client actually know about the server's settings, though?

David

