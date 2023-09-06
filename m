Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F2A07940FD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Sep 2023 18:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240809AbjIFQCO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Sep 2023 12:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236511AbjIFQCN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Sep 2023 12:02:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C92281981
        for <linux-fsdevel@vger.kernel.org>; Wed,  6 Sep 2023 09:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694016073;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RGPPbmO08ttjc/gDON/wShpO8XSYQN5IRch5OGh+AgE=;
        b=d8VN3DfAJzF5CpHTLJdnWq+/o7DVu15sarbwW338ljznbDbDnE5qbBSARzKooP8Llvngl2
        8rvsQYa7pO8lIRD5GOur+C4HSi/Z8Xxl9BkluK6+e4rzP7LXXdYyCU2u2JmVgu6DOPlHFH
        +0ZPDK+DMM1DBXlktIi/Fhthqmx2vds=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-690-yHcjSMTpP_SKHg_hAi5JHA-1; Wed, 06 Sep 2023 12:01:10 -0400
X-MC-Unique: yHcjSMTpP_SKHg_hAi5JHA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 30A83183719C;
        Wed,  6 Sep 2023 16:01:07 +0000 (UTC)
Received: from file1-rdu.file-001.prod.rdu2.dc.redhat.com (unknown [10.11.5.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 03C07493112;
        Wed,  6 Sep 2023 16:01:07 +0000 (UTC)
Received: by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix, from userid 12668)
        id E3E1330C1C07; Wed,  6 Sep 2023 16:01:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix) with ESMTP id DFDA23FD6A;
        Wed,  6 Sep 2023 18:01:06 +0200 (CEST)
Date:   Wed, 6 Sep 2023 18:01:06 +0200 (CEST)
From:   Mikulas Patocka <mpatocka@redhat.com>
To:     Christian Brauner <brauner@kernel.org>
cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Zdenek Kabelac <zkabelac@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        dm-devel@redhat.com, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] fix writing to the filesystem after unmount
In-Reply-To: <20230906-aufheben-hagel-9925501b7822@brauner>
Message-ID: <60f244be-803b-fa70-665e-b5cba15212e@redhat.com>
References: <59b54cc3-b98b-aff9-14fc-dc25c61111c6@redhat.com> <20230906-launenhaft-kinder-118ea59706c8@brauner> <f5d63867-5b3e-294b-d1f5-a128817cfc7@redhat.com> <20230906-aufheben-hagel-9925501b7822@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On Wed, 6 Sep 2023, Christian Brauner wrote:

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

"umount /opt" doesn't hang. It waits one second (until dmsetup resume is 
called) and then proceeds.

Then, it fails with "rmmod: ERROR: Module brd is in use" because the 
script didn't unmount /mnt/test.

> > BTW. what do you think that unmount of a frozen filesystem should properly 
> > do? Fail with -EBUSY? Or, unfreeze the filesystem and unmount it? Or 
> > something else?
> 
> In my opinion we should refuse to unmount frozen filesystems and log an
> error that the filesystem is frozen. Waiting forever isn't a good idea
> in my opinion.

But lvm may freeze filesystems anytime - so we'd get randomly returned 
errors then.

> But this is a significant uapi change afaict so this would need to be
> hidden behind a config option, a sysctl, or it would have to be a new
> flag to umount2() MNT_UNFROZEN which would allow an administrator to use
> this flag to not unmount a frozen filesystems.

The kernel currently distinguishes between kernel-initiated freeze (that 
is used by the XFS scrub) and userspace-initiated freeze (that is used by 
the FIFREEZE ioctl and by device-mapper initiated freeze through 
freeze_bdev).

Perhaps we could distinguish between FIFREEZE-initiated freezes and 
device-mapper initiated freezes as well. And we could change the logic to 
return -EBUSY if the freeze was initiated by FIFREEZE and to wait for 
unfreeze if it was initiated by the device-mapper.

Mikulas

