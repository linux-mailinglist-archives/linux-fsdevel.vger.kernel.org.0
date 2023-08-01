Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3161D76B752
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Aug 2023 16:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234625AbjHAOZ0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Aug 2023 10:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232408AbjHAOZZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Aug 2023 10:25:25 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F08DE45
        for <linux-fsdevel@vger.kernel.org>; Tue,  1 Aug 2023 07:25:24 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-3a412653352so3997418b6e.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Aug 2023 07:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1690899923; x=1691504723;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zEWduPTN7KNCR0+/VfZ1mDkCFzABNOGtLE9KVkkqmhI=;
        b=oIcxB97i1BPyYhv+ltDY1yszH/Gy1R0BrKRo3aKlwgb44vbpoXOyAYE38/nvZWAAjD
         8c5s7Wdu2w5JJxNG8SLWaQYjb6SuoP8+Gjin9f2Sp9bmE7FJJsxVowl9jpZgRk5D+9T2
         LBSJg556zmNP5NxpnMN30R5Fcsm6ErrNJX8jw3KrYGsldnkFa6jbco4KsOHC2h5+xpdn
         7CJzUL+xZSUZxJ5P67j+xBA1luJORvuOvGEM8CRvPmXTcWCNXSa44TjIYFv0VbNXBhx5
         1x9QK2debih1cEowfhlqspu1R3utZkNiGzNJ7+kPxGicPQoUbVhCmRKvFTn/9OEtDIUj
         5l0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690899923; x=1691504723;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zEWduPTN7KNCR0+/VfZ1mDkCFzABNOGtLE9KVkkqmhI=;
        b=M6nC7clpbKMc9EffpktcUKa8/dxjCqBZNijpkGbFihtMM9/4BuPABLq+htFJhS8LAe
         DWfZbijgyBnHdqN7xWLRVlLLPlivc2W/8GhHvdB/LE75pc4Nsp2ToRkYXSfgKqd7jPJE
         bd0B0lmnu9fYK6E9WPL6iiM3bnjRVLiwO3BzX0BLAFMvJjFAvPFNm9mawOHheeIk06na
         q88I8xBpLNXnlMpS5yCRD1gug/wKBbecIdINkmi6VOUOk9dHO++YFxk4vfWLa7/e4YMQ
         gqNMfzeYI6M8T/Sk+ALkL0dguQqX580ITQfDK/O++Iuw52ML6zvoGU+B1YJ5nh64iom5
         U/kA==
X-Gm-Message-State: ABy/qLZIKK52S/frpg6SuIfQnJEXFvwGeX0s37zt3b1UVZc/V5wLLypB
        /CzMV/WscDXjgEwifvImfypeHQ==
X-Google-Smtp-Source: APBJJlEQAaToW8m9Ag+K/Vzyc8JYuIEpSe0qEhqVPL3NMm7+RMn8VjyeX5c0gcPXpIBAvWHAysP4lw==
X-Received: by 2002:a05:6358:882:b0:139:cb15:ecd3 with SMTP id m2-20020a056358088200b00139cb15ecd3mr3039539rwj.8.1690899923181;
        Tue, 01 Aug 2023 07:25:23 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id q6-20020a0ce206000000b006300e92ea02sm4684051qvl.121.2023.08.01.07.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 07:25:22 -0700 (PDT)
