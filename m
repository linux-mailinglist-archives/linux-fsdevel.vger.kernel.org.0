Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A31FC4197FB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Sep 2021 17:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235239AbhI0Pdq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Sep 2021 11:33:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21972 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235149AbhI0Pdq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Sep 2021 11:33:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632756727;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=D9vyE2w7x1f9V/jxsslLnzIMn1DhmA/pE0Z9+LjhaOo=;
        b=cPYVYKve5MjOJmUGA6/ay++0WsLNkv+M15GqxEnGD3eSgo73iyAiNkqtIcJoE3kcDG2WwL
        SgKjI6G4ppIr0xbgXUN6jZA9Xk358gXsu0xAJBB9rFZQp0E/+CPUxe99PPsHvPvtxgMZii
        So7xJjR4V9FDuGf6zk7o4X9uXIQlDRg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-506-ZOS6EqxBO9qgaxYramUQHw-1; Mon, 27 Sep 2021 11:32:04 -0400
X-MC-Unique: ZOS6EqxBO9qgaxYramUQHw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B757E50751;
        Mon, 27 Sep 2021 15:32:02 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.16.225])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6C7B4100164A;
        Mon, 27 Sep 2021 15:32:02 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 04D4B222E4F; Mon, 27 Sep 2021 11:32:02 -0400 (EDT)
Date:   Mon, 27 Sep 2021 11:32:01 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Jeffle Xu <jefflexu@linux.alibaba.com>, stefanha@redhat.com,
        miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
        virtio-fs@redhat.com, bo.liu@linux.alibaba.com,
        joseph.qi@linux.alibaba.com
Subject: Re: [PATCH v5 2/5] fuse: make DAX mount option a tri-state
Message-ID: <YVHj8Z+XbN9QMJT8@redhat.com>
References: <20210923092526.72341-1-jefflexu@linux.alibaba.com>
 <20210923092526.72341-3-jefflexu@linux.alibaba.com>
 <YUzPUYU8R5LL4mzU@redhat.com>
 <20210923222618.GB2361455@dread.disaster.area>
 <YU0jovIYv+xeinQd@redhat.com>
 <20210927002148.GH2361455@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210927002148.GH2361455@dread.disaster.area>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 27, 2021 at 10:21:48AM +1000, Dave Chinner wrote:
