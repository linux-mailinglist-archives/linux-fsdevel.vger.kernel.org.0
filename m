Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 504095E5DC9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Sep 2022 10:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbiIVIpZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Sep 2022 04:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbiIVIo7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Sep 2022 04:44:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A982760EE
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Sep 2022 01:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663836295;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RrTKazNRm0paFcNnYRxkeaPVY77eHZ75mhDDJvcKZCg=;
        b=St5JW7L8yC0sCbNHCj1p1Yg5ZfdqvUCIfr0fGQpGuVwYh7t8IScK2VJ6iGzH7NOEUq1LWt
        /Knk5UCE+Kvi+O1cx50ytlcXVJP/IrwsulT9z8MjicoZDQBm1AwjsEamKGQnw+/BG5vFWQ
        7RdGFJyDbe434z2K0vQ+2s16fXaTy7s=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-177-eeNS3tmxPH-Lxk0wG_xGeA-1; Thu, 22 Sep 2022 04:44:54 -0400
X-MC-Unique: eeNS3tmxPH-Lxk0wG_xGeA-1
Received: by mail-ed1-f70.google.com with SMTP id w20-20020a05640234d400b00450f24c8ca6so6144871edc.13
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Sep 2022 01:44:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=RrTKazNRm0paFcNnYRxkeaPVY77eHZ75mhDDJvcKZCg=;
        b=DqbIa1YQXbKMrGqFHXp5kxmDx+aMnW1evwo5aEH9+xeMq8JbUhwPiQDLTS+h/jj+ra
         YRuUhGMM2RIrL80oalaZbvRG7peMnYcTQ2Kg3HgGFELS+I30+DMOEE7hkVNlR+zs4tpz
         nWjTRAaMliAtKdoDS7vC+U7Vr4Ff5870Gmsk3Wv5lpX9/ReoyGde6cznAxUyBje+Iu9w
         Jj+po4ybMHYnx8/N+9xJH+M270OrB4Fw/RbJn7F+mTacO8o+8RWyyu4y2yrtjOmFqgdB
         gdrEWiU890UuBeEPsaSwI04LJ/ii8tbN5qCDLIon8Tg4hSRRxTvHZYsIM7c7Nm8nMybq
         ebAw==
X-Gm-Message-State: ACrzQf09gnrqNrkQfISQcI1z3MIX7kJ9X13xuXdr4TEwJkGtmkq4GR/w
        Un2SHiuyvrMha0t60QlB16Lv4aeOGuOKNsBCkTrzSYVrEez2E3xVP5e881w3RecTNfSCOvq5I2d
        St+SX260aYy2Mmf74LJj+BB0SjSR7zifX/TrEmi/RUrrfg2fGdZVwkWgJnxkoqycrIwEWsmtIhB
        ndBQ==
X-Received: by 2002:a17:906:4fd0:b0:781:bcca:78e6 with SMTP id i16-20020a1709064fd000b00781bcca78e6mr1839871ejw.508.1663836292377;
        Thu, 22 Sep 2022 01:44:52 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4CB1DudmdST2b/PsoDFSnCNK55cPHhtwUFpO1lDweC9SpS4gsR3p6jChXTNytVDBr/Z1ZOsQ==
X-Received: by 2002:a17:906:4fd0:b0:781:bcca:78e6 with SMTP id i16-20020a1709064fd000b00781bcca78e6mr1839850ejw.508.1663836292065;
        Thu, 22 Sep 2022 01:44:52 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (193-226-214-223.pool.digikabel.hu. [193.226.214.223])
        by smtp.gmail.com with ESMTPSA id h15-20020a170906718f00b00730b3bdd8d7sm2297942ejk.179.2022.09.22.01.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 01:44:51 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Al Viro <viro@ZenIV.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Amir Goldstein <amir73il@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Yu-li Lin <yulilin@google.com>,
        Chirantan Ekbote <chirantan@chromium.org>
Subject: [PATCH v4 07/10] vfs: make vfs_tmpfile() static
Date:   Thu, 22 Sep 2022 10:44:39 +0200
Message-Id: <20220922084442.2401223-8-mszeredi@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220922084442.2401223-1-mszeredi@redhat.com>
References: <20220922084442.2401223-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

No callers outside of fs/namei.c anymore.

Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/namei.c         | 3 +--
 include/linux/fs.h | 3 ---
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 81c388a813d3..03ad4e55fb26 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3583,7 +3583,7 @@ static int do_open(struct nameidata *nd,
  * On non-idmapped mounts or if permission checking is to be performed on the
  * raw inode simply passs init_user_ns.
  */
-struct dentry *vfs_tmpfile(struct user_namespace *mnt_userns,
+static struct dentry *vfs_tmpfile(struct user_namespace *mnt_userns,
 			   struct dentry *dentry, umode_t mode, int open_flag)
 {
 	struct dentry *child = NULL;
@@ -3622,7 +3622,6 @@ struct dentry *vfs_tmpfile(struct user_namespace *mnt_userns,
 	dput(child);
 	return ERR_PTR(error);
 }
-EXPORT_SYMBOL(vfs_tmpfile);
 
 /**
  * vfs_tmpfile_open - open a tmpfile for kernel internal use
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 15fafda95dd3..02646542f6bb 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2004,9 +2004,6 @@ static inline int vfs_whiteout(struct user_namespace *mnt_userns,
 			 WHITEOUT_DEV);
 }
 
-struct dentry *vfs_tmpfile(struct user_namespace *mnt_userns,
-			   struct dentry *dentry, umode_t mode, int open_flag);
-
 struct file *vfs_tmpfile_open(struct user_namespace *mnt_userns,
 			const struct path *parentpath,
 			umode_t mode, int open_flag, const struct cred *cred);
-- 
2.37.3

