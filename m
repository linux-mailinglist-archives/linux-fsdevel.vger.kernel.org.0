Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3443724CBA6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Aug 2020 05:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbgHUDvS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Aug 2020 23:51:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:36158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727050AbgHUDvS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Aug 2020 23:51:18 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB25F2076E;
        Fri, 21 Aug 2020 03:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597981877;
        bh=P/+5Iuw27xx7rvW/RiUtG3rRebK71DLY9gVtxYSoVmk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tvzMiECk3m9ZrFgL9jWU3YPIwWqO83e0eOBZI8fT7UYKgOTTR5tOcQrywMwXnaGtR
         nDISKx6Es41eovSWj2Y0XN+e+eoPyOdfpwZ8ullZrFDFb1avY/rQTke0Ei0HkLDdw3
         6hMahyJROMnAZr9c5fAW4e80s2tqTFEbOhlyxuyM=
Date:   Thu, 20 Aug 2020 20:51:16 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Chris Kennelly <ckennelly@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Song Liu <songliubraving@fb.com>,
        David Rientjes <rientjes@google.com>,
        Ian Rogers <irogers@google.com>,
        Hugh Dickens <hughd@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Fangrui Song <maskray@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] fs/binfmt_elf: Use PT_LOAD p_align values for
 suitable start address.
Message-Id: <20200820205116.3467a186cb4ac20342f0ee4b@linux-foundation.org>
In-Reply-To: <20200820170541.1132271-2-ckennelly@google.com>
References: <20200820170541.1132271-1-ckennelly@google.com>
        <20200820170541.1132271-2-ckennelly@google.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 20 Aug 2020 13:05:40 -0400 Chris Kennelly <ckennelly@google.com> wrote:

> The current ELF loading mechancism provides page-aligned mappings.  This
> can lead to the program being loaded in a way unsuitable for
> file-backed, transparent huge pages when handling PIE executables.
> 
> For binaries built with increased alignment, this limits the number of
> bits usable for ASLR, but provides some randomization over using fixed
> load addresses/non-PIE binaries.
> 
> @@ -421,6 +422,24 @@ static int elf_read(struct file *file, void *buf, size_t len, loff_t pos)
>  	return 0;
>  }
>  
> +static unsigned long maximum_alignment(struct elf_phdr *cmds, int nr)
> +{
> +	unsigned long alignment = 0;
> +	int i;
> +
> +	for (i = 0; i < nr; i++) {
> +		if (cmds[i].p_type == PT_LOAD) {
> +			/* skip non-power of two alignments */

Comment isn't terribly helpful.  It explains "what" (which is utterly
obvious from the code anyway) but it fails to explain "why".

> +			if (!is_power_of_2(cmds[i].p_align))
> +				continue;
> +			alignment = max(alignment, cmds[i].p_align);

generates a max() warning:

fs/binfmt_elf.c:435:16: note: in expansion of macro `max'
    alignment = max(alignment, cmds[i].p_align);

p_align may be Elf64_Xword, may be Elf32_Word, may be something else. 
That's quite unwieldy and I don't like max_t.  How about this?

--- a/fs/binfmt_elf.c~fs-binfmt_elf-use-pt_load-p_align-values-for-suitable-start-address-fix
+++ a/fs/binfmt_elf.c
@@ -429,10 +429,12 @@ static unsigned long maximum_alignment(s
 
 	for (i = 0; i < nr; i++) {
 		if (cmds[i].p_type == PT_LOAD) {
+			unsigned long p_align = cmds[i].p_align;
+
 			/* skip non-power of two alignments */
-			if (!is_power_of_2(cmds[i].p_align))
+			if (!is_power_of_2(p_align))
 				continue;
-			alignment = max(alignment, cmds[i].p_align);
+			alignment = max(alignment, p_align);
 		}
 	}
 
_

