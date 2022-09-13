Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC3B5B6B82
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Sep 2022 12:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbiIMKUs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Sep 2022 06:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231143AbiIMKUr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Sep 2022 06:20:47 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 580F156BB9
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Sep 2022 03:20:46 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id e17so16851101edc.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Sep 2022 03:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=aE4/Rc6oywBWjxqba5cZUvxLK9vy2/D6P+b5NpkWBrA=;
        b=N9cfSBtLn66CqN3msM3gmuAtt5TGZG7FQBj+9MhJnjkHO+lBW6GKos5Yfx8GNTZp1H
         CbrmKGGYuLwfEHeMuhzHzRV+ZuNPPdypzHp2Uw5EVpVyBxHIhtdhny/2CSbT2j40bj23
         8UcaCoxllUCpqkgGt7nxxseALBVnbtGLmntK4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=aE4/Rc6oywBWjxqba5cZUvxLK9vy2/D6P+b5NpkWBrA=;
        b=lps9V2CstfBgPQbiVpdQ+MYdnkSEJz9f6phnI7uKVx5QHxk0vXDU9gMjMHe6CcdCHu
         UW1rRg48QzKNpFZNTmNAh/ZjMGVDJcqZeQNJAwQv72mz8oiSeLy9wNjDIPNbXDsTv6Py
         M3NEVL31I6i117kD7+UnHEB5N/v1tBV46WDhyOPcAyaAbj3OCanGD7mtnWtfot4Av0xn
         RiXSJeVGG/YCwBnuO0C7OHPGtBZh6g4rR4VlvHWcaNzToP7X0hvzr5Eo7s/rPTXM5fdf
         tMmlt7Dnn0s1pfKLAVzj3exJ5UGk3oxbc1RWSTVpiPU0qHTVp5VAYSzxY6gd9or2Jft+
         ipdw==
X-Gm-Message-State: ACgBeo0xBdb9L2XtPpe7+kOTr9+E1MnHlpvLQulO3h9+HK9y+CFQjR+2
        E+fZL77sNjNj63+b1r4n7TZv9DRQfI1TY+o9JEwOwQ==
X-Google-Smtp-Source: AA6agR4eC3se5/g8DsNb7M7/RRq6AuBy7G2ouI5lhqGibkm88jfQRbPXmcgkiagcpZif5uEoKBQIK9t4gFluXSiP14A=
X-Received: by 2002:a05:6402:2289:b0:44e:f490:319a with SMTP id
 cw9-20020a056402228900b0044ef490319amr26074779edb.28.1663064444938; Tue, 13
 Sep 2022 03:20:44 -0700 (PDT)
MIME-Version: 1.0
References: <CAJfpegvsCQ+rJv2rSk3mUMsX_N26ardW=MYbHxifO5DU7uSYqA@mail.gmail.com>
 <20220831025704.240962-1-yulilin@google.com> <CAJfpegvMGxigBe=3tgwBRKuSS0H1ey=0WhOkgOz5di-LqXH-HQ@mail.gmail.com>
 <CAMW0D+epkBMTEzzJhkX7HeEepCH=yxJ-rytnA+XWQ8ao=CREqw@mail.gmail.com>
 <YxYbCt4/S4r2JHw2@miu.piliscsaba.redhat.com> <Yx/iGX+xGdqlnH73@ZenIV>
In-Reply-To: <Yx/iGX+xGdqlnH73@ZenIV>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 13 Sep 2022 12:20:33 +0200
Message-ID: <CAJfpegs=H+mUw1BeVnpSxtUeRGnjza-+0=uXxN2KRpvZESXTAA@mail.gmail.com>
Subject: Re: [PATCH 2/2] fuse: Implement O_TMPFILE support
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Yu-li Lin <yulilin@google.com>, chirantan@chromium.org,
        dgreid@chromium.org, fuse-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, suleiman@chromium.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 13 Sept 2022 at 03:51, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Mon, Sep 05, 2022 at 05:51:38PM +0200, Miklos Szeredi wrote:
