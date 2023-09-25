Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59B6B7AD873
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Sep 2023 14:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231395AbjIYM7z convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Sep 2023 08:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjIYM7y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Sep 2023 08:59:54 -0400
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35EFA111;
        Mon, 25 Sep 2023 05:59:47 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:54348)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qklBe-008HDy-UV; Mon, 25 Sep 2023 06:59:42 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:34044 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qklBd-000Ydx-Cr; Mon, 25 Sep 2023 06:59:42 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Sebastian Ott <sebott@redhat.com>
Cc:     Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Mark Brown <broonie@kernel.org>, Willy Tarreau <w@1wt.eu>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20230914-bss-alloc-v1-1-78de67d2c6dd@weissschuh.net>
        <36e93c8e-4384-b269-be78-479ccc7817b1@redhat.com>
        <87zg1bm5xo.fsf@email.froward.int.ebiederm.org>
        <37d3392c-cf33-20a6-b5c9-8b3fb8142658@redhat.com>
Date:   Mon, 25 Sep 2023 07:59:14 -0500
In-Reply-To: <37d3392c-cf33-20a6-b5c9-8b3fb8142658@redhat.com> (Sebastian
        Ott's message of "Mon, 25 Sep 2023 11:20:51 +0200 (CEST)")
Message-ID: <87jzsemmsd.fsf_-_@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1qklBd-000Ydx-Cr;;;mid=<87jzsemmsd.fsf_-_@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1+zeBWlMWYidPi5EZ2XGj5BTvgKF/74uK4=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Virus: No
X-Spam-DCC: XMission; sa03 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Sebastian Ott <sebott@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 908 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 4.2 (0.5%), b_tie_ro: 2.8 (0.3%), parse: 1.03
        (0.1%), extract_message_metadata: 13 (1.4%), get_uri_detail_list: 2.6
        (0.3%), tests_pri_-2000: 11 (1.2%), tests_pri_-1000: 2.1 (0.2%),
        tests_pri_-950: 1.02 (0.1%), tests_pri_-900: 0.84 (0.1%),
        tests_pri_-200: 0.69 (0.1%), tests_pri_-100: 14 (1.5%), tests_pri_-90:
        70 (7.7%), check_bayes: 69 (7.5%), b_tokenize: 10 (1.1%),
        b_tok_get_all: 10 (1.1%), b_comp_prob: 2.0 (0.2%), b_tok_touch_all: 44
        (4.8%), b_finish: 0.66 (0.1%), tests_pri_0: 429 (47.2%),
        check_dkim_signature: 0.48 (0.1%), check_dkim_adsp: 2.3 (0.2%),
        poll_dns_idle: 344 (37.9%), tests_pri_10: 1.73 (0.2%), tests_pri_500:
        357 (39.3%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH] binfmt_elf: Support segments with 0 filesz and misaligned
 starts
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Implement a helper elf_load that wraps elf_map and performs all
of the necessary work to ensure that when "memsz > filesz"
the bytes described by "memsz > filesz" are zeroed.

Link: https://lkml.kernel.org/r/20230914-bss-alloc-v1-1-78de67d2c6dd@weissschuh.net
Reported-by: Sebastian Ott <sebott@redhat.com>
Reported-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/binfmt_elf.c | 111 +++++++++++++++++++++---------------------------
 1 file changed, 48 insertions(+), 63 deletions(-)

Can you please test this one?

With this patch I can boot a machine, and I like the structure much
better.  Overall this seems a more reviewable and safer patch although
it is almost as aggressive in the cleanups.

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 7b3d2d491407..8bea9d974361 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -110,25 +110,6 @@ static struct linux_binfmt elf_format = {
 
 #define BAD_ADDR(x) (unlikely((unsigned long)(x) >= TASK_SIZE))
 
-static int set_brk(unsigned long start, unsigned long end, int prot)
-{
-	start = ELF_PAGEALIGN(start);
-	end = ELF_PAGEALIGN(end);
-	if (end > start) {
-		/*
-		 * Map the last of the bss segment.
-		 * If the header is requesting these pages to be
-		 * executable, honour that (ppc32 needs this).
-		 */
-		int error = vm_brk_flags(start, end - start,
-				prot & PROT_EXEC ? VM_EXEC : 0);
-		if (error)
-			return error;
-	}
-	current->mm->start_brk = current->mm->brk = end;
-	return 0;
-}
-
 /* We need to explicitly zero any fractional pages
    after the data section (i.e. bss).  This would
    contain the junk from the file that should not
@@ -406,6 +387,51 @@ static unsigned long elf_map(struct file *filep, unsigned long addr,
 	return(map_addr);
 }
 
+static unsigned long elf_load(struct file *filep, unsigned long addr,
+		const struct elf_phdr *eppnt, int prot, int type,
+		unsigned long total_size)
+{
+	unsigned long zero_start, zero_end;
+	unsigned long map_addr;
+
+	if (eppnt->p_filesz) {
+		map_addr = elf_map(filep, addr, eppnt, prot, type, total_size);
+		if (BAD_ADDR(map_addr))
+			return map_addr;
+		if (eppnt->p_memsz > eppnt->p_filesz) {
+			zero_start = map_addr + ELF_PAGEOFFSET(eppnt->p_vaddr) +
+				eppnt->p_filesz;
+			zero_end = map_addr + ELF_PAGEOFFSET(eppnt->p_vaddr) +
+				eppnt->p_memsz;
+
+			/* Zero the end of the last mapped page */
+			padzero(zero_start);
+		}
+	} else {
+		zero_start = ELF_PAGESTART(addr);
+		zero_end = zero_start + ELF_PAGEOFFSET(eppnt->p_vaddr) +
+			eppnt->p_memsz;
+	}
+	if (eppnt->p_memsz > eppnt->p_filesz) {
+		/*
+		 * Map the last of the segment.
+		 * If the header is requesting these pages to be
+		 * executable, honour that (ppc32 needs this).
+		 */
+		int error;
+
+		zero_start = ELF_PAGEALIGN(zero_start);
+		zero_end = ELF_PAGEALIGN(zero_end);
+
+		error = vm_brk_flags(zero_start, zero_end - zero_start,
+				     prot & PROT_EXEC ? VM_EXEC : 0);
+		if (error)
+			map_addr = error;
+	}
+	return map_addr;
+}
+
+
 static unsigned long total_mapping_size(const struct elf_phdr *phdr, int nr)
 {
 	elf_addr_t min_addr = -1;
@@ -829,7 +855,6 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	struct elf_phdr *elf_ppnt, *elf_phdata, *interp_elf_phdata = NULL;
 	struct elf_phdr *elf_property_phdata = NULL;
 	unsigned long elf_bss, elf_brk;
-	int bss_prot = 0;
 	int retval, i;
 	unsigned long elf_entry;
 	unsigned long e_entry;
@@ -1040,33 +1065,6 @@ static int load_elf_binary(struct linux_binprm *bprm)
 		if (elf_ppnt->p_type != PT_LOAD)
 			continue;
 
-		if (unlikely (elf_brk > elf_bss)) {
-			unsigned long nbyte;
-
-			/* There was a PT_LOAD segment with p_memsz > p_filesz
-			   before this one. Map anonymous pages, if needed,
-			   and clear the area.  */
-			retval = set_brk(elf_bss + load_bias,
-					 elf_brk + load_bias,
-					 bss_prot);
-			if (retval)
-				goto out_free_dentry;
-			nbyte = ELF_PAGEOFFSET(elf_bss);
-			if (nbyte) {
-				nbyte = ELF_MIN_ALIGN - nbyte;
-				if (nbyte > elf_brk - elf_bss)
-					nbyte = elf_brk - elf_bss;
-				if (clear_user((void __user *)elf_bss +
-							load_bias, nbyte)) {
-					/*
-					 * This bss-zeroing can fail if the ELF
-					 * file specifies odd protections. So
-					 * we don't check the return value
-					 */
-				}
-			}
-		}
-
 		elf_prot = make_prot(elf_ppnt->p_flags, &arch_state,
 				     !!interpreter, false);
 
@@ -1162,7 +1160,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 			}
 		}
 
