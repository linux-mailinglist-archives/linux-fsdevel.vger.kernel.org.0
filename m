Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5C0423C839
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Aug 2020 10:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727921AbgHEIxy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Wed, 5 Aug 2020 04:53:54 -0400
Received: from mx1.emlix.com ([188.40.240.192]:45754 "EHLO mx1.emlix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726104AbgHEIxx (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Aug 2020 04:53:53 -0400
Received: from mailer.emlix.com (unknown [81.20.119.6])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.emlix.com (Postfix) with ESMTPS id DB9D65F98C;
        Wed,  5 Aug 2020 10:53:51 +0200 (CEST)
From:   Rolf Eike Beer <eb@emlix.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Ralf Baechle <ralf@linux-mips.org>
Subject: binfmt_elf: simplify error handling in load_elf_phdrs()
Date:   Wed, 05 Aug 2020 10:53:51 +0200
Message-ID: <3284126.HYjqi5uYoC@devpool35>
Organization: emlix GmbH
In-Reply-To: <6469675.ETGqQKjL3G@devpool35>
References: <6469675.ETGqQKjL3G@devpool35>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

---
 fs/binfmt_elf.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 251298d25c8c..64b4b47448af 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -434,7 +434,7 @@ static struct elf_phdr *load_elf_phdrs(const struct elfhdr *elf_ex,
 				       struct file *elf_file)
 {
 	struct elf_phdr *elf_phdata = NULL;
-	int retval, err = -1;
+	int retval = -1;
 	unsigned int size;
 
 	/*
@@ -456,15 +456,9 @@ static struct elf_phdr *load_elf_phdrs(const struct elfhdr *elf_ex,
 
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
2.28.0


-- 
Rolf Eike Beer, emlix GmbH, http://www.emlix.com
Fon +49 551 30664-0, Fax +49 551 30664-11
Gothaer Platz 3, 37083 Göttingen, Germany
Sitz der Gesellschaft: Göttingen, Amtsgericht Göttingen HR B 3160
Geschäftsführung: Heike Jordan, Dr. Uwe Kracke – Ust-IdNr.: DE 205 198 055

emlix - smart embedded open source



