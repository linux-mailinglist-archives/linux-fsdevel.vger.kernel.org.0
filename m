Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 344321F4067
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jun 2020 18:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731125AbgFIQNV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Jun 2020 12:13:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48758 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731112AbgFIQNU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Jun 2020 12:13:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591719199;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yeGZmO/JYZG5FQp5dwk/kPkEYWtQgdOsYGZyA4HB6Bo=;
        b=Y6AEg51SxI7g8MPXro2GxLwL/cWDC2kNLPlvvq58xv+ZHHwbcKmXSj9iGBtDPqjb9yngQ9
        tcOHqDhDK9tQm+dYrBeGcCvNbJHbFmulsgFw1gYwvLQwNWL6T3tg0xhBywUaajqCC0RcIU
        TTZ4XjiWTjPUg8asSpZMLFoVCMvhWiw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-459-wP6gp0uBPvuudx7tztxueg-1; Tue, 09 Jun 2020 12:13:15 -0400
X-MC-Unique: wP6gp0uBPvuudx7tztxueg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6C3DA9117F;
        Tue,  9 Jun 2020 16:13:14 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-114-66.rdu2.redhat.com [10.10.114.66])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6DCA07A1EB;
        Tue,  9 Jun 2020 16:13:13 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 1/6] afs: Fix memory leak in afs_put_sysnames()
From:   David Howells <dhowells@redhat.com>
To:     linux-afs@lists.infradead.org
Cc:     Zhihao Cheng <chengzhihao1@huawei.com>, dhowells@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 09 Jun 2020 17:13:12 +0100
Message-ID: <159171919260.3038039.5675242420072463110.stgit@warthog.procyon.org.uk>
In-Reply-To: <159171918506.3038039.10915051218779105094.stgit@warthog.procyon.org.uk>
References: <159171918506.3038039.10915051218779105094.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.22
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Zhihao Cheng <chengzhihao1@huawei.com>

Fix afs_put_sysnames() to actually free the specified afs_sysnames
object after its reference count has been decreased to zero and
its contents have been released.

Fixes: 6f8880d8e681557 ("afs: Implement @sys substitution handling")
Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/proc.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/afs/proc.c b/fs/afs/proc.c
index 22d00cf1913d..e817fc740ba0 100644
--- a/fs/afs/proc.c
+++ b/fs/afs/proc.c
@@ -567,6 +567,7 @@ void afs_put_sysnames(struct afs_sysnames *sysnames)
 			if (sysnames->subs[i] != afs_init_sysname &&
 			    sysnames->subs[i] != sysnames->blank)
 				kfree(sysnames->subs[i]);
+		kfree(sysnames);
 	}
 }
 


