Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1477E43982
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2019 17:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388373AbfFMPON (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jun 2019 11:14:13 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:46313 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732254AbfFMN3C (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jun 2019 09:29:02 -0400
Received: by mail-yb1-f196.google.com with SMTP id p8so7808028ybo.13;
        Thu, 13 Jun 2019 06:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=07p62ncGb8nczxYUGigIhwh8bBgfXLhsK5lyKT95rQc=;
        b=bli5xX8kw1TJNS9Yc9JUR2ez8EpVvO/W5Sa6VpdQ6aEAIAJHFOuCpVwgjPMUiUAP+d
         maJfBsLOzcSI0ncfuXbcGo24dUFTV/kPb9UZuMp/eWZM6+D4pwxuiW20C1AnvVWULIU5
         +5Z7QBgBb4B4InmEkHDoxWK+CV0E4Y44kSKg+wumOfVdCOTxUhy3BWuxLj8d3Khj/Xrx
         UT2AtnWNMyyQi/13z+PQjqy5EOmAGjM+4B9F7uT+BKvopi+UClAG871rTI8EPzT8N9GP
         jhVHrw2n+rVWsgVKqgIwDCiVy9vSwX1F4VpSuLenZNJ3Sg2L2KJmECpM9AfDQZCyK61Y
         Tlvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=07p62ncGb8nczxYUGigIhwh8bBgfXLhsK5lyKT95rQc=;
        b=YiJgNSx5PxEGexFCjNns7Doo50lYC4BJAm5l5opx+hpEV5fq0nE+Fpjj3Wc4sE7AoJ
         Jn92bIjg9Tv66FdkLfFwq3lsq+ocVJ6Z69qslhRJqkcitxAkYpYck34F2HRmEe5QXfq8
         5Z2wganAV1yolPAmstcCVOZ56SanNB4eBlaKEBFGwtKh0u7QCQWZ6svhZ0iWN8PN5+xn
         U3tnHt7TRQbUHNgHg5o+4AAW8vO4RDlk8W/GbrvF2+9RngwPpV+fztLEqdm3MxmGkxUU
         Kp7iEtE5kP3jQd7eepXkxRA4XmgQCV4LOtOm71i6uPndRdu1iez3RSbaxz+7k3jnU8Vc
         ZM7A==
X-Gm-Message-State: APjAAAVV+wX31UM6B/LrkzFC8f5pyoBZ19vJ6knrxqlTehyNn1jkkB0O
        SHOl6KToP1nRivDZmC3IvUpSpe3rctMq2hrks3MlFw==
X-Google-Smtp-Source: APXvYqzXHuzeid5ENXFkiAQosxLiBljlB5FkM8PjLzY9xH1klWHlk1nSIThL9djBQWyya2nhwnQC4scTq22GNYaskzE=
X-Received: by 2002:a05:6902:4c3:: with SMTP id v3mr42689690ybs.144.1560432540877;
 Thu, 13 Jun 2019 06:29:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190612172408.22671-1-amir73il@gmail.com> <2851a6b983ed8b5b858b3b336e70296204349762.camel@kernel.org>
In-Reply-To: <2851a6b983ed8b5b858b3b336e70296204349762.camel@kernel.org>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 13 Jun 2019 16:28:49 +0300
Message-ID: <CAOQ4uxi-uEhAbqVeYbeqAR=TXpthZHdUKkaZJB7fy1TgdZObjQ@mail.gmail.com>
Subject: Re: [PATCH v2] locks: eliminate false positive conflicts for write lease
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 13, 2019 at 4:22 PM Jeff Layton <jlayton@kernel.org> wrote:
>
> On Wed, 2019-06-12 at 20:24 +0300, Amir Goldstein wrote:
> > check_conflicting_open() is checking for existing fd's open for read or
> > for write before allowing to take a write lease.  The check that was
> > implemented using i_count and d_count is an approximation that has
> > several false positives.  For example, overlayfs since v4.19, takes an
> > extra reference on the dentry; An open with O_PATH takes a reference on
> > the dentry although the file cannot be read nor written.
> >
> > Change the implementation to use i_readcount and i_writecount to
> > eliminate the false positive conflicts and allow a write lease to be
> > taken on an overlayfs file.
> >
> > The change of behavior with existing fd's open with O_PATH is symmetric
> > w.r.t. current behavior of lease breakers - an open with O_PATH currently
> > does not break a write lease.
> >
> > This increases the size of struct inode by 4 bytes on 32bit archs when
> > CONFIG_FILE_LOCKING is defined and CONFIG_IMA was not already
> > defined.
> >
> > Cc: <stable@vger.kernel.org> # v4.19
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> >
> > Miklos, Jeff and Bruce,
> >
> > This patch fixes a v4.19 overlayfs regression with taking write
> > leases. It also provides correct semantics w.r.t RDONLY open counter
> > that Bruce also needed for nfsd.
> >
> > Since this is locks code that fixes an overlayfs regression which
> > is also needed for nfsd, it could go via either of your trees.
> > I didn't want to pick sides, so first one to grab the patch wins ;-)
> >
> > I verified the changes using modified LTP F_SETLEASE tests [1],
> > which I ran over xfs and overlayfs.
> >
> > Thanks,
> > Amir.
> >
> > [1] https://github.com/amir73il/ltp/commits/overlayfs-devel
> >
> > Changes since v1:
> > - Drop patch to fold i_readcount into i_count
> > - Make i_readcount depend on CONFIG_FILE_LOCKING
> >
> >  fs/locks.c         | 33 ++++++++++++++++++++++-----------
> >  include/linux/fs.h |  4 ++--
> >  2 files changed, 24 insertions(+), 13 deletions(-)
> >
> > diff --git a/fs/locks.c b/fs/locks.c
> > index ec1e4a5df629..28528b4fc53b 100644
> > --- a/fs/locks.c
> > +++ b/fs/locks.c
> > @@ -1753,10 +1753,10 @@ int fcntl_getlease(struct file *filp)
> >  }
> >
> >  /**
> > - * check_conflicting_open - see if the given dentry points to a file that has
> > + * check_conflicting_open - see if the given file points to an inode that has
> >   *                       an existing open that would conflict with the
> >   *                       desired lease.
> > - * @dentry:  dentry to check
> > + * @filp:    file to check
> >   * @arg:     type of lease that we're trying to acquire
> >   * @flags:   current lock flags
> >   *
> > @@ -1764,19 +1764,31 @@ int fcntl_getlease(struct file *filp)
> >   * conflict with the lease we're trying to set.
> >   */
> >  static int
> > -check_conflicting_open(const struct dentry *dentry, const long arg, int flags)
> > +check_conflicting_open(struct file *filp, const long arg, int flags)
> >  {
> >       int ret = 0;
> > -     struct inode *inode = dentry->d_inode;
> > +     struct inode *inode = locks_inode(filp);
> > +     int wcount = atomic_read(&inode->i_writecount);
> > +     int self_wcount = 0, self_rcount = 0;
> >
> >       if (flags & FL_LAYOUT)
> >               return 0;
> >
> > -     if ((arg == F_RDLCK) && inode_is_open_for_write(inode))
> > +     if (arg == F_RDLCK && wcount > 0)
> >               return -EAGAIN;
> >
> > -     if ((arg == F_WRLCK) && ((d_count(dentry) > 1) ||
> > -         (atomic_read(&inode->i_count) > 1)))
> > +     /* Eliminate deny writes from actual writers count */
> > +     if (wcount < 0)
> > +             wcount = 0;
> > +
> > +     /* Make sure that only read/write count is from lease requestor */
> > +     if (filp->f_mode & FMODE_WRITE)
> > +             self_wcount = 1;
> > +     else if ((filp->f_mode & (FMODE_READ | FMODE_WRITE)) == FMODE_READ)
>
> nit: you already checked for FMODE_WRITE and you know that it's not set
> here, so this is equivalent to:
>
>     else if (filp->f_mode & FMODE_READ)
>

Right... I guess you or Miklos could fix this up on commit.
Let me know if you want a re-post.

> > +             self_rcount = 1;
> > +
> > +     if (arg == F_WRLCK && (wcount != self_wcount ||
> > +         atomic_read(&inode->i_readcount) != self_rcount))
> >               ret = -EAGAIN;
> >
> >       return ret;
> > @@ -1786,8 +1798,7 @@ static int
> >  generic_add_lease(struct file *filp, long arg, struct file_lock **flp, void **priv)
> >  {
> >       struct file_lock *fl, *my_fl = NULL, *lease;
> > -     struct dentry *dentry = filp->f_path.dentry;
> > -     struct inode *inode = dentry->d_inode;
> > +     struct inode *inode = locks_inode(filp);
> >       struct file_lock_context *ctx;
> >       bool is_deleg = (*flp)->fl_flags & FL_DELEG;
> >       int error;
> > @@ -1822,7 +1833,7 @@ generic_add_lease(struct file *filp, long arg, struct file_lock **flp, void **pr
> >       percpu_down_read(&file_rwsem);
> >       spin_lock(&ctx->flc_lock);
> >       time_out_leases(inode, &dispose);
> > -     error = check_conflicting_open(dentry, arg, lease->fl_flags);
> > +     error = check_conflicting_open(filp, arg, lease->fl_flags);
> >       if (error)
> >               goto out;
> >
> > @@ -1879,7 +1890,7 @@ generic_add_lease(struct file *filp, long arg, struct file_lock **flp, void **pr
> >        * precedes these checks.
> >        */
> >       smp_mb();
> > -     error = check_conflicting_open(dentry, arg, lease->fl_flags);
> > +     error = check_conflicting_open(filp, arg, lease->fl_flags);
> >       if (error) {
> >               locks_unlink_lock_ctx(lease);
> >               goto out;
> > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > index 79ffa2958bd8..2d55f1b64014 100644
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -694,7 +694,7 @@ struct inode {
> >       atomic_t                i_count;
> >       atomic_t                i_dio_count;
> >       atomic_t                i_writecount;
> > -#ifdef CONFIG_IMA
> > +#if defined(CONFIG_IMA) || defined(CONFIG_FILE_LOCKING)
> >       atomic_t                i_readcount; /* struct files open RO */
> >  #endif
> >       union {
> > @@ -2895,7 +2895,7 @@ static inline bool inode_is_open_for_write(const struct inode *inode)
> >       return atomic_read(&inode->i_writecount) > 0;
> >  }
> >
> > -#ifdef CONFIG_IMA
> > +#if defined(CONFIG_IMA) || defined(CONFIG_FILE_LOCKING)
> >  static inline void i_readcount_dec(struct inode *inode)
> >  {
> >       BUG_ON(!atomic_read(&inode->i_readcount));
>
>
> Looks good to me. Aside from the minor nit above:
>
>     Reviewed-by: Jeff Layton <jlayton@kernel.org>
>
> I have one file locking patch queued up for v5.3 so far, but nothing for
> v5.2. Miklos or Bruce, if either of you have anything to send to Linus
> for v5.2 would you mind taking this one too?
>

Well. I did send a fix patch to Miklos for a bug introduced in v5.2-rc4,
so...

> If not I can queue it up and get it to him after letting it soak in
> linux-next for a bit.
>

Thanks for review!
Amir.
