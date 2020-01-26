Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72E3814985B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Jan 2020 02:03:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729045AbgAZBDC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 25 Jan 2020 20:03:02 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41996 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728925AbgAZBDC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 25 Jan 2020 20:03:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580000580;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=C4UL/sgONviDDd6p9omNf+B6AIXhtVKxNHoU71HLvJU=;
        b=R0FVevCLMrQi7L4PRiolQoWouiDmv49tKs6xjHy8XFZLywIRwfQKVef//UA8o7T9rENqhj
        HryVPxioupu5Zy2lfXKsOM/ExoRg0jppL9t0CqMioGtixEqq7ov6HRG+ZDDaLZ4oRzMYOJ
        3CwnQJrflTscXAUXCZSxxVk7wRdLwkQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-193-tWSNo41eO2W7Co1G0ej1EQ-1; Sat, 25 Jan 2020 20:02:56 -0500
X-MC-Unique: tWSNo41eO2W7Co1G0ej1EQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4A32613E1;
        Sun, 26 Jan 2020 01:02:55 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-99.rdu2.redhat.com [10.10.120.99])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4AE1D60BEC;
        Sun, 26 Jan 2020 01:02:54 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH] afs: Fix characters allowed into cell names
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sun, 26 Jan 2020 01:02:53 +0000
Message-ID: <158000057348.1293463.7255193286211009648.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The afs filesystem needs to prohibit certain characters from cell names,
such as '/', as these are used to form filenames in procfs, leading to the
following warning being generated:

	WARNING: CPU: 0 PID: 3489 at fs/proc/generic.c:178

Fix afs_alloc_cell() to disallow nonprintable characters, '/', '@' and
names that begin with a dot.

Remove the check for "@cell" as that is then redundant.

This can be tested by running:

	echo add foo/.bar 1.2.3.4 >/proc/fs/afs/cells

Note that we will also need to deal with:

 - Names ending in ".invalid" shouldn't be passed to the DNS.

 - Names that contain non-valid domainname chars shouldn't be passed to the
   DNS.

 - DNS replies that say "your-dns-needs-immediate-attention.<gTLD>" and
   replies containing A records that say 127.0.53.53 should be considered
   invalid.
   [https://www.icann.org/en/system/files/files/name-collision-mitigation-01aug14-en.pdf]

but these need to be dealt with by the kafs-client DNS program rather than
the kernel.

Fixes: ^1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: syzbot+b904ba7c947a37b4b291@syzkaller.appspotmail.com
Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/cell.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/afs/cell.c b/fs/afs/cell.c
index 1310893c1634..40491edefd69 100644
--- a/fs/afs/cell.c
+++ b/fs/afs/cell.c
@@ -134,8 +134,17 @@ static struct afs_cell *afs_alloc_cell(struct afs_net *net,
 		_leave(" = -ENAMETOOLONG");
 		return ERR_PTR(-ENAMETOOLONG);
 	}
-	if (namelen == 5 && memcmp(name, "@cell", 5) == 0)
+
+	/* Prohibit cell names that contain unprintable chars, '/' and '@' or
+	 * that begin with a dot.  This also precludes "@cell".
+	 */
+	if (name[0] == '.')
 		return ERR_PTR(-EINVAL);
+	for (i = 0; i < namelen; i++) {
+		char ch = name[i];
+		if (!isprint(ch) || ch == '/' || ch == '@')
+			return ERR_PTR(-EINVAL);
+	}
 
 	_enter("%*.*s,%s", namelen, namelen, name, addresses);
 


