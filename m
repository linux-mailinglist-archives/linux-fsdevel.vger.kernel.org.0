Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 631AD31EA30
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Feb 2021 14:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233350AbhBRNBB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Feb 2021 08:01:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233257AbhBRMuP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Feb 2021 07:50:15 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F70C0613D6;
        Thu, 18 Feb 2021 04:49:22 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id f6so1804949iop.11;
        Thu, 18 Feb 2021 04:49:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9j05/ujhefn+i0uqoNehBDttjjnrMeor9N19kGyBeSk=;
        b=BfkwYu9RpKR1NdZ+Nn3sljyddrWxW0TzGm16y8diuJzOvM0HGEIgJdiHtqxTPiX7Ek
         j4GN4sx1SqSwRXxgz/4+QWZSdEDAmCud+Xc/l8GgVQ3QyZ4WdrZLWHSo6jHo0UsjPuyS
         Ej2+rVCZQYJLQrae3nZuslv7pJSgbJ7zRhTgrWQ14YZQEQ0tCUZn8gGclYsGG+K75zu+
         Ma9oSPHm2vYiXoafUhMU3WEsUfX0/IhfCkSx9AadJ5Y8byDm2+DZGcbvQenbbfPn/yVc
         M16dHHx8XlVkpjx7umh3g5yHNuMsDUb1j0JrnyF5VfVmurxyDko8EwHuwx8AXztXI9i2
         DJvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9j05/ujhefn+i0uqoNehBDttjjnrMeor9N19kGyBeSk=;
        b=bBDYxBF3k3RRfbkfe1uYIh+S28eykQnnKR/V3cQ4qTLF7/eiZg2kYaFE3fr4gSfVoX
         //WKea45GmhtSqgAiM1O6cnFqlm/15ViRV81zYxoI+A4tRIFf9ACJNe0DxMtVykT7cO0
         eTW1ScHjIIbDaV9KGns5QleeZsUeVV7ymPV5/RUwzEUbUTF7WfOgIccTaCjcVQ2F6RhQ
         fJ8FLXVBGkCBTE9DI7QXbmTlRjvTUaVbXF037bCioUSBumwxx3FjTcvISpuDAHKjTKCl
         56qHT+MddVZWIriR+MwwYd+dNfbFfmYxcEuGNQzm0anE8n7/qxKhPsASSnf/ruUv89xk
         hHbQ==
X-Gm-Message-State: AOAM532mSTIe/FdF0Gj0QbrjwZT8G1viz4gH+CCVGrM7WP85BvsjxWMq
        7JEjDUXqrXTtxZsowZNHIOYr9mNZH7Y3EqJR1GE=
X-Google-Smtp-Source: ABdhPJyiinOZW0Ed1PyFRQLequIG17LpZAaMaI1SZHpTTeUl5fiQpkjTSMdoOBgxuolyYWsE850IsToVi8uolFDUGRM=
X-Received: by 2002:a02:bb16:: with SMTP id y22mr4275297jan.123.1613652561509;
 Thu, 18 Feb 2021 04:49:21 -0800 (PST)
MIME-Version: 1.0
References: <CAOQ4uxiFGjdvX2-zh5o46pn7RZhvbGHH0wpzLPuPOom91FwWeQ@mail.gmail.com>
 <20210215154317.8590-1-lhenriques@suse.de> <20210218074207.GA329605@infradead.org>
 <CAOQ4uxgreB=TywvWQXfcHYMBcFm5OKSdwUC8YJY1WuVja6PccQ@mail.gmail.com>
 <87v9apis97.fsf@suse.de> <87mtw1incj.fsf@suse.de>
In-Reply-To: <87mtw1incj.fsf@suse.de>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 18 Feb 2021 14:49:10 +0200
Message-ID: <CAOQ4uxjGkm0Pn84UW6JKSK3mFkrPKykfkXDLL1V4YPSgAOXULA@mail.gmail.com>
Subject: Re: [PATCH v2] vfs: prevent copy_file_range to copy across devices
To:     Luis Henriques <lhenriques@suse.de>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        Steve French <sfrench@samba.org>,
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

On Thu, Feb 18, 2021 at 2:14 PM Luis Henriques <lhenriques@suse.de> wrote:
>
> Luis Henriques <lhenriques@suse.de> writes:
>
> > Amir Goldstein <amir73il@gmail.com> writes:
> >
> >> On Thu, Feb 18, 2021 at 9:42 AM Christoph Hellwig <hch@infradead.org> wrote:
> >>>
> >>> Looks good:
> >>>
> >>> Reviewed-by: Christoph Hellwig <hch@lst.de>
> >>>
> >>> This whole idea of cross-device copie has always been a horrible idea,
> >>> and I've been arguing against it since the patches were posted.
> >>
> >> Ok. I'm good with this v2 as well, but need to add the fallback to
> >> do_splice_direct()
> >> in nfsd_copy_file_range(), because this patch breaks it.
> >>
> >> And the commit message of v3 is better in describing the reported issue.
> >
> > Except that, as I said in a previous email, v2 doesn't really fix the
> > issue: all the checks need to be done earlier in generic_copy_file_checks().
> >
> > I'll work on getting v4, based on v2 and but moving the checks and
> > implementing your review suggestions to v3 (plus this nfs change).
>
> There's something else:
>
> The filesystems (nfs, ceph, cifs, fuse) rely on the fallback to
> generic_copy_file_range() if something's wrong.  And this "something's
> wrong" is fs specific.  For example: in ceph it is possible to offload the
> file copy to the OSDs even if the files are in different filesystems as
> long as these filesystems are on the *same* ceph cluster.  If the copy
> being done is across two different clusters, then the copy reverts to
> splice.  This means that the boilerplate code being removed in v2 of this
> patch needs to be restored and replace by:
>
>         ret = __ceph_copy_file_range(src_file, src_off, dst_file, dst_off,
>                                      len, flags);
>
>         if (ret == -EOPNOTSUPP || ret == -EXDEV)
>                 ret = do_splice_direct(src_file, &src_off, dst_file, &dst_off,
>                                        len > MAX_RW_COUNT ? MAX_RW_COUNT : len,
>                                        flags);
>         return ret;
>

Why not leave the filesystem code as is and leave the
generic_copy_file_range() helper? Less churn.

Then nfsd_copy_file_range() can also fallback to generic_copy_file_range().

Thanks,
Amir.
