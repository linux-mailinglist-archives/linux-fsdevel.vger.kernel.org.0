Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 574AD43B35A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Oct 2021 15:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236271AbhJZNsa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Oct 2021 09:48:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55297 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236267AbhJZNsa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Oct 2021 09:48:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635255965;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5Ep8HB0+Wzr9HQfBXAnDK/+PUPziF55iKgs+3mE2DhA=;
        b=Mj1Q8pZezzPo9zsTnxbX6q3HE0sc0cnuNPOwByYJV9MvLDSkNJc8Niszce1F2tyFmrh4Sv
        eSHcBj/mpsMLOAHK/A/OdnZUq6m1jls+vqoB3UfxgrRtv+TEjfaBTGGHjsseJ59V/w2M1P
        0yaFqa7Q9Q6nw2gPZFuajiZ3FggPadc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-40-rRG3SKqyMEihEEHZakpMfg-1; Tue, 26 Oct 2021 09:46:02 -0400
X-MC-Unique: rRG3SKqyMEihEEHZakpMfg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C8821362F8;
        Tue, 26 Oct 2021 13:46:00 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.17.178])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 735F65C1A1;
        Tue, 26 Oct 2021 13:45:59 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id F28AA2204A5; Tue, 26 Oct 2021 09:45:58 -0400 (EDT)
Date:   Tue, 26 Oct 2021 09:45:58 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     JeffleXu <jefflexu@linux.alibaba.com>,
        Dave Chinner <dchinner@redhat.com>, stefanha@redhat.com,
        miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
        virtio-fs@redhat.com, bo.liu@linux.alibaba.com,
        joseph.qi@linux.alibaba.com
Subject: Re: [PATCH v6 2/7] fuse: make DAX mount option a tri-state
Message-ID: <YXgGlrlv9VBFVt2U@redhat.com>
References: <20211011030052.98923-3-jefflexu@linux.alibaba.com>
 <YW2AU/E0pLHO5Yl8@redhat.com>
 <652ac323-6546-01b8-992e-460ad59577ca@linux.alibaba.com>
 <YXAzB5sOrFRUzTC5@redhat.com>
 <96956132-fced-5739-d69a-7b424dc65f7c@linux.alibaba.com>
 <20211025175251.GF3465596@iweiny-DESK2.sc.intel.com>
 <YXbzeomdC5cD1xfF@redhat.com>
 <20211025190201.GG3465596@iweiny-DESK2.sc.intel.com>
 <YXcGiw6m9363Cz83@redhat.com>
 <20211025204145.GH3465596@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211025204145.GH3465596@iweiny-DESK2.sc.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 25, 2021 at 01:41:45PM -0700, Ira Weiny wrote:
> On Mon, Oct 25, 2021 at 03:33:31PM -0400, Vivek Goyal wrote:
> 
> [snip]
> 
> > > > > > > 
> > > > > > 
> > > > > > I can only find the following discussions about the earliest record on
> > > > > > this tri-state mount option:
> > > > > > 
> > > > > > https://lore.kernel.org/lkml/20200316095509.GA13788@lst.de/
> > > > > > https://lore.kernel.org/lkml/20200401040021.GC56958@magnolia/
> > > > > > 
> > > > > > 
> > > > > > Hi, Ira Weiny,
> > > > > > 
> > > > > > Do you have any thought on this, i.e. why the default behavior has
> > > > > > changed after introduction of per inode dax?
> > > > > 
> > > > > While this is 'technically' different behavior the end user does not see any
> > > > > difference in behavior if they continue without software changes.  Specifically
> > > > > specifying nothing continues to operate with all the files on the FS to be
> > > > > '_not_ DAX'.  While specifying '-o dax' forces DAX on all files.
> > > > > 
> > > > > This expands the default behavior in a backwards compatible manner.
> > > > 
> > > > This is backward compatible in a sense that if somebody upgrades to new
> > > > kernel, things will still be same. 
> > > > 
> > > > I think little problematic change is that say I bring in persistent
> > > > memory from another system (which has FS_XFLAGS_DAX set on some inodes)
> > > > and then mount it without andy of the dax mount options, then per
> > > > inode dax will be enabled unexpectedly if I boot with newer kernels
> > > > but it will be disable if I mount with older kernels. Do I understand it
> > > > right.
> > > 
> > > Indeed that will happen.  However, wouldn't the users (software) of those files
> > > have knowledge that those files were DAX and want to continue with them in that
> > > mode?
> > 
> > I am not sure. Say before per-inode dax feature, I had written a script
> > which walks though all the mount points and figure out if dax is enabled
> > or not. I could simply look at mount options and tell if dax could be
> > enabled or not.
> > 
> > But now same script will give false results as per inode dax could
> > still be enabled.
> 
> The mount option is being deprecated.  So it is best to start to phase out
> scripts like that.

