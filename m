Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C068D4DD736
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Mar 2022 10:38:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234567AbiCRJjS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Mar 2022 05:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233932AbiCRJjO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Mar 2022 05:39:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ED29F1C348A
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Mar 2022 02:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647596274;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uS5OLLy58zowFJOHUPh79D3XiQk55Uu9GC4n+ZxRfmM=;
        b=Id2EjwxWO+An1UpxsQkUzBFPag9IXKtrVLWSGpDgzOa0DqKoUVoQQdZEo3JX58UTIs4Njk
        1C9lK2EqyIZ2F9CcWSfyGbI2wGv7dve/0YgFItB9sBVSDUx9iVcvK+fIG13z6Pklphc3ep
        f511b4LnbgrJautIf/lBgXkFUenPjlY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-654-RZHKyeUmPHygu5KFbrOKWA-1; Fri, 18 Mar 2022 05:37:42 -0400
X-MC-Unique: RZHKyeUmPHygu5KFbrOKWA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D89092A2AD40;
        Fri, 18 Mar 2022 09:37:41 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-13-174.pek2.redhat.com [10.72.13.174])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7429E112C08E;
        Fri, 18 Mar 2022 09:37:33 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     willy@infradead.org, bhe@redhat.com, kexec@lists.infradead.org,
        yangtiezhu@loongson.cn, amit.kachhap@arm.com, hch@lst.de,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk
Subject: [PATCH v4 4/4] fs/proc/vmcore: Use iov_iter_count()
Date:   Fri, 18 Mar 2022 17:37:06 +0800
Message-Id: <20220318093706.161534-5-bhe@redhat.com>
In-Reply-To: <20220318093706.161534-1-bhe@redhat.com>
References: <20220318093706.161534-1-bhe@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

To replace open coded iter->count. This makes code cleaner.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 fs/proc/vmcore.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 4cbb8db7c507..ed58a7edc821 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -319,21 +319,21 @@ static ssize_t __read_vmcore(struct iov_iter *iter, loff_t *fpos)
 	u64 start;
 	struct vmcore *m = NULL;
 
-	if (iter->count == 0 || *fpos >= vmcore_size)
+	if (!iov_iter_count(iter) || *fpos >= vmcore_size)
 		return 0;
 
 	iov_iter_truncate(iter, vmcore_size - *fpos);
 
 	/* Read ELF core header */
 	if (*fpos < elfcorebuf_sz) {
-		tsz = min(elfcorebuf_sz - (size_t)*fpos, iter->count);
+		tsz = min(elfcorebuf_sz - (size_t)*fpos, iov_iter_count(iter));
 		if (copy_to_iter(elfcorebuf + *fpos, tsz, iter) < tsz)
 			return -EFAULT;
 		*fpos += tsz;
 		acc += tsz;
 
 		/* leave now if filled buffer already */
-		if (iter->count == 0)
+		if (!iov_iter_count(iter))
 			return acc;
 	}
 
@@ -354,7 +354,7 @@ static ssize_t __read_vmcore(struct iov_iter *iter, loff_t *fpos)
 		/* Read device dumps */
 		if (*fpos < elfcorebuf_sz + vmcoredd_orig_sz) {
 			tsz = min(elfcorebuf_sz + vmcoredd_orig_sz -
-				  (size_t)*fpos, iter->count);
+				  (size_t)*fpos, iov_iter_count(iter));
 			start = *fpos - elfcorebuf_sz;
 			if (vmcoredd_copy_dumps(iter, start, tsz))
 				return -EFAULT;
@@ -363,13 +363,14 @@ static ssize_t __read_vmcore(struct iov_iter *iter, loff_t *fpos)
 			acc += tsz;
 
 			/* leave now if filled buffer already */
-			if (!iter->count)
+			if (!iov_iter_count(iter))
 				return acc;
 		}
 #endif /* CONFIG_PROC_VMCORE_DEVICE_DUMP */
 
 		/* Read remaining elf notes */
-		tsz = min(elfcorebuf_sz + elfnotes_sz - (size_t)*fpos, iter->count);
+		tsz = min(elfcorebuf_sz + elfnotes_sz - (size_t)*fpos,
+			  iov_iter_count(iter));
 		kaddr = elfnotes_buf + *fpos - elfcorebuf_sz - vmcoredd_orig_sz;
 		if (copy_to_iter(kaddr, tsz, iter) < tsz)
 			return -EFAULT;
@@ -378,7 +379,7 @@ static ssize_t __read_vmcore(struct iov_iter *iter, loff_t *fpos)
 		acc += tsz;
 
 		/* leave now if filled buffer already */
-		if (iter->count == 0)
+		if (!iov_iter_count(iter))
 			return acc;
 	}
 
@@ -386,7 +387,7 @@ static ssize_t __read_vmcore(struct iov_iter *iter, loff_t *fpos)
 		if (*fpos < m->offset + m->size) {
 			tsz = (size_t)min_t(unsigned long long,
 					    m->offset + m->size - *fpos,
-					    iter->count);
+					    iov_iter_count(iter));
 			start = m->paddr + *fpos - m->offset;
 			tmp = read_from_oldmem(iter, tsz, &start,
 					cc_platform_has(CC_ATTR_MEM_ENCRYPT));
@@ -396,7 +397,7 @@ static ssize_t __read_vmcore(struct iov_iter *iter, loff_t *fpos)
 			acc += tsz;
 
 			/* leave now if filled buffer already */
-			if (iter->count == 0)
+			if (!iov_iter_count(iter))
 				return acc;
 		}
 	}
-- 
2.34.1

