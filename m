Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE606261F1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Nov 2022 20:32:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234015AbiKKTcC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Nov 2022 14:32:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233980AbiKKTb7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Nov 2022 14:31:59 -0500
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7695476FB2
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Nov 2022 11:31:58 -0800 (PST)
Date:   Fri, 11 Nov 2022 11:31:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1668195116;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DJT6xX+1WAMEebk+AO1GFzsspXzUi1NZznB+TV04Jfc=;
        b=n5APBWeY97SIC5E1V/XVGJBtz0wq+HUOXv0Nv3uBUT9YAeJ8T9zCbqlkkv+rSd6Fhosmoi
        maP4dr0nclSxsSkFlOeEtf7pruXaOGh+jm8u7Qex2XW8h2xhEMmXF1wepFhdd4M/zSECCV
        PcM47Reib3bhnvl40IVaFJ1wJ4Z3Gt8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, Vasily Averin <vvs@openvz.org>,
        Hugh Dickins <hughd@google.com>,
        Seth Forshee <sforshee@kernel.org>,
        =?iso-8859-1?Q?St=E9phane?= Graber <stgraber@ubuntu.com>,
        Tejun Heo <tj@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v3] xattr: use rbtree for simple_xattrs
Message-ID: <Y26jJ6oMwDGCGmC9@P9FQF9L96D.corp.robot.car>
References: <20221111115336.1845383-1-brauner@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111115336.1845383-1-brauner@kernel.org>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 11, 2022 at 12:53:36PM +0100, Christian Brauner wrote:
> A while ago Vasily reported that it is possible to set a large number of
> xattrs on inodes of filesystems that make use of the simple xattr
> infrastructure. This includes all kernfs-based filesystems that support
> xattrs (e.g., cgroupfs) and tmpfs. Both cgroupfs and tmpfs can be
> mounted by unprivileged users in unprivileged containers and root in an
> unprivileged container can set an unrestricted number of security.*
> xattrs and privileged users can also set unlimited trusted.* xattrs. As
> there are apparently users that have a fairly large number of xattrs we
> should scale a bit better. Other xattrs such as user.* are restricted
> for kernfs-based instances to a fairly limited number.
> 
> Using a simple linked list protected by a spinlock used for set, get,
> and list operations doesn't scale well if users use a lot of xattrs even
> if it's not a crazy number. There's no need to bring in the big guns
> like rhashtables or rw semaphores for this. An rbtree with a rwlock, or
> limited rcu semanics and seqlock is enough.
> 
> It scales within the constraints we are working in. By far the most
> common operation is getting an xattr. Setting xattrs should be a
> moderately rare operation. And listxattr() often only happens when
> copying xattrs between files or with the filey. Holding a lock across
> listxattr() is unproblematic because it doesn't list the values of
> xattrs. It can only be used to list the names of all xattrs set on a
> file. And the number of xattr names that can be listed with listxattr()
> is limited to XATTR_LIST_MAX aka 65536 bytes. If a larger buffer is
> passed then vfs_listxattr() caps it to XATTR_LIST_MAX and if more xattr
> names are found it will return -EFBIG. In short, the maximum amount of
> memory that can be retrieved via listxattr() is limited.
> 
> Of course, the API is broken as documented on xattr(7) already. In the
> future we might want to address this but for now this is the world we
> live in and have lived for a long time. But it does indeed mean that
> once an application goes over XATTR_LIST_MAX limit of xattrs set on an
> inode it isn't possible to copy the file and include its xattrs in the
> copy unless the caller knows all xattrs or limits the copy of the xattrs
> to important ones it knows by name (At least for tmpfs, and kernfs-based
> filesystems. Other filesystems might provide ways of achieving this.).
> 
> Bonus of this port to rbtree+rwlock is that we shrink the memory
> consumption for users of the simple xattr infrastructure.
> 
> Also add proper kernel documentation to all the functions.
> A big thanks to Paul for his comments.
> 
> Cc: Vasily Averin <vvs@openvz.org>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
> ---
> 
> Notes:
>     In the v1 and v2 of this patch we used an rbtree which was protected by an
>     rcu+seqlock combination. During the discussion it became clear that there's
>     some valid concern how safe it is to combine rcu with rbtrees. While most of
>     the issues are highly unlikely to matter in practice the code here can be
>     reached by unprivileged users rather directly so we should not be adventurous.
>     Instead of the rcu+seqlock combination simply use an rwlock. This will scale
>     sufficiently as well and had been one of the implementations I considered and
>     wrote a little while ago. Thanks to Paul for some deeper insights into issues
>     associated with rcu and rbtrees!
>     
>     In addition to this patch I would like to propose that we restrict the number
>     of xattrs for the simple xattr infrastructure via XATTR_MAX_LIST bytes. In
>     other words, we restrict the number of xattrs for simple xattr filesystems to
>     the number of xattrs names that can be retrieved via listxattr(). That should
>     be about 2000 to 3000 xattrs per inode which is more than enough. We should
>     risk this and see if we get any regression reports from userswith this
>     approach.
>     
>     This should be as simple as adding a max_list member to struct simple_xattrs
>     and initialize it with XATTR_MAX_LIST. Set operations would then check against
>     this field whether the new xattr they are trying to set will fit and return
>     -EFBIG otherwise. I think that might be a good approach to get rid of the in
>     principle unbounded number of xattrs that can be set via the simple xattr
>     infrastructure. I think this is a regression risk worth taking.
>     
>     /* v2 */
>     Christian Brauner <brauner@kernel.org>:
>     - Fix kernel doc.
>     - Remove accidental leftover union from previous iteration.
>     
>     /* v3 */
>     Port the whole thing to use a simple rwlock instead of rcu+seqlock.
>     
>     "Paul E. McKenney" <paulmck@kernel.org>:
>     - Fix simple_xattr_add() by searching the correct slot in the rbtree first.
>     
>     Roman Gushchin <roman.gushchin@linux.dev>:
>     - Avoid calling strcmp() multiple times.
> 
>  fs/xattr.c            | 317 +++++++++++++++++++++++++++++++++---------
>  include/linux/xattr.h |  38 ++---
>  mm/shmem.c            |   2 +-
>  3 files changed, 260 insertions(+), 97 deletions(-)

Acked-by: Roman Gushchin <roman.gushchin@linux.dev>

Thanks!
