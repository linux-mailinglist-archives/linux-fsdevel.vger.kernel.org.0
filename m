Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7776977C8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Feb 2023 09:08:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233508AbjBOII5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Feb 2023 03:08:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233816AbjBOII4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Feb 2023 03:08:56 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7CC4268A
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Feb 2023 00:08:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676448485;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9u9d4+mSA10ut2q7fk3wCmoZCnOirUoOM8gzSFKLCaI=;
        b=axYw+tm8bjSvrYPXSQs/MHhb2WptAE8svInjNG/n1p0VUkjzoP/qOH+4Vfew+Wj5moIkl1
        rmksO6DzPzzBuj/O5RFzVVklbbIRj5qWREOnrjrEzJ/nbDLkeFQKo2VEmJAV92vJpHVwVd
        jzFTGW+umCLNNzvFafCtwM9OGPi94Ss=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-639-QV-m0oUcNiaSK3dKwtDYaw-1; Wed, 15 Feb 2023 03:08:02 -0500
X-MC-Unique: QV-m0oUcNiaSK3dKwtDYaw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8F46729AA2D5;
        Wed, 15 Feb 2023 08:08:01 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D1FF6140EBF6;
        Wed, 15 Feb 2023 08:07:58 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <867e1e3e-681b-843b-1704-effed736e13d@kernel.dk>
References: <867e1e3e-681b-843b-1704-effed736e13d@kernel.dk> <20230214171330.2722188-1-dhowells@redhat.com> <2877092.1676415412@warthog.procyon.org.uk>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     dhowells@redhat.com, smfrench@gmail.com,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v14 00/17] iov_iter: Improve page extraction (pin or just list)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2895994.1676448478.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Wed, 15 Feb 2023 08:07:58 +0000
Message-ID: <2895995.1676448478@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jens Axboe <axboe@kernel.dk> wrote:

> Let's update the branch and see how it goes... If there's more fallout, =
then
> let's make a fallback plan for the first few.

I forgot to export the new functions, as Steve found out.  Fix attached.

David
---
splice: Export filemap/direct_splice_read()

filemap_splice_read() and direct_splice_read() should be exported.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Jens Axboe <axboe@kernel.dk>
cc: Christoph Hellwig <hch@lst.de>
cc: Al Viro <viro@zeniv.linux.org.uk>
cc: David Hildenbrand <david@redhat.com>
cc: John Hubbard <jhubbard@nvidia.com>
cc: linux-cifs@vger.kernel.org
cc: linux-mm@kvack.org
cc: linux-block@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
---
 fs/splice.c  |    1 +
 mm/filemap.c |    1 +
 2 files changed, 2 insertions(+)

diff --git a/fs/splice.c b/fs/splice.c
index 4c6332854b63..928c7be2f318 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -373,6 +373,7 @@ ssize_t direct_splice_read(struct file *in, loff_t *pp=
os,
 	kfree(bv);
 	return ret;
 }
+EXPORT_SYMBOL(direct_splice_read);
 =

 /**
  * generic_file_splice_read - splice data from file to a pipe
diff --git a/mm/filemap.c b/mm/filemap.c
index 8c7b135c8e23..570f86578f7c 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2969,6 +2969,7 @@ ssize_t filemap_splice_read(struct file *in, loff_t =
*ppos,
 =

 	return total_spliced ? total_spliced : error;
 }
+EXPORT_SYMBOL(filemap_splice_read);
 =

 static inline loff_t folio_seek_hole_data(struct xa_state *xas,
 		struct address_space *mapping, struct folio *folio,

