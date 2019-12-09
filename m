Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 162E2117BCA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2019 00:49:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727282AbfLIXs7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Dec 2019 18:48:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:52532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726743AbfLIXs7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Dec 2019 18:48:59 -0500
Received: from ebiggers-linuxstation.mtv.corp.google.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9EDD8206D5;
        Mon,  9 Dec 2019 23:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575935338;
        bh=qIw0/Cqg5inNE3yoL3e9n6zRu1d5Hx4DEJ3fhR1AhEg=;
        h=From:To:Cc:Subject:Date:From;
        b=OXOcd8PNcrC5gQO797td2Ws7LHz2V3kvnoY+kFTy7HzaoxUeseUxW5H3YxXz3sBsQ
         H/xD+yZm11RwfCq+gEcXZYLad3II4gmje9SktQ4h2Xxkn7rUKomWijPJIR1lJ1EJra
         u8SRfhTJ686l/HDIFa66hq4Padpf8fnhQiIokcrg=
From:   Eric Biggers <ebiggers@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH] fs/namespace.c: make to_mnt_ns() static
Date:   Mon,  9 Dec 2019 15:48:30 -0800
Message-Id: <20191209234830.156260-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.24.0.393.g34dc348eaf-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Make to_mnt_ns() static to address the following 'sparse' warning:

    fs/namespace.c:1731:22: warning: symbol 'to_mnt_ns' was not declared. Should it be static?

Signed-off-by: Eric Biggers <ebiggers@google.com>
---

Hi Andrew, please consider applying this straightforward cleanup.
This has been sent to Al four times with no response, plus this
same patch has been sent many times by other people too.

 fs/namespace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 2fd0c8bcb8c14..dd26cad6c5dd5 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1728,7 +1728,7 @@ static bool is_mnt_ns_file(struct dentry *dentry)
 	       dentry->d_fsdata == &mntns_operations;
 }
 
-struct mnt_namespace *to_mnt_ns(struct ns_common *ns)
+static struct mnt_namespace *to_mnt_ns(struct ns_common *ns)
 {
 	return container_of(ns, struct mnt_namespace, ns);
 }
-- 
2.24.0.393.g34dc348eaf-goog

