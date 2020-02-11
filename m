Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E08CF1595DC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2020 18:02:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728274AbgBKRCX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Feb 2020 12:02:23 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:53662 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727895AbgBKRCX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Feb 2020 12:02:23 -0500
Received: from ip5f5bf7ec.dynamic.kabel-deutschland.de ([95.91.247.236] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1j1Ysi-00014T-SQ; Tue, 11 Feb 2020 16:59:28 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@ubuntu.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Aleksa Sarai <cyphar@cyphar.com>, Jann Horn <jannh@google.com>
Cc:     smbarber@chromium.org, Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Serge Hallyn <serge@hallyn.com>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        containers@lists.linux-foundation.org,
        linux-security-module@vger.kernel.org, linux-api@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 23/24] sys:__sys_setresgid(): handle fsid mappings
Date:   Tue, 11 Feb 2020 17:57:52 +0100
Message-Id: <20200211165753.356508-24-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200211165753.356508-1-christian.brauner@ubuntu.com>
References: <20200211165753.356508-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Switch setresgid() to lookup fsids in the fsid mappings. If no fsid mappings are
setup the behavior is unchanged, i.e. fsids are looked up in the id mappings.

During setresgid() the kfsgid is set to the kegid corresponding the egid that is
requested by userspace. If the requested egid is -1 the kfsgid is reset to the
current kegid. For the latter case this means we need to lookup the
corresponding userspace egid corresponding to the current kegid in the id
mappings and translate this egid into the corresponding kfsgid in the fsid
mappings.

Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 kernel/sys.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/kernel/sys.c b/kernel/sys.c
index 3b98ce84607d..674d0ba4887c 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -750,11 +750,12 @@ long __sys_setresgid(gid_t rgid, gid_t egid, gid_t sgid)
 	const struct cred *old;
 	struct cred *new;
 	int retval;
-	kgid_t krgid, kegid, ksgid;
+	kgid_t krgid, kegid, ksgid, kfsgid;
 
 	krgid = make_kgid(ns, rgid);
 	kegid = make_kgid(ns, egid);
 	ksgid = make_kgid(ns, sgid);
+	kfsgid = make_kfsgid(ns, egid);
 
 	if ((rgid != (gid_t) -1) && !gid_valid(krgid))
 		return -EINVAL;
@@ -762,6 +763,8 @@ long __sys_setresgid(gid_t rgid, gid_t egid, gid_t sgid)
 		return -EINVAL;
 	if ((sgid != (gid_t) -1) && !gid_valid(ksgid))
 		return -EINVAL;
+	if ((egid != (gid_t) -1) && !gid_valid(kfsgid))
+		return -EINVAL;
 
 	new = prepare_creds();
 	if (!new)
@@ -783,11 +786,15 @@ long __sys_setresgid(gid_t rgid, gid_t egid, gid_t sgid)
 
 	if (rgid != (gid_t) -1)
 		new->gid = krgid;
-	if (egid != (gid_t) -1)
+	if (egid != (gid_t) -1) {
 		new->egid = kegid;
+	} else {
+		gid_t fsgid = from_kgid_munged(new->user_ns, new->egid);
+		kfsgid = make_kfsgid(ns, fsgid);
+	}
 	if (sgid != (gid_t) -1)
 		new->sgid = ksgid;
-	new->fsgid = new->egid;
+	new->fsgid = kfsgid;
 
 	return commit_creds(new);
 
-- 
2.25.0

