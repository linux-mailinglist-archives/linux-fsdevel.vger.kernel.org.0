Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D75A226CCE0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Sep 2020 22:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728536AbgIPUui (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Sep 2020 16:50:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37979 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726634AbgIPQzM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Sep 2020 12:55:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600275310;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kerhCoVWsEyNRAW3z9PF5+F+5l2ckGp7jqAJsTLRVXQ=;
        b=Lad5W2GysJwljsT95sBaUmDkVrSlG5vg6GP7JLnLx7HhpNWn9ZsgEKaAQKYHo7n7hjdSLf
        /9TiRh3gdVuVYMp22jivI/D8xTO12YNVoPOWlIbhk9Xd5y0vfTN0nVOcRsO3Y1PUPIsn70
        3E3ZJAe0IaUSI8yK/+vPZOvQf0VzT6I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-452-G8CNpshqOfGTRsCVBgw5jw-1; Wed, 16 Sep 2020 12:17:59 -0400
X-MC-Unique: G8CNpshqOfGTRsCVBgw5jw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9A6BF1891E80;
        Wed, 16 Sep 2020 16:17:58 +0000 (UTC)
Received: from horse.redhat.com (ovpn-116-139.rdu2.redhat.com [10.10.116.139])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0A09976E16;
        Wed, 16 Sep 2020 16:17:55 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 8DBAF223D08; Wed, 16 Sep 2020 12:17:54 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, miklos@szeredi.hu
Cc:     vgoyal@redhat.com, virtio-fs@redhat.com
Subject: [PATCH v2 2/6] fuse: Set FUSE_WRITE_KILL_PRIV in cached write path
Date:   Wed, 16 Sep 2020 12:17:33 -0400
Message-Id: <20200916161737.38028-3-vgoyal@redhat.com>
In-Reply-To: <20200916161737.38028-1-vgoyal@redhat.com>
References: <20200916161737.38028-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-fsdevel-owner@vger.kernel.org
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

