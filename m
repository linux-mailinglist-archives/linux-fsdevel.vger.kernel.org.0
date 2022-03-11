Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 102424D6293
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Mar 2022 14:49:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348967AbiCKNu6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Mar 2022 08:50:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243680AbiCKNu5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Mar 2022 08:50:57 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 809C91C46BF
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Mar 2022 05:49:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647006593;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nkVV5Z2jvGzdxq9DT6Fv6Bpxc803c9THPKkducVZxOM=;
        b=H4BsCFisBmfq7LqSX/Dgp2Z2AffdLpw0v9jw4B7lOETE6u1dgXSrz7Un+39/egkpZ85K6/
        U/DsOqEJhktBUbCWq12hepVitg1cCxEsmaw75vE4pz1qFBUp2LI0z4j/MpaEih+XguaGfR
        phSxBnSuhrKo2H/OJSY9D3XYEHf6fPg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-145-TueK1vdeMAWKJda3GjGIzA-1; Fri, 11 Mar 2022 08:49:50 -0500
X-MC-Unique: TueK1vdeMAWKJda3GjGIzA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 251001091DA1;
        Fri, 11 Mar 2022 13:49:48 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 72A0483591;
        Fri, 11 Mar 2022 13:49:35 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <dd054c962818716e718bd9b446ee5322ca097675.camel@redhat.com>
References: <dd054c962818716e718bd9b446ee5322ca097675.camel@redhat.com> <164692883658.2099075.5745824552116419504.stgit@warthog.procyon.org.uk> <164692907694.2099075.10081819855690054094.stgit@warthog.procyon.org.uk>
To:     Jeff Layton <jlayton@redhat.com>
Cc:     dhowells@redhat.com, linux-cachefs@redhat.com,
        ceph-devel@vger.kernel.org,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        David Wysochanski <dwysocha@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 12/20] ceph: Make ceph_init_request() check caps on readahead
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2533820.1647006574.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Fri, 11 Mar 2022 13:49:34 +0000
Message-ID: <2533821.1647006574@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jeff Layton <jlayton@redhat.com> wrote:

> > +static int ceph_init_request(struct netfs_io_request *rreq, struct fi=
le *file)
> > +{
> > +	struct inode *inode =3D rreq->inode;
> > +	int got =3D 0, want =3D CEPH_CAP_FILE_CACHE;
> > +	int ret =3D 0;
> > +
> > +	if (file) {
> > +		struct ceph_rw_context *rw_ctx;
> > +		struct ceph_file_info *fi =3D file->private_data;
> > +
> > +		rw_ctx =3D ceph_find_rw_context(fi);
> > +		if (rw_ctx)
> > +			return 0;
> > +	}
> > +
> > +	if (rreq->origin !=3D NETFS_READAHEAD)
> > +		return 0;
> > +
> =

> ^^^
> I think you should move this check above the if (file) block above it.
> We don't need to anything at all if we're not in readahead.

How about the attached, then?

David
---
commit 7082946186fc26016b15bc9039bd6d92ae732ef3
Author: David Howells <dhowells@redhat.com>
Date:   Wed Mar 9 21:45:22 2022 +0000

    ceph: Make ceph_init_request() check caps on readahead
    =

    Move the caps check from ceph_readahead() to ceph_init_request(),
    conditional on the origin being NETFS_READAHEAD so that in a future pa=
tch,
    ceph can point its ->readahead() vector directly at netfs_readahead().
    =

    Changes
    =3D=3D=3D=3D=3D=3D=3D
    ver #4)
     - Move the check for NETFS_READAHEAD up in ceph_init_request()[2].
    =

    ver #3)
     - Split from the patch to add a netfs inode context[1].
     - Need to store the caps got in rreq->netfs_priv for later freeing.
    =

    Signed-off-by: David Howells <dhowells@redhat.com>
    cc: ceph-devel@vger.kernel.org
    cc: linux-cachefs@redhat.com
    Link: https://lore.kernel.org/r/8af0d47f17d89c06bbf602496dd845f2b0bf25=
b3.camel@kernel.org/ [1]
    Link: https://lore.kernel.org/r/dd054c962818716e718bd9b446ee5322ca0976=
75.camel@redhat.com/ [2]

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 9189257476f8..4aeccafa5dda 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -354,6 +354,45 @@ static void ceph_netfs_issue_read(struct netfs_io_sub=
request *subreq)
 	dout("%s: result %d\n", __func__, err);
 }
 =

