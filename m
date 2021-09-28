Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 843C341B22C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Sep 2021 16:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241239AbhI1Ogd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Sep 2021 10:36:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49796 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241220AbhI1Ogc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Sep 2021 10:36:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632839693;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VMchkmm3f+fDDi3gbHe2/O//b39BC4huxTWsOVKzbkM=;
        b=L79Hsl/cdJqqY4/GOhj9ZJleTxQgUSabC44njCVoeh3kd4RFUUl4FODPngsZSTliyzINbm
        yI1xgmLBUBZigOAIP0iY9/4r8CRlhdaCAyJCvNrBKukmFILM3HeWDk8lScJEQanMjAbpCV
        PSfnA9EyWj9HfrZKEJ7uURXbkcwprdI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-295-u96VOVF8MP67wJ2TnMZx6A-1; Tue, 28 Sep 2021 10:34:49 -0400
X-MC-Unique: u96VOVF8MP67wJ2TnMZx6A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 87B578E4AA8;
        Tue, 28 Sep 2021 14:34:48 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.17.104])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7CDE360871;
        Tue, 28 Sep 2021 14:34:28 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 14830220B02; Tue, 28 Sep 2021 10:34:28 -0400 (EDT)
Date:   Tue, 28 Sep 2021 10:34:28 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     JeffleXu <jefflexu@linux.alibaba.com>
Cc:     Dave Chinner <david@fromorbit.com>, stefanha@redhat.com,
        miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
        virtio-fs@redhat.com, bo.liu@linux.alibaba.com,
        joseph.qi@linux.alibaba.com
Subject: Re: [PATCH v5 2/5] fuse: make DAX mount option a tri-state
Message-ID: <YVMn9Ki2DjCZy2Vm@redhat.com>
References: <20210923092526.72341-1-jefflexu@linux.alibaba.com>
 <20210923092526.72341-3-jefflexu@linux.alibaba.com>
 <YUzPUYU8R5LL4mzU@redhat.com>
 <20210923222618.GB2361455@dread.disaster.area>
 <YU0jovIYv+xeinQd@redhat.com>
 <20210927002148.GH2361455@dread.disaster.area>
 <a8224842-7e05-c3fd-7413-5f425e099251@linux.alibaba.com>
 <20210928034453.GJ2361455@dread.disaster.area>
 <93d817b2-01a4-6e83-cb0b-ca84f67f3d95@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93d817b2-01a4-6e83-cb0b-ca84f67f3d95@linux.alibaba.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 28, 2021 at 01:17:27PM +0800, JeffleXu wrote:
