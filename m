Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B025D77FC28
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Aug 2023 18:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352150AbjHQQcC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Aug 2023 12:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353716AbjHQQby (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Aug 2023 12:31:54 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9717B30F6;
        Thu, 17 Aug 2023 09:31:47 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-68871bbfe33so2340281b3a.0;
        Thu, 17 Aug 2023 09:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692289907; x=1692894707;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gTUiG3Uzc8lBmEAdnNxTTIOVJ6aRIqmu+UQYdbs/0nA=;
        b=AQLKDS97LyIhLPj8AD968FZ4So6lIlkG5PJiM8KpcuZOtsBXgm456iJWBEHuxIIWKs
         WJBMLiVzdLJ7PmOPX4dHpxLTpPnT7VNTpM6X/3A3uLZwMKzlecaWhukti2KzonqVayFu
         kQbe2GlzLvr+8DlCV3xzangFUoIxOmWFOVR6SiOQDXaxjunlEYDlShS9MlpkVbc6cziy
         b9XlRsf4CpQ6XkvdY+622Pmvk7TJhDPr94xG9Ju1wcdyljYSogakTF6f/H33BrJnP+xE
         pO8dUG7Y5q9R0NdsRv7uM77OOX7zc33foZmEBngPjQd/+pTrGjZWtCz8Al2+ZDyw96vR
         SDJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692289907; x=1692894707;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gTUiG3Uzc8lBmEAdnNxTTIOVJ6aRIqmu+UQYdbs/0nA=;
        b=D8VywI8khNTfb5t+aGxRAKHtP3AgH6ywyr4H90FKtCWI8RgeKmslaDE4xWb/HsPe5n
         4VoM25zmGtBI42j7+LPn8tk6mgxbzQQgZiJAREfHtuOb+TBzIZJuBq1X33tqTMmbS9v+
         fbmYMdkUreW+GFe/JIDd1ulcOG0fnknmgXKopn3RnkmdxnVFc6lIHp1x8ZFqfLjb6Ud8
         MMwiSMi+N4S2PN9vuoj2vkmo8zs7MyqcrlerlkHCuqV25f4spvWZyAQdRkS60qn/VbmO
         SBPIkWXuKCMoKEnm8IHiRJffAjk0bjIL6HXZ71iEPIFzaXoorBZ5i8ioM8W4NDZ+w3Xp
         0v3g==
X-Gm-Message-State: AOJu0YwOTYxWxguNFamQ6KFzM2f1VrDcn4AcDD2qh+ZxKBQ81upwyHFh
        ZWEIgVf/p8Jsid4S4OmWsGM=
X-Google-Smtp-Source: AGHT+IGfp9I34QqYFtb6+LmvEd6QtCBofUGRvrNZtrU7IumAWH8guLp9JQ6RtHC2It+kh7Zb9gJztA==
X-Received: by 2002:a05:6a00:17a5:b0:682:f529:6d69 with SMTP id s37-20020a056a0017a500b00682f5296d69mr52413pfg.7.1692289906899;
        Thu, 17 Aug 2023 09:31:46 -0700 (PDT)
Received: from fanta-System-Product-Name.. ([222.252.65.171])
        by smtp.gmail.com with ESMTPSA id m7-20020aa79007000000b006887037cde6sm4212392pfo.60.2023.08.17.09.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 09:31:46 -0700 (PDT)
From:   Anh Tuan Phan <tuananhlfc@gmail.com>
To:     viro@zeniv.linux.org.uk, brauner@kernel.org
Cc:     Anh Tuan Phan <tuananhlfc@gmail.com>,
        linux-fsdevel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1] fs/dcache: Replace printk and WARN_ON by WARN
Date:   Thu, 17 Aug 2023 23:31:42 +0700
Message-Id: <20230817163142.117706-1-tuananhlfc@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use WARN instead of printk + WARN_ON as reported from coccinelle:
./fs/dcache.c:1667:1-7: SUGGESTION: printk + WARN_ON can be just WARN

Signed-off-by: Anh Tuan Phan <tuananhlfc@gmail.com>
---
 fs/dcache.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 52e6d5fdab6b..fd5f133b180e 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1664,7 +1664,7 @@ static enum d_walk_ret umount_check(void *_data, struct dentry *dentry)
 	if (dentry == _data && dentry->d_lockref.count == 1)
 		return D_WALK_CONTINUE;
 
-	printk(KERN_ERR "BUG: Dentry %p{i=%lx,n=%pd} "
+	WARN(1, "BUG: Dentry %p{i=%lx,n=%pd} "
 			" still in use (%d) [unmount of %s %s]\n",
 		       dentry,
 		       dentry->d_inode ?
@@ -1673,7 +1673,6 @@ static enum d_walk_ret umount_check(void *_data, struct dentry *dentry)
 		       dentry->d_lockref.count,
 		       dentry->d_sb->s_type->name,
 		       dentry->d_sb->s_id);
-	WARN_ON(1);
 	return D_WALK_CONTINUE;
 }
 
-- 
2.34.1