> > On Wed, Aug 31, 2022 at 02:30:40PM -0700, Yu-li Lin wrote:
> > > Thanks for the reference. IIUC, the consensus is to make it atomic,
> > > although there's no agreement on how it should be done. Does that mean
> > > we should hold off on
> > > this patch until atomic temp files are figured out higher in the stack
> > > or do you have thoughts on how the fuse uapi should look like prior to
> > > the vfs/refactoring decision?
> >
> > Here's a patch refactoring the tmpfile kapi to return an open file instead of a
> > dentry.
> >
> > Comments?
>
> First and foremost: how many operations the interested filesystems (cifs,
> for one) are capable of for such beasts?  I can believe that FUSE can handle
> that, but can something like cifs do it?  Their protocol is pathname-based, IIRC;
> can they really handle that kind of files without something like sillyrename?
> Because if sillyrename and its analogues are in the game, we have seriously
> changed rules re directory locking, and we'd better figure that out first.
>
> IOW, I would really like to see proposed instances for FUSE and CIFS - the shape
> of the series seriously depends upon that.  Before we commit to calling conventions
> changes.

Was there a requirement for CIFS supporting tmpfile?  Is so where?

>
> That aside, some notes on the patch:
>
> * file->f_path.dentry all over the place is ugly and wrong.  If nothing else,
> d_tmpfile() could be converted to taking struct file * - nothing outside of
> ->tmpfile() instances is using it.
> * finish_tmpfile() parts would be less noisy if it was finish_tmpfile(file, errror),
> starting with if (error) return error;
> * a bit of weirdness in ext4:
> >       err = dquot_initialize(dir);
> >       if (err)
> > -             return err;
> > +             goto out;
> Huh?  Your out: starts with if (err) return err;  Sure, compiler
> will figure it out, but what have human readers done to you?
> * similar in shmem:
> > +out:
> > +     if (error)
> > +             return error;
> > +
> > +     return finish_tmpfile(file);
> >  out_iput:
> >       iput(inode);
> > -     return error;
> > +     goto out;
> How the hell would it ever get to out_iput: with error == 0?
> * in your vfs_tmpfile() wrapper
> > +     child = ERR_CAST(file);
> > +     if (!IS_ERR(file)) {
> > +             error = vfs_tmpfile_new(mnt_userns, path, file, mode);
> > +             child = error ? ERR_PTR(error) : dget(file->f_path.dentry);
> > +             fput(file);
> > +     }
> > +     return child;
> This really ought to be
>         if (IS_ERR(file))
>                 return ERR_CAST(file);
>         ...
> IS_ERR() comes with implicit unlikely()...
>

Agreed with all of the above.

>
> Next, there are users outside of do_o_tmpfile().  The one in cachefiles
> is a prime candidate for combining with open - the stuff done between
> vfs_tmpfile() and opening the sucker consists of
>         * cachefiles_ondemand_init_object() - takes no cleanup on
> later failure exits, doesn't know anything about dentry created.  Might
> as well be done before vfs_tmpfile().
>         * cachefiles_mark_inode_in_use() - which really can't fail there,
> and the only thing being done is marking the sucker with S_KERNEL_FILE.
> Could be done after opening just as well.
>         * vfs_truncate() used to expand to required size.  Trivially done
> after opening, and we probably want struct file there - there's a reason
> why ftruncate(2) sets ATTR_FILE/ia_file...  We are unlikely to use
> anything like FUSE for cachefiles, but leaving traps like that is a bad
> idea.
> IOW, cachefiles probably wants a preliminary patch series that would
> massage it to the "tmpfile right next to open, the use struct file"
> form.

Sure, that would have been the next step after the API is settled.

> Another user is overlayfs, and that's going to get painful.  It checks for
> ->tmpfile() working and if it does work, we use it for copyup.  The trouble
> is, will e.g. FUSE be ready to handle things like setxattr on such dentries?
> It's not just a matter of copying the data - there we would be quite fine
> with opened file; it's somewhat clumsy since copyup is done for FIFOs, etc.,
> but that could be dealt with.  But things like setting metadata are done
> by dentry there.  And with your patch the file will have been closed by
> the time we get to that part.  Can e.g. FUSE deal with that?

At the moment FUSE is not supported as upper layer, so it's a non-issue.

But I don't see why copy-up can't be fixed to keep the tmp file open.
In fact that's something I also want to do once the interface is
agreed upon.

Thanks,
Miklos
