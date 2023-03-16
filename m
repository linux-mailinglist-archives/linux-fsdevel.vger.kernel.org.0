Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3296D6BCCF6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Mar 2023 11:37:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjCPKhj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Mar 2023 06:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjCPKhi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Mar 2023 06:37:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC4BCB1A56;
        Thu, 16 Mar 2023 03:37:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 059CD61FCF;
        Thu, 16 Mar 2023 10:37:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DB2BC433D2;
        Thu, 16 Mar 2023 10:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678963045;
        bh=aaZRwQVh0S2cwsOoK6mMGNTaZ2Y0Wz+xzaT0LCVeMns=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=knOT7AazRIZYcsoJtphylGvsPe8pvp+iziSMhJdR51h38GuSAFeHnY8gjCnElKaf0
         N9sVfWihzcoa22bHorYbDMblpyFodtK4h4AvMTsgoA4LrTGt6cz9RYdOdS/8o4T41Z
         wZfB08uAhxyUaakCi1pJrOZauf2ZKLlS4NzkVEhnq7HfSHBGKvINpnqPCg/4B0Yfl1
         G8jpX8L8sghB4eUs45v/81xb4LGqLS/Rcq9CN60TVuq3rohSjl6ovtGkpJzgbdBCZX
         xVkWLIXGVWM+JaJOJprYYuLweWtoa8Ap52vkKmJoJeM7ZDBFGvQ0DtAPiiqOUHPvmS
         AhFl4A6bezNwg==
Date:   Thu, 16 Mar 2023 11:37:19 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Glenn Washburn <development@efficientek.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        Seth Forshee <sforshee@kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH v2] hostfs: handle idmapped mounts
Message-ID: <20230316103719.v6tircpezxmal7o3@wittgenstein>
References: <20230301015002.2402544-1-development@efficientek.com>
 <20230302083928.zek46ybxvuwgwdf5@wittgenstein>
 <20230304002846.48278199@crass-HP-ZBook-15-G2>
 <20230304120118.bhbilwzhmjt72fok@wittgenstein>
 <b0e04468-f313-047d-5bde-785bb826599b@efficientek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b0e04468-f313-047d-5bde-785bb826599b@efficientek.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 16, 2023 at 06:20:19AM +0000, Glenn Washburn wrote:
