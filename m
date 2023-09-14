Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75CE37A0E82
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Sep 2023 21:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233122AbjINTuX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Sep 2023 15:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjINTuW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Sep 2023 15:50:22 -0400
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 545AD26AB;
        Thu, 14 Sep 2023 12:50:18 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:38982)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qgsLn-00GZhg-4r; Thu, 14 Sep 2023 13:50:07 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:33022 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qgsLl-003z6W-RZ; Thu, 14 Sep 2023 13:50:06 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Mark Brown <broonie@kernel.org>, Willy Tarreau <w@1wt.eu>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Sebastian Ott <sebott@redhat.com>,
        stable@vger.kernel.org
References: <20230914-bss-alloc-v1-1-78de67d2c6dd@weissschuh.net>
Date:   Thu, 14 Sep 2023 14:49:44 -0500
In-Reply-To: <20230914-bss-alloc-v1-1-78de67d2c6dd@weissschuh.net> ("Thomas
        =?utf-8?Q?Wei=C3=9Fschuh=22's?= message of "Thu, 14 Sep 2023 17:59:21
 +0200")
Message-ID: <87fs3gwn53.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1qgsLl-003z6W-RZ;;;mid=<87fs3gwn53.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX18h1j36igoeR9FeBDXb/u1JtAQea+Mzym8=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,LotsOfNums_01,T_TM2_M_HEADER_IN_MSG,XM_B_Unicode,
        XM_Multi_Part_URI shortcircuit=no autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.2 LotsOfNums_01 BODY: Lots of long strings of numbers
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.0 XM_B_Unicode BODY: Testing for specific types of unicode
        *  1.2 XM_Multi_Part_URI URI: Long-Multi-Part URIs
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: =?ISO-8859-1?Q?**;Thomas Wei=c3=9fschuh <linux@weissschuh.net>?=
X-Spam-Relay-Country: 
X-Spam-Timing: total 542 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 10 (1.9%), b_tie_ro: 9 (1.6%), parse: 1.00 (0.2%),
         extract_message_metadata: 17 (3.1%), get_uri_detail_list: 2.7 (0.5%),
        tests_pri_-2000: 10 (1.8%), tests_pri_-1000: 2.4 (0.5%),
        tests_pri_-950: 1.17 (0.2%), tests_pri_-900: 1.00 (0.2%),
        tests_pri_-200: 0.78 (0.1%), tests_pri_-100: 14 (2.7%), tests_pri_-90:
        66 (12.3%), check_bayes: 65 (11.9%), b_tokenize: 10 (1.9%),
        b_tok_get_all: 12 (2.2%), b_comp_prob: 4.0 (0.7%), b_tok_touch_all: 35
        (6.4%), b_finish: 0.94 (0.2%), tests_pri_0: 362 (66.7%),
        check_dkim_signature: 0.56 (0.1%), check_dkim_adsp: 1.89 (0.3%),
        poll_dns_idle: 42 (7.8%), tests_pri_10: 1.98 (0.4%), tests_pri_500: 52
        (9.5%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH RFC] binfmt_elf: fully allocate bss pages
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Thomas Weißschuh <linux@weissschuh.net> writes:

> When allocating the pages for bss the start address needs to be rounded
> down instead of up.
> Otherwise the start of the bss segment may be unmapped.
>
> The was reported to happen on Aarch64:

Those program headers you quote look corrupt.

The address 0x41ffe8 is not 0x10000 aligned.

I don't think anything in the elf specification allows that.

The most common way to have bss is for a elf segment to have a larger
memsize than filesize.  In which case rounding up is the correct way to
handle things.

We definitely need to verify the appended bss case works, before
taking this patch, or we will get random application failures
because parts of the data segment are being zeroed, or the binaries
won't load because the bss won't be able to map over the initialized data.


The note segment living at a conflicting virtual address also looks
suspicious.   It is probably harmless, as note segments are not
loaded.


Are you by any chance using an experimental linker?


In general every segment in an elf executable needs to be aligned to the
SYSVABI's architecture page size.  I think that is 64k on ARM.  Which it
looks like the linker tried to implement by setting the alignment to
0x10000, and then ignored by putting a byte offset beginning to the
page.

At a minimum someone needs to sort through what the elf specification
says needs to happen is a weird case like this where the start address
of a load segment does not match the alignment of the segment.

To see how common this is I looked at a binary known to be working, and
my /usr/bin/ls binary has one segment that has one of these unaligned
starts as well.

So it must be defined to work somewhere but I need to see the definition
to even have a good opinion on the nonsense of saying an unaligned value
should be aligned.


All I know is that we need to limit our support to what memory mapping
pieces from the elf executable can support.  Which at a minimum requires:
	virt_addr % ELF_MIN_ALIGN == file_offset % ELF_MIN_ALIGN



Eric










> Memory allocated by set_brk():
> Before: start=0x420000 end=0x420000
> After:  start=0x41f000 end=0x420000
>
> The triggering binary looks like this:
>
>     Elf file type is EXEC (Executable file)
>     Entry point 0x400144
>     There are 4 program headers, starting at offset 64
>
>     Program Headers:
>       Type           Offset             VirtAddr           PhysAddr
>                      FileSiz            MemSiz              Flags  Align
>       LOAD           0x0000000000000000 0x0000000000400000 0x0000000000400000
>                      0x0000000000000178 0x0000000000000178  R E    0x10000
>       LOAD           0x000000000000ffe8 0x000000000041ffe8 0x000000000041ffe8
>                      0x0000000000000000 0x0000000000000008  RW     0x10000
>       NOTE           0x0000000000000120 0x0000000000400120 0x0000000000400120
>                      0x0000000000000024 0x0000000000000024  R      0x4
>       GNU_STACK      0x0000000000000000 0x0000000000000000 0x0000000000000000
>                      0x0000000000000000 0x0000000000000000  RW     0x10
>
>      Section to Segment mapping:
>       Segment Sections...
>        00     .note.gnu.build-id .text .eh_frame
>        01     .bss
>        02     .note.gnu.build-id
>        03
>
> Reported-by: Sebastian Ott <sebott@redhat.com>
> Closes: https://lore.kernel.org/lkml/5d49767a-fbdc-fbe7-5fb2-d99ece3168cb@redhat.com/
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> ---
>
> I'm not really familiar with the ELF loading process, so putting this
> out as RFC.
>
> A example binary compiled with aarch64-linux-gnu-gcc 13.2.0 is available
> at https://test.t-8ch.de/binfmt-bss-repro.bin
> ---
>  fs/binfmt_elf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> index 7b3d2d491407..4008a57d388b 100644
> --- a/fs/binfmt_elf.c
> +++ b/fs/binfmt_elf.c
> @@ -112,7 +112,7 @@ static struct linux_binfmt elf_format = {
>  
>  static int set_brk(unsigned long start, unsigned long end, int prot)
>  {
> -	start = ELF_PAGEALIGN(start);
> +	start = ELF_PAGESTART(start);
>  	end = ELF_PAGEALIGN(end);
>  	if (end > start) {
>  		/*
>
> ---
> base-commit: aed8aee11130a954356200afa3f1b8753e8a9482
> change-id: 20230914-bss-alloc-f523fa61718c
>
> Best regards,
