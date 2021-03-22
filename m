Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 994D2344D96
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Mar 2021 18:40:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232025AbhCVRkH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Mar 2021 13:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232011AbhCVRjx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Mar 2021 13:39:53 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C64D6C061574
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Mar 2021 10:39:52 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id d191so9660354wmd.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Mar 2021 10:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L3sTdhQ5v1OVEw0UZY5TFnzGoHyxLs0I3bglRdItHtU=;
        b=Gc+Wcaf6vjj6tcbQzqR9WoQYueQSfQpZwPWY79SQx/2rpwtNtW3nh6SqxpMsVoJrdi
         NCSH+Jm1kZpMDMGIWuwj9ET4e6K+zdMYphDL9n42cNnRTuasRSoyTRRMTQAXrPVVyxXR
         wjPf8jKDku1intl5Hom82hrI963FMIsxPJwb+8zC7725Ozh+XJHcWL/qI9juBQycvQq5
         OT31o3VcT5fTHc9lJ1vOo92OalQHxUrzWgPtKa8WBcWTR23xFSGMoADLNWuwGmlCbad1
         zWjZTIHvaJ1FtR6kszXfdh9C9yi4U0KdXWBF9XytMQW7lPdXS/Ff3dd2uVzwqr66pb1g
         aiHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L3sTdhQ5v1OVEw0UZY5TFnzGoHyxLs0I3bglRdItHtU=;
        b=ECxqM8/KtsqBRLXU8vWxgb+yruC8rruSMPS+jA9imIZxR3XGOo/687im+QfQIMTsFt
         WB2sesdFdfQWbPIaCkwH7WvuiNI5QeqvmnPyaZjGZ2mJTV8/PEZKMjcOZr22VAalDRHq
         d8yq0rQ7NvsY1aGs2TCJ5/Vq+GW8YBQQctrZQaawVcqpJI20e2yH8l40iDxKKaOWqvwl
         dHPVbrHRMOuSYdWlgMzoiURkD2cLjr9Ux7Zego/tP4cftvpZYrZrSkuDEVxgzn1Y9mUu
         cdJ11iYoF6tiZUCYXmhU9KGMilbabx82ShwFesmAL9EXMR9iWvshx1QOVM1mlBfJS91J
         TXSQ==
X-Gm-Message-State: AOAM532R+O0D4b+ywBxsg5xFAY1wa+BQznXJXOhUGCQq4upM9O+Vpc+G
        zDg5MaR7XCXNC1YohhZtivU=
X-Google-Smtp-Source: ABdhPJwjNJUBnLEsoCkoIrWXiquBwyY6hFB5Hg6Z9aaKN4QxYGZ1VPZ3X8XPr2t1+V7Qw9D7rIQXxA==
X-Received: by 2002:a1c:4c10:: with SMTP id z16mr161313wmf.136.1616434791610;
        Mon, 22 Mar 2021 10:39:51 -0700 (PDT)
Received: from localhost.localdomain ([141.226.241.101])
        by smtp.gmail.com with ESMTPSA id p27sm138790wmi.12.2021.03.22.10.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 10:39:50 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Hugh Dickins <hughd@google.com>, Theodore Tso <tytso@mit.edu>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/2] shmem: allow reporting fanotify events with file handles on tmpfs
Date:   Mon, 22 Mar 2021 19:39:44 +0200
Message-Id: <20210322173944.449469-3-amir73il@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210322173944.449469-1-amir73il@gmail.com>
References: <20210322173944.449469-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Since kernel v5.1, fanotify_init(2) supports the flag FAN_REPORT_FID
for identifying objects using file handle and fsid in events.

fanotify_mark(2) fails with -ENODEV when trying to set a mark on
filesystems that report null f_fsid in stasfs(2).

Use the digest of uuid as f_fsid for tmpfs to uniquely identify tmpfs
objects as best as possible and allow setting an fanotify mark that
reports events with file handles on tmpfs.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 mm/shmem.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/shmem.c b/mm/shmem.c
index b2db4ed0fbc7..162d8f8993bb 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2846,6 +2846,9 @@ static int shmem_statfs(struct dentry *dentry, struct kstatfs *buf)
 		buf->f_ffree = sbinfo->free_inodes;
 	}
 	/* else leave those fields 0 like simple_statfs */
+
+	buf->f_fsid = uuid_to_fsid(dentry->d_sb->s_uuid.b);
+
 	return 0;
 }
 
-- 
2.25.1