Date:   Tue, 1 Aug 2023 10:25:21 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>, Karel Zak <kzak@redhat.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC 0/3] fs: allow userspace to detect superblock reuse
Message-ID: <20230801142521.GB2012161@perftesting>
References: <20230801-vfs-super-exclusive-v1-0-1a587e56c9f3@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801-vfs-super-exclusive-v1-0-1a587e56c9f3@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 01, 2023 at 03:08:59PM +0200, Christian Brauner wrote:
> Summary
> =======
> 
> This introduces FSCONFIG_CMD_CREATE_EXCL which will allows userspace to
> implement something like mount -t ext4 --exclusive /dev/sda /B which
> fails if a superblock for the requested filesystem does already exist:
> 
> Before this patch
> -----------------
> 
> $ sudo ./move-mount -f xfs -o source=/dev/sda4 /A
> Requesting filesystem type xfs
> Mount options requested: source=/dev/sda4
> Attaching mount at /A
> Moving single attached mount
> Setting key(source) with val(/dev/sda4)
> 
> $ sudo ./move-mount -f xfs -o source=/dev/sda4 /B
> Requesting filesystem type xfs
> Mount options requested: source=/dev/sda4
> Attaching mount at /B
> Moving single attached mount
> Setting key(source) with val(/dev/sda4)
> 
> After this patch with --exclusive as a switch for FSCONFIG_CMD_CREATE_EXCL
> --------------------------------------------------------------------------
> 
> $ sudo ./move-mount -f xfs --exclusive -o source=/dev/sda4 /A
> Requesting filesystem type xfs
> Request exclusive superblock creation
> Mount options requested: source=/dev/sda4
> Attaching mount at /A
> Moving single attached mount
> Setting key(source) with val(/dev/sda4)
> 
> $ sudo ./move-mount -f xfs --exclusive -o source=/dev/sda4 /B
> Requesting filesystem type xfs
> Request exclusive superblock creation
> Mount options requested: source=/dev/sda4
> Attaching mount at /B
> Moving single attached mount
> Setting key(source) with val(/dev/sda4)
> Device or resource busy | move-mount.c: 300: do_fsconfig: i xfs: reusing existing superblock not allowed
> 
> Details
> =======
> 
> As mentioned on the list (cf. [1]-[3]) mount requests like
> mount -t ext4 /dev/sda /A are ambigous for userspace. Either a new
> superblock has been created and mounted or an existing superblock has
> been reused and a bind-mount has been created.
> 
> This becomes clear if we consider two processes creating the same mount
> for the same block device:
> 
> P1                                                              P2
> fd_fs = fsopen("ext4");                                         fd_fs = fsopen("ext4");
> fsconfig(fd_fs, FSCONFIG_SET_STRING, "source", "/dev/sda");     fsconfig(fd_fs, FSCONFIG_SET_STRING, "source", "/dev/sda");
> fsconfig(fd_fs, FSCONFIG_SET_STRING, "dax", "always");          fsconfig(fd_fs, FSCONFIG_SET_STRING, "resuid", "1000");
> 
> // wins and creates superblock
> fsconfig(fd_fs, FSCONFIG_CMD_CREATE, ...)
>                                                                 // finds compatible superblock of P1
>                                                                 // spins until P1 sets SB_BORN and grabs a reference
>                                                                 fsconfig(fd_fs, FSCONFIG_CMD_CREATE, ...)
> 
> fd_mnt1 = fsmount(fd_fs);                                       fd_mnt2 = fsmount(fd_fs);
> move_mount(fd_mnt1, "/A")                                       move_mount(fd_mnt2, "/B")
> 
> Not just does P2 get a bind-mount for nearly all filesystems the mount
> options for P2 are usually completely ignored. The VFS itself doesn't
> and shouldn't enforce filesystem specific mount option compatibility. It
> only enforces incompatibility for read-only <-> read-write transitions:
> 
> mount -t ext4       /dev/sda /A
> mount -t ext4 -o ro /dev/sda /B
> 
> The read-only request will fail with EBUSY as the VFS can't just
> silently transition a superblock from read-write to read-only or vica
> versa without risking security issues.
> 
> To userspace this silent superblock reuse can be security issue in
> certain circumstances because there is currently no simple way for them
> to know that they did indeed manage to create the superblock and didn't
> just reuse an existing one.
> 
> This adds a new FSCONFIG_CMD_CREATE_EXCL command to fsconfig() that
> returns EBUSY if an existing superblock is found. Userspace that needs
> to be sure that they did create the superblock with the requested mount
> options can request superblock creation using this command. If it
> succeeds they can be sure that they did create the superblock with the
> requested mount options.
> 
> This requires the new mount api. With the old mount api we would have to
> plumb this through every legacy filesystem's file_system_type->mount()
> method. If they want this feature they are most welcome to switch to the
> new mount api.
> 
> Following is an analysis of the effect of FSCONFIG_CMD_CREATE_EXCL on
> each high-level superblock creation helper:
> 
> (1) get_tree_nodev()
> 
>     Always allocate new superblock. Hence, FSCONFIG_CMD_CREATE and
>     FSCONFIG_CMD_CREATE_EXCL are equivalent.
> 
>     The binderfs or overlayfs filesystems are examples.
> 
> (4) get_tree_keyed()
> 
>     Finds an existing superblock based on sb->s_fs_info. Hence,
>     FSCONFIG_CMD_CREATE would reuse an existing superblock whereas
>     FSCONFIG_CMD_CREATE_EXCL would reject it with EBUSY.
> 
>     The mqueue or nfsd filesystems are examples.
> 
> (2) get_tree_bdev()
> 
>     This effectively works like get_tree_keyed().
> 
>     The ext4 or xfs filesystems are examples.
> 
> (3) get_tree_single()
> 
>     Only one superblock of this filesystem type can ever exist.
>     Hence, FSCONFIG_CMD_CREATE would reuse an existing superblock
>     whereas FSCONFIG_CMD_CREATE_EXCL would reject it with EBUSY.
> 
>     The securityfs or configfs filesystems are examples.
> 
>     This has a further consequence. Some filesystems will never destroy
>     the superblock once it has been created. For example, if securityfs
>     is mounted the allocated superblock will never be destroyed again as
>     long as there is still an LSM making use it. Consequently, even if
>     securityfs is unmounted and seemingly destroyed it really isn't
>     which means that FSCONFIG_CMD_CREATE_EXCL will continue rejecting
>     reusing the existing superblock.
> 
>     This is unintuitive but not a problem. Such special purpose
>     filesystems aren't mounted multiple times anyway.
> 
> Following is an analysis of the effect of FSCONFIG_CMD_CREATE_EXCL on
> filesystems that make use of the low-level sget_fc() helper directly.
> They're all effectively variants on get_tree_keyed() or get_tree_bdev():
> 
> (5) mtd_get_sb()
> 
>     Similar logic to get_tree_keyed().
> 
> (6) afs_get_tree()
> 
>     Similar logic to get_tree_keyed().
> 
> (7) ceph_get_tree()
> 
>     Similar logic to get_tree_keyed().
> 
>     Already explicitly allows forcing the allocation of a new superblock
>     via CEPH_OPT_NOSHARE. This turns it into get_tree_nodev().
> 
> (8) fuse_get_tree_submount()
> 
>     Similar logic to get_tree_nodev().
> 
> (9) fuse_get_tree()
> 
>     Forces reuse of existing FUSE superblock.
> 
>     Forces reuse of existing superblock if passed in file refers to an
>     existing FUSE connection.
>     If FSCONFIG_CMD_CREATE_EXCL is specified together with an fd
>     referring to an existing FUSE connections this would cause the
>     superblock reusal to fail. If reusing is the intent then
>     FSCONFIG_CMD_CREATE_EXCL shouldn't be specified.
> 
> (10) fuse_get_tree()
>      -> get_tree_nodev()
> 
>     Same logic as in get_tree_nodev().
> 
> (11) fuse_get_tree()
>      -> get_tree_bdev()
> 
>     Same logic as in get_tree_bdev().
> 
> (12) virtio_fs_get_tree()
> 
>      Same logic as get_tree_keyed().
> 
> (13) gfs2_meta_get_tree()
> 
>      Forces reuse of existing gfs2 superblock.
> 
>      Mounting gfs2meta enforces that a gf2s superblock must already
>      exist. If not, it will error out. Consequently, mounting gfs2meta
>      with FSCONFIG_CMD_CREATE_EXCL would always fail. If reusing is the
>      intent then FSCONFIG_CMD_CREATE_EXCL shouldn't be specified.
> 
> (14) kernfs_get_tree()
> 
>      Similar logic to get_tree_keyed().
> 
> (15) nfs_get_tree_common()
> 
>     Similar logic to get_tree_keyed().
> 
>     Already explicitly allows forcing the allocation of a new superblock
>     via NFS_MOUNT_UNSHARED. This effectively turns it into
>     get_tree_nodev().
> 
> Link: [1] https://lore.kernel.org/linux-block/20230704-fasching-wertarbeit-7c6ffb01c83d@brauner
> Link: [2] https://lore.kernel.org/linux-block/20230705-pumpwerk-vielversprechend-a4b1fd947b65@brauner
> Link: [3] https://lore.kernel.org/linux-fsdevel/20230725-einnahmen-warnschilder-17779aec0a97@brauner
> 

The description and use case seem reasonable to me, the code is straightforward,
I assume you've added RFC only because you want comments on wether we want the
functionality/your approach to fixing the problem is acceptable?  For me this
makes sense and is simple enough.  I have a nit where I think we should say
something like "can't reuse existing file system" instead of "superblock", just
because we know what superblock means doesn't mean the user will necessarily
understand that out the gate.

You can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

to the series.  Thanks,

Josef
