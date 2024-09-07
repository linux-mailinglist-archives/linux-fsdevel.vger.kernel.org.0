Return-Path: <linux-fsdevel+bounces-28895-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A5C9701AB
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Sep 2024 12:21:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9E45B223AA
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Sep 2024 10:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B49DC158536;
	Sat,  7 Sep 2024 10:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Taog2JMe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127301B85DC;
	Sat,  7 Sep 2024 10:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725704505; cv=none; b=hnyb8WW8EEpEaUw0YsMgUClQ0RER4EF6IvAqNaQp+IM/oN7U3G6F3UJIWc5Xr5dOZV+gawVXNVtB+Amy7+WZ9+Cn0QcylA0SYlvNijowxaW5MK9AuE+U8O4FJEUwFmsHrftgxMfgl/x+GNYzeLJngQIkBA75LQGpFQ8SrP6xCOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725704505; c=relaxed/simple;
	bh=brdoB5/Ell2kBeABWW/H/H2kjDMNetcfjnz38IsGo8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IUQz69xv84UCR/963kCNBLiJboWlgrOUhqxHEQ7GsQ2+dHyMLT23pJQu0x4eRlJHSZCIx97ZArtCc5hUN1e4tWuDV+WjXyeAJjse2ufRKD/dcXSNyp8L6bWsp9v2byA5EEIqN3Nia9qwbiy2Cs2RjukKnLKwmjvTVk4gdOX5uMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Taog2JMe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D57CC4CEC2;
	Sat,  7 Sep 2024 10:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725704504;
	bh=brdoB5/Ell2kBeABWW/H/H2kjDMNetcfjnz38IsGo8w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Taog2JMe0QhBEXggSYvWMQwy7Jl6ieNPX/S05l7EaoXe4jzTtTHEG0oV3Q8v9hxtH
	 ISOKHhQIkkURgs5/s4zaik3Mmm6O4f4XFbZovHBb3tmsQxHwRymE5/CAzBMhT/Thal
	 Dibkj1MxKs+Xbt4CrbCWK5SCvYadxfO57FjeX1Ti+in/WaYGRie0dR9fsb4LVltCDB
	 7pedZzocs1IHOlYGjm6uJywwPWYbB+XCUE9aiAfVoJzBSL/afAsYCZZIOuJaBjxl4v
	 An/gON9bK0qgM4JasW3jnLuknPnoDinUR9nFE4SlaZJZK3mVfLHNP/m+sXKWB0GpUY
	 WnxudBcTzl0Iw==
Date: Sat, 7 Sep 2024 12:21:38 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Tom Haynes <loghyr@gmail.com>, 
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 09/11] fs: handle delegated timestamps in
 setattr_copy_mgtime
Message-ID: <20240907-rekonstruieren-gejagt-06d24089f842@brauner>
References: <20240905-delstid-v4-0-d3e5fd34d107@kernel.org>
 <20240905-delstid-v4-9-d3e5fd34d107@kernel.org>
 <ZtnR7x6pYz1x7LvK@tissot.1015granger.net>
 <c955b19c00026a2237c9224c8224f1ac6f249d4c.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c955b19c00026a2237c9224c8224f1ac6f249d4c.camel@kernel.org>

