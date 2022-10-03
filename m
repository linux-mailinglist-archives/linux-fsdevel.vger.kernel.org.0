Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C48155F303A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Oct 2022 14:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbiJCMWJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Oct 2022 08:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiJCMWG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Oct 2022 08:22:06 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E31371BC;
        Mon,  3 Oct 2022 05:22:04 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id c11so16469906wrp.11;
        Mon, 03 Oct 2022 05:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=TIkUkS6ogLSq4cIP6DAYUvne3O+N/YCgY5mK3r4+77I=;
        b=iYmtUWF2PG4zvdl+97Rq1UOf31uOYluCWxFKdr79NdKrgSCzG7WTy6pEEu5PPJZMk0
         YpQkjiWz9NPS+nZXSXnSOlx5UmfPQ5DdQpgAFr96qGQEMXGXrdCMgaR6iPAP9ACfCZ8k
         hR+ztQsNt2HUfSOnga3+QNYLakYpwZKeKlDYYJ0gvQ2+v1mekWfs1FWZYq1dIYFv95aE
         llCSOYc0GQt39xYau2BgePxoRoh7X1ngwemim0mgkbZqJdGQ2/3vTdrFzXxHKYwdieAN
         C0gY6tCdZCiWJAlXJBbDK2Sqj8U3Tur1Ru9hvFIHKyhy9XenxEpleyVtJvDHM1IwkqKh
         BQnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=TIkUkS6ogLSq4cIP6DAYUvne3O+N/YCgY5mK3r4+77I=;
        b=ClXk4wO2Y/9U4yMJisXFkAjzhwrRw7TGyAl36zDUDE7qNCXybq8AZyq2E6cdDjee9p
         M1bQyHGxep7LJUznM5j/++/dZI4xuO7B10dJWNCN1cfUnAIYh7F4Q/RkKm7WvTKv62a5
         SO+aIlGeQQTm9WODpXI3/HjQ5/GnHYl80IQKqqzkQYHTwJvf2qhH76SbKSR1JsfE10Ef
         3Pfs8DZDwV2Z5qq2MN2LNkK9BIKCoNTq7sY4VYLiy0xbUQSI8znChEMbfeCfCQXuKEq7
         Xk5OM0oOpJKZIFLt3706IahVZXwb1NYlpVkgoaGjQTuvLGVXcKwJsoSkZg5dey7k/c3e
         RNIA==
X-Gm-Message-State: ACrzQf1lCRwO6RcKZmxBUgQ62id7GbIUiWTg6mVYuUsDEB9wBepNBrCl
        d5xeUL+WLSCAFbVD2g0Udhs=
X-Google-Smtp-Source: AMsMyM6EST0kfm7s7umrgBy5gHG82CwA6g61+pnT5guTMT5tnVCUSCSbEk3LE+T7J2BPk6Tm9/ySUg==
X-Received: by 2002:a05:6000:1887:b0:22a:3c3d:75ea with SMTP id a7-20020a056000188700b0022a3c3d75eamr12173828wri.669.1664799723022;
        Mon, 03 Oct 2022 05:22:03 -0700 (PDT)
Received: from localhost.localdomain ([5.29.8.191])
        by smtp.gmail.com with ESMTPSA id v11-20020a05600c444b00b003a682354f63sm16983387wmn.11.2022.10.03.05.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 05:22:02 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Christian Brauner <brauner@kernel.com>,
        Yang Xu <xuyang2018.jy@fujitsu.com>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Filipe Manana <fdmanana@kernel.org>,
        linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/2] ovl: remove privs in ovl_copyfile()
Date:   Mon,  3 Oct 2022 15:21:53 +0300
Message-Id: <20221003122154.900300-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221003122154.900300-1-amir73il@gmail.com>
References: <20221003122154.900300-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Underlying fs doesn't remove privs because copy_range/remap_range are
called with privileged mounter credentials.

This fixes some failures in fstest generic/673.

Fixes: 8ede205541ff ("ovl: add reflink/copyfile/dedup support")
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/overlayfs/file.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index d17faeb014e5..c8308da8909a 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -567,14 +567,23 @@ static loff_t ovl_copyfile(struct file *file_in, loff_t pos_in,
 	const struct cred *old_cred;
 	loff_t ret;
 
+	inode_lock(inode_out);
+	if (op != OVL_DEDUPE) {
+		/* Update mode */
+		ovl_copyattr(inode_out);
+		ret = file_remove_privs(file_out);
+		if (ret)
+			goto out_unlock;
+	}
+
 	ret = ovl_real_fdget(file_out, &real_out);
 	if (ret)
-		return ret;
+		goto out_unlock;
 
 	ret = ovl_real_fdget(file_in, &real_in);
 	if (ret) {
 		fdput(real_out);
-		return ret;
+		goto out_unlock;
 	}
 
 	old_cred = ovl_override_creds(file_inode(file_out)->i_sb);
@@ -603,6 +612,9 @@ static loff_t ovl_copyfile(struct file *file_in, loff_t pos_in,
 	fdput(real_in);
 	fdput(real_out);
 
+out_unlock:
+	inode_unlock(inode_out);
+
 	return ret;
 }
 
-- 
2.25.1

