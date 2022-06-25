Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26D4455A778
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Jun 2022 08:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231934AbiFYG32 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 25 Jun 2022 02:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiFYG31 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 25 Jun 2022 02:29:27 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C553049262;
        Fri, 24 Jun 2022 23:29:25 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id o13so4190369vsn.4;
        Fri, 24 Jun 2022 23:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=No377ue9hliAlnVVrUT0TAHGwczfAk1MaBYXRRYSwqg=;
        b=Jcxy/I7faYxnifozntghRx9UogO9EowLcxWpd/bkVi2USX+W4muKaqbgsUnS1jKeYR
         KfLQgAC2Y19ZlYxhbASD1PT1k6dWjZRNbhIry7wRKGnVMr5PKIKipctdIyhdc30ZjaoS
         u4/BRVXXwE/QWdC8KonhXGsUG9D3qFXQOxBbOgzUj6ZfXK1ypy0tfV1gjQYD38B/6pXg
         dA4Jh2N+fyG3OA1ELBbHHow1KZqzl150/BtzJ4RnRyO+CPG9pbuRTfGwDDLLyXQ/xVTu
         hDbFMEdTGFxleBiKkazncVLTtTrD/Xe7uTq23wlBLcSbGF7ZfD6NSlt1PDRWDCnWM++F
         UtBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=No377ue9hliAlnVVrUT0TAHGwczfAk1MaBYXRRYSwqg=;
        b=5kEF2PqeW5rlzAFHUtKwS5dFWmnX/qRt9gvb1r52nBkmhHcetZF7yEf/Y7c3TdYZ/d
         SO+mLz+uq3Lz/R4hfwQ+NM89WF3gIlDwQhLk0weA83C4lc2DkSFZ1ISu6Wd7/V7nBO3k
         b68xRJnYKptjHGh8Zs+pRJ7BNFim61qKc+/hL7H2XpjRwlbNM5KHp/VJtGtZmq4mUVrh
         qMGau8CbtWKxLl57Pelpxx1Wl5rPXngd9JkbmxAYepLYaXJYi2PIrVjF0KRnSXgjQQmL
         VSzTl0yqEodccDpYrnduJ3gbR0MPTRdEywTwwBOGHlF4RGSAT2C/76VkKi7erNit14Ix
         B1UA==
X-Gm-Message-State: AJIora8zhZF9k1CJEjjqULVkDSPcr5RzwJY49brXY1AgvcjLeqQs8gCH
        GtJT4IxKGU5BG+9lLLF2vfSEpM0rVX2cnJNnDqY=
X-Google-Smtp-Source: AGRyM1sWlRTjrPUdXCM+CmS/wIuwle9k9i0tRbSDRk3K+OVJKbYtwhxtO/66ssF1WCyXExyXhU66erb7HMe29IkzMIU=
X-Received: by 2002:a05:6102:5dc:b0:354:63f1:df8d with SMTP id
 v28-20020a05610205dc00b0035463f1df8dmr807788vsf.72.1656138564795; Fri, 24 Jun
 2022 23:29:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220617103338.1654418-1-amir73il@gmail.com>
In-Reply-To: <20220617103338.1654418-1-amir73il@gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 25 Jun 2022 09:29:13 +0300
Message-ID: <CAOQ4uxiaZAxgRPP5QvakKgsqG-6G=PkN9o3ho46TXY8+sDTu1g@mail.gmail.com>
Subject: Re: [PATCH v16] vfs: fix copy_file_range() regression in cross-fs copies
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Namjae Jeon <linkinjeon@kernel.org>,
        Luis Henriques <lhenriques@suse.com>,
        Steve French <smfrench@gmail.com>,
        Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        Dave Chinner <david@fromorbit.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        He Zhe <zhe.he@windriver.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        kernel test robot <oliver.sang@intel.com>,
        Luis Henriques <lhenriques@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 17, 2022 at 1:33 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> A regression has been reported by Nicolas Boichat, found while using the
