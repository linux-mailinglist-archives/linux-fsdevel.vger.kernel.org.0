Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3A9B6BA199
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Mar 2023 22:51:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbjCNVvG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Mar 2023 17:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjCNVvF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Mar 2023 17:51:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C82F51F85
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Mar 2023 14:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678830621;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KWBL8j9Kw5UJa5rIZGzcpgA4OkzAlidgj6Myi5kTuW4=;
        b=Z0srXGuFk2RYrFiHcGMgoNj/otbNDHtqam9RScrU7hws5E4fuW7AVWRt5tsJj9UTSjZzP0
        OJCGkr/TItQge4fbBda9cLapSzil5WYjeOGmEeWqZrHFJDQbFBy0SyjHTw6jM3O/8e8mfL
        4DQP5qQU7FUWmFXxuY5+owzXyEVI0aQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-480-URV1ga8lPOq_q_b6t_9rpg-1; Tue, 14 Mar 2023 17:50:16 -0400
X-MC-Unique: URV1ga8lPOq_q_b6t_9rpg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7DB3385A588;
        Tue, 14 Mar 2023 21:50:15 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DB3572166B26;
        Tue, 14 Mar 2023 21:50:12 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAHk-=wh-OKQdK2AE+CD_Y5bimnoSH=_4+F5EOZoGUf3SGJdxGA@mail.gmail.com>
References: <CAHk-=wh-OKQdK2AE+CD_Y5bimnoSH=_4+F5EOZoGUf3SGJdxGA@mail.gmail.com> <20230308165251.2078898-1-dhowells@redhat.com> <20230308165251.2078898-4-dhowells@redhat.com> <CAHk-=wjYR3h5Q-_i3Q2Et=P8WsrjwNA20fYpEQf9nafHwBNALA@mail.gmail.com> <ZBCkDvveAIJENA0G@casper.infradead.org> <CAHk-=wiO-Z7QdKnA+yeLCROiVVE6dBK=TaE7wz4hMc0gE2SPRw@mail.gmail.com> <3761465.1678818404@warthog.procyon.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dhowells@redhat.com, Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Daniel Golle <daniel@makrotopia.org>,
        Guenter Roeck <groeck7@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH v17 03/14] shmem: Implement splice-read
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3826545.1678830612.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Tue, 14 Mar 2023 21:50:12 +0000
Message-ID: <3826546.1678830612@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> wrote:

> But please at least stop doing the
> =

>      get_page(buf->page);
> =

> on the zero-page (which includes using no-op .get and .put functions
> in  zero_pipe_buf_ops().

I'll make the attached change.  It seems to work.

David
---
diff --git a/mm/shmem.c b/mm/shmem.c
index 3cbec1d56112..d9b60ab556fe 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2719,6 +2719,17 @@ static ssize_t shmem_file_read_iter(struct kiocb *i=
ocb, struct iov_iter *to)
 	return retval ? retval : error;
 }
 =

+static bool zero_pipe_buf_get(struct pipe_inode_info *pipe,
+			      struct pipe_buffer *buf)
+{
+	return true;
+}
+
+static void zero_pipe_buf_release(struct pipe_inode_info *pipe,
+				  struct pipe_buffer *buf)
+{
+}
+
 static bool zero_pipe_buf_try_steal(struct pipe_inode_info *pipe,
 				    struct pipe_buffer *buf)
 {
@@ -2726,9 +2737,9 @@ static bool zero_pipe_buf_try_steal(struct pipe_inod=
e_info *pipe,
 }
 =

 static const struct pipe_buf_operations zero_pipe_buf_ops =3D {
-	.release	=3D generic_pipe_buf_release,
+	.release	=3D zero_pipe_buf_release,
 	.try_steal	=3D zero_pipe_buf_try_steal,
-	.get		=3D generic_pipe_buf_get,
+	.get		=3D zero_pipe_buf_get,
 };
 =

 static size_t splice_zeropage_into_pipe(struct pipe_inode_info *pipe,