On Thu, Sep 05, 2024 at 01:46:14PM GMT, Jeff Layton wrote:
> On Thu, 2024-09-05 at 11:44 -0400, Chuck Lever wrote:
> > On Thu, Sep 05, 2024 at 08:41:53AM -0400, Jeff Layton wrote:
> > > When updating the ctime on an inode for a SETATTR with a multigrain
> > > filesystem, we usually want to take the latest time we can get for the
> > > ctime. The exception to this rule is when there is a nfsd write
> > > delegation and the server is proxying timestamps from the client.
> > > 
> > > When nfsd gets a CB_GETATTR response, we want to update the timestamp
> > > value in the inode to the values that the client is tracking. The client
> > > doesn't send a ctime value (since that's always determined by the
> > > exported filesystem), but it can send a mtime value. In the case where
> > > it does, then we may need to update the ctime to a value commensurate
> > > with that instead of the current time.
> > > 
> > > If ATTR_DELEG is set, then use ia_ctime value instead of setting the
> > > timestamp to the current time.
> > > 
> > > With the addition of delegated timestamps we can also receive a request
> > > to update only the atime, but we may not need to set the ctime. Trust
> > > the ATTR_CTIME flag in the update and only update the ctime when it's
> > > set.
> > > 
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > ---
> > >  fs/attr.c          | 28 +++++++++++++--------
> > >  fs/inode.c         | 74 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
> > >  include/linux/fs.h |  2 ++
> > >  3 files changed, 94 insertions(+), 10 deletions(-)
> > > 
> > > diff --git a/fs/attr.c b/fs/attr.c
> > > index 3bcbc45708a3..392eb62aa609 100644
> > > --- a/fs/attr.c
> > > +++ b/fs/attr.c
> > > @@ -286,16 +286,20 @@ static void setattr_copy_mgtime(struct inode *inode, const struct iattr *attr)
> > >  	unsigned int ia_valid = attr->ia_valid;
> > >  	struct timespec64 now;
> > >  
> > > -	/*
> > > -	 * If the ctime isn't being updated then nothing else should be
> > > -	 * either.
> > > -	 */
> > > -	if (!(ia_valid & ATTR_CTIME)) {
> > > -		WARN_ON_ONCE(ia_valid & (ATTR_ATIME|ATTR_MTIME));
> > > -		return;
> > > +	if (ia_valid & ATTR_CTIME) {
> > > +		/*
> > > +		 * In the case of an update for a write delegation, we must respect
> > > +		 * the value in ia_ctime and not use the current time.
> > > +		 */
> > > +		if (ia_valid & ATTR_DELEG)
> > > +			now = inode_set_ctime_deleg(inode, attr->ia_ctime);
> > > +		else
> > > +			now = inode_set_ctime_current(inode);
> > > +	} else {
> > > +		/* If ATTR_CTIME isn't set, then ATTR_MTIME shouldn't be either. */
> > > +		WARN_ON_ONCE(ia_valid & ATTR_MTIME);
> > >  	}
> > >  
> > > -	now = inode_set_ctime_current(inode);
> > >  	if (ia_valid & ATTR_ATIME_SET)
> > >  		inode_set_atime_to_ts(inode, attr->ia_atime);
> > >  	else if (ia_valid & ATTR_ATIME)
> > > @@ -354,8 +358,12 @@ void setattr_copy(struct mnt_idmap *idmap, struct inode *inode,
> > >  		inode_set_atime_to_ts(inode, attr->ia_atime);
> > >  	if (ia_valid & ATTR_MTIME)
> > >  		inode_set_mtime_to_ts(inode, attr->ia_mtime);
> > > -	if (ia_valid & ATTR_CTIME)
> > > -		inode_set_ctime_to_ts(inode, attr->ia_ctime);
> > > +	if (ia_valid & ATTR_CTIME) {
> > > +		if (ia_valid & ATTR_DELEG)
> > > +			inode_set_ctime_deleg(inode, attr->ia_ctime);
> > > +		else
> > > +			inode_set_ctime_to_ts(inode, attr->ia_ctime);
> > > +	}
> > >  }
> > >  EXPORT_SYMBOL(setattr_copy);
> > >  
> > 
> > This patch fails to apply cleanly to my copy of nfsd-next:
> > 
> >   error: `git apply --index`: error: patch failed: fs/attr.c:286
> >   error: fs/attr.c: patch does not apply
> > 
> > Before I try jiggling this to get it to apply, is there anything
> > I should know? I worry about a potential merge conflict here,
> > hopefully it will be no more complicated than that.
> > 
> > 
> 
> This is based on a combo of your nfsd-next branch and Christian's
> vfs.mgtime branch. This patch in particular depends on the multigrain
> patches in his tree.
> 
> I think we can just drop this patch from the series in your tree, and
> I'll get Christian to pick it up in his tree. The ctime setting will be
> a bit racy without it but everything should still work.
> 
> Sound ok? Christian, are you OK with picking this up in vfs.mgtime?

Yep, of course. Already picked it up.

