Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9CC38AE29
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 May 2021 14:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234337AbhETM2V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 May 2021 08:28:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51772 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232884AbhETM1P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 May 2021 08:27:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621513554;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GyKgynniRDUoKP5K5rhBmL1x4hLij6EvDAklIQldN/k=;
        b=J+uzWEnqwUsRbCfCfAve+LS6xvfsL78iNPpRcRN0jncSuAu3x3rH/mgEQRMyu2se7Z8T6i
        YG5W0py76X+hfYKowWr+lNAeJpUEYODc+mvbJ0rmEermCi4vNGA0aixhUdwedgIHlNzfJh
        zyRJU8t/orNi3IwGBBEjrDeevMH1TDs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-499-iGAexnAZPtOlhpFAS6pTVA-1; Thu, 20 May 2021 08:25:52 -0400
X-MC-Unique: iGAexnAZPtOlhpFAS6pTVA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7BBE0180FD61;
        Thu, 20 May 2021 12:25:51 +0000 (UTC)
Received: from max.com (unknown [10.40.195.97])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DC70760C04;
        Thu, 20 May 2021 12:25:49 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>, cluster-devel@redhat.com
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Jan Kara <jack@suse.cz>,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 4/6] gfs2: Encode glock holding and retry flags in journal_info
Date:   Thu, 20 May 2021 14:25:34 +0200
Message-Id: <20210520122536.1596602-5-agruenba@redhat.com>
In-Reply-To: <20210520122536.1596602-1-agruenba@redhat.com>
References: <20210520122536.1596602-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use the lowest two bits in current->journal_info to encode when
we're holding a glock and when an operation holding a glock
needs to be retried.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/incore.h | 35 +++++++++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/fs/gfs2/incore.h b/fs/gfs2/incore.h
index aa8d1a23132d..e32433df119c 100644
--- a/fs/gfs2/incore.h
+++ b/fs/gfs2/incore.h
@@ -871,14 +871,45 @@ static inline unsigned gfs2_max_stuffed_size(const struct gfs2_inode *ip)
 	return GFS2_SB(&ip->i_inode)->sd_sb.sb_bsize - sizeof(struct gfs2_dinode);
 }
 
+/*
+ * Transactions are always memory aligned, so we use bit 0 of
+ * current->journal_info to indicate when we're holding a glock and so taking
+ * random additional glocks might deadlock, and bit 1 to indicate when such an
+ * operation needs to be retried after dropping and re-acquiring that "outer"
+ * glock.
+ */
+
 static inline struct gfs2_trans *current_trans(void)
 {
-	return current->journal_info;
+	return (void *)((long)current->journal_info & ~3);
 }
 
 static inline void set_current_trans(struct gfs2_trans *tr)
 {
-	current->journal_info = tr;
+	long flags = (long)current->journal_info & 3;
+	current->journal_info = (void *)((long)tr | flags);
+}
+
+static inline bool current_holds_glock(void)
+{
+	return (long)current->journal_info & 1;
+}
+
+static inline bool current_needs_retry(void)
+{
+	return (long)current->journal_info & 2;
+}
+
+static inline void set_current_holds_glock(bool b)
+{
+	current->journal_info =
+		(void *)(((long)current->journal_info & ~1) | b);
+}
+
+static inline void set_current_needs_retry(bool b)
+{
+	current->journal_info =
+		(void *)(((long)current->journal_info & ~2) | (b << 1));
 }
 
 #endif /* __INCORE_DOT_H__ */
-- 
2.26.3

