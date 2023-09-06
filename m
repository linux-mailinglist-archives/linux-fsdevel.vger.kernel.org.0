Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86132793FE4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Sep 2023 17:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236493AbjIFPEh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Sep 2023 11:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235832AbjIFPEg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Sep 2023 11:04:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29F351992
        for <linux-fsdevel@vger.kernel.org>; Wed,  6 Sep 2023 08:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694012619;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bA3Z59EBa88YEWKPW5Pibx0Xocr0hzgWVcA/01NMcDk=;
        b=I63JMTNNlVWutI8hYUzEuTrczjzK4RAH2CWv7v8jVbQm66wpBEuxlPI25LCLJD9Jt2cSzg
        QNEadANFtYkitmeDbZA2Cz8aVcVjUUxtnAev5gILGlYCw61JjChdd1IDrROllDj94GR65G
        2Jfsj7ijZnAKZZ3ochHeY90SnthIEg4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-20-9Sj-0DwfP1CdyyoLM7eeDg-1; Wed, 06 Sep 2023 11:03:35 -0400
X-MC-Unique: 9Sj-0DwfP1CdyyoLM7eeDg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2E04910487A9;
        Wed,  6 Sep 2023 15:03:35 +0000 (UTC)
Received: from file1-rdu.file-001.prod.rdu2.dc.redhat.com (unknown [10.11.5.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E82AD404119;
        Wed,  6 Sep 2023 15:03:34 +0000 (UTC)
Received: by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix, from userid 12668)
        id CE98630C1C07; Wed,  6 Sep 2023 15:03:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix) with ESMTP id C9EEF3FD6A;
        Wed,  6 Sep 2023 17:03:34 +0200 (CEST)
Date:   Wed, 6 Sep 2023 17:03:34 +0200 (CEST)
From:   Mikulas Patocka <mpatocka@redhat.com>
To:     Christian Brauner <brauner@kernel.org>
cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Zdenek Kabelac <zkabelac@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        dm-devel@redhat.com, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] fix writing to the filesystem after unmount
In-Reply-To: <20230906-launenhaft-kinder-118ea59706c8@brauner>
Message-ID: <f5d63867-5b3e-294b-d1f5-a128817cfc7@redhat.com>
References: <59b54cc3-b98b-aff9-14fc-dc25c61111c6@redhat.com> <20230906-launenhaft-kinder-118ea59706c8@brauner>
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

> > What happens:
> > * dmsetup suspend calls freeze_bdev, that goes to freeze_super and it
> >   increments sb->s_active
> > * then we unmount the filesystem, we go to cleanup_mnt, cleanup_mnt calls
> >   deactivate_super, deactivate_super sees that sb->s_active is 2, so it
> >   decreases it to 1 and does nothing - the umount syscall returns
> >   successfully
> > * now we have a mounted filesystem despite the fact that umount returned
> 
> That can happen for any number of reasons. Other codepaths might very
> well still hold active references to the superblock. The same thing can
> happen when you have your filesystem pinned in another mount namespace.
> 
> If you really want to be absolutely sure that the superblock is
> destroyed you must use a mechanism like fanotify which allows you to get
> notified on superblock destruction.

If the administrator runs a script that performs unmount and then back-up 
of the underlying block device, it may read corrupted data. I think that 
this is a problem.

> > @@ -1251,7 +1251,7 @@ static void cleanup_mnt(struct mount *mn
> >  	}
> >  	fsnotify_vfsmount_delete(&mnt->mnt);
> >  	dput(mnt->mnt.mnt_root);
> > -	deactivate_super(mnt->mnt.mnt_sb);
> > +	wait_and_deactivate_super(mnt->mnt.mnt_sb);
> 
> Your patch means that we hang on any umount when the filesystem is
> frozen.

Currently, if we freeze a filesystem with "fsfreeze" and unmount it, the 
mount point is removed, but the filesystem stays active and it is leaked. 
You can't unfreeze it with "fsfreeze --unfreeze" because the mount point 
is gone. (the only way how to recover it is "echo j>/proc/sysrq-trigger").

> IOW, you'd also hang on any umount of a bind-mount. IOW, every
> single container making use of this filesystems via bind-mounts would
> hang on umount and shutdown.

bind-mount doesn't modify "s->s_writers.frozen", so the patch does nothing 
in this case. I tried unmounting bind-mounts and there was no deadlock.

> You'd effectively build a deadlock trap for userspace when the
> filesystem is frozen. And nothing can make progress until that thing is
> thawed. Umount can't block if the block device is frozen.

unmounting a filesystem frozen with "fsfreeze" doesn't work in the current 
kernel. We can say that the administrator shouldn't do it. But reading the 
block device after umount finishes is something that the administrator may 
do.

BTW. what do you think that unmount of a frozen filesystem should properly 
do? Fail with -EBUSY? Or, unfreeze the filesystem and unmount it? Or 
something else?

> That msleep(1) alone is a pretty nasty hack. We should definitely not
> spin in code like this. That superblock could stay frozen for a long
> time without s_umount held. So this is spinning.
> 
> Even if we wanted to do this it would need to use a similar wait
> mechanism for the filesystem to be thawed like we do in
> thaw_super_locked().

Yes, it may be possible to rework it using a wait queue.

Mikulas

