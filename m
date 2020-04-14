Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43CF41A73FC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Apr 2020 09:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406208AbgDNHCF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Apr 2020 03:02:05 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44114 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406199AbgDNHCD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Apr 2020 03:02:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=EWZgZ6zyaZ6YMEIgvBGyR6v+qe30cpq5NGkMXzw4/z0=; b=brLQnI//YTVH10A1ASGVRH5ecM
        6D4KzVn5tJO5QdGtAC9GiH9cbvSIclxkBmD6MqKjC0qQCzI18Qxioj1Iy2beU52vZEEhtBmcrhILh
        bNGgEOK2yIm7cGevcumIY+OXpkfqH9wLqCub4OhtjyxjGWhpnbUIU5TEr8Um1An3BD5+QN/ftElkh
        OH+k7eUnl47pqatXQukhLm1pHnZ/APl8buAPWRuZGmZPHOOw2ddmUgDK5jfVwNSvjlZqaBP/c4Fwr
        RxEEqx56YHzv/XRdnWOkjzzVUdKKAKC0GFHYADKTaQTubMVvHTHpMfVfzPrKvoW1kJYXZXIdYr0kq
        9WUHsQYw==;
Received: from [2001:4bb8:180:384b:4c21:af7:dd95:e552] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jOFa0-0005Yq-5U; Tue, 14 Apr 2020 07:01:56 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Jeremy Kerr <jk@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        linuxppc-dev@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/8] binfmt_elf: open code copy_siginfo_to_user to kernelspace buffer
Date:   Tue, 14 Apr 2020 09:01:38 +0200
Message-Id: <20200414070142.288696-5-hch@lst.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200414070142.288696-1-hch@lst.de>
References: <20200414070142.288696-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Instead of messing with the address limit just open code the trivial
memcpy + memset logic for the native version, and a call to
to_compat_siginfo for the compat version.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/binfmt_elf.c        | 9 +++++----
 fs/compat_binfmt_elf.c | 6 +++++-
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 13f25e241ac4..607c5a5f855e 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1553,15 +1553,16 @@ static void fill_auxv_note(struct memelfnote *note, struct mm_struct *mm)
 	fill_note(note, "CORE", NT_AUXV, i * sizeof(elf_addr_t), auxv);
 }
 
+#ifndef fill_siginfo_note
 static void fill_siginfo_note(struct memelfnote *note, user_siginfo_t *csigdata,
 		const kernel_siginfo_t *siginfo)
 {
-	mm_segment_t old_fs = get_fs();
-	set_fs(KERNEL_DS);
-	copy_siginfo_to_user((user_siginfo_t __user *) csigdata, siginfo);
-	set_fs(old_fs);
+	memcpy(csigdata, siginfo, sizeof(struct kernel_siginfo));
+	memset((char *)csigdata + sizeof(struct kernel_siginfo), 0,
+		SI_EXPANSION_SIZE);
 	fill_note(note, "CORE", NT_SIGINFO, sizeof(*csigdata), csigdata);
 }
+#endif
 
 #define MAX_FILE_NOTE_SIZE (4*1024*1024)
 /*
diff --git a/fs/compat_binfmt_elf.c b/fs/compat_binfmt_elf.c
index aaad4ca1217e..ab84e095618b 100644
--- a/fs/compat_binfmt_elf.c
+++ b/fs/compat_binfmt_elf.c
@@ -39,7 +39,11 @@
  */
 #define user_long_t		compat_long_t
 #define user_siginfo_t		compat_siginfo_t
-#define copy_siginfo_to_user	copy_siginfo_to_user32
+#define fill_siginfo_note(note, csigdata, siginfo)		\
+do {									\
+	to_compat_siginfo(csigdata, siginfo, compat_siginfo_flags());	\
+	fill_note(note, "CORE", NT_SIGINFO, sizeof(*csigdata), csigdata); \
+} while (0)
 
 /*
  * The machine-dependent core note format types are defined in elfcore-compat.h,
-- 
2.25.1

