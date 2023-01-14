Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF8C66AD33
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Jan 2023 19:02:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbjANSCu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 14 Jan 2023 13:02:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbjANSCs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 14 Jan 2023 13:02:48 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB4CBBAC;
        Sat, 14 Jan 2023 10:02:46 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id u19so59137626ejm.8;
        Sat, 14 Jan 2023 10:02:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DiozvCaMITGYcphAARs79W4NXPgo9KLi6rj9QC8zgn0=;
        b=MQ0GgH52Jyj5zgcCIKehozrBZUZmbh25poVp6JSmLbjNCBXko2KXRfE2tBAbzXvBHm
         ZLRh924mbrfN5cOPknP1rGaVdJe8hVMchF6KKzbQ8rqNlZ5osuFg+xyUgZ8yp3DSEeho
         Hmvq7UftpHgmXri1QZ14UEjZwaU+US+YtQAxytMSuJHwgKj9kz8OWG+Vr6dvXEpAJOGh
         hc5ulqUcWgHfNzlTG+YDIysgFZvgAZCRrUPKdXdLzq7gTAlmr3yApDj3uS99J5p0RC7g
         E1yIXrPgn3mBLd6QopWJFUyq5wGJ/0ZGUmQg06PLt82JTPeHubfvMH1H5/Kh9jL8CsMv
         PZOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DiozvCaMITGYcphAARs79W4NXPgo9KLi6rj9QC8zgn0=;
        b=gCzsj9nOAdSOp3bUJLKpH3kcgA9ceb0RsGHQ3nH8JOCD8kVqPyrA/Vmd5Zz6/12Wlx
         gXqFNJjMj0tP5dLgroS6erGXsndNA2++JZPaS4/9cG2kJe5yoCeO42nJTM3ebhsTCyYq
         LWQXEKwgWlAKuh1nAJ37Esww5V3C7jVI63IxFCCVOJ1rqsxyzjp96zdp2+Hnsby0Acru
         6itGklF0XbBjrlSDwyJurzxPHIEDkRkkxDDYtwPpO/OjeClBJQbjXqc0c/1gMaSUtiBJ
         3iW5dUHV3/7JMKXlr44QhnPpgKbRzb89PFWIRIpJOfUv6lL+XloL/nasQK3AVlcnCMTq
         1pAg==
X-Gm-Message-State: AFqh2kr2pEU2To/wxe8F7aDoFUhyMUIZpP2MiqqboxvGIfBlRokbNUZW
        QJoGgWHQrbyRWf1q/pzxjwDTKJFSwcU8cg==
X-Google-Smtp-Source: AMrXdXvxblpBKmoNatgiUxhFRIC67gOWDs1S1NoDlVjEM36jINCaabw638IbXCrDRlwdQPn5E7yZ6A==
X-Received: by 2002:a17:907:6e16:b0:7c1:b64:e290 with SMTP id sd22-20020a1709076e1600b007c10b64e290mr126029725ejc.45.1673719365211;
        Sat, 14 Jan 2023 10:02:45 -0800 (PST)
Received: from f.. (cst-prg-72-175.cust.vodafone.cz. [46.135.72.175])
        by smtp.gmail.com with ESMTPSA id eg49-20020a05640228b100b00488117821ffsm9623220edb.31.2023.01.14.10.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Jan 2023 10:02:44 -0800 (PST)
From:   Mateusz Guzik <mjguzik@gmail.com>
To:     viro@zeniv.linux.org.uk
Cc:     serge@hallyn.com, torvalds@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH 2/2] vfs: avoid duplicating creds in faccessat if possible
Date:   Sat, 14 Jan 2023 19:02:24 +0100
Message-Id: <20230114180224.1777699-2-mjguzik@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230114180224.1777699-1-mjguzik@gmail.com>
References: <20230114180224.1777699-1-mjguzik@gmail.com>
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

access(2) remains commonly used, for example on exec:
access("/etc/ld.so.preload", R_OK)

or when running gcc: strace -c gcc empty.c
% time     seconds  usecs/call     calls    errors syscall
------ ----------- ----------- --------- --------- ----------------
  0.00    0.000000           0        42        26 access

It falls down to do_faccessat without the AT_EACCESS flag, which in turn
results in allocation of new creds in order to modify fsuid/fsgid and
caps. This is a very expensive process single-threaded and most notably
multi-threaded, with numerous structures getting refed and unrefed on
imminent new cred destruction.

Turns out for typical consumers the resulting creds would be identical
and this can be checked upfront, avoiding the hard work.

An access benchmark plugged into will-it-scale running on Cascade Lake
shows:
test	proc	before	after
access1	1	1310582	2908735	 (+121%)  # distinct files
access1	24	4716491	63822173 (+1353%) # distinct files
access2	24	2378041	5370335	 (+125%)  # same file

The above benchmarks are not integrated into will-it-scale, but can be
found in a pull request:
https://github.com/antonblanchard/will-it-scale/pull/36/files

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/open.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/fs/open.c b/fs/open.c
index 82c1a28b3308..c5bfc4e3df94 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -367,7 +367,37 @@ COMPAT_SYSCALL_DEFINE6(fallocate, int, fd, int, mode, compat_arg_u64_dual(offset
  * access() needs to use the real uid/gid, not the effective uid/gid.
  * We do this by temporarily clearing all FS-related capabilities and
  * switching the fsuid/fsgid around to the real ones.
+ *
+ * Creating new credentials is expensive, so we try to skip doing it,
+ * which we can if the result would match what we already got.
  */
+static bool access_need_override_creds(int flags)
+{
+	const struct cred *cred;
+
+	if (flags & AT_EACCESS)
+		return false;
+
+	cred = current->cred;
+	if (!uid_eq(cred->fsuid, cred->uid) ||
+	    !gid_eq(cred->fsgid, cred->gid))
+		return true;
+
+	if (!issecure(SECURE_NO_SETUID_FIXUP)) {
+		kuid_t root_uid = make_kuid(cred->user_ns, 0);
+		if (!uid_eq(cred->uid, root_uid)) {
+			if (!cap_isclear(cred->cap_effective))
+				return true;
+		} else {
+			if (!cap_isidentical(cred->cap_effective,
+			    cred->cap_permitted))
+				return true;
+		}
+	}
+
+	return false;
+}
+
 static const struct cred *access_override_creds(void)
 {
 	const struct cred *old_cred;
@@ -436,7 +466,7 @@ static long do_faccessat(int dfd, const char __user *filename, int mode, int fla
 	if (flags & AT_EMPTY_PATH)
 		lookup_flags |= LOOKUP_EMPTY;
 
-	if (!(flags & AT_EACCESS)) {
+	if (access_need_override_creds(flags)) {
 		old_cred = access_override_creds();
 		if (!old_cred)
 			return -ENOMEM;
-- 
2.34.1

