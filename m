Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91EEE52D65C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 May 2022 16:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232100AbiESOoK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 May 2022 10:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbiESOoI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 May 2022 10:44:08 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 983FDD029D
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 May 2022 07:44:06 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id n13so8529690ejv.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 May 2022 07:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=KFGWAI4EYgMt4FvUzV6Yv53tsjw6MgnmUEHgsfIx7hU=;
        b=l0mPxi/mbdfg5aXkTk+EOrcAhtv+PxDgNyz24uRig87CQ5H3OHjrD6+MPc7p+zILWt
         IKzZtAT6GrQNSgEkYf4ed7v0BGbp19ZZI1UHwvJkMUFGsi3RGgCgQAtNaYFh8mawQsm2
         PGMQTOaxgxKZOCXXJQSFIiSB9qbRqU20cWW08=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=KFGWAI4EYgMt4FvUzV6Yv53tsjw6MgnmUEHgsfIx7hU=;
        b=Z85MPBb/Rd2f5h25qsbt0nhRGGYtYWtwkg8KnOncCynnFu+QSSvT8JYYapZUuIPImi
         F5qzqO2lGnJ0/klcO6h7fHrRfmSYm2fW3DPBB4sSNkYA2F1K/ylyN6hi3GctRZwWP5AC
         3fizdWrFpJ/cSoVaORZ83v8BJVBqiiCmDhYKxQ/Ps7020SCVf3OWsyC6uJwDzDsIUhPd
         8Y6vhXViXdIFaVY+xtzQJrO3ofoNR8tZ2Ov4cjcFo3g/sr8bST9Fbbdz4yaO70YzsKCV
         MCKfNMiC/Pn0KTHjB+rb2CLGz14jjOlPNdiQRL7Wyhe1YQKwMk1VvQcka8j79dArqAOI
         KpOw==
X-Gm-Message-State: AOAM530FGhaP9NTZRe7Bk4n9aoOZWYQ19NQPHez055hByTAmVmnzgyu4
        kh+p4uF4ANpAXyVsB0GMC3NfkA==
X-Google-Smtp-Source: ABdhPJwKPRqtxAzCzNxegCXLkb262FIMasxUf+iWLzGo9zRZ3YHp1nqeTdDXPKTSns/Pqmh/Pzwxuw==
X-Received: by 2002:a17:906:b1ce:b0:6fe:98fb:9521 with SMTP id bv14-20020a170906b1ce00b006fe98fb9521mr3271304ejb.434.1652971445118;
        Thu, 19 May 2022 07:44:05 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-178-48-189-3.catv.fixed.vodafone.hu. [178.48.189.3])
        by smtp.gmail.com with ESMTPSA id c6-20020a056402120600b0042aa6a43ccdsm2929430edw.28.2022.05.19.07.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 07:44:04 -0700 (PDT)
Date:   Thu, 19 May 2022 16:43:58 +0200
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Vivek Goyal <vgoyal@redhat.com>,
        Dharmendra Singh <dharamhans87@gmail.com>,
        Bernd Schubert <bschubert@ddn.com>
Subject: [RFC PATCH] vfs: allow ->atomic_open() on positive
Message-ID: <YoZXro9PoYAPUeh5@miu.piliscsaba.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Al,

Do you see anything bad with allowing ->atomic_open() to take a positive dentry
and possibly invalidate it after it does the atomic LOOKUP/CREATE+OPEN?

It looks wrong not to allow optimizing away the roundtrip associated with
revalidation when we do allow optimizing away the roundtrip for the initial
lookup in the same situation.

Thanks,
Miklos


diff --git a/fs/namei.c b/fs/namei.c
index 509657fdf4f5..d35b5cbf7f64 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3267,7 +3267,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 		dput(dentry);
 		dentry = NULL;
 	}
-	if (dentry->d_inode) {
+	if (dentry->d_inode && !d_atomic_open(dentry)) {
 		/* Cached positive dentry: will open in f_op->open */
 		return dentry;
 	}
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index f5bba51480b2..da681bdbc34e 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -208,6 +208,7 @@ struct dentry_operations {
 #define DCACHE_NOKEY_NAME		0x02000000 /* Encrypted name encoded without key */
 #define DCACHE_OP_REAL			0x04000000
 
+#define DCACHE_ATOMIC_OPEN		0x08000000 /* Always use ->atomic_open() to open this file */
 #define DCACHE_PAR_LOOKUP		0x10000000 /* being looked up (with parent locked shared) */
 #define DCACHE_DENTRY_CURSOR		0x20000000
 #define DCACHE_NORCU			0x40000000 /* No RCU delay for freeing */
@@ -446,6 +447,11 @@ static inline bool d_is_positive(const struct dentry *dentry)
 	return !d_is_negative(dentry);
 }
 
+static inline bool d_atomic_open(const struct dentry *dentry)
+{
+	return dentry->d_flags & DCACHE_ATOMIC_OPEN;
+}
+
 /**
  * d_really_is_negative - Determine if a dentry is really negative (ignoring fallthroughs)
  * @dentry: The dentry in question
