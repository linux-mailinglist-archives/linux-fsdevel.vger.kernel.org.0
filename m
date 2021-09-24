Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62AC1417216
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Sep 2021 14:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343615AbhIXMpo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Sep 2021 08:45:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58168 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343555AbhIXMpm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Sep 2021 08:45:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632487449;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oGp5/6NC+0qZZRFSqVkNXwHfJ+hAtdowkfrgS7jWCqg=;
        b=VwHITAGL2npZxnOUqiE53uyyBM/w3dos03RCr5+fzOP2Ya0HUnEH6gULpkiUCCV5ZpkbI6
        D7WBRwldLsR5jshjG4LJkRYLN7ELE+DcmW/LEUXu5jhWBcRIdBRvApA0QCFy1rHRj+basD
        aSPq0YihcwC8fwiClEurafSbZGr1Dsk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-34-6UPeP6r-N02fmlUEmz86Dw-1; Fri, 24 Sep 2021 08:44:08 -0400
X-MC-Unique: 6UPeP6r-N02fmlUEmz86Dw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 09E0510067A3;
        Fri, 24 Sep 2021 12:43:53 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.32.185])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 407DA61158;
        Fri, 24 Sep 2021 12:43:03 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id C420D222E4F; Fri, 24 Sep 2021 08:43:02 -0400 (EDT)
Date:   Fri, 24 Sep 2021 08:43:02 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     JeffleXu <jefflexu@linux.alibaba.com>
Cc:     Dave Chinner <david@fromorbit.com>, stefanha@redhat.com,
        miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
        virtio-fs@redhat.com, bo.liu@linux.alibaba.com,
        joseph.qi@linux.alibaba.com
Subject: Re: [PATCH v5 2/5] fuse: make DAX mount option a tri-state
Message-ID: <YU3H1pEesZASqXha@redhat.com>
References: <20210923092526.72341-1-jefflexu@linux.alibaba.com>
 <20210923092526.72341-3-jefflexu@linux.alibaba.com>
 <YUzPUYU8R5LL4mzU@redhat.com>
 <20210923222618.GB2361455@dread.disaster.area>
 <YU0jovIYv+xeinQd@redhat.com>
 <0cc7241e-3fc1-00b9-22c6-4d7ef4776579@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0cc7241e-3fc1-00b9-22c6-4d7ef4776579@linux.alibaba.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 24, 2021 at 11:06:07AM +0800, JeffleXu wrote:
