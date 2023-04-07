Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0E16DAA30
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Apr 2023 10:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239718AbjDGIcW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Apr 2023 04:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239769AbjDGIcT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Apr 2023 04:32:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A95BB758;
        Fri,  7 Apr 2023 01:31:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B5A5764400;
        Fri,  7 Apr 2023 08:31:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86128C433EF;
        Fri,  7 Apr 2023 08:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680856297;
        bh=XFJX0aIoTwEZu3tF0nUfIKqcAwHn480nmM9BxuL7GGE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=SGyCFDnt9Mx1NP+juQGVr4YT+BB1tBgi1D3tIJnr6YSVzjy5wG0KfhSbW79tJgmPv
         4gBT52ErO6Vn6/aZY6JTy28+mz4zi6H2D9ZTL7Wd418qJttASLR6F9M1fBHg1uG6OU
         R6dvfEQSBebI+cXScLV+eYyS0RIXEYclJ3mgbW7nBOXvE/Y/lg083ovfgVoWrT+j7O
         JriTRu9idEYY9/KUx7lEtlsSxYzvQYj6iOx2j7QviIYho6LJn4v7Df0K7DslZsoCTZ
         tgCG5ALdKwgHxKdoLLwq0b7FLyHQ6zTkLXYnpnn7fdXo7rYiIVzdO3tjd2YCH104t6
         dWl1uOkWgKmmg==
Date:   Fri, 7 Apr 2023 10:31:30 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     Stefan Berger <stefanb@linux.ibm.com>,
        Paul Moore <paul@paul-moore.com>, zohar@linux.ibm.com,
        linux-integrity@vger.kernel.org, miklos@szeredi.hu,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: Re: [PATCH] overlayfs: Trigger file re-evaluation by IMA / EVM after
 writes
Message-ID: <20230407-trasse-umgearbeitet-d580452b7a9b@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxgoMsQnoe7VFtTDCGK_FWk==fCa8rfJ0uUr2XeWpKLy=g@mail.gmail.com>
 <4f739cc6847975991874d56ef9b9716c82cf62a3.camel@kernel.org>
 <7d8f05e26dc7152dfad771dfc867dec145aa054b.camel@kernel.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 07, 2023 at 09:42:43AM +0300, Amir Goldstein wrote:
