Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEFD87987DF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Sep 2023 15:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243595AbjIHN3Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Sep 2023 09:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243582AbjIHN3O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Sep 2023 09:29:14 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FAB41BC1
        for <linux-fsdevel@vger.kernel.org>; Fri,  8 Sep 2023 06:29:10 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-40061928e5aso23053325e9.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Sep 2023 06:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694179749; x=1694784549; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dzj3w2r2MgqLRuOLU8iEGyQpilmqdS6eXeo3DUZ9DfM=;
        b=B6p4xnq2CYjtAafEhwNEHhVdwQle1djJhFKZ6K850AZDi+Z3azhSQPYAZIAlh4IP5Q
         ke5L9asF7RmNTpLp1n/1XNx+gjWwKKOZXFMjHPqwL+pzjln5qvizOzINGMl+Xt/ZXK9Q
         qjl8wgeq3TK2aj8Z3XNvK/omw0G1c/15f0AHZlyi/BHZC7AyoyHvOhXdixXy3Gu0zLKq
         eLFKj7L+Kb0NoswZUWUpR/z1a9LVrRTfLQ1LXvl7nz4YsOUyojGTVD6LBseVhfVCP+e5
         txwORXiFABYRSxQWkTVThpO1uRgxXoFTvjBe9EXCyl1k45k7VEq4O4obmv5CEYF1LEle
         O3tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694179749; x=1694784549;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dzj3w2r2MgqLRuOLU8iEGyQpilmqdS6eXeo3DUZ9DfM=;
        b=MBlTgo7c6dQCsCTJuE5U2Ql8G/ORmSnpYlB1L3Ij+uIEqgQTaiJkLLygR13GA5gYmO
         4jcvbaNSyIxaKIHvOEw22QkcWv4WRvGP3t4kDqpx00F3nPK4UYS/mNviAa49cLoYZ690
         s0IFPH7wZ7wt3fc8Oq6rgaqft8WMqRMMAqvcmjBnP6Dqk2m16oAd3ODhWXji5jW6YqfC
         jwc5QoDILoBR4H24KhuARtx9OAYtS+DKyGUFvVXhQcjmS29NtZc9k8AAnzxb0vJC66yb
         rVDD+Hv7RfVQbN09nU/xNVE1/I56WxnLQMgkGZSFQurkr+Wh5KSKH21GhqvCY31ju2QN
         78uA==
X-Gm-Message-State: AOJu0YxFvLLwBFJhHjBdfGB/DM2ZtKM+qV8tS7JASFEWNZEwiE2Srrau
        G+yFTdbSbt6cKXRF0OhuT3g=
X-Google-Smtp-Source: AGHT+IFfyvZtob+LI/SvXVI4N7qr8+7FrWP3cMynkESh1e/R5CyLdfTj7PCwUJ5r6YhXyqYKKSKwJA==
X-Received: by 2002:a7b:c042:0:b0:3f8:2777:15e with SMTP id u2-20020a7bc042000000b003f82777015emr2318867wmc.31.1694179748789;
        Fri, 08 Sep 2023 06:29:08 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id 18-20020a05600c249200b003fe1a96845bsm5248747wms.2.2023.09.08.06.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 06:29:08 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/2] fs: export mnt_{get,put}_write_access() to modules
Date:   Fri,  8 Sep 2023 16:29:00 +0300
Message-Id: <20230908132900.2983519-3-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230908132900.2983519-1-amir73il@gmail.com>
References: <20230908132900.2983519-1-amir73il@gmail.com>
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

Overlayfs is going to use those to get write access on the upper mount
during entire copy up without taking freeze protection on upper sb for
the entire copy up.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/namespace.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/namespace.c b/fs/namespace.c
index 3fe7c0484e6a..9e0ea73f2ff9 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -386,6 +386,7 @@ int mnt_get_write_access(struct vfsmount *m)
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(mnt_get_write_access);
 
 /**
  * mnt_want_write - get write access to a mount
@@ -466,6 +467,7 @@ void mnt_put_write_access(struct vfsmount *mnt)
 	mnt_dec_writers(real_mount(mnt));
 	preempt_enable();
 }
+EXPORT_SYMBOL_GPL(mnt_put_write_access);
 
 /**
  * mnt_drop_write - give up write access to a mount
-- 
2.34.1

