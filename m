Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43E1C2CC31
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2019 18:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbfE1QhI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 May 2019 12:37:08 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:36348 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbfE1QhH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 May 2019 12:37:07 -0400
Received: by mail-yb1-f195.google.com with SMTP id y2so5310828ybo.3;
        Tue, 28 May 2019 09:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PYyoMvDm/dXGRe/O4V7JuzdN8o4UlUgeVG3yspmetXo=;
        b=VGw9h+5SH8G2eQBLA4yzErLGp2JcQz5xkbxQhD17r2EyO4n3JzIrewbU9I6o6WONw+
         Mugd6wgNJT9XNvgGJT/WIeboXrmaLDPR45HipqdaZbOIVLZcrOLkcglAUq8Kc2QmXlSV
         s4e7wBZAeV9aFiknfm+jQaohyzMx3FIkXPtYUnMx3UCuonMt/FtPqMBdXuMupYe31rsT
         MvsTYmpTrm95yu80x68xgVtFk12/7AcIrwnq6iPGNMy8h4BUb9Fo/al5ZshH2YCM5KIU
         MBHrjChha7QRDMatUFEQhQ2LMObbsKY/AIe7bsF1pqIxjcCsB91CkmJboWNIHzpnS4ew
         iwPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PYyoMvDm/dXGRe/O4V7JuzdN8o4UlUgeVG3yspmetXo=;
        b=d/dE1b3H4v6blKnu1qrsoxbbsmsviOI9EFNYjb4Rps2ajHaUXCRFiIAqQwKiYygjji
         QczPv4xzkJb47T8RfeGhZZAnG5c4KIqr2I3rKECGA694nkexFtl+9SQiKclHUAnAfobF
         q7skc2ZQDIaKtWxmsJa6NUazOYvcV9tA1RD9gEPTILeSCuj8GeDn4d+qplWydvBJsoLq
         CnstKHpJeT0i4Q/V8zhqDc16SPHiPtRHvV6LFfQNCK2wFSdS+4AOM8Tn7MI3YXF2BQTQ
         bAeTE2IGcGrUdcUiEc40yuBdoejUPXO5KzhHE/wZQZQkiMPV+uyiOttqXQ3NieSX7Tom
         6lTw==
X-Gm-Message-State: APjAAAXU4AXZRr/Q8WpwbEHoOrD44rav7SHW+jjWKkYGnGDrwqksEdFc
        s4vUiIAlH4yOX216pmcU5YiJsy7OoQWsDQrp0JM=
X-Google-Smtp-Source: APXvYqzNmXIBn6/oTpIvfmHhHyE9ZsSfbV4ffVVj9wkSHo/L8B4c8X2QTwsa87MpFpK8M5ofJUZjdRtBA0rjxm3gF1g=
X-Received: by 2002:a25:d946:: with SMTP id q67mr2138643ybg.126.1559061426538;
 Tue, 28 May 2019 09:37:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190526061100.21761-1-amir73il@gmail.com> <20190526061100.21761-7-amir73il@gmail.com>
 <20190528163020.GF5221@magnolia>
In-Reply-To: <20190528163020.GF5221@magnolia>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 28 May 2019 19:36:55 +0300
Message-ID: <CAOQ4uxh1Tk+ZN+hiEJLsSFP8Q=RNPEaJ_FDG_XkzkrtBXBL65A@mail.gmail.com>
Subject: Re: [PATCH v2 6/8] vfs: copy_file_range should update file timestamps
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@lst.de>,
        Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        Luis Henriques <lhenriques@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>, ceph-devel@vger.kernel.org,
        linux-api@vger.kernel.org, Dave Chinner <dchinner@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 28, 2019 at 7:30 PM Darrick J. Wong <darrick.wong@oracle.com> wrote:
>
> On Sun, May 26, 2019 at 09:10:57AM +0300, Amir Goldstein wrote:
> > From: Dave Chinner <dchinner@redhat.com>
> >
> > Timestamps are not updated right now, so programs looking for
> > timestamp updates for file modifications (like rsync) will not
> > detect that files have changed. We are also accessing the source
> > data when doing a copy (but not when cloning) so we need to update
> > atime on the source file as well.
> >
> > Signed-off-by: Dave Chinner <dchinner@redhat.com>
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> >  fs/read_write.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/fs/read_write.c b/fs/read_write.c
> > index e16bcafc0da2..4b23a86aacd9 100644
> > --- a/fs/read_write.c
> > +++ b/fs/read_write.c
> > @@ -1576,6 +1576,16 @@ int generic_copy_file_range_prep(struct file *file_in, struct file *file_out)
> >
> >       WARN_ON_ONCE(!inode_is_locked(file_inode(file_out)));
> >
> > +     /* Update source timestamps, because we are accessing file data */
> > +     file_accessed(file_in);
> > +
> > +     /* Update destination timestamps, since we can alter file contents. */
> > +     if (!(file_out->f_mode & FMODE_NOCMTIME)) {
> > +             ret = file_update_time(file_out);
> > +             if (ret)
> > +                     return ret;
> > +     }
> > +
> >       /*
> >        * Clear the security bits if the process is not being run by root.
> >        * This keeps people from modifying setuid and setgid binaries.
>
> Should the file_update_time and file_remove_privs calls be factored into
> a separate small function to be called by generic_{copy,remap}_range_prep?
>

Ok. same helper could be called also after copy when inode is not locked
throughout the copy.

Thanks,
Amir.
