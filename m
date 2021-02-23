Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EFBD322F0C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Feb 2021 17:48:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233619AbhBWQsh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Feb 2021 11:48:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232252AbhBWQsb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Feb 2021 11:48:31 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57F7DC061574;
        Tue, 23 Feb 2021 08:47:49 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id a7so17782617iok.12;
        Tue, 23 Feb 2021 08:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WmAo5L2wPiNmCxX2SsMhVwmNiNfH0lB7kdUrYra76uE=;
        b=Z91Mgq8GTZJM5BUXteX5qcyJRjuqkzGnyNdWSwaAwN+5Wm4/MKkHXOLBXhulJwMnzo
         Tf0RoVm5tWWpbw2/0Ym0YX4AYBflCBaku3oIJ34b1p9V5+Kd7/omL58YyTMa+DcLGJ4l
         SKRwA5t08vJhqkPl5onWh1OlFK2/vGUfJbPuy9PZHp6v/zKMGtdjtAl8nieCLS/MGOhI
         aJoACLyDdBDCjgicy3bcpyCZszGVXOGw1oatvTjmVKn4nVu5hodtg7hKm2XlHXqALhoX
         w2Lqzcu4wY6toPAC42wVTDkWiBXbgCKMzySFWHRF1dc91tNlu+dGTHSceJzq20lkTLD3
         pq+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WmAo5L2wPiNmCxX2SsMhVwmNiNfH0lB7kdUrYra76uE=;
        b=SWBDCHJ1FtVIgwZOKJoUqmcA6Owy4sAoInteO9EOhFHHn/Jb0Wm36/WxznZOi6REmB
         BcpH/zpunLsX1e6BZ9EpM2FoYmTDO48XFiUw6CIkrOacfU6Xir8KwsSuLccuf+WQz6S7
         z1SByjQa0yCBI1CP9E0coxZM4/FwULwMTzVqxj8j6Khh4CFjyYHgRZmS1C/BHL9w4Q/1
         l3wmzCSJ6mOpt5qR1BWWiTn1GsUxtD6Z2dgrw0b/NTkArd3OuHawNv5PbvVBcIhnPvPx
         7fCHOb5oCr7R/YkPGhK77MCVL4pDev/qpgkhR7sf/3JTgljtg1tSkJ5RsuImUle/VGu1
         Lz0g==
X-Gm-Message-State: AOAM5303hMsABb2wGQPxocogmkxaBfl3/LgPckcUUmjrvgNf4Bvjjqfa
        uvCnvWsLUbXj1a0433AEDl3ZV6hT8KP0lVF4QyF9x+WjhCc=
X-Google-Smtp-Source: ABdhPJw02yGOSJai1Gc5mY3O1hHtanOAuGOa6GIZCf4oqrNGDrgPerk2sVR2tXo/5tJz+4oua6P7eKYlN0YRSiSowyA=
X-Received: by 2002:a05:6602:2c52:: with SMTP id x18mr20435300iov.5.1614098868675;
 Tue, 23 Feb 2021 08:47:48 -0800 (PST)
MIME-Version: 1.0
References: <20210221195833.23828-1-lhenriques@suse.de> <20210222102456.6692-1-lhenriques@suse.de>
 <26a22719-427a-75cf-92eb-dda10d442ded@oracle.com> <YDTZwH7xv41Wimax@suse.de>
 <7cc69c24-80dd-0053-24b9-3a28b0153f7e@oracle.com> <7c12e6a3-e4a6-5210-1b57-09072eac3270@oracle.com>
