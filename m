Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19383220FE9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jul 2020 16:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbgGOOvj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jul 2020 10:51:39 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:27275 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726809AbgGOOvh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jul 2020 10:51:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594824696;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e+GUMkIqOM1756261b5DcpT99uKH+47iX9jCYAeaOt4=;
        b=fKyZ0cWReMV5tbZ3KYqO1+IxMKRLDNyAswjxwr3mBan89u5ma5r1lFY90uAHtnhdib1TUD
        oraleeEscUraRKtwvsP/5TDEqjVDEynEONjr1MITHoCHwBZ1EcmD4RVHVePaRl3wiBhAQ3
        4qmO3WoaCkvrE6MzGHpPBuwGTKH2DzA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-267-1qTtWfGdMCGV4yDZuWsOng-1; Wed, 15 Jul 2020 10:51:34 -0400
X-MC-Unique: 1qTtWfGdMCGV4yDZuWsOng-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C8B5E100AA23;
        Wed, 15 Jul 2020 14:51:31 +0000 (UTC)
Received: from dcbz.redhat.com (ovpn-114-113.ams2.redhat.com [10.36.114.113])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E795660BF4;
        Wed, 15 Jul 2020 14:51:24 +0000 (UTC)
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
Subject: [PATCH v5 3/6] pid_namespace: use checkpoint_restore_ns_capable() for ns_last_pid
Date:   Wed, 15 Jul 2020 16:49:51 +0200
Message-Id: <20200715144954.1387760-4-areber@redhat.com>
In-Reply-To: <20200715144954.1387760-1-areber@redhat.com>
References: <20200715144954.1387760-1-areber@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use the newly introduced capability CAP_CHECKPOINT_RESTORE to allow
writing to ns_last_pid.

Signed-off-by: Adrian Reber <areber@redhat.com>
Signed-off-by: Nicolas Viennot <Nicolas.Viennot@twosigma.com>
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

