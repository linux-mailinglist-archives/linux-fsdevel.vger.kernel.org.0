Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDB54220FEF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jul 2020 16:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbgGOOxD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jul 2020 10:53:03 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:44579 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726851AbgGOOxC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jul 2020 10:53:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594824781;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=92lte8n3yu9W0SorD40v1+TSi2IDS2o0VxXIGO6eK0g=;
        b=Bob3yeI4mz3GOodf1yF7IubjILiHG6BJ8qAH9d/DiB8JAaOlMtOAeNzCP8BQa81TPqAuzE
        xnrWN7YSJiN+QsmeZY0YwU1WhhcAFP5eAbt3JLnzbON3k0CCc9S6Sfo5VewaCZLM7kAJfq
        N+qIGvKTAcld+LF0z3eRiIoMKf1d5eU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-11-PvOYl-MuNP6OOxhtc3SWSw-1; Wed, 15 Jul 2020 10:51:54 -0400
X-MC-Unique: PvOYl-MuNP6OOxhtc3SWSw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 69FB118A1DE8;
        Wed, 15 Jul 2020 14:51:51 +0000 (UTC)
Received: from dcbz.redhat.com (ovpn-114-113.ams2.redhat.com [10.36.114.113])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 256A160BF1;
        Wed, 15 Jul 2020 14:51:47 +0000 (UTC)
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
Subject: [PATCH v5 5/6] prctl: Allow checkpoint/restore capable processes to change exe link
Date:   Wed, 15 Jul 2020 16:49:53 +0200
Message-Id: <20200715144954.1387760-6-areber@redhat.com>
In-Reply-To: <20200715144954.1387760-1-areber@redhat.com>
References: <20200715144954.1387760-1-areber@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Nicolas Viennot <Nicolas.Viennot@twosigma.com>

Allow CAP_CHECKPOINT_RESTORE capable users to change /proc/self/exe.

This commit also changes the permission error code from -EINVAL to
-EPERM for consistency with the rest of the prctl() syscall when
checking capabilities.

Signed-off-by: Nicolas Viennot <Nicolas.Viennot@twosigma.com>
Signed-off-by: Adrian Reber <areber@redhat.com>
---
 kernel/sys.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/kernel/sys.c b/kernel/sys.c
index 00a96746e28a..dd59b9142b1d 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2007,12 +2007,14 @@ static int prctl_set_mm_map(int opt, const void __user *addr, unsigned long data
 
 	if (prctl_map.exe_fd != (u32)-1) {
 		/*
-		 * Make sure the caller has the rights to
-		 * change /proc/pid/exe link: only local sys admin should
-		 * be allowed to.
+		 * Check if the current user is checkpoint/restore capable.
+		 * At the time of this writing, it checks for CAP_SYS_ADMIN
+		 * or CAP_CHECKPOINT_RESTORE.
+		 * Note that a user with access to ptrace can masquerade an
+		 * arbitrary program as any executable, even setuid ones.
 		 */
-		if (!ns_capable(current_user_ns(), CAP_SYS_ADMIN))
-			return -EINVAL;
+		if (!checkpoint_restore_ns_capable(current_user_ns()))
+			return -EPERM;
 
 		error = prctl_set_mm_exe_file(mm, prctl_map.exe_fd);
 		if (error)
-- 
2.26.2

