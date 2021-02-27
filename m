Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3B8326DB4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Feb 2021 17:01:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbhB0QBE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 27 Feb 2021 11:01:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbhB0QBB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 27 Feb 2021 11:01:01 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0601C06174A;
        Sat, 27 Feb 2021 08:00:16 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id g9so10817760ilc.3;
        Sat, 27 Feb 2021 08:00:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nio1yNQi+L2wva6nOc/JRBtmUWzhDNBBQaxudgLnaIo=;
        b=IbQOFIbb/NvHsDc08ZelP5ChJ9w/ERd7kgqSNDRUYPb3/4ehMQiH2NBLwycELfsSk9
         KkCG/5b94nIdkzVYIcXzWOC9HLr/vbgvHmxdqpx9R92KgchtekSUW8xT1CU8bhq1O6CE
         jJAFv9aIgCwActde1Hk40njk7UHQzZBD9486E/siypZAIheIGGfx2u1vMGFDRBZ3usib
         7aHwH0Qfn/CACwJR9zg7W3N4R4UQrQlz8sMHnZYLox1iqFunI1nRbsGNZmhDuzTjJGCT
         nn9eapBAXo4814BSW0LzmrsR+vW2/myYFA/q8TKlr3YUQJo1qcfVregquYVuzmkgY3HR
         AvaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nio1yNQi+L2wva6nOc/JRBtmUWzhDNBBQaxudgLnaIo=;
        b=twzUBvW50Ie9FDaxJdg0BRjpRW50VgmPpQzKWPcuCRSbl87/bO8kcTVP7I8SWe31Pm
         cRtueR77WYYT4yziFPHoKBAOyhEivvHD68wzP2eo9EybKuoIk9OI3W++mPMkLY/LEyU7
         eHNiT4RdGjrXIDDYkITfO0WBaki0T5MD106Xt5UyhWwlbKhdXNDPPjiyVBlrReigfqzE
         1GWMevBK6ku/ZuKAY/YFdmESmVy5+YbfS5isQlh49uCEKpv7NZMRnHX3006qPm+lhXx4
         Q6CTkrxLArtGMviXN7dImEOMm3OetBHcq2nM7xHRMxfV47VsyL/DFrljEaLhKt39AOyR
         8bng==
X-Gm-Message-State: AOAM530ShCA4JQyZHAm/Ki3iKUuIlDi0wGnN+KMF2x35T2bB5cGssz12
        KkJQwkC4zkLlapTe64HqH/5yuHEr5U9XtoCucQ4=
X-Google-Smtp-Source: ABdhPJwlgEUnS9h4M6Am2vjE9GmLbWA2lA5Hcn+o+/drCgHyk5bW/DP+6IDbeUyESOgsO3mQ2mzzIFHeB3dnGcwCl14=
X-Received: by 2002:a92:2c08:: with SMTP id t8mr6730444ile.72.1614441616259;
 Sat, 27 Feb 2021 08:00:16 -0800 (PST)
MIME-Version: 1.0
References: <ffd92bb4-8f72-cbec-045f-a2ad7869ab3b@gmail.com> <20210227134922.5706-1-alx.manpages@gmail.com>
In-Reply-To: <20210227134922.5706-1-alx.manpages@gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 27 Feb 2021 18:00:04 +0200
Message-ID: <CAOQ4uxiGaMxUfFFo=GmH60-8SA6Lc0k_Op7jfneKFx1NmF=BsQ@mail.gmail.com>
Subject: Re: [RFC v2] copy_file_range.2: Update cross-filesystem support for 5.12
To:     Alejandro Colomar <alx.manpages@gmail.com>
Cc:     Michael Kerrisk <mtk.manpages@gmail.com>,
        linux-man <linux-man@vger.kernel.org>,
        Luis Henriques <lhenriques@suse.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Jeff Layton <jlayton@kernel.org>,
        Steve French <sfrench@samba.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dave Chinner <dchinner@redhat.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Ian Lance Taylor <iant@google.com>,
        Luis Lozano <llozano@chromium.org>,
        Andreas Dilger <adilger@dilger.ca>,
        Olga Kornievskaia <aglo@umich.edu>,
        Christoph Hellwig <hch@infradead.org>,
        ceph-devel <ceph-devel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Walter Harms <wharms@bfs.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Feb 27, 2021 at 3:59 PM Alejandro Colomar