> On Thu, Apr 6, 2023 at 11:23 PM Stefan Berger <stefanb@linux.ibm.com> wrote:
> >
> >
> >
> > On 4/6/23 15:37, Jeff Layton wrote:
> > > On Thu, 2023-04-06 at 15:11 -0400, Stefan Berger wrote:
> > >>
> > >> On 4/6/23 14:46, Jeff Layton wrote:
> > >>> On Thu, 2023-04-06 at 17:01 +0200, Christian Brauner wrote:
> > >>>> On Thu, Apr 06, 2023 at 10:36:41AM -0400, Paul Moore wrote:
> > >>
> > >>>
> > >>> Correct. As long as IMA is also measuring the upper inode then it seems
> > >>> like you shouldn't need to do anything special here.
> > >>
> > >> Unfortunately IMA does not notice the changes. With the patch provided in the other email IMA works as expected.
> > >>
> > >
> > >
> > > It looks like remeasurement is usually done in ima_check_last_writer.
> > > That gets called from __fput which is called when we're releasing the
> > > last reference to the struct file.
> > >
> > > You've hooked into the ->release op, which gets called whenever
> > > filp_close is called, which happens when we're disassociating the file
> > > from the file descriptor table.
> > >
> > > So...I don't get it. Is ima_file_free not getting called on your file
> > > for some reason when you go to close it? It seems like that should be
> > > handling this.
> >
> > I would ditch the original proposal in favor of this 2-line patch shown here:
> >
> > https://lore.kernel.org/linux-integrity/a95f62ed-8b8a-38e5-e468-ecbde3b221af@linux.ibm.com/T/#m3bd047c6e5c8200df1d273c0ad551c645dd43232
> >
> >
> > The new proposed i_version increase occurs on the inode that IMA sees later on for
> > the file that's being executed and on which it must do a re-evaluation.
> >
> > Upon file changes ima_inode_free() seems to see two ima_file_free() calls,
> > one for what seems to be the upper layer (used for vfs_* functions below)
> > and once for the lower one.
> > The important thing is that IMA will see the lower one when the file gets
> > executed later on and this is the one that I instrumented now to have its
> > i_version increased, which in turn triggers the re-evaluation of the file post
> > modification.
> >
> > static ssize_t ovl_write_iter(struct kiocb *iocb, struct iov_iter *iter)
> > [...]
> >         struct fd real;
> > [...]
> >         ret = ovl_real_fdget(file, &real);
> >         if (ret)
> >                 goto out_unlock;
> >
> > [...]
> >         if (is_sync_kiocb(iocb)) {
> >                 file_start_write(real.file);
> > -->             ret = vfs_iter_write(real.file, iter, &iocb->ki_pos,
> >                                      ovl_iocb_to_rwf(ifl));
> >                 file_end_write(real.file);
> >                 /* Update size */
> >                 ovl_copyattr(inode);
> >         } else {
> >                 struct ovl_aio_req *aio_req;
> >
> >                 ret = -ENOMEM;
> >                 aio_req = kmem_cache_zalloc(ovl_aio_request_cachep, GFP_KERNEL);
> >                 if (!aio_req)
> >                         goto out;
> >
> >                 file_start_write(real.file);
> >                 /* Pacify lockdep, same trick as done in aio_write() */
> >                 __sb_writers_release(file_inode(real.file)->i_sb,
> >                                      SB_FREEZE_WRITE);
> >                 aio_req->fd = real;
> >                 real.flags = 0;
> >                 aio_req->orig_iocb = iocb;
> >                 kiocb_clone(&aio_req->iocb, iocb, real.file);
> >                 aio_req->iocb.ki_flags = ifl;
> >                 aio_req->iocb.ki_complete = ovl_aio_rw_complete;
> >                 refcount_set(&aio_req->ref, 2);
> > -->             ret = vfs_iocb_iter_write(real.file, &aio_req->iocb, iter);
> >                 ovl_aio_put(aio_req);
> >                 if (ret != -EIOCBQUEUED)
> >                         ovl_aio_cleanup_handler(aio_req);
> >         }
> >          if (ret > 0)                                           <--- this get it to work
> >                  inode_maybe_inc_iversion(inode, false);                <--- since this inode is known to IMA
> 
> If the aio is queued, then I think increasing i_version here may be premature.
> 
> Note that in this code flow, the ovl ctime is updated in
> ovl_aio_cleanup_handler() => ovl_copyattr()
> after file_end_write(), similar to the is_sync_kiocb() code patch.
> 
> It probably makes most sense to include i_version in ovl_copyattr().
> Note that this could cause ovl i_version to go backwards on copy up
> (i.e. after first open for write) when switching from the lower inode
> i_version to the upper inode i_version.
> 
> Jeff's proposal to use vfs_getattr_nosec() in IMA code is fine too.
> It will result in the same i_version jump.
> 
> IMO it wouldn't hurt to have a valid i_version value in the ovl inode
> as well. If the ovl inode values would not matter, we would not have
> needed  ovl_copyattr() at all, but it's not good to keep vfs in the dark...
> 
> Thanks,
> Amir.

On Thu, Apr 06, 2023 at 05:24:11PM -0400, Jeff Layton wrote:
> On Thu, 2023-04-06 at 16:22 -0400, Stefan Berger wrote:
> > 
> > On 4/6/23 15:37, Jeff Layton wrote:
> > > On Thu, 2023-04-06 at 15:11 -0400, Stefan Berger wrote:
> > > > 
> > > > On 4/6/23 14:46, Jeff Layton wrote:
> > > > > On Thu, 2023-04-06 at 17:01 +0200, Christian Brauner wrote:
> > > > > > On Thu, Apr 06, 2023 at 10:36:41AM -0400, Paul Moore wrote:
> > > > 
> > > > > 
> > > > > Correct. As long as IMA is also measuring the upper inode then it seems
> > > > > like you shouldn't need to do anything special here.
> > > > 
> > > > Unfortunately IMA does not notice the changes. With the patch provided in the other email IMA works as expected.
> > > > 
> > > 
> > > 
> > > It looks like remeasurement is usually done in ima_check_last_writer.
> > > That gets called from __fput which is called when we're releasing the
> > > last reference to the struct file.
> > > 
> > > You've hooked into the ->release op, which gets called whenever
> > > filp_close is called, which happens when we're disassociating the file
> > > from the file descriptor table.
> > > 
> > > So...I don't get it. Is ima_file_free not getting called on your file
> > > for some reason when you go to close it? It seems like that should be
> > > handling this.
> > 
> > I would ditch the original proposal in favor of this 2-line patch shown here:
> > 
> > https://lore.kernel.org/linux-integrity/a95f62ed-8b8a-38e5-e468-ecbde3b221af@linux.ibm.com/T/#m3bd047c6e5c8200df1d273c0ad551c645dd43232
> > 
> > 
> 
> Ok, I think I get it. IMA is trying to use the i_version from the
> overlayfs inode.

