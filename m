Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F4E33DEB6B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Aug 2021 13:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235533AbhHCLAK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Aug 2021 07:00:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44271 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235506AbhHCLAH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Aug 2021 07:00:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627988396;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aE8XCCL55f8qnxJqwivFKeV5VGgs9Ifqgx6vr3CKXek=;
        b=MqgTzy2emac9u626iteQsPyGmk0BFE5Q7SdMlNRKh1k2KHkauBwgTpkOuIbtCuBMK1FNa9
        WvfHdGPqxOGru6vQ2O4BTyVgulwBqoPW8sTV2n7/QCjEyof26VDLeHcNvq14w8uHgvhwV+
        4mQFAfRdQh5Hf4Qp2DjHolTkNrb/B84=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-60-m4sIGmG_O_enoSoAqyzJYA-1; Tue, 03 Aug 2021 06:59:54 -0400
X-MC-Unique: m4sIGmG_O_enoSoAqyzJYA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ECA31190B2A0;
        Tue,  3 Aug 2021 10:59:52 +0000 (UTC)
Received: from thuth.com (unknown [10.39.192.110])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D0C5660C5F;
        Tue,  3 Aug 2021 10:59:49 +0000 (UTC)
From:   Thomas Huth <thuth@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-nfs@vger.kernel.org
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>, linux-s390@vger.kernel.org,
        Jia He <hejianet@gmail.com>,
        Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Subject: [PATCH 2/2] lockd: change the proc_handler for nsm_use_hostnames
Date:   Tue,  3 Aug 2021 12:59:37 +0200
Message-Id: <20210803105937.52052-3-thuth@redhat.com>
In-Reply-To: <20210803105937.52052-1-thuth@redhat.com>
References: <20210803105937.52052-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Jia He <hejianet@gmail.com>

nsm_use_hostnames is a module parameter and it will be exported to sysctl
procfs. This is to let user sometimes change it from userspace. But the
minimal unit for sysctl procfs read/write it sizeof(int).
In big endian system, the converting from/to  bool to/from int will cause
error for proc items.

This patch use a new proc_handler proc_dobool to fix it.

Signed-off-by: Jia He <hejianet@gmail.com>
Reviewed-by: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
[thuth: Fix typo in commit message]
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 fs/lockd/svc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/lockd/svc.c b/fs/lockd/svc.c
index 2de048f80eb8..0ab9756ed235 100644
--- a/fs/lockd/svc.c
+++ b/fs/lockd/svc.c
@@ -584,7 +584,7 @@ static struct ctl_table nlm_sysctls[] = {
 		.data		= &nsm_use_hostnames,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler	= proc_dobool,
 	},
 	{
 		.procname	= "nsm_local_state",
-- 
2.27.0

