Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBDF65302EB
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 May 2022 14:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344528AbiEVMIq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 22 May 2022 08:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344247AbiEVMIp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 22 May 2022 08:08:45 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B600D3A5D9
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 May 2022 05:08:44 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id p22so21236601lfo.10
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 May 2022 05:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:cc
         :content-language:to:content-transfer-encoding;
        bh=uk1OTCr2W3WWHv7qfitt9BCJebEVB6x82RShNeGdjGw=;
        b=mEF9IYA2ZRrG+Bhx9uSNUkHKRVD23MKTrWJX9EOlAiZbU9wRpuRejbqb2yLlDp8X9T
         OVkYvX99lVBCZH9yTyNW6wz5dmwwcIBqDmkd/kfmDjs3QU1HfzQdsxjESnW8mUYaRriV
         6Z4j9R5Mh+vtTVlzeoT2gT0K6gCelvK0vbTZruG93Te7htRZiAVz7U6cNyRlgAQwtYel
         +khOQlfIVKnMgrxe6lzMhkz7YFkBNTHNvwIKm+FE/qVA8uF0/bN7dRsE07cNtwCKgfFg
         Pcfya8g6j5nTQas5lCGnlj8hXDt/amkiz1SujbiF71e4J7xwvJ/qqttoZJJgITEQWL4x
         aLRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:cc:content-language:to:content-transfer-encoding;
        bh=uk1OTCr2W3WWHv7qfitt9BCJebEVB6x82RShNeGdjGw=;
        b=s8Y2WibgsnflkicyHTc6QUXqwZFhTaNAta6ox8mY1VrtVp6bwT5fCMgmrWJKAPrlnx
         B/dKhzA/UA2wXkSKXuL9yazHE+dbHHGD7Y+REv/Z8PTymoPl+iCum2QhPpsOI8PwC3H6
         yK+f6cNkWfKNPd27fMSC0duAlIIXSWuz1liHX4d0QwghPGcpNKEhjoWdS3TAGDUYm5fl
         Ym6bvOOspqf+xuqQkmm4W9NUHEXjscF4jCCkZvCAveexsQFVppLqUaNmJ3buyUCNlwwb
         tGFjrsasvrpRZRAbZjvfB4EktsabyBzFA6+1pj5rt+lmXLZt8GXmE1rtkGjGolG+tKHD
         DGvA==
X-Gm-Message-State: AOAM532zuGlk1cpfonDCvN4WuFx+/68FBzgdDPEbLaY+B6qgKZ+mSus8
        XnvSJUwDKFzifp/WMO+k7EvqrCcqqJz1aQ==
X-Google-Smtp-Source: ABdhPJxsub/tSLeBC47HC0Z3fGzJDBVGTK4hyMDtXUm3DePwV2n9xRDKDcZEUjVMkW/ZR/uBPp8xdg==
X-Received: by 2002:a05:6512:3f94:b0:474:68e:46c3 with SMTP id x20-20020a0565123f9400b00474068e46c3mr13678027lfa.431.1653221323129;
        Sun, 22 May 2022 05:08:43 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.185])
        by smtp.gmail.com with ESMTPSA id t25-20020ac24c19000000b0047255d21181sm1426580lfq.176.2022.05.22.05.08.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 May 2022 05:08:42 -0700 (PDT)
Message-ID: <31a6874c-1cb8-e081-f1ca-ef1a81f9dda0@openvz.org>
Date:   Sun, 22 May 2022 15:08:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
From:   Vasily Averin <vvs@openvz.org>
Subject: [PATCH v3] fs/proc/base.c: fix incorrect fmode_t casts
Cc:     kernel@openvz.org, linux-kernel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fixes sparce warnings:
fs/proc/base.c:2240:25: sparse: warning: cast to restricted fmode_t
fs/proc/base.c:2297:42: sparse: warning: cast from restricted fmode_t
fs/proc/base.c:2394:48: sparse: warning: cast from restricted fmode_t

fmode_t is birwie type and requires __force attribute for any cast

Signed-off-by: Vasily Averin <vvs@openvz.org>
---
v3: split, reworked according to Christoph Hellwig recommendation
---
 fs/proc/base.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index c1031843cc6a..4e4edf9db5f0 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2237,13 +2237,13 @@ static struct dentry *
 proc_map_files_instantiate(struct dentry *dentry,
 			   struct task_struct *task, const void *ptr)
 {
-	fmode_t mode = (fmode_t)(unsigned long)ptr;
+	const fmode_t *mode = ptr;
 	struct proc_inode *ei;
 	struct inode *inode;
 
 	inode = proc_pid_make_inode(dentry->d_sb, task, S_IFLNK |
-				    ((mode & FMODE_READ ) ? S_IRUSR : 0) |
-				    ((mode & FMODE_WRITE) ? S_IWUSR : 0));
+				    ((*mode & FMODE_READ ) ? S_IRUSR : 0) |
+				    ((*mode & FMODE_WRITE) ? S_IWUSR : 0));
 	if (!inode)
 		return ERR_PTR(-ENOENT);
 
@@ -2294,7 +2294,7 @@ static struct dentry *proc_map_files_lookup(struct inode *dir,
 
 	if (vma->vm_file)
 		result = proc_map_files_instantiate(dentry, task,
-				(void *)(unsigned long)vma->vm_file->f_mode);
+						    &vma->vm_file->f_mode);
 
 out_no_vma:
 	mmap_read_unlock(mm);
@@ -2391,7 +2391,7 @@ proc_map_files_readdir(struct file *file, struct dir_context *ctx)
 				      buf, len,
 				      proc_map_files_instantiate,
 				      task,
-				      (void *)(unsigned long)p->mode))
+				      &p->mode))
 			break;
 		ctx->pos++;
 	}
-- 
2.36.1

