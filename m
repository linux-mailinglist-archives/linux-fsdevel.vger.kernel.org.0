Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E54994CBE7F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Mar 2022 14:06:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231965AbiCCNGy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Mar 2022 08:06:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233568AbiCCNGv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Mar 2022 08:06:51 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 51F3D4F9C6
        for <linux-fsdevel@vger.kernel.org>; Thu,  3 Mar 2022 05:06:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646312763;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=sGGDuVdhwcgwx2SrnK8/gblmV0d5e2AdCaqPp9vXJSk=;
        b=ZTILtw7pvFcWPssdjaZp6vrQuy5MlLqIzIJSV+lvY17SuL8YrGBNbD1of6p5b9vvOjCDYM
        1mK4mkih28i7zkAFZaXzDN595HECjlhsXmGpEElVVHlziEjcwWq2p0riaLiNIo8B7AonQT
        ZqVb9xKVPaPud21VBACgathbEGOCf6Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-357-Pf9F7lb2P8OIppZEskDrrA-1; Thu, 03 Mar 2022 08:06:02 -0500
X-MC-Unique: Pf9F7lb2P8OIppZEskDrrA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3AC411091DAB;
        Thu,  3 Mar 2022 13:06:01 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3003A83289;
        Thu,  3 Mar 2022 13:05:19 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH] cachefiles: Fix incorrect length to fallocate()
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
Cc:     Jeffle Xu <jefflexu@linux.alibaba.com>,
        Jeff Layton <jlayton@kernel.org>,
        Jeff Layton <jlayton@kernel.org>, linux-cachefs@redhat.com,
        dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 03 Mar 2022 13:05:18 +0000
Message-ID: <164631271818.3677819.29893671575083538.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
Tested-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
cc: linux-cachefs@redhat.com
Link: https://lore.kernel.org/r/164630854858.3665356.17419701804248490708.stgit@warthog.procyon.org.uk # v1
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