Sure. But this change does break such scripts (if there is any). I am
just responding to previous comments that existing software/scripts
should not be broken. 

> 
> > 
> > > 
> > > > 
> > > > > The user
> > > > > can now enable DAX on some files.  But this is an opt-in on the part of the
> > > > > user of the FS and again does not change with existing software/scripts/etc.
> > > > 
> > > > Don't understand this "opt-in" bit. If user mounts an fs without
> > > > specifying any of the dax options, then per inode dax will still be
> > > > enabled if inode has the correct flag set.
> > > 
> > > But only users who actually set that flag 'opt-in'.
> > > 
> > > > So is setting of flag being
> > > > considered as opt-in (insted of mount option).
> > > 
> > > Yes.
> > > 
> > > > 
> > > > If setting of flag is being considered as opt-in, that probably will not
> > > > work very well with virtiofs. Because server can enforce a different
> > > > policy for enabling per file dax (instead of FS_XFLAG_DAX).
> > > 
> > > I'm not sure I understand how this happens?  I think the server probably has to
> > > enable per INODE by default to allow the client to do what the end users wants.
> > > 
> > 
> > Server can have either per inode disabled or enabled. If enabled, it could
> > determine DAX status of file based on FS_XFLAG_DAX or based on something
> > else depending on server policy. Users want to be able to determine
> > DAX status of file based on say file size.
> 
> 'file size'?  I'm not sure how that would work.  Did you mean something else?

So virtiofs uses DAX only to bypass page cache in guest. virtiofs pci
device advertizes a range of memory which is directly accessed using
dax. We use a chunk size of 2MB. That means for every 2MB chunk, there
will be around 512 pages. Each struct page will consume around 64 bytes
of RAM in guest. So for every 2MB chunk of file, RAM usage in guest
is around 512 * 64 = 32768 (32Kib). 

So there are users who claim that for smaller files say 4K or 8K in size,
it is probably better to not use DAX at all. In that case we will use
say 4K of page cache and leave DAX memory to be used for larger files.
(This will be useful only if virtiofs cache memory is in short supply). 

Hence the idea that why not use per inode dax and enable dax selectively
on files as needed. Given we have a remote server running, it gives
extra capability that we can take this DAX decision dynamically based
on some server policy (and not necessarily rely on FS_XFLAG_DAX stuff).

So once such policy is file size based policy. Where if a file size 
is small, server might not want to use DAX on that file. There could
be many more such policies depending on where DAX is most useful
in the context of virtiofs.

> 
> > 
> > > I agree that if the end user is expecting DAX and the server disables it then
> > > that is a problem but couldn't that happen before?
> > 
> > If end user expects to enable DAX and sever can't enable it, then mount
> > fails. So currently if you mount "-o dax" and server does not support
> > DAX, mount will fail.
> 
> The same could happen on a server where the underlying device does not support
> DAX.  What if the server was mounted without '-o dax'?

In general, there is no connection between DAX in guest and device on
host enabling DAX. We can very well enable DAX in guest without having
any DAX enabled on host device. From virtiofs perspective, we are just
mmapping host files in qemu address space and that works both with
dax enabled/disabled devices on host.

> Wouldn't a client mount
> with '-o dax' fail now?  So why can't the same be true with the new set of
> options?

So yes, if server does not support DAX and client asks for DAX, mount
will fail. (As it should fail).

Problem with enabling "dax=inode" by default is that if a client
is mounted without any dax option, then dax is disabled. Now if a server
is upgraded and restarted with some dax policy enabled, suddenly dax
will be enabled in client without it opting in for anything and client
might be surprised.

Now one argument can be hey, we have FS_XFLAG_DAX set on inode, so it
is ok to turn on dax. May be. But virtiofs serever can have its own
dax policies (like file size based policy), and it can ignore
FS_XFLAG_DAX completely. In that case enabling per inode dax by default
(without client opting in), seems contrary to what we are doing now.

