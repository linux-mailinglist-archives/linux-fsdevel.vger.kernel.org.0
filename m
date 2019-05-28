Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC8FE2CA13
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2019 17:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbfE1POW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 May 2019 11:14:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60450 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726969AbfE1POV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 May 2019 11:14:21 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2A55BC01F278;
        Tue, 28 May 2019 15:14:21 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-125-65.rdu2.redhat.com [10.10.125.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C6B4DD468D;
        Tue, 28 May 2019 15:14:19 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 23/25] fsinfo: bpf - add sb operation fsinfo() [ver #13]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, raven@themaw.net, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mszeredi@redhat.com
Date:   Tue, 28 May 2019 16:14:19 +0100
Message-ID: <155905645905.1662.13856174905974520945.stgit@warthog.procyon.org.uk>
In-Reply-To: <155905626142.1662.18430571708534506785.stgit@warthog.procyon.org.uk>
References: <155905626142.1662.18430571708534506785.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Tue, 28 May 2019 15:14:21 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ian Kent <raven@themaw.net>

The new fsinfo() system call adds a new super block operation
->fsinfo() which is used by file systems to provide file
system specific information for fsinfo() requests.

The fsinfo() request FSINFO_ATTR_PARAMETERS provides the same
function as sb operation ->show_options() so it needs to be
implemented by any file system that provides ->show_options()
as a minimum.

Signed-off-by: Ian Kent <raven@themaw.net>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 kernel/bpf/inode.c |   24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
index 6e22363054b1..49ac30424dd1 100644
--- a/kernel/bpf/inode.c
+++ b/kernel/bpf/inode.c
@@ -23,6 +23,7 @@
 #include <linux/filter.h>
 #include <linux/bpf.h>
 #include <linux/bpf_trace.h>
+#include <linux/fsinfo.h>
 
 enum bpf_type {
 	BPF_TYPE_UNSPEC	= 0,
@@ -567,6 +568,26 @@ static int bpf_show_options(struct seq_file *m, struct dentry *root)
 	return 0;
 }
 
+#ifdef CONFIG_FSINFO
+/*
+ * Get filesystem information.
+ */
+static int bpf_fsinfo(struct path *path, struct fsinfo_kparams *params)
+{
+	umode_t mode = d_inode(path->dentry)->i_mode & S_IALLUGO & ~S_ISVTX;
+
+	switch (params->request) {
+	case FSINFO_ATTR_PARAMETERS:
+		if (mode != S_IRWXUGO)
+			fsinfo_note_paramf(params, "mode", "%o", mode);
+		return params->usage;
+
+	default:
+		return generic_fsinfo(path, params);
+	}
+}
+#endif /* CONFIG_FSINFO */
+
 static void bpf_free_inode(struct inode *inode)
 {
 	enum bpf_type type;
@@ -583,6 +604,9 @@ static const struct super_operations bpf_super_ops = {
 	.drop_inode	= generic_delete_inode,
 	.show_options	= bpf_show_options,
 	.free_inode	= bpf_free_inode,
+#ifdef CONFIG_FSINFO
+	.fsinfo		= bpf_fsinfo,
+#endif
 };
 
 enum {

