Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A57F22CDDE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jul 2020 20:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbgGXSid (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jul 2020 14:38:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32807 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726493AbgGXSid (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jul 2020 14:38:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595615911;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VxvG3aIdXnoGOb1aQ6qs6G7M5TgTV1H3UA5uFtnrcig=;
        b=QehrmQuj19EEda1+ATYERtoX6EKZPDlB/z7aG2A5zERwawW9SkutVaXGyk0+It6bprIQrV
        3NMEmYKZ0CfXr5/Og0cauTRPlzGbZOmIYWDQX4zwxeAxnl9v79abvQm+MTQq/TEfjHTPe6
        1DrzyjFrXpH9uelqFh62Vg4rWY/DAMQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-440-O0oOyaC_PZuFd8NRpeTfOA-1; Fri, 24 Jul 2020 14:38:30 -0400
X-MC-Unique: O0oOyaC_PZuFd8NRpeTfOA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1EAE98015CE;
        Fri, 24 Jul 2020 18:38:29 +0000 (UTC)
Received: from horse.redhat.com (ovpn-116-85.rdu2.redhat.com [10.10.116.85])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 99C5972683;
        Fri, 24 Jul 2020 18:38:25 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 3356E223D04; Fri, 24 Jul 2020 14:38:25 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, miklos@szeredi.hu
Cc:     vgoyal@redhat.com, virtio-fs@redhat.com
Subject: [PATCH 2/5] fuse: Set FUSE_WRITE_KILL_PRIV in cached write path
Date:   Fri, 24 Jul 2020 14:38:09 -0400
Message-Id: <20200724183812.19573-3-vgoyal@redhat.com>
In-Reply-To: <20200724183812.19573-1-vgoyal@redhat.com>
References: <20200724183812.19573-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If caller does not have CAP_FSETID, we set FUSE_WRITE_KILL_PRIV in direct
I/O path but not in cached write path. Set it there as well so that server
can clear suid/sgid/caps as needed.

Set it only if fc->handle_killpriv_v2 is set. Otherwise client is responsible
for kill suid/sgid. We do it direct I/O path anyway because we do't call
file_remove_privs() there (with cache=none option).

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/fuse/file.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 83d917f7e542..57899afc7cba 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1083,6 +1083,8 @@ static ssize_t fuse_send_write_pages(struct fuse_io_args *ia,
 
 	fuse_write_args_fill(ia, ff, pos, count);
 	ia->write.in.flags = fuse_write_flags(iocb);
+	if (fc->handle_killpriv_v2 && !capable(CAP_FSETID))
+		ia->write.in.write_flags |= FUSE_WRITE_KILL_PRIV;
 
 	err = fuse_simple_request(fc, &ap->args);
 	if (!err && ia->write.out.size > count)
-- 
2.25.4

