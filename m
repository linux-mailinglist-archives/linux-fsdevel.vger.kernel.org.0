Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB2E22B644
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jul 2020 20:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbgGWS7d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Jul 2020 14:59:33 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:54334 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726617AbgGWS7b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Jul 2020 14:59:31 -0400
Received: from callcc.thunk.org (pool-96-230-252-158.bstnma.fios.verizon.net [96.230.252.158])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 06NIxSlY016217
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Jul 2020 14:59:28 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 07817420304; Thu, 23 Jul 2020 14:59:28 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     viro@zeniv.linux.org.uk
Cc:     Linux Filesystem Development List <linux-fsdevel@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH] fs: prevent out-of-bounds array speculation when closing a file descriptor
Date:   Thu, 23 Jul 2020 14:59:21 -0400
Message-Id: <20200723185921.1847880-1-tytso@mit.edu>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Google-Bug-Id: 114199369
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 fs/file.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/file.c b/fs/file.c
index abb8b7081d7a..73189eaad1df 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -632,6 +632,7 @@ int __close_fd(struct files_struct *files, unsigned fd)
 	fdt = files_fdtable(files);
 	if (fd >= fdt->max_fds)
 		goto out_unlock;
+	fd = array_index_nospec(fd, fdt->max_fds);
 	file = fdt->fd[fd];
 	if (!file)
 		goto out_unlock;
-- 
2.24.1

