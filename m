Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE9652E6E9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2019 23:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbfE2VBC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 May 2019 17:01:02 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:42040 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726538AbfE2VBB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 May 2019 17:01:01 -0400
Received: by mail-yw1-f66.google.com with SMTP id s5so1663890ywd.9;
        Wed, 29 May 2019 14:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2bUX9HHLDimGpHftlxiZFbL0LRNK02ZuHhjX+WUCqPs=;
        b=mokTnnsRdjT1v9zXbMeJ8tMVuwGBi9oZieTmqfLND4TQvuv+6jYtzMpalLNeGnT8OE
         qLACIUrBtyV6h9Tc5JogpdaL7A/jqf9qpUVZOetoZ3/JtYd9XV8Bk/PLRr0mV4lilWCy
         Zzues0JQGQuvgVDBXvscVDBj/gKJ65K7d8ECbfQxgoYZJ1VJ9VvScP5eu60wCuUsEXB6
         R+omRXtO+AJBLqI3vpt2gZ5zvIzPhSXOmq5TZQbV/GlnbeXEn9p/eEgq2t+9GTijHWXA
         rERh2cPUv88AjcLOg1qw2fDegTzoESZ766o7y3cxugW8mnSeP5s1Il/FQfKZc3LBYIt5
         7/mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2bUX9HHLDimGpHftlxiZFbL0LRNK02ZuHhjX+WUCqPs=;
        b=Y9ziizeJ6MQ0u8vDh2w8CV5SRr6GauNAQygz3jf2/kV7vNesOMJ2fhbENuHVFH/d1V
         UMwB48QCvDEBwYERgyVMEauBNlmuTqoz2zAQekudrkKAN/eVUlg2vr3+DYEf1b+1wX/u
         LZeDPWfwh60p614oqd0Fy6zGxC9rFxjRrM6ZNk8fSYjJoX7l5/y2baigl3SNqZQAOfe5
         xzQ53XLqKo/dvqDeI2F0mL2W5ILezqRNBL5tnL7doYaRI0mgEvJcuVrzX6rhkfMIuz5c
         AdZBUH1+5dbemB98YKbye3kvh/NPu6gafY797nj5wOtiarEpgQcppExPqCbfce/ajCqe
         YGsQ==
X-Gm-Message-State: APjAAAWjDE2DJMP88ftyiepiymr+3MwOHlfm4EXhX/twr1Vz0mYFU4oO
        z90WzMmQqQb7y6BbMCh+zaX22IBO3s8u4qyPkUg=
X-Google-Smtp-Source: APXvYqyrK/4V0q9KZq/DcTiqx6cmC6OvHU4vovdF+8lt7yiCN/6T6wIGMo6YYCvkngQFkF/b2jOo5E+utaFhPNJyMeg=
X-Received: by 2002:a81:4f06:: with SMTP id d6mr48990950ywb.379.1559163660713;
 Wed, 29 May 2019 14:01:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190529174318.22424-1-amir73il@gmail.com> <20190529174318.22424-13-amir73il@gmail.com>
 <CAOQ4uxgYM_eM==uqGQuKiGb+f08qs53=E+DONMMzW=N-Ab5YZA@mail.gmail.com> <c32af433639b451419d36382a05edabfcb742294.camel@hammerspace.com>
In-Reply-To: <c32af433639b451419d36382a05edabfcb742294.camel@hammerspace.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 30 May 2019 00:00:49 +0300
Message-ID: <CAOQ4uxio_1J-v3dcXO154N0Ntq+vrM0FOQv0G6Nh1HBmtHZEfQ@mail.gmail.com>
Subject: Re: [PATCH v3 12/13] nfs: copy_file_range needs to strip setuid bits
 and update timestamps
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "Anna.Schumaker@netapp.com" <Anna.Schumaker@netapp.com>,
        "olga.kornievskaia@gmail.com" <olga.kornievskaia@gmail.com>,
        "hch@lst.de" <hch@lst.de>,
        "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "lhenriques@suse.com" <lhenriques@suse.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "darrick.wong@oracle.com" <darrick.wong@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 29, 2019 at 11:02 PM Trond Myklebust
<trondmy@hammerspace.com> wrote:
>
> On Wed, 2019-05-29 at 22:34 +0300, Amir Goldstein wrote:
> > Hi Olga,Anna,Trond
> >
> > Could we get an ACK on this patch.
> > It is a prerequisite for merging the cross-device copy_file_range
> > work.
> >
> > It depends on a new helper introduced here:
> > https://lore.kernel.org/linux-fsdevel/CAOQ4uxjbcSWX1hUcuXbn8hFH3QYB+5bAC9Z1yCwJdR=T-GGtCg@mail.gmail.com/T/#m1569878c41f39fac3aadb3832a30659c323b582a
> >
> > Thanks,
> > Amir,
> >
> > On Wed, May 29, 2019 at 8:43 PM Amir Goldstein <amir73il@gmail.com>
> > wrote:
> > > Like ->write_iter(), we update mtime and strip setuid of dst file
> > > before
> > > copy and like ->read_iter(), we update atime of src file after
> > > copy.
> > >
> > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > ---
> > >  fs/nfs/nfs42proc.c | 9 ++++++---
> > >  1 file changed, 6 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
> > > index 5196bfa7894d..c37a8e5116c6 100644
> > > --- a/fs/nfs/nfs42proc.c
> > > +++ b/fs/nfs/nfs42proc.c
> > > @@ -345,10 +345,13 @@ ssize_t nfs42_proc_copy(struct file *src,
> > > loff_t pos_src,
> > >
> > >         do {
> > >                 inode_lock(file_inode(dst));
> > > -               err = _nfs42_proc_copy(src, src_lock,
> > > -                               dst, dst_lock,
> > > -                               &args, &res);
> > > +               err = file_modified(dst);
> > > +               if (!err)
> > > +                       err = _nfs42_proc_copy(src, src_lock,
> > > +                                              dst, dst_lock,
> > > +                                              &args, &res);
> > >                 inode_unlock(file_inode(dst));
> > > +               file_accessed(src);
> > >
> > >                 if (err >= 0)
> > >                         break;
> > > --
> > > 2.17.1
> > >
>
> Please drop this patch. In the NFS protocol, the client is not expected
> to mess with atime or mtime other than when the user explicitly sets it
> through a call to utimensat() or similar. The server takes care of any
> a/mtime updates as and when the file is read/written to.
>
> Ditto for suid/sgid clearing.
>
> Motto: "No file_accessed() or file_remove_privs() calls, please. We're
> NFS."

OK.

Thanks,
Amir.
