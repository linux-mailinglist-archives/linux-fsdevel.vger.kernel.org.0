Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC5173EBA0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jun 2023 22:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbjFZURW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jun 2023 16:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbjFZURS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jun 2023 16:17:18 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 974C3F2
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jun 2023 13:17:17 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-bfe702f99b8so4950092276.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jun 2023 13:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687810637; x=1690402637;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vzLka2g6v99bvwFV0X8erM243tNvsLeL+nN3D/Woyf0=;
        b=jl3ESW4pRptTgPA5siTyuZi4Dv3eIpwdoknSH2LtwJcVtjBKPOgQ/jrinpHbp8cp4s
         8kSuu4XpwQmNnDQ34kEm7SQ7FU/IidUCr0Es6Oq/JpJ4mxp6PHuI8lfioEOahtA7dHsb
         jU4tx4EK3uBQNEedRuvCWVgDSq0ipOoGvYFPpOAkHrQncUr7IXPp19yFx8S58+RQepSu
         gkBV0cFLMLaTSJSqn1Ngc7VTqUzsVuRg/7f1b5T22ZqC6lJiqdZNF1Rjopj9DmlBF9SL
         myqVI1CiOkrEIaXqYglvWuiSxyOn57nNgpoSKfltpgNFmeWDx7k04QmqaUfYKpfF6gKB
         kNpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687810637; x=1690402637;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vzLka2g6v99bvwFV0X8erM243tNvsLeL+nN3D/Woyf0=;
        b=P5QwkWpGZHdq9PAobbG6011yYESJpF5cnbR3xTo94uJ4Qhqc0TBjThgnyE2maHsV+h
         NyeDHavG5VvmeZKi6mx1jmB10Mgr6ZTV9yGvjKm8TehinssDGutFpW3jdJ9tcFqYJsUg
         KEhb9rQsnmVfhqO49M3Jbj03s+us8jotR/yFbMNV3XSGwQtY9BgiWXKc6Eb9YD3xfdj/
         Cb2b0EbkYogVidZ/oRWz/mLoz8g0G+HKzhu/OLJyIazbS4pPTnBJ70U24m8Yj23rJPVO
         FGJzRq0LOWY6+IIZ4+IYxFAXaHGRm/mi5cpMs4xenWS1jWPuEnZPFeG58qfyM2AVYMYT
         w3NA==
X-Gm-Message-State: AC+VfDyhPzQtdtRSYJAs0tmRqDckTHG79minChVk4m4GYc3Czak73A5E
        VTk98q+sLUIdmBxDsr2COSO1043HMcs=
X-Google-Smtp-Source: ACHHUZ5XEE6oajY8ojwA8+WsFwp5LtUJKNtkmnXQLDwPJWIeNDjbR+m2+M+hZm/6CP/uYZRuZbihuihODXA=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:5075:f38d:ce2f:eb1b])
 (user=surenb job=sendgmr) by 2002:a05:6902:91:b0:ba8:6dc0:cacf with SMTP id
 h17-20020a056902009100b00ba86dc0cacfmr6468725ybs.12.1687810636851; Mon, 26
 Jun 2023 13:17:16 -0700 (PDT)
Date:   Mon, 26 Jun 2023 13:17:12 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230626201713.1204982-1-surenb@google.com>
Subject: [PATCH 1/2] kernfs: add kernfs_ops.free operation to free resources
 tied to the file
From:   Suren Baghdasaryan <surenb@google.com>
To:     tj@kernel.org
Cc:     gregkh@linuxfoundation.org, peterz@infradead.org,
        lujialin4@huawei.com, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        mingo@redhat.com, ebiggers@kernel.org, oleg@redhat.com,
        akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, kernel-team@android.com,
        surenb@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

kernfs_ops.release operation can be called from kernfs_drain_open_files
which is not tied to the file's real lifecycle. Introduce a new kernfs_ops
free operation which is called only when the last fput() of the file is
performed and therefore is strictly tied to the file's lifecycle. This
operation will be used for freeing resources tied to the file, like
waitqueues used for polling the file.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 fs/kernfs/file.c       | 8 +++++---
 include/linux/kernfs.h | 5 +++++
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index 40c4661f15b7..acc52d23d8f6 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -766,7 +766,7 @@ static int kernfs_fop_open(struct inode *inode, struct file *file)
 
 /* used from release/drain to ensure that ->release() is called exactly once */
 static void kernfs_release_file(struct kernfs_node *kn,
-				struct kernfs_open_file *of)
+				struct kernfs_open_file *of, bool final)
 {
 	/*
 	 * @of is guaranteed to have no other file operations in flight and
@@ -787,6 +787,8 @@ static void kernfs_release_file(struct kernfs_node *kn,
 		of->released = true;
 		of_on(of)->nr_to_release--;
 	}
+	if (final && kn->attr.ops->free)
+		kn->attr.ops->free(of);
 }
 
 static int kernfs_fop_release(struct inode *inode, struct file *filp)
@@ -798,7 +800,7 @@ static int kernfs_fop_release(struct inode *inode, struct file *filp)
 		struct mutex *mutex;
 
 		mutex = kernfs_open_file_mutex_lock(kn);
-		kernfs_release_file(kn, of);
+		kernfs_release_file(kn, of, true);
 		mutex_unlock(mutex);
 	}
 
@@ -852,7 +854,7 @@ void kernfs_drain_open_files(struct kernfs_node *kn)
 		}
 
 		if (kn->flags & KERNFS_HAS_RELEASE)
-			kernfs_release_file(kn, of);
+			kernfs_release_file(kn, of, false);
 	}
 
 	WARN_ON_ONCE(on->nr_mmapped || on->nr_to_release);
diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
index 73f5c120def8..a7e404ff31bb 100644
--- a/include/linux/kernfs.h
+++ b/include/linux/kernfs.h
@@ -273,6 +273,11 @@ struct kernfs_ops {
 	 */
 	int (*open)(struct kernfs_open_file *of);
 	void (*release)(struct kernfs_open_file *of);
+	/*
+	 * Free resources tied to the lifecycle of the file, like a
+	 * waitqueue used for polling.
+	 */
+	void (*free)(struct kernfs_open_file *of);
 
 	/*
 	 * Read is handled by either seq_file or raw_read().
-- 
2.41.0.162.gfafddb0af9-goog

