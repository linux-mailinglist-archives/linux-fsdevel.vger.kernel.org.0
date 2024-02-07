Return-Path: <linux-fsdevel+bounces-10603-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA34484CAFC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 14:04:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3ED41C24E66
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 13:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B02D27605F;
	Wed,  7 Feb 2024 13:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DA5W1+oB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF1476035
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Feb 2024 13:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707311057; cv=none; b=Zgwc44rD1vLFYuIw/oIG8dQMCtRIhpU94nK3/VwAZHOyGR4zD3b0FkCimPR7si5QDrhnALzUojiA3bgsQZ/hGbFFVYNv5bJgOiJXawwlwB+u7YxT2D9SD/b7W22SuIHcgfXD3Mk7vrE/dDilLRA9DJ8m//AsuUnXw89ErWFg/18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707311057; c=relaxed/simple;
	bh=NX8orA+GVnnPwrF0apwCns+C6OpZLx0AleNzR/n5FUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=edJZvDx7g/dqjfFbZ6NDN7S4FXVBZv1OUEAkfkzlnAX5S39SLt5C5j7JAJM5M2961hdL64pK+jZ26lkHjUVXdLJiY4PFm8g3cELUkIFZRKWl+odq/TmYcxi6SsMSdh+DrsxBx4rdhiP6UcCH6Ryj/x0qFsFIMHpQuJx66Zpl5bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DA5W1+oB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707311054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L12i3OcGmJi2tYPUezs3YjaVa/gCWzHhD1McLmDOUM8=;
	b=DA5W1+oB5Kza7pdjnQG78g9rRnXcSHGTUhWc9f7epM3Wx0aHl/CIb1oXlQXBRtnmZwEdfo
	Gzd8JasH4c4PtZ2toxvpO8B2q8QXkf3JwN4xz6DiWzCtseLZXQwSk7LpmX/MKQzIwNYqIV
	ya5zBnXc7SK8BZKU2bVoNIcnoNFU8N8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-440-OV_Rx9OvMKyeOZ5fiIid2g-1; Wed, 07 Feb 2024 08:04:11 -0500
X-MC-Unique: OV_Rx9OvMKyeOZ5fiIid2g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 450F5862DC8;
	Wed,  7 Feb 2024 13:04:11 +0000 (UTC)
Received: from bfoster (unknown [10.22.32.186])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C87151121312;
	Wed,  7 Feb 2024 13:04:10 +0000 (UTC)
Date: Wed, 7 Feb 2024 08:05:29 -0500
From: Brian Foster <bfoster@redhat.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Dave Chinner <david@fromorbit.com>, brauner@kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jan Kara <jack@suse.cz>, Dave Chinner <dchinner@redhat.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH v2 3/7] fs: FS_IOC_GETUUID
Message-ID: <ZcN+8iOBR97t451x@bfoster>
References: <20240206201858.952303-1-kent.overstreet@linux.dev>
 <20240206201858.952303-4-kent.overstreet@linux.dev>
 <ZcKsIbRRfeXfCObl@dread.disaster.area>
 <cm4wbdmpuq6mlyfqrb3qqwyysa3qao6t5sc2eq3ykmgb4ptpab@qkyberqtvrtt>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cm4wbdmpuq6mlyfqrb3qqwyysa3qao6t5sc2eq3ykmgb4ptpab@qkyberqtvrtt>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

On Tue, Feb 06, 2024 at 05:37:22PM -0500, Kent Overstreet wrote:
> On Wed, Feb 07, 2024 at 09:01:05AM +1100, Dave Chinner wrote:
> > On Tue, Feb 06, 2024 at 03:18:51PM -0500, Kent Overstreet wrote:
> > > +static int ioctl_getfsuuid(struct file *file, void __user *argp)
> > > +{
> > > +	struct super_block *sb = file_inode(file)->i_sb;
> > > +
> > > +	if (!sb->s_uuid_len)
> > > +		return -ENOIOCTLCMD;
> > > +
> > > +	struct fsuuid2 u = { .len = sb->s_uuid_len, };
> > > +	memcpy(&u.uuid[0], &sb->s_uuid, sb->s_uuid_len);
> > > +
> > > +	return copy_to_user(argp, &u, sizeof(u)) ? -EFAULT : 0;
> > > +}
> > 
> > Can we please keep the declarations separate from the code? I always
> > find this sort of implicit scoping of variables both difficult to
> > read (especially in larger functions) and a landmine waiting to be
> > tripped over. This could easily just be:
> > 
> > static int ioctl_getfsuuid(struct file *file, void __user *argp)
> > {
> > 	struct super_block *sb = file_inode(file)->i_sb;
> > 	struct fsuuid2 u = { .len = sb->s_uuid_len, };
> > 
> > 	....
> > 
> > and then it's consistent with all the rest of the code...
> 
> The way I'm doing it here is actually what I'm transitioning my own code
> to - the big reason being that always declaring variables at the tops of
> functions leads to separating declaration and initialization, and worse
> it leads people to declaring a variable once and reusing it for multiple
> things (I've seen that be a source of real bugs too many times).
> 

I still think this is of questionable value. I know I've mentioned
similar concerns to Dave's here on the bcachefs list, but still have not
really seen any discussion other than a bit of back and forth on the
handful of generally accepted (in the kernel) uses of this sort of thing
for limiting scope in loops/branches and such.

I was skimming through some more recent bcachefs patches the other day
(the journal write pipelining stuff) where I came across one or two
medium length functions where this had proliferated, and I found it kind
of annoying TBH. It starts to almost look like there are casts all over
the place and it's a bit more tedious to filter out logic from the
additional/gratuitous syntax, IMO.

That's still just my .02, but there was also previous mention of
starting/having discussion on this sort of style change. Is that still
the plan? If so, before or after proliferating it throughout the
bcachefs code? ;) I am curious if there are other folks in kernel land
who think this makes enough sense that they'd plan to adopt it. Hm?

Brian

> But I won't push that in this patch, we can just keep the style
> consistent for now.
> 
> > > +/* Returns the external filesystem UUID, the same one blkid returns */
> > > +#define FS_IOC_GETFSUUID		_IOR(0x12, 142, struct fsuuid2)
> > > +
> > 
> > Can you add a comment somewhere in the file saying that new VFS
> > ioctls should use the "0x12" namespace in the range 142-255, and
> > mention that BLK ioctls should be kept within the 0x12 {0-141}
> > range?
> 
> Well, if we're going to try to keep the BLK_ and FS_IOC_ ioctls in
> separate ranges, then FS_IOC_ needs to move to something else becasue
> otherwise BLK_ won't have a way to expand.
> 
> So what else -
> 
> ioctl-number.rst has a bunch of other ranges listed for fs.h, but 0x12
> appears to be the only one without conflicts - all the other ranges seem
> to have originated with other filesystems.
> 
> So perhaps I will take Darrick's nak (0x15) suggestion after all.
> 


