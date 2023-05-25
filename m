Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3AB47107BD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 May 2023 10:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238018AbjEYIkX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 May 2023 04:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbjEYIkV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 May 2023 04:40:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3362186
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 May 2023 01:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685003949;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Hkz4KYmd+qyivCKCvtUuaLboauM+EJmqeUCBu8NMbLs=;
        b=Z115Yt2TQ/yrNI3AUAFgJ4hCFr3xc3QU3+hyDvai5OjpHFEXsoZYSiPlnX5KmCBAbkpx7X
        ICxpcNSir1kduc74LItCzKWTNf4NI2u3RqkhgBdpKdQNj3W8xsGRT73QiqFjFuAktKPQ9F
        sKBDk5nRDZSuNfLu90/rhJvyjmVVwF0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-297-0cOG5D8xOvCHAP0HOjqVgw-1; Thu, 25 May 2023 04:39:01 -0400
X-MC-Unique: 0cOG5D8xOvCHAP0HOjqVgw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0B6F885A5BD;
        Thu, 25 May 2023 08:39:01 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.39.192.68])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 06397492B00;
        Thu, 25 May 2023 08:38:57 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     Damien Le Moal <dlemoal@kernel.org>
cc:     dhowells@redhat.com, Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@kvack.org
Subject: [PATCH] zonefs: Call zonefs_io_error() on any error from filemap_splice_read()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3788352.1685003937.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Thu, 25 May 2023 09:38:57 +0100
Message-ID: <3788353.1685003937@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

    =

Call zonefs_io_error() after getting any error from filemap_splice_read()
in zonefs_file_splice_read(), including non-fatal errors such as ENOMEM,
EINTR and EAGAIN.

Suggested-by: Damien Le Moal <dlemoal@kernel.org>
Link: https://lore.kernel.org/r/5d327bed-b532-ad3b-a211-52ad0a3e276a@kerne=
l.org/
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Naohiro Aota <naohiro.aota@wdc.com>
cc: Johannes Thumshirn <jth@kernel.org>
cc: Christoph Hellwig <hch@lst.de>
cc: Al Viro <viro@zeniv.linux.org.uk>
cc: Jens Axboe <axboe@kernel.dk>
cc: linux-fsdevel@vger.kernel.org
cc: linux-block@vger.kernel.org
cc: linux-mm@kvack.org
---
 fs/zonefs/file.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/zonefs/file.c b/fs/zonefs/file.c
index 65d4c4fe6364..0660cffc5ed8 100644
--- a/fs/zonefs/file.c
+++ b/fs/zonefs/file.c
@@ -782,7 +782,7 @@ static ssize_t zonefs_file_splice_read(struct file *in=
, loff_t *ppos,
 =

 	if (len > 0) {
 		ret =3D filemap_splice_read(in, ppos, pipe, len, flags);
-		if (ret =3D=3D -EIO)
+		if (ret < 0)
 			zonefs_io_error(inode, false);
 	}
 =

