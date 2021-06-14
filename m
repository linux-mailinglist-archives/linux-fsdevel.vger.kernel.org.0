Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B77A3A6D69
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jun 2021 19:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233072AbhFNRrZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Jun 2021 13:47:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49037 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233763AbhFNRrX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Jun 2021 13:47:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623692720;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6H4VN0TQLGM3nnVWpoc1Pex4P44R3EjC+GamNulSNTA=;
        b=dhgzdDGFhKzGwSPw7E9P/RcyqidCdzsm398ZkF8wvel3vFwGd4CWYj+u7L6rQYeIe+qOQL
        HHOWBGORxGdId8DEPHU2/h5SVs4ecqu1tLB1ztqxt2r7jVQor0oD6wYD6KbpqdVe5SgXHI
        RLP7wsCVoRJ0ovEsUrl4P0WPKKU3Kvc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-99-fPxLTNScPqebiCAFCZVQ7g-1; Mon, 14 Jun 2021 13:45:19 -0400
X-MC-Unique: fPxLTNScPqebiCAFCZVQ7g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 69D119F936;
        Mon, 14 Jun 2021 17:45:17 +0000 (UTC)
Received: from horse.redhat.com (ovpn-114-174.rdu2.redhat.com [10.10.114.174])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D482160657;
        Mon, 14 Jun 2021 17:45:06 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 62478225FCE; Mon, 14 Jun 2021 13:45:06 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtio-fs@redhat.com
Cc:     vgoyal@redhat.com, miklos@szeredi.hu, stefanha@redhat.com,
        dgilbert@redhat.com, viro@zeniv.linux.org.uk, dhowells@redhat.com,
        richard.weinberger@gmail.com, hch@infradead.org,
        asmadeus@codewreck.org, v9fs-developer@lists.sourceforge.net
Subject: [PATCH v2 2/2] init/do_mounts.c: Add 9pfs to the list of tag based filesystems
Date:   Mon, 14 Jun 2021 13:44:54 -0400
Message-Id: <20210614174454.903555-3-vgoyal@redhat.com>
In-Reply-To: <20210614174454.903555-1-vgoyal@redhat.com>
References: <20210614174454.903555-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add 9p to the list of tag based filesystems. I tested basic testing
with kernel command line "root=hostShared rootfstype=9p rw" and it
works for me.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 init/do_mounts.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/init/do_mounts.c b/init/do_mounts.c
index 2a18238f4962..7c86bfdab15b 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -35,6 +35,9 @@ static char *__initdata tag_based_rootfs[] = {
 #if IS_BUILTIN(CONFIG_VIRTIO_FS)
 	"virtiofs",
 #endif
+#if IS_BUILTIN(CONFIG_9P_FS)
+	"9p",
+#endif
 };
 static bool __initdata tag_based_root;
 static int root_wait;
-- 
2.25.4

