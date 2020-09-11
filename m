Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B17CC265871
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Sep 2020 06:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725771AbgIKEpM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Sep 2020 00:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgIKEpJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Sep 2020 00:45:09 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BEDBC061573;
        Thu, 10 Sep 2020 21:45:09 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id fa1so1114179pjb.0;
        Thu, 10 Sep 2020 21:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GkavzkycfND+4vCO4VeMuzt7qDfojSlqnl/vJMxoJ74=;
        b=mWUO7v67Y6xXVzWk3lUJ0Xc+U+hXxP+LiKgr8S1C8lYRYvLawsv+HwfKW+PdYa7Xr8
         4FZCpEW60nNVlSfjBdEAnRwSL6d7BLOG5IxOdEcPVGja0R2vdlGQDexqU4+cnW0tXnAC
         4piV8hlet/mzc1ubJJGbUratt+qr6+m8/FL233KLhzFRt9dnjw/m0LFz3MDPp0FYJ2UI
         e6RPJXhD9IToMJ9YGEmFzaZB9RudhES4UCrXDMQFTXekCHnJgjZvpibJLBVE42BGA0dT
         yQp+x4Z0dbE4fh5SG1UxqkI94n5Wn/p8Bh1s1bCptn1pAAZSr2GS5f+wjLQmBW9qVze7
         6MRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GkavzkycfND+4vCO4VeMuzt7qDfojSlqnl/vJMxoJ74=;
        b=ZtY7jCc6Px1HBNfJIeWgA8mMRbH8xQFzSVZy9eaqTt043IZwZ3uWrxRRjS40FCYax6
         NA1lZpsOnvDTYdsvOm3nleZsShYl415VgllvCojJYY+gEws+ONjIPwir1gfNmeK/GiwN
         9on9qH6vM4KuC7iPA9/0XyiHEjQSLEY8HMscYDBy46hqyV0eUpo3GkpE3CjacXC0U7G2
         Ic8K79/BDbyknSNE7K+WUWACZT5pS60//yoM7D5hG1vPel70xvQ2bVcfylFjcS58jghK
         tVoM2kZEDOD+dsThPfpMNexLQtMK2dvJ7fQGniDPZZQfqD0w32LO0zTcqfAqBiY1gZUj
         5shA==
X-Gm-Message-State: AOAM531OesXk9BIkGaNoHEzZjGSOcN4pefDZqqWMBQFozbHrFOByTpNy
        3Guvz4rlr9hB1Y0+hmTZPdRujA10aTI=
X-Google-Smtp-Source: ABdhPJwrP7C4ZNKEuVVFvnL2lUjp5HzDw0xYe6dftWod5cniZ2dUxjHLK5uCNxid9TR/kz30soFbhQ==
X-Received: by 2002:a17:90a:104f:: with SMTP id y15mr523800pjd.45.1599799508685;
        Thu, 10 Sep 2020 21:45:08 -0700 (PDT)
Received: from dc803.localdomain (FL1-111-169-191-163.hyg.mesh.ad.jp. [111.169.191.163])
        by smtp.gmail.com with ESMTPSA id a23sm543817pgv.86.2020.09.10.21.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 21:45:08 -0700 (PDT)
From:   Tetsuhiro Kohada <kohada.t2@gmail.com>
To:     kohada.t2@gmail.com
Cc:     kohada.tetsuhiro@dc.mitsubishielectric.co.jp,
        mori.takahiro@ab.mitsubishielectric.co.jp,
        motai.hirotaka@aj.mitsubishielectric.co.jp,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] exfat: remove useless check in exfat_move_file()
Date:   Fri, 11 Sep 2020 13:45:06 +0900
Message-Id: <20200911044506.13912-1-kohada.t2@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In exfat_move_file(), the identity of source and target directory has been
checked by the caller.
Also, it gets stream.start_clu from file dir-entry, which is an invalid
determination.

Signed-off-by: Tetsuhiro Kohada <kohada.t2@gmail.com>
---
 fs/exfat/namei.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
index 803748946ddb..1c433491f771 100644
--- a/fs/exfat/namei.c
+++ b/fs/exfat/namei.c
@@ -1095,11 +1095,6 @@ static int exfat_move_file(struct inode *inode, struct exfat_chain *p_olddir,
 	if (!epmov)
 		return -EIO;
 
-	/* check if the source and target directory is the same */
-	if (exfat_get_entry_type(epmov) == TYPE_DIR &&
-	    le32_to_cpu(epmov->dentry.stream.start_clu) == p_newdir->dir)
-		return -EINVAL;
-
 	num_old_entries = exfat_count_ext_entries(sb, p_olddir, oldentry,
 		epmov);
 	if (num_old_entries < 0)
-- 
2.25.1

