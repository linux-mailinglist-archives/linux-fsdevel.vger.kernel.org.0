Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B080F7940E6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Sep 2023 17:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242760AbjIFP62 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Sep 2023 11:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242751AbjIFP61 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Sep 2023 11:58:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 308FD172C;
        Wed,  6 Sep 2023 08:58:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB4BCC433C8;
        Wed,  6 Sep 2023 15:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694015903;
        bh=jskjr6l10+eDyi1ANnoyYapU1KgxGD8h6s5uE5Jj3yE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YGEHA3ylBdBzUw5ef5gJkc7BKTYTI7GuMBdJ6YEij/ybXkLYtlsDgWHka7qgWz1go
         rfjJxJoxgKV0Gcy5tkcNvpXv5nfHTnlyUtYeitC6XoOGd2NQm6XeA+ufE0XAQBu1Lc
         RkYdmsGlHVuj/OK1X04zzJTUtGs7YnxhbeeZgfQPrWBxA7zF2F+pCQ9NzuOnYvG26W
         6BItDfmKfEyl2NZU6mgqaECcvBR40GTO/TxEGZQhYZu+QAiMQLfQ3J7KHEsD3je73z
         2/ere48gs57SRd8qyOiJ8+d1pkv7W2EV2y1T7O2mjj0KBwEpxy4g41KSIFcrGh9gSs
         w9U5A0nI9FQ7Q==
Date:   Wed, 6 Sep 2023 17:58:18 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Zdenek Kabelac <zkabelac@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        dm-devel@redhat.com, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [PATCH] fix writing to the filesystem after unmount
Message-ID: <20230906-echtheit-dezent-6f3621821cf2@brauner>
References: <59b54cc3-b98b-aff9-14fc-dc25c61111c6@redhat.com>
 <20230906-launenhaft-kinder-118ea59706c8@brauner>
 <f5d63867-5b3e-294b-d1f5-a128817cfc7@redhat.com>
 <20230906-aufheben-hagel-9925501b7822@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230906-aufheben-hagel-9925501b7822@brauner>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 06, 2023 at 05:33:32PM +0200, Christian Brauner wrote:
> > Currently, if we freeze a filesystem with "fsfreeze" and unmount it, the 
> > mount point is removed, but the filesystem stays active and it is leaked. 
> > You can't unfreeze it with "fsfreeze --unfreeze" because the mount point 
> > is gone. (the only way how to recover it is "echo j>/proc/sysrq-trigger").
> 
> You can of course always remount and unfreeze it.
> 
> > > IOW, you'd also hang on any umount of a bind-mount. IOW, every
> > > single container making use of this filesystems via bind-mounts would
> > > hang on umount and shutdown.
> > 
> > bind-mount doesn't modify "s->s_writers.frozen", so the patch does nothing 
> > in this case. I tried unmounting bind-mounts and there was no deadlock.
> 
> With your patch what happens if you do the following?
> 
> #!/bin/sh -ex
> modprobe brd rd_size=4194304
> vgcreate vg /dev/ram0
> lvcreate -L 16M -n lv vg
> mkfs.ext4 /dev/vg/lv
> 
> mount -t ext4 /dev/vg/lv /mnt/test
> mount --bind /mnt/test /opt
> mount --make-private /opt
> 
> dmsetup suspend /dev/vg/lv
> (sleep 1; dmsetup resume /dev/vg/lv) &
> 
> umount /opt # I'd expect this to hang
> 
> md5sum /dev/vg/lv
> md5sum /dev/vg/lv
> dmsetup remove_all
> rmmod brd
> 
> > BTW. what do you think that unmount of a frozen filesystem should properly 
> > do? Fail with -EBUSY? Or, unfreeze the filesystem and unmount it? Or 
> > something else?
> 
> In my opinion we should refuse to unmount frozen filesystems and log an
> error that the filesystem is frozen. Waiting forever isn't a good idea
> in my opinion.
> 
> But this is a significant uapi change afaict so this would need to be
> hidden behind a config option, a sysctl, or it would have to be a new
> flag to umount2() MNT_UNFROZEN which would allow an administrator to use
> this flag to not unmount a frozen filesystems.

That's probably too careful. I think we could risk starting to return an
error when trying to unmount a frozen filesystem. And if that causes
regressions we could go and look at another option like MNT_UNFROZEN or
whatever.
