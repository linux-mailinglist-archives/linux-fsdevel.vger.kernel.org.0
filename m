Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 579DB70B57E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 May 2023 08:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231827AbjEVGyk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 May 2023 02:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231860AbjEVGyP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 May 2023 02:54:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC2F199D
        for <linux-fsdevel@vger.kernel.org>; Sun, 21 May 2023 23:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684738208;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WPmCmuYomWuJ+5LnnTa+OzAzhut1gbOGrEeSAMZunF8=;
        b=HZDwEEQ3hr/UL0kwljhuNHza3rs99z+kg0Hn0kQBgSEzGYTWeP2n+L6ZEhZ67k9dr3ai3k
        GkJpEqsfh49Yakip2sM0LE/XaALBtbzSsGJw4ppmQfsRk5y60M6lJ9eRzkbB7PmkozKmQM
        EUHoC2h5vH+yPouZNGegs/JFser4yI4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-308-o3bjNUnbPDuBiGmpC7NUHw-1; Mon, 22 May 2023 02:50:03 -0400
X-MC-Unique: o3bjNUnbPDuBiGmpC7NUHw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5281C3828894;
        Mon, 22 May 2023 06:50:02 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.39.192.68])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 58B271121315;
        Mon, 22 May 2023 06:49:59 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <376ab23b-52d0-d7fd-2dd9-414cbb474e01@linux.alibaba.com>
References: <376ab23b-52d0-d7fd-2dd9-414cbb474e01@linux.alibaba.com> <20230520000049.2226926-1-dhowells@redhat.com> <20230520000049.2226926-23-dhowells@redhat.com>
To:     Joseph Qi <joseph.qi@linux.alibaba.com>
Cc:     dhowells@redhat.com, Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Christoph Hellwig <hch@lst.de>, Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>, ocfs2-devel@oss.oracle.com
Subject: Re: [PATCH v21 22/30] ocfs2: Provide a splice-read stub
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2414054.1684738198.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Mon, 22 May 2023 07:49:58 +0100
Message-ID: <2414055.1684738198@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

So something like the attached changes?  Any suggestions as to how to impr=
ove
the comments?

David
---
diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
index f7e00b5689d5..86add13b5f23 100644
--- a/fs/ocfs2/file.c
+++ b/fs/ocfs2/file.c
@@ -2552,7 +2552,7 @@ static ssize_t ocfs2_file_read_iter(struct kiocb *io=
cb,
 	 *
 	 * Take and drop the meta data lock to update inode fields
 	 * like i_size. This allows the checks down below
-	 * generic_file_read_iter() a chance of actually working.
+	 * copy_splice_read() a chance of actually working.
 	 */
 	ret =3D ocfs2_inode_lock_atime(inode, filp->f_path.mnt, &lock_level,
 				     !nowait);
@@ -2593,7 +2593,7 @@ static ssize_t ocfs2_file_splice_read(struct file *i=
n, loff_t *ppos,
 				     (unsigned long long)OCFS2_I(inode)->ip_blkno,
 				     in->f_path.dentry->d_name.len,
 				     in->f_path.dentry->d_name.name,
-				     0);
+				     flags);
 =

 	/*
 	 * We're fine letting folks race truncates and extending writes with
@@ -2601,10 +2601,10 @@ static ssize_t ocfs2_file_splice_read(struct file =
*in, loff_t *ppos,
 	 * rw_lock during read.
 	 *
 	 * Take and drop the meta data lock to update inode fields like i_size.
-	 * This allows the checks down below generic_file_splice_read() a
-	 * chance of actually working.
+	 * This allows the checks down below filemap_splice_read() a chance of
+	 * actually working.
 	 */
-	ret =3D ocfs2_inode_lock_atime(inode, in->f_path.mnt, &lock_level, true)=
;
+	ret =3D ocfs2_inode_lock_atime(inode, in->f_path.mnt, &lock_level, 1);
 	if (ret < 0) {
 		if (ret !=3D -EAGAIN)
 			mlog_errno(ret);