In-Reply-To: <7c12e6a3-e4a6-5210-1b57-09072eac3270@oracle.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 23 Feb 2021 18:47:37 +0200
Message-ID: <CAOQ4uxh2E2oJjHoOBY3GU__6UcjE67E7qR1uMus7f_xhQyM54g@mail.gmail.com>
Subject: Re: [PATCH v8] vfs: fix copy_file_range regression in cross-fs copies
To:     dai.ngo@oracle.com
Cc:     Luis Henriques <lhenriques@suse.de>,
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 23, 2021 at 6:02 PM <dai.ngo@oracle.com> wrote:
>
>
> On 2/23/21 7:29 AM, dai.ngo@oracle.com wrote:
> >
> > On 2/23/21 2:32 AM, Luis Henriques wrote:
> >> On Mon, Feb 22, 2021 at 08:25:27AM -0800, dai.ngo@oracle.com wrote:
> >>> On 2/22/21 2:24 AM, Luis Henriques wrote:
> >>>> A regression has been reported by Nicolas Boichat, found while
> >>>> using the
> >>>> copy_file_range syscall to copy a tracefs file.  Before commit
> >>>> 5dae222a5ff0 ("vfs: allow copy_file_range to copy across devices") the
> >>>> kernel would return -EXDEV to userspace when trying to copy a file
> >>>> across
> >>>> different filesystems.  After this commit, the syscall doesn't fail
> >>>> anymore
> >>>> and instead returns zero (zero bytes copied), as this file's
> >>>> content is
> >>>> generated on-the-fly and thus reports a size of zero.
> >>>>
> >>>> This patch restores some cross-filesystem copy restrictions that
> >>>> existed
> >>>> prior to commit 5dae222a5ff0 ("vfs: allow copy_file_range to copy
> >>>> across
> >>>> devices").  Filesystems are still allowed to fall-back to the VFS
> >>>> generic_copy_file_range() implementation, but that has now to be done
> >>>> explicitly.
> >>>>
> >>>> nfsd is also modified to fall-back into generic_copy_file_range()
> >>>> in case
> >>>> vfs_copy_file_range() fails with -EOPNOTSUPP or -EXDEV.
> >>>>
> >>>> Fixes: 5dae222a5ff0 ("vfs: allow copy_file_range to copy across
> >>>> devices")
> >>>> Link:
> >>>> https://urldefense.com/v3/__https://lore.kernel.org/linux-fsdevel/20210212044405.4120619-1-drinkcat@chromium.org/__;!!GqivPVa7Brio!P1UWThiSkxbjfjFQWNYJmCxGEkiLFyvHjH6cS-G1ZTt1z-TeqwGQgQmi49dC6w$
> >>>> Link:
> >>>> https://urldefense.com/v3/__https://lore.kernel.org/linux-fsdevel/CANMq1KDZuxir2LM5jOTm0xx*BnvW=ZmpsG47CyHFJwnw7zSX6Q@mail.gmail.com/__;Kw!!GqivPVa7Brio!P1UWThiSkxbjfjFQWNYJmCxGEkiLFyvHjH6cS-G1ZTt1z-TeqwGQgQmgCmMHzA$
> >>>> Link:
> >>>> https://urldefense.com/v3/__https://lore.kernel.org/linux-fsdevel/20210126135012.1.If45b7cdc3ff707bc1efa17f5366057d60603c45f@changeid/__;!!GqivPVa7Brio!P1UWThiSkxbjfjFQWNYJmCxGEkiLFyvHjH6cS-G1ZTt1z-TeqwGQgQmzqItkrQ$
> >>>> Reported-by: Nicolas Boichat <drinkcat@chromium.org>
> >>>> Signed-off-by: Luis Henriques <lhenriques@suse.de>
> >>>> ---
> >>>> Changes since v7
> >>>> - set 'ret' to '-EOPNOTSUPP' before the clone 'if' statement so
> >>>> that the
> >>>>     error returned is always related to the 'copy' operation
> >>>> Changes since v6
> >>>> - restored i_sb checks for the clone operation
> >>>> Changes since v5
> >>>> - check if ->copy_file_range is NULL before calling it
> >>>> Changes since v4
> >>>> - nfsd falls-back to generic_copy_file_range() only *if* it gets
> >>>> -EOPNOTSUPP
> >>>>     or -EXDEV.
> >>>> Changes since v3
> >>>> - dropped the COPY_FILE_SPLICE flag
> >>>> - kept the f_op's checks early in generic_copy_file_checks,
> >>>> implementing
> >>>>     Amir's suggestions
> >>>> - modified nfsd to use generic_copy_file_range()
> >>>> Changes since v2
> >>>> - do all the required checks earlier, in generic_copy_file_checks(),
> >>>>     adding new checks for ->remap_file_range
> >>>> - new COPY_FILE_SPLICE flag
> >>>> - don't remove filesystem's fallback to generic_copy_file_range()
> >>>> - updated commit changelog (and subject)
> >>>> Changes since v1 (after Amir review)
> >>>> - restored do_copy_file_range() helper
> >>>> - return -EOPNOTSUPP if fs doesn't implement CFR
> >>>> - updated commit description
> >>>>
> >>>>    fs/nfsd/vfs.c   |  8 +++++++-
> >>>>    fs/read_write.c | 49
> >>>> ++++++++++++++++++++++++-------------------------
> >>>>    2 files changed, 31 insertions(+), 26 deletions(-)
> >>>>
> >>>> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> >>>> index 04937e51de56..23dab0fa9087 100644
> >>>> --- a/fs/nfsd/vfs.c
> >>>> +++ b/fs/nfsd/vfs.c
> >>>> @@ -568,6 +568,7 @@ __be32 nfsd4_clone_file_range(struct nfsd_file
> >>>> *nf_src, u64 src_pos,
> >>>>    ssize_t nfsd_copy_file_range(struct file *src, u64 src_pos,
> >>>> struct file *dst,
> >>>>                     u64 dst_pos, u64 count)
> >>>>    {
> >>>> +    ssize_t ret;
> >>>>        /*
> >>>>         * Limit copy to 4MB to prevent indefinitely blocking an nfsd
> >>>> @@ -578,7 +579,12 @@ ssize_t nfsd_copy_file_range(struct file *src,
> >>>> u64 src_pos, struct file *dst,
> >>>>         * limit like this and pipeline multiple COPY requests.
> >>>>         */
> >>>>        count = min_t(u64, count, 1 << 22);
> >>>> -    return vfs_copy_file_range(src, src_pos, dst, dst_pos, count, 0);
> >>>> +    ret = vfs_copy_file_range(src, src_pos, dst, dst_pos, count, 0);
> >>>> +
> >>>> +    if (ret == -EOPNOTSUPP || ret == -EXDEV)
> >>>> +        ret = generic_copy_file_range(src, src_pos, dst, dst_pos,
> >>>> +                          count, 0);
> >>>> +    return ret;
> >>>>    }
> >>>>    __be32 nfsd4_vfs_fallocate(struct svc_rqst *rqstp, struct svc_fh
> >>>> *fhp,
> >>>> diff --git a/fs/read_write.c b/fs/read_write.c
> >>>> index 75f764b43418..5a26297fd410 100644
> >>>> --- a/fs/read_write.c
> >>>> +++ b/fs/read_write.c
> >>>> @@ -1388,28 +1388,6 @@ ssize_t generic_copy_file_range(struct file
> >>>> *file_in, loff_t pos_in,
> >>>>    }
> >>>>    EXPORT_SYMBOL(generic_copy_file_range);
> >>>> -static ssize_t do_copy_file_range(struct file *file_in, loff_t
> >>>> pos_in,
> >>>> -                  struct file *file_out, loff_t pos_out,
> >>>> -                  size_t len, unsigned int flags)
> >>>> -{
> >>>> -    /*
> >>>> -     * Although we now allow filesystems to handle cross sb copy,
> >>>> passing
> >>>> -     * a file of the wrong filesystem type to filesystem driver
> >>>> can result
> >>>> -     * in an attempt to dereference the wrong type of
> >>>> ->private_data, so
> >>>> -     * avoid doing that until we really have a good reason.  NFS
> >>>> defines
> >>>> -     * several different file_system_type structures, but they all
> >>>> end up
> >>>> -     * using the same ->copy_file_range() function pointer.
> >>>> -     */
> >>>> -    if (file_out->f_op->copy_file_range &&
> >>>> -        file_out->f_op->copy_file_range ==
> >>>> file_in->f_op->copy_file_range)
> >>>> -        return file_out->f_op->copy_file_range(file_in, pos_in,
> >>>> -                               file_out, pos_out,
> >>>> -                               len, flags);
> >>>> -
> >>>> -    return generic_copy_file_range(file_in, pos_in, file_out,
> >>>> pos_out, len,
> >>>> -                       flags);
> >>>> -}
> >>>> -
> >>>>    /*
> >>>>     * Performs necessary checks before doing a file copy
> >>>>     *
> >>>> @@ -1427,6 +1405,25 @@ static int generic_copy_file_checks(struct
> >>>> file *file_in, loff_t pos_in,
> >>>>        loff_t size_in;
> >>>>        int ret;
> >>>> +    /*
> >>>> +     * Although we now allow filesystems to handle cross sb copy,
> >>>> passing
> >>>> +     * a file of the wrong filesystem type to filesystem driver
> >>>> can result
> >>>> +     * in an attempt to dereference the wrong type of
> >>>> ->private_data, so
> >>>> +     * avoid doing that until we really have a good reason.  NFS
> >>>> defines
> >>>> +     * several different file_system_type structures, but they all
> >>>> end up
> >>>> +     * using the same ->copy_file_range() function pointer.
> >>>> +     */
> >>>> +    if (file_out->f_op->copy_file_range) {
> >>>> +        if (file_in->f_op->copy_file_range !=
> >>>> +            file_out->f_op->copy_file_range)
> >>>> +            return -EXDEV;
> >>>> +    } else if (file_in->f_op->remap_file_range) {
> >>>> +        if (file_inode(file_in)->i_sb != file_inode(file_out)->i_sb)
> >>>> +            return -EXDEV;
> >>> I think this check is redundant, it's done in vfs_copy_file_range.
> >>> If this check is removed then the else clause below should be removed
> >>> also. Once this check and the else clause are removed then might as
> >>> well move the the check of copy_file_range from here to
> >>> vfs_copy_file_range.
> >>>
> >> I don't think it's really redundant, although I agree is messy due to
> >> the
> >> fact we try to clone first instead of copying them.
> >>
> >> So, in the clone path, this is the only place where we return -EXDEV if:
> >>
> >> 1) we don't have ->copy_file_range *and*
> >> 2) we have ->remap_file_range but the i_sb are different.
> >>
> >> The check in vfs_copy_file_range() is only executed if:
> >>
> >> 1) we have *valid* ->copy_file_range ops and/or
> >> 2) we have *valid* ->remap_file_range
> >>
> >> So... if we remove the check in generic_copy_file_checks() as you
> >> suggest
> >> and:
> >> - we don't have ->copy_file_range,
> >> - we have ->remap_file_range but
> >> - the i_sb are different
> >>
> >> we'll return the -EOPNOTSUPP (the one set in line "ret =
> >> -EOPNOTSUPP;" in
> >> function vfs_copy_file_range() ) instead of -EXDEV.
> >
> > Yes, this is the different.The NFS code handles both -EOPNOTSUPP and
> > -EXDEVV by doing generic_copy_file_range.  Do any other consumers of
> > vfs_copy_file_range rely on -EXDEV and not -EOPNOTSUPP and which is
> > the correct error code for this case? It seems to me that -EOPNOTSUPP
> > is more appropriate than EXDEV when (sb1 != sb2).
>

EXDEV is the right code for:
filesystem supports the operation but not for sb1 != sb1.

> So with the current patch, for a clone operation across 2 filesystems:
>
>    . if src and dst filesystem support both copy_file_range and
>      map_file_range then the code returns -ENOTSUPPORT.
>

Why do you say that?
Which code are you referring to exactly?
Did you see this behavior in a test?

>    . if the filesystems only support map_file_range then the
>      code returns -EXDEV
>
> This seems confusing, shouldn't only 1 error code returned for this case?
>

From my read of the code, user will get -EXDEV in both the cases you
listed.

Thanks,
Amir.
