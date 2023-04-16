Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1B96E3CD3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Apr 2023 01:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjDPXiF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 16 Apr 2023 19:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjDPXiD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 16 Apr 2023 19:38:03 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D4012125
        for <linux-fsdevel@vger.kernel.org>; Sun, 16 Apr 2023 16:38:02 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id v21-20020a17090a459500b0024776162815so2819951pjg.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 16 Apr 2023 16:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1681688282; x=1684280282;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zme2OySKGE2VvMRb4G+HHWrmRanPh+C2a9onzIOhilg=;
        b=ro8jshoTM3W3LywDOQ6ji9zFPvrIbnzinfQmhSoUgPpx67XPmEOA+Y9tPapbKLive/
         iSqvA5Zyue+SHSfiK7WFbzt6s4xH3xNy66cNIdfE9oJ2qWDpOOUKAMUxS9Lxc5WVd/0C
         tI7ucIGTs1y35Yq4bUt9kCG+i3l0E8Mvu0DbWFIezoV55L/s2jMYMIv3DTT47XYlu9nU
         NN3vW/AJ/wZfOVklAGtP7Ta55nUPHvNg8fLLLVSx8Q7PGuDpyf+0WRMfqng6p78WXERh
         Y5qHJlt5m4b1MwL3JvwVtTEaUyfpcGZ2udog/nn6jl9sFeZCXaXWOH4ebFnU8fEM9iXT
         e0GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681688282; x=1684280282;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zme2OySKGE2VvMRb4G+HHWrmRanPh+C2a9onzIOhilg=;
        b=YZy9+dmRk8jc0AIoPHSjdszunI9lwgzXjwMVeBpv7/ju8k+pbyoeXvePJTou/QRxKA
         /w1v+fiqyVYhPVWixrPrCZBCMItnfqJoDr/yuXufBiTIu6vx1bswbzmLxNWBo3qDpvWH
         t9oGdI29Heapptx2DiRQjO/qOXnQVjnKyBZ1LfRkpc03Wju7Y8OCyxl7yPcy/0+tR5Jx
         mdlOPZny4MuNlnFxv4O2kn1xujI3qikCqZR13nM0dncytH3hZQuUQnAlQ1ybO4j+tN/O
         s4baiM2Nsb4CCyH05aXijsWXqRy8UoqOzbdLpWYhxziB/ae9n4G6GyBIQtIZTTbh8e9q
         s5fw==
X-Gm-Message-State: AAQBX9dQivU9w7UjaW5zTCc9ixJTe9/PkAwS0M0vIUy/VKCuPnhIaU6t
        pfHu3V4KB4s5oR+j0Xzbm6P0uw==
X-Google-Smtp-Source: AKy350b9SFMVUKkMnHQa/P2bLAGvmL5zDsVaWFNFps85can4MvEjnm6hGbM4v4MxZEVgMkqwOQtaUA==
X-Received: by 2002:a17:90a:f190:b0:247:1f35:3314 with SMTP id bv16-20020a17090af19000b002471f353314mr11543337pjb.48.1681688281995;
        Sun, 16 Apr 2023 16:38:01 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-41-174.pa.nsw.optusnet.com.au. [49.180.41.174])
        by smtp.gmail.com with ESMTPSA id q66-20020a17090a1b4800b002465ff5d829sm5813185pjq.13.2023.04.16.16.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 16:38:01 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1poBwU-004G1O-Ca; Mon, 17 Apr 2023 09:37:58 +1000
Date:   Mon, 17 Apr 2023 09:37:58 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Chuck Lever III <chuck.lever@oracle.com>,
        Frank van der Linden <fllinden@amazon.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] nfsd: don't use GFP_KERNEL from
 nfsd_getxattr()/nfsd_listxattr()
Message-ID: <20230416233758.GD447837@dread.disaster.area>
References: <72bf692e-bb6b-c1f2-d1ba-3205ab649b43@I-love.SAKURA.ne.jp>
 <4BC7955B-40E4-4A43-B2D1-2E9302E84337@oracle.com>
 <b014047a-4a70-b38f-c5bb-01bc3c53d6f2@I-love.SAKURA.ne.jp>
 <aee35d52ab19e7e95f69742be8329764db72cbf8.camel@kernel.org>
 <c310695e-4279-b1a7-5c2a-2771cc19aa66@I-love.SAKURA.ne.jp>
 <7246a80ae33244a4553bbc0ca9e771ce8143d97b.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7246a80ae33244a4553bbc0ca9e771ce8143d97b.camel@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Apr 16, 2023 at 07:51:41AM -0400, Jeff Layton wrote:
