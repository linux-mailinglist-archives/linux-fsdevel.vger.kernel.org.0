Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE4E32300C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Feb 2021 18:56:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232986AbhBWR4B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Feb 2021 12:56:01 -0500
Received: from mx2.suse.de ([195.135.220.15]:58222 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232490AbhBWR4A (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Feb 2021 12:56:00 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EC5DCAFB5;
        Tue, 23 Feb 2021 17:55:17 +0000 (UTC)
Received: from localhost (brahms [local])
        by brahms (OpenSMTPD) with ESMTPA id c850542d;
        Tue, 23 Feb 2021 17:56:22 +0000 (UTC)
Date:   Tue, 23 Feb 2021 17:56:22 +0000
From:   Luis Henriques <lhenriques@suse.de>
To:     dai.ngo@oracle.com
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
Subject: Re: [PATCH v8] vfs: fix copy_file_range regression in cross-fs copies
Message-ID: <YDVBxh2agWAU+edl@suse.de>
References: <20210221195833.23828-1-lhenriques@suse.de>
 <20210222102456.6692-1-lhenriques@suse.de>
 <26a22719-427a-75cf-92eb-dda10d442ded@oracle.com>
 <YDTZwH7xv41Wimax@suse.de>
 <7cc69c24-80dd-0053-24b9-3a28b0153f7e@oracle.com>
 <7c12e6a3-e4a6-5210-1b57-09072eac3270@oracle.com>
 <CAOQ4uxh2E2oJjHoOBY3GU__6UcjE67E7qR1uMus7f_xhQyM54g@mail.gmail.com>
 <72c41310-85e4-16fe-8d9c-d42abe0566a9@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <72c41310-85e4-16fe-8d9c-d42abe0566a9@oracle.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 23, 2021 at 08:57:38AM -0800, dai.ngo@oracle.com wrote:
> 
> On 2/23/21 8:47 AM, Amir Goldstein wrote:
> > On Tue, Feb 23, 2021 at 6:02 PM <dai.ngo@oracle.com> wrote:
> > > 
> > > On 2/23/21 7:29 AM, dai.ngo@oracle.com wrote:
> > > > On 2/23/21 2:32 AM, Luis Henriques wrote:
> > > > > On Mon, Feb 22, 2021 at 08:25:27AM -0800, dai.ngo@oracle.com wrote:
> > > > > > On 2/22/21 2:24 AM, Luis Henriques wrote:
> > > > > > > A regression has been reported by Nicolas Boichat, found while
> > > > > > > using the
> > > > > > > copy_file_range syscall to copy a tracefs file.  Before commit
> > > > > > > 5dae222a5ff0 ("vfs: allow copy_file_range to copy across devices") the
> > > > > > > kernel would return -EXDEV to userspace when trying to copy a file
> > > > > > > across
> > > > > > > different filesystems.  After this commit, the syscall doesn't fail
> > > > > > > anymore
> > > > > > > and instead returns zero (zero bytes copied), as this file's
> > > > > > > content is
> > > > > > > generated on-the-fly and thus reports a size of zero.
> > > > > > > 
> > > > > > > This patch restores some cross-filesystem copy restrictions that
> > > > > > > existed
> > > > > > > prior to commit 5dae222a5ff0 ("vfs: allow copy_file_range to copy
> > > > > > > across
> > > > > > > devices").  Filesystems are still allowed to fall-back to the VFS
> > > > > > > generic_copy_file_range() implementation, but that has now to be done
> > > > > > > explicitly.
> > > > > > > 
> > > > > > > nfsd is also modified to fall-back into generic_copy_file_range()
> > > > > > > in case
> > > > > > > vfs_copy_file_range() fails with -EOPNOTSUPP or -EXDEV.
> > > > > > > 
> > > > > > > Fixes: 5dae222a5ff0 ("vfs: allow copy_file_range to copy across
> > > > > > > devices")
> > > > > > > Link:
> > > > > > > https://urldefense.com/v3/__https://lore.kernel.org/linux-fsdevel/20210212044405.4120619-1-drinkcat@chromium.org/__;!!GqivPVa7Brio!P1UWThiSkxbjfjFQWNYJmCxGEkiLFyvHjH6cS-G1ZTt1z-TeqwGQgQmi49dC6w$
> > > > > > > Link:
> > > > > > > https://urldefense.com/v3/__https://lore.kernel.org/linux-fsdevel/CANMq1KDZuxir2LM5jOTm0xx*BnvW=ZmpsG47CyHFJwnw7zSX6Q@mail.gmail.com/__;Kw!!GqivPVa7Brio!P1UWThiSkxbjfjFQWNYJmCxGEkiLFyvHjH6cS-G1ZTt1z-TeqwGQgQmgCmMHzA$
> > > > > > > Link:
> > > > > > > https://urldefense.com/v3/__https://lore.kernel.org/linux-fsdevel/20210126135012.1.If45b7cdc3ff707bc1efa17f5366057d60603c45f@changeid/__;!!GqivPVa7Brio!P1UWThiSkxbjfjFQWNYJmCxGEkiLFyvHjH6cS-G1ZTt1z-TeqwGQgQmzqItkrQ$
> > > > > > > Reported-by: Nicolas Boichat <drinkcat@chromium.org>
> > > > > > > Signed-off-by: Luis Henriques <lhenriques@suse.de>
> > > > > > > ---
> > > > > > > Changes since v7
> > > > > > > - set 'ret' to '-EOPNOTSUPP' before the clone 'if' statement so
> > > > > > > that the
> > > > > > >      error returned is always related to the 'copy' operation
> > > > > > > Changes since v6
> > > > > > > - restored i_sb checks for the clone operation
> > > > > > > Changes since v5
> > > > > > > - check if ->copy_file_range is NULL before calling it
> > > > > > > Changes since v4
> > > > > > > - nfsd falls-back to generic_copy_file_range() only *if* it gets
> > > > > > > -EOPNOTSUPP
> > > > > > >      or -EXDEV.
> > > > > > > Changes since v3
> > > > > > > - dropped the COPY_FILE_SPLICE flag
> > > > > > > - kept the f_op's checks early in generic_copy_file_checks,
> > > > > > > implementing
> > > > > > >      Amir's suggestions
> > > > > > > - modified nfsd to use generic_copy_file_range()
> > > > > > > Changes since v2
> > > > > > > - do all the required checks earlier, in generic_copy_file_checks(),
> > > > > > >      adding new checks for ->remap_file_range
> > > > > > > - new COPY_FILE_SPLICE flag
> > > > > > > - don't remove filesystem's fallback to generic_copy_file_range()
> > > > > > > - updated commit changelog (and subject)
> > > > > > > Changes since v1 (after Amir review)
> > > > > > > - restored do_copy_file_range() helper
> > > > > > > - return -EOPNOTSUPP if fs doesn't implement CFR
> > > > > > > - updated commit description
> > > > > > > 
> > > > > > >     fs/nfsd/vfs.c   |  8 +++++++-
> > > > > > >     fs/read_write.c | 49
> > > > > > > ++++++++++++++++++++++++-------------------------
> > > > > > >     2 files changed, 31 insertions(+), 26 deletions(-)
> > > > > > > 
> > > > > > > diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> > > > > > > index 04937e51de56..23dab0fa9087 100644
> > > > > > > --- a/fs/nfsd/vfs.c
> > > > > > > +++ b/fs/nfsd/vfs.c
> > > > > > > @@ -568,6 +568,7 @@ __be32 nfsd4_clone_file_range(struct nfsd_file
> > > > > > > *nf_src, u64 src_pos,
> > > > > > >     ssize_t nfsd_copy_file_range(struct file *src, u64 src_pos,
> > > > > > > struct file *dst,
> > > > > > >                      u64 dst_pos, u64 count)
> > > > > > >     {
> > > > > > > +    ssize_t ret;
> > > > > > >         /*
> > > > > > >          * Limit copy to 4MB to prevent indefinitely blocking an nfsd
> > > > > > > @@ -578,7 +579,12 @@ ssize_t nfsd_copy_file_range(struct file *src,
> > > > > > > u64 src_pos, struct file *dst,
> > > > > > >          * limit like this and pipeline multiple COPY requests.
> > > > > > >          */
> > > > > > >         count = min_t(u64, count, 1 << 22);
> > > > > > > -    return vfs_copy_file_range(src, src_pos, dst, dst_pos, count, 0);
> > > > > > > +    ret = vfs_copy_file_range(src, src_pos, dst, dst_pos, count, 0);
> > > > > > > +
> > > > > > > +    if (ret == -EOPNOTSUPP || ret == -EXDEV)
> > > > > > > +        ret = generic_copy_file_range(src, src_pos, dst, dst_pos,
> > > > > > > +                          count, 0);
> > > > > > > +    return ret;
> > > > > > >     }
> > > > > > >     __be32 nfsd4_vfs_fallocate(struct svc_rqst *rqstp, struct svc_fh
> > > > > > > *fhp,
> > > > > > > diff --git a/fs/read_write.c b/fs/read_write.c
> > > > > > > index 75f764b43418..5a26297fd410 100644
> > > > > > > --- a/fs/read_write.c
> > > > > > > +++ b/fs/read_write.c
> > > > > > > @@ -1388,28 +1388,6 @@ ssize_t generic_copy_file_range(struct file
> > > > > > > *file_in, loff_t pos_in,
> > > > > > >     }
> > > > > > >     EXPORT_SYMBOL(generic_copy_file_range);
> > > > > > > -static ssize_t do_copy_file_range(struct file *file_in, loff_t
> > > > > > > pos_in,
> > > > > > > -                  struct file *file_out, loff_t pos_out,
> > > > > > > -                  size_t len, unsigned int flags)
> > > > > > > -{
> > > > > > > -    /*
> > > > > > > -     * Although we now allow filesystems to handle cross sb copy,
> > > > > > > passing
> > > > > > > -     * a file of the wrong filesystem type to filesystem driver
> > > > > > > can result
> > > > > > > -     * in an attempt to dereference the wrong type of
> > > > > > > ->private_data, so
> > > > > > > -     * avoid doing that until we really have a good reason.  NFS
> > > > > > > defines
> > > > > > > -     * several different file_system_type structures, but they all
> > > > > > > end up
> > > > > > > -     * using the same ->copy_file_range() function pointer.
> > > > > > > -     */
> > > > > > > -    if (file_out->f_op->copy_file_range &&
> > > > > > > -        file_out->f_op->copy_file_range ==
> > > > > > > file_in->f_op->copy_file_range)
> > > > > > > -        return file_out->f_op->copy_file_range(file_in, pos_in,
> > > > > > > -                               file_out, pos_out,
> > > > > > > -                               len, flags);
> > > > > > > -
> > > > > > > -    return generic_copy_file_range(file_in, pos_in, file_out,
> > > > > > > pos_out, len,
> > > > > > > -                       flags);
> > > > > > > -}
> > > > > > > -
> > > > > > >     /*
> > > > > > >      * Performs necessary checks before doing a file copy
> > > > > > >      *
> > > > > > > @@ -1427,6 +1405,25 @@ static int generic_copy_file_checks(struct
> > > > > > > file *file_in, loff_t pos_in,
> > > > > > >         loff_t size_in;
> > > > > > >         int ret;
> > > > > > > +    /*
> > > > > > > +     * Although we now allow filesystems to handle cross sb copy,
> > > > > > > passing
> > > > > > > +     * a file of the wrong filesystem type to filesystem driver
> > > > > > > can result
> > > > > > > +     * in an attempt to dereference the wrong type of
> > > > > > > ->private_data, so
> > > > > > > +     * avoid doing that until we really have a good reason.  NFS
> > > > > > > defines
> > > > > > > +     * several different file_system_type structures, but they all
> > > > > > > end up
> > > > > > > +     * using the same ->copy_file_range() function pointer.
> > > > > > > +     */
> > > > > > > +    if (file_out->f_op->copy_file_range) {
> > > > > > > +        if (file_in->f_op->copy_file_range !=
> > > > > > > +            file_out->f_op->copy_file_range)
> > > > > > > +            return -EXDEV;
> > > > > > > +    } else if (file_in->f_op->remap_file_range) {
> > > > > > > +        if (file_inode(file_in)->i_sb != file_inode(file_out)->i_sb)
> > > > > > > +            return -EXDEV;
> > > > > > I think this check is redundant, it's done in vfs_copy_file_range.
> > > > > > If this check is removed then the else clause below should be removed
> > > > > > also. Once this check and the else clause are removed then might as
> > > > > > well move the the check of copy_file_range from here to
> > > > > > vfs_copy_file_range.
> > > > > > 
> > > > > I don't think it's really redundant, although I agree is messy due to
> > > > > the
> > > > > fact we try to clone first instead of copying them.
> > > > > 
> > > > > So, in the clone path, this is the only place where we return -EXDEV if:
> > > > > 
> > > > > 1) we don't have ->copy_file_range *and*
> > > > > 2) we have ->remap_file_range but the i_sb are different.
> > > > > 
> > > > > The check in vfs_copy_file_range() is only executed if:
> > > > > 
> > > > > 1) we have *valid* ->copy_file_range ops and/or
> > > > > 2) we have *valid* ->remap_file_range
> > > > > 
> > > > > So... if we remove the check in generic_copy_file_checks() as you
> > > > > suggest
> > > > > and:
> > > > > - we don't have ->copy_file_range,
> > > > > - we have ->remap_file_range but
> > > > > - the i_sb are different
> > > > > 
> > > > > we'll return the -EOPNOTSUPP (the one set in line "ret =
> > > > > -EOPNOTSUPP;" in
> > > > > function vfs_copy_file_range() ) instead of -EXDEV.
> > > > Yes, this is the different.The NFS code handles both -EOPNOTSUPP and
> > > > -EXDEVV by doing generic_copy_file_range.  Do any other consumers of
> > > > vfs_copy_file_range rely on -EXDEV and not -EOPNOTSUPP and which is
> > > > the correct error code for this case? It seems to me that -EOPNOTSUPP
> > > > is more appropriate than EXDEV when (sb1 != sb2).
> > EXDEV is the right code for:
> > filesystem supports the operation but not for sb1 != sb1.
> > 
> > > So with the current patch, for a clone operation across 2 filesystems:
> > > 
> > >     . if src and dst filesystem support both copy_file_range and
> > >       map_file_range then the code returns -ENOTSUPPORT.
> > > 
> > Why do you say that?
> > Which code are you referring to exactly?
> 
> If the filesystems support both copy_file_range and map_file_range,
> it passes the check in generic_file_check but it fails with the
> check in vfs_copy_file_range and returns -ENOTSUPPORT (added by
> the v8 patch)

I'm sorry but I can't simply see where this can happen.  If both syscalls
are present (and all other checks pass), the code will first try the
->map_file_range.  If that succeeds, it bails out; if that fails, it tries
the ->copy_file_range.  The -ENOTSUPPORT is just there for the case the
->map_file_range fails and ->copy_file_range isn't implemented.

[ <sigh> It would be so much easier if we didn't attempt to clone. ]

But as I said previously, I'm way beyond embarrassment now as I failed to
see too many obvious mistakes in previous versions :-)

Cheers,
--
Luís
