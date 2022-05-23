Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6110E530961
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 May 2022 08:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbiEWGMk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 May 2022 02:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236775AbiEWGMK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 May 2022 02:12:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A19402ED5F
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 May 2022 23:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653286323;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zdXvbxe9TBvQlL5k5IXJSGdtX0v6lNlLaY17sAtSeoo=;
        b=DxgxXviYrTJ/lZA6Z72kBitugwo4ZfbPWYN8Bl0Vd0Gxz/KVtDINQXGzyfRVSkRmYmE7GR
        mtBhYIBt2/IhVGRfUpGX605paH4fxFjaAIX/tRoqL1FQJzlPsmlErWOK6ZrwwajlXlCwyf
        d55U5j9PsLTir+/PJLLvGPIXXkx3568=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-520--Ln86PXDPeW6kkOhtvqsjg-1; Mon, 23 May 2022 02:08:52 -0400
X-MC-Unique: -Ln86PXDPeW6kkOhtvqsjg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9F6C7384F801;
        Mon, 23 May 2022 06:08:51 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C42B2C27E97;
        Mon, 23 May 2022 06:08:49 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <e5f6fee5518ce8e1b4fc5aa7038de1617a341c2f.camel@kernel.org>
References: <e5f6fee5518ce8e1b4fc5aa7038de1617a341c2f.camel@kernel.org> <165296980082.3595490.3561111064004493810.stgit@warthog.procyon.org.uk>
To:     Jeff Layton <jlayton@kernel.org>, Xiubo Li <xiubli@redhat.com>
Cc:     dhowells@redhat.com, Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        David Wysochanski <dwysocha@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        v9fs-developer@lists.sourceforge.net, ceph-devel@vger.kernel.org,
        linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
        linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] netfs: ->cleanup() op is always given a rreq pointer now
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <460692.1653286129.1@warthog.procyon.org.uk>
Date:   Mon, 23 May 2022 07:08:49 +0100
Message-ID: <460693.1653286129@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jeff Layton <jlayton@kernel.org> wrote:

> Do we need free_subrequest? It looks like nothing defines it in this
> series.

These two patches add stuff that's used by stuff on my netfs-lib branch, but
that's not going to be pushed this window, so I won't push these two patches
for now.

David

