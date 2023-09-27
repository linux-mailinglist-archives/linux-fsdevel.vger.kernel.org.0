Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 377C17B0D38
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Sep 2023 22:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbjI0UTE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Sep 2023 16:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjI0UTD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Sep 2023 16:19:03 -0400
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D2E11D;
        Wed, 27 Sep 2023 13:19:02 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:46428)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qlazr-005jV1-5R; Wed, 27 Sep 2023 14:18:59 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:42922 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qlazp-005ur2-UD; Wed, 27 Sep 2023 14:18:58 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Sebastian Ott <sebott@redhat.com>,
        Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Pedro Falcato <pedro.falcato@gmail.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20230927033634.make.602-kees@kernel.org>
        <20230927034223.986157-3-keescook@chromium.org>
Date:   Wed, 27 Sep 2023 15:18:34 -0500
In-Reply-To: <20230927034223.986157-3-keescook@chromium.org> (Kees Cook's
        message of "Tue, 26 Sep 2023 20:42:20 -0700")
Message-ID: <87y1gr8j51.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1qlazp-005ur2-UD;;;mid=<87y1gr8j51.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX19RBgBS8g27Lxlq2bg39xuBcUJPOTSRDNI=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: ; sa06 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Kees Cook <keescook@chromium.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 663 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 10 (1.5%), b_tie_ro: 9 (1.3%), parse: 1.42 (0.2%),
         extract_message_metadata: 27 (4.0%), get_uri_detail_list: 4.0 (0.6%),
        tests_pri_-2000: 28 (4.3%), tests_pri_-1000: 2.5 (0.4%),
        tests_pri_-950: 1.29 (0.2%), tests_pri_-900: 1.06 (0.2%),
        tests_pri_-200: 0.88 (0.1%), tests_pri_-100: 19 (2.9%), tests_pri_-90:
        168 (25.4%), check_bayes: 159 (23.9%), b_tokenize: 10 (1.5%),
        b_tok_get_all: 9 (1.3%), b_comp_prob: 2.4 (0.4%), b_tok_touch_all: 133
        (20.1%), b_finish: 1.01 (0.2%), tests_pri_0: 385 (58.0%),
        check_dkim_signature: 0.61 (0.1%), check_dkim_adsp: 7 (1.1%),
        poll_dns_idle: 0.73 (0.1%), tests_pri_10: 2.2 (0.3%), tests_pri_500:
        14 (2.1%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v3 3/4] binfmt_elf: Provide prot bits as context for
 padzero() errors
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Kees Cook <keescook@chromium.org> writes:

> Errors with padzero() should be caught unless we're expecting a
> pathological (non-writable) segment. Report -EFAULT only when PROT_WRITE
> is present.
>
> Additionally add some more documentation to padzero(), elf_map(), and
> elf_load().

I wonder if this might be easier to just perform the PROT_WRITE
test in elf_load, and to completely skip padzero of PROT_WRITE
is not present. 

Eric

> Cc: Eric Biederman <ebiederm@xmission.com>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: linux-fsdevel@vger.kernel.org
> Cc: linux-mm@kvack.org
> Suggested-by: Eric Biederman <ebiederm@xmission.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  fs/binfmt_elf.c | 33 +++++++++++++++++++++++----------
>  1 file changed, 23 insertions(+), 10 deletions(-)
>
> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> index 0214d5a949fc..b939cfe3215c 100644
> --- a/fs/binfmt_elf.c
> +++ b/fs/binfmt_elf.c
> @@ -110,19 +110,21 @@ static struct linux_binfmt elf_format = {
>  
>  #define BAD_ADDR(x) (unlikely((unsigned long)(x) >= TASK_SIZE))
>  
> -/* We need to explicitly zero any fractional pages
> -   after the data section (i.e. bss).  This would
> -   contain the junk from the file that should not
> -   be in memory
> +/*
> + * We need to explicitly zero any trailing portion of the page that follows
> + * p_filesz when it ends before the page ends (e.g. bss), otherwise this
> + * memory will contain the junk from the file that should not be present.
>   */
> -static int padzero(unsigned long elf_bss)
> +static int padzero(unsigned long address, int prot)
>  {
>  	unsigned long nbyte;
>  
> -	nbyte = ELF_PAGEOFFSET(elf_bss);
> +	nbyte = ELF_PAGEOFFSET(address);
>  	if (nbyte) {
>  		nbyte = ELF_MIN_ALIGN - nbyte;
> -		if (clear_user((void __user *) elf_bss, nbyte))
> +		/* Only report errors when the segment is writable. */
> +		if (clear_user((void __user *)address, nbyte) &&
> +		    prot & PROT_WRITE)
>  			return -EFAULT;
>  	}
>  	return 0;
> @@ -348,6 +350,11 @@ create_elf_tables(struct linux_binprm *bprm, const struct elfhdr *exec,
>  	return 0;
>  }
>  
> +/*
> + * Map "eppnt->p_filesz" bytes from "filep" offset "eppnt->p_offset"
> + * into memory at "addr". (Note that p_filesz is rounded up to the
> + * next page, so any extra bytes from the file must be wiped.)
> + */
>  static unsigned long elf_map(struct file *filep, unsigned long addr,
>  		const struct elf_phdr *eppnt, int prot, int type,
>  		unsigned long total_size)
> @@ -387,6 +394,11 @@ static unsigned long elf_map(struct file *filep, unsigned long addr,
>  	return(map_addr);
>  }
>  
> +/*
> + * Map "eppnt->p_filesz" bytes from "filep" offset "eppnt->p_offset"
> + * into memory at "addr". Memory from "p_filesz" through "p_memsz"
> + * rounded up to the next page is zeroed.
> + */
>  static unsigned long elf_load(struct file *filep, unsigned long addr,
>  		const struct elf_phdr *eppnt, int prot, int type,
>  		unsigned long total_size)
> @@ -405,7 +417,8 @@ static unsigned long elf_load(struct file *filep, unsigned long addr,
>  				eppnt->p_memsz;
>  
>  			/* Zero the end of the last mapped page */
> -			padzero(zero_start);
> +			if (padzero(zero_start, prot))
> +				return -EFAULT;
>  		}
>  	} else {
>  		map_addr = zero_start = ELF_PAGESTART(addr);
> @@ -712,7 +725,7 @@ static unsigned long load_elf_interp(struct elfhdr *interp_elf_ex,
>  	 * the file up to the page boundary, and zero it from elf_bss
>  	 * up to the end of the page.
>  	 */
> -	if (padzero(elf_bss)) {
> +	if (padzero(elf_bss, bss_prot)) {
>  		error = -EFAULT;
>  		goto out;
>  	}
> @@ -1407,7 +1420,7 @@ static int load_elf_library(struct file *file)
>  		goto out_free_ph;
>  
>  	elf_bss = eppnt->p_vaddr + eppnt->p_filesz;
> -	if (padzero(elf_bss)) {
> +	if (padzero(elf_bss, PROT_WRITE)) {
>  		error = -EFAULT;
>  		goto out_free_ph;
>  	}
