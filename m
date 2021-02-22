Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCD3F321463
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Feb 2021 11:47:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbhBVKrk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Feb 2021 05:47:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbhBVKre (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Feb 2021 05:47:34 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC58C06178C;
        Mon, 22 Feb 2021 02:46:32 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id z18so10338453ile.9;
        Mon, 22 Feb 2021 02:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FHZQdAl+UcOWFEKhnz51zgke6JFt0Apq4o1l3JnjKAI=;
        b=BR+j5tJ76HJ/MrYsYUrbRAckIqs5GbHwJGeClmEn6L96g5exlOi5QZeYy7ZvvUq4wG
         JynsiK3Ygr53wwHj/6xTghe+kBd/tlpV+84eFX7WAr43T3wJM6RxORvPN/SWBOQcmm/V
         OoKN52LfbVvqCkqFMVdKThs3kIt7ud25jOtaGGi27pwzkLMpfZkfWDMXhO/0XWVxeHNW
         YNFiJrC+vbItmaQ0DB6DrpAZa5DxlS9iPabxEwCvsI56Fg7CXnHrPIstiiguxxU8trtS
         UEN2f5vaSNWxCzmhs+clpU2Tne/l4pqXV4nSiWT8T5wYJUusloUdhy2E0X1FJyMMETi5
         rX9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FHZQdAl+UcOWFEKhnz51zgke6JFt0Apq4o1l3JnjKAI=;
        b=LNh4N6sPXV7BizilQviZVG0NxTW+YGvAJV56Vmc0n2Qmf+D47Sz4Imy41Bx3U22brU
         Bpl5BGl/NNBkGnm+626cTlJB4Kn8ea1J6ostS1O1Cs0Yjaz7O2B1ywdoDiKobLU69W0e
         3ZUjwZeNnmAn5HxgESxxpu7knlOvjtthAQshTNDankoWYZlleUhA2De7HiTh9YnqUw/I
         ZrHjfucI1Q84k2DwMzL6UuxMiMe2hbdXtDViBC2jWJAXylBbJrm6WdXf5H3K/8d5Hpz1
         NxwFuwbbJKWD5FTVlPewX6hT/+fMY9+BQ8KnRszKTZHvnceMexIYwcrjPz1yFTXDcYXF
         PUAw==
X-Gm-Message-State: AOAM531mRTTUAgIKBv3SEBJK95koZ2d+cnLrM9y2TxzdDnsN+a6GF8v9
        qOOTK3/8v7cdNjnQOW5uKwxAMYc8AKYJl6TNSa0=
X-Google-Smtp-Source: ABdhPJwCt22ShOeNCpiOnTx3JXmkEO2/x+8xvzSi9yrlR8q5F2qEMQngv4H4MSPX9tkAXc2eNDJvntVrkaQKi+YyX+Y=
X-Received: by 2002:a92:740c:: with SMTP id p12mr1161730ilc.9.1613990791635;
 Mon, 22 Feb 2021 02:46:31 -0800 (PST)
MIME-Version: 1.0
References: <20210221195833.23828-1-lhenriques@suse.de> <20210222102456.6692-1-lhenriques@suse.de>
In-Reply-To: <20210222102456.6692-1-lhenriques@suse.de>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 22 Feb 2021 12:46:20 +0200
Message-ID: <CAOQ4uxjwEyQkY3WKiWD9X4nJpgjZ9640evoSPRxtw9iPsigGyA@mail.gmail.com>
Subject: Re: [PATCH v8] vfs: fix copy_file_range regression in cross-fs copies
To:     Luis Henriques <lhenriques@suse.de>
Cc:     Jeff Layton <jlayton@kernel.org>, Steve French <sfrench@samba.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dave Chinner <dchinner@redhat.com>,
        Greg KH <gregkh@linuxfoundation.org>,
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
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 22, 2021 at 12:23 PM Luis Henriques <lhenriques@suse.de> wrote:
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
> Signed-off-by: Luis Henriques <lhenriques@suse.de>
> ---

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Thanks,
Amir.
