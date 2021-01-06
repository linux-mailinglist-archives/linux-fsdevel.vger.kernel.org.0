Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 612E12EBF12
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Jan 2021 14:50:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727459AbhAFNpe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Jan 2021 08:45:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726709AbhAFNpd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Jan 2021 08:45:33 -0500
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71411C06135B;
        Wed,  6 Jan 2021 05:44:33 -0800 (PST)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kx96y-007MOe-Sh; Wed, 06 Jan 2021 13:44:28 +0000
Date:   Wed, 6 Jan 2021 13:44:28 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] binfmt_elf: Fix fill_prstatus() call in
 fill_note_info()
Message-ID: <20210106134428.GB3579531@ZenIV.linux.org.uk>
References: <20210106075112.1593084-1-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210106075112.1593084-1-geert@linux-m68k.org>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 06, 2021 at 08:51:12AM +0100, Geert Uytterhoeven wrote:
> On m68k, which does not define CORE_DUMP_USE_REGSET:
> 
>     fs/binfmt_elf.c: In function ‘fill_note_info’:
>     fs/binfmt_elf.c:2040:20: error: passing argument 1 of ‘fill_prstatus’ from incompatible pointer type [-Werror=incompatible-pointer-types]
>      2040 |  fill_prstatus(info->prstatus, current, siginfo->si_signo);
> 	  |                ~~~~^~~~~~~~~~
> 	  |                    |
> 	  |                    struct elf_prstatus *
>     fs/binfmt_elf.c:1498:55: note: expected ‘struct elf_prstatus_common *’ but argument is of type ‘struct elf_prstatus *’
>      1498 | static void fill_prstatus(struct elf_prstatus_common *prstatus,
> 	  |                           ~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~
> 
> The fill_prstatus() signature was changed, but one caller was not
> updated.
> 
> Reported-by: noreply@ellerman.id.au
> Fixes: 147d88b334cd5416 ("elf_prstatus: collect the common part (everything before pr_reg) into a struct")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
> Compile-tested only.  Feel free to fold into the original commit.

Thanks, folded and pushed out...
