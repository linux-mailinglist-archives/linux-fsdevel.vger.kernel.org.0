Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4F0A26BBCB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Sep 2020 07:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbgIPF1S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Sep 2020 01:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbgIPF1Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Sep 2020 01:27:16 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51273C06174A;
        Tue, 15 Sep 2020 22:27:16 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id u9so2561238plk.4;
        Tue, 15 Sep 2020 22:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VJVDbbAlJ3EVegFgwxB/3/h59utgDfMyQ6scbBMOYNk=;
        b=A0ZiSvqZool5kn3WbGpLkkhh1vZthuLxPC3zqqCNTVibSFcUjMOQ+IUGBS76hngwPv
         HkhVhMiEAN1f4INTdiJhlJVzg883lrpc+AIXKZNa+mFvXd5zEosYgM+SJqH9NRkHVBlk
         ArrNt4lfQtr894OODK5r+0MnLMvB0bYcbUnzaQhmpwjc2fXXu4C8mCZ191kIWCQJ4t6F
         kDYQSIRirP6Tp8CkHTRvLB7vW4upDxNNvNPDLLocCqdRtZ9cyNjvo7LNjeZhyedD/+s3
         kkNAmVK5nV4Maqc26fX6hZ7qhAp7NuT6skNoWfE78Ptl2PspbfuAjO2gTZ9DhKuyyVZq
         zspw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VJVDbbAlJ3EVegFgwxB/3/h59utgDfMyQ6scbBMOYNk=;
        b=AwNEnmAd/z/zqNtlhhxJAy1bpRF4XUlPT7HVW0KhM569C8frHeVJQ0lBFuJvD1P89S
         HcAOM9JMb2uH/3qnvW3ExHF/bc3PKDpHC1YzuPZnWA1YBnOtd7su4a2EceXlhUkZngCe
         eFlQYr/yJYR+sR2Gk4jlR/iTml1rnNfMgDY61BxP0wfrLLvWBEeZVLIBmph24j8VO+Re
         hY01I9ySrudcb9TMf+oTQ9pStOob5FSwjnfm97uSyaAFyOJMv0O+jA3dbtp+yALUi+zE
         4K1ekqvuXSRoFbA4bjx4ErTWCqsrfYA2FTTIpArQrWorP/+qNMW0e5uA/vHfui5YFnJD
         am0g==
X-Gm-Message-State: AOAM5309CnvYGAA3AtRUFGmYTkBPkRHNbTzxhVBidmMBB7wwdYi5nsp4
        NcnT2V4QYaVZ0W+b5sHB3BU=
X-Google-Smtp-Source: ABdhPJy8G9XX2Xhtqw57CWyGwxACp6HRAIaTDwKifUE1VrFl4nVVK524/rBCPvr4xEp0GINizv1eCQ==
X-Received: by 2002:a17:902:b086:b029:d1:e5e7:bddb with SMTP id p6-20020a170902b086b02900d1e5e7bddbmr4635762plr.59.1600234035653;
        Tue, 15 Sep 2020 22:27:15 -0700 (PDT)
Received: from localhost.localdomain ([49.207.198.18])
        by smtp.gmail.com with ESMTPSA id md10sm1172565pjb.45.2020.09.15.22.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 22:27:14 -0700 (PDT)
From:   Anant Thazhemadam <anant.thazhemadam@gmail.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        Anant Thazhemadam <anant.thazhemadam@gmail.com>,
        syzbot+4191a44ad556eacc1a7a@syzkaller.appspotmail.com,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fs: fix KMSAN uninit-value bug by initializing nd in do_file_open_root
Date:   Wed, 16 Sep 2020 10:56:56 +0530
Message-Id: <20200916052657.18683-1-anant.thazhemadam@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The KMSAN bug report for the bug indicates that there exists;
Local variable ----nd@do_file_open_root created at:
 do_file_open_root+0xa4/0xb40 fs/namei.c:3385
 do_file_open_root+0xa4/0xb40 fs/namei.c:3385

Initializing nd fixes this issue, and doesn't break anything else either

Fixes: https://syzkaller.appspot.com/bug?extid=4191a44ad556eacc1a7a
Reported-by: syzbot+4191a44ad556eacc1a7a@syzkaller.appspotmail.com
Tested-by: syzbot+4191a44ad556eacc1a7a@syzkaller.appspotmail.com
Signed-off-by: Anant Thazhemadam <anant.thazhemadam@gmail.com>
---
 fs/namei.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/namei.c b/fs/namei.c
index e99e2a9da0f7..b27382586209 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3404,7 +3404,7 @@ struct file *do_filp_open(int dfd, struct filename *pathname,
 struct file *do_file_open_root(struct dentry *dentry, struct vfsmount *mnt,
 		const char *name, const struct open_flags *op)
 {
-	struct nameidata nd;
+	struct nameidata nd = {};
 	struct file *file;
 	struct filename *filename;
 	int flags = op->lookup_flags | LOOKUP_ROOT;
-- 
2.25.1