+static int ceph_init_request(struct netfs_io_request *rreq, struct file *=
file)
+{
+	struct inode *inode =3D rreq->inode;
+	int got =3D 0, want =3D CEPH_CAP_FILE_CACHE;
+	int ret =3D 0;
+
+	if (rreq->origin !=3D NETFS_READAHEAD)
+		return 0;
+
+	if (file) {
+		struct ceph_rw_context *rw_ctx;
+		struct ceph_file_info *fi =3D file->private_data;
+
+		rw_ctx =3D ceph_find_rw_context(fi);
+		if (rw_ctx)
+			return 0;
+	}
+
+	/*
+	 * readahead callers do not necessarily hold Fcb caps
+	 * (e.g. fadvise, madvise).
+	 */
+	ret =3D ceph_try_get_caps(inode, CEPH_CAP_FILE_RD, want, true, &got);
+	if (ret < 0) {
+		dout("start_read %p, error getting cap\n", inode);
+		return ret;
+	}
+
+	if (!(got & want)) {
+		dout("start_read %p, no cache cap\n", inode);
+		return -EACCES;
+	}
+	if (ret =3D=3D 0)
+		return -EACCES;
+
+	rreq->netfs_priv =3D (void *)(uintptr_t)got;
+	return 0;
+}
+
 static void ceph_readahead_cleanup(struct address_space *mapping, void *p=
riv)
 {
 	struct inode *inode =3D mapping->host;
@@ -365,7 +404,7 @@ static void ceph_readahead_cleanup(struct address_spac=
e *mapping, void *priv)
 }
 =

 static const struct netfs_request_ops ceph_netfs_read_ops =3D {
-	.is_cache_enabled	=3D ceph_is_cache_enabled,
+	.init_request		=3D ceph_init_request,
 	.begin_cache_operation	=3D ceph_begin_cache_operation,
 	.issue_read		=3D ceph_netfs_issue_read,
 	.expand_readahead	=3D ceph_netfs_expand_readahead,
@@ -393,33 +432,7 @@ static int ceph_readpage(struct file *file, struct pa=
ge *subpage)
 =

 static void ceph_readahead(struct readahead_control *ractl)
 {
-	struct inode *inode =3D file_inode(ractl->file);
-	struct ceph_file_info *fi =3D ractl->file->private_data;
-	struct ceph_rw_context *rw_ctx;
-	int got =3D 0;
-	int ret =3D 0;
-
-	if (ceph_inode(inode)->i_inline_version !=3D CEPH_INLINE_NONE)
-		return;
-
-	rw_ctx =3D ceph_find_rw_context(fi);
-	if (!rw_ctx) {
-		/*
-		 * readahead callers do not necessarily hold Fcb caps
-		 * (e.g. fadvise, madvise).
-		 */
-		int want =3D CEPH_CAP_FILE_CACHE;
-
-		ret =3D ceph_try_get_caps(inode, CEPH_CAP_FILE_RD, want, true, &got);
-		if (ret < 0)
-			dout("start_read %p, error getting cap\n", inode);
-		else if (!(got & want))
-			dout("start_read %p, no cache cap\n", inode);
-
-		if (ret <=3D 0)
-			return;
-	}
-	netfs_readahead(ractl, &ceph_netfs_read_ops, (void *)(uintptr_t)got);
+	netfs_readahead(ractl, &ceph_netfs_read_ops, NULL);
 }
 =

 #ifdef CONFIG_CEPH_FSCACHE

