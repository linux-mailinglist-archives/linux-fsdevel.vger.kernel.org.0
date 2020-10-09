Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CCC12890A2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Oct 2020 20:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388179AbgJISQl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Oct 2020 14:16:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31637 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388121AbgJISQl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Oct 2020 14:16:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602267400;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kerhCoVWsEyNRAW3z9PF5+F+5l2ckGp7jqAJsTLRVXQ=;
        b=E0QfsBJLqRSGXNR31BYGh7w3UzvILoOQjH4NvP8BCi2IwZ1kYOeyThofju2EL6qD+nf4gR
        bg6ueQCMvfntFsxCezuUk0J8YeL+DAghFzpac1bHOFvIuEPgLr+yZ5cFybzmVNE20e5gHE
        ooTp3odtsesaeZGi9JV24dMniK5PoxQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-204-XtP8krm9MWuuK0zi5nz1kQ-1; Fri, 09 Oct 2020 14:16:37 -0400
X-MC-Unique: XtP8krm9MWuuK0zi5nz1kQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EC522427CB;
        Fri,  9 Oct 2020 18:16:36 +0000 (UTC)
Received: from horse.redhat.com (ovpn-115-194.rdu2.redhat.com [10.10.115.194])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4D35110023A5;
        Fri,  9 Oct 2020 18:16:33 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id DB2D4223D06; Fri,  9 Oct 2020 14:16:32 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, miklos@szeredi.hu
Cc:     vgoyal@redhat.com, virtio-fs@redhat.com
Subject: [PATCH v3 2/6] fuse: Set FUSE_WRITE_KILL_PRIV in cached write path
Date:   Fri,  9 Oct 2020 14:15:08 -0400
Message-Id: <20201009181512.65496-3-vgoyal@redhat.com>
In-Reply-To: <20201009181512.65496-1-vgoyal@redhat.com>
References: <20201009181512.65496-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

With HANDLE_KILLPRIV_V2, server will need to kill suid/sgid if caller
does not have CAP_FSETID. We already have a flag FUSE_WRITE_KILL_PRIV
in WRITE request and we already set it in direct I/O path.

To make it work in cached write path also, start setting FUSE_WRITE_KILL_PRIV
in this path too.

Set it only if fc->handle_killpriv_v2 is set. Otherwise client is responsible
for kill suid/sgid.

In case of direct I/O we set FUSE_WRITE_KILL_PRIV unconditionally because
we do't call file_remove_privs() in that path (with cache=none option).

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/fuse/file.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 172a0b1aa634..e40428f3d0f1 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1095,6 +1095,8 @@ static ssize_t fuse_send_write_pages(struct fuse_io_args *ia,
 
 	fuse_write_args_fill(ia, ff, pos, count);
 	ia->write.in.flags = fuse_write_flags(iocb);
+	if (fc->handle_killpriv_v2 && !capable(CAP_FSETID))
+		ia->write.in.write_flags |= FUSE_WRITE_KILL_PRIV;
 
 	err = fuse_simple_request(fc, &ap->args);
 	if (!err && ia->write.out.size > count)
-- 
2.25.4

