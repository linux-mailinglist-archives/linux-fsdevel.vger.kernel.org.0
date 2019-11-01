Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F8F9ECA06
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2019 21:57:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbfKAU5o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Nov 2019 16:57:44 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:35160 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbfKAU5n (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Nov 2019 16:57:43 -0400
Received: by mail-oi1-f195.google.com with SMTP id n16so9325776oig.2;
        Fri, 01 Nov 2019 13:57:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B2Wo++qvCAWopO2MVN1SxMuOaw9O5ooxGYbXrtTGoLc=;
        b=JnPKRmD8EH+YTuMKNidCmXHCX/xkxCn1I5n0S0B4DX7PNVRwaflaqlbaRoR3ijfKYy
         buUgt6M5ddeaC6dTS2u+uBTqyp2BQ8o5sw56Zgrp8LRUgCmlgengvLZ7aHNN2BPgC3xf
         n2hnXEcOkD7OoG1RxTgiLd/OsAO6tFtLyHFOuv+QbfPI61W37ATcc2PLDUe0tEYWs4l9
         ZB8fmWRLSS3ZeAAjaLikBXOIATdnibwsKMtaMc9npj1IEkPya28MPDALPjcIXKvIevIP
         8zF/pTKFCAxK+G5JpswJvCoWHo8KVccNusSQfrGFp9kW1Rua+Vs4iZObJq74YUKQBXEE
         TdQg==
X-Gm-Message-State: APjAAAXitYPQXSYdzk7bUFE86PsG8V12cHlWtzVZg6VmLLBFZNNt2UYl
        g9sr2isaukLaVAAL6k2OpNDXGWMPmjI5F4gjpko=
X-Google-Smtp-Source: APXvYqyMPGVgSghm8B6Z8BliWMbf63SJMtQqkLmxrpCWnOLjhSTH18y22Nnv6Mk4zTGM1EgQgPb5eF27WcBVRETo4XE=
X-Received: by 2002:a05:6808:60a:: with SMTP id y10mr3730740oih.102.1572641862721;
 Fri, 01 Nov 2019 13:57:42 -0700 (PDT)
MIME-Version: 1.0
References: <20191031010736.113783-1-Valdis.Kletnieks@vt.edu>
In-Reply-To: <20191031010736.113783-1-Valdis.Kletnieks@vt.edu>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 1 Nov 2019 21:57:31 +0100
Message-ID: <CAMuHMdXzyVBa4TZEc5eRaBzu50thgJ2TrHJLZqwhbQ=JASgWOA@mail.gmail.com>
Subject: Re: [RFC] errno.h: Provide EFSCORRUPTED for everybody
To:     Valdis Kletnieks <valdis.kletnieks@vt.edu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, Jan Kara <jack@suse.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        driverdevel <devel@driverdev.osuosl.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-erofs@lists.ozlabs.org,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        Linux-Arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Valdis,

On Thu, Oct 31, 2019 at 2:11 AM Valdis Kletnieks
<valdis.kletnieks@vt.edu> wrote:
> Three questions: (a) ACK/NAK on this patch, (b) should it be all in one
> patch, or one to add to errno.h and 6 patches for 6 filesystems?), and
> (c) if one patch, who gets to shepherd it through?
>
> There's currently 6 filesystems that have the same #define. Move it
> into errno.h so it's defined in just one place.
>
> Signed-off-by: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>

Thanks for your patch!

> --- a/include/uapi/asm-generic/errno.h
> +++ b/include/uapi/asm-generic/errno.h
> @@ -98,6 +98,7 @@
>  #define        EINPROGRESS     115     /* Operation now in progress */
>  #define        ESTALE          116     /* Stale file handle */
>  #define        EUCLEAN         117     /* Structure needs cleaning */
> +#define        EFSCORRUPTED    EUCLEAN

I have two questions:
a) Why not use EUCLEAN everywhere instead?
    Having two different names for the same errno complicates grepping.
b) Perhaps both errors should use different values? Do they have the
   same semantics? I'm not a fs developer, so this is a bit fuzzy to me.
   According to Documentation/, one seems to originate in mtd, the
   other in xfs.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
