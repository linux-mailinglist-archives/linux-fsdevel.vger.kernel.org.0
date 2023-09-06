Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADDA37941B9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Sep 2023 18:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241187AbjIFQx3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Sep 2023 12:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbjIFQx2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Sep 2023 12:53:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 739BA1998
        for <linux-fsdevel@vger.kernel.org>; Wed,  6 Sep 2023 09:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694019163;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mfYmAcpYkYzhKQZoChWHlcW4sGJfpbdE3D/POReW8GY=;
        b=L+vN+koAJfJ3PV+eP2VEAlTXcAxLuC3lJlQLfBfGJredpyRgokSpuZ8iGStKKECGWiuoVE
        iW9WLc0SPXhywOgQXwgrZbVnXXk4MzfZTi3Q7X0vWO7bM7iVQeKSUS/ejwdycj2KkAV+3n
        b01hdUSjRpzsV4Mb6QwV0mofogEvNuQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-691-XvGPOTMDOiisq-5g8VEEKA-1; Wed, 06 Sep 2023 12:52:40 -0400
X-MC-Unique: XvGPOTMDOiisq-5g8VEEKA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F2AFE29AA2E6;
        Wed,  6 Sep 2023 16:52:39 +0000 (UTC)
Received: from file1-rdu.file-001.prod.rdu2.dc.redhat.com (unknown [10.11.5.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E39A9404119;
        Wed,  6 Sep 2023 16:52:39 +0000 (UTC)
Received: by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix, from userid 12668)
        id D2B4230C1C07; Wed,  6 Sep 2023 16:52:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix) with ESMTP id CEFA53FD6A;
        Wed,  6 Sep 2023 18:52:39 +0200 (CEST)
Date:   Wed, 6 Sep 2023 18:52:39 +0200 (CEST)
From:   Mikulas Patocka <mpatocka@redhat.com>
To:     Christian Brauner <brauner@kernel.org>
cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Zdenek Kabelac <zkabelac@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        dm-devel@redhat.com, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] fix writing to the filesystem after unmount
In-Reply-To: <20230906-aufkam-bareinlage-6e7d06d58e90@brauner>
Message-ID: <818a3cc0-c17b-22c0-4413-252dfb579cca@redhat.com>
References: <59b54cc3-b98b-aff9-14fc-dc25c61111c6@redhat.com> <20230906-launenhaft-kinder-118ea59706c8@brauner> <f5d63867-5b3e-294b-d1f5-a128817cfc7@redhat.com> <20230906-aufheben-hagel-9925501b7822@brauner> <60f244be-803b-fa70-665e-b5cba15212e@redhat.com>
 <20230906-aufkam-bareinlage-6e7d06d58e90@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On Wed, 6 Sep 2023, Christian Brauner wrote:

> On Wed, Sep 06, 2023 at 06:01:06PM +0200, Mikulas Patocka wrote:
> > 
> > 
> > On Wed, 6 Sep 2023, Christian Brauner wrote:
> > 
> > > > > IOW, you'd also hang on any umount of a bind-mount. IOW, every
> > > > > single container making use of this filesystems via bind-mounts would
> > > > > hang on umount and shutdown.
> > > > 
> > > > bind-mount doesn't modify "s->s_writers.frozen", so the patch does nothing 
> > > > in this case. I tried unmounting bind-mounts and there was no deadlock.
> > > 
> > > With your patch what happens if you do the following?
> > > 
> > > #!/bin/sh -ex
> > > modprobe brd rd_size=4194304
> > > vgcreate vg /dev/ram0
> > > lvcreate -L 16M -n lv vg
> > > mkfs.ext4 /dev/vg/lv
> > > 
> > > mount -t ext4 /dev/vg/lv /mnt/test
> > > mount --bind /mnt/test /opt
> > > mount --make-private /opt
> > > 
> > > dmsetup suspend /dev/vg/lv
> > > (sleep 1; dmsetup resume /dev/vg/lv) &
> > > 
> > > umount /opt # I'd expect this to hang
> > > 
> > > md5sum /dev/vg/lv
> > > md5sum /dev/vg/lv
> > > dmsetup remove_all
> > > rmmod brd
> > 
> > "umount /opt" doesn't hang. It waits one second (until dmsetup resume is 
> > called) and then proceeds.
> 
> So unless I'm really misreading the code - entirely possible - the
> umount of the bind-mount now waits until the filesystem is resumed with
> your patch. And if that's the case that's a bug.

Yes.

It can be fixed by changing wait_and_deactivate_super to this:

void wait_and_deactivate_super(struct super_block *s)
{
	down_write(&s->s_umount);
	while (s->s_writers.frozen != SB_UNFROZEN && atomic_read(&s->s_active) == 2) {
		up_write(&s->s_umount);
		msleep(1);
		down_write(&s->s_umount);
	}
	deactivate_locked_super(s);
}

> > > > BTW. what do you think that unmount of a frozen filesystem should properly 
> > > > do? Fail with -EBUSY? Or, unfreeze the filesystem and unmount it? Or 
> > > > something else?
> > > 
> > > In my opinion we should refuse to unmount frozen filesystems and log an
> > > error that the filesystem is frozen. Waiting forever isn't a good idea
> > > in my opinion.
> > 
> > But lvm may freeze filesystems anytime - so we'd get randomly returned 
> > errors then.
> 
> So? Or you might hang at anytime.

lvm doesn't keep logical volumes suspended for a prolonged amount of time. 
It will unfreeze them after it made updates to the dm table and to the 
metadata. So, it won't hang forever.

I think it's better to sleep for a short time in umount than to return an 
error.

Mikulas