> On Sun, 2023-04-16 at 08:21 +0900, Tetsuo Handa wrote:
> > On 2023/04/16 3:40, Jeff Layton wrote:
> > > On Sun, 2023-04-16 at 02:11 +0900, Tetsuo Handa wrote:
> > > > On 2023/04/16 1:13, Chuck Lever III wrote:
> > > > > > On Apr 15, 2023, at 7:07 AM, Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp> wrote:
> > > > > > 
> > > > > > Since GFP_KERNEL is GFP_NOFS | __GFP_FS, usage like GFP_KERNEL | GFP_NOFS
> > > > > > does not make sense. Drop __GFP_FS flag in order to avoid deadlock.
> > > > > 
> > > > > The server side threads run in process context. GFP_KERNEL
> > > > > is safe to use here -- as Jeff said, this code is not in
> > > > > the server's reclaim path. Plenty of other call sites in
> > > > > the NFS server code use GFP_KERNEL.
> > > > 
> > > > GFP_KERNEL memory allocation calls filesystem's shrinker functions
> > > > because of __GFP_FS flag. My understanding is
> > > > 
> > > >   Whether this code is in memory reclaim path or not is irrelevant.
> > > >   Whether memory reclaim path might hold lock or not is relevant.
> > > > 
> > > > . Therefore, question is, does nfsd hold i_rwsem during memory reclaim path?
> > > > 
> > > 
> > > No. At the time of these allocations, the i_rwsem is not held.
> > 
> > Excuse me? nfsd_getxattr()/nfsd_listxattr() _are_ holding i_rwsem
> > via inode_lock_shared(inode) before kvmalloc(GFP_KERNEL | GFP_NOFS) allocation.
> > That's why
> > 
> > 	/*
> > 	 * We're holding i_rwsem - use GFP_NOFS.
> > 	 */
> > 
> > is explicitly there in nfsd_listxattr() side.

You can do GFP_KERNEL allocations holding the i_rwsem just fine.
All that it requires is the caller holds a reference to the inode,
and at that point inode will should skip the given inode without
every locking it.

Of course, lockdep can't handle the "referenced inode lock ->
fsreclaim -> unreferenced inode lock" pattern at all. It throws out
false positives when it detects this because it's not aware of the
fact that reference counts prevent inode lock recursion based
deadlocks in the vfs inode cache shrinker.

If a custom, non-vfs shrinker is walking inodes that have no
references and taking i_rwsem in a way that can block without first
checking whether it is safe to lock the inode in a deadlock free
manner, they are doing the wrong thing and the custom shrinker needs
to be fixed.

> > 
> > If memory reclaim path (directly or indirectly via locking dependency) involves
> > inode_lock_shared(inode)/inode_lock(inode), it is not safe to use __GFP_FS flag.
> > 
> 
> (cc'ing Frank V. who wrote this code and -fsdevel)
> 
> I stand corrected! You're absolutely right that it's taking the i_rwsem
> for read there. That seems pretty weird, actually. I don't believe we
> need to hold the inode_lock to call vfs_getxattr or vfs_listxattr, and
> certainly nothing else under there requires it.
> 
> Frank, was there some reason you decided you needed the inode_lock
> there? It looks like under the hood, the xattr code requires you to take
> it for write in setxattr and removexattr, but you don't need it at all
> in getxattr or listxattr. Go figure.

IIRC, the filesytsem can't take the i_rwsem for get/listxattr
because the lookup contexts may already hold the i_rwsem. I think
this is largely a problem caused by LSMs (e.g. IMA) needing to
access security xattrs in paths where the inode is already
locked.

> Longer term, I wonder what the inode_lock is protecting in setxattr and
> removexattr operations, given that get and list don't require them?
> These are always delegated to the filesystem driver -- there is no
> generic xattr implementation.

Serialising updates against each other. xattr modifications are
supposed to be "atomic" from the perspective of the user - they see
the entire old or the new xattr, never a partial value.

FWIW, XFS uses it's internal metadata rwsem for access/update
serialisation of xattrs because we can't rely on the i_rwsem for
reliable serialisation. I'm guessing that most journalling
filesystems do something similar.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