> 
> 
> On 9/24/21 9:02 AM, Vivek Goyal wrote:
> > On Fri, Sep 24, 2021 at 08:26:18AM +1000, Dave Chinner wrote:
> >> On Thu, Sep 23, 2021 at 03:02:41PM -0400, Vivek Goyal wrote:
> >>> On Thu, Sep 23, 2021 at 05:25:23PM +0800, Jeffle Xu wrote:
> >>>> We add 'always', 'never', and 'inode' (default). '-o dax' continues to
> >>>> operate the same which is equivalent to 'always'. To be consistemt with
> >>>> ext4/xfs's tri-state mount option, when neither '-o dax' nor '-o dax='
> >>>> option is specified, the default behaviour is equal to 'inode'.
> >>>
> >>> So will "-o dax=inode" be used for per file DAX where dax mode comes
> >>> from server?
> >>>
> >>> I think we discussed this. It will be better to leave "-o dax=inode"
> >>> alone. It should be used when we are reading dax status from file
> >>> attr (like ext4 and xfs). 
> >>>
> >>> And probably create separate option say "-o dax=server" where server
> >>> specifies which inode should use dax.
> >>
> >> That seems like a poor idea to me.
> >>
> >> The server side already controls what the client side does by
> >> controlling the inode attributes that the client side sees.  That
> >> is, if the server is going to specify whether the client side data
> >> access is going to use dax, then the server presents the client with
> >> an inode that has the DAX attribute flag set on it.
> > 
> > Hi Dave,
> > 
> > Currently in fuse/virtiofs, DAX is compltely controlled by client. Server
> > has no say in it. If client is mounted with "-o dax", dax is enabled on
> > all files otherwise dax is disabled on all files. One could think of
> > implementing an option on server so that server could deny mmap()
> > requests that come from client, but so far nobody asked for such
> > an option on server side.
> > 
> > When you say "inode that has DAX attribute flag set on it", are you
> > referring to "S_DAX (in inode->i_flags)" or persistent attr
> > "FS_XFLAG_DAX"?
> > 
> > As of now S_DAX on client side inode is set by fuse client whenever
> > client mounted filesystem with "-o dax". And I think you are assuming
> > that DAX attribute of inode is already coming from server. That's not
> > the case. In fact that seems to be the proposal. Provide capability
> > so that server can specify which inode should be using DAX and which
> > inode should not be.
> > 
> >>
> >> In that case, turning off dax on the guest side should be
> >> communicated to the fuse server so the server turns off the DAX flag
> >> on the server side iff server side policy allows it.
> > 
> > Not sure what do you mean by server turns of DAX flag based on client
> > turning off DAX. Server does not have to do anything. If client decides
> > to not use DAX (in guest), it will not send FUSE_SETUPMAPPING requests
> > to server and that's it.
> > 
> >> When the guest
> >> then purges it's local inode and reloads it from the server then it
> >> will get an inode with the DAX flag set according to server side
> >> policy.
> > 
> > So right now we don't have a mechanism for server to specify DAX flag.
> > And that's what this patch series is trying to do.
> > 
> >>
> >> Hence if the server side is configured with "dax=always" or
> >> dax="never" semantics it means the client side inode flag state
> >> cannot control DAX mode. That means, regardless of the client side
> >> mount options, DAX is operating under always or never policy,
> > 
> > Hmm..., When you say "server side is configured with "dax=always", 
> > do you mean shared directory on host is mounted with "-o dax=always",
> > or you mean some virtiofs server specific option which enables
> > dax on all inodes from server side.
> > 
> > In general, DAX on host and DAX inside guest are completely independent.
> > Host filesystem could very well be mounted with dax or without dax and
> > that has no affect on guests's capability to be able to enable DAX or
> > not. 
> 
> Hi Dave, I think you are referring to "shared directory on host is
> mounted with "-o dax=always"" when you are saying "server side is
> configured with "dax=always". And just as Vivek said, there's no
> necessary relationship between the DAX mode in host and that in guest,
> technically.
> 
> 
> > 
> >> enforced by the server side by direct control of the client inode
> >> DAX attribute flag. If dax=inode is in use on both sides, the the
> >> server honours the requests of the client to set/clear the inode
> >> flags and presents the inode flag according to the state the client
> >> side has requested.
> >>
> >> This policy state probably should be communicated to
> >> the fuse client from the server at mount time so policy conflicts
> >> can be be resolved at mount time (e.g. reject mount if policy
> >> conflict occurs, default to guest overrides server or vice versa,
> >> etc). This then means that that the client side mount policies will
> >> default to server side policy when they set "dax=inode" but also
> >> provide a local override for always or never local behaviour.
> >>
> >> Hence, AFAICT, there is no need for a 'dax=server' option - this
> >> seems to be exactly what 'dax=inode' behaviour means on the client
> >> side - it behaves according to how the server side propagates the
> >> DAX attribute to the client for each inode.
> > 
> > Ok. So "-o dax=inode" in fuse will have a different meaning as opposed
> > to ext4/xfs. This will mean that server will pass DAX state of inode
> > when inode is instantiated and client should honor that. 
> > 
> > But what about FS_XFLAG_DAX flag then. Say host file system
> > does support this att and fuse/virtiofs allows querying and
> > setting this attribute (I don't think it is allowed now). So
> > will we not create a future conflict where in case of fuse/virtiofs
> > "-o dax=inode" means something different and it does look at
> > FS_XFLAG_DAX file attr.
> > 
> >>
> >>> Otherwise it will be very confusing. People familiar with "-o dax=inode"
> >>> on ext4/xfs will expect file attr to work and that's not what we
> >>> are implementing, IIUC.
> >>
> >> The dax mount option behaviour is already confusing enough without
> >> adding yet another weird, poorly documented, easily misunderstood
> >> mode that behaves subtly different to existing modes.
> >>
> >> Please try to make the virtiofs behaviour compatible with existing
> >> modes - it's not that hard to make the client dax=inode behaviour be
> >> controlled by the server side without any special client side mount
> >> modes.
> > 
> > Given I want to keep the option of similar behavior for "dax=inode"
> > across ext4/xfs and virtiofs, I suggested "dax=server". Because I 
> > assumed that "dax=inode" means that dax is per inode property AND
> > this per inode property is specified by persistent file attr 
> > FS_XFLAG_DAX.
> > 
> > But fuse/virtiofs will not be specifying dax property of inode using
> > FS_XFLAG_DAX (atleast as of now). And server will set DAX property
> > using some bit in protocol. 
> > 
> > So these seem little different. If we use "dax=inode" for server
> > specifying DAX property of inode, then in future if client can
> > query/set FS_XFLAG_DAX on inode, it will be a problem. There will
> > be a conflict.
> > 
> > Use case I was imagining was, say on host, user might set FS_XFLAG_DAX
> > attr on relevant files and then mount virtiofs in guest with 
> > "-o dax=inode". ...
> 
> Yes this will be a real using case, where users could specify which
> files should be DAX enabled by setting FS_XFLAG_DAX attr **on host**. In
> this case, the FS_XFLAG_DAX attr could still be conveyed by
> FUSE_ATTR_DAX (introduced in this patch set) in FUSE_LOOKUP reply. Then
> extra option may be added to fuse daemon, e.g., '-o policy=server' for
> getting DAX attr according to fuse daemon's own policy, and '-o
> policy=flag' for querying persistent FS_XFLAG_DAX attr of the host inode.
> 
> And thus 'dax=server' mount option inside guest could be omitted and
> replaced by 'policy=server' option on the fuse daemon side. In this
> case, the fuse kernel module could be as simple as possible, while all
> other strategies could be implemented on the fuse daemon side.
> 
> 
> > ... Guest will query state of FS_XFLAG_DAX on inode
> > and enable DAX accordingly. (And server is not necessarily playing
> > an active role in determining which files should use DAX).
> 
> It will be less efficient for guest to initiate another FUSE_IOCTL
> request to query if FS_XFLAG_DAX attr is on the inode. I think
> FUSE_ATTR_DAX flag in FUSE_LOOKUP reply shall be adequate for conveying
> DAX related attr.

This is a good point. In case of fuse, for querying FS_XFLAG_DAX, there
will be extra round trip for FUSE_IOCTL message. It will be better if
server could have an option which enables checking FS_XFLAG_DAX and
respond with FUSE_ATTR_DAX flag in FUSE_LOOKUP message.

Ok, so for the case of fuse, "-o dax=inode" can just mean that enablement
of DAX is per inode. But which files should use DAX is determined by
server. And client will not have a say in this.

And server could have dax options (as you mentioned) to determine whether
it should query FS_XFLAG_DAX to determine dax status of file or it
could implement its own policy (say size based) to determine which inodes
should use DAX. We probably will have document this little deviation
in behavior in Documentation/filesystem/dax.rst

I guess this sounds reasonable. There is little deviation from ext4/xfs
but they are local filesystems to exact match might not make lot of
sense in fuse context.
> 
> 
> However it is indeed an issue when it comes to the consistency of
> FS_XFLAG_DAX flag with ext4/xfs. There are following two semantics when
> using per-file DAX for ext4/xfs:
> 
> 1. user sets FS_XFLAG_DAX attribute on inode, for which per-file DAX
> shall be enabled, and the attribute will be stored persistently on the
> inode;

So this one we can still support as long as fuse supports ioctl and
query and setting FS_XFLAG_DAX, right?

> 2. user can query the FS_XFLAG_DAX attribute to see if DAX is enabled
> for specific file, when it's in 'dax=inode' mode.

Documentation/filesystems/dax.rst says.

 1. There exists an in-kernel file access mode flag `S_DAX` that corresponds to
    the statx flag `STATX_ATTR_DAX`.  See the manpage for statx(2) for details
    about this access mode.

So my understanding is that if user wants to know if DAX is currently
being used on a file, they should call statx() and check for 
STATX_ATTR_DAX flag instead? And this will be set based on S_DAX status
of inode.

If this is correct, then it is not an issue. We should be able to
return STATX_ATTR_DAX based on S_DAX and user should be able to
figure out which files are using DAX. Just that it will not necessarily
match FS_XFLAG_DAX because server might be configured to use its own
custom policy to determine DAX status of a file/inode.

> 
> 
> For semantic 1), I'm quite doubted if there's necessity and possibility
> of this using case for fuse so far, given admin could already specify
> which files should be DAX enabled on the host side. If this semantic
> indeed shall be implemented later, then I'm afraid 'policy=server'
> option shall always be specified with fuse daemon, that is, fuse daemon
> shall always query the FS_XFLAG_DAX attr of the inode on the host.
> 
> For semantic 2), could we return a fake FS_XFLAG_DAX once the server
> shows that this file should be DAX enabled?

I guess we don't have to return fake FS_XFLAG_DAX at all. If user space
is calling statx(), we should just set STATX_ATTR_DAX if file/inode is
using DAX.

Thanks
Vivek

> 
> > 
> > In summary, there seem to be two use cases.
> > 
> > A. virtiofsd/fuse-server wants do be able to come up with its own policy
> >    to decide which inodes should use guest.
> > 
> > B. guest client decides which inode use DAX based on FS_XFLAG_DAX attr
> >    on inode (and server does not play a role).
> > 
> > To be able to different between these two cases, I was suggesting using
> > "-o dax=inode" for B and "-o dax=server" for A.
> 
> 
> -- 
> Thanks,
> Jeffle
> 

