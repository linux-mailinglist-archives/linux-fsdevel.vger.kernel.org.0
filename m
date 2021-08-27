Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40B7B3F9CF4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Aug 2021 18:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236713AbhH0Qvp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Aug 2021 12:51:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40116 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236724AbhH0Qve (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Aug 2021 12:51:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630083045;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gFRdiyPuactUcLg/wErn/XbBvh4nZFvYbNfA2glabKM=;
        b=Sd6Oe+k1XuX+Lvfio2pYAIjdA6BuzvfUvFvo8U519yIL7b664QDgfCQdkfiZ2StPWYjQZc
        yMBoya/Mr0ZS+356jj/IU5mqSDN1D4pWziPJ+olwVPG6lXJajpKNnIqKGVuUeVShNqRdLG
        I6b7eYNp9CizAHcjiANzAUYLORohFrI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-494-M31ZDbdSO2e6eAJH6BioaA-1; Fri, 27 Aug 2021 12:50:43 -0400
X-MC-Unique: M31ZDbdSO2e6eAJH6BioaA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ED1281009E23;
        Fri, 27 Aug 2021 16:50:41 +0000 (UTC)
Received: from max.com (unknown [10.40.194.206])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EB82C60C82;
        Fri, 27 Aug 2021 16:50:29 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        cluster-devel@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        Bob Peterson <rpeterso@redhat.com>
Subject: [PATCH v7 09/19] gfs2: Remove redundant check from gfs2_glock_dq
Date:   Fri, 27 Aug 2021 18:49:16 +0200
Message-Id: <20210827164926.1726765-10-agruenba@redhat.com>
In-Reply-To: <20210827164926.1726765-1-agruenba@redhat.com>
References: <20210827164926.1726765-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Bob Peterson <rpeterso@redhat.com>

In function gfs2_glock_dq, it checks to see if this is the fast path.
Before this patch, it checked both "find_first_holder(gl) == NULL" and
list_empty(&gl->gl_holders), which is redundant. If gl_holders is empty
then find_first_holder must return NULL. This patch removes the
redundancy.

Signed-off-by: Bob Peterson <rpeterso@redhat.com>
---
 fs/gfs2/glock.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index fd280b6c37ce..f24db2ececfb 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -1514,12 +1514,11 @@ void gfs2_glock_dq(struct gfs2_holder *gh)
 
 	list_del_init(&gh->gh_list);
 	clear_bit(HIF_HOLDER, &gh->gh_iflags);
-	if (find_first_holder(gl) == NULL) {
-		if (list_empty(&gl->gl_holders) &&
-		    !test_bit(GLF_PENDING_DEMOTE, &gl->gl_flags) &&
-		    !test_bit(GLF_DEMOTE, &gl->gl_flags))
-			fast_path = 1;
-	}
+	if (list_empty(&gl->gl_holders) &&
+	    !test_bit(GLF_PENDING_DEMOTE, &gl->gl_flags) &&
+	    !test_bit(GLF_DEMOTE, &gl->gl_flags))
+		fast_path = 1;
+
 	if (!test_bit(GLF_LFLUSH, &gl->gl_flags) && demote_ok(gl))
 		gfs2_glock_add_to_lru(gl);
 
-- 
2.26.3

