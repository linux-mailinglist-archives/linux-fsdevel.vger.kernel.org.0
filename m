Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2A704A4B34
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jan 2022 17:04:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380013AbiAaQEU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jan 2022 11:04:20 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:42236 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380008AbiAaQEO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jan 2022 11:04:14 -0500
Received: from in02.mta.xmission.com ([166.70.13.52]:59860)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nEZA5-00HCAt-KS; Mon, 31 Jan 2022 09:04:13 -0700
Received: from ip68-110-24-146.om.om.cox.net ([68.110.24.146]:48638 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nEZA3-007DnS-4X; Mon, 31 Jan 2022 09:04:13 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Denys Vlasenko <vda.linux@googlemail.com>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@Oracle.com>
References: <20220131153740.2396974-1-willy@infradead.org>
Date:   Mon, 31 Jan 2022 10:03:31 -0600
In-Reply-To: <20220131153740.2396974-1-willy@infradead.org> (Matthew Wilcox's
        message of "Mon, 31 Jan 2022 15:37:40 +0000")
Message-ID: <871r0nriy4.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nEZA3-007DnS-4X;;;mid=<871r0nriy4.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.110.24.146;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+pHxZIM9Z0F/v54hDEFvV4FtGm43/Bzjs=
X-SA-Exim-Connect-IP: 68.110.24.146
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa05.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMSubLong autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa05 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa05 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;"Matthew Wilcox (Oracle)" <willy@infradead.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1874 ms - load_scoreonly_sql: 0.11 (0.0%),
        signal_user_changed: 10 (0.6%), b_tie_ro: 9 (0.5%), parse: 0.76 (0.0%),
         extract_message_metadata: 9 (0.5%), get_uri_detail_list: 1.28 (0.1%),
        tests_pri_-1000: 13 (0.7%), tests_pri_-950: 1.03 (0.1%),
        tests_pri_-900: 0.83 (0.0%), tests_pri_-90: 95 (5.1%), check_bayes: 93
        (5.0%), b_tokenize: 6 (0.3%), b_tok_get_all: 6 (0.3%), b_comp_prob:
        2.1 (0.1%), b_tok_touch_all: 74 (4.0%), b_finish: 0.80 (0.0%),
        tests_pri_0: 1726 (92.1%), check_dkim_signature: 0.49 (0.0%),
        check_dkim_adsp: 2.8 (0.1%), poll_dns_idle: 1.04 (0.1%), tests_pri_10:
        2.6 (0.1%), tests_pri_500: 13 (0.7%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] binfmt_elf: Take the mmap lock when walking the VMA list
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

"Matthew Wilcox (Oracle)" <willy@infradead.org> writes:

> I'm not sure if the VMA list can change under us, but dump_vma_snapshot()
> is very careful to take the mmap_lock in write mode.  We only need to
> take it in read mode here as we do not care if the size of the stack
> VMA changes underneath us.
>
> If it can be changed underneath us, this is a potential use-after-free
> for a multithreaded process which is dumping core.

The problem is not multi-threaded process so much as processes that
share their mm.

I think rather than take a lock we should be using the snapshot captured
with dump_vma_snapshot.  Otherwise we have the very real chance that the
two get out of sync.  Which would result in a non-sense core file.

Probably that means that dump_vma_snapshot needs to call get_file on
vma->vm_file store it in core_vma_metadata.

Do you think you can fix it something like that?

Eric


> Fixes: 2aa362c49c31 ("coredump: extend core dump note section to contain file names of mapped files")
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> ---
>  fs/binfmt_elf.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> index 605017eb9349..dc2318355762 100644
> --- a/fs/binfmt_elf.c
> +++ b/fs/binfmt_elf.c
> @@ -1651,6 +1651,7 @@ static int fill_files_note(struct memelfnote *note)
>  	name_base = name_curpos = ((char *)data) + names_ofs;
>  	remaining = size - names_ofs;
>  	count = 0;
> +	mmap_read_lock(mm);
>  	for (vma = mm->mmap; vma != NULL; vma = vma->vm_next) {
>  		struct file *file;
>  		const char *filename;
> @@ -1661,6 +1662,7 @@ static int fill_files_note(struct memelfnote *note)
>  		filename = file_path(file, name_curpos, remaining);
>  		if (IS_ERR(filename)) {
>  			if (PTR_ERR(filename) == -ENAMETOOLONG) {
> +				mmap_read_unlock(mm);
>  				kvfree(data);
>  				size = size * 5 / 4;
>  				goto alloc;
> @@ -1680,6 +1682,7 @@ static int fill_files_note(struct memelfnote *note)
>  		*start_end_ofs++ = vma->vm_pgoff;
>  		count++;
>  	}
> +	mmap_read_unlock(mm);
>  
>  	/* Now we know exact count of files, can store it */
>  	data[0] = count;