Hence, I think not having "dax=inode" as default, is path of least
surprise for an existing user. A user can easily tell whether dax
is being used or not just by looking at filesystem mount optins.

> 
> > 
> > I think same should happen when per inode DAX is introduced for virtiofs.
> > If sever does not support per inode dax and user mounts with "-o
> > dax=inode", then mount should fail.
> 
> I think that is reasonable.  The client can't mount with something the server
> can't support.
> 
> > 
> > In fact, this is another reason that probably "dax=inode" should not be
> > default. Say client is new and server is old and does not support
> > per inode dax, then client might start failing mount after client
> > upgrade, and that's not good.
> 
> Shouldn't the client fall back to whatever the server supports?  It is the same
> as the client wanting DAX now without server and/or device support.  It just
> can't get it.  Right?

Well, current model is that fail the operation and let user try mount
again without DAX.

If we were to design fallback, then question will be how will user know
that server does not support DAX and we fallback to non-dax. Also it will
be change of behavior as well from exsiting non-fallback semantics.

I guess one could argue that if you are moving to new dax options
(-o dax=inode/always/never), then this is an opportunity to move to
fallback model. My concern remains thought that if user specified
"dax=inode or dax=always" and server does not support, how will user
know we are not using dax. 

Not sure there is a good answer here. In some cases users like to
see explicit failure if some option can't be supported. IIRC, in case
of overalayfs, if users passed in "-o metacopy=on" and if overlayfs
can't enable it, then users expected a failure (instead of a ignoring
metacopy silently).

So choosing not to fallback seems ok to be. Nobody has complained so far.

> 
> > 
> > More I think about it, more it feels like that "dax=never" should be
> > the default if user has not specified any of the dax options. This
> > probably will introduce least amount of surprise. Atleast for virtiofs.
> > IMHO, it probably would have made sense even for ext4/xfs but that
> > ship has already sailed.
> 
> I disagree because dax=never is backwards from what we really want for the
> future.  'dax=inode' is the most flexible setting.

If your goal is to enable dax by default if FS_XFLAG_DAX is set, then'
yes dax=inode default makes sense. I was only complaining about change
of behavior in some cases. I mean one coule argue same thing for
dax=always. If block device supports dax, then enable dax by default
until and unless user specifies "-o dax=never". But previous options
were not designed that way. A user had to opt-in for DAX behavior
even if device had the capability to support DAX.

And in the same line, I am arguing a user should opt-in for per inode
DAX, even if inode has the capability to be used as DAX inode.

And I don't mind "dax=inode" being default if that's deemed more useful.
My concern there is only change of behavior by default.

> In fact that setting is
> best for the server by default which allows more control to be in the clients
> hands.  Would you agree?

"dax=inode" on server default makes sense to me (as long as client asked
for dax=inode). Should it be enabled by default in client, I am still
afraid of change of behavior from existing dax mount options and having
to explain and justify change of behavior to users.

> 
> > 
> > > Maybe I'm getting confused
> > > because I'm not familiar enough with virtiofs.
> > > 
> > > > 
> > > > And given there are two entities here (client and server), I think it
> > > > will be good if if we give client a chance as well to decide whether
> > > > it wants to enable per file dax or not. I know it can alwasy do 
> > > > "dax=never" but it can still be broken if client software remains
> > > > same but host/server software is upgraded or commnad line changed.
> > > 
> > > But the files are 'owned' by a single user or group of users who must have
> > > placed the file in DAX mode at some point right?
> > 
> > Yes, either users/groups/admin might have set FS_XFLAG_DAX on inodes. But
> > now there is another controller (virtiofs server) which determines whether
> > that flag takes affect or not (based on server settings).
> 
> I think this is just like the file being on a device which does not support
> DAX.  The file inode flag can be set but the file will not be in DAX mode on a
> non-dax device.  So in this case the server is a non-dax device.

So if I mount with "dax=inode or dax=always" and block device does not
support DAX, what happens. Mount fails or it fallsback siliently to
non-dax mode?

I suspect that in new dax options it falls back to non-dax mode. And
your argument seems to be that user should stat every file and
query for STATX_ATTR_DAX to determine if dax is enabled on file
or not.

One one hand, I am not too fond of this new semantics of automatic fallback
and dax=inode default, and on the other hand, I want to be as close
as possible to ext4/xfs semantics so that there is less confusion for
users.

Vivek

