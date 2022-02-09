Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D47E34AE843
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Feb 2022 05:08:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346080AbiBIEIB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Feb 2022 23:08:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347390AbiBIDoU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Feb 2022 22:44:20 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0EFBC06174F;
        Tue,  8 Feb 2022 19:44:16 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5A33A210E8;
        Wed,  9 Feb 2022 03:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1644378255; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/cdzcXATInTTzE2SJ6+3y5cgkVoGHTC4gzNOh7oP0Z4=;
        b=j/X2z605NxlDQ4m7NJyLOw51/VyZ1uhBeSl6SZrjgMQYC1XlYkfo1kPu8mEknx5H86En32
        au45VCmpCxHR6P847+3cx8YRtojXLGxXAi69zpQx45/IZWQHsMHragZE10XXg644TbfFhV
        t6KUbSBBye/EPgahtqzlw+1FFR07ETo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 171DD1332F;
        Wed,  9 Feb 2022 03:44:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 7USBOY04A2LfPQAAMHmgww
        (envelope-from <jeffm@suse.com>); Wed, 09 Feb 2022 03:44:13 +0000
Message-ID: <c96031b4-b76d-d82c-e232-1cccbbf71946@suse.com>
Date:   Tue, 8 Feb 2022 22:44:12 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Content-Language: en-US
To:     Richard Guy Briggs <rgb@redhat.com>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Paris <eparis@redhat.com>, Tony Jones <tonyj@suse.de>
References: <cover.1621363275.git.rgb@redhat.com>
 <f5f1a4d8699613f8c02ce762807228c841c2e26f.1621363275.git.rgb@redhat.com>
From:   Jeff Mahoney <jeffm@suse.com>
Subject: Re: [PATCH v4 2/3] audit: add support for the openat2 syscall
In-Reply-To: <f5f1a4d8699613f8c02ce762807228c841c2e26f.1621363275.git.rgb@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Richard -

On 5/19/21 16:00, Richard Guy Briggs wrote:
> The openat2(2) syscall was added in kernel v5.6 with commit fddb5d430ad9
> ("open: introduce openat2(2) syscall")
> 
> Add the openat2(2) syscall to the audit syscall classifier.
> 
> Link: https://github.com/linux-audit/audit-kernel/issues/67
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> Link: https://lore.kernel.org/r/f5f1a4d8699613f8c02ce762807228c841c2e26f.1621363275.git.rgb@redhat.com
> ---

[...]

> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index d775ea16505b..3f59ab209dfd 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -76,6 +76,7 @@
>  #include <linux/fsnotify_backend.h>
>  #include <uapi/linux/limits.h>
>  #include <uapi/linux/netfilter/nf_tables.h>
> +#include <uapi/linux/openat2.h>
>  
>  #include "audit.h"
>  
> @@ -196,6 +197,8 @@ static int audit_match_perm(struct audit_context *ctx, int mask)
>  		return ((mask & AUDIT_PERM_WRITE) && ctx->argv[0] == SYS_BIND);
>  	case AUDITSC_EXECVE:
>  		return mask & AUDIT_PERM_EXEC;
> +	case AUDITSC_OPENAT2:
> +		return mask & ACC_MODE((u32)((struct open_how *)ctx->argv[2])->flags);
>  	default:
>  		return 0;
>  	}

ctx->argv[2] holds a userspace pointer and can't be dereferenced like this.

I'm getting oopses, like so:
BUG: unable to handle page fault for address: 00007fff961bbe70

#PF: supervisor read access in kernel mode

#PF: error_code(0x0001) - permissions violation

PGD 8000000132291067 P4D 8000000132291067 PUD 132174067 PMD 132bb1067
PTE 800000013be02867

Oops: 0001 [#1] PREEMPT SMP PTI

CPU: 1 PID: 4525 Comm: a.out Kdump: loaded Not tainted 5.16.4-1-default
#1 openSUSE Tumbleweed f35df798c13cc3a259a6bf2924380af618948152

Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
rel-1.14.0-0-g155821a-rebuilt.opensuse.org 04/01/2014

RIP: 0010:audit_filter_rules.constprop.0+0x97e/0x1220

Code: 41 21 c5 41 83 7f 18 01 0f 85 5f f7 ff ff e9 65 f9 ff ff 83 f8 05
0f 84 5f 06 00 00 83 f8 06 0f 85 03 02 00 00 49 8b 44 24 40 <48> 8b 00
83 e0 03 0f be 80 c5 5e 45 86 41 21 c5 eb c7 4d 85 e4 0f

RSP: 0018:ffffb096403cbe08 EFLAGS: 00010246

RAX: 00007fff961bbe70 RBX: 0000000000000001 RCX: 000000000000001f

RDX: 0000000000000006 RSI: 00000000000001b5 RDI: 00000000c000003e

RBP: ffff9cb784a85020 R08: ffff9cb78775c380 R09: ffff9cb790ad9eb8

R10: 0000000040000020 R11: ffff9cb783f7b410 R12: ffff9cb78486dc00

R13: 000000000000000f R14: 00000000000001b5 R15: ffff9cb78775c380

FS:  00007ff21fca9740(0000) GS:ffff9cb7ffd00000(0000) knlGS:0000000000000000

CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033

CR2: 00007fff961bbe70 CR3: 0000000121264002 CR4: 0000000000370ee0

DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000

DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

Call Trace:

 <TASK>

 audit_filter_syscall+0xb0/0x100

 ? do_sys_openat2+0x81/0x160

 __audit_syscall_exit+0x69/0xf0

 syscall_exit_to_user_mode_prepare+0x14d/0x180

 syscall_exit_to_user_mode+0x9/0x40

 do_syscall_64+0x69/0x80

 ? syscall_exit_to_user_mode+0x18/0x40

 ? do_syscall_64+0x69/0x80

 entry_SYSCALL_64_after_hwframe+0x44/0xae

RIP: 0033:0x7ff21fdd195d


Where the faulting address matches the open_how address printed with the
following test using a "-w /var/tmp/testfile -k openat2-oops" audit rule.

#include <fcntl.h>

#include <linux/openat2.h>

#include <sys/syscall.h>

#include <unistd.h>

#include <stdio.h>



long openat2(int dirfd, const char *pathname, struct open_how *how,
size_t size)

{

       return  syscall(SYS_openat2, dirfd, pathname, how, size);

}



int

main(void)

{

        struct open_how how = {

                .flags = O_RDONLY|O_DIRECTORY,

        };



        int fd;



        fprintf(stderr, "&how = %p\n", &how);



        fd = openat2(AT_FDCWD, "/var/tmp/testfile", &how, sizeof(struct
open_how));

        perror("openat2");

}


$ mkdir /var/tmp/testfile
$ ./a.out

&how = 0x7fff961bbe70

<crash>

-Jeff

-- 
Jeff Mahoney
Director, SUSE Labs Data & Performance
