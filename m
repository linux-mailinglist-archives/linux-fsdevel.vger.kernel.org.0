Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 718F87BBF37
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Oct 2023 20:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233399AbjJFSyo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Oct 2023 14:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233317AbjJFSyl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Oct 2023 14:54:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57891106
        for <linux-fsdevel@vger.kernel.org>; Fri,  6 Oct 2023 11:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696618356;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BlaoLCyuqcY+41bC5MK6wnQeesc3w4fcpuq4w3pEvtE=;
        b=EJB/7UxbZWA279eb/wwHHidBiLE9d/QBTVD132L8cOM1Zxnp063P63L9vcMTGHJdje37qe
        sfY0idFyjyNLrdWA2fG6Hw7Sn4WTAVZ4yMjT3cj1sYeQFSx/8hYzGUp/dTBFmBjzpMtxrY
        /MZBShO5k0LPlbLVQgwrClRnU9VqFis=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-fXF5fO1WPMCD1An5Ir83eg-1; Fri, 06 Oct 2023 14:52:25 -0400
X-MC-Unique: fXF5fO1WPMCD1An5Ir83eg-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-9b98d8f6bafso207702566b.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Oct 2023 11:52:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696618344; x=1697223144;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BlaoLCyuqcY+41bC5MK6wnQeesc3w4fcpuq4w3pEvtE=;
        b=mUG6tvjV0+vlWPNDhxlxz11uV0MpB+DLxl+5SXrAJ/D4oai5a9jXvT47tOJuKbr7MO
         aeZWWbC6fs/J/jN8Tel4PjgDcluKgb85cBIxm0CyYVhu95Pf+3CqXMX43W0N3uaiOS0F
         AyBM83+uc3tg05GaVhHxJ5eIJgyoFP94wvkxdmrX9yEywrNJpMqjjj/g6iSFQxJMVZ40
         GT0N+fpjg54vSUAR2KISmADZVUTJch9F4Gxl+auxiqSkFuR7ZB+blA6NBOboZKsLMP9k
         We4pI4Fy8DYkacjxOakJ4IlRRY8cE3gsNtn2m87TIGLzcgw8DB4XprWiSUBzKk4II6H0
         l0uw==
X-Gm-Message-State: AOJu0Yxv67yI23KuGcmgxvUIXKZGZH57oA93r58TylNWBYqDRf2PBmbj
        07BASG5r7E1GApsfAvFVog7OHfn/9IhjFF2fMcOH+YoiEi2HvkP23qz6++lj1V2mMivD2BUL4ml
        4remIOvXh1qCE2SmCoXoDOjLE
X-Received: by 2002:a17:906:300f:b0:9ae:6a8b:f8aa with SMTP id 15-20020a170906300f00b009ae6a8bf8aamr7747680ejz.26.1696618344137;
        Fri, 06 Oct 2023 11:52:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGEYdkuIsSVenx/4uH2p+mA+oW9MGScE7Z/AddBzQwdbEUsftUik0ThWo7nIT0gm/cImU0pMg==
X-Received: by 2002:a17:906:300f:b0:9ae:6a8b:f8aa with SMTP id 15-20020a170906300f00b009ae6a8bf8aamr7747667ejz.26.1696618343885;
        Fri, 06 Oct 2023 11:52:23 -0700 (PDT)
Received: from localhost.localdomain ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id os5-20020a170906af6500b009b947f81c4asm3304741ejb.155.2023.10.06.11.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 11:52:23 -0700 (PDT)
From:   Andrey Albershteyn <aalbersh@redhat.com>
To:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        fsverity@lists.linux.dev
Cc:     djwong@kernel.org, ebiggers@kernel.org, david@fromorbit.com,
        dchinner@redhat.com, Andrey Albershteyn <aalbersh@redhat.com>
Subject: [PATCH v3 06/28] fsverity: add drop_page() callout
Date:   Fri,  6 Oct 2023 20:49:00 +0200
Message-Id: <20231006184922.252188-7-aalbersh@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231006184922.252188-1-aalbersh@redhat.com>
References: <20231006184922.252188-1-aalbersh@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Allow filesystem to make additional processing on verified pages
instead of just dropping a reference. This will be used by XFS for
internal buffer cache manipulation in further patches. The btrfs,
ext4, and f2fs just drop the reference.

Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
---
 fs/verity/read_metadata.c |  4 ++--
 fs/verity/verify.c        |  6 +++---
 include/linux/fsverity.h  | 33 +++++++++++++++++++++++++++++++++
 3 files changed, 38 insertions(+), 5 deletions(-)

