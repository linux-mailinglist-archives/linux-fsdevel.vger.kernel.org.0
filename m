Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 170514FBF6D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Apr 2022 16:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347395AbiDKOpy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Apr 2022 10:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347390AbiDKOpy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Apr 2022 10:45:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5638613F28
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Apr 2022 07:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649688219;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=D+XJaf7h6+3Eoi7jpfHr9ZIJMx44xBPQcMP6evn0mvM=;
        b=FgpFEEDniPiUhV5ND49TCncK7QM++vBiD20cYixI5KHvVd1F3zSo5LtZgecljWJgW+BWIX
        3Q2oGHQVv7Tf6gwuP1PmXBvKkPnN+0yAHTF1ysxrkMmGDr6G7XjtaaS+BXqFeqyZ4+N8ge
        2TjUD/XDWUPNIyJothC6Cqq9VRIKOVc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-662-lfMXun7DO--7UttZUDDmag-1; Mon, 11 Apr 2022 10:43:33 -0400
X-MC-Unique: lfMXun7DO--7UttZUDDmag-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7F95183396D;
        Mon, 11 Apr 2022 14:43:33 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7A16A40FF407;
        Mon, 11 Apr 2022 14:43:33 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 23BEhXra022612;
        Mon, 11 Apr 2022 10:43:33 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 23BEhXeM022608;
        Mon, 11 Apr 2022 10:43:33 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Mon, 11 Apr 2022 10:43:33 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] stat: don't fail if the major number is >= 256
Message-ID: <alpine.LRH.2.02.2204111023230.6206@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If you run a program compiled with OpenWatcom for Linux on a filesystem on 
NVMe, all "stat" syscalls fail with -EOVERFLOW. The reason is that the 
NVMe driver allocates a device with the major number 259 and it doesn't 
pass the "old_valid_dev" test.

This patch removes the tests - it's better to wrap around than to return
an error. (note that cp_old_stat also doesn't report an error and wraps
the number around)

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

---
 fs/stat.c |    6 ------
 1 file changed, 6 deletions(-)

Index: linux-5.17.2/fs/stat.c
===================================================================
--- linux-5.17.2.orig/fs/stat.c	2022-04-10 21:39:27.000000000 +0200
+++ linux-5.17.2/fs/stat.c	2022-04-10 21:42:43.000000000 +0200
@@ -334,7 +334,6 @@ SYSCALL_DEFINE2(fstat, unsigned int, fd,
 #  define choose_32_64(a,b) b
 #endif
 
-#define valid_dev(x)  choose_32_64(old_valid_dev(x),true)
 #define encode_dev(x) choose_32_64(old_encode_dev,new_encode_dev)(x)
 
 #ifndef INIT_STRUCT_STAT_PADDING
@@ -345,8 +344,6 @@ static int cp_new_stat(struct kstat *sta
 {
 	struct stat tmp;
 
-	if (!valid_dev(stat->dev) || !valid_dev(stat->rdev))
-		return -EOVERFLOW;
 #if BITS_PER_LONG == 32
 	if (stat->size > MAX_NON_LFS)
 		return -EOVERFLOW;
@@ -644,9 +641,6 @@ static int cp_compat_stat(struct kstat *
 {
 	struct compat_stat tmp;
 
-	if (!old_valid_dev(stat->dev) || !old_valid_dev(stat->rdev))
-		return -EOVERFLOW;
-
 	memset(&tmp, 0, sizeof(tmp));
 	tmp.st_dev = old_encode_dev(stat->dev);
 	tmp.st_ino = stat->ino;

