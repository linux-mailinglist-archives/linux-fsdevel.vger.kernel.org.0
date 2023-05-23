Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE6270DCF4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 May 2023 14:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236766AbjEWMtm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 May 2023 08:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234057AbjEWMtk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 May 2023 08:49:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74D99138
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 May 2023 05:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684846130;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=hz+rQBDAcdUtSJzBU0XZBYw1XZqw4mtBlUpMTPXSzN4=;
        b=OmxBFetaJQHKHWPnTYLOW3KPHIbJ3tmdzYkeKNYyQiizBVJ0fGBZ/x9581RJfkOhy7BWPc
        8SC+Oa+FR+1zbWvdKK3Gy+bQ/jx7ZDVDXAMOsN/FGKKmPp6M/vztu7a+3PJDpf63ULdQ7h
        Y6ZmapjTwW4mm8DaYHKATlRCfjx3v7Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-36-2A2PiPSiNQaORPT8h7GuJQ-1; Tue, 23 May 2023 08:48:44 -0400
X-MC-Unique: 2A2PiPSiNQaORPT8h7GuJQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 35CF2811E93;
        Tue, 23 May 2023 12:48:43 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.39.192.68])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C540A40CFD46;
        Tue, 23 May 2023 12:48:41 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     Shyam Prasad N <sprasad@microsoft.com>
cc:     dhowells@redhat.com, Steve French <smfrench@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Paulo Alcantara <pc@manguebit.com>,
        Tom Talpey <tom@talpey.com>, Jeff Layton <jlayton@kernel.org>,
        linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] cifs: Fix cifs_limit_bvec_subset() to correctly check the maxmimum size
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2989164.1684846121.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Tue, 23 May 2023 13:48:41 +0100
Message-ID: <2989165.1684846121@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix cifs_limit_bvec_subset() so that it limits the span to the maximum
specified and won't return with a size greater than max_size.

Fixes: d08089f649a0 ("cifs: Change the I/O paths to use an iterator rather=
 than a page list")
Reported-by: Shyam Prasad N <sprasad@microsoft.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <smfrench@gmail.com>
cc: Rohith Surabattula <rohiths.msft@gmail.com>
cc: Paulo Alcantara <pc@manguebit.com>
cc: Tom Talpey <tom@talpey.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cifs@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
---
 fs/cifs/file.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index ba7f2e09d6c8..df88b8c04d03 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -3353,9 +3353,10 @@ static size_t cifs_limit_bvec_subset(const struct i=
ov_iter *iter, size_t max_siz
 	while (n && ix < nbv) {
 		len =3D min3(n, bvecs[ix].bv_len - skip, max_size);
 		span +=3D len;
+		max_size -=3D len;
 		nsegs++;
 		ix++;
-		if (span >=3D max_size || nsegs >=3D max_segs)
+		if (max_size =3D=3D 0 || nsegs >=3D max_segs)
 			break;
 		skip =3D 0;
 		n -=3D len;

