Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0845641BA25
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Sep 2021 00:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243074AbhI1WW7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Sep 2021 18:22:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:52668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243073AbhI1WW5 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Sep 2021 18:22:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2F9D6613A5;
        Tue, 28 Sep 2021 22:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1632867677;
        bh=GbLld7FAg2taHDUAb/Jj//RLLzXibDSgRos/aDK5sSo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hnF/r2lvT4sNBb1FyCrA91j9fnOSo+GbWwFkuf7hholPz37lXws2Psk3Oi2pqKWEk
         XZ7k9PJ2fBL/qj30nMPbGt+Q5XNthvv4n+lvq+O/HfXoBuk0XqAVW1mZLj5C5yBpAc
         zRpoY3T+t+D2n4rqvoGtqkUrkdvKffX2L932jIgA=
Date:   Tue, 28 Sep 2021 15:21:16 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Chen Jingwen <chenjingwen6@huawei.com>
Cc:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Michal Hocko <mhocko@suse.com>,
        Andrei Vagin <avagin@openvz.org>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] elf: don't use MAP_FIXED_NOREPLACE for elf interpreter
 mappings
Message-Id: <20210928152116.347d5f0020e3cbb0192ebbff@linux-foundation.org>
In-Reply-To: <20210928125657.153293-1-chenjingwen6@huawei.com>
References: <20210928125657.153293-1-chenjingwen6@huawei.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

(cc Linus)

On Tue, 28 Sep 2021 20:56:57 +0800 Chen Jingwen <chenjingwen6@huawei.com> wrote:

> In commit b212921b13bd ("elf: don't use MAP_FIXED_NOREPLACE for elf executable mappings")
> we still leave MAP_FIXED_NOREPLACE in place for load_elf_interp.
> Unfortunately, this will cause kernel to fail to start with
> 
> [    2.384321] 1 (init): Uhuuh, elf segment at 00003ffff7ffd000 requested but the memory is mapped already
> [    2.386240] Failed to execute /init (error -17)
> 
> The reason is that the elf interpreter (ld.so) has overlapping segments.
> 
> readelf -l ld-2.31.so
> Program Headers:
>   Type           Offset             VirtAddr           PhysAddr
>                  FileSiz            MemSiz              Flags  Align
>   LOAD           0x0000000000000000 0x0000000000000000 0x0000000000000000
>                  0x000000000002c94c 0x000000000002c94c  R E    0x10000
>   LOAD           0x000000000002dae0 0x000000000003dae0 0x000000000003dae0
>                  0x00000000000021e8 0x0000000000002320  RW     0x10000
>   LOAD           0x000000000002fe00 0x000000000003fe00 0x000000000003fe00
>                  0x00000000000011ac 0x0000000000001328  RW     0x10000
> 
> The reason for this problem is the same as described in
> commit ad55eac74f20 ("elf: enforce MAP_FIXED on overlaying elf segments").
> Not only executable binaries, elf interpreters (e.g. ld.so) can have
> overlapping elf segments, so we better drop MAP_FIXED_NOREPLACE and go
> back to MAP_FIXED in load_elf_interp.
> 
> Fixes: 4ed28639519c ("fs, elf: drop MAP_FIXED usage from elf_map")
> Cc: <stable@vger.kernel.org> # v4.19
> Signed-off-by: Chen Jingwen <chenjingwen6@huawei.com>
> ---
>  fs/binfmt_elf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> index 69d900a8473d..a813b70f594e 100644
> --- a/fs/binfmt_elf.c
> +++ b/fs/binfmt_elf.c
> @@ -630,7 +630,7 @@ static unsigned long load_elf_interp(struct elfhdr *interp_elf_ex,
>  
>  			vaddr = eppnt->p_vaddr;
>  			if (interp_elf_ex->e_type == ET_EXEC || load_addr_set)
> -				elf_type |= MAP_FIXED_NOREPLACE;
> +				elf_type |= MAP_FIXED;
>  			else if (no_base && interp_elf_ex->e_type == ET_DYN)
>  				load_addr = -vaddr;
>  
> -- 
> 2.12.3
