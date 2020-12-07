Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52F732D162E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Dec 2020 17:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727725AbgLGQee (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Dec 2020 11:34:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41582 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727704AbgLGQed (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Dec 2020 11:34:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607358787;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=otYj369xse9R2kbOApLqBDn6NdlRsKHBl6lYbw3xZEw=;
        b=ilx0XmJ983dYodBhAs4Q4VYTh27yeCPwf400wL+Pl889/kCMZ3H/JgFwXDvphJofHKNn5z
        mmyVgH0ZX2O/c40zagkLrRiDZrQD92Vr8z45V1iNlB19sXxSuxnS9EyaKArbcmDKD4KQEU
        EY7LVA4XUQ/pnd9AuBc8Xgik11OMDgw=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-161-NuJeeIE0OXGuGguTw3uL8g-1; Mon, 07 Dec 2020 11:33:03 -0500
X-MC-Unique: NuJeeIE0OXGuGguTw3uL8g-1
Received: by mail-ej1-f71.google.com with SMTP id f12so4030770ejk.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Dec 2020 08:33:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=otYj369xse9R2kbOApLqBDn6NdlRsKHBl6lYbw3xZEw=;
        b=Zd2r2HboLr5Q+l5tw9HZV/pX4MhqaOzCSsHXCMkcimfPd347J8xwidh88dJSx9XP6N
         /yXNiEo8zCNEBTuL4yCPHtDhwDRLDbbT90xXMOKMQ58sxpOIULTqzoEeKKLRSG+nWx7K
         lsV2D2x25wddklgnifVGCHCWZwcwQ0s2GaTzS3o9732fwGoA5LThk1vnYcOgicpTMQOo
         e92FEoCVkicuUVKrFdLjWFTDagSqIzYBs1irjszWNdsvHru4PbIK4aQXTDX323O40Fwr
         5Z8nNvsfWCW7QXr8uUPiZcGEYNjle4DXJ08xORgiguP7FHQRPf1XNz2c+tyeFdvbdW3C
         MtRQ==
X-Gm-Message-State: AOAM531cbSkUFpr9XpGDaQb1jkrSpap1CwTNrQRq3FrTMCLRnrz6+K2G
        sH15K7mrmTfyP2l8WqkzKxPyVuszzkUntW+SsdXzF50Cey7aYMtPRu+1dAB53iL3jad8OMSVqu6
        fb3+MM4IMlyGGKZcP9mivv7BpPQ==
X-Received: by 2002:a17:906:c83b:: with SMTP id dd27mr19881674ejb.356.1607358782442;
        Mon, 07 Dec 2020 08:33:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJygw9J/iNohcy2imBMmRfiewi1ytt2qnsha6UorIQb1JISBnH+1nxrUZXhES5TAxxlwjwkJkQ==
X-Received: by 2002:a17:906:c83b:: with SMTP id dd27mr19881657ejb.356.1607358782244;
        Mon, 07 Dec 2020 08:33:02 -0800 (PST)
Received: from miu.piliscsaba.redhat.com (catv-86-101-169-67.catv.broadband.hu. [86.101.169.67])
        by smtp.gmail.com with ESMTPSA id op5sm12801964ejb.43.2020.12.07.08.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 08:33:01 -0800 (PST)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     "Eric W . Biederman" <ebiederm@xmission.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 02/10] vfs: verify source area in vfs_dedupe_file_range_one()
Date:   Mon,  7 Dec 2020 17:32:47 +0100
Message-Id: <20201207163255.564116-3-mszeredi@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201207163255.564116-1-mszeredi@redhat.com>
References: <20201207163255.564116-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Call remap_verify_area() on the source file as well as the destination.

When called from vfs_dedupe_file_range() the check as already been
performed, but not so if called from layered fs (overlayfs, etc...)

Could ommit the redundant check in vfs_dedupe_file_range(), but leave for
now to get error early (for fear of breaking backward compatibility).

This call shouldn't be performance sensitive.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/remap_range.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/remap_range.c b/fs/remap_range.c
index e6099beefa97..77dba3a49e65 100644
--- a/fs/remap_range.c
+++ b/fs/remap_range.c
@@ -456,8 +456,16 @@ loff_t vfs_dedupe_file_range_one(struct file *src_file, loff_t src_pos,
 	if (ret)
 		return ret;
 
+	/*
+	 * This is redundant if called from vfs_dedupe_file_range(), but other
+	 * callers need it and it's not performance sesitive...
+	 */
+	ret = remap_verify_area(src_file, src_pos, len, false);
+	if (ret)
+		goto out_drop_write;
+
 	ret = remap_verify_area(dst_file, dst_pos, len, true);
-	if (ret < 0)
+	if (ret)
 		goto out_drop_write;
 
 	ret = -EPERM;
-- 
2.26.2