Which is likely to give wrong results and I agree with you that it
should rely on vfs_getattr_nosec().

> 
> I suspect that the real problem here is that IMA is just doing a bare
> inode_query_iversion. Really, we ought to make IMA call
> vfs_getattr_nosec (or something like it) to query the getattr routine in
> the upper layer. Then overlayfs could just propagate the results from
> the upper layer in its response.
> 
> That sort of design may also eventually help IMA work properly with more
> exotic filesystems, like NFS or Ceph.
> 
> > The new proposed i_version increase occurs on the inode that IMA sees later on for
> > the file that's being executed and on which it must do a re-evaluation.
> > 
> > Upon file changes ima_inode_free() seems to see two ima_file_free() calls,
> > one for what seems to be the upper layer (used for vfs_* functions below)
> > and once for the lower one.
> > The important thing is that IMA will see the lower one when the file gets
> > executed later on and this is the one that I instrumented now to have its
> > i_version increased, which in turn triggers the re-evaluation of the file post
> > modification.
> > 
> > static ssize_t ovl_write_iter(struct kiocb *iocb, struct iov_iter *iter)
> > [...]
> > 	struct fd real;
> > [...]
> > 	ret = ovl_real_fdget(file, &real);
> > 	if (ret)
> > 		goto out_unlock;
> > 
> > [...]
> > 	if (is_sync_kiocb(iocb)) {
> > 		file_start_write(real.file);
> > -->		ret = vfs_iter_write(real.file, iter, &iocb->ki_pos,
> > 				     ovl_iocb_to_rwf(ifl));
> > 		file_end_write(real.file);
> > 		/* Update size */
> > 		ovl_copyattr(inode);
> > 	} else {
> > 		struct ovl_aio_req *aio_req;
> > 
> > 		ret = -ENOMEM;
> > 		aio_req = kmem_cache_zalloc(ovl_aio_request_cachep, GFP_KERNEL);
> > 		if (!aio_req)
> > 			goto out;
> > 
> > 		file_start_write(real.file);
> > 		/* Pacify lockdep, same trick as done in aio_write() */
> > 		__sb_writers_release(file_inode(real.file)->i_sb,
> > 				     SB_FREEZE_WRITE);
> > 		aio_req->fd = real;
> > 		real.flags = 0;
> > 		aio_req->orig_iocb = iocb;
> > 		kiocb_clone(&aio_req->iocb, iocb, real.file);
> > 		aio_req->iocb.ki_flags = ifl;
> > 		aio_req->iocb.ki_complete = ovl_aio_rw_complete;
> > 		refcount_set(&aio_req->ref, 2);
> > -->		ret = vfs_iocb_iter_write(real.file, &aio_req->iocb, iter);
> > 		ovl_aio_put(aio_req);
> > 		if (ret != -EIOCBQUEUED)
> > 			ovl_aio_cleanup_handler(aio_req);
> > 	}
> >          if (ret > 0)						<--- this get it to work
> >                  inode_maybe_inc_iversion(inode, false);		<--- since this inode is known to IMA
> > out:
> >          revert_creds(old_cred);
> > out_fdput:
> >          fdput(real);
> > 
> > out_unlock:
> >          inode_unlock(inode);
> > 
> > 
> > 
> > 
> >     Stefan
> > 
> > > 
> > > In any case, I think this could use a bit more root-cause analysis.
> > 
> 
> -- 
> Jeff Layton <jlayton@kernel.org>

