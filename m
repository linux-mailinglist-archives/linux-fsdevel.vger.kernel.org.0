Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F4EA7ACD82
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Sep 2023 03:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbjIYBOe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 24 Sep 2023 21:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbjIYBOd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 24 Sep 2023 21:14:33 -0400
X-Greylist: delayed 1365 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 24 Sep 2023 18:14:26 PDT
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2355DF;
        Sun, 24 Sep 2023 18:14:26 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:46622)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qkZp0-0009rb-GN; Sun, 24 Sep 2023 18:51:34 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:57448 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qkZoy-00HNGT-UA; Sun, 24 Sep 2023 18:51:34 -0600
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
Date:   Sun, 24 Sep 2023 19:50:59 -0500
In-Reply-To: <36e93c8e-4384-b269-be78-479ccc7817b1@redhat.com> (Sebastian
        Ott's message of "Thu, 21 Sep 2023 12:36:34 +0200 (CEST)")
Message-ID: <87zg1bm5xo.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1qkZoy-00HNGT-UA;;;mid=<87zg1bm5xo.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX189MyQi6aZOi7cuLy5Pi8vFZekioLnKdO4=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Sebastian Ott <sebott@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 930 ms - load_scoreonly_sql: 0.07 (0.0%),
        signal_user_changed: 12 (1.3%), b_tie_ro: 11 (1.1%), parse: 2.1 (0.2%),
         extract_message_metadata: 10 (1.0%), get_uri_detail_list: 6 (0.7%),
        tests_pri_-2000: 4.1 (0.4%), tests_pri_-1000: 2.6 (0.3%),
        tests_pri_-950: 1.28 (0.1%), tests_pri_-900: 1.03 (0.1%),
        tests_pri_-200: 0.90 (0.1%), tests_pri_-100: 18 (1.9%), tests_pri_-90:
        98 (10.5%), check_bayes: 94 (10.1%), b_tokenize: 20 (2.1%),
        b_tok_get_all: 15 (1.6%), b_comp_prob: 5.0 (0.5%), b_tok_touch_all: 50
        (5.4%), b_finish: 0.92 (0.1%), tests_pri_0: 754 (81.1%),
        check_dkim_signature: 0.77 (0.1%), check_dkim_adsp: 2.7 (0.3%),
        poll_dns_idle: 0.42 (0.0%), tests_pri_10: 2.8 (0.3%), tests_pri_500:
        12 (1.3%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH RFC] binfmt_elf: fully allocate bss pages
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Sebastian Ott <sebott@redhat.com> writes:

> Hej,
>
> since we figured that the proposed patch is not going to work I've spent a
> couple more hours looking at this (some static binaries on arm64 segfault
> during load [0]). The segfault happens because of a failed clear_user()
> call in load_elf_binary(). The address we try to write zeros to is mapped with
> correct permissions.
>
> After some experiments I've noticed that writing to anonymous mappings work
> fine and all the error cases happend on file backed VMAs. Debugging showed that
> in elf_map() we call vm_mmap() with a file offset of 15 pages - for a binary
> that's less than 1KiB in size.
>
> Looking at the ELF headers again that 15 pages offset originates from the offset
> of the 2nd segment - so, I guess the loader did as instructed and that binary is
> just too nasty?
>
> Program Headers:
>   Type           Offset             VirtAddr           PhysAddr
>                  FileSiz            MemSiz              Flags  Align
>   LOAD           0x0000000000000000 0x0000000000400000 0x0000000000400000
>                  0x0000000000000178 0x0000000000000178  R E    0x10000
>   LOAD           0x000000000000ffe8 0x000000000041ffe8 0x000000000041ffe8
>                  0x0000000000000000 0x0000000000000008  RW     0x10000
>   NOTE           0x0000000000000120 0x0000000000400120 0x0000000000400120
>                  0x0000000000000024 0x0000000000000024  R      0x4
>   GNU_STACK      0x0000000000000000 0x0000000000000000 0x0000000000000000
>                  0x0000000000000000 0x0000000000000000  RW     0x10
>
> As an additional test I've added a bunch of zeros at the end of that binary
> so that the offset is within that file and it did load just fine.
>
> On the other hand there is this section header:
>   [ 4] .bss              NOBITS           000000000041ffe8  0000ffe8
>        0000000000000008  0000000000000000  WA       0     0     1
>
> "sh_offset
> This member's value gives the byte offset from the beginning of the file to
> the first byte in the section. One section type, SHT_NOBITS described
> below, occupies no space in the file, and its sh_offset member locates
> the conceptual placement in the file.
> "
>
> So, still not sure what to do here..
>
> Sebastian
>
> [0] https://lore.kernel.org/lkml/5d49767a-fbdc-fbe7-5fb2-d99ece3168cb@redhat.com/

I think that .bss section that is being generated is atrocious.

At the same time I looked at what the linux elf loader is trying to do,
and the elf loader's handling of program segments with memsz > filesz
has serious remnants a.out of programs allocating memory with the brk
syscall.

Lots of the structure looks like it started with the assumption that
there would only be a single program header with memsz > filesz the way
and that was the .bss.   The way things were in the a.out days and
handling of other cases has been debugged in later.

So I have modified elf_map to always return successfully when there is
a zero filesz in the program header for an elf segment.

Then I have factored out a function clear_tail that ensures the zero
padding for an entire elf segment is present.

Please test this and see if it causes your test case to work.

Please also dig into gcc or whichever code generates that horrendous
.bss section and see if that can be fixed so the code can work on older
kernels.  A section that only contains .bss has no business not being
properly aligned.  Even if the data in that section doesn't start at the
beginning of the page, there is no reason to feed nasty data to other
programs.  It just increases the odds of complications for no good
reason.  At a minimum that is going to be needed to run that code on
older kernels.

Eric


diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 7b3d2d491407..f6608df75df6 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -110,43 +110,66 @@ static struct linux_binfmt elf_format = {
 
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
    be in memory
  */
-static int padzero(unsigned long elf_bss)
+static int padzero(unsigned long elf_bss, unsigned long elf_brk)
 {
 	unsigned long nbyte;
 
 	nbyte = ELF_PAGEOFFSET(elf_bss);
 	if (nbyte) {
 		nbyte = ELF_MIN_ALIGN - nbyte;
+		if (nbyte > elf_brk - elf_bss)
+			nbyte = elf_brk - elf_bss;
 		if (clear_user((void __user *) elf_bss, nbyte))
 			return -EFAULT;
 	}
 	return 0;
 }
 
+static int clear_tail(struct elf_phdr *phdr, unsigned long load_bias, int prot)
+{
+	unsigned long start, end;
+
+	/* Is there a tail to clear? */
+	if (phdr->p_filesz >= phdr->p_memsz)
+		return 0;
+
+	/* Where does the tail start? */
+	if (phdr->p_filesz)
+		start = load_bias + phdr->p_vaddr + phdr->p_filesz;
+	else
+		start = ELF_PAGESTART(load_bias + phdr->p_vaddr);
+
+	/* Where does the tail end? */
+	end = load_bias + phdr->p_vaddr + phdr->p_memsz;
+
+	/*
+	 * This bss-zeroing can fail if the ELF
+	 * file specifies odd protections. So
+	 * we don't check the return value
+	 */
+	padzero(start, end);
+
+	start = ELF_PAGEALIGN(start);
+	end = ELF_PAGEALIGN(end);
+	if (end > start) {
+		/*
+		 * Map the last of the bss segment.
+		 * If the header is requesting these pages to be
+		 * executable, honour that (ppc32 needs this).
+		 */
+		int error = vm_brk_flags(start, end - start,
+				prot & PROT_EXEC ? VM_EXEC : 0);
+		if (error)
+			return error;
+	}
+	return 0;
+}
+
 /* Let's use some macros to make this stack manipulation a little clearer */
 #ifdef CONFIG_STACK_GROWSUP
 #define STACK_ADD(sp, items) ((elf_addr_t __user *)(sp) + (items))
@@ -379,7 +402,7 @@ static unsigned long elf_map(struct file *filep, unsigned long addr,
 
 	/* mmap() will return -EINVAL if given a zero size, but a
 	 * segment with zero filesize is perfectly valid */
-	if (!size)
+	if (!eppnt->p_filesz)
 		return addr;
 
 	/*
@@ -596,8 +619,6 @@ static unsigned long load_elf_interp(struct elfhdr *interp_elf_ex,
 	struct elf_phdr *eppnt;
 	unsigned long load_addr = 0;
 	int load_addr_set = 0;
-	unsigned long last_bss = 0, elf_bss = 0;
-	int bss_prot = 0;
 	unsigned long error = ~0UL;
 	unsigned long total_size;
 	int i;
@@ -661,50 +682,13 @@ static unsigned long load_elf_interp(struct elfhdr *interp_elf_ex,
 				goto out;
 			}
 
-			/*
-			 * Find the end of the file mapping for this phdr, and
-			 * keep track of the largest address we see for this.
-			 */
-			k = load_addr + eppnt->p_vaddr + eppnt->p_filesz;
-			if (k > elf_bss)
-				elf_bss = k;
-
-			/*
-			 * Do the same thing for the memory mapping - between
-			 * elf_bss and last_bss is the bss section.
-			 */
-			k = load_addr + eppnt->p_vaddr + eppnt->p_memsz;
-			if (k > last_bss) {
-				last_bss = k;
-				bss_prot = elf_prot;
-			}
+			/* Map anonymous pages and clear the tail if needed */
+			error = clear_tail(eppnt, load_addr, elf_prot);
+			if (error)
+				goto out;
 		}
 	}
 
-	/*
-	 * Now fill out the bss section: first pad the last page from
-	 * the file up to the page boundary, and zero it from elf_bss
-	 * up to the end of the page.
-	 */
-	if (padzero(elf_bss)) {
-		error = -EFAULT;
-		goto out;
-	}
-	/*
-	 * Next, align both the file and mem bss up to the page size,
-	 * since this is where elf_bss was just zeroed up to, and where
-	 * last_bss will end after the vm_brk_flags() below.
-	 */
-	elf_bss = ELF_PAGEALIGN(elf_bss);
-	last_bss = ELF_PAGEALIGN(last_bss);
-	/* Finally, if there is still more bss to allocate, do it. */
-	if (last_bss > elf_bss) {
-		error = vm_brk_flags(elf_bss, last_bss - elf_bss,
-				bss_prot & PROT_EXEC ? VM_EXEC : 0);
-		if (error)
-			goto out;
-	}
-
 	error = load_addr;
 out:
 	return error;
@@ -828,8 +812,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	unsigned long error;
 	struct elf_phdr *elf_ppnt, *elf_phdata, *interp_elf_phdata = NULL;
 	struct elf_phdr *elf_property_phdata = NULL;
-	unsigned long elf_bss, elf_brk;
-	int bss_prot = 0;
+	unsigned long elf_brk;
 	int retval, i;
 	unsigned long elf_entry;
 	unsigned long e_entry;
@@ -1020,7 +1003,6 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	if (retval < 0)
 		goto out_free_dentry;
 
-	elf_bss = 0;
 	elf_brk = 0;
 
 	start_code = ~0UL;
@@ -1040,32 +1022,6 @@ static int load_elf_binary(struct linux_binprm *bprm)
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
 
 		elf_prot = make_prot(elf_ppnt->p_flags, &arch_state,
 				     !!interpreter, false);
@@ -1208,42 +1164,31 @@ static int load_elf_binary(struct linux_binprm *bprm)
 			goto out_free_dentry;
 		}
 
