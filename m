Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B16E1A9166
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Apr 2020 05:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389102AbgDODBw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Apr 2020 23:01:52 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:48503 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389084AbgDODBu (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Apr 2020 23:01:50 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4926Zd4FkSz9sQx;
        Wed, 15 Apr 2020 13:01:45 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1586919707;
        bh=wr6FGrvjjaQN2x9ODC6a9us38dRMb7OMhprJ91sYg7o=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=IJJ65I1WUYqc4ArGbU1X/J2cI7ABjrgXkwER3LkWC4g1d0oxCSmSADvRsSPRkyfYW
         gkIzCNUUmqgKBDk/clptOgDt8qrFrQ/GmY5fneVv1hTzmVXdk3bUY3CQqqE7LZH3vP
         obB2+RxmycGha1kc63WwQetad2T7/o6nzLvFd5Qk7Kg2srEAWZpEasVSiPb97+xIQj
         gQdlhbyvLAcBaHhR8xGrKoadcf2l6Bw0/XVO4ID1bl4Pp/E1XqhoM1P6Uaxfro8Zog
         2mABH0Xnzx4hIdz9OuqqreRCPhsHvdyT5pU58eVPxIdygYmHGDgi55lHNqeEKBAT7g
         S67EjCLBvl4yQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Jeremy Kerr <jk@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        linuxppc-dev@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/8] binfmt_elf: open code copy_siginfo_to_user to kernelspace buffer
In-Reply-To: <20200414070142.288696-5-hch@lst.de>
References: <20200414070142.288696-1-hch@lst.de> <20200414070142.288696-5-hch@lst.de>
Date:   Wed, 15 Apr 2020 13:01:59 +1000
Message-ID: <87y2qxih94.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christoph Hellwig <hch@lst.de> writes:

> Instead of messing with the address limit just open code the trivial
> memcpy + memset logic for the native version, and a call to
> to_compat_siginfo for the compat version.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/binfmt_elf.c        | 9 +++++----
>  fs/compat_binfmt_elf.c | 6 +++++-
>  2 files changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> index 13f25e241ac4..607c5a5f855e 100644
> --- a/fs/binfmt_elf.c
> +++ b/fs/binfmt_elf.c
> @@ -1553,15 +1553,16 @@ static void fill_auxv_note(struct memelfnote *note, struct mm_struct *mm)
>  	fill_note(note, "CORE", NT_AUXV, i * sizeof(elf_addr_t), auxv);
>  }
>  
> +#ifndef fill_siginfo_note
>  static void fill_siginfo_note(struct memelfnote *note, user_siginfo_t *csigdata,
>  		const kernel_siginfo_t *siginfo)
>  {
> -	mm_segment_t old_fs = get_fs();
> -	set_fs(KERNEL_DS);
> -	copy_siginfo_to_user((user_siginfo_t __user *) csigdata, siginfo);
> -	set_fs(old_fs);
> +	memcpy(csigdata, siginfo, sizeof(struct kernel_siginfo));
> +	memset((char *)csigdata + sizeof(struct kernel_siginfo), 0,
> +		SI_EXPANSION_SIZE);
>  	fill_note(note, "CORE", NT_SIGINFO, sizeof(*csigdata), csigdata);
>  }
> +#endif
>  
>  #define MAX_FILE_NOTE_SIZE (4*1024*1024)
>  /*
> diff --git a/fs/compat_binfmt_elf.c b/fs/compat_binfmt_elf.c
> index aaad4ca1217e..ab84e095618b 100644
> --- a/fs/compat_binfmt_elf.c
> +++ b/fs/compat_binfmt_elf.c
> @@ -39,7 +39,11 @@
>   */
>  #define user_long_t		compat_long_t
>  #define user_siginfo_t		compat_siginfo_t
> -#define copy_siginfo_to_user	copy_siginfo_to_user32
> +#define fill_siginfo_note(note, csigdata, siginfo)		\
> +do {									\
> +	to_compat_siginfo(csigdata, siginfo, compat_siginfo_flags());	\
> +	fill_note(note, "CORE", NT_SIGINFO, sizeof(*csigdata), csigdata); \
> +} while (0)

This doesn't build on ppc (cell_defconfig):

  ../fs/binfmt_elf.c: In function 'fill_note_info':
  ../fs/compat_binfmt_elf.c:44:39: error: implicit declaration of function 'compat_siginfo_flags'; did you mean 'to_compat_siginfo'? [-Werror=implicit-function-d
  eclaration]
    to_compat_siginfo(csigdata, siginfo, compat_siginfo_flags()); \
                                         ^~~~~~~~~~~~~~~~~~~~
  ../fs/binfmt_elf.c:1846:2: note: in expansion of macro 'fill_siginfo_note'
    fill_siginfo_note(&info->signote, &info->csigdata, siginfo);
    ^~~~~~~~~~~~~~~~~
  cc1: some warnings being treated as errors
  make[2]: *** [../scripts/Makefile.build:266: fs/compat_binfmt_elf.o] Error 1


I guess the empty version from kernel/signal.c needs to move into a
header somewhere.

cheers

