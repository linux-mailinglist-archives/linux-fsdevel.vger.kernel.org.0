Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11E7176F766
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Aug 2023 04:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232741AbjHDCCA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Aug 2023 22:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232705AbjHDCB7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Aug 2023 22:01:59 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 306E544A1;
        Thu,  3 Aug 2023 19:01:57 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id ada2fe7eead31-447684c4283so673822137.2;
        Thu, 03 Aug 2023 19:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691114516; x=1691719316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Li4Rr3SDbAWbMC9vqUARkDUxqa5LNmgwNWmtZCQPN7c=;
        b=MoVB1XjmMagsHZzn9G8ftY6HWJZOUd3UQbdoUZGHvxiTrJtRhQmKpY5hMXxXdiDzuq
         zQBrBD4AM2yCz+AjuuOypK1qRVFL8If5W+fTO+cw9XBWSGuM7Hrx2k1cmlpjp62wiDDF
         xmsVPYq08ScKsEB2acJFU2fLVkjAs3OQk4kUojzHHGQtCjQau8BO/IfSPhWz7s7RoG+F
         ObfsdVyd9J6qFm5iu3TH8pCH6XZy+vWbCGwACVvcWshSg7B1v3rxfId451mLVIpY2bVi
         GasCyfXQI0s3z46olnWXSpFmLflSUgwZZScpT/KeG4Ra5OVORJFyNsdv2rD2oRuBkEtE
         dKlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691114516; x=1691719316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Li4Rr3SDbAWbMC9vqUARkDUxqa5LNmgwNWmtZCQPN7c=;
        b=AHwHs1RDHmSRRmMjEQdp+RoWkigg69QbSEujxAVrY8D9ipzJ60Ju0TJHasS2oa2qcp
         QbDA3n8BWOjcDu7YmnYL80StdtYdCcaJS+9TwoUiYpuxqzZt7IPnjwf0A6ImjihI7ljx
         Rz+3hsVYQo3vef1JPaB/jl0TW3sVPCr5wgfXf91SkP92D74ssmF2C15Ah/LhHFgD6OrZ
         Dr/G81p/groWSONlBM9e2z1WG6HPPfD3YAjCK6lfKGyxNfKaWUwVKXJL35T1lR9phjzH
         c2uCC3MK43cARq8goc0EWtvy/EVUyEM1JWP2C5M0YA7UrRdxGcPsM3YyfBYcevdmUcOR
         rlMw==
X-Gm-Message-State: AOJu0YyZGsTcfdCada2Pv0UMonW1QldD/e237rGQQSMnfF7ynhVuJ9H/
        Gm3gH9iSKS6EsN42ApoOrz+Xc1/wNT+tEcOslw0=
X-Google-Smtp-Source: AGHT+IHATFbengwvPlZLXwXXl9tdvm/xeC68n6I1h9PJY7Qw0FOEZCU8f3gigNz/0f8AxRF04Qwf1gS0iLv+NBKaP4k=
X-Received: by 2002:a05:6102:a35:b0:443:7635:34d with SMTP id
 21-20020a0561020a3500b004437635034dmr329869vsb.30.1691114516008; Thu, 03 Aug
 2023 19:01:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230802154131.2221419-1-hch@lst.de> <20230802154131.2221419-3-hch@lst.de>
 <20230803114651.ihtqqgthbdjjgxev@quack3>
In-Reply-To: <20230803114651.ihtqqgthbdjjgxev@quack3>
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Fri, 4 Aug 2023 11:01:39 +0900
Message-ID: <CAKFNMomzHg33SHnp6xGMEZY=+k6Y4t7dvBvgBDbO9H3ujzNDCw@mail.gmail.com>
Subject: Re: [PATCH 02/12] nilfs2: use setup_bdev_super to de-duplicate the
 mount code
To:     Jan Kara <jack@suse.cz>
Cc:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 3, 2023 at 8:46=E2=80=AFPM Jan Kara wrote:
>
> On Wed 02-08-23 17:41:21, Christoph Hellwig wrote:
> > Use the generic setup_bdev_super helper to open the main block device
> > and do various bits of superblock setup instead of duplicating the
> > logic.  This includes moving to the new scheme implemented in common
> > code that only opens the block device after the superblock has allocate=
d.
> >
> > It does not yet convert nilfs2 to the new mount API, but doing so will
> > become a bit simpler after this first step.
> >
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
>
> AFAICS nilfs2 could *almost* use mount_bdev() directly and then just do i=
ts

> snapshot thing after mount_bdev() returns. But it has this weird logic
> that: "if the superblock is already mounted but we can shrink the whole
> dcache, then do remount instead of ignoring mount options". Firstly, this
> looks racy - what prevents someone from say opening a file on the sb just
> after nilfs_tree_is_busy() shrinks dcache? Secondly, it is inconsistent
> with any other filesystem so it's going to surprise sysadmins not
> intimately knowing nilfs2. Thirdly, from userspace you cannot tell what
> your mount call is going to do. Last but not least, what is it really goo=
d
> for? Ryusuke, can you explain please?
>
>                                                                 Honza

I think you are referring to the following part:

>        if (!s->s_root) {
...
>        } else if (!sd.cno) {
>                if (nilfs_tree_is_busy(s->s_root)) {
>                        if ((flags ^ s->s_flags) & SB_RDONLY) {
>                                nilfs_err(s,
>                                          "the device already has a %s mou=
nt.",
>                                          sb_rdonly(s) ? "read-only" : "re=
ad/write");
>                                err =3D -EBUSY;
>                                goto failed_super;
>                        }
>                } else {
>                        /*
>                         * Try remount to setup mount states if the curren=
t
>                         * tree is not mounted and only snapshots use this=
 sb.
>                         */
>                        err =3D nilfs_remount(s, &flags, data);
>                        if (err)
>                                goto failed_super;
>                }
>        }

What this logic is trying to do is, if there is already a nilfs2 mount
instance for the device, and are trying to mounting the current tree
(sd.cno is 0, so this is not a snapshot mount), then will switch
depending on whether the current tree has a mount:

- If the current tree is mounted, it's just like a normal filesystem.
(A read-only mount and a read/write mount can't coexist, so check
that, and reuse the instance if possible)
- Otherwise, i.e. for snapshot mounts only, do whatever is necessary
to add a new current mount, such as starting a log writer.
   Since it does the same thing that nilfs_remount does, so
nilfs_remount() is used there.

Whether or not there is a current tree mount can be determined by
d_count(s->s_root) > 1 as nilfs_tree_is_busy() does.
Where s->s_root is always the root dentry of the current tree, not
that of the mounted snapshot.

I remember that calling shrink_dcache_parent() before this test was to
do the test correctly if there was garbage left in the dcache from the
past current mount.

If the current tree isn't mounted, it just cleans up the garbage, and
the reference count wouldn't have incremented in parallel.

If the current tree is mounted, d_count(s->s_root) will not decrease
to 1, so it's not a problem.
However, this will cause unexpected dcache shrinkage for the in-use
tree, so it's not a good idea, as you pointed out.  If there is
another way of judging without this side effect, it should be
replaced.

I will reply here once.

Regards,
Ryusuke Konishi
