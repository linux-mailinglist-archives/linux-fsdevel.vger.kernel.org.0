Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED2A619F31
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Nov 2022 18:48:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbiKDRsd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Nov 2022 13:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbiKDRsb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Nov 2022 13:48:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B6743ACC
        for <linux-fsdevel@vger.kernel.org>; Fri,  4 Nov 2022 10:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667584048;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=qnPmYmConUMgaBA5iJmBF7ozEvY3875t4nGAe/KAgjQ=;
        b=XGQybIPrL7qvkhV+JFhFl1i/73L8BXxvQ9w/H7mK48m5O0PMxlaNMFD07E9t/uqvGlML1J
        Wd1eday13O9/hMeUGMIK0hYM93B2E4Z7/oPCEKbbR1pYMvLBmwaot7AmC8dxOEC8ssy+pC
        EdVU9Xg5mxe45UfyqSr0Jm5q/zBaCTQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-102-3FIYXAr3MwugYiDXwX6Aig-1; Fri, 04 Nov 2022 13:47:24 -0400
X-MC-Unique: 3FIYXAr3MwugYiDXwX6Aig-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7905F85A583;
        Fri,  4 Nov 2022 17:47:23 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.37.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9C97C4EA5A;
        Fri,  4 Nov 2022 17:47:21 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>, willy@infradead.org,
        dchinner@redhat.com, Steve French <smfrench@gmail.com>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>, linux-cifs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iov_iter: Declare new iterator direction symbols
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1010625.1667584040.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Fri, 04 Nov 2022 17:47:20 +0000
Message-ID: <1010626.1667584040@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus, Al,

If we're going to go with Al's changes to switch to using ITER_SOURCE and
ITER_DEST instead of READ/WRITE, can we put just the new symbols into main=
line
now, even if we leave the rest for the next merge window?

Thanks,
David
---
From: Al Viro <viro@zeniv.linux.org.uk>

iov_iter: Declare new iterator direction symbols

READ/WRITE proved to be actively confusing - the meanings are
"data destination, as used with read(2)" and "data source, as
used with write(2)", but people keep interpreting those as
"we read data from it" and "we write data to it", i.e. exactly
the wrong way.

Call them ITER_DEST and ITER_SOURCE - at least that is harder
to misinterpret...

[dhowells] Declare the symbols for later use and change to an enum.  If
READ/WRITE are switched to an enum also, I think the compiler should
generate a warning if they're mixed.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: David Howells <dhowells@redhat.com>
Link: https://lore.kernel.org/r/20221028023352.3532080-12-viro@zeniv.linux=
.org.uk/ # v2
---
 include/linux/uio.h |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/uio.h b/include/linux/uio.h
index 2e3134b14ffd..7c1317b34c57 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -29,6 +29,11 @@ enum iter_type {
 	ITER_UBUF,
 };
 =

+enum iov_iter_direction {
+	ITER_DEST	=3D 0,	/* Iterator is a destination buffer (=3D=3D READ) */
+	ITER_SOURCE	=3D 1,	/* Iterator is a source buffer (=3D=3D WRITE) */
+};
+
 struct iov_iter_state {
 	size_t iov_offset;
 	size_t count;

