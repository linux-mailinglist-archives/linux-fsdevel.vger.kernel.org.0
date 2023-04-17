Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95F2F6E4B69
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Apr 2023 16:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbjDQOY7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Apr 2023 10:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjDQOY6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Apr 2023 10:24:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B66C410C;
        Mon, 17 Apr 2023 07:24:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4929A62056;
        Mon, 17 Apr 2023 14:24:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CD7CC433EF;
        Mon, 17 Apr 2023 14:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681741495;
        bh=jEolfV4qSU824Qh1BjYwq6ZXkqOqKDIdGjk2dkb+EGE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YaMhaSxpNlU90+lE26jSBVParjfGKw78oIiSDU9/pwC3LGac19oXgYWT28tMN+fya
         rEaHrM7RR+xnlZLXYu1NyaTq981wDLl8/0OF+0edqZDamdmKxqreACt1+uDS6lexEA
         QXzR3ZBoZlp5dRHsh+UMR1LjdJ0AR5KvVDaxwkmxHZBjEMutp0gGQQEGA8sQzlp1mu
         1rldU/wcyfaIYB9zHbSlZG7tYa1W4L9Wbqlj87H05ZVk4bmYDVOiG/Ba6XOjUc+VbP
         7rpL9/ho0q6UuD/9lTP8rUtMm2vgT0Tto01oKinVfk+ZupnR77UR1BECLi0OdGZOrs
         0DVUD0y+y7TLQ==
Date:   Mon, 17 Apr 2023 16:24:50 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     NeilBrown <neilb@suse.de>, Al Viro <viro@zeniv.linux.org.uk>,
        Dave Wysochanski <dwysocha@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH/RFC] VFS: LOOKUP_MOUNTPOINT should used cached info
 whenever possible.
Message-ID: <20230417-relaxen-selektiert-4b4b4143d7f6@brauner>
References: <95ee689c76bf034fa2fe9fade0bccdb311f3a04f.camel@kernel.org>
 <168168683217.24821.6260957092725278201@noble.neil.brown.name>
 <20230417-beisein-investieren-360fa20fb68a@brauner>
 <6c08ad94ca949d0f3525f7e1fc24a72c50affd59.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6c08ad94ca949d0f3525f7e1fc24a72c50affd59.camel@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 17, 2023 at 08:25:23AM -0400, Jeff Layton wrote:
> On Mon, 2023-04-17 at 13:55 +0200, Christian Brauner wrote:
> > On Mon, Apr 17, 2023 at 09:13:52AM +1000, NeilBrown wrote:
> > > 
> > > When performing a LOOKUP_MOUNTPOINT lookup we don't really want to
> > > engage with underlying systems at all.  Any mount point MUST be in the
> > > dcache with a complete direct path from the root to the mountpoint.
> > > That should be sufficient to find the mountpoint given a path name.
> > > 
> > > This becomes an issue when the filesystem changes unexpected, such as
> > > when a NFS server is changed to reject all access.  It then becomes
> > > impossible to unmount anything mounted on the filesystem which has
> > > changed.  We could simply lazy-unmount the changed filesystem and that
> > > will often be sufficient.  However if the target filesystem needs
> > > "umount -f" to complete the unmount properly, then the lazy unmount will
> > > leave it incompletely unmounted.  When "-f" is needed, we really need to
> > 
> > I don't understand this yet. All I see is nfs_umount_begin() that's
> > different for MNT_FORCE to kill remaining io. Why does that preclude
> > MNT_DETACH? You might very well fail MNT_FORCE and the only way you can
> > get rid is to use MNT_DETACH, no? So I don't see why that is an
> > argument.
> > 
> > > be able to name the target filesystem.
> > > 
> > > We NEVER want to revalidate anything.  We already avoid the revalidation
> > > of the mountpoint itself, be we won't need to revalidate anything on the
> > > path either as thay might affect the cache, and the cache is what we are
> > > really looking in.
> > > 
> > > Permission checks are a little less clear.  We currently allow any user
> > 
> > This is all very brittle.
> > 
> > First case that comes to mind is overlayfs where the permission checking
> > is performed twice. Once on the overlayfs inode itself based on the
> > caller's security context and a second time on the underlying inode with
> > the security context of the mounter of the overlayfs instance.
> > 
> > A mounter could have dropped all privileges aside from CAP_SYS_ADMIN so
> > they'd be able to mount the overlayfs instance but would be restricted
> > from accessing certain directories or files. The task accessing the
> > overlayfs instance however could have a completely different security
> > context including CAP_DAC_READ_SEARCH and such. Both tasks could
> > reasonably be in different user namespaces and so on.
> > 
> > The LSM hooks are also called twice and would now also be called once.
> > 
> > It also forgets that acl_permission() check may very well call into the
> > filesystem via check_acl().
> > 
> > So umount could either be used to infer existence of files that the user
> > wouldn't otherwise know they exist or in the worst case allow to umount
> > something that they wouldn't have access to.
> > 
> > Aside from that this would break userspace assumptions and as Al and
> > I've mentioned before in the other thread you'd need a new flag to
> > umount2() for this. The permission model can't just change behind users
> > back.
> > 
> > But I dislike it for the now even more special-cased umount path lookup
> > alone tbh. I'd feel way more comfortable with a non-lookup related
> > solution that doesn't have subtle implications for permission checking.
> > 
> 
> These are good points.
> 
> One way around the issues you point out might be to pass down a new
> MAY_LOOKUP_MOUNTPOINT mask flag to ->permission. That would allow the
> filesystem driver to decide whether it wants to avoid potentially
> problematic activity when checking permissions. nfs_permission could
> check for that and take a more hands-off approach to the permissions
> check. Between that and skipping d_revalidate on LOOKUP_MOUNTPOINT, I
> think that might do what we need.

Yes, that's pretty obvious. I considered that, wrote the section and
deleted it again because I still find this pretty ugly. It does leak
very specific lookup information into filesystems that isn't generically
useful like MAY_NOT_BLOCK is. Most filesystems don't need to check with
a server like NFS does and so don't suffer from this issue.

The crucial change in the patchset in its current form is that you're
requesting from the VFS to significantly alter permission checking just
because this is a umount request in a pretty fundamental way for roughly
21 filesytems. Afaict, on the VFS level that doesn't make sense. The VFS
can't just skip a filesystem's ->permission() handler with "well, it's
just on a way to a umount so whatever". That's just not going to be
correct and is just a source of subtle security bugs. So NAK on that.

And I'm curious why is it obvious that we don't want to revalidate _any_
path component and not just the last one? Why is that generally safe?
Why can't this be used to access files and directories the caller
wouldn't otherwise be able to access? I would like to have this spelled
out for slow people like me, please.

From my point of view, this would only be somewhat safe _generally_ if
you'd allow circumvention for revalidation and permission checking if
MNT_FORCE is specified and the caller has capable(CAP_DAC_READ_SEARCH).
You'd still mess with overlayfs permission model in this case though.

Plus, there are better options of solving this problem. Again, I'd
rather build a separate api for unmounting then playing such potentially
subtle security sensitive games with permission checking during path
lookup.
