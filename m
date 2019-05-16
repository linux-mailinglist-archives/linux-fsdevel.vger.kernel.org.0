Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5B91FD56
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2019 03:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbfEPBq1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 May 2019 21:46:27 -0400
Received: from fieldses.org ([173.255.197.46]:33120 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727018AbfEPBWY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 May 2019 21:22:24 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 89CBB50A2; Wed, 15 May 2019 21:20:23 -0400 (EDT)
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     linux-nfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org,
        "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 10/12] nfsd: show lock and deleg stateids
Date:   Wed, 15 May 2019 21:20:17 -0400
Message-Id: <1557969619-17157-13-git-send-email-bfields@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1557969619-17157-1-git-send-email-bfields@redhat.com>
References: <1557969619-17157-1-git-send-email-bfields@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "J. Bruce Fields" <bfields@redhat.com>

These entries are pretty minimal for now.

Signed-off-by: J. Bruce Fields <bfields@redhat.com>
---
 fs/nfsd/nfs4state.c | 59 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 4025b3c692fd..652e0544e058 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -2323,12 +2323,66 @@ static int nfs4_show_open(struct seq_file *s, struct nfs4_stid *st)
 	seq_printf(s, ", ");
 	nfs4_show_owner(s, oo);
 	seq_printf(s, " }\n");
+	fput(file);
+
+	return 0;
+}
+
+static int nfs4_show_lock(struct seq_file *s, struct nfs4_stid *st)
+{
+	struct nfs4_ol_stateid *ols;
+	struct nfs4_file *nf;
+	struct file *file;
+	struct nfs4_stateowner *oo;
 
+	ols = openlockstateid(st);
+	oo = ols->st_stateowner;
+	nf = st->sc_file;
+	file = find_any_file(nf);
+
+	seq_printf(s, "- 0x%16phN: { type: lock, ", &st->sc_stateid);
+
+	/*
+	 * Note: a lock stateid isn't really the same thing as a lock,
+	 * it's the locking state held by one owner on a file, and there
+	 * may be multiple (or no) lock ranges associated with it.
+	 * (Same for the matter is true of open stateids.)
+	 */
+
+	nfs4_show_superblock(s, file);
+	/* XXX: open stateid? */
+	seq_printf(s, ", ");
+	nfs4_show_owner(s, oo);
+	seq_printf(s, " }\n");
 	fput(file);
 
 	return 0;
 }
 
+static int nfs4_show_deleg(struct seq_file *s, struct nfs4_stid *st)
+{
+	struct nfs4_delegation *ds;
+	struct nfs4_file *nf;
+	struct file *file;
+
+	ds = delegstateid(st);
+	nf = st->sc_file;
+	file = nf->fi_deleg_file;
+
+	seq_printf(s, "- 0x%16phN: { type: deleg, ", &st->sc_stateid);
+
+	/* Kinda dead code as long as we only support read delegs: */
+	seq_printf(s, "access: %s, ",
+		ds->dl_type == NFS4_OPEN_DELEGATE_READ ? "r" : "w");
+
+	/* XXX: lease time, whether it's being recalled. */
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
@@ -2336,9 +2390,14 @@ static int states_show(struct seq_file *s, void *v)
 	switch (st->sc_type) {
 	case NFS4_OPEN_STID:
 		return nfs4_show_open(s, st);
+	case NFS4_LOCK_STID:
+		return nfs4_show_lock(s, st);
+	case NFS4_DELEG_STID:
+		return nfs4_show_deleg(s, st);
 	default:
 		return 0; /* XXX: or SEQ_SKIP? */
 	}
+	/* XXX: copy stateids? */
 }
 
 static struct seq_operations states_seq_ops = {
-- 
2.21.0