-		error = elf_map(bprm->file, load_bias + vaddr, elf_ppnt,
+		error = elf_load(bprm->file, load_bias + vaddr, elf_ppnt,
 				elf_prot, elf_flags, total_size);
 		if (BAD_ADDR(error)) {
 			retval = IS_ERR_VALUE(error) ?
@@ -1217,10 +1215,8 @@ static int load_elf_binary(struct linux_binprm *bprm)
 		if (end_data < k)
 			end_data = k;
 		k = elf_ppnt->p_vaddr + elf_ppnt->p_memsz;
-		if (k > elf_brk) {
-			bss_prot = elf_prot;
+		if (k > elf_brk)
 			elf_brk = k;
-		}
 	}
 
 	e_entry = elf_ex->e_entry + load_bias;
@@ -1232,18 +1228,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	start_data += load_bias;
 	end_data += load_bias;
 
-	/* Calling set_brk effectively mmaps the pages that we need
-	 * for the bss and break sections.  We must do this before
-	 * mapping in the interpreter, to make sure it doesn't wind
-	 * up getting placed where the bss needs to go.
-	 */
-	retval = set_brk(elf_bss, elf_brk, bss_prot);
-	if (retval)
-		goto out_free_dentry;
-	if (likely(elf_bss != elf_brk) && unlikely(padzero(elf_bss))) {
-		retval = -EFAULT; /* Nobody gets to see this, but.. */
-		goto out_free_dentry;
-	}
+	current->mm->start_brk = current->mm->brk = ELF_PAGEALIGN(elf_brk);
 
 	if (interpreter) {
 		elf_entry = load_elf_interp(interp_elf_ex,
-- 
2.41.0

