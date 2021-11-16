Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 358AB4532A6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Nov 2021 14:12:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236594AbhKPNOS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Nov 2021 08:14:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:22377 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236544AbhKPNOO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Nov 2021 08:14:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637068277;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=G+eFuVhDZ+VMRsPPrXKpG+BgL73UT9dRvCnGODv/ZC0=;
        b=Wiesi/w8RGrpEgMiqQDOadCu3L3EKlYomP4csIPCyH7ha5Blh3GLuFKu6+yrCo1jfr0fk5
        QNbZkFeB6zR9KyRCgqr3fZjSZT45Ld08ZFcDDwpLSupP1NP3cMAllOtx+TyMpiDqUjwGTb
        A6Xy0YY/jnIXsA+1C8UtnFyLVjpyXRc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-385-msIPPAEFNGiKqYENOBTpcw-1; Tue, 16 Nov 2021 08:11:16 -0500
X-MC-Unique: msIPPAEFNGiKqYENOBTpcw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0C7F61966320;
        Tue, 16 Nov 2021 13:11:15 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.39.192.241])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 29FC460C13;
        Tue, 16 Nov 2021 13:11:12 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Christian Brauner <christian@brauner.io>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] proc: Make the proc_create[_data]() stubs static inlines
Date:   Tue, 16 Nov 2021 14:11:12 +0100
Message-Id: <20211116131112.508304-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Change the proc_create[_data]() stubs which are used when CONFIG_PROC_FS
is not set from #defines to a static inline stubs.

Thix should fix clang -Werror builds failing due to errors like this:

drivers/platform/x86/thinkpad_acpi.c:918:30: error: unused variable
 'dispatch_proc_ops' [-Werror,-Wunused-const-variable]

Fixing this in include/linux/proc_fs.h should ensure that the same issue
is also fixed in any other drivers hitting the same -Werror issue.

Cc: platform-driver-x86@vger.kernel.org
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Note the commit message says "should fix" because I could not actually
be bothered to verify this. The whole notion of combining:
1. clang
2. -Werror
3. -Wunused-const-variable
Is frankly a bit crazy, causing way too much noise and has already
cost me too much time IMHO.
---
 include/linux/proc_fs.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/linux/proc_fs.h b/include/linux/proc_fs.h
index 069c7fd95396..3d19453fb6b3 100644
--- a/include/linux/proc_fs.h
+++ b/include/linux/proc_fs.h
@@ -178,8 +178,14 @@ static inline struct proc_dir_entry *proc_mkdir_mode(const char *name,
 #define proc_create_seq(name, mode, parent, ops) ({NULL;})
 #define proc_create_single(name, mode, parent, show) ({NULL;})
 #define proc_create_single_data(name, mode, parent, show, data) ({NULL;})
-#define proc_create(name, mode, parent, proc_ops) ({NULL;})
-#define proc_create_data(name, mode, parent, proc_ops, data) ({NULL;})
+
+static inline struct proc_dir_entry *proc_create(
+	const char *, umode_t, struct proc_dir_entry *, const struct proc_ops *)
+{ return NULL; }
+
+static inline struct proc_dir_entry *proc_create_data(
+	const char *, umode_t, struct proc_dir_entry *, const struct proc_ops *, void *)
+{ return NULL; }
 
 static inline void proc_set_size(struct proc_dir_entry *de, loff_t size) {}
 static inline void proc_set_user(struct proc_dir_entry *de, kuid_t uid, kgid_t gid) {}
-- 
2.31.1

