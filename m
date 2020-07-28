Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B69723109D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jul 2020 19:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731832AbgG1RLP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jul 2020 13:11:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:35896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731070AbgG1RLP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jul 2020 13:11:15 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B599E20792;
        Tue, 28 Jul 2020 17:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595956275;
        bh=MR8mg3/IJgrM9SZbw474ePJSLyQfESFHDMAInBpWuhE=;
        h=From:To:Cc:Subject:Date:From;
        b=Ofm5DMIzcN6j+Cha4R0mw1pUbT1n3f9mVPYx0hue/a0Ot7cJk5nom/ged2M7RNngu
         ZWQ0yxelrt+kwWo/XbT9oZ71iwKI2chnFMsQhSDAnsPwuklcCGKR9KShwFDMpb3or/
         oI2ba8c7N3TQHJk86dU7tzg9SueKWVovgPRdtI+s=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 1/4] anon_inodes: Make _anon_inode_getfile() static
Date:   Tue, 28 Jul 2020 19:11:06 +0200
Message-Id: <20200728171109.28687-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

_anon_inode_getfile() function is not used outside so make it static to
fix W=1 warning:

    fs/anon_inodes.c:80:14: warning: no previous prototype for '_anon_inode_getfile' [-Wmissing-prototypes]
       80 | struct file *_anon_inode_getfile(const char *name,

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 fs/anon_inodes.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/anon_inodes.c b/fs/anon_inodes.c
index 25d92c64411e..90b022960027 100644
--- a/fs/anon_inodes.c
+++ b/fs/anon_inodes.c
@@ -77,11 +77,11 @@ static struct inode *anon_inode_make_secure_inode(
 	return inode;
 }
 
-struct file *_anon_inode_getfile(const char *name,
-				 const struct file_operations *fops,
-				 void *priv, int flags,
-				 const struct inode *context_inode,
-				 bool secure)
+static struct file *_anon_inode_getfile(const char *name,
+					const struct file_operations *fops,
+					void *priv, int flags,
+					const struct inode *context_inode,
+					bool secure)
 {
 	struct inode *inode;
 	struct file *file;
-- 
2.17.1

