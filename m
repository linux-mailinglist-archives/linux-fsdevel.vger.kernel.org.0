Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C36A4CBD2C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Mar 2022 12:55:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232917AbiCCL4l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Mar 2022 06:56:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231193AbiCCL4k (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Mar 2022 06:56:40 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9AED3D0048
        for <linux-fsdevel@vger.kernel.org>; Thu,  3 Mar 2022 03:55:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646308554;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=IY8lWVSOV3bu6U2dVFxqTE5k4e4xoGosytCtjhB+xz0=;
        b=LDXTi+fhQtka05QdD1C+WPQouBVhSiAHwpZjWZsdBZCg+LEWyIepaEurp4zpGSoOwZ9quh
        qjTwXO3H/hAk0Tc9e5hfPfp83ilb27fnQVaROkoAAfQd/ceA3LqkrrJspdvFjWsnxzNNx3
        DpRwdh3eLpHr9xqZPzAGVT/RtB5Ujr0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-247-gl5wym27Ng2KQYmErdbzSQ-1; Thu, 03 Mar 2022 06:55:51 -0500
X-MC-Unique: gl5wym27Ng2KQYmErdbzSQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A43E91091DA0;
        Thu,  3 Mar 2022 11:55:50 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 76C0F842D4;
        Thu,  3 Mar 2022 11:55:49 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH] cachefiles: Fix incorrect length to fallocate()
From:   David Howells <dhowells@redhat.com>
To:     jlayton@kernel.org
Cc:     Jeffle Xu <jefflexu@linux.alibaba.com>, linux-cachefs@redhat.com,
        dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 03 Mar 2022 11:55:48 +0000
Message-ID: <164630854858.3665356.17419701804248490708.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When cachefiles_shorten_object() calls fallocate() to shape the cache file
to match the DIO size, it passes the total file size it wants to achieve,
not the amount of zeros that should be inserted.  Since this is meant to
preallocate that amount of storage for the file, it can cause the cache to
fill up the disk and hit ENOSPC.

Fix this by passing the length actually required to go from the current EOF
to the desired EOF.

Fixes: 7623ed6772de ("cachefiles: Implement cookie resize for truncate")
Reported-by: Jeffle Xu <jefflexu@linux.alibaba.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-cachefs@redhat.com
---

 fs/cachefiles/interface.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/cachefiles/interface.c b/fs/cachefiles/interface.c
index 51c968cd00a6..ae93cee9d25d 100644
--- a/fs/cachefiles/interface.c
+++ b/fs/cachefiles/interface.c
@@ -254,7 +254,7 @@ static bool cachefiles_shorten_object(struct cachefiles_object *object,
 		ret = cachefiles_inject_write_error();
 		if (ret == 0)
 			ret = vfs_fallocate(file, FALLOC_FL_ZERO_RANGE,
-					    new_size, dio_size);
+					    new_size, dio_size - new_size);
 		if (ret < 0) {
 			trace_cachefiles_io_error(object, file_inode(file), ret,
 						  cachefiles_trace_fallocate_error);


