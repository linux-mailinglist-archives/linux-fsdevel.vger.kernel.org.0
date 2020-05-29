Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E37BB1E8ADE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 May 2020 00:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728451AbgE2WDK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 May 2020 18:03:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24871 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728739AbgE2WDD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 May 2020 18:03:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590789782;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g/aI4LSwmo2x3NIsjNt6okyTDEvgfAxH61DZvBADxec=;
        b=OgVPoba3I7VcgtYFOGtrjHLyudx/OaBMLWfU/C2iRiItjHYUKfdXABZJesEawfRdDp22HR
        /W2tiEP747OuNIbd/OmUODunq+J2I0UYNCJgLKDZI03YvS2tH0f+lokSubSaKG6cvCVANR
        gLdecrLTpyHgW/eCS2QA1dHis7xZxfg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-318-hYDmwy78OhascDW9fQZv0Q-1; Fri, 29 May 2020 18:03:00 -0400
X-MC-Unique: hYDmwy78OhascDW9fQZv0Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 504A580183C;
        Fri, 29 May 2020 22:02:59 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-138.rdu2.redhat.com [10.10.112.138])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8F24775294;
        Fri, 29 May 2020 22:02:58 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 24/27] afs: Fix afs_statfs() to not let the values go below
 zero
From:   David Howells <dhowells@redhat.com>
To:     linux-afs@lists.infradead.org
Cc:     dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 29 May 2020 23:02:57 +0100
Message-ID: <159078977780.679399.6918426082550606601.stgit@warthog.procyon.org.uk>
In-Reply-To: <159078959973.679399.15496997680826127470.stgit@warthog.procyon.org.uk>
References: <159078959973.679399.15496997680826127470.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.22
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix afs_statfs() so that the value for f_bavail and f_bfree don't go
"negative" if the number of blocks in use by a volume exceeds the max quota
for that volume.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/super.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/afs/super.c b/fs/afs/super.c
index c77b11b31233..b552357b1d13 100644
--- a/fs/afs/super.c
+++ b/fs/afs/super.c
@@ -729,7 +729,10 @@ static void afs_get_volume_status_success(struct afs_operation *op)
 		buf->f_blocks = vs->part_max_blocks;
 	else
 		buf->f_blocks = vs->max_quota;
-	buf->f_bavail = buf->f_bfree = buf->f_blocks - vs->blocks_in_use;
+
+	if (buf->f_blocks > vs->blocks_in_use)
+		buf->f_bavail = buf->f_bfree =
+			buf->f_blocks - vs->blocks_in_use;
 }
 
 static const struct afs_operation_ops afs_get_volume_status_operation = {