> copy_file_range syscall to copy a tracefs file.  Before commit
> 5dae222a5ff0 ("vfs: allow copy_file_range to copy across devices") the
> kernel would return -EXDEV to userspace when trying to copy a file across
> different filesystems.  After this commit, the syscall doesn't fail anymore
> and instead returns zero (zero bytes copied), as this file's content is
> generated on-the-fly and thus reports a size of zero.
>
> Another regression has been reported by He Zhe - the assertion of
> WARN_ON_ONCE(ret == -EOPNOTSUPP) can be triggered from userspace when
> copying from a sysfs file whose read operation may return -EOPNOTSUPP.
>
> Since we do not have test coverage for copy_file_range() between any
> two types of filesystems, the best way to avoid these sort of issues
> in the future is for the kernel to be more picky about filesystems that
> are allowed to do copy_file_range().
>
> This patch restores some cross-filesystem copy restrictions that existed
> prior to commit 5dae222a5ff0 ("vfs: allow copy_file_range to copy across
> devices"), namely, cross-sb copy is not allowed for filesystems that do
> not implement ->copy_file_range().
>
> Filesystems that do implement ->copy_file_range() have full control of
> the result - if this method returns an error, the error is returned to
> the user.  Before this change this was only true for fs that did not
> implement the ->remap_file_range() operation (i.e. nfsv3).
>
> Filesystems that do not implement ->copy_file_range() still fall-back to
> the generic_copy_file_range() implementation when the copy is within the
> same sb.  This helps the kernel can maintain a more consistent story
> about which filesystems support copy_file_range().
>
> nfsd and ksmbd servers are modified to fall-back to the
> generic_copy_file_range() implementation in case vfs_copy_file_range()
> fails with -EOPNOTSUPP or -EXDEV, which preserves behavior of
> server-side-copy.
>
> fall-back to generic_copy_file_range() is not implemented for the smb
> operation FSCTL_DUPLICATE_EXTENTS_TO_FILE, which is arguably a correct
> change of behavior.
>
> Fixes: 5dae222a5ff0 ("vfs: allow copy_file_range to copy across devices")
> Link: https://lore.kernel.org/linux-fsdevel/20210212044405.4120619-1-drinkcat@chromium.org/
> Link: https://lore.kernel.org/linux-fsdevel/CANMq1KDZuxir2LM5jOTm0xx+BnvW=ZmpsG47CyHFJwnw7zSX6Q@mail.gmail.com/
> Link: https://lore.kernel.org/linux-fsdevel/20210126135012.1.If45b7cdc3ff707bc1efa17f5366057d60603c45f@changeid/
> Link: https://lore.kernel.org/linux-fsdevel/20210630161320.29006-1-lhenriques@suse.de/
> Reported-by: Nicolas Boichat <drinkcat@chromium.org>
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Signed-off-by: Luis Henriques <lhenriques@suse.de>
> Fixes: 64bf5ff58dff ("vfs: no fallback for ->copy_file_range")
> Link: https://lore.kernel.org/linux-fsdevel/20f17f64-88cb-4e80-07c1-85cb96c83619@windriver.com/
> Reported-by: He Zhe <zhe.he@windriver.com>
> Tested-by: Namjae Jeon <linkinjeon@kernel.org>
> Tested-by: Luis Henriques <lhenriques@suse.de>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>
> Hi Al,
>
> Please take this fix for two long standing regressions of
> cross-fs copy_file_range().
>
> Hopefully, we got everything right after 15 revisions
> posted by me and Luis.
>
> The end result should be much more consistent behavior
> from userspace POV and a lot less un-tested corner cases
> for vfs.
>

Ping.

This has been dragging on for a long time.
I want to fix this broken API.

Can you please get this staged for 5.19?

I understand if you can't be bothered with copy_file_range()
I can send the patch directly to Linus (CCed) if you prefer.

Thanks,
Amir.

>
> Changes since v15:
> - Added Tested-by from Luis and Namje
>
> Changes since v14 [1]:
> - Allow fallback to generic_copy_file_range() within same sb
> - Run the LTP copy_file_range tests
> - Assume patch authorship
>
> Changes since v13:
> - Rebased and tested over 5.19-rc1
> - Never fallback from ->copy_file_range() to generic_copy_file_range()
> - Added fallback to generic_copy_file_range() in ksmbd
> - Typo fixes in commit message and comments
>
> [1] https://lore.kernel.org/linux-fsdevel/20220606134608.684131-1-amir73il@gmail.com/
> [2] https://lore.kernel.org/linux-fsdevel/CAOQ4uxgHPgFTWBOF34=UDtaCOk0EA6f=66szS-Ox62YNPx1b=A@mail.gmail.com/
>
>  fs/ksmbd/smb2pdu.c | 16 ++++++++--
>  fs/ksmbd/vfs.c     |  4 +++
>  fs/nfsd/vfs.c      |  8 ++++-
>  fs/read_write.c    | 77 ++++++++++++++++++++++++++--------------------
>  4 files changed, 68 insertions(+), 37 deletions(-)
>
> diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
> index e6f4ccc12f49..17f42f5b02fe 100644
> --- a/fs/ksmbd/smb2pdu.c
> +++ b/fs/ksmbd/smb2pdu.c
> @@ -7806,14 +7806,24 @@ int smb2_ioctl(struct ksmbd_work *work)
>                 src_off = le64_to_cpu(dup_ext->SourceFileOffset);
>                 dst_off = le64_to_cpu(dup_ext->TargetFileOffset);
>                 length = le64_to_cpu(dup_ext->ByteCount);
> -               cloned = vfs_clone_file_range(fp_in->filp, src_off, fp_out->filp,
> -                                             dst_off, length, 0);
> +               /*
> +                * XXX: It is not clear if FSCTL_DUPLICATE_EXTENTS_TO_FILE
> +                * should fall back to vfs_copy_file_range().  This could be
> +                * beneficial when re-exporting nfs/smb mount, but note that
> +                * this can result in partial copy that returns an error status.
> +                * If/when FSCTL_DUPLICATE_EXTENTS_TO_FILE_EX is implemented,
> +                * fall back to vfs_copy_file_range(), should be avoided when
> +                * the flag DUPLICATE_EXTENTS_DATA_EX_SOURCE_ATOMIC is set.
> +                */
> +               cloned = vfs_clone_file_range(fp_in->filp, src_off,
> +                                             fp_out->filp, dst_off, length, 0);
>                 if (cloned == -EXDEV || cloned == -EOPNOTSUPP) {
>                         ret = -EOPNOTSUPP;
>                         goto dup_ext_out;
>                 } else if (cloned != length) {
>                         cloned = vfs_copy_file_range(fp_in->filp, src_off,
> -                                                    fp_out->filp, dst_off, length, 0);
> +                                                    fp_out->filp, dst_off,
> +                                                    length, 0);
>                         if (cloned != length) {
>                                 if (cloned < 0)
>                                         ret = cloned;
> diff --git a/fs/ksmbd/vfs.c b/fs/ksmbd/vfs.c
> index dcdd07c6efff..8d57347231ce 100644
> --- a/fs/ksmbd/vfs.c
> +++ b/fs/ksmbd/vfs.c
> @@ -1777,6 +1777,10 @@ int ksmbd_vfs_copy_file_ranges(struct ksmbd_work *work,
>
>                 ret = vfs_copy_file_range(src_fp->filp, src_off,
>                                           dst_fp->filp, dst_off, len, 0);
> +               if (ret == -EOPNOTSUPP || ret == -EXDEV)
> +                       ret = generic_copy_file_range(src_fp->filp, src_off,
> +                                                     dst_fp->filp, dst_off,
> +                                                     len, 0);
>                 if (ret < 0)
>                         return ret;
>
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 840e3af63a6f..b764213bcc55 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -577,6 +577,7 @@ __be32 nfsd4_clone_file_range(struct svc_rqst *rqstp,
>  ssize_t nfsd_copy_file_range(struct file *src, u64 src_pos, struct file *dst,
>                              u64 dst_pos, u64 count)
>  {
> +       ssize_t ret;
>
>         /*
>          * Limit copy to 4MB to prevent indefinitely blocking an nfsd
> @@ -587,7 +588,12 @@ ssize_t nfsd_copy_file_range(struct file *src, u64 src_pos, struct file *dst,
>          * limit like this and pipeline multiple COPY requests.
>          */
>         count = min_t(u64, count, 1 << 22);
> -       return vfs_copy_file_range(src, src_pos, dst, dst_pos, count, 0);
> +       ret = vfs_copy_file_range(src, src_pos, dst, dst_pos, count, 0);
> +
> +       if (ret == -EOPNOTSUPP || ret == -EXDEV)
> +               ret = generic_copy_file_range(src, src_pos, dst, dst_pos,
> +                                             count, 0);
> +       return ret;
>  }
>
>  __be32 nfsd4_vfs_fallocate(struct svc_rqst *rqstp, struct svc_fh *fhp,
> diff --git a/fs/read_write.c b/fs/read_write.c
> index b1b1cdfee9d3..c77df4ca6558 100644
> --- a/fs/read_write.c
> +++ b/fs/read_write.c
> @@ -1397,28 +1397,6 @@ ssize_t generic_copy_file_range(struct file *file_in, loff_t pos_in,
>  }
>  EXPORT_SYMBOL(generic_copy_file_range);
>
> -static ssize_t do_copy_file_range(struct file *file_in, loff_t pos_in,
> -                                 struct file *file_out, loff_t pos_out,
> -                                 size_t len, unsigned int flags)
> -{
> -       /*
> -        * Although we now allow filesystems to handle cross sb copy, passing
> -        * a file of the wrong filesystem type to filesystem driver can result
> -        * in an attempt to dereference the wrong type of ->private_data, so
> -        * avoid doing that until we really have a good reason.  NFS defines
> -        * several different file_system_type structures, but they all end up
> -        * using the same ->copy_file_range() function pointer.
> -        */
> -       if (file_out->f_op->copy_file_range &&
> -           file_out->f_op->copy_file_range == file_in->f_op->copy_file_range)
> -               return file_out->f_op->copy_file_range(file_in, pos_in,
> -                                                      file_out, pos_out,
> -                                                      len, flags);
> -
> -       return generic_copy_file_range(file_in, pos_in, file_out, pos_out, len,
> -                                      flags);
> -}
> -
>  /*
>   * Performs necessary checks before doing a file copy
>   *
> @@ -1440,6 +1418,24 @@ static int generic_copy_file_checks(struct file *file_in, loff_t pos_in,
>         if (ret)
>                 return ret;
>
> +       /*
> +        * We allow some filesystems to handle cross sb copy, but passing
> +        * a file of the wrong filesystem type to filesystem driver can result
> +        * in an attempt to dereference the wrong type of ->private_data, so
> +        * avoid doing that until we really have a good reason.
> +        *
> +        * nfs and cifs define several different file_system_type structures
> +        * and several different sets of file_operations, but they all end up
> +        * using the same ->copy_file_range() function pointer.
> +        */
> +       if (file_out->f_op->copy_file_range) {
> +               if (file_in->f_op->copy_file_range !=
> +                   file_out->f_op->copy_file_range)
> +                       return -EXDEV;
> +       } else if (file_inode(file_in)->i_sb != file_inode(file_out)->i_sb) {
> +               return -EXDEV;
> +       }
> +
>         /* Don't touch certain kinds of inodes */
>         if (IS_IMMUTABLE(inode_out))
>                 return -EPERM;
> @@ -1505,26 +1501,41 @@ ssize_t vfs_copy_file_range(struct file *file_in, loff_t pos_in,
>         file_start_write(file_out);
>
>         /*
> -        * Try cloning first, this is supported by more file systems, and
> -        * more efficient if both clone and copy are supported (e.g. NFS).
> +        * Cloning is supported by more file systems, so we implement copy on
> +        * same sb using clone, but for filesystems where both clone and copy
> +        * are supported (e.g. nfs,cifs), we only call the copy method.
>          */
> +       if (file_out->f_op->copy_file_range) {
> +               ret = file_out->f_op->copy_file_range(file_in, pos_in,
> +                                                     file_out, pos_out,
> +                                                     len, flags);
> +               goto done;
> +       }
> +
>         if (file_in->f_op->remap_file_range &&
>             file_inode(file_in)->i_sb == file_inode(file_out)->i_sb) {
> -               loff_t cloned;
> -
> -               cloned = file_in->f_op->remap_file_range(file_in, pos_in,
> +               ret = file_in->f_op->remap_file_range(file_in, pos_in,
>                                 file_out, pos_out,
>                                 min_t(loff_t, MAX_RW_COUNT, len),
>                                 REMAP_FILE_CAN_SHORTEN);
> -               if (cloned > 0) {
> -                       ret = cloned;
> +               if (ret > 0)
>                         goto done;
> -               }
>         }
>
> -       ret = do_copy_file_range(file_in, pos_in, file_out, pos_out, len,
> -                               flags);
> -       WARN_ON_ONCE(ret == -EOPNOTSUPP);
> +       /*
> +        * We can get here for same sb copy of filesystems that do not implement
> +        * ->copy_file_range() in case filesystem does not support clone or in
> +        * case filesystem supports clone but rejected the clone request (e.g.
> +        * because it was not block aligned).
> +        *
> +        * In both cases, fall back to kernel copy so we are able to maintain a
> +        * consistent story about which filesystems support copy_file_range()
> +        * and which filesystems do not, that will allow userspace tools to
> +        * make consistent desicions w.r.t using copy_file_range().
> +        */
> +       ret = generic_copy_file_range(file_in, pos_in, file_out, pos_out, len,
> +                                     flags);
> +
>  done:
>         if (ret > 0) {
>                 fsnotify_access(file_in);
> --
> 2.25.1
>
