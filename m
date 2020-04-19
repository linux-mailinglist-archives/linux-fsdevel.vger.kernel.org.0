Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59F8A1AFDA8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Apr 2020 21:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgDSTpx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Apr 2020 15:45:53 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45240 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbgDSTpv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Apr 2020 15:45:51 -0400
Received: by mail-pf1-f195.google.com with SMTP id w65so3871804pfc.12;
        Sun, 19 Apr 2020 12:45:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8eAcVIKDv5Pxv4vhGmI5RPGxd5/34ByDOVy4yEbxjOw=;
        b=RI7Tb7ixJCt7mw/hARKoiiuSv/PYwKGbDB0yUl4YY04/uKh4eVKP8I5syQ+xeI9Pjg
         iPQA8Q+ASOqzkEMHzMznAh4kaQR9/JN66r6tXUK0XdROzHecPRBUcWq4HShlkeZ9CPTb
         kjmBTD4VA0bBGBFQpIiY2ge0HA4azg4CQCeJ8oZLdGe8l8d4RJIQFqrKXbXXOshUKN5L
         vc+qltOeB7Sn/1YXyNPHtTuv0wYmxDJzJnnYR+Yar70eqICcLRO21+oL7VDnOj3N7jY4
         Ix7vwhCQ/eaqE1u3+PVRLmk9aPw3wbAxzfC439nDa+Rf8FbRdXZgbU8CUkUNdS52IjUp
         onoQ==
X-Gm-Message-State: AGi0PubRsfaehcCTpI/oyeEd5qyhjEy3Cu8XQfg++g9NF2nSfN5UmEjU
        /xAR30Y7wgF4PY5k0TLtn6Y=
X-Google-Smtp-Source: APiQypJKWR3D9PTkDLW015p+SOWl71AOzd1pfWUaHiOwDS7oh/tvTofjj4cC8q+yS3mo4hA7hYStiQ==
X-Received: by 2002:a63:3814:: with SMTP id f20mr4061780pga.283.1587325550777;
        Sun, 19 Apr 2020 12:45:50 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id v94sm12047750pjb.39.2020.04.19.12.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2020 12:45:43 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 10FCD422E5; Sun, 19 Apr 2020 19:45:39 +0000 (UTC)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk, viro@zeniv.linux.org.uk, bvanassche@acm.org,
        gregkh@linuxfoundation.org, rostedt@goodmis.org, mingo@redhat.com,
        jack@suse.cz, ming.lei@redhat.com, nstange@suse.de,
        akpm@linux-foundation.org
Cc:     mhocko@suse.com, yukuai3@huawei.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v2 09/10] block: panic if block debugfs dir is not created
Date:   Sun, 19 Apr 2020 19:45:28 +0000
Message-Id: <20200419194529.4872-10-mcgrof@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20200419194529.4872-1-mcgrof@kernel.org>
References: <20200419194529.4872-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If DEBUG_FS is disabled we have another inline
blk_debugfs_register() which just returns 0.

If BLK_DEV_IO_TRACE is enabled we rely on the block debugfs
directory to have been created. If BLK_DEV_IO_TRACE is not enabled
though, but if debugfs is still enabled we will always create a
debugfs directory for a request_queue. Instead of special-casing
this just for BLK_DEV_IO_TRACE, ensure this block debugfs dir is
always created at boot if we have enabled debugfs.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 block/blk-debugfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/blk-debugfs.c b/block/blk-debugfs.c
index 761318dcbf40..d6ec980e7531 100644
--- a/block/blk-debugfs.c
+++ b/block/blk-debugfs.c
@@ -15,6 +15,8 @@ struct dentry *blk_debugfs_root;
 void blk_debugfs_register(void)
 {
 	blk_debugfs_root = debugfs_create_dir("block", NULL);
+	if (!blk_debugfs_root)
+		panic("Failed to create block debugfs directory\n");
 }
 
 int __must_check blk_queue_debugfs_register(struct request_queue *q)
-- 
2.25.1