> On 3/4/23 12:01, Christian Brauner wrote:
> > On Sat, Mar 04, 2023 at 12:28:46AM -0600, Glenn Washburn wrote:
> > > On Thu, 2 Mar 2023 09:39:28 +0100
> > > Christian Brauner <brauner@kernel.org> wrote:
> > > 
> > > > On Tue, Feb 28, 2023 at 07:50:02PM -0600, Glenn Washburn wrote:
> > > > > Let hostfs handle idmapped mounts. This allows to have the same
> > > > > hostfs mount appear in multiple locations with different id
> > > > > mappings.
> > > > > 
> > > > > root@(none):/media# id
> > > > > uid=0(root) gid=0(root) groups=0(root)
> > > > > root@(none):/media# mkdir mnt idmapped
> > > > > root@(none):/media# mount -thostfs -o/home/user hostfs mnt
> > > > > 
> > > > > root@(none):/media# touch mnt/aaa
> > > > > root@(none):/media# mount-idmapped --map-mount u:`id -u user`:0:1
> > > > > --map-mount g:`id -g user`:0:1 /media/mnt /media/idmapped
> > > > > root@(none):/media# ls -l mnt/aaa idmapped/aaa -rw-r--r-- 1 root
> > > > > root 0 Jan 28 01:23 idmapped/aaa -rw-r--r-- 1 user user 0 Jan 28
> > > > > 01:23 mnt/aaa
> > > > > 
> > > > > root@(none):/media# touch idmapped/bbb
> > > > > root@(none):/media# ls -l mnt/bbb idmapped/bbb
> > > > > -rw-r--r-- 1 root root 0 Jan 28 01:26 idmapped/bbb
> > > > > -rw-r--r-- 1 user user 0 Jan 28 01:26 mnt/bbb
> > > > > 
> > > > > Signed-off-by: Glenn Washburn <development@efficientek.com>
> > > > > ---
> > > > > Changes from v1:
> > > > >   * Rebase on to tip. The above commands work and have the results
> > > > > expected. The __vfsuid_val(make_vfsuid(...)) seems ugly to get the
> > > > > uid_t, but it seemed like the best one I've come across. Is there a
> > > > > better way?
> > > > 
> > > > Sure, I can help you with that. ;)
> > > 
> > > Thank you!
> > > 
> > > > > 
> > > > > Glenn
> > > > > ---
> > > > >   fs/hostfs/hostfs_kern.c | 13 +++++++------
> > > > >   1 file changed, 7 insertions(+), 6 deletions(-)
> > > > > 
> > > > > diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
> > > > > index c18bb50c31b6..9459da99a0db 100644
> > > > > --- a/fs/hostfs/hostfs_kern.c
> > > > > +++ b/fs/hostfs/hostfs_kern.c
> > > > > @@ -786,7 +786,7 @@ static int hostfs_permission(struct mnt_idmap
> > > > > *idmap, err = access_file(name, r, w, x);
> > > > >   	__putname(name);
> > > > >   	if (!err)
> > > > > -		err = generic_permission(&nop_mnt_idmap, ino,
> > > > > desired);
> > > > > +		err = generic_permission(idmap, ino, desired);
> > > > >   	return err;
> > > > >   }
> > > > > @@ -794,13 +794,14 @@ static int hostfs_setattr(struct mnt_idmap
> > > > > *idmap, struct dentry *dentry, struct iattr *attr)
> > > > >   {
> > > > >   	struct inode *inode = d_inode(dentry);
> > > > > +	struct user_namespace *fs_userns = i_user_ns(inode);
> > > > 
> > > > Fyi, since hostfs can't be mounted in a user namespace
> > > > fs_userns == &init_user_ns
> > > > so it doesn't really matter what you use.
> > > 
> > > What would you suggest as preferable?
> > 
> > I would leave init_user_ns hardcoded as it clearly indicates that hostfs
> > can only be mounted in the initial user namespace. Plus, the patch is
> > smaller.
> > 
> > > 
> > > > >   	struct hostfs_iattr attrs;
> > > > >   	char *name;
> > > > >   	int err;
> > > > >   	int fd = HOSTFS_I(inode)->fd;
> > > > > -	err = setattr_prepare(&nop_mnt_idmap, dentry, attr);
> > > > > +	err = setattr_prepare(idmap, dentry, attr);
> > > > >   	if (err)
> > > > >   		return err;
> > > > > @@ -814,11 +815,11 @@ static int hostfs_setattr(struct mnt_idmap
> > > > > *idmap, }
> > > > >   	if (attr->ia_valid & ATTR_UID) {
> > > > >   		attrs.ia_valid |= HOSTFS_ATTR_UID;
> > > > > -		attrs.ia_uid = from_kuid(&init_user_ns,
> > > > > attr->ia_uid);
> > > > > +		attrs.ia_uid = __vfsuid_val(make_vfsuid(idmap,
> > > > > fs_userns, attr->ia_uid)); }
> > > > >   	if (attr->ia_valid & ATTR_GID) {
> > > > >   		attrs.ia_valid |= HOSTFS_ATTR_GID;
> > > > > -		attrs.ia_gid = from_kgid(&init_user_ns,
> > > > > attr->ia_gid);
> > > > > +		attrs.ia_gid = __vfsgid_val(make_vfsgid(idmap,
> > > > > fs_userns, attr->ia_gid));
> > > > 
> > > > Heh, if you look include/linux/fs.h:
> > > > 
> > > >          /*
> > > >           * The two anonymous unions wrap structures with the same
> > > > member. *
> > > >           * Filesystems raising FS_ALLOW_IDMAP need to use
> > > > ia_vfs{g,u}id which
> > > >           * are a dedicated type requiring the filesystem to use the
> > > > dedicated
> > > >           * helpers. Other filesystem can continue to use ia_{g,u}id
> > > > until they
> > > >           * have been ported.
> > > >           *
> > > >           * They always contain the same value. In other words
> > > > FS_ALLOW_IDMAP
> > > >           * pass down the same value on idmapped mounts as they would
> > > > on regular
> > > >           * mounts.
> > > >           */
> > > >          union {
> > > >                  kuid_t          ia_uid;
> > > >                  vfsuid_t        ia_vfsuid;
> > > >          };
> > > >          union {
> > > >                  kgid_t          ia_gid;
> > > >                  vfsgid_t        ia_vfsgid;
> > > >          };
> > > > 
> > > > this just is:
> > > > 
> > > > attrs.ia_uid = from_vfsuid(idmap, fs_userns, attr->ia_vfsuid));
> > > > attrs.ia_gid = from_vfsgid(idmap, fs_userns, attr->ia_vfsgid));
> > > 
> > > Its easy to miss from this patch because of lack of context, but attrs
> > > is a struct hostfs_iattr, not struct iattr. And attrs.ia_uid is of type
> > > uid_t, not kuid_t. So the above fails to compile. This is why I needed
> > 
> > Oh, I see. And then that raw value is used by calling
> > fchmod()/chmod()/chown()/fchown() and so on. That's rather special.
> > Ok, then I know what to do.
> > 
> > > to wrap make_vfsuid() in __vfsuid_val() (to get the uid_t).
> > 
> > Right. My point had been - independent of the struct hostfs_iattr issue
> > you thankfully pointed out - that make_vfsuid() is wrong here.
> > 
> > make_vfsuid() is used to map a filesystem wide k{g,u}id_t according to
> > the mount's idmapping that operation originated from. But that's done
> > by the vfs way before we're calling into the filesystem. For example,
> > it's done in chown_common().
> > 
> > So the value placed in struct iattr (the VFS struct) is already a
> > vfs{g,u}id stored in iattr->ia_vfs{g,u}id. So you need to use
> > from_vfs{g,u}id() here.
> > 
> > > 
> > > I had decided against using from_vfsuid() because then I thought I'd
> > > need to use from_kuid() to get the uid_t. And from_kuid() takes the
> > > namespace (again), which seemed uglier.
> > > 
> > > Based on this, what do you suggest?
> > 
> > Ok, so just some details on the background before I paste what I think
> > we should do.
> > As soon as you support idmapped mounts you at least technically are
> Thanks for the detailed explanation. I apologize for not getting back to
> this sooner.

