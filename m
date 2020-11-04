Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D92002A5EF7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Nov 2020 08:52:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728922AbgKDHv5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Wed, 4 Nov 2020 02:51:57 -0500
Received: from mx1.emlix.com ([136.243.223.33]:44506 "EHLO mx1.emlix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728518AbgKDHv5 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Nov 2020 02:51:57 -0500
X-Greylist: delayed 538 seconds by postgrey-1.27 at vger.kernel.org; Wed, 04 Nov 2020 02:51:56 EST
Received: from mailer.emlix.com (p5098be52.dip0.t-ipconnect.de [80.152.190.82])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.emlix.com (Postfix) with ESMTPS id DF3BB6046C;
        Wed,  4 Nov 2020 08:42:57 +0100 (CET)
From:   Rolf Eike Beer <eb@emlix.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] binfmt_elf: simplify error handling in load_elf_phdrs()
Date:   Wed, 04 Nov 2020 08:42:58 +0100
Message-ID: <1810206.T5v88Pq2cJ@devpool47>
Organization: emlix GmbH
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Rolf Eike Beer <eb@emlix.com>
---
 fs/binfmt_elf.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index b588d1291b25..74827a7a06d0 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -458,7 +458,7 @@ static struct elf_phdr *load_elf_phdrs(const struct elfhdr *elf_ex,
 				       struct file *elf_file)
 {
 	struct elf_phdr *elf_phdata = NULL;
-	int retval, err = -1;
+	int retval = -1;
 	unsigned int size;
 
 	/*
@@ -480,15 +480,9 @@ static struct elf_phdr *load_elf_phdrs(const struct elfhdr *elf_ex,
 
 	/* Read in the program headers */
 	retval = elf_read(elf_file, elf_phdata, size, elf_ex->e_phoff);
-	if (retval < 0) {
-		err = retval;
-		goto out;
-	}
 
-	/* Success! */
-	err = 0;
 out:
-	if (err) {
+	if (retval) {
 		kfree(elf_phdata);
 		elf_phdata = NULL;
 	}
-- 
2.29.1


-- 
Rolf Eike Beer, emlix GmbH, http://www.emlix.com
Fon +49 551 30664-0, Fax +49 551 30664-11
Gothaer Platz 3, 37083 Göttingen, Germany
Sitz der Gesellschaft: Göttingen, Amtsgericht Göttingen HR B 3160
Geschäftsführung: Heike Jordan, Dr. Uwe Kracke – Ust-IdNr.: DE 205 198 055

emlix - smart embedded open source



