Return-Path: <linux-fsdevel+bounces-11117-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C46B98513C0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 13:46:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ABF82832B6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 12:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1331B3A1D4;
	Mon, 12 Feb 2024 12:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IJO4yTxU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2E73A1A2
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Feb 2024 12:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707741948; cv=none; b=iWE2wNIhaajVjE3GN45Fo+qyfKBVdNpRrhJk98a0+WaYddJCInZi0zYxuhk2wcWWyjKYX5q4afiy3jWOGm/ViZTfCzNIXFPzie52rsrc5fB4XhpGY6t3mYTLuuJmn/fZuMW48qDcxdLMO/GO3v6cTUFadKwGDcsUnFXToJJMaY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707741948; c=relaxed/simple;
	bh=47Vc+He3k3RnRH0Ql7hR/kVezI3csD20gT8aPlqqG/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hWilx0OCthbURvobHyNaXqWekAUfCn5f7UMxPSbl9h7VFvDEWnvhHvviMyHvqdpLBkZ0Nr0gM0E/cENbKKq74rV6+FMxucH1g6kI5y1eY8IoQtc5APZObjBa/Iyc7HLmAN3YCyriZW8X1gOleSSjp9ejPsADUDbkfWTZCl0FqJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IJO4yTxU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707741945;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CDSPlvIYjBlKyfzOSysIpxi5bGhwenO4Xb+dpw1JB1E=;
	b=IJO4yTxU9HC6nXUps5gL36XZmVLsSWPrxmz02UIGsV/7CcQuzDpZbSx/C+YyqMmc6f3soX
	8GhG8xi/vO7uxZ3WTwIcJtfXcmxUH7ut4BHk2hMW7oosMaDcF8MUzs5YTNoWWfpepdNqcW
	UVv2ijBgr1fuq1ol68Y5fqVDnTjwnSY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-417-ba70zfwLNsySkNpyQxSsgg-1; Mon,
 12 Feb 2024 07:45:42 -0500
X-MC-Unique: ba70zfwLNsySkNpyQxSsgg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2CEB81C29EA0;
	Mon, 12 Feb 2024 12:45:42 +0000 (UTC)
Received: from bfoster (unknown [10.22.8.118])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 9FCFBC2E1E6;
	Mon, 12 Feb 2024 12:45:41 +0000 (UTC)
Date: Mon, 12 Feb 2024 07:47:00 -0500
From: Brian Foster <bfoster@redhat.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Dave Chinner <david@fromorbit.com>, brauner@kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jan Kara <jack@suse.cz>, Dave Chinner <dchinner@redhat.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH v2 3/7] fs: FS_IOC_GETUUID
Message-ID: <ZcoTROgZiKOfp3iM@bfoster>
References: <20240206201858.952303-1-kent.overstreet@linux.dev>
 <20240206201858.952303-4-kent.overstreet@linux.dev>
 <ZcKsIbRRfeXfCObl@dread.disaster.area>
 <cm4wbdmpuq6mlyfqrb3qqwyysa3qao6t5sc2eq3ykmgb4ptpab@qkyberqtvrtt>
 <ZcN+8iOBR97t451x@bfoster>
 <krc2udjtkvylugzuledk7hre7rizmiajrgkiwvwcmsxtgxobyz@miqndphw7uhi>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <krc2udjtkvylugzuledk7hre7rizmiajrgkiwvwcmsxtgxobyz@miqndphw7uhi>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

On Thu, Feb 08, 2024 at 04:57:02PM -0500, Kent Overstreet wrote:
> On Wed, Feb 07, 2024 at 08:05:29AM -0500, Brian Foster wrote:
> > On Tue, Feb 06, 2024 at 05:37:22PM -0500, Kent Overstreet wrote:
> > > On Wed, Feb 07, 2024 at 09:01:05AM +1100, Dave Chinner wrote:
> > > > On Tue, Feb 06, 2024 at 03:18:51PM -0500, Kent Overstreet wrote:
> > > > > +static int ioctl_getfsuuid(struct file *file, void __user *argp)
> > > > > +{
> > > > > +	struct super_block *sb = file_inode(file)->i_sb;
> > > > > +
> > > > > +	if (!sb->s_uuid_len)
> > > > > +		return -ENOIOCTLCMD;
> > > > > +
> > > > > +	struct fsuuid2 u = { .len = sb->s_uuid_len, };
> > > > > +	memcpy(&u.uuid[0], &sb->s_uuid, sb->s_uuid_len);
> > > > > +
> > > > > +	return copy_to_user(argp, &u, sizeof(u)) ? -EFAULT : 0;
> > > > > +}
> > > > 
> > > > Can we please keep the declarations separate from the code? I always
> > > > find this sort of implicit scoping of variables both difficult to
> > > > read (especially in larger functions) and a landmine waiting to be
> > > > tripped over. This could easily just be:
> > > > 
> > > > static int ioctl_getfsuuid(struct file *file, void __user *argp)
> > > > {
> > > > 	struct super_block *sb = file_inode(file)->i_sb;
> > > > 	struct fsuuid2 u = { .len = sb->s_uuid_len, };
> > > > 
> > > > 	....
> > > > 
> > > > and then it's consistent with all the rest of the code...
> > > 
> > > The way I'm doing it here is actually what I'm transitioning my own code
> > > to - the big reason being that always declaring variables at the tops of
> > > functions leads to separating declaration and initialization, and worse
> > > it leads people to declaring a variable once and reusing it for multiple
> > > things (I've seen that be a source of real bugs too many times).
> > > 
> > 
> > I still think this is of questionable value. I know I've mentioned
> > similar concerns to Dave's here on the bcachefs list, but still have not
> > really seen any discussion other than a bit of back and forth on the
> > handful of generally accepted (in the kernel) uses of this sort of thing
> > for limiting scope in loops/branches and such.
> > 
> > I was skimming through some more recent bcachefs patches the other day
> > (the journal write pipelining stuff) where I came across one or two
> > medium length functions where this had proliferated, and I found it kind
> > of annoying TBH. It starts to almost look like there are casts all over
> > the place and it's a bit more tedious to filter out logic from the
> > additional/gratuitous syntax, IMO.
> > 
> > That's still just my .02, but there was also previous mention of
> > starting/having discussion on this sort of style change. Is that still
> > the plan? If so, before or after proliferating it throughout the
> > bcachefs code? ;) I am curious if there are other folks in kernel land
> > who think this makes enough sense that they'd plan to adopt it. Hm?
> 
> That was the discussion :)
> 
> bcachefs is my codebase, so yes, I intend to do it there. I really think
> this is an instance where you and Dave are used to the way C has
> historically forced us to do things; our brains get wired to read code a
> certain way and changes are jarring.
> 

Heh, fair enough. That's certainly your prerogative. I'm certainly not
trying to tell you what to do or not with bcachefs. That's at least
direct enough that it's clear it's not worth debating too much. ;)

> But take a step back; if we were used to writing code the way I'm doing
> it, and you were arguing for putting declarations at the tops of
> functions, what would the arguments be?
> 

I think my thought process would be similar. I.e., is the proposed
benefit of such a change worth the tradeoffs?

> I would say you're just breaking up the flow of ideas for no reason; a
> chain of related statements now includes a declaration that isn't with
> the actual logic.
> 
> And bugs due to variable reuse, missed initialization - there's real
> reasons not to do it that way.
> 

And were I in that position, I don't think I would reduce a decision
that affects readability/reviewability of my subsystem to a nontrivial
degree (for other people, at least) to that single aspect. This would be
the answer to the question: "is this worth considering?"

Brian


