Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 982D931ED08
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Feb 2021 18:15:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233603AbhBRRNP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Feb 2021 12:13:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232815AbhBRPy0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Feb 2021 10:54:26 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73CE1C06178A;
        Thu, 18 Feb 2021 07:53:45 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id w1so1844968ilm.12;
        Thu, 18 Feb 2021 07:53:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jHTepAlgTB29GedvBS59O+ZCtpomsphnsV6+Q0YzaKA=;
        b=rh06aKoeJZqVRP33hjROHoKd/qSMoZCoo3TwZOv3WnZOLPIVpCyj9huZGaAx9W0QSc
         ouVZ+SzP+qYt0nZImmvgN9wE6A0RVITwEniF6KIp9rfrZd05RQG0Tpet2qu9VwMtoN/8
         YNnBMuxco6dxHVokc4GdEyfwGPixHb9UU1PxOvVU9Frq2KyHIsdg1T+ooHoaIfqIS6nD
         AORQV/jA9yfxAtwN62q5Z3Fr6NQOptyysokkmb5fJIqtVnFGXTal9XOCDFT1CE3hrt5/
         T0Fu+YQTNq1sKawIyxv57mKie0SkMpd34/uce7jTxsLDY6BPsLBpTIWRJy7oJxn/jidO
         JFtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jHTepAlgTB29GedvBS59O+ZCtpomsphnsV6+Q0YzaKA=;
        b=hhlzFshOr+4EjHoEex3Uf79OzZSJSjHFdK9OWMpFJ0kkPxpZzN8k0Ha3DsQaiHqMEo
         0qnJ6tCgH74ik1OlsHfH7v15baF5hXd1ABBzInLIVEyXweOqPvaAMnx0rPFLvwZxQz46
         7IMH8CUQKlI+xrgEcdb1QlsRLbSHb1HSu7RoAPMkN/M0wYMWYOhWgpBCOAOvkmMC2epo
         LIXXzWcz68QR993WSSMVMl6AclBPaAVfvIIarIYWjLqzWlsbyOJ80m450rTQnLa4MVoq
         ePsizHBIkkN/joaDd3mMWxgXavbM9jUVwkGEI/Fm0j48bfplJ0OUPTsqExTk6T76V0Z5
         T9pg==
X-Gm-Message-State: AOAM533Xq5v7/JLs68kQ+GRiI3WyeX7Ayy4GpBy9WlpYUQUGR3k+KLHf
        nUlKLKZ8bE7hHxpk7wOdymD7fhU/mBE22WvAoTE=
X-Google-Smtp-Source: ABdhPJzX4e5mLMreJslRfH45oHpKARb9BPN/u3cMRDZ7OC9QXf/dJ7aDlICxgGSnOYq4QhM4PQD2699e4RN20kEKijo=
X-Received: by 2002:a92:8e42:: with SMTP id k2mr4398912ilh.250.1613663624156;
 Thu, 18 Feb 2021 07:53:44 -0800 (PST)
MIME-Version: 1.0
References: <CAOQ4uxj=ZeJ0HYtivP=pg5mSDaiQGU8Fz8qw0Egfa2Ert5Ra7A@mail.gmail.com>
 <20210218151752.26710-1-lhenriques@suse.de>
In-Reply-To: <20210218151752.26710-1-lhenriques@suse.de>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 18 Feb 2021 17:53:33 +0200
Message-ID: <CAOQ4uxgO45cqKLRsXBxn04fVkqH483G3ngCtV_gZGHMQDFixig@mail.gmail.com>
Subject: Re: [PATCH v5] vfs: fix copy_file_range regression in cross-fs copies
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

On Thu, Feb 18, 2021 at 5:16 PM Luis Henriques <lhenriques@suse.de> wrote:
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
> And v5!  Sorry.  Sure, it makes sense to go through the all the vfs_cfr()
> checks first.

You missed my other comment on v4...

not checking NULL copy_file_range case.

Thanks,
Amir.
