Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32CB7220FE7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jul 2020 16:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726782AbgGOOvc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jul 2020 10:51:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42673 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726766AbgGOOvb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jul 2020 10:51:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594824690;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cFqxEO5GCd1e1dZ9OjJhtlzwIsLHCJufCpGCyw2ZCfQ=;
        b=YUEhM2Ed+WCNg2/gpGqE/4HGmNv1rMNfh6157qn1WeJPApuz3FWKDbI8JRpRHF/iv7rmLc
        Zng9mgHsfColh2SR/7kKDXr77yjKQrD3b7WmHBf4zjn1wjVLNjUBneRzl4ykfXilG/Sdbf
        IMMP4KJ6SBaH761aK/cgQtdgJe/iW7g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-202-TmwZIEFRPpGGho2HLUOd2Q-1; Wed, 15 Jul 2020 10:51:26 -0400
X-MC-Unique: TmwZIEFRPpGGho2HLUOd2Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 81A891009616;
        Wed, 15 Jul 2020 14:51:23 +0000 (UTC)
Received: from dcbz.redhat.com (ovpn-114-113.ams2.redhat.com [10.36.114.113])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0C09A60BF1;
        Wed, 15 Jul 2020 14:51:12 +0000 (UTC)
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
Subject: [PATCH v5 2/6] pid: use checkpoint_restore_ns_capable() for set_tid
Date:   Wed, 15 Jul 2020 16:49:50 +0200
Message-Id: <20200715144954.1387760-3-areber@redhat.com>
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
using clone3() with set_tid set.

Signed-off-by: Adrian Reber <areber@redhat.com>
Signed-off-by: Nicolas Viennot <Nicolas.Viennot@twosigma.com>
---
 kernel/pid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/pid.c b/kernel/pid.c
index de9d29c41d77..a9cbab0194d9 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -199,7 +199,7 @@ struct pid *alloc_pid(struct pid_namespace *ns, pid_t *set_tid,
 			if (tid != 1 && !tmp->child_reaper)
 				goto out_free;
 			retval = -EPERM;
-			if (!ns_capable(tmp->user_ns, CAP_SYS_ADMIN))
+			if (!checkpoint_restore_ns_capable(tmp->user_ns))
 				goto out_free;
 			set_tid_size--;
 		}
-- 
2.26.2

