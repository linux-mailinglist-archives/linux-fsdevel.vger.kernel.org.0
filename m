Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBB3A6F0F09
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Apr 2023 01:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344184AbjD0XfC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Apr 2023 19:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbjD0Xe7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Apr 2023 19:34:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C7D646BB
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Apr 2023 16:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682638412;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8j1mufvIgrEof2rz1gioQYw01o/93612V76WfPJiQ9s=;
        b=FojXuSDQZ41z3gKKATqVRliiJxP8kQf2GpGF6ZKdad6fa4+BLM3VVq0eaTL3n/Rrm5UlaG
        y+1IZQ0ljG457FGUdZl1ytKp2f64IS9ex71ujB2NlgtynwRsbtdv/uNqMKT3bJw7S4x1ji
        zeXcqcQ/VShM7wSonY6o4wfuvbBJXKw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-522-OJLfBfwhM7m20J7kGJ2TRQ-1; Thu, 27 Apr 2023 19:33:28 -0400
X-MC-Unique: OJLfBfwhM7m20J7kGJ2TRQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3E5FE1C068C6;
        Thu, 27 Apr 2023 23:33:28 +0000 (UTC)
Received: from rh (vpn2-52-17.bne.redhat.com [10.64.52.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5C0581121314;
        Thu, 27 Apr 2023 23:33:27 +0000 (UTC)
Received: from localhost ([::1] helo=rh)
        by rh with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <dchinner@redhat.com>)
        id 1psB75-0001eO-2u;
        Fri, 28 Apr 2023 09:33:23 +1000
Date:   Fri, 28 Apr 2023 09:33:20 +1000
From:   Dave Chinner <dchinner@redhat.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-block@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Eric Sandeen <sandeen@redhat.com>,
        Christoph Hellwig <hch@lst.de>, Zhang Yi <yi.zhang@redhat.com>
Subject: Re: [ext4 io hang] buffered write io hang in balance_dirty_pages
Message-ID: <ZEsGQFN4Pd12r+Nt@rh>
References: <ZEnb7KuOWmu5P+V9@ovpn-8-24.pek2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZEnb7KuOWmu5P+V9@ovpn-8-24.pek2.redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 27, 2023 at 10:20:28AM +0800, Ming Lei wrote:
> Hello Guys,
> 
> I got one report in which buffered write IO hangs in balance_dirty_pages,
> after one nvme block device is unplugged physically, then umount can't
> succeed.

The bug here is that the device unplug code has not told the
filesystem that it's gone away permanently.

This is the same problem we've been having for the past 15 years -
when block device goes away permanently it leaves the filesystem and
everything else dependent on the block device completely unaware
that they are unable to function anymore. IOWs, the block
device remove path is relying on -unreliable side effects- of
filesystem IO error handling to produce what we'd call "correct
behaviour".

The block device needs to be shutting down the filesystem when it
has some sort of fatal, unrecoverable error like this (e.g. hot
unplug). We have the XFS_IOC_GOINGDOWN ioctl for telling the
filesystem it can't function anymore. This ioctl
(_IOR('X',125,__u32)) has also been replicated into ext4, f2fs and
CIFS and it gets exercised heavily by fstests. Hence this isn't XFS
specific functionality, nor is it untested functionality.

The ioctl should be lifted to the VFS as FS_IOC_SHUTDOWN and a
super_operations method added to trigger a filesystem shutdown.
That way the block device removal code could simply call
sb->s_ops->shutdown(sb, REASON) if it exists rather than
sync_filesystem(sb) if there's a superblock associated with the
block device. Then all these 

This way we won't have to spend another two decades of people
complaining about how applications and filesystems hang when they
pull the storage device out from under them and the filesystem
didn't do something that made it notice before the system hung....

> So far only observed on ext4 FS, not see it on XFS.

Pure dumb luck - a journal IO failed on XFS (probably during the
sync_filesystem() call) and that shut the filesystem down.

> I guess it isn't
> related with disk type, and not tried such test on other type of disks yet,
> but will do.

It can happen on any block device based storage that gets pulled
from under any filesystem without warning.

> Seems like dirty pages aren't cleaned after ext4 bio is failed in this
> situation?

Yes, because the filesystem wasn't shut down on device removal to
tell it that it's allowed to toss away dirty pages as they cannot be
cleaned via the IO path....

-Dave.
-- 
Dave Chinner
dchinner@redhat.com

