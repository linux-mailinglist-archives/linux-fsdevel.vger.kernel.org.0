Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D776D3CB647
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jul 2021 12:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239560AbhGPKtl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Jul 2021 06:49:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:52078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239511AbhGPKtk (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Jul 2021 06:49:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 67396613E9;
        Fri, 16 Jul 2021 10:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626432405;
        bh=1aR2USH0CSQL4T/c6HKpO22PJzNSucyRjc4FadtDIlg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qK7goXNrq0nmffRXGExed9j+F8pXvlZzQ4zzJRV90PzwR24m/XAWtAsitB/k0kJdG
         O28XZ1xur/QgXXlc+HExsOy06lnHtOpH5/CCMUqXoxk+te5E3PN49REzHs4PJ1NlZz
         0X3Xa1WvQypQtAm+8407zB4LkrWK3b1w9HcY9VFumya0Y/jDyoLJ5ryP4DTLA6Eqgd
         zM1m+fh2ELqg+IpprKbQrVkZxDksbflQ7k5wfLEK2nfI5XieqmDoC9i5THMdGlys6H
         dGbC4jrO8n2rZbcv2xw9JNPMLl4NBNmpTYeyzimzrxLIqVJ22GDMGDS2bRRdSHP7cI
         nDpK4Y+7iqwdg==
From:   Alexey Gladkov <legion@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
Subject: [RESEND PATCH v6 1/5] docs: proc: add documentation about mount restrictions
Date:   Fri, 16 Jul 2021 12:45:59 +0200
Message-Id: <d6845d759b5792fec272c932c91bbe3a8523c976.1626432185.git.legion@kernel.org>
X-Mailer: git-send-email 2.29.3
In-Reply-To: <cover.1626432185.git.legion@kernel.org>
References: <cover.1626432185.git.legion@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Alexey Gladkov <legion@kernel.org>
---
 Documentation/filesystems/proc.rst | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 2fa69f710e2a..5a1bb0e081fd 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -50,6 +50,7 @@ fixes/update part 1.1  Stefani Seibold <stefani@seibold.net>    June 9 2009
 
   4	Configuring procfs
   4.1	Mount options
+  4.2	Mount restrictions
 
   5	Filesystem behavior
 
@@ -2175,6 +2176,19 @@ information about processes information, just add identd to this group.
 subset=pid hides all top level files and directories in the procfs that
 are not related to tasks.
 
+4.2	Mount restrictions
+--------------------------
+
+If user namespaces are in use, the kernel additionally checks the instances of
+procfs available to the mounter and will not allow procfs to be mounted if:
+
+  1. This mount is not fully visible.
+
+     a. It's root directory is not the root directory of the filesystem.
+     b. If any file or non-empty procfs directory is hidden by another mount.
+
+  2. A new mount overrides the readonly option or any option from atime familty.
+
 Chapter 5: Filesystem behavior
 ==============================
 
-- 
2.29.3

