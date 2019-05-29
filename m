Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4D52E516
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2019 21:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbfE2TKt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 May 2019 15:10:49 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:44039 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbfE2TKt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 May 2019 15:10:49 -0400
Received: by mail-yb1-f193.google.com with SMTP id x187so1192853ybc.11;
        Wed, 29 May 2019 12:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sdhgQS4Tb0z7ll/z1cxYjMzf/L4cWSD38GVXaIhtm/U=;
        b=LtvWdqaYIKuBvm2A8iP5YbvFOhyWBZez/NhG4i7YEldl1hiJTsafXWckN933f3qCVI
         CkxQCfOhZseHYQCHer6DLfo3nT0gtAbIX9YhQDVPiJNYY7hQeltY+GXotEItkJTUQW78
         m0JB142Qtvmp9ViLy3AmfOWUS0cDaWJX8yAZMUUg2KnmJruRrUnEska5wYEq3f+qjslM
         cn1fadjdwh9Z5RfTTQG+c+Qu5p5aZHd8D9ZiOA736G6qJ9NDiCAtj1kZavHjO03oqtPE
         zImC3Gk7Pt3fLQF+XhESI4BiscAW3panE6plkC4RzWx8HVYC8+ANhjLEMovdazbqj340
         ayoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sdhgQS4Tb0z7ll/z1cxYjMzf/L4cWSD38GVXaIhtm/U=;
        b=EFYQjU6WyNlswqYrDZxGtoOw3ILXz1qfwRoVjmKh21Ocl5imVOweyvpF1FxTi+074b
         4KuYZ8Mo3HH0Qc7psWn0/ChlzIc/PUhSYj2vezEn5LxfMi9Qtem0vLGQmeYK6EQZO+3x
         rqD5/pd/ZVFG0ncG9q1kKUnVCYSHKdLR4Nt0oUKOJJrfXiUbv471wCZUbpvWY6SFPuWY
         PzWt5RZrxiODPwl9DhdpZtJ4vgIqnygpZDJVTituoD5l1ebPDXspfTGXvZYoKe0sqMFa
         pruiCaB6+JyL4HbBzEy59AOHEORGN3fnGmQCFlETzNmr+Lr/RnmpcsylxpMZTaUew9KX
         rSIw==
X-Gm-Message-State: APjAAAWhA/9v5Td+OFaakHmqCfn/QAwYnNkDApHvixJmBdOOE9jRuDq1
        F5AvVmTPn13Jq7w/CMPSHwxYqfTT4f8ZldnAeGk=
X-Google-Smtp-Source: APXvYqzkPFXzzQ68XwK4gBJ8wXlhtmgHqOEg//df7cwWLUWieql2vlpDhcbGPLTS7Culngu0vK88uGJpWOimwn4Sejc=
X-Received: by 2002:a25:a081:: with SMTP id y1mr36085656ybh.428.1559157048369;
 Wed, 29 May 2019 12:10:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190529174318.22424-1-amir73il@gmail.com> <20190529174318.22424-8-amir73il@gmail.com>
 <20190529183149.GG5231@magnolia>
In-Reply-To: <20190529183149.GG5231@magnolia>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 29 May 2019 22:10:37 +0300
Message-ID: <CAOQ4uxg0Z8Ne8kadPzsushW43t3Sijy+9WQbGRRO=CtmMAbtuA@mail.gmail.com>
Subject: Re: [PATCH v3 07/13] xfs: use file_modified() helper
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@lst.de>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        Luis Henriques <lhenriques@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-api@vger.kernel.org, ceph-devel@vger.kernel.org,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 29, 2019 at 9:31 PM Darrick J. Wong <darrick.wong@oracle.com> wrote:
>
> On Wed, May 29, 2019 at 08:43:11PM +0300, Amir Goldstein wrote:
> > Note that by using the helper, the order of calling file_remove_privs()
> > after file_update_mtime() in xfs_file_aio_write_checks() has changed.
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> >  fs/xfs/xfs_file.c | 15 +--------------
> >  1 file changed, 1 insertion(+), 14 deletions(-)
> >
> > diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> > index 76748255f843..916a35cae5e9 100644
> > --- a/fs/xfs/xfs_file.c
> > +++ b/fs/xfs/xfs_file.c
> > @@ -367,20 +367,7 @@ xfs_file_aio_write_checks(
> >        * lock above.  Eventually we should look into a way to avoid
> >        * the pointless lock roundtrip.
> >        */
> > -     if (likely(!(file->f_mode & FMODE_NOCMTIME))) {
>
> ...especially since here we think NOCMTIME is likely /not/ to be set.
>
> > -             error = file_update_time(file);
> > -             if (error)
> > -                     return error;
> > -     }
> > -
> > -     /*
> > -      * If we're writing the file then make sure to clear the setuid and
> > -      * setgid bits if the process is not being run by root.  This keeps
> > -      * people from modifying setuid and setgid binaries.
> > -      */
> > -     if (!IS_NOSEC(inode))
> > -             return file_remove_privs(file);
>
> Hm, file_modified doesn't have the !IS_NOSEC check guarding
> file_remove_privs, are you sure it's ok to remove the suid bits
> unconditionally?  Even if SB_NOSEC (and therefore S_NOSEC) are set?
>

file_remove_privs() has its own IS_NOSEC() check.

Thanks,
Amir.