No need to apologize!

> 
> > always dealing with two mappings:
> > 
> > (1) First, there's the filesystem wide idmapping which is taken from the
> >      namespace the filessytem was mounted in. This idmapping is applied
> >      when you read the raw uid/gid value from disk and turn into a kuid_t
> >      type. That value is persistent and stored in inode->i_{g,u}id. All
> >      things that are cached and that can be accessed from multiple mounts
> >      concurrently can only ever cache k{g,u}id_t aka filesystem values.
> > (2) Whenever we're dealing with an operation that's coming from an
> >      idmapped mount we need to take the idmapping of the mount into
> >      account. That idmapping is completely separate type struct
> >      mnt_idmap that's opaque for filesystems and most of the vfs.
> > 
> >      That idmapping is used to generate the vfs{g,u}id_t. IOW, translates
> >      from the filesystem representation to a mount/vfs representation.
> > 
> > So, in order to store the correct value on disk we need to invert those
> > two idmappings to arrive at the raw value that we want to store:
> > (U1) from_vfsuid() // map to the filesystem wide value aka something
> >       that we can store in inode->i_{g,u}id and that's cacheable. This is
> >       done in setattr_copy().
> > (U2) from_kuid() // map the filesystem wide value to the raw value we
> >       want to store on disk
> 
> It seems to me that there are actually 3 mappings, with the third being (U2)
> above (ie vfsuid_t -> kuid_t). And that from_vfsuid() does mappings (1) and
> (2) above. Is this incorrect?

My language was confusing. You're dealing two _idmappings_ but
3 mappings _may_ be performed iff the filesystem you're dealing with can
itself be mounted with an idmapping/in a namespace. Otherwise it's just
two mappings as the filesystem idmapping is a nop,
i.e., maps 0:0, 1:1, ..., n:n.

For details you can read Documentation/filesystems/idmappings.rst but
note that it's out of date and requires the patch I picked up a few days
ago:
https://git.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping.git/commit/?h=for-next&id=5d3ca5968480758a29a0b2777da9049a7c5134e3

> 
> Whats confusing to me is that from_vfsuid() takes both an idmap and a user
> namespace, so presumably it will handle both mapping types (1) and (2). And
> then there's from_kuid() which takes an idmap, so I thought it might also do
> a type (2) mapping. But looking at the code it doesn't seem to ever use its
> idmap parameter. Can you explain the rational behind having from_kuid() take
> an idmap? Is it legacy that will be cleaned up as this code settles down /
> stabilizes? Or perhaps its