-		k = elf_ppnt->p_vaddr + elf_ppnt->p_filesz;
+		/* Map anonymous pages and clear the tail if needed */
+		retval = clear_tail(elf_ppnt, load_bias, elf_prot);
+		if (retval)
+			goto out_free_dentry;
 
-		if (k > elf_bss)
-			elf_bss = k;
+		k = elf_ppnt->p_vaddr + elf_ppnt->p_filesz;
 		if ((elf_ppnt->p_flags & PF_X) && end_code < k)
 			end_code = k;
 		if (end_data < k)
 			end_data = k;
 		k = elf_ppnt->p_vaddr + elf_ppnt->p_memsz;
 		if (k > elf_brk) {
-			bss_prot = elf_prot;
 			elf_brk = k;
 		}
 	}
 
 	e_entry = elf_ex->e_entry + load_bias;
 	phdr_addr += load_bias;
-	elf_bss += load_bias;
 	elf_brk += load_bias;
 	start_code += load_bias;
 	end_code += load_bias;
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
@@ -1369,7 +1314,6 @@ static int load_elf_library(struct file *file)
 {
 	struct elf_phdr *elf_phdata;
 	struct elf_phdr *eppnt;
-	unsigned long elf_bss, bss, len;
 	int retval, error, i, j;
 	struct elfhdr elf_ex;
 
@@ -1425,19 +1369,9 @@ static int load_elf_library(struct file *file)
 	if (error != ELF_PAGESTART(eppnt->p_vaddr))
 		goto out_free_ph;
 
-	elf_bss = eppnt->p_vaddr + eppnt->p_filesz;
-	if (padzero(elf_bss)) {
-		error = -EFAULT;
+	error = clear_tail(eppnt, 0, 0);
+	if (error)
 		goto out_free_ph;
-	}
-
-	len = ELF_PAGEALIGN(eppnt->p_filesz + eppnt->p_vaddr);
-	bss = ELF_PAGEALIGN(eppnt->p_memsz + eppnt->p_vaddr);
-	if (bss > len) {
-		error = vm_brk(len, bss - len);
-		if (error)
-			goto out_free_ph;
-	}
 	error = 0;
 
 out_free_ph:

