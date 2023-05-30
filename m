Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB1B7162CD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 May 2023 15:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232559AbjE3N6w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 May 2023 09:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232519AbjE3N6v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 May 2023 09:58:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF4F7103;
        Tue, 30 May 2023 06:58:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 64582622B2;
        Tue, 30 May 2023 13:58:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8179C433EF;
        Tue, 30 May 2023 13:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685455127;
        bh=hcaXRRGzPBhBBLpEW0isVOB3DKBAASE/ESHMgHvcgQE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WiHDyUv0qet+LrK4Zo5p1pc0ctSRdXlGbGZ8tl02Vx1vVgIRAhB0H5UMaqqDHCAjZ
         XQjzg7jCBTWXmvjejDMJipaWrKARky609Yw4j6YSdroUBzfV6QT0wSj8m6CaH3tf0a
         g4ThSKzN/ETU2CeP8TDgy1vX+fJrEgQ9qrU3Cu+nWH+h4goHpMT99clf4C9yvIzoAB
         u6Ie6MA2SMi94iAxjNCCjqDTP+kXpP/GK97lw9niukWZB/T5wC/9lm8/PN4UXluqrd
         /1sYc6xTyVRqd7BZWVLzTIgi3XyklcdR9AufeJU8WFw8ZcapWsg4DCuEgpAdU784dC
         miq8usuqEjdFQ==
Date:   Tue, 30 May 2023 15:58:35 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc:     Xiu Jianfeng <xiujianfeng@huawei.com>, gregkh@linuxfoundation.org,
        rafael@kernel.org, viro@zeniv.linux.org.uk, dhowells@redhat.com,
        code@tyhicks.com, hirofumi@mail.parknet.co.jp,
        linkinjeon@kernel.org, sfrench@samba.org, senozhatsky@chromium.org,
        tom@talpey.com, chuck.lever@oracle.com, jlayton@kernel.org,
        miklos@szeredi.hu, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org, casey@schaufler-ca.com, dchinner@redhat.com,
        john.johansen@canonical.com, mcgrof@kernel.org,
        mortonm@chromium.org, fred@cloudflare.com, mpe@ellerman.id.au,
        nathanl@linux.ibm.com, gnoack3000@gmail.com,
        roberto.sassu@huawei.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        ecryptfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        wangweiyang2@huawei.com, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH -next 0/2] lsm: Change inode_setattr() to take struct
Message-ID: <20230530-mietfrei-zynisch-8b63a8566f66@brauner>
References: <20230505081200.254449-1-xiujianfeng@huawei.com>
 <20230515-nutzen-umgekehrt-eee629a0101e@brauner>
 <75b4746d-d41e-7c9f-4bb0-42a46bda7f17@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <75b4746d-d41e-7c9f-4bb0-42a46bda7f17@digikod.net>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 26, 2023 at 06:33:05PM +0200, Mickaël Salaün wrote:
> 
> On 15/05/2023 17:12, Christian Brauner wrote:
> > On Fri, May 05, 2023 at 04:11:58PM +0800, Xiu Jianfeng wrote:
> > > Hi,
> > > 
> > > I am working on adding xattr/attr support for landlock [1], so we can
> > > control fs accesses such as chmod, chown, uptimes, setxattr, etc.. inside
> > > landlock sandbox. the LSM hooks as following are invoved:
> > > 1.inode_setattr
> > > 2.inode_setxattr
> > > 3.inode_removexattr
> > > 4.inode_set_acl
> > > 5.inode_remove_acl
> > > which are controlled by LANDLOCK_ACCESS_FS_WRITE_METADATA.
> > > 
> > > and
> > > 1.inode_getattr
> > > 2.inode_get_acl
> > > 3.inode_getxattr
> > > 4.inode_listxattr
> > > which are controlled by LANDLOCK_ACCESS_FS_READ_METADATA
> > 
> > It would be helpful to get the complete, full picture.
> > 
> > Piecemeal extending vfs helpers with struct path arguments is costly,
> > will cause a lot of churn and will require a lot of review time from us.
> > 
> > Please give us the list of all security hooks to which you want to pass
> > a struct path (if there are more to come apart from the ones listed
> > here). Then please follow all callchains and identify the vfs helpers
> > that would need to be updated. Then please figure out where those
> > vfs helpers are called from and follow all callchains finding all
> > inode_operations that would have to be updated and passed a struct path
> > argument. So ultimately we'll end up with a list of vfs helpers and
> > inode_operations that would have to be changed.
> > 
> > I'm very reluctant to see anything merged without knowing _exactly_ what
> > you're getting us into.
> 
> Ultimately we'd like the path-based LSMs to reach parity with the
> inode-based LSMs. This proposal's goal is to provide users the ability to
> control (in a complete and easy way) file metadata access. For these we need
> to extend the inode_*attr hooks and inode_*acl hooks to handle paths. The
> chown/chmod hooks are already good.
> 
> In the future, I'd also like to be able to control directory traversals
> (e.g. chdir), which currently only calls inode_permission().
> 
> What would be the best way to reach this goal?

The main concern which was expressed on other patchsets before is that
modifying inode operations to take struct path is not the way to go.
Passing struct path into individual filesystems is a clear layering
violation for most inode operations, sometimes downright not feasible,
and in general exposing struct vfsmount to filesystems is a hard no. At
least as far as I'm concerned.

So the best way to achieve the landlock goal might be to add new hooks
in cases where you would be required to modify inode operations
otherwise. Taking the chdir() case as an example. That calls
path_permission(). Since inode_permission() and generic_permission() are
called in a lot of places where not even a dentry might be readily
available we will not extend them to take a struct path argument. This
would also involve extending the inode ->permission() method which is a
no go. That's neither feasible and would involve modifying a good chunk
of code for the sole purpose of an LSM.

So in path_permission() you might have the potential to add an LSM hook.
Or if you need to know what syscall this was called for you might have
to add a hook into chdir() itself. That is still unpleasant but since
the alternative to adding new LSM hooks might be endless layering
violations that's a compromise that at least I can live with. Ultimately
you have to convince more people.

Some concerns around passing struct path to LSM hooks in general that I
would like to just point out and ask you to keep in mind: As soon as
there's an LSM hook that takes a path argument it means all LSMs have
access to a struct path. At that point visibility into what's been done
to that struct path is lost for the fs layer.

One the one hand that's fine on the other hand sooner or later some LSM
will try to get creative and do things like starting to infer
relationships between mounts without understanding mount property and
mount handling enough, or start trying to infer the parent of a path and
perform permission checks on it in ways that aren't sane. And that sucks
because this only becomes obvious when fs wide changes are done that
affect LSM hooks as well.

And that's the other thing. The more objects the LSM layer gets access
to the greater the cost to do fs wide changes because the fs layer is
now even closer entangled with the LSM layer. For example, even simple
things like removing IOP_XATTR - even just for POSIX ACLs - suddenly
become complicated not because of the fs layer but because of how the
LSM layer makes use of it. It might start relying on internal flags that
would be revoked later and so on. That also goes for struct vfsmount. So
it means going through every LSM trying to figure out if a change is ok
or not. And we keep adding new LSMs without deprecating older ones (A
problem we also face in the fs layer.) and then they sit around but
still need to be taken into account when doing changes.
