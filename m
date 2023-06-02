Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A143472026D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Jun 2023 14:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235253AbjFBMyH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Jun 2023 08:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjFBMyG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Jun 2023 08:54:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB162180;
        Fri,  2 Jun 2023 05:54:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7690C64EC2;
        Fri,  2 Jun 2023 12:54:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D484C433D2;
        Fri,  2 Jun 2023 12:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685710443;
        bh=E4tvAvvly/nNUkissqD4JjDi0RtHz4cnGxNDH6IPYgg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LHzovUnbgWS1Yqge1ua7p0PjJyjPIl+igEbAlUWklQ2y44HTHWNrVLh/M9PbNAwTQ
         ACO18rn9yZ3W5AsyLx3P2smpcoSafk6aLgVTQ3VODmfm9GQWQixVKnXAALkcyPT07O
         MhgSfhSfW274WDIZ2/T+A3NiRprLXYwnodSAtbwjnSdJU+HF/byyuuqHeouzlvJVtm
         bJQMJeEmQfN1RfbGW48OLYvXmgIJNFGf2z4BT2Wji0aNKIvatAzEuroWS8BaFTHAsl
         4YyEhJ8Nt+EHhdn9uScHRRu1g5PqN19ndmByzhY7vtJJhuLaXOqNDD2CQtX7oDa82w
         hM9yt0t+hcSuA==
Date:   Fri, 2 Jun 2023 14:53:58 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc:     Xiubo Li <xiubli@redhat.com>, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 10/13] ceph: allow idmapped setattr inode op
Message-ID: <20230602-vorzeichen-praktikum-f17931692301@brauner>
References: <20230524153316.476973-1-aleksandr.mikhalitsyn@canonical.com>
 <20230524153316.476973-11-aleksandr.mikhalitsyn@canonical.com>
 <b3b1b8dc-9903-c4ff-0a63-9a31a311ff0b@redhat.com>
 <CAEivzxfxug8kb7_SzJGvEZMcYwGM8uW25gKa_osFqUCpF_+Lhg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEivzxfxug8kb7_SzJGvEZMcYwGM8uW25gKa_osFqUCpF_+Lhg@mail.gmail.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 02, 2023 at 02:45:30PM +0200, Aleksandr Mikhalitsyn wrote:
> On Fri, Jun 2, 2023 at 3:30 AM Xiubo Li <xiubli@redhat.com> wrote:
> >
> >
> > On 5/24/23 23:33, Alexander Mikhalitsyn wrote:
> > > From: Christian Brauner <christian.brauner@ubuntu.com>
> > >
> > > Enable __ceph_setattr() to handle idmapped mounts. This is just a matter
> > > of passing down the mount's idmapping.
> > >
> > > Cc: Jeff Layton <jlayton@kernel.org>
> > > Cc: Ilya Dryomov <idryomov@gmail.com>
> > > Cc: ceph-devel@vger.kernel.org
> > > Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> > > Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
> > > ---
> > >   fs/ceph/inode.c | 11 +++++++++--
> > >   1 file changed, 9 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
> > > index 37e1cbfc7c89..f1f934439be0 100644
> > > --- a/fs/ceph/inode.c
> > > +++ b/fs/ceph/inode.c
> > > @@ -2050,6 +2050,13 @@ int __ceph_setattr(struct inode *inode, struct iattr *attr)
> > >
> > >       dout("setattr %p issued %s\n", inode, ceph_cap_string(issued));
> > >
> > > +     /*
> > > +      * The attr->ia_{g,u}id members contain the target {g,u}id we're

This is now obsolete... In earlier imlementations attr->ia_{g,u}id was
used and contained the filesystem wide value, not the idmapped mount
value.

However, this was misleading and we changed that in commit b27c82e12965
("attr: port attribute changes to new types") and introduced dedicated
new types into struct iattr->ia_vfs{g,u}id. So the you need to use
attr->ia_vfs{g,u}id as documented in include/linux/fs.h and you need to
transform them into filesystem wide values and then to raw values you
send over the wire.

Alex should be able to figure this out though.

> > > +      * sending over the wire. The mount idmapping only matters when we
> > > +      * create new filesystem objects based on the caller's mapped
> > > +      * fs{g,u}id.
> > > +      */
> > > +     req->r_mnt_idmap = &nop_mnt_idmap;
> >
> > For example with an idmapping 1000:0 and in the /mnt/idmapped_ceph/.
> >
> > This means the "__ceph_setattr()" will always use UID 0 to set the
> > caller_uid, right ? If it is then the client auth checking for the
> 
> Yes, if you have a mapping like b:1000:0:1 (the last number is a
> length of a mapping). It means even more,
> the only user from which you can create something on the filesystem
> will be UID = 0,
> because all other UIDs/GIDs are not mapped and you'll instantly get
> -EOVERFLOW from the kernel.
> 
> > setattr requests in cephfs MDS will succeed, since the UID 0 is root.
> > But if you use a different idmapping, such as 1000:2000, it will fail.
> 
> If you have a mapping b:1000:2000:1 then the only valid UID/GID from
> which you can create something
> on an idmapped mount will be UID/GID = 2000:2000 (and this will be
> mapped to 1000:1000 and sent over the wire,
> because we performing an idmapping procedure for requests those are
> creating inodes).
> So, even root with UID = 0 will not be able to create a file on such a
> mount and get -EOVERFLOW.
> 
> >
> > So here IMO we should set it to 'idmap' too ?
> 
> Good question. I can't see any obvious issue with setting an actual
> idmapping here.
> It will be interesting to know Christian's opinion about this.
> 
> Kind regards,
> Alex
> 
> >
> > Thanks
> >
> > - Xiubo
> >
> > >       if (ia_valid & ATTR_UID) {
> > >               dout("setattr %p uid %d -> %d\n", inode,
> > >                    from_kuid(&init_user_ns, inode->i_uid),
> > > @@ -2240,7 +2247,7 @@ int ceph_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
> > >       if (ceph_inode_is_shutdown(inode))
> > >               return -ESTALE;
> > >
> > > -     err = setattr_prepare(&nop_mnt_idmap, dentry, attr);
> > > +     err = setattr_prepare(idmap, dentry, attr);
> > >       if (err != 0)
> > >               return err;
> > >
> > > @@ -2255,7 +2262,7 @@ int ceph_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
> > >       err = __ceph_setattr(inode, attr);
> > >
> > >       if (err >= 0 && (attr->ia_valid & ATTR_MODE))
> > > -             err = posix_acl_chmod(&nop_mnt_idmap, dentry, attr->ia_mode);
> > > +             err = posix_acl_chmod(idmap, dentry, attr->ia_mode);
> > >
> > >       return err;
> > >   }
> >
