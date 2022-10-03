Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16AC25F3051
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Oct 2022 14:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbiJCMax (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Oct 2022 08:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbiJCMat (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Oct 2022 08:30:49 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8ECE3ECE0;
        Mon,  3 Oct 2022 05:30:48 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id w18so7765225wro.7;
        Mon, 03 Oct 2022 05:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=TIkUkS6ogLSq4cIP6DAYUvne3O+N/YCgY5mK3r4+77I=;
        b=bk2k+GHDx0OumIX00AOPS18p4i/MFC39fD/Bjvr0xFCQQvH5rPmpTAEv1iMJ9GQwKo
         kSiPk/bmhV/e8g583IZoihuO7GXl9BgBzhPq87Z1dTsEiZSXE/AT52rhVc3M/+TUnVA0
         hSg1WPfxxgo7WY3v5Pjdr3qmJ+F1ce1Dz7XKFNf+W7KLcC1wbcT9Gn4ik9dcc2GLRxj4
         FHGfHEHotVgJ+VicF6jnWRL8KLQR/79KGI9YGGTpc9az/ETqXgNH/5JSRU+gNITUcq9X
         UUfqqjXOdFIdAz6cbws4Qh51rxvCzYQXN/aBOUTrj6WIYnhOaT8ruh1m1GZkAKRwkWzL
         1/JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=TIkUkS6ogLSq4cIP6DAYUvne3O+N/YCgY5mK3r4+77I=;
        b=LHLZzRrnRPX+BSoD0zjS1GZ7f55RGR3z+CUTiqNlGopJoR78e7Npwb2nqdWWP4sZ4G
         Ao2ChzVWzq7wdPPUiYMRlC7Xl+gfTxmdifImd3kxglM1VDbnBPgfCrNUJHqHsH/kYJhR
         za6igSUuuupRGi0+FRtiK3g+YS4M5Lt/KRpigbjKn3zd5QlewIJ0oBqeW8f1Kg3lgDkI
         sjzE1Jxsh2Zh/2OUr2EAWkEvYHwo2S4hQrbFaBUgViG5eXeKofBEYSWktY3aBwwfhHF8
         vPKQ1/fCQTUTwqthp/AFrgO2J2yhYUx5p4muibfjXoO3UIg5TLIuBYm1LMqD51vVROkh
         WZaA==
X-Gm-Message-State: ACrzQf0zJ1h0aqDn3VK4X82viE6Arl6xVJGLHAhwx9rSOjJShlaVUK87
        c/qfVT1ILqrOtrAJw7BiO7g=
X-Google-Smtp-Source: AMsMyM65S2to7BpHy75XW6R1IuJ97zcRa7ISj/GoSawpUGS57/fAchzsQ5fj9CV2DNvaGtVqo8p/iw==
X-Received: by 2002:a05:6000:982:b0:229:79e5:6a96 with SMTP id by2-20020a056000098200b0022979e56a96mr12643051wrb.469.1664800247466;
        Mon, 03 Oct 2022 05:30:47 -0700 (PDT)
Received: from localhost.localdomain ([5.29.8.191])
        by smtp.gmail.com with ESMTPSA id b14-20020a05600c4e0e00b003b535ad4a5bsm11845392wmq.9.2022.10.03.05.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 05:30:46 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Christian Brauner <brauner@kernel.org>,
        Yang Xu <xuyang2018.jy@fujitsu.com>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Filipe Manana <fdmanana@kernel.org>,
        linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/2] ovl: remove privs in ovl_copyfile()
Date:   Mon,  3 Oct 2022 15:30:39 +0300
Message-Id: <20221003123040.900827-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221003123040.900827-1-amir73il@gmail.com>
References: <20221003123040.900827-1-amir73il@gmail.com>
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

