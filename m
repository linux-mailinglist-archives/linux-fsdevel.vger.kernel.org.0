Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 292D81F760A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jun 2020 11:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbgFLJeL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Jun 2020 05:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbgFLJeI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Jun 2020 05:34:08 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D36C03E96F
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jun 2020 02:34:08 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id mb16so9447130ejb.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jun 2020 02:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=X5siOvQBNShUtnvB4zxkqwmfdY0mViL1F/Vp+45S0Ys=;
        b=gScFvi2/1NnV6++VTOBqIJFBM+9rly5ig695/g/bnZLW+cSHzw0lWjLu0YSMgMFXSx
         VeVz4ltrT6cDSNKu8WkbwQyRVK2Nsq6Kgo5WXlp2ObWAbKsK9jBEDWk6TKRLwUBaFY9A
         j0nxciFw/o8mwT0xUCDSPvmjVVHOm3G8HbGcQAepv0UQGzSugLbcB1MbhBci7g+YOg9U
         fmE5tsleWocqckRdGiTZMwRdJwLhRlYdmttiFBtIbjm6X2abLAgFaaVrq9A70Twqls33
         3LkVBmnr1fHpNQojn0ddvWrozwMpuqLaXaIysn3Ej+R8FaZDFopZTJo6i2uXDzsCi1L5
         RQwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=X5siOvQBNShUtnvB4zxkqwmfdY0mViL1F/Vp+45S0Ys=;
        b=l2PzzM/xTeXop4Ouyp7NQh76flDYpXNzEn4GBOzKaBNCS0Bq8LM11Ygem8N0aT6xYo
         wJdjeS3aEy98xIyIptfkWgVS1vFX0xEhR+haOiitj2L/lEJ+OhTyeLPa+JppHouhIMow
         Zq9qCmI2NP4E4oD9RsgH4mLE17Tx4cP2Hf3YYYHVIN1+Ib3t2a8GQE0auvdx5aPYfdXE
         jjkoDwYn6RtDBMr/QdNCWH4sJOAiqvgXG/nG46K7ZqP4LsWczTQf6OURHB8BuFMAL1H/
         f37iYq2PNqMBkZrSUULhC0lQTjUbGCTOQthQH8SpdwsaXoD7Lighc4Gr8BnLlL9MnKPg
         lTjQ==
X-Gm-Message-State: AOAM533dj/DyNGW2d4hyttEqTqmnF4tZyLcWF//WMwtWfXMjvS78JyHx
        0bOWD4J1suBP2AyDeQy1mTY=
X-Google-Smtp-Source: ABdhPJzNbjzo6dmDSsndWnvZYry1h323fQpVx5MtlXwaw8Ef7aWXNdwGIFkPfe/suX5adzHMS/7yvQ==
X-Received: by 2002:a17:906:f10a:: with SMTP id gv10mr11985547ejb.309.1591954446788;
        Fri, 12 Jun 2020 02:34:06 -0700 (PDT)
Received: from localhost.localdomain ([5.102.204.95])
        by smtp.gmail.com with ESMTPSA id l2sm2876578edq.9.2020.06.12.02.34.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 02:34:06 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 04/20] nfsd: use fsnotify_data_inode() to get the unlinked inode
Date:   Fri, 12 Jun 2020 12:33:27 +0300
Message-Id: <20200612093343.5669-5-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200612093343.5669-1-amir73il@gmail.com>
References: <20200612093343.5669-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The inode argument to handle_event() is about to become obsolete.
Return non const inode pointer from fsnotify_data_inode(), fsnotify
hooks do not pass const inode pointer as data.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/nfsd/filecache.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 82198d747c4c..ace8e5c30952 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -599,11 +599,13 @@ static struct notifier_block nfsd_file_lease_notifier = {
 
 static int
 nfsd_file_fsnotify_handle_event(struct fsnotify_group *group,
-				struct inode *inode,
+				struct inode *to_tell,
 				u32 mask, const void *data, int data_type,
 				const struct qstr *file_name, u32 cookie,
 				struct fsnotify_iter_info *iter_info)
 {
+	struct inode *inode = fsnotify_data_inode(data, data_type);
+
 	trace_nfsd_file_fsnotify_handle_event(inode, mask);
 
 	/* Should be no marks on non-regular files */
-- 
2.17.1

