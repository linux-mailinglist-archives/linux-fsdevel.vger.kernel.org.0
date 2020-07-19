Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EAF922511C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jul 2020 12:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbgGSKGA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Jul 2020 06:06:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53259 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726608AbgGSKF7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Jul 2020 06:05:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595153158;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QpLyxw8wQAuIcbhaRs4wVIjovAuQu5U0BsAVT1HBuI4=;
        b=N9iMdkxGnsAJwflzK0xRZ4j9Ydg0qTRdZFNR5klJyCaqs35Lu0RNhwKuoCp4+TafiZRYVC
        SKSoOnTJoThWk3sBnrIvJP+HYqnWNK48luBxfKAu9t8mUFyuTsiwx972WIefDWtOG7a4Li
        Jaw9SES8jO/i7HQv/7gIJAO7vu95IjY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-194-635876xIOHG7FbqLCuCeYQ-1; Sun, 19 Jul 2020 06:05:54 -0400
X-MC-Unique: 635876xIOHG7FbqLCuCeYQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1CE54107ACCA;
        Sun, 19 Jul 2020 10:05:52 +0000 (UTC)
Received: from dcbz.redhat.com (ovpn-112-10.ams2.redhat.com [10.36.112.10])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D059573044;
        Sun, 19 Jul 2020 10:05:47 +0000 (UTC)
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
Subject: [PATCH v6 3/7] pid_namespace: use checkpoint_restore_ns_capable() for ns_last_pid
Date:   Sun, 19 Jul 2020 12:04:13 +0200
Message-Id: <20200719100418.2112740-4-areber@redhat.com>
In-Reply-To: <20200719100418.2112740-1-areber@redhat.com>
References: <20200719100418.2112740-1-areber@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use the newly introduced capability CAP_CHECKPOINT_RESTORE to allow
writing to ns_last_pid.

Signed-off-by: Adrian Reber <areber@redhat.com>
Signed-off-by: Nicolas Viennot <Nicolas.Viennot@twosigma.com>
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
Reviewed-by: Serge Hallyn <serge@hallyn.com>
---
 kernel/pid_namespace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
index 0e5ac162c3a8..ac135bd600eb 100644
--- a/kernel/pid_namespace.c
+++ b/kernel/pid_namespace.c
@@ -269,7 +269,7 @@ static int pid_ns_ctl_handler(struct ctl_table *table, int write,
 	struct ctl_table tmp = *table;
 	int ret, next;
 
-	if (write && !ns_capable(pid_ns->user_ns, CAP_SYS_ADMIN))
+	if (write && !checkpoint_restore_ns_capable(pid_ns->user_ns))
 		return -EPERM;
 
 	/*
-- 
2.26.2

