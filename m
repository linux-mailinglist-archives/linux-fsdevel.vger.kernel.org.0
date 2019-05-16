Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46A211FD69
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2019 03:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbfEPBq3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 May 2019 21:46:29 -0400
Received: from fieldses.org ([173.255.197.46]:33122 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727019AbfEPBWY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 May 2019 21:22:24 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 8E2F14749; Wed, 15 May 2019 21:20:23 -0400 (EDT)
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     linux-nfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org,
        "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 11/12] nfsd4: show layout stateids
Date:   Wed, 15 May 2019 21:20:18 -0400
Message-Id: <1557969619-17157-14-git-send-email-bfields@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1557969619-17157-1-git-send-email-bfields@redhat.com>
References: <1557969619-17157-1-git-send-email-bfields@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "J. Bruce Fields" <bfields@redhat.com>

These are also minimal for now, I'm not sure what information would be
useful.

Signed-off-by: J. Bruce Fields <bfields@redhat.com>
---
 fs/nfsd/nfs4state.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 652e0544e058..e36c6e64e448 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -2383,6 +2383,24 @@ static int nfs4_show_deleg(struct seq_file *s, struct nfs4_stid *st)
 	return 0;
 }
 
+static int nfs4_show_layout(struct seq_file *s, struct nfs4_stid *st)
+{
+	struct nfs4_layout_stateid *ls;
+	struct file *file;
+
+	ls = container_of(st, struct nfs4_layout_stateid, ls_stid);
+	file = ls->ls_file;
+
+	seq_printf(s, "- 0x%16phN: { type: layout, ", &st->sc_stateid);
+
+	/* XXX: What else would be useful? */
+
+	nfs4_show_superblock(s, file);
+	seq_printf(s, " }\n");
+
+	return 0;
+}
+
 static int states_show(struct seq_file *s, void *v)
 {
 	struct nfs4_stid *st = v;
@@ -2394,6 +2412,8 @@ static int states_show(struct seq_file *s, void *v)
 		return nfs4_show_lock(s, st);
 	case NFS4_DELEG_STID:
 		return nfs4_show_deleg(s, st);
+	case NFS4_LAYOUT_STID:
+		return nfs4_show_layout(s, st);
 	default:
 		return 0; /* XXX: or SEQ_SKIP? */
 	}
-- 
2.21.0

