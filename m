Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE1481158A9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2019 22:35:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbfLFVe7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Dec 2019 16:34:59 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37488 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726375AbfLFVe7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Dec 2019 16:34:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575668097;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=QqbyZYGZnYQCIEjuJv4K9a69RNYGOwglIe0OXAFPCN8=;
        b=ISeeQhl8lxakJPPyDOyg05PkH6kvnFlGgTU/eWR+mg/1VUt7LNaT+kt/orHhjcKBg00jeA
        lxaAtNTTIIV8qk/fhppL13JOU4pU2szLaGSyisL6rs46j3Szn1mEXFrcajy3cgdn37EmTl
        EJsbNLAiPeTgnfSM3hSm62kgqTDdk9c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-330-t5RaSMnLND-Ukq0Qcfnapw-1; Fri, 06 Dec 2019 16:34:54 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1840C183B701;
        Fri,  6 Dec 2019 21:34:53 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-250.rdu2.redhat.com [10.10.120.250])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0645360BF4;
        Fri,  6 Dec 2019 21:34:51 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH] pipe: Fix iteration end check in fuse_dev_splice_write()
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
Cc:     miklos@szeredi.hu, dhowells@redhat.com, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 06 Dec 2019 21:34:51 +0000
Message-ID: <157566809107.17007.16619855857308884231.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: t5RaSMnLND-Ukq0Qcfnapw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix the iteration end check in fuse_dev_splice_write().  The iterator
position can only be compared with == or != since wrappage may be involved.

Fixes: 8cefc107ca54 ("pipe: Use head and tail pointers for the ring, not cursor and length")
Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/fuse/dev.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index d4e6691d2d92..8e02d76fe104 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1965,7 +1965,7 @@ static ssize_t fuse_dev_splice_write(struct pipe_inode_info *pipe,
 
 	nbuf = 0;
 	rem = 0;
-	for (idx = tail; idx < head && rem < len; idx++)
+	for (idx = tail; idx != head && rem < len; idx++)
 		rem += pipe->bufs[idx & mask].len;
 
 	ret = -EINVAL;

