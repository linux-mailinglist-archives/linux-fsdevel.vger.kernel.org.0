Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2D946008F5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Oct 2022 10:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbiJQIoO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Oct 2022 04:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbiJQIoM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Oct 2022 04:44:12 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BD1B2BE3F
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Oct 2022 01:44:09 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id x18so13110440ljm.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Oct 2022 01:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qwIwAcqWBfBMRrm9KF2boeBuiPaxpIOUZ43XencQIbo=;
        b=Nrfotfa7MvpY7q0BJxF8GYRMfDoStqAH0gkcWf1bZUF+k/4FN4VrpQKYK3jZBNkZbU
         9nUYp6FlyhtT/GVq0w+Zl4xOv/B2vJTf3IO5Pe/89dj2ynrkpCw9MAiTwWTe0rDsYm5n
         OmQYUbH2dGgKPJGXIi4hqk/f+drAbYZB/w54lgCD1bgdPLIN5KGeLnBGZqdp6wjrulW/
         SKzruULcjVdI61kdj3R8GeeunRA5I5xWFb8h58+PEB2JkOBlKLqnW+uXpsPUBhNPT3nm
         ekW5pqYozDIRwNqbAFHW2Ragfrv47U6CG0jcv0h+KnvFqOT+UyZh5v4TBs9BU/YeHZVC
         rkOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qwIwAcqWBfBMRrm9KF2boeBuiPaxpIOUZ43XencQIbo=;
        b=KWp+nm1kSmWNd8H6NnQK6izMflNQf8HaxXdbLZyPO6H/cI/AUubr+q2RJOSUO9ARBs
         h9xLWjYeF2sf2q5smqnDXjHxzz9QyswoBl4nvFnltArwWopl/KpAaiEURkz0Hj33k0Yp
         QKJihW5iPUlMx29iFPpFvjlBYTlcGflCsCTDK8y9AAxt5miCRrIFRQXByc+6PZU3ak/R
         9e0SPCMKu2Hd+sPzS12zjynH1W4KruTbtO+A1ZVnRpl7d7zxOxtmidmfuKBYsjsP9ySI
         /quohevaAM6xL2Mtxr4VNaxWTNr3IRtCRInoyX/gcYEsZRuG1+s6E6PDqD6sWsPvLAjf
         yD2Q==
X-Gm-Message-State: ACrzQf3OK1m5mUzILM1KyT7d2aSSXByeCqrVJi6Mn7ld9AcLJJLjjLnT
        TmaWurYUe3KCllrnJB5Zf7P8r4yvmGPWWlqHUYCPDQ==
X-Google-Smtp-Source: AMsMyM7sr3h7oQemK/dOL+YtBSU21PIPjg5e9KcVS4lXt6tQt+i3ydRApB3/QcxDIS2D9ndM4Qe96lBxOkubafTa0gs=
X-Received: by 2002:a2e:b5af:0:b0:26f:d634:2f0d with SMTP id
 f15-20020a2eb5af000000b0026fd6342f0dmr3852031ljn.33.1665996247476; Mon, 17
 Oct 2022 01:44:07 -0700 (PDT)
MIME-Version: 1.0
References: <20221014084837.1787196-1-hrkanabar@gmail.com> <20221014084837.1787196-4-hrkanabar@gmail.com>
 <5bc906b3-ccb5-a385-fcb6-fc51c8fea3fd@suse.com>
In-Reply-To: <5bc906b3-ccb5-a385-fcb6-fc51c8fea3fd@suse.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 17 Oct 2022 10:43:55 +0200
Message-ID: <CACT4Y+YeSOZPN+ek6vSLhsCugJ3iGF35-sghnZt4qQJ36DA6mA@mail.gmail.com>
Subject: Re: [PATCH RFC 3/7] fs/btrfs: support `DISABLE_FS_CSUM_VERIFICATION`
 config option
To:     Qu Wenruo <wqu@suse.com>
Cc:     Hrutvik Kanabar <hrkanabar@gmail.com>,
        Hrutvik Kanabar <hrutvik@google.com>,
        Marco Elver <elver@google.com>,
        Aleksandr Nogikh <nogikh@google.com>,
        kasan-dev@googlegroups.com,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        "Darrick J . Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Anton Altaparmakov <anton@tuxera.com>,
        linux-ntfs-dev@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 14 Oct 2022 at 12:24, 'Qu Wenruo' via kasan-dev