> On Thu, Sep 23, 2021 at 09:02:26PM -0400, Vivek Goyal wrote:
> > On Fri, Sep 24, 2021 at 08:26:18AM +1000, Dave Chinner wrote:
> > > On Thu, Sep 23, 2021 at 03:02:41PM -0400, Vivek Goyal wrote:
> > > > On Thu, Sep 23, 2021 at 05:25:23PM +0800, Jeffle Xu wrote:
> > > > > We add 'always', 'never', and 'inode' (default). '-o dax' continues to
> > > > > operate the same which is equivalent to 'always'. To be consistemt with
> > > > > ext4/xfs's tri-state mount option, when neither '-o dax' nor '-o dax='
> > > > > option is specified, the default behaviour is equal to 'inode'.
> > > > 
> > > > So will "-o dax=inode" be used for per file DAX where dax mode comes
> > > > from server?
> > > > 
> > > > I think we discussed this. It will be better to leave "-o dax=inode"
> > > > alone. It should be used when we are reading dax status from file
> > > > attr (like ext4 and xfs). 
> > > > 
> > > > And probably create separate option say "-o dax=server" where server
> > > > specifies which inode should use dax.
> > > 
> > > That seems like a poor idea to me.
> > > 
> > > The server side already controls what the client side does by
> > > controlling the inode attributes that the client side sees.  That
> > > is, if the server is going to specify whether the client side data
> > > access is going to use dax, then the server presents the client with
> > > an inode that has the DAX attribute flag set on it.
> > 
> > Hi Dave,
> > 
> > Currently in fuse/virtiofs, DAX is compltely controlled by client. Server
> > has no say in it. If client is mounted with "-o dax", dax is enabled on
> > all files otherwise dax is disabled on all files. One could think of
> > implementing an option on server so that server could deny mmap()
> > requests that come from client, but so far nobody asked for such
> > an option on server side.
> 
> Can you please refer to the new options "always|never|inode" in
> disucssions, because the "-o dax" option is deprecated and we really
> need to center discussions around the new options, not the
> deprecated one.
> 
> > When you say "inode that has DAX attribute flag set on it", are you
> > referring to "S_DAX (in inode->i_flags)" or persistent attr
> > "FS_XFLAG_DAX"?
> 
> Neither. The S_DAX flags is the VFS struct inode state that tells
> the kernel what to do with that inode. The FS_XFLAG_DAX is the
> userspace API status/control flag that represents the current state
> of the persistent per-inode DAX control attribute.
> 
> What I'm talking about the persistent attribute that is present
> on stable storage. e.g. in the XFS on-disk inode the flag is
> XFS_DIFLAG2_DAX which is never seen outside low level XFS code. In
> the case of FUSE, this is the persistent server-side DAX attribute
> state. The client gets this information from the server via an
> inode attribute defined in the FUSE protocol. The client translates
> that network protocol attribute to S_DAX status on FS inode
> instantiation, and to/from FS_XFLAG_DAX for user control under
> dax=inode.
> 
> In the case that the user changes FS_XFLAG_DAX, the FUSE client
> needs to communicate that attribute change to the server, where the
> server then changes the persistent state of the on-disk inode so
> that the next time the client requests that inode, it gets the state
> it previously set. Unless, of course, there are server side policy
> overrides (never/always).
> 
> IOWs, dax=inode on the client side is essentially "follow server
> side policy" because the server maintains the persistent DAX flag
> state in the server side inode...
> 
> > As of now S_DAX on client side inode is set by fuse client whenever
> > client mounted filesystem with "-o dax". And I think you are assuming
> 
> Of course. Similarly, if the client uses dax=never, the S_DAX is
> never set on the VFS inode. But if dax=inode is set, where does the
> DAX attribute state that determines S_DAX comes from .....?
> 
> > that DAX attribute of inode is already coming from server. That's not
> > the case. In fact that seems to be the proposal. Provide capability
> > so that server can specify which inode should be using DAX and which
> > inode should not be.
> 
> Yup, that's exactly what I'm talking about - this is "dax=inode"
> behaviour, because the client follows what the server tells it
> in the inode attributes that arrive over the wire.
> 
> > > In that case, turning off dax on the guest side should be
> > > communicated to the fuse server so the server turns off the DAX flag
> > > on the server side iff server side policy allows it.
> > 
> > Not sure what do you mean by server turns of DAX flag based on client
> > turning off DAX. Server does not have to do anything. If client decides
> > to not use DAX (in guest), it will not send FUSE_SETUPMAPPING requests
> > to server and that's it.
> 
> Where does the client get it's per-inode DAX policy from if
> dax=inode is, like other DAX filesystems, the default behaviour?
> 
> Where is the persistent storage of that per-inode attribute kept?
> 
> > > When the guest
> > > then purges it's local inode and reloads it from the server then it
> > > will get an inode with the DAX flag set according to server side
> > > policy.
> > 
> > So right now we don't have a mechanism for server to specify DAX flag.
> > And that's what this patch series is trying to do.
> > 
> > > 
> > > Hence if the server side is configured with "dax=always" or
> > > dax="never" semantics it means the client side inode flag state
> > > cannot control DAX mode. That means, regardless of the client side
> > > mount options, DAX is operating under always or never policy,
> > 
> > Hmm..., When you say "server side is configured with "dax=always", 
> > do you mean shared directory on host is mounted with "-o dax=always",
> > or you mean some virtiofs server specific option which enables
> > dax on all inodes from server side.
> 
> I don't care. That's a server side implementation detail. You can
> keep it in a private xattr for all I care.
> 
> > In general, DAX on host and DAX inside guest are completely independent.
> > Host filesystem could very well be mounted with dax or without dax and
> > that has no affect on guests's capability to be able to enable DAX or
> > not. 
> 
> If you have both the host and guest accessing the same files with
> different modes, then you have a data coherency problem that is
> guaranteed to corrupt data.
> 
> > > seems to be exactly what 'dax=inode' behaviour means on the client
> > > side - it behaves according to how the server side propagates the
> > > DAX attribute to the client for each inode.
> > 
> > Ok. So "-o dax=inode" in fuse will have a different meaning as opposed
> > to ext4/xfs. This will mean that server will pass DAX state of inode
> > when inode is instantiated and client should honor that. 
> 
> No, that's exactly what dax=inode means: DAX behaviour is
> per-inode state that users must probe via statx() to determine if
> dax is active or not.
> 
> > But what about FS_XFLAG_DAX flag then. Say host file system
> > does support this att and fuse/virtiofs allows querying and
> > setting this attribute (I don't think it is allowed now).
> 
> FS_XFLAG_DAX is the ioctl-based control API for the client side.
> It's not a persistent flag.
> 
> > So will we not create a future conflict where in case of
> > fuse/virtiofs "-o dax=inode" means something different and it does
> > look at FS_XFLAG_DAX file attr.
> 
> Like many, I suspect you might be mis-understanding the DAX API.
> 
> There are 4 parts to it:
> 
> - persistent filesystem inode state flag
> - ioctls to manipulate persistent inode state flag (FS_XFLAG_DAX)
> - mount options to override persistent inode state flag
> - VFS inode state indicating DAX is active (S_DAX, STATX_ATTR_DAX)
> 
> You seem to be conflating the user API FS_XFLAG_DAX flag with
> whatever the filesystem uses to physically storage that state. They
> are not the same thing. FS_XFLAG_DAX also has no correlation with
> the mount options - we can change the on-disk flag state regardless
> of the mount option in use. We can even change the on-disk state
> flag on *kernels that don't support DAX*.  Changing the on-disk
> attribute *does not change S_DAX*.
> 
> That's because the on-disk persistent state is a property of the
> filesystem's on-disk format, not a property of the kernel that is
> running on that machine. The persistent state flag is managed as a
> completely independent filesystem inode attribute, but it only
> affects behaviour when the dax=inode mode has been selected.
> 
> Control of the behaviour by this persistent inode flag is what
> dax=inode means. It does not define how that attribute flag is
> managed, it just defines the policy that an the inode's behaviour
> will be determined by it's dax attribute state.

So here is my confusion. Say client mounts filesystem with "dax=inode"
and file "foo.txt" has FS_XFLAG_DAX set, do I have 

> 
> OTOH, S_DAX is used by the kernel to enable DAX access. It is the
> _mechanism_, not the policy. We control S_DAX by mount option and/or
> the filesystems persistent inode state flag, and behaviour is
> determined by these policies at VFS inode instantiation time. Change
> the policy, turf the inode out of cache and re-instantiate it, and
> S_DAX for that inode is recalculated from the new policy.
> 
> For FUSE, the server provides the persistent storage and nothing
> else. The ioctls to manipulate dax state are client side ioctls, as
> are the mount options and the S_DAX vfs inode state. Hence for
> server side management of the per-inode S_DAX state, the FUSE
> protocol needs to be able to pass the per-inode persistent DAX
> attribute state to the client and the client needs to honor
> that attribute from the server.
> 
> How the FUSE server stores this persistent attribute is up to the
> server implementation. If the server wants FUSE access to be
> independent of host access, it can't use the persistent inode flags
> in the host filesystem - it will need to use it's own xattrs. If the
> server wants host access to be coherent with the guest, then it will
> need to implement that in a different way.
> 
> But the FUSE client doesn't care about any of this server side
> policy mumbo-jumbo - it just needs to do what the server sends
> to it in the DAX inode attribute. And that's exactly what dax=inode
> means...
> 
> > In summary, there seem to be two use cases.
> > 
> > A. virtiofsd/fuse-server wants do be able to come up with its own
> > policy to decide which inodes should use guest.
> > 
> > B. guest client decides which inode use DAX based on FS_XFLAG_DAX
> > attr on inode (and server does not play a role).
> > 
> > To be able to different between these two cases, I was suggesting
> > using "-o dax=inode" for B and "-o dax=server" for A.
> 
> dax=inode covrees both these cases.  All the server side needs to do
> is set the inode attribute according to policy, and all the client
> needs to do is obey the server side per-inode attribute. IOWs,
> client side using "dax=inode" means the server side controls the DAX
> behaviour via the FUSE DAX attribute. 

Hi Dave,

Can a filesystem mounted with "-o dax=inode" enable DAX on a file even
if FS_XFLAG_DAX attr is not set on the file. I think that's something new
which will happen in case of fuse  and currently does not happen with
ext4/xfs.

That's the use case A which wants to enable DAX attribute of a file
based on its own policy (irrespective of state of FS_XFLAG_DAX on
file).

IIUC, you are ok with this. Just want to be sure because this
is a subtle change from ext4/xfs behavior which will only enable
DAX on a file if FS_XFLAG_DAX is set (with dax=inode). IOW, on
ext4/xfs if FS_XFLAG_DAX is not set on file then DAX will not be
enabled (dax=inode).

I don't want applications to be making assumption that if FS_XFFLAG_DAX
is not set on a file, then DAX will not be enabled on that file because
that's what exactly fuse/virtiofs can do.

> 
> If the server wants the client to always use DAX, then it always
> sets the FUSE inode attribute. If the server says "never use DAX",
> then it never sets the FUSE inode attribute.  If the server doesn't
> want the client to control policy, then it just rejects attempts to
> change the per-inode persistent DAX flag via client side
> ioctl(FS_XFLAG_DAX) calls. Hence we have use case A completely
> covered.

Ok, I think the behavior of ioctl(FS_XFLAG_DAX) calls is confusing
me most in this context. IIUC, you are suggesting that server will
define the policy whether it is supporting ioctl(FS_XFLAG_DAX)
or not. This is will part of feature negotiation of fuse protocol.

If server decides to support ioctl(FS_XFLAG_DAX), then it should
work similar to ext4/xfs and also follow inheritance rules.

If server decides to not support (or not enable) ioctl(FS_XFLAG_DAX),
then server need to reject any attempt from client to set
FS_XFLAG_DAX. And if client queries the current state of 
FS_XFLAG_DAX, then we need to return it is not set (even if it
set on underlying filesystem). That way client will think FS_XFLAG_DAX
is not set and will not expect DAX to be necessarily enabled.

> 
> For case B, which is true dax=inode behaviour at the client, then
> the server side honours the client side requests to change the
> persistent FUSE DAX inode attribute via client side FS_XFLAG_DAX
> ioctls.
> 
> See? At the client side, there is absolutely no difference between
> server side policy control and true dax=inode support. The client is
> completely unaware of server side policies and that's how the client
> side should be implemented. The applications have to be prepared for
> policy to change dynamically with either dax=server or dax=inode, so
> there's no difference to applications running in the guest either.
> 
> Hence I just don't see the justification for a special DAX mode from
> an architectural POV. It's no more work to implement per-inode DAX
> properly form the start and we don't end up with a special, subtly
> different mode.

Ok, So I guess initially we could just implement "-o dax=inode" and
*not support FS_XFLAG_DAX" API at all. Fuse server will decide which
inodes should enable DAX and communicate that to client in a message
response as part of protocol. Any attempt by client to set attr
FS_XFLAG_DAX should fail (Say -ENOTSUP). And any query of FS_XFLAG_DAX
attr should return attr is not set.

One could support "FS_XFLAG_DAX" API down the line. And in that case
fuser server should allow setting and querying FS_XFLAG_DAX and follow
inheritance rules. Also dax flag of inode should be set according to
state of FS_XFLAG_DAX attr (and not some internal decision of server).
IOW, server will have to follow state of FS_XFLAG_DAX attr in deciding
DAX state of inode if it decided to support FS_XFLAG_DAX attr API.

Thanks
Vivek

