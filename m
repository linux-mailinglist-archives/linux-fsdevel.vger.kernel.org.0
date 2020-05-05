Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B867A1C5250
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 May 2020 11:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728714AbgEEJ7d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 May 2020 05:59:33 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:48343 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728701AbgEEJ73 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 May 2020 05:59:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588672768;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4J/LkBdEboueddkWDbGtL76FcH5ycOdWjbYh+JqdAEM=;
        b=O3p7RfBX67osbbrnDBnYrR/QEbI1oPvmJNshzZPAb+4T/yfUhtYg/q5HJKhUQ43QUs22fL
        UgcVEBh7tPHZHf3K//PED/HojjlMysxULjl2xmbhQ0Wop3gH1fs+mHsjeFxILC6rEtbNxG
        1CuH6cmcS0xnRmoKOIB1G8FWpZPzohA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-485-mhHYd9bYPYCUp-Kr2-KFAg-1; Tue, 05 May 2020 05:59:27 -0400
X-MC-Unique: mhHYd9bYPYCUp-Kr2-KFAg-1
Received: by mail-wr1-f71.google.com with SMTP id p8so971435wrj.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 May 2020 02:59:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4J/LkBdEboueddkWDbGtL76FcH5ycOdWjbYh+JqdAEM=;
        b=FX9iHU1MSRy6biQxVftd0qUCcwccOGHEREUWNxPwaYOVyMFHdagILwxHspRZytUceW
         NgczlgCEd0FV+e9+0XNJPUuOQQaStlxqAcOhmitRCFG/558s3gr4xhHNiheXYguAG+Kz
         WZq0EWI30nyL6fnWQ7FXuQ479b4uUUNsn8ShuLMIYdp14tPzYx3nGX2uO5pQK4hgF8ZE
         R90ICx4N/J4V5IGdbTUhpx7mL7W1Nz3EDaD9gXhp2WvFLHKuEsIGFuUEiZoJCtbtsJJd
         eQcDNBsK0c62kqNeubhPIixHPS0QJkb2YnV7RzuxqJ33qdJyJ1sZn0yzvcKqwBlI1TGO
         fNQA==
X-Gm-Message-State: AGi0PuYwTIim1G8xTINXbCozPagqNQEFNPmFiaRQVU5hS+B+oNznjFrB
        9FyQmEdgBZKFqFB+RJH4h9Xx34et9y3Nf6pMsNQugqEI1u6KX0+MLsXIiRymdnSLfTlbeE5uLMw
        xDNKMfxiFMWif0rbMS/wJD3CTbg==
X-Received: by 2002:a1c:bc09:: with SMTP id m9mr2446448wmf.145.1588672765868;
        Tue, 05 May 2020 02:59:25 -0700 (PDT)
X-Google-Smtp-Source: APiQypK28sptWzG05TBfnidx/q2aKF56XjU0DY89EO48ZN2COM1CLb9sQWcKg09AMb/ywFhqkXje2w==
X-Received: by 2002:a1c:bc09:: with SMTP id m9mr2446431wmf.145.1588672765716;
        Tue, 05 May 2020 02:59:25 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id t16sm2862734wmi.27.2020.05.05.02.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 02:59:24 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, David Howells <dhowells@redhat.com>
Subject: [PATCH 07/12] statx: don't clear STATX_ATIME on SB_RDONLY
Date:   Tue,  5 May 2020 11:59:10 +0200
Message-Id: <20200505095915.11275-8-mszeredi@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200505095915.11275-1-mszeredi@redhat.com>
References: <20200505095915.11275-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

IS_NOATIME(inode) is defined as __IS_FLG(inode, SB_RDONLY|SB_NOATIME), so
generic_fillattr() will clear STATX_ATIME from the result_mask if the super
block is marked read only.

This was probably not the intention, so fix to only clear STATX_ATIME if
the fs doesn't support atime at all.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Acked-by: David Howells <dhowells@redhat.com>
---
 fs/stat.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/stat.c b/fs/stat.c
index a6709e7ba71d..f7f07d1b73cb 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -73,7 +73,8 @@ int vfs_getattr_nosec(const struct path *path, struct kstat *stat,
 	query_flags &= KSTAT_QUERY_FLAGS;
 
 	/* allow the fs to override these if it really wants to */
-	if (IS_NOATIME(inode))
+	/* SB_NOATIME means filesystem supplies dummy atime value */
+	if (inode->i_sb->s_flags & SB_NOATIME)
 		stat->result_mask &= ~STATX_ATIME;
 	if (IS_AUTOMOUNT(inode))
 		stat->attributes |= STATX_ATTR_AUTOMOUNT;
-- 
2.21.1

