Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECE6170C14C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 May 2023 16:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233852AbjEVOlL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 May 2023 10:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbjEVOlK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 May 2023 10:41:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B0499
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 May 2023 07:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684766435;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=AFW+IZL67Cz0xRBwmMsauHMgB+wZd79K6KlpZee9jmw=;
        b=WA/9hwcKVjZqly8iXSjWoBnT4uL/Wlwvidfoua0kBEaonQ0RnQ2hVmOJ+D01GTVpDmrL1G
        EUpLktgkMIIcg+sDn/rgy8QsOIcsm7pwPSEfUGNBXu3mXPrZWAY7+v15Fyo8a2Fpea2D2I
        MJd/4mQ+LHjQ8ZEEmYiSBduP2Q/Rjos=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-564-Ig3pnr3WNRKXjMESuYRgaA-1; Mon, 22 May 2023 10:40:33 -0400
X-MC-Unique: Ig3pnr3WNRKXjMESuYRgaA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B189D38025F5;
        Mon, 22 May 2023 14:40:32 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.39.192.68])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4895C40CFD45;
        Mon, 22 May 2023 14:40:31 +0000 (UTC)
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
Subject: [PATCH] cifs: Fix cifs_limit_bvec_subset() to correctly check the maxmimum size
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2811950.1684766430.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Mon, 22 May 2023 15:40:30 +0100
Message-ID: <2811951.1684766430@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
 fs/cifs/file.c |    1 +
 1 file changed, 1 insertion(+)


diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index ba7f2e09d6c8..4778614cfccf 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -3353,6 +3353,7 @@ static size_t cifs_limit_bvec_subset(const struct io=
v_iter *iter, size_t max_siz
 	while (n && ix < nbv) {
 		len =3D min3(n, bvecs[ix].bv_len - skip, max_size);
 		span +=3D len;
+		max_size -=3D len;
 		nsegs++;
 		ix++;
 		if (span >=3D max_size || nsegs >=3D max_segs)

