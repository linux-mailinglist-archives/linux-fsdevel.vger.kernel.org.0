Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70B7766D0E0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jan 2023 22:21:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234266AbjAPVVX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Jan 2023 16:21:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234171AbjAPVVU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Jan 2023 16:21:20 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D337723C42;
        Mon, 16 Jan 2023 13:21:18 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id qx13so12520078ejb.13;
        Mon, 16 Jan 2023 13:21:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CCEk4uyfLQ6ixPIMnmhnLIi8+lwOJlnHpr806bX8wOs=;
        b=dKk3o918oQTVmJd2rJ4ABOiqX1kqDqrlSHZtmQLo6RYGqNuOLgtT5JEMpWL5PN6PJP
         BWhNz+cb5ml7oDjTeksuAsATTZBOFDhw1kOuxYp86+NP0YJfZOXkDyfaJvYezuwiCxP1
         O57S6AgkwHZXQeZAvsZbhRBLJC7Q7Mew1C4Ob/6RPHSWrHme2kGi05F4wnpaus3s4mJk
         303ds1cmYyy7acXtYUoW7UsqzJcw5FRt5bxaGMfRQLjN2hQgHnKcTkZD+mR0Jf1hUogh
         vA5Vranx4BtvnLIyqxlDSc5AmOArrF4kOUliPw7vmghQlnus2HE77ZI7ARub2w4esy32
         n2xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CCEk4uyfLQ6ixPIMnmhnLIi8+lwOJlnHpr806bX8wOs=;
        b=PBX6qb/fxu25JuKMNai0bUHJt9XLd6CqFmbnTlj1ktZYk0NhZG+31+tSsLZYUN7Onv
         Keu1xwhBqjlPajWzusay5yGElpWlOH72uEE30jk84LF58zj0HDcDTULzrnyjRhm6/UFG
         yiXBx0wseKKwX/Ru7eRAMhd0MXhCdQWnJ+nd4j0uEV0Pv/+CU/OntQTv+jAljZjyGkW7
         NZSQUo7bjpQgmSw+wItACF3bOmBYxzR7e6YHUwB5Luwu8oiSwZ7nNSRozJAFjTr2fjVa
         /LIAGuof7tcERDaf2+8GKvFBliWiabVbrnLhpLb2PobiCei6GYIG/2P6I4FbmvqhxnmP
         Ok1g==
X-Gm-Message-State: AFqh2kqCoEQdPLyo9qlury7fm5WwijTHU/r+6tL9bEgMVDEYN2FSc/EX
        l+VL1ovQcVGcq+FshUwpVHo=
X-Google-Smtp-Source: AMrXdXswPLbR6iTVBBUPWgxTXTyg3hXGgZ2EFt/pXXQ0M8ZnXCAkfqpzJpML16C/cHPpv97GZYIRlg==
X-Received: by 2002:a17:906:eb8e:b0:871:6b9d:dbc with SMTP id mh14-20020a170906eb8e00b008716b9d0dbcmr470750ejb.21.1673904077291;
        Mon, 16 Jan 2023 13:21:17 -0800 (PST)
Received: from f.. (cst-prg-72-175.cust.vodafone.cz. [46.135.72.175])
        by smtp.gmail.com with ESMTPSA id q18-20020a17090676d200b00857c2c29553sm7961721ejn.197.2023.01.16.13.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 13:21:16 -0800 (PST)
From:   Mateusz Guzik <mjguzik@gmail.com>
To:     viro@zeniv.linux.org.uk
Cc:     serge@hallyn.com, torvalds@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v2 2/2] vfs: avoid duplicating creds in faccessat if possible
Date:   Mon, 16 Jan 2023 22:21:05 +0100
Message-Id: <20230116212105.1840362-2-mjguzik@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230116212105.1840362-1-mjguzik@gmail.com>
References: <20230116212105.1840362-1-mjguzik@gmail.com>
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

v2:
- fix current->cred usage warn reported by the kernel test robot
Link: https://lore.kernel.org/all/202301150709.9EC6UKBT-lkp@intel.com/
---
 fs/open.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/fs/open.c b/fs/open.c
index 82c1a28b3308..3c068a38044c 100644
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
+	cred = current_cred();
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

