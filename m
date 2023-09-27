Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFD4E7B055E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Sep 2023 15:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231909AbjI0N3v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Sep 2023 09:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbjI0N3u (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Sep 2023 09:29:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84B26121;
        Wed, 27 Sep 2023 06:29:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DE94C433C7;
        Wed, 27 Sep 2023 13:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695821389;
        bh=HP0v40iSx8Vr8h/BjmerjsuwLjXNU/N7N3nzZW+WetY=;
        h=From:To:Cc:Subject:Date:From;
        b=efQ5Qou8ufF+JGMgMJavR2QSr4mopBd2oEsorbMTk3whH2K6Q3uv/3pXPVQFTn/ob
         qR+YiThAyNRbuwS98TNG/xzxml1jOpxBOsVFGhhX7rtenixlPJKcZsRNOjbmnShWMs
         m6O1/IvK7TIu2bSF3WnUkhCyojXYmQt2ASPlXRfsfVkpzDh7cZy/AIK7Xbp6DYEAuS
         SNGC+Ilnzo3x5xTNYmEcMWz4nzygVpDFmVX1ednK673veM50QScCU6FsVYmT592ORQ
         gyGibnwc6goWufL/kBuGGuawKWmj+/QCDQqba8m8F+3PHB1MG4lRSCcFQ87ecFRWN5
         Q1L8QYAcMmFBg==
From:   Greg Ungerer <gerg@kernel.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     palmer@rivosinc.com, keescook@chromium.org, ebiederm@xmission.com,
        brauner@kernel.org, viro@zeniv.linux.org.uk,
        Greg Ungerer <gerg@kernel.org>
Subject: [PATCH] binfmt_elf_fdpic: clean up debug warnings
Date:   Wed, 27 Sep 2023 23:29:33 +1000
Message-Id: <20230927132933.3290734-1-gerg@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The binfmt_elf_fdpic loader has some debug trace that can be enabled at
build time. The recent 64-bit additions cause some warnings if that
debug is enabled, such as:

    fs/binfmt_elf_fdpic.c: In function ‘elf_fdpic_map_file’:
    fs/binfmt_elf_fdpic.c:46:33: warning: format ‘%x’ expects argument of type ‘unsigned int’, but argument 3 has type ‘Elf64_Addr’ {aka ‘long long unsigned int’} [-Wformat=]
       46 | #define kdebug(fmt, ...) printk("FDPIC "fmt"\n" ,##__VA_ARGS__ )
          |                                 ^~~~~~~~
    ./include/linux/printk.h:427:25: note: in definition of macro ‘printk_index_wrap’
      427 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
          |                         ^~~~

Cast values to the largest possible type (which is equivilent to unsigned
long long in this case) and use appropriate format specifiers to match.

Fixes: b922bf04d2c1 ("binfmt_elf_fdpic: support 64-bit systems")
Signed-off-by: Greg Ungerer <gerg@kernel.org>
---
 fs/binfmt_elf_fdpic.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index 43b2a2851ba3..97c3e8551aac 100644
--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -900,10 +900,12 @@ static int elf_fdpic_map_file(struct elf_fdpic_params *params,
 	kdebug("- DYNAMIC[]: %lx", params->dynamic_addr);
 	seg = loadmap->segs;
 	for (loop = 0; loop < loadmap->nsegs; loop++, seg++)
-		kdebug("- LOAD[%d] : %08x-%08x [va=%x ms=%x]",
+		kdebug("- LOAD[%d] : %08llx-%08llx [va=%llx ms=%llx]",
 		       loop,
-		       seg->addr, seg->addr + seg->p_memsz - 1,
-		       seg->p_vaddr, seg->p_memsz);
+		       (unsigned long long) seg->addr,
+		       (unsigned long long) seg->addr + seg->p_memsz - 1,
+		       (unsigned long long) seg->p_vaddr,
+		       (unsigned long long) seg->p_memsz);
 
 	return 0;
 
@@ -1082,9 +1084,10 @@ static int elf_fdpic_map_file_by_direct_mmap(struct elf_fdpic_params *params,
 		maddr = vm_mmap(file, maddr, phdr->p_memsz + disp, prot, flags,
 				phdr->p_offset - disp);
 
-		kdebug("mmap[%d] <file> sz=%lx pr=%x fl=%x of=%lx --> %08lx",
-		       loop, phdr->p_memsz + disp, prot, flags,
-		       phdr->p_offset - disp, maddr);
+		kdebug("mmap[%d] <file> sz=%llx pr=%x fl=%x of=%llx --> %08lx",
+		       loop, (unsigned long long) phdr->p_memsz + disp,
+		       prot, flags, (unsigned long long) phdr->p_offset - disp,
+		       maddr);
 
 		if (IS_ERR_VALUE(maddr))
 			return (int) maddr;
@@ -1146,8 +1149,9 @@ static int elf_fdpic_map_file_by_direct_mmap(struct elf_fdpic_params *params,
 
 #else
 		if (excess > 0) {
-			kdebug("clear[%d] ad=%lx sz=%lx",
-			       loop, maddr + phdr->p_filesz, excess);
+			kdebug("clear[%d] ad=%llx sz=%lx", loop,
+			       (unsigned long long) maddr + phdr->p_filesz,
+			       excess);
 			if (clear_user((void *) maddr + phdr->p_filesz, excess))
 				return -EFAULT;
 		}
-- 
2.25.1