On Thu, Apr 06, 2023 at 06:04:36PM -0400, Jeff Layton wrote:
> On Thu, 2023-04-06 at 17:24 -0400, Jeff Layton wrote:
> > On Thu, 2023-04-06 at 16:22 -0400, Stefan Berger wrote:
> > > 
> > > On 4/6/23 15:37, Jeff Layton wrote:
> > > > On Thu, 2023-04-06 at 15:11 -0400, Stefan Berger wrote:
> > > > > 
> > > > > On 4/6/23 14:46, Jeff Layton wrote:
> > > > > > On Thu, 2023-04-06 at 17:01 +0200, Christian Brauner wrote:
> > > > > > > On Thu, Apr 06, 2023 at 10:36:41AM -0400, Paul Moore wrote:
> > > > > 
> > > > > > 
> > > > > > Correct. As long as IMA is also measuring the upper inode then it seems
> > > > > > like you shouldn't need to do anything special here.
> > > > > 
> > > > > Unfortunately IMA does not notice the changes. With the patch provided in the other email IMA works as expected.
> > > > > 
> > > > 
> > > > 
> > > > It looks like remeasurement is usually done in ima_check_last_writer.
> > > > That gets called from __fput which is called when we're releasing the
> > > > last reference to the struct file.
> > > > 
> > > > You've hooked into the ->release op, which gets called whenever
> > > > filp_close is called, which happens when we're disassociating the file
> > > > from the file descriptor table.
> > > > 
> > > > So...I don't get it. Is ima_file_free not getting called on your file
> > > > for some reason when you go to close it? It seems like that should be
> > > > handling this.
> > > 
> > > I would ditch the original proposal in favor of this 2-line patch shown here:
> > > 
> > > https://lore.kernel.org/linux-integrity/a95f62ed-8b8a-38e5-e468-ecbde3b221af@linux.ibm.com/T/#m3bd047c6e5c8200df1d273c0ad551c645dd43232

We should cool it with the quick hacks to fix things. :)

> > > 
> > > 
> > 
> > Ok, I think I get it. IMA is trying to use the i_version from the
> > overlayfs inode.
> > 
> > I suspect that the real problem here is that IMA is just doing a bare
> > inode_query_iversion. Really, we ought to make IMA call
> > vfs_getattr_nosec (or something like it) to query the getattr routine in
> > the upper layer. Then overlayfs could just propagate the results from
> > the upper layer in its response.
> > 
> > That sort of design may also eventually help IMA work properly with more
> > exotic filesystems, like NFS or Ceph.
> > 
> > 
> > 
> 
> Maybe something like this? It builds for me but I haven't tested it. It
> looks like overlayfs already should report the upper layer's i_version
> in getattr, though I haven't tested that either:
> 
> -----------------------8<---------------------------
> 
> [PATCH] IMA: use vfs_getattr_nosec to get the i_version
> 
> IMA currently accesses the i_version out of the inode directly when it
> does a measurement. This is fine for most simple filesystems, but can be
> problematic with more complex setups (e.g. overlayfs).
> 
> Make IMA instead call vfs_getattr_nosec to get this info. This allows
> the filesystem to determine whether and how to report the i_version, and
> should allow IMA to work properly with a broader class of filesystems in
> the future.
> 
> Reported-by: Stefan Berger <stefanb@linux.ibm.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---

So, I think we want both; we want the ovl_copyattr() and the
vfs_getattr_nosec() change:

(1) overlayfs should copy up the inode version in ovl_copyattr(). That
    is in line what we do with all other inode attributes. IOW, the
    overlayfs inode's i_version counter should aim to mirror the
    relevant layer's i_version counter. I wouldn't know why that
    shouldn't be the case. Asking the other way around there doesn't
    seem to be any use for overlayfs inodes to have an i_version that
    isn't just mirroring the relevant layer's i_version.
(2) Jeff's changes for ima to make it rely on vfs_getattr_nosec().
    Currently, ima assumes that it will get the correct i_version from
    an inode but that just doesn't hold for stacking filesystem.

While (1) would likely just fix the immediate bug (2) is correct and
_robust_. If we change how attributes are handled vfs_*() helpers will
get updated and ima with it. Poking at raw inodes without using
appropriate helpers is much more likely to get ima into trouble.

Christian
