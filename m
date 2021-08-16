Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE0733ECE37
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Aug 2021 08:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233116AbhHPGA6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Aug 2021 02:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231680AbhHPGAt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Aug 2021 02:00:49 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39AE6C061764
        for <linux-fsdevel@vger.kernel.org>; Sun, 15 Aug 2021 22:59:39 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id c8-20020a7bc008000000b002e6e462e95fso1307587wmb.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 15 Aug 2021 22:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=jqBY/ebZYRvdLqk7Wp1d8f7rPHyH1R6AhCB+qEOVxBk=;
        b=Glpr0hJZ91J8FXz/69q+WNxyCYHKJuYOVUSNs/S6JJFDpVcBfcWeGeEQABi2hsqiVh
         vRJPABKgXnoNDdoC9CzoTQPIxCozwRu69kRZE7y3bFnJuMeSsvpyGnpPl19U1YnATryy
         +AxtshNrCHt2j8V6vODYk64hckG8BgP4kPAcP3obm5qzzSozeHqWu4rGW64K6s33N5NA
         Bkv7q24eelzXdkrJETFGqYl2TJvcOBEEC6FWBilwEHAjtOwTRNLGEieqKAvkF1QhE1Wt
         zGrr2JM4dEY0fw0O1J4Y97S5k1UZNsPF+WP0KOKgAchq8inB7L8vQ4AaNUcwVtzLItmi
         jJvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=jqBY/ebZYRvdLqk7Wp1d8f7rPHyH1R6AhCB+qEOVxBk=;
        b=MLpvyIiTqEj6/24eENm50Yl4+pEsKgSea717PG+oTw6ZCetomu8uNI/u0Mxh+RvGP2
         Vu5VOIjTpn7bSERiMqVxjgiVHpRAivkQQ7s74G/3gwmXB2kIQdqo7+/cHhqXJoG6lmpB
         DzUamkoHbKMizVBn0fwCwpIROazorPxbIFmDmFoXzBkEuDl4iWc8SdKXeTcWrS5C4WXr
         u098NOg1u+V98OZb5lAtj2E2KPw/DNc1YS2ibciV5wpevTLFxp261tVo3oLtLNCC/GM5
         jRCFjp02B1qIehlicF/gsQ9QKYAsyjeE020vNwdHWLpL5E0hPdpKqRcXwzAX7xg4LKuS
         yx/w==
X-Gm-Message-State: AOAM5301a3uLreIBHgBlRXiU4K2+ihHGfZTAx15ABVHEuwCBGl7MsKLd
        aStySNVRQ34SrxgshRR2Ge4XofoId5Q=
X-Google-Smtp-Source: ABdhPJwMCoCSOLikLsqMteInPRSqQ+xQdjKVRQpT3qzIPgO62sh0Su0wGTqRf/SOA11bnSCD8kF+9Q==
X-Received: by 2002:a1c:8093:: with SMTP id b141mr13320314wmd.177.1629093577580;
        Sun, 15 Aug 2021 22:59:37 -0700 (PDT)
Received: from itaypc ([176.228.32.241])
        by smtp.gmail.com with ESMTPSA id p6sm10094576wrw.50.2021.08.15.22.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Aug 2021 22:59:37 -0700 (PDT)
Date:   Mon, 16 Aug 2021 07:50:39 +0300
From:   Itay Iellin <ieitayie@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     torvalds@linuxfoundation.org, greg@kroah.com,
        ebiederm@xmission.com, security@kernel.org,
        viro@zeniv.linux.org.uk, jannh@google.com
Subject: fs/binfmt_elf: Integer Overflow vulnerability report
Message-ID: <YRnun9418g70VyJT@itaypc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Bcc: 
Subject: fs/binfmt_elf: Integer Overflow vulnerability report
Reply-To: 
I'm sharing a report of an integer overflow vulnerability I found (in 
fs/binfmt_elf.c). I sent and discussed this vulnerability report with members
of security@kernel.org. I'm raising this for public discussion, with approval
from Greg (greg@kroah.com).

On Sun, Aug 01, 2021 at 04:30:30PM +0300, Itay Iellin wrote:
> In fs/binfmt_elf.c, line 1193, e_entry value can be overflowed. This
> potentially allows to create a fake entry point field for an ELF file.
> 
> The local variable e_entry is set to elf_ex->e_entry + load_bias.
> Given an ET_DYN ELF file, without a PT_INTERP program header, with an 
> elf_ex->e_entry field in the ELF header, which equals to
> 0xffffffffffffffff(in x86_64 for example), and a load_bias which is greater 
> than 0, e_entry(the local variable) overflows. This bypasses the check of 
> BAD_ADDR macro in line 1241.
> 
> It is possible to set a large enough NO-OP(NOP) sled, before the
> actual code, modify the elf_ex->e_entry field so that elf_ex->e_entry+load_bias
> will be in the range where the NO-OP sled is mapped(because the offset
> of the PT_LOAD program header of the text segment can be controlled). 
> This is practically a guess, because load_bias is randomized, the ELF file can
> be loaded a large amount of times until elf_ex->e_entry + load_bias 
> is in the range of the NO-OP sled.
> To conclude, this bug potentially allows the creation of a "fake" entry point
> field in the ELF file header. 
> 
> Suggested git diff:
> 
> Add a BAD_ADDR test to elf_ex->e_entry to prevent from using an
> overflowed elf_entry value.
> 
> Signed-off-by: Itay Iellin <ieitayie@gmail.com>
> ---
>  fs/binfmt_elf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> index 439ed81e755a..b59dcd5857db 100644
> --- a/fs/binfmt_elf.c
> +++ b/fs/binfmt_elf.c
> @@ -1238,7 +1238,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
>  		kfree(interp_elf_phdata);
>  	} else {
>  		elf_entry = e_entry;
> -		if (BAD_ADDR(elf_entry)) {
> +		if (BAD_ADDR(elf_entry) || BAD_ADDR(elf_ex->e_entry)) {
>  			retval = -EINVAL;
>  			goto out_free_dentry;
>  		}
> -- 
> 2.32.0
> 

I am not attaching the replies to my initial report from the discussion with
members of security@kernel.org, only when or if I will be given permission
from the repliers to do so.

Itay Iellin