<alx.manpages@gmail.com> wrote:
>
> Linux 5.12 fixes a regression.
>
> Cross-filesystem copies (introduced in 5.3) were buggy.
>
> Move the statements documenting cross-fs to BUGS.
> Kernels 5.3..5.11 should be patched soon.
>
> State version information for some errors related to this.
>
> Reported-by: Luis Henriques <lhenriques@suse.de>
> Reported-by: Amir Goldstein <amir73il@gmail.com>
> Related: <https://lwn.net/Articles/846403/>
> Cc: Greg KH <gregkh@linuxfoundation.org>
> Cc: Michael Kerrisk <mtk.manpages@gmail.com>
> Cc: Anna Schumaker <anna.schumaker@netapp.com>
> Cc: Jeff Layton <jlayton@kernel.org>
> Cc: Steve French <sfrench@samba.org>
> Cc: Miklos Szeredi <miklos@szeredi.hu>
> Cc: Trond Myklebust <trond.myklebust@hammerspace.com>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: "Darrick J. Wong" <darrick.wong@oracle.com>
> Cc: Dave Chinner <dchinner@redhat.com>
> Cc: Nicolas Boichat <drinkcat@chromium.org>
> Cc: Ian Lance Taylor <iant@google.com>
> Cc: Luis Lozano <llozano@chromium.org>
> Cc: Andreas Dilger <adilger@dilger.ca>
> Cc: Olga Kornievskaia <aglo@umich.edu>
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: ceph-devel <ceph-devel@vger.kernel.org>
> Cc: linux-kernel <linux-kernel@vger.kernel.org>
> Cc: CIFS <linux-cifs@vger.kernel.org>
> Cc: samba-technical <samba-technical@lists.samba.org>
> Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>
> Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
> Cc: Walter Harms <wharms@bfs.de>
> Signed-off-by: Alejandro Colomar <alx.manpages@gmail.com>
> ---
>
> Hi all,
>
> Please check that this is correct.
> I wrote it as I understood copy_file_range() from the LWN article,
> and the conversation on this thread,
> but maybe someone with more experience on this syscall find bugs in my patch.
>
> When kernels 5.3..5.11 fix this, some info could be compacted a bit more,
> and maybe the BUGS section could be removed.
>
> Also, I'd like to know which filesystems support cross-fs, and since when.
>
> Amir, you said that it was only cifs and nfs (since when? 5.3? 5.12?).
>
> Also, I'm a bit surprised that <5.3 could fail with EOPNOTSUPP
> and it wasn't documented.  Is that for sure, Amir?

No. You are right. EOPNOTSUPP is new.
Kernel always fell back to sendfile(2) if the filesystem did not support
copy_file_range().

>
> Thanks,
>
> Alex
>
> ---
>  man2/copy_file_range.2 | 29 ++++++++++++++++++++---------
>  1 file changed, 20 insertions(+), 9 deletions(-)
>
> diff --git a/man2/copy_file_range.2 b/man2/copy_file_range.2
> index 611a39b80..93f54889d 100644
> --- a/man2/copy_file_range.2
> +++ b/man2/copy_file_range.2
> @@ -169,6 +169,9 @@ Out of memory.
>  .B ENOSPC
>  There is not enough space on the target filesystem to complete the copy.
>  .TP
> +.BR EOPNOTSUPP " (before Linux 5.3; or since Linux 5.12)"
> +The filesystem does not support this operation.
> +.TP

so not before 5.3

>  .B EOVERFLOW
>  The requested source or destination range is too large to represent in the
>  specified data types.
> @@ -184,10 +187,17 @@ or
>  .I fd_out
>  refers to an active swap file.
>  .TP
> -.B EXDEV
> +.BR EXDEV " (before Linux 5.3)"
>  The files referred to by
>  .IR fd_in " and " fd_out
> -are not on the same mounted filesystem (pre Linux 5.3).
> +are not on the same filesystem.
> +.TP
> +.BR EXDEV " (or since Linux 5.12)"
> +The files referred to by
> +.IR fd_in " and " fd_out
> +are not on the same filesystem,
> +and the source and target filesystems are not of the same type,
> +or do not support cross-filesystem copy.

ok.

>  .SH VERSIONS
>  The
>  .BR copy_file_range ()
> @@ -195,13 +205,10 @@ system call first appeared in Linux 4.5, but glibc 2.27 provides a user-space
>  emulation when it is not available.
>  .\" https://sourceware.org/git/?p=glibc.git;a=commit;f=posix/unistd.h;h=bad7a0c81f501fbbcc79af9eaa4b8254441c4a1f
>  .PP
> -A major rework of the kernel implementation occurred in 5.3.
> -Areas of the API that weren't clearly defined were clarified and the API bounds
> -are much more strictly checked than on earlier kernels.
> -Applications should target the behaviour and requirements of 5.3 kernels.
> -.PP

That information is useful. Why remove it?
FYI, the LTP tests written to velidate the copy_file_range() API are not running
on kernel < 5.3 at all.

> -First support for cross-filesystem copies was introduced in Linux 5.3.
> -Older kernels will return -EXDEV when cross-filesystem copies are attempted.
> +Since 5.12,
> +cross-filesystem copies can be achieved
> +when both filesystems are of the same type,
> +and that filesystem implements support for it.
>  .SH CONFORMING TO
>  The
>  .BR copy_file_range ()
> @@ -226,6 +233,10 @@ gives filesystems an opportunity to implement "copy acceleration" techniques,
>  such as the use of reflinks (i.e., two or more inodes that share
>  pointers to the same copy-on-write disk blocks)
>  or server-side-copy (in the case of NFS).
> +.SH BUGS
> +In Linux kernels 5.3 to 5.11, cross-filesystem copies were supported.

I think it is a bit confusing to say "were supported", because how come
support went away from kernel 5.12? maybe something along the lines
that kernel implementation of copy was used if there was no filesystem
support for the operation...

> +However, on some virtual filesystems, the call failed to copy,
> +eventhough it may have reported success.
>  .SH EXAMPLES
>  .EX
>  #define _GNU_SOURCE
> --
> 2.30.1.721.g45526154a5
>