> 
> 
> On 9/28/21 11:44 AM, Dave Chinner wrote:
> > On Mon, Sep 27, 2021 at 10:28:34AM +0800, JeffleXu wrote:
> >> On 9/27/21 8:21 AM, Dave Chinner wrote:
> >>> On Thu, Sep 23, 2021 at 09:02:26PM -0400, Vivek Goyal wrote:
> >>>> On Fri, Sep 24, 2021 at 08:26:18AM +1000, Dave Chinner wrote:
> >>>>> On Thu, Sep 23, 2021 at 03:02:41PM -0400, Vivek Goyal wrote:
> >>> In the case that the user changes FS_XFLAG_DAX, the FUSE client
> >>> needs to communicate that attribute change to the server, where the
> >>> server then changes the persistent state of the on-disk inode so
> >>> that the next time the client requests that inode, it gets the state
> >>> it previously set. Unless, of course, there are server side policy
> >>> overrides (never/always).
> >>
> >> One thing I'm concerned with is that, is the following behavior
> >> consistent with the semantics of per-file DAX in ext4/xfs?
> >>
> >> Client changes FS_XFLAG_DAX, this change is communicated to server and
> >> then server also returns **success**. Then client finds that this file
> >> is not DAX enabled, since server doesn't honor the previously set state.
> > 
> > FS_XFLAG_DAX is advisory in nature - it does not have to be honored
> > at inode instantiation.
> 
> Fine.
> 
> > 
> >> IOWs, shall server always honor the persistent per-inode attribute of
> >> host file (if the change of FS_XFLAG_DAX inside guest is stored as
> >> persistent per-inode attribute on host file)?
> > 
> > If the user set the flag, then queries it, the server should be
> > returning the state that the user set, regardless of whether it is
> > being honored at inode instantiation time.
> > 
> > Remember, FS_XFLAG_DAX does not imply S_DAX and vice versa
> Got it.
> 
> > 
> >>>> Not sure what do you mean by server turns of DAX flag based on client
> >>>> turning off DAX. Server does not have to do anything. If client decides
> >>>> to not use DAX (in guest), it will not send FUSE_SETUPMAPPING requests
> >>>> to server and that's it.
> >>>
> >>> Where does the client get it's per-inode DAX policy from if
> >>> dax=inode is, like other DAX filesystems, the default behaviour?
> >>>
> >>> Where is the persistent storage of that per-inode attribute kept?
> >>
> >> In the latest patch set, it is not supported yet to change FS_XFLAG_DAX
> >> (and thus setting/clearing persistent per-inode attribute) inside guest,
> >> since this scenario is not urgently needed as the real using case.
> > 
> > AFAICT the FS_IOC_FS{GS}ETXATTR ioctl is already supported by the
> > fuse client and it sends the ioctl to the server. Hence the client
> > should already support persistent FS_XFLAG_DAX manipulations
> > regardless of where/how the attribute is stored by the server. Did
> > you actually add code to the client in this patchset to stop
> > FS_XFLAG_DAX from being propagated to the server?
> 
> Yes fuse client supports FS_IOC_FS{GS}ETXATTR ioctl already, but AFAIK
> "passthrough" type virtiofsd doesn't support FUSE_IOCTL yet. My previous
> patch had ever added support for FUSE_IOCTL to virtiofsd.
> 
> > 
> >> Currently the per-inode dax attribute is completely fed from server
> >> thourgh FUSE protocol, e.g. server could set/clear the per-inode dax
> >> attribute depending on the file size.
> > 
> > Yup, that's a policy dax=inode on the client side would allow.
> > Indeed, this same policy could also be implemented as a client side
> > policy, allowing user control instead of admin control of such
> > conditional DAX behaviour... :)
> > 
> >> The previous path set indeed had ever supported changing FS_XFLAG_DAX
> >> and accordingly setting/clearing persistent per-inode attribute inside
> >> guest. For "passthrough" type virtiofsd, the persistent per-inode
> >> attribute is stored as XFS_DIFLAG2_DAX/EXT4_DAX_FL on host file
> >> directly, since this is what "passthrough" means.
> > 
> > Right, but that's server side storage implementation details, not a
> > protocol or client side detail. What I can't find in the current
> > client is where this per-inode flag is actually used in the FUSE dax
> > inode init path - it just checks whether the connection has DAX
> > state set up. Hence I don't see how FS_XFLAG_DAX control from the
> > client currently has any influence on the client side DAX usage.
> 
> Fuse client fetches the per-inode DAX attribute from
> fuse_entry_out.attr.flags of FUSE_LOOKUP reply. It's implemented in
> patch 4 of this patch set.
> 
> The background info is that, fuse client will send a FUSE_LOOKUP request
> to server during inode instantiation, while FS_XFLAG_DAX flag is not
> included in the FUSE_LOOKUP reply, and thus fuse client need to send
> another FUSE_IOCTL if it wants to query the persistent inode flags. To
> remove this extra fuse request during inode instantiation, this flag is
> merged into FUSE_LOOKUP reply (fuse_entry_out.attr.flags) as
> FUSE_ATTR_DAX. Then if FUSE_ATTR_DAX flag is set in
> fuse_entry_out.attr.flags, then fuse client knows that this file shall
> be DAX enabled.
> 
> IOWs, under this mechanism it relies on fuse server to check persistent
> inode flags on host, and then set FUSE_ATTR_DAX flag accordingly.
> 
> > 
> > Seems somewhat crazy to me explicitly want to remove that client
> > side control of per-inode behaviour whilst adding the missing client
> > side bits that allow for the per-inode policy control from server
> > side.  Can we please just start with the common, compatible
> > dax=inode behaviour on the client side, then layer the server side
> > policy control options over the top of that?
> 
> 
> Hi Vivek,
> 
> It seems that we shall also support setting/clearing FS_XFLAG_DAX inside
> guest? If that's the case, then how to design virtiofsd behavior? I
> mean, is it mandatory or optional for virtiofsd to query FS_XFLAG_DAX of
> host files when guest is mounted with "dax=inode"? If it's optional,
> then the performance may be better since it doesn't need to do one extra
> FS_IOC_FSGETXATTR ioctl when handling FUSE_LOOKUP, but admin needs to
> specify "-o policy=flag" to virtiofsd explicitly if it's really needed.

Hi Jeffle,

How about first doing a patch series to just enable ioctl in virtiofsd.
I know David Gilbert and others had security concenrs w.r.t. These
are coming from untrusted guest and they had concerns that we should
only allow selective operations as needed (opted-in by admin). So may
be a daemon option which specifies which operations to allow.

Once that's done, we probably will have to do a patch series, to
make sure FS_XFLAG_DAX inherit behavior is working properly. Especially
that behavior about inheriting FS_XFLAG_DAX flag when a new file
is created and parent dir has FS_XFLAG_DAX set. May be we can just
rely on host filesystem doing it? Limitation will be that it will
only work if host fs is ext4/xfs.

w.r.t virtiofsd, I think we can provide an option say "-o
dax_policy=<option>", which controls what policy is in effect. So if
a daemon specific policy is in effect, we can skip checking FS_XFLAG_DAX
state. In fact, checking FS_XFLAG_DAX state also should probably be
a policy option and not enabled by default.

Say, "-o dax_policy=FS_XFLAG_DAX" will enable cheking FS_XFLAG_DAX on
inode during FUSE_LOOKUP time. Otherwise daemon can fallback to
its own policy and set DAX flag in lookup reply accordingly.

Vivek

