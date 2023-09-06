Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85F4D79406F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Sep 2023 17:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239788AbjIFPdg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Sep 2023 11:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbjIFPdg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Sep 2023 11:33:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD21CE6;
        Wed,  6 Sep 2023 08:33:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6559C433C8;
        Wed,  6 Sep 2023 15:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694014412;
        bh=ien2fY2RFwul9+Bf5Q3uYGTFvylRBfT0Rr9oePLasuM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P79q3Aoq7p1ZW954KK1GopqB4/38jmDbushO6xB3xRNDQU45aX9MR48rxORIucHxi
         SUYLIf01Vng0tka0+YWqECpsHbrY0RR8iwbRLhI5jJH8G5k3gaR+kXnUFcZNCMnEcd
         huHUimCeLkSdNmr9xZClWjc7Pu8WXm3As6FQ1fpkk4l0ja9eVjQlUKrt4oFPyF8ltA
         myIClhE4S9pUm+uge5+hq1lCWn3cOGQKxKOIrml9M3mopkeuhdx3Lj3gHTZT8kOboJ
         dzUyOiozRAGhWuXIRsu1et5T1wQGYQ7Sl68CA/WZAOXeBKHsx4Gb1x8SJCRujkT8kQ
         glrcAxWIQ/YOQ==
Date:   Wed, 6 Sep 2023 17:33:27 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Zdenek Kabelac <zkabelac@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        dm-devel@redhat.com, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] fix writing to the filesystem after unmount
Message-ID: <20230906-aufheben-hagel-9925501b7822@brauner>
References: <59b54cc3-b98b-aff9-14fc-dc25c61111c6@redhat.com>
 <20230906-launenhaft-kinder-118ea59706c8@brauner>
 <f5d63867-5b3e-294b-d1f5-a128817cfc7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f5d63867-5b3e-294b-d1f5-a128817cfc7@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Currently, if we freeze a filesystem with "fsfreeze" and unmount it, the 
> mount point is removed, but the filesystem stays active and it is leaked. 
> You can't unfreeze it with "fsfreeze --unfreeze" because the mount point 
> is gone. (the only way how to recover it is "echo j>/proc/sysrq-trigger").

You can of course always remount and unfreeze it.

> > IOW, you'd also hang on any umount of a bind-mount. IOW, every
> > single container making use of this filesystems via bind-mounts would
> > hang on umount and shutdown.
> 
> bind-mount doesn't modify "s->s_writers.frozen", so the patch does nothing 
> in this case. I tried unmounting bind-mounts and there was no deadlock.

With your patch what happens if you do the following?

#!/bin/sh -ex
modprobe brd rd_size=4194304
vgcreate vg /dev/ram0
lvcreate -L 16M -n lv vg
mkfs.ext4 /dev/vg/lv

mount -t ext4 /dev/vg/lv /mnt/test
mount --bind /mnt/test /opt
mount --make-private /opt

dmsetup suspend /dev/vg/lv
(sleep 1; dmsetup resume /dev/vg/lv) &

umount /opt # I'd expect this to hang

md5sum /dev/vg/lv
md5sum /dev/vg/lv
dmsetup remove_all
rmmod brd

> BTW. what do you think that unmount of a frozen filesystem should properly 
> do? Fail with -EBUSY? Or, unfreeze the filesystem and unmount it? Or 
> something else?

In my opinion we should refuse to unmount frozen filesystems and log an
error that the filesystem is frozen. Waiting forever isn't a good idea
in my opinion.

But this is a significant uapi change afaict so this would need to be
hidden behind a config option, a sysctl, or it would have to be a new
flag to umount2() MNT_UNFROZEN which would allow an administrator to use
this flag to not unmount a frozen filesystems.
