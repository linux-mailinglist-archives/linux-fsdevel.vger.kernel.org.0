Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D541320F9E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Feb 2021 04:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231803AbhBVDB5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 21 Feb 2021 22:01:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231864AbhBVDBw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 21 Feb 2021 22:01:52 -0500
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4400C06178C
        for <linux-fsdevel@vger.kernel.org>; Sun, 21 Feb 2021 19:01:05 -0800 (PST)
Received: by mail-vs1-xe2f.google.com with SMTP id t23so5802039vsk.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 21 Feb 2021 19:01:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bj008TzA91yeOQfW1fAghRLR+ASOodj9cM7GwstAIME=;
        b=imn9aZ2j3Wc5I4qvtgMJytqp6zEdNE4LeSMoNNryFUBCZrV7FE1azq3l+13vXM++Cu
         cz7Z3z9xT98T5chMANc6ZJLQ678xFeZTDGLZYNpK+ISQQLnCmrZQ8SouthHoMGb+aL0l
         CNKCU0qYSO02Pu0zkz7jCNHHx70wtPXDK4Ho0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bj008TzA91yeOQfW1fAghRLR+ASOodj9cM7GwstAIME=;
        b=ubjirfJ3o40sctxWSKkkBVBHhOpM+wCRVGCR3x6cJGHDw8uzsWw8EL8VhyVLSJ0bgz
         BANl8YRZ0L2IsqTqDZERLxhe2bFCTGcdJaXUHDwN71pjp/oWwjF1Wdt+GivdKdi873ks
         Rj09Hhfr8AAqM3EWX9oG3vZgUex8Qq3J3a0+5xsnsedWCXm+IdlpObJhHzLJHYNcb1uu
         7jlA+oJianlbSMZfyX/buxKJGoYYOgHyTf0JSchac3kAuHLRBBTWwR6qe4kAS8O7Xnew
         GNK7Cnfkz5BfFHdF5oEwwjumTw6qQ7sK6FiJ/AU5S/r/gy/I2fIX/oMQyFlRCp5dpKFu
         ZBvQ==
X-Gm-Message-State: AOAM532GRTlXIBVQsret7rPZ5x58P3qfzcJPVvw8hvUmsHw9DMH1ncKb
        31UJyH6+2UGFqzxogSRJwU8uw1DPXUrRE5P5Qmle1A==
X-Google-Smtp-Source: ABdhPJzu00J2jyLPd7KbgiPCKHQxN149b3F53M+u5NFqNCJwlFsWdb6wAPdM4uLfZXt8qvbnDsys07L1jvDhzmMSIc8=
X-Received: by 2002:a67:1046:: with SMTP id 67mr7467152vsq.21.1613962864510;
 Sun, 21 Feb 2021 19:01:04 -0800 (PST)
MIME-Version: 1.0
References: <CAN-5tyGs9skFZ=ghd8Vz2F35S70QYi+kujdyRYLSkcEi8Jm9gw@mail.gmail.com>
 <20210221195833.23828-1-lhenriques@suse.de>
In-Reply-To: <20210221195833.23828-1-lhenriques@suse.de>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Mon, 22 Feb 2021 11:00:53 +0800
Message-ID: <CANMq1KDOSfsVC0Akk8xm2=kPBsU9WfZVDrqnQZSViwZUT=wO+A@mail.gmail.com>
Subject: Re: [PATCH v7] vfs: fix copy_file_range regression in cross-fs copies
To:     Luis Henriques <lhenriques@suse.de>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Steve French <sfrench@samba.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dave Chinner <dchinner@redhat.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Ian Lance Taylor <iant@google.com>,
        Luis Lozano <llozano@chromium.org>,
        Andreas Dilger <adilger@dilger.ca>,
        Olga Kornievskaia <aglo@umich.edu>,
        Christoph Hellwig <hch@infradead.org>,
        ceph-devel@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 22, 2021 at 3:57 AM Luis Henriques <lhenriques@suse.de> wrote:
>
> A regression has been reported by Nicolas Boichat, found while using the
> copy_file_range syscall to copy a tracefs file.  Before commit
> 5dae222a5ff0 ("vfs: allow copy_file_range to copy across devices") the
> kernel would return -EXDEV to userspace when trying to copy a file across
> different filesystems.  After this commit, the syscall doesn't fail anymore
> and instead returns zero (zero bytes copied), as this file's content is
> generated on-the-fly and thus reports a size of zero.
>
> This patch restores some cross-filesystem copy restrictions that existed
> prior to commit 5dae222a5ff0 ("vfs: allow copy_file_range to copy across
> devices").  Filesystems are still allowed to fall-back to the VFS
> generic_copy_file_range() implementation, but that has now to be done
> explicitly.
>
> nfsd is also modified to fall-back into generic_copy_file_range() in case
> vfs_copy_file_range() fails with -EOPNOTSUPP or -EXDEV.
>
> Fixes: 5dae222a5ff0 ("vfs: allow copy_file_range to copy across devices")
> Link: https://lore.kernel.org/linux-fsdevel/20210212044405.4120619-1-drinkcat@chromium.org/
> Link: https://lore.kernel.org/linux-fsdevel/CANMq1KDZuxir2LM5jOTm0xx+BnvW=ZmpsG47CyHFJwnw7zSX6Q@mail.gmail.com/
> Link: https://lore.kernel.org/linux-fsdevel/20210126135012.1.If45b7cdc3ff707bc1efa17f5366057d60603c45f@changeid/
> Reported-by: Nicolas Boichat <drinkcat@chromium.org>

Tested-by: Nicolas Boichat <drinkcat@chromium.org>

> Signed-off-by: Luis Henriques <lhenriques@suse.de>
> ---
> Changes since v6
> - restored i_sb checks for the clone operation
> Changes since v5
> - check if ->copy_file_range is NULL before calling it
> Changes since v4
> - nfsd falls-back to generic_copy_file_range() only *if* it gets -EOPNOTSUPP
>   or -EXDEV.
> Changes since v3
> - dropped the COPY_FILE_SPLICE flag
> - kept the f_op's checks early in generic_copy_file_checks, implementing
>   Amir's suggestions
> - modified nfsd to use generic_copy_file_range()
> Changes since v2
> - do all the required checks earlier, in generic_copy_file_checks(),
>   adding new checks for ->remap_file_range
> - new COPY_FILE_SPLICE flag
> - don't remove filesystem's fallback to generic_copy_file_range()
> - updated commit changelog (and subject)
> Changes since v1 (after Amir review)
> - restored do_copy_file_range() helper
> - return -EOPNOTSUPP if fs doesn't implement CFR
> - updated commit description
>
>  fs/nfsd/vfs.c   |  8 +++++++-
>  fs/read_write.c | 50 ++++++++++++++++++++++++-------------------------
>  2 files changed, 32 insertions(+), 26 deletions(-)
> [snip]