diff --git a/fs/verity/read_metadata.c b/fs/verity/read_metadata.c
index f58432772d9e..8bd4b29a9a95 100644
--- a/fs/verity/read_metadata.c
+++ b/fs/verity/read_metadata.c
@@ -56,12 +56,12 @@ static int fsverity_read_merkle_tree(struct inode *inode,
 		virt = kmap_local_page(page);
 		if (copy_to_user(buf, virt + offs_in_page, bytes_to_copy)) {
 			kunmap_local(virt);
-			put_page(page);
+			fsverity_drop_page(inode, page);
 			err = -EFAULT;
 			break;
 		}
 		kunmap_local(virt);
-		put_page(page);
+		fsverity_drop_page(inode, page);
 
 		retval += bytes_to_copy;
 		buf += bytes_to_copy;
diff --git a/fs/verity/verify.c b/fs/verity/verify.c
index 904ccd7e8e16..2fe7bd57b16e 100644
--- a/fs/verity/verify.c
+++ b/fs/verity/verify.c
@@ -183,7 +183,7 @@ verify_data_block(struct inode *inode, struct fsverity_info *vi,
 			memcpy(_want_hash, haddr + hoffset, hsize);
 			want_hash = _want_hash;
 			kunmap_local(haddr);
-			put_page(hpage);
+			fsverity_drop_page(inode, hpage);
 			goto descend;
 		}
 		hblocks[level].page = hpage;
@@ -218,7 +218,7 @@ verify_data_block(struct inode *inode, struct fsverity_info *vi,
 		memcpy(_want_hash, haddr + hoffset, hsize);
 		want_hash = _want_hash;
 		kunmap_local(haddr);
-		put_page(hpage);
+		fsverity_drop_page(inode, hpage);
 	}
 
 	/* Finally, verify the data block. */
@@ -237,7 +237,7 @@ verify_data_block(struct inode *inode, struct fsverity_info *vi,
 error:
 	for (; level > 0; level--) {
 		kunmap_local(hblocks[level - 1].addr);
-		put_page(hblocks[level - 1].page);
+		fsverity_drop_page(inode, hblocks[level - 1].page);
 	}
 	return false;
 }
diff --git a/include/linux/fsverity.h b/include/linux/fsverity.h
index 1eb7eae580be..6514ed6b09b4 100644
--- a/include/linux/fsverity.h
+++ b/include/linux/fsverity.h
@@ -120,6 +120,16 @@ struct fsverity_operations {
 	 */
 	int (*write_merkle_tree_block)(struct inode *inode, const void *buf,
 				       u64 pos, unsigned int size);
+
+	/**
+	 * Release the reference to a Merkle tree page
+	 *
+	 * @page: the page to release
+	 *
+	 * This is called when fs-verity is done with a page obtained with
+	 * ->read_merkle_tree_page().
+	 */
+	void (*drop_page)(struct page *page);
 };
 
 #ifdef CONFIG_FS_VERITY
@@ -174,6 +184,24 @@ bool fsverity_verify_blocks(struct folio *folio, size_t len, size_t offset);
 void fsverity_verify_bio(struct bio *bio);
 void fsverity_enqueue_verify_work(struct work_struct *work);
 
+/**
+ * fsverity_drop_page() - drop page obtained with ->read_merkle_tree_page()
+ * @inode: inode in use for verification or metadata reading
+ * @page: page to be dropped
+ *
+ * Generic put_page() method. Calls out back to filesystem if ->drop_page() is
+ * set, otherwise just drops the reference to a page.
+ *
+ */
+static inline void fsverity_drop_page(struct inode *inode, struct page *page)
+{
+	if (inode->i_sb->s_vop->drop_page)
+		inode->i_sb->s_vop->drop_page(page);
+	else
+		put_page(page);
+}
+
+
 #else /* !CONFIG_FS_VERITY */
 
 static inline struct fsverity_info *fsverity_get_info(const struct inode *inode)
@@ -251,6 +279,11 @@ static inline void fsverity_enqueue_verify_work(struct work_struct *work)
 	WARN_ON_ONCE(1);
 }
 
+static inline void fsverity_drop_page(struct inode *inode, struct page *page)
+{
+	WARN_ON_ONCE(1);
+}
+
 #endif	/* !CONFIG_FS_VERITY */
 
 static inline bool fsverity_verify_folio(struct folio *folio)
-- 
2.40.1

