Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 692836A444D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Feb 2023 15:24:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbjB0OYW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Feb 2023 09:24:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbjB0OYV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Feb 2023 09:24:21 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0863EDBF8
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Feb 2023 06:23:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677507820;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=yg76FnkX04HHXW1mHvn8i4mIGRu2T9NZWGFYq1EPWQo=;
        b=D5iI7yYsKa4wrWfy6DzsLxkhR6hHcG5FMflz0kZa/sSQ8wym0IPPfnkie7KyfOPQDtlnhd
        0sDtz7PHqSKjAIXlBplbtjM8hatblf99YC9Fh1+Ow0KyL2DQzig72eoz3JiilCXHL0bwoQ
        rO13ITS773++PCxCJPV5eQOmBgeQJEE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-636-7dPZkuwNNC6edyeI5CsAig-1; Mon, 27 Feb 2023 09:23:35 -0500
X-MC-Unique: 7dPZkuwNNC6edyeI5CsAig-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8A5291C0418D;
        Mon, 27 Feb 2023 14:23:34 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2FFABC15BAD;
        Mon, 27 Feb 2023 14:23:33 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>,
        Miklos Szeredi <miklos@szeredi.hu>, Amit Shah <amit@kernel.org>
cc:     dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC][PATCH] splice: Prevent gifting of multipage folios
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2734057.1677507812.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Mon, 27 Feb 2023 14:23:32 +0000
Message-ID: <2734058.1677507812@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

    =

Don't let parts of multipage folios be gifted by (vm)splice into a pipe as
the other end may only be expecting single-page gifts (fuse and virtio
console for example).

replace_page_cache_folio(), for example, will do the wrong thing if it
tries to replace a single paged folio with a multipage folio.

Try to avoid this by making add_to_pipe() remove the gift flag on multipag=
e
folios.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Matthew Wilcox <willy@infradead.org>
cc: Miklos Szeredi <miklos@szeredi.hu>
cc: Amit Shah <amit@kernel.org>
cc: linux-fsdevel@vger.kernel.org
cc: virtualization@lists.linux-foundation.org
cc: linux-mm@kvack.org
---
 fs/splice.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/splice.c b/fs/splice.c
index 2e76dbb81a8f..33caa28a86e4 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -240,6 +240,8 @@ ssize_t add_to_pipe(struct pipe_inode_info *pipe, stru=
ct pipe_buffer *buf)
 	} else if (pipe_full(head, tail, pipe->max_usage)) {
 		ret =3D -EAGAIN;
 	} else {
+		if (folio_nr_pages(page_folio(buf->page)) > 1)
+			buf->flags &=3D ~PIPE_BUF_FLAG_GIFT;
 		pipe->bufs[head & mask] =3D *buf;
 		pipe->head =3D head + 1;
 		return buf->len;

