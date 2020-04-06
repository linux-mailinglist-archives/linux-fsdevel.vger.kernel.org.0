Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4516A19F574
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Apr 2020 14:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbgDFMDn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Apr 2020 08:03:43 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44240 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727837AbgDFMDX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Apr 2020 08:03:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=X9T4vgxv3AED6WrMtBEfU9gKbzUFifrizTVGzClBy28=; b=lDBFdnMK7u5Ps2gCLlLSWzBICO
        NDp9wh6nvkix3LnCQc2911mE1kKuS6OWMmCXZ/SbIriHjG2y136Ouh1hSkJykTe2akQHQ0zXpEHyP
        SBk5zzkUJf8rM/AfM0a053N6JNxQCl6W3aDSMpVVSm6/cQSyvnsbjzWNfaWFBxHul25itMOg03dWy
        GH+PhZzfe1kKxhhXbeSsd0Fas7qNPH0AOC9wMkzEfdu96G05ZlwL2QFaxfcbOcmE61l7l0ZeGqODO
        hYAIuMXT79WPx07fJhI2LzxyTKtMG2jDFtjJ9zMonIeDIoDi08lEYMZ1SYSyvP8WfuTFjgAvdlB9w
        WmK+F0CQ==;
Received: from [2001:4bb8:180:5765:7ca0:239a:fe26:fec2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jLQTG-0003Jb-SH; Mon, 06 Apr 2020 12:03:19 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Jeremy Kerr <jk@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>,
        linuxppc-dev@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] binfmt_elf: open code copy_siginfo_to_user to kernelspace buffer
Date:   Mon,  6 Apr 2020 14:03:08 +0200
Message-Id: <20200406120312.1150405-3-hch@lst.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200406120312.1150405-1-hch@lst.de>
References: <20200406120312.1150405-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Instead of messing with the address limit just open code the trivial
memcpy + memset logic.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/binfmt_elf.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index f4713ea76e82..d744ce9a4b52 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1556,10 +1556,9 @@ static void fill_auxv_note(struct memelfnote *note, struct mm_struct *mm)
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
 
-- 
2.25.1