<kasan-dev@googlegroups.com> wrote:
>
> On 2022/10/14 16:48, Hrutvik Kanabar wrote:
> > From: Hrutvik Kanabar <hrutvik@google.com>
> >
> > When `DISABLE_FS_CSUM_VERIFICATION` is enabled, bypass checksum
> > verification.
> >
> > Signed-off-by: Hrutvik Kanabar <hrutvik@google.com>
>
> I always want more fuzz for btrfs, so overall this is pretty good.
>
> But there are some comments related to free space cache part.
>
> Despite the details, I'm wondering would it be possible for your fuzzing
> tool to do a better job at user space? Other than relying on loosen
> checks from kernel?
>
> For example, implement a (mostly) read-only tool to do the following
> workload:
>
> - Open the fs
>    Including understand the checksum algo, how to re-generate the csum.
>
> - Read out the used space bitmap
>    In btrfs case, it's going to read the extent tree, process the
>    backrefs items.
>
> - Choose the victim sectors and corrupt them
>    Obviously, vitims should be choosen from above used space bitmap.
>
> - Re-calculate the checksum for above corrupted sectors
>    For btrfs, if it's a corrupted metadata, re-calculate the checksum.
>
> By this, we can avoid such change to kernel, and still get a much better
> coverage.
>
> If you need some help on such user space tool, I'm pretty happy to
> provide help.
>
> > ---
> >   fs/btrfs/check-integrity.c  | 3 ++-
> >   fs/btrfs/disk-io.c          | 6 ++++--
> >   fs/btrfs/free-space-cache.c | 3 ++-
> >   fs/btrfs/inode.c            | 3 ++-
> >   fs/btrfs/scrub.c            | 9 ++++++---
> >   5 files changed, 16 insertions(+), 8 deletions(-)
> >
> > diff --git a/fs/btrfs/check-integrity.c b/fs/btrfs/check-integrity.c
> > index 98c6e5feab19..eab82593a325 100644
> > --- a/fs/btrfs/check-integrity.c
> > +++ b/fs/btrfs/check-integrity.c
> > @@ -1671,7 +1671,8 @@ static noinline_for_stack int btrfsic_test_for_metadata(
> >               crypto_shash_update(shash, data, sublen);
> >       }
> >       crypto_shash_final(shash, csum);
> > -     if (memcmp(csum, h->csum, fs_info->csum_size))
> > +     if (!IS_ENABLED(CONFIG_DISABLE_FS_CSUM_VERIFICATION) &&
> > +         memcmp(csum, h->csum, fs_info->csum_size))
> >               return 1;
> >
> >       return 0; /* is metadata */
> > diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> > index a2da9313c694..7cd909d44b24 100644
> > --- a/fs/btrfs/disk-io.c
> > +++ b/fs/btrfs/disk-io.c
> > @@ -184,7 +184,8 @@ static int btrfs_check_super_csum(struct btrfs_fs_info *fs_info,
> >       crypto_shash_digest(shash, raw_disk_sb + BTRFS_CSUM_SIZE,
> >                           BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE, result);
> >
> > -     if (memcmp(disk_sb->csum, result, fs_info->csum_size))
> > +     if (!IS_ENABLED(CONFIG_DISABLE_FS_CSUM_VERIFICATION) &&
> > +         memcmp(disk_sb->csum, result, fs_info->csum_size))
> >               return 1;
> >
> >       return 0;
> > @@ -494,7 +495,8 @@ static int validate_extent_buffer(struct extent_buffer *eb)
> >       header_csum = page_address(eb->pages[0]) +
> >               get_eb_offset_in_page(eb, offsetof(struct btrfs_header, csum));
> >
> > -     if (memcmp(result, header_csum, csum_size) != 0) {
> > +     if (!IS_ENABLED(CONFIG_DISABLE_FS_CSUM_VERIFICATION) &&
> > +         memcmp(result, header_csum, csum_size) != 0) {
>
> I believe this is the main thing fuzzing would take advantage of.
>
> It would be much better if this is the only override...
>
> >               btrfs_warn_rl(fs_info,
> >   "checksum verify failed on logical %llu mirror %u wanted " CSUM_FMT " found " CSUM_FMT " level %d",
> >                             eb->start, eb->read_mirror,
> > diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
> > index f4023651dd68..203c8a9076a6 100644
> > --- a/fs/btrfs/free-space-cache.c
> > +++ b/fs/btrfs/free-space-cache.c
> > @@ -574,7 +574,8 @@ static int io_ctl_check_crc(struct btrfs_io_ctl *io_ctl, int index)
> >       io_ctl_map_page(io_ctl, 0);
> >       crc = btrfs_crc32c(crc, io_ctl->orig + offset, PAGE_SIZE - offset);
> >       btrfs_crc32c_final(crc, (u8 *)&crc);
> > -     if (val != crc) {
> > +     if (!IS_ENABLED(CONFIG_DISABLE_FS_CSUM_VERIFICATION) &&
> > +         val != crc) {
>
> I'm already seeing this to cause problems, especially for btrfs.
>
> Btrfs has a very strong dependency on free space tracing, as all of our
> metadata (and data by default) relies on COW to keep the fs consistent.
>
> I tried a lot of different methods in the past to make sure we won't
> write into previously used space, but it's causing a lot of performance
> impact.
>
> Unlike tree-checker, we can not easily got a centerlized space to handle
> all the free space cross-check thing (thus it's only verified by things
> like btrfs-check).
>
> Furthermore, even if you skip this override, with latest default
> free-space-tree feature, free space info is stored in regular btrfs
> metadata (tree blocks), with regular metadata checksum protection.
>
> Thus I'm pretty sure we will have tons of reports on this, and
> unfortunately we can only go whac-a-mole way for it.

Hi Qu,

I don't fully understand what you mean. Could you please elaborate?

Do you mean that btrfs uses this checksum check to detect blocks that
were written to w/o updating the checksum?




> >               btrfs_err_rl(io_ctl->fs_info,
> >                       "csum mismatch on free space cache");
> >               io_ctl_unmap_page(io_ctl);
> > diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> > index b0807c59e321..1a49d897b5c1 100644
> > --- a/fs/btrfs/inode.c
> > +++ b/fs/btrfs/inode.c
> > @@ -3434,7 +3434,8 @@ int btrfs_check_sector_csum(struct btrfs_fs_info *fs_info, struct page *page,
> >       crypto_shash_digest(shash, kaddr, fs_info->sectorsize, csum);
> >       kunmap_local(kaddr);
> >
> > -     if (memcmp(csum, csum_expected, fs_info->csum_size))
> > +     if (!IS_ENABLED(CONFIG_DISABLE_FS_CSUM_VERIFICATION) &&
> > +         memcmp(csum, csum_expected, fs_info->csum_size))
>
> This skips data csum check, I don't know how valueable it is, but this
> should be harmless mostly.
>
> If we got reports related to this, it would be a nice surprise.
>
> >               return -EIO;
> >       return 0;
> >   }
> > diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> > index f260c53829e5..a7607b492f47 100644
> > --- a/fs/btrfs/scrub.c
> > +++ b/fs/btrfs/scrub.c
> > @@ -1997,7 +1997,8 @@ static int scrub_checksum_data(struct scrub_block *sblock)
> >
> >       crypto_shash_digest(shash, kaddr, fs_info->sectorsize, csum);
> >
> > -     if (memcmp(csum, sector->csum, fs_info->csum_size))
> > +     if (!IS_ENABLED(CONFIG_DISABLE_FS_CSUM_VERIFICATION) &&
> > +         memcmp(csum, sector->csum, fs_info->csum_size))
>
> Same as data csum verification overide.
> Not necessary/useful but good to have.
>
> >               sblock->checksum_error = 1;
> >       return sblock->checksum_error;
> >   }
> > @@ -2062,7 +2063,8 @@ static int scrub_checksum_tree_block(struct scrub_block *sblock)
> >       }
> >
> >       crypto_shash_final(shash, calculated_csum);
> > -     if (memcmp(calculated_csum, on_disk_csum, sctx->fs_info->csum_size))
> > +     if (!IS_ENABLED(CONFIG_DISABLE_FS_CSUM_VERIFICATION) &&
> > +         memcmp(calculated_csum, on_disk_csum, sctx->fs_info->csum_size))
>
> This is much less valueable, since it's only affecting scrub, and scrub
> itself is already very little checking the content of metadata.

Could you please elaborate here as well?
This is less valuable from what perspective?
The data loaded from disk can have any combination of
(correct/incorrect metadata) x (correct/incorrect checksum).
Correctness of metadata and checksum are effectively orthogonal,
right?



> Thanks,
> Qu
>
> >               sblock->checksum_error = 1;
> >
> >       return sblock->header_error || sblock->checksum_error;
> > @@ -2099,7 +2101,8 @@ static int scrub_checksum_super(struct scrub_block *sblock)
> >       crypto_shash_digest(shash, kaddr + BTRFS_CSUM_SIZE,
> >                       BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE, calculated_csum);
> >
> > -     if (memcmp(calculated_csum, s->csum, sctx->fs_info->csum_size))
> > +     if (!IS_ENABLED(CONFIG_DISABLE_FS_CSUM_VERIFICATION) &&
> > +         memcmp(calculated_csum, s->csum, sctx->fs_info->csum_size))
> >               ++fail_cor;
> >
> >       return fail_cor + fail_gen;
