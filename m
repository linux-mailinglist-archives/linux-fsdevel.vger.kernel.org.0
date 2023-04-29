Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3B736F22A0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Apr 2023 05:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346637AbjD2DRT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Apr 2023 23:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbjD2DRR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Apr 2023 23:17:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD5073C06
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Apr 2023 20:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682738191;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Y8HvWUV5hy/kWDmDmtLLm7pt+PnVWNujp0CYMU9jQ6c=;
        b=MS0zLInpe1In0pld9X3eeeD2wFg/dJWChCRDo/NTgas0RRnLpyTtw9s4POCTi21d0cTF4n
        kPbm6/s7A6+RbNmt149WuET8diJ1ci9quE3WIQhqSLawawbc6d38R2Jg/duG3Qz7MEWOiD
        3yTN9a110AIDz/fx7c0tRmMK8UYieF4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-571-ssp8t18XOjSZ-rjNIW5Xcw-1; Fri, 28 Apr 2023 23:16:28 -0400
X-MC-Unique: ssp8t18XOjSZ-rjNIW5Xcw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C78AC811E7E;
        Sat, 29 Apr 2023 03:16:27 +0000 (UTC)
Received: from ovpn-8-24.pek2.redhat.com (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 05C6D40F177;
        Sat, 29 Apr 2023 03:16:19 +0000 (UTC)
Date:   Sat, 29 Apr 2023 11:16:14 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Baokun Li <libaokun1@huawei.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-ext4@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-block@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Dave Chinner <dchinner@redhat.com>,
        Eric Sandeen <sandeen@redhat.com>,
        Christoph Hellwig <hch@lst.de>, Zhang Yi <yi.zhang@redhat.com>,
        yangerkun <yangerkun@huawei.com>, ming.lei@redhat.com
Subject: Re: [ext4 io hang] buffered write io hang in balance_dirty_pages
Message-ID: <ZEyL/sjVeW88XpIn@ovpn-8-24.pek2.redhat.com>
References: <ZEnb7KuOWmu5P+V9@ovpn-8-24.pek2.redhat.com>
 <ZEny7Izr8iOc/23B@casper.infradead.org>
 <ZEn/KB0fZj8S1NTK@ovpn-8-24.pek2.redhat.com>
 <dbb8d8a7-3a80-34cc-5033-18d25e545ed1@huawei.com>
 <ZEpH+GEj33aUGoAD@ovpn-8-26.pek2.redhat.com>
 <663b10eb-4b61-c445-c07c-90c99f629c74@huawei.com>
 <ZEpcCOCNDhdMHQyY@ovpn-8-26.pek2.redhat.com>
 <ZEskO8md8FjFqQhv@ovpn-8-24.pek2.redhat.com>
 <fb127775-bbe4-eb50-4b9d-45a8e0e26ae7@huawei.com>
 <ZEtd6qZOgRxYnNq9@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZEtd6qZOgRxYnNq9@mit.edu>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 28, 2023 at 01:47:22AM -0400, Theodore Ts'o wrote:
> On Fri, Apr 28, 2023 at 11:47:26AM +0800, Baokun Li wrote:
> > Ext4 just detects I/O Error and remounts it as read-only, it doesn't know
> > if the current disk is dead or not.
> > 
> > I asked Yu Kuai and he said that disk_live() can be used to determine
> > whether
> > a disk has been removed based on the status of the inode corresponding to
> > the block device, but this is generally not done in file systems.
> 
> What really needs to happen is that del_gendisk() needs to inform file
> systems that the disk is gone, so that the file system can shutdown
> the file system and tear everything down.

OK, looks both Dave and you have same suggestion, and IMO, it isn't hard to
add one interface for notifying FS, and it can be either one s_ops->shutdown()
or shutdown_filesystem(struct super_block *sb).

But the main job should be how this interface is implemented in FS/VFS side,
so it looks one more FS job, and block layer can call shutdown_filesystem()
from del_gendisk() simply.

> 
> disk_live() is relatively new; it was added in August 2021.  Back in

IO failure plus checking disk_live() could be one way for handling the
failure, but this kind of interface isn't friendly.

> 2015, I had added the following in fs/ext4/super.c:
> 
> /*
>  * The del_gendisk() function uninitializes the disk-specific data
>  * structures, including the bdi structure, without telling anyone
>  * else.  Once this happens, any attempt to call mark_buffer_dirty()
>  * (for example, by ext4_commit_super), will cause a kernel OOPS.
>  * This is a kludge to prevent these oops until we can put in a proper
>  * hook in del_gendisk() to inform the VFS and file system layers.
>  */
> static int block_device_ejected(struct super_block *sb)
> {
> 	struct inode *bd_inode = sb->s_bdev->bd_inode;
> 	struct backing_dev_info *bdi = inode_to_bdi(bd_inode);
> 
> 	return bdi->dev == NULL;
> }
> 
> As the comment states, it's rather awkward to have the file system
> check to see if the block device is dead in various places; the real

I can understand the awkward, :-(

bdi_unregister() is called in del_gendisk(), since bdi_register() has
to be called in add_disk() where major/minor is figured out.

> problem is that the block device shouldn't just *vanish*, with the

That looks not realistic, removable disk can be gone any time, and device
driver error handler often deletes disk as the last straw, and it shouldn't
be hard to observe such error.

Also it is not realistic to wait until all openers closes the bdev, given
it may wait forever.

> block device structures egetting partially de-initialized, without the
> block layer being polite enough to let the file system know.

Block device & gendisk instance won't be gone if the bdev is opened, and
I guess it is just few fields deinitialized, such as bdi->dev, bdi could be
the only one used by FS code. 

> 
> > Those dirty pages that are already there are piling up and can't be
> > written back, which I think is a real problem. Can the block layer
> > clear those dirty pages when it detects that the disk is deleted?
> 
> Well, the dirty pages belong to the file system, and so it needs to be
> up to the file system to clear out the dirty pages.  But I'll also
> what the right thing to do when a disk gets removed is not necessarily
> obvious.

Yeah, clearing dirty pages doesn't belong to block layer.

> 
> For example, suppose some process has a file mmap'ed into its address
> space, and that file is on the disk which the user has rudely yanked
> out from their laptop; what is the right thing to do?  Do we kill the
> process?  Do we let the process write to the mmap'ed region, and
> silently let the modified data go *poof* when the process exits?  What
> if there is an executable file on the removable disk, and there are
> one or more processes running that executable when the device
> disappears?  Do we kill the process?  Do we let the process run unti
> it tries to access a page which hasn't been paged in and then kill the
> process?
> 
> We should design a proper solution for What Should Happen when a
> removable disk gets removed unceremoniously without unmounting the
> file system first.  It's not just a matter of making some tests go
> green....

Agree, the trouble is actually in how FS to handle the disk removal.


Thanks,
Ming

