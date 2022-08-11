Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70B5058F714
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Aug 2022 06:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233915AbiHKEzm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Aug 2022 00:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbiHKEzk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Aug 2022 00:55:40 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99474606B9
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Aug 2022 21:55:39 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id w28so4588641qtc.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Aug 2022 21:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:message-id:subject:cc:to:from:date:from:to:cc;
        bh=Livy2eVp0oE6BvapXUHOqoc+qrYCMvetxKGx/oHIznU=;
        b=KYTrUnak0g/usjIFO/ZNDzJxAOGsMVs1p9UqyFngCX4RIQ2DhFYpf7yXJbAuSyNX8V
         tXLInbqEaia/rWRDMzQ2cmqhqvi7w8r40U2u8xmdsl5ZgwDQOrNAjiFQkRgW46gvP9cQ
         ye2YKsn3lpYXP5HbehH5s92HgTRT8biHp3dcxAc7Yna3k2Lm2iJISektyNABe1nRXzYs
         JQto9/AHKRUxSR9VBP9mf2AfeXUd2RBew76Jic7w4t72yC6t/hEJhdUsUet2PaaXG+it
         /bJnc3Z6gGNSy2O0o3rA7Da+zr+yfNsIDQicrNEGlVJEQhh9x4P1k+GbaelgZ0GAJnCR
         kb7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc;
        bh=Livy2eVp0oE6BvapXUHOqoc+qrYCMvetxKGx/oHIznU=;
        b=IBCUmVcisgaxQBmOxNGELHNy2eRm+9DFuN3USRiD1uv86t0kHTdypWOJxx/wqS5jbF
         A1pbeEFaSQUZBGROCatjEqxh09eTCTxgpK3ZupaKUq2F2asLDX+mubXQubBu/INndy73
         SfKKLPFX591HRu8eaUmtCSE0R3AE6J/CSm04wBsA8FbsoZ01GiODlG/NVz++ugeI+U8j
         OBMlkbOhnsPkw5GDlugdB1tqJP1ZLBvUG58/zgKl/jfC4R9lr1pdq/pvA+qToLYqJ7SO
         Iw6XMR6vJZLekr5MaEEtWMwPO6HZatmzc4G++DE3DYskszVd624c+UVGFse4uL4WBxXy
         Qhjg==
X-Gm-Message-State: ACgBeo043hvTBan7ccf8HW/IRrwqDZQ7H+4W7Ro89QNIjG/6eUBpJYZe
        PIgY+v5otJR4FhYc8+T7pSXxSuisWrSkNg==
X-Google-Smtp-Source: AA6agR4AybdacHnM4HqeZIxBY+/3+U4qzpHnjFLWyZ+Sv/uep2K5Ga46VfT3pVrkxOdkftnl12lyFA==
X-Received: by 2002:ac8:7d92:0:b0:31f:1fe3:2bfe with SMTP id c18-20020ac87d92000000b0031f1fe32bfemr27577728qtd.628.1660193738692;
        Wed, 10 Aug 2022 21:55:38 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id y6-20020ae9f406000000b006b8cff25187sm1261607qkl.42.2022.08.10.21.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 21:55:38 -0700 (PDT)
Date:   Wed, 10 Aug 2022 21:55:36 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     "Darrick J. Wong" <djwong@kernel.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH] mm/shmem: tmpfs fallocate use file_modified()
Message-ID: <39c5e62-4896-7795-c0a0-f79c50d4909@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

5.18 fixed the btrfs and ext4 fallocates to use file_modified(), as xfs
was already doing, to drop privileges: and fstests generic/{683,684,688}
expect this.  There's no need to argue over keep-size allocation (which
could just update ctime): fix shmem_fallocate() to behave the same way.

Signed-off-by: Hugh Dickins <hughd@google.com>
---

 mm/shmem.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2839,12 +2839,13 @@ static long shmem_fallocate(struct file *file, int mode, loff_t offset,
 
 	if (!(mode & FALLOC_FL_KEEP_SIZE) && offset + len > inode->i_size)
 		i_size_write(inode, offset + len);
-	inode->i_ctime = current_time(inode);
 undone:
 	spin_lock(&inode->i_lock);
 	inode->i_private = NULL;
 	spin_unlock(&inode->i_lock);
 out:
+	if (!error)
+		file_modified(file);
 	inode_unlock(inode);
 	return error;
 }
