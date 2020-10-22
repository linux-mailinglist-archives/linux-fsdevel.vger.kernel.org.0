Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0338B296286
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Oct 2020 18:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896700AbgJVQRt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Oct 2020 12:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2896697AbgJVQRt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Oct 2020 12:17:49 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 531DFC0613CE
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Oct 2020 09:17:49 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id v5so2757770wmh.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Oct 2020 09:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=an4HM7viF76dg/BBOcet2kiSOHM3LCjyzxKusN4Cnjw=;
        b=iCpyZf3v2xE9KHsfzUXVGtoriEuj7sXoIkHaAXOraSZIN2rY9cfiHSmSg7CoZtrn+P
         9nFFLzFZlRx81Z6UnMlmBMyZyaqgsY34PthTnZYTWfuoZSOGZ0GQ6ulipbK4JDi/hfZr
         REAHdX0+4+sPPh3iZRFpEm6RETOAqGop2Gq1aqAd2/5Q8KBsp2iyTgf1D7U44s0jaZwQ
         zAWHVvyW9U+UW/58Uosnlt1mnxWM8CTBdo+s8M4lA3zwJvd/6+eyMWcpqRstUT2++IVP
         DIdJQUg1tUkOIiDaY0ztAr/vt5j2k5UFsFTNmigIB3IbSFm+2JoYp2W1SLuoqJ4WNHjR
         GlSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=an4HM7viF76dg/BBOcet2kiSOHM3LCjyzxKusN4Cnjw=;
        b=Lo9c5Tc7WTyn2BnissOzJmw8W/WAu4VDeSpMPk9+7n6V1jruckMIwNzthLX0UKJdb+
         9/61VtWwRmNOr2pshOJVMxmGZe0JwT/3tly7af/i78ent1RqdIkKmCAEJI4G2t5BAm8E
         OLqMQaAPJoyIgMjQ9MRoR4HrHgx3jB+VZk6rXAt+5LLMmDTOb+w1eRwe6eUYldJZmJxp
         KVrEWymtMp2MaoANwwRZ9hU+rN7VAw/LmxkkQF9pTtGplUsG6c7Kdk3NpyOtx4loQL10
         bDpeKhXPVxJRmdMPCNzT+Bv7Mn4pO62ffP2SLmoH2cE9rT2M2hkUcEDXv1uVfms+GUyw
         RYGw==
X-Gm-Message-State: AOAM533DvRccdT7IsIhKU1gK6DEe5x1nZEcsoKHK3PNlflMOHwIDcDlH
        cZNkI4r5NxsY+6RNVJAwcYmQog==
X-Google-Smtp-Source: ABdhPJw8L1B7TdR0f5aXqfG0EAiugB4+Afdb5e50ZlRsr4MLvNkoFdhvzOvRCWDKNky9BAc37nuSIQ==
X-Received: by 2002:a7b:c143:: with SMTP id z3mr3456794wmi.17.1603383468056;
        Thu, 22 Oct 2020 09:17:48 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:210:7220:84ff:fe09:7d5c])
        by smtp.gmail.com with ESMTPSA id s5sm4243186wmc.3.2020.10.22.09.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2020 09:17:47 -0700 (PDT)
Date:   Thu, 22 Oct 2020 17:17:45 +0100
From:   Alessio Balsini <balsini@android.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Alessio Balsini <balsini@android.com>,
        Akilesh Kailash <akailash@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Antonio SJ Musumeci <trapexit@spawn.link>,
        David Anderson <dvander@google.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Jann Horn <jannh@google.com>, Jens Axboe <axboe@kernel.dk>,
        Martijn Coenen <maco@android.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Lawrence <paullawrence@google.com>,
        Stefano Duo <stefanoduo@google.com>,
        Zimuzo Ezeozue <zezeozue@google.com>,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        kernel-team <kernel-team@android.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V9 3/4] fuse: Introduce synchronous read and write for
 passthrough
Message-ID: <20201022161745.GC36774@google.com>
References: <20200924131318.2654747-1-balsini@android.com>
 <20200924131318.2654747-4-balsini@android.com>
 <CAJfpegu=0QtzqSOGi_yd48eL3hgG1Hqf_YO2prWeiHBwwMHZyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegu=0QtzqSOGi_yd48eL3hgG1Hqf_YO2prWeiHBwwMHZyA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 30, 2020 at 08:50:46PM +0200, Miklos Szeredi wrote:
> > [...]
> > +ssize_t fuse_passthrough_read_iter(struct kiocb *iocb_fuse,
> > +                                  struct iov_iter *iter)
> > +{
> > +       ssize_t ret;
> > +       const struct cred *old_cred;
> > +       struct file *fuse_filp = iocb_fuse->ki_filp;
> > +       struct fuse_file *ff = fuse_filp->private_data;
> > +       struct file *passthrough_filp = ff->passthrough_filp;
> > +
> > +       if (!iov_iter_count(iter))
> > +               return 0;
> > +
> > +       old_cred = fuse_passthrough_override_creds(fuse_filp);
> > +       if (is_sync_kiocb(iocb_fuse)) {
> > +               ret = vfs_iter_read(passthrough_filp, iter, &iocb_fuse->ki_pos,
> > +                                   iocbflags_to_rwf(iocb_fuse->ki_flags));
> > +       } else {
> > +               ret = -EIO;
> > +       }
> 
> Just do vfs_iter_read() unconditionally, instead of returning EIO.
> It will work fine, except it won't be async.
> 
> Yeah, I know next patch is going to fix this, but still, lets not make
> this patch return silly errors.
> 
> > [...]
> > +ssize_t fuse_passthrough_write_iter(struct kiocb *iocb_fuse,
> > +                                   struct iov_iter *iter)
> > +{
> > +       ssize_t ret;
> > +       const struct cred *old_cred;
> > +       struct file *fuse_filp = iocb_fuse->ki_filp;
> > +       struct fuse_file *ff = fuse_filp->private_data;
> > +       struct inode *fuse_inode = file_inode(fuse_filp);
> > +       struct file *passthrough_filp = ff->passthrough_filp;
> > +
> > +       if (!iov_iter_count(iter))
> > +               return 0;
> > +
> > +       inode_lock(fuse_inode);
> > +
> > +       old_cred = fuse_passthrough_override_creds(fuse_filp);
> > +       if (is_sync_kiocb(iocb_fuse)) {
> > +               file_start_write(passthrough_filp);
> > +               ret = vfs_iter_write(passthrough_filp, iter, &iocb_fuse->ki_pos,
> > +                                   iocbflags_to_rwf(iocb_fuse->ki_flags));
> > +               file_end_write(passthrough_filp);
> > +               if (ret > 0)
> > +                       fuse_copyattr(fuse_filp, passthrough_filp);
> > +       } else {
> > +               ret = -EIO;
> > +       }
> 
> And the same here.
> 

Ack, adding both to the upcoming patch set.

Thanks,
Alessio
