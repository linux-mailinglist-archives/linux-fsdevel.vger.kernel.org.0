Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A03E8777936
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Aug 2023 15:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233133AbjHJNIv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Aug 2023 09:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231902AbjHJNIu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Aug 2023 09:08:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4986B91
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Aug 2023 06:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691672880;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Gv2PHDy05xeKCb4ONOqV5jsjjW0Plf8giK9Cu4AytwA=;
        b=e22Gi62pAA3I75ahRh7K2HlvZEg/lXqtedvU6BVIYvHgULp/AtR2Lmx532NWTGNP3qI56b
        gwh7xtj/WIAqKfZSIBZaZgMTeh4ArIcljDrqzRGlqRhRebWe/9N7AQ7/h7eoISbijR8GQ5
        IPcaJAPPIJeWmaneMMWy1536pnchPrk=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-12-YI7mgYmVP4al5-pb-1FX0A-1; Thu, 10 Aug 2023 09:07:55 -0400
X-MC-Unique: YI7mgYmVP4al5-pb-1FX0A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A46151C07263;
        Thu, 10 Aug 2023 13:07:53 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.185])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 33D24C15BB8;
        Thu, 10 Aug 2023 13:07:50 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <f0538006-6641-eaf6-b7b5-b3ef57afc652@gmail.com>
References: <f0538006-6641-eaf6-b7b5-b3ef57afc652@gmail.com> <ecbb5d7e-7238-28e2-1a17-686325e2bb50@gmail.com> <4c49176f-147a-4283-f1b1-32aac7b4b996@gmail.com> <20230522121125.2595254-1-dhowells@redhat.com> <20230522121125.2595254-9-dhowells@redhat.com> <2267272.1686150217@warthog.procyon.org.uk> <5a9d4ffb-a569-3f60-6ac8-070ab5e5f5ad@gmail.com> <776549.1687167344@warthog.procyon.org.uk> <7337a904-231d-201d-397a-7bbe7cae929f@gmail.com> <20230630102143.7deffc30@kernel.org>
To:     Tariq Toukan <ttoukan.linux@gmail.com>
Cc:     dhowells@redhat.com, Jakub Kicinski <kuba@kernel.org>,
        netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jeff Layton <jlayton@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Chuck Lever III <chuck.lever@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Boris Pismenny <borisp@nvidia.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Gal Pressman <gal@nvidia.com>, ranro@nvidia.com,
        samiram@nvidia.com, drort@nvidia.com,
        Tariq Toukan <tariqt@nvidia.com>
Subject: Re: [PATCH net-next v10 08/16] tls: Inline do_tcp_sendpages()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3480242.1691672869.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Thu, 10 Aug 2023 14:07:49 +0100
Message-ID: <3480243.1691672869@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Tariq Toukan <ttoukan.linux@gmail.com> wrote:

> We are collecting more info on how the repro is affected by the differen=
t
> parameters.

I'm wondering if userspace is feeding the unspliceable page in somehow.  C=
ould
you try running with the attached changes?  It might help catch the point =
at
which the offending page is first spliced into the pipe and any backtrace
might help localise the driver that's producing it.

Thanks,
David
---
diff --git a/fs/splice.c b/fs/splice.c
index 3e2a31e1ce6a..877df1de3863 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -218,6 +218,8 @@ ssize_t splice_to_pipe(struct pipe_inode_info *pipe,
 	while (!pipe_full(head, tail, pipe->max_usage)) {
 		struct pipe_buffer *buf =3D &pipe->bufs[head & mask];
 =

+		WARN_ON_ONCE(!sendpage_ok(spd->pages[page_nr]));
+
 		buf->page =3D spd->pages[page_nr];
 		buf->offset =3D spd->partial[page_nr].offset;
 		buf->len =3D spd->partial[page_nr].len;
@@ -252,6 +254,8 @@ ssize_t add_to_pipe(struct pipe_inode_info *pipe, stru=
ct pipe_buffer *buf)
 	unsigned int mask =3D pipe->ring_size - 1;
 	int ret;
 =

+	WARN_ON_ONCE(!sendpage_ok(buf->page));
+
 	if (unlikely(!pipe->readers)) {
 		send_sig(SIGPIPE, current, 0);
 		ret =3D -EPIPE;
@@ -861,6 +865,8 @@ ssize_t splice_to_socket(struct pipe_inode_info *pipe,=
 struct file *out,
 				break;
 			}
 =

+			WARN_ON_ONCE(!sendpage_ok(buf->page));
+
 			bvec_set_page(&bvec[bc++], buf->page, seg, buf->offset);
 			remain -=3D seg;
 			if (remain =3D=3D 0 || bc >=3D ARRAY_SIZE(bvec))
@@ -1411,6 +1417,8 @@ static int iter_to_pipe(struct iov_iter *from,
 		for (i =3D 0; i < n; i++) {
 			int size =3D min_t(int, left, PAGE_SIZE - start);
 =

+			WARN_ON_ONCE(!sendpage_ok(pages[i]));
+
 			buf.page =3D pages[i];
 			buf.offset =3D start;
 			buf.len =3D size;