Sure, I can explain. The from_kuid() function maps from a kuid_t into a
uid_t and the make_kuid() function maps from a uid_t into a kuid_t. They
are used to interact with a caller's idmapping (current_user_ns()) or a
filesystem idmapping (sb->s_user_ns). (As far as I'm concerned, that's
already a severe ambiguity as a filesystem idmapping is something very
different from a caller idmapping. Technically, this should've
been expressed in the form of a dedicated type struct fs_userns or sm to
keep them distinct. But that's a different topic.)

So, idmapped mounts bring in the concept of per mount ownership. So you
need to distinguish between filesystem wide ownership (kuid_t/kgid_t)
and mount local/VFS ownership (vfsuid_t/vfsgid_t). Expressing this in
two different types is a safety measure so you can't generate a vfsuid_t
via make_kuid() and you can't generate a uid_t from a vfsuid_t via
from_kuid(). Because they fundamentally shouldn't be concerned with
VFS/mount ownership to avoid confusion.

So the next step is to ensure that the idmapping used to generate such
vfsuid_t/vfsgid_t is type-distinct from caller- and filesystem
namespaces. This way you can never pass a mount idmapping to
from_kuid(), make_kuid(), or accidently use it for permission checking
in ns_capable() etc.

So the dedicated struct mnt_idmap type makes such bugs impossible as it
can only be passed to dedicated helpers and cannot be dereferenced
outside of a tiny piece of core VFS code.

In addition to that, we should aim to let filesystems create idmapped
mounts without having to allocate namespaces. Ofc, for the container
use-case it's very convenient to just be able to reuse the container's
namespace, attach it to a mount and thus delegate the mount to the
container. This is especially nice because it _can_ be used make
container ownership completely transient. IOW, you could spawn the same
container with a random idmapping everytime because the idmap isn't
persisted on-disk.

Back to your case. As I've explained. hostfs cannot be mounted inside of
namespaces. Thus, the idmapping attached to the filesystem retievable
via i_user_ns() is a nop, i.e., it maps 0:0, 1:1, ..., n:n. So there's
nothing to do for from_kuid() or make_kuid() before mapping into a
mount.

More details you should be able to find in
Documentation/filesystems/idmappings.rst as mentioned before.

> 
> > 
> > For nearly all filesystems these steps almost never need to be performed
> > explicitly. Instead, dedicated vfs helpers will do this:
> > 
> > (U1) i_{g,u}id_update() // map to filesystem wide value
> > (U2) i_{g,u}id_read() // map to raw on-disk value
> > 
> > For filesystems that don't support being mounted in namespaces the (U2)
> > step is always a nop. So technically there's no difference between:
> > 
> > (U2) from_kuid() and __kuid_val(kuid)
> > 
> > but it's cleaner to use the helpers even in that case.
> > 
> > So given how hostfs works these two steps need to be performed
> > explicitly. So I suggest (untested):
> > 
> > diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
> > index c18bb50c31b6..72b7e1bcc32e 100644
> > --- a/fs/hostfs/hostfs_kern.c
> > +++ b/fs/hostfs/hostfs_kern.c
> > @@ -813,12 +813,22 @@ static int hostfs_setattr(struct mnt_idmap *idmap,
> >                  attrs.ia_mode = attr->ia_mode;
> >          }
> >          if (attr->ia_valid & ATTR_UID) {
> > +               kuid_t kuid;
> > +
> >                  attrs.ia_valid |= HOSTFS_ATTR_UID;
> > -               attrs.ia_uid = from_kuid(&init_user_ns, attr->ia_uid);
> > +               /* Map the vfs id into the filesystem. */
> > +               kuid = from_vfsuid(idmap, &init_user_ns, attr->ia_vfsuid);
> > +               /* Map the filesystem id to its raw on disk value. */
> > +               attrs.ia_uid = from_kuid(&init_user_ns, kuid);
> 
> Its interesting that this is what I originally discarded, as an unfamiliar
> reader, it looks like you're doing two namespace mappings. But that's not
> happening because from_kuid() disregards its namespace parameter.

It's a nop because hostfs isn't mountable inside of namespace/with an
idmapping.

> 
> I've tested this and it does seems to work. Thanks!

+1

Not sure if you have xfstests integration but if you do:

sudo ./check -g idmapped

you'll get a whole testsuite dedicated to it.
