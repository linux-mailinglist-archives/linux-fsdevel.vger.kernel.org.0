Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81D1E225121
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jul 2020 12:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbgGSKGH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Jul 2020 06:06:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37641 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726705AbgGSKGF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Jul 2020 06:06:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595153164;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bWuh2eVsJy0zmmKuqx/toS5Tiv1kLy1bNqveFCfH5Bc=;
        b=d25qZHxbdFo0wHUXA6aawM5H8nsz21uyJh/yBzqGLaZOx2C+6P2Qij0zm7S0eki3WPShLB
        oRFmijbIx0WQHK3QRoRu9HBSqIA6rtr3Dul9nVk1N6OkbBn/CapsJkMDtTkwpDC3091h0K
        w2I5u4Sfe8E2dk2MK5J3C9El2kS5ddQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-27-HFeV2CDOO668pp4rFaUAjw-1; Sun, 19 Jul 2020 06:06:00 -0400
X-MC-Unique: HFeV2CDOO668pp4rFaUAjw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 621AA1085;
        Sun, 19 Jul 2020 10:05:57 +0000 (UTC)
Received: from dcbz.redhat.com (ovpn-112-10.ams2.redhat.com [10.36.112.10])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1C6B8710A8;
        Sun, 19 Jul 2020 10:05:52 +0000 (UTC)
From:   Adrian Reber <areber@redhat.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@gmail.com>,
        Nicolas Viennot <Nicolas.Viennot@twosigma.com>,
        =?UTF-8?q?Micha=C5=82=20C=C5=82api=C5=84ski?= 
        <mclapinski@google.com>, Kamil Yurtsever <kyurtsever@google.com>,
        Dirk Petersen <dipeit@gmail.com>,
        Christine Flood <chf@redhat.com>,
        Casey Schaufler <casey@schaufler-ca.com>
Cc:     Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>,
        Adrian Reber <areber@redhat.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Serge Hallyn <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, selinux@vger.kernel.org,
        Eric Paris <eparis@parisplace.org>,
        Jann Horn <jannh@google.com>, linux-fsdevel@vger.kernel.org
Subject: [PATCH v6 4/7] proc: allow access in init userns for map_files with CAP_CHECKPOINT_RESTORE
Date:   Sun, 19 Jul 2020 12:04:14 +0200
Message-Id: <20200719100418.2112740-5-areber@redhat.com>
In-Reply-To: <20200719100418.2112740-1-areber@redhat.com>
References: <20200719100418.2112740-1-areber@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Opening files in /proc/pid/map_files when the current user is
CAP_CHECKPOINT_RESTORE capable in the root namespace is useful for
checkpointing and restoring to recover files that are unreachable via
the file system such as deleted files, or memfd files.

Signed-off-by: Adrian Reber <areber@redhat.com>
Signed-off-by: Nicolas Viennot <Nicolas.Viennot@twosigma.com>
Reviewed-by: Cyrill Gorcunov <gorcunov@gmail.com>
---
 fs/proc/base.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 65893686d1f1..b824a8c89011 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2194,16 +2194,16 @@ struct map_files_info {
 };
 
 /*
- * Only allow CAP_SYS_ADMIN to follow the links, due to concerns about how the
- * symlinks may be used to bypass permissions on ancestor directories in the
- * path to the file in question.
+ * Only allow CAP_SYS_ADMIN and CAP_CHECKPOINT_RESTORE to follow the links, due
+ * to concerns about how the symlinks may be used to bypass permissions on
+ * ancestor directories in the path to the file in question.
  */
 static const char *
 proc_map_files_get_link(struct dentry *dentry,
 			struct inode *inode,
 		        struct delayed_call *done)
 {
-	if (!capable(CAP_SYS_ADMIN))
+	if (!checkpoint_restore_ns_capable(&init_user_ns))
 		return ERR_PTR(-EPERM);
 
 	return proc_pid_get_link(dentry, inode, done);
-- 
2.26.2

