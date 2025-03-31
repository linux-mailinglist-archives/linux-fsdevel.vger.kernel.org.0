Return-Path: <linux-fsdevel+bounces-45326-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC51A763F1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 12:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BCEC3A9FF8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 10:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0BDD1DF24F;
	Mon, 31 Mar 2025 10:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ex0U3QNM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B4827726;
	Mon, 31 Mar 2025 10:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743416148; cv=none; b=T/HeOLjD9WOakYr3GjVozRSw4vIy2E/qBsSCx9ksZxuzA+86ltEFfHup/vBB7qeLqVRut0/8CpGFFrb2Ri+MsyDvHzt/YJgt9BpU3gIwPDOI5oCHSarC8KrvwHrUwYKQF6/hekJlDbn27mm5pEQGhUVwGMmIpr3YDvnQ5ttafZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743416148; c=relaxed/simple;
	bh=yQy1qXZNHGOwHh5JPSZrArNTezKxmxO7XuZ48+Aewow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ubv0BsNxm6/u8B+h+AtiIv3O05Jipk8nQUwXM7N8RQGlblwXNMw1ykymM4GzrDSGTCQVOh1jDWNjKGpdui922l3XmGHWPk3hY9Z0AHgRSwut5szABL4+oehx3lRj7t7KTtaQ55AF4weWv2JO7r0oDIttSSyTkD1A+LKqQDTcYhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ex0U3QNM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76086C4CEE3;
	Mon, 31 Mar 2025 10:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743416147;
	bh=yQy1qXZNHGOwHh5JPSZrArNTezKxmxO7XuZ48+Aewow=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ex0U3QNM+iO3HbBzwGTQf+hlv6d1gQsqr1F8IXIju39ZlIq0U2ych8CZTxoXrRWbe
	 yqBTnHU2Zzb9gYnXWahVQ7JUWqr+/Ct1hi71tBHGOt5BFLjnZ4ZUqlUMDi+XV6Ouq0
	 DG99hfyoKB/S3vPB0tgS+tLWBg2KQ5gedJlN9RvE72eKVJBV9R3a1xYYGOYuFiajf9
	 MXUGTJPl+Wclg1hbcQI+rC4PWUR7uBu0aVX3Mgb0poXY3cVIQ5qMriYSRh9hEyYhZQ
	 V9p+AsSyJHRSulDpeEYTbf6k/vkOBfwBHnMrVy38vt8B5wCd/B23fWJZJ7lpS9nq87
	 vOJgXTxYKXIGQ==
Date: Mon, 31 Mar 2025 12:15:41 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, mcgrof@kernel.org, hch@infradead.org, david@fromorbit.com, 
	rafael@kernel.org, djwong@kernel.org, pavel@kernel.org, peterz@infradead.org, 
	mingo@redhat.com, will@kernel.org, boqun.feng@gmail.com
Subject: Re: [PATCH v2 5/6] super: use common iterator (Part 2)
Message-ID: <20250331-klartext-lebst-d73d3ba0fca2@brauner>
References: <20250329-work-freeze-v2-0-a47af37ecc3d@kernel.org>
 <20250329-work-freeze-v2-5-a47af37ecc3d@kernel.org>
 <mmzfke3c6ioply3ezhushtoxnca5e3kx3ynteie6sf7cye3bqm@yu7wpqctwbrb>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <mmzfke3c6ioply3ezhushtoxnca5e3kx3ynteie6sf7cye3bqm@yu7wpqctwbrb>

On Mon, Mar 31, 2025 at 12:07:12PM +0200, Jan Kara wrote:
> On Sat 29-03-25 09:42:18, Christian Brauner wrote:
> > Use a common iterator for all callbacks. We could go for something even
> > more elaborate (advance step-by-step similar to iov_iter) but I really
> > don't think this is warranted.
> > 
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> 
> Looks good, one nit below. With that fixed feel free to add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> 
> > +#define invalid_super list_entry_is_head
> 
> Why do you have this invalid_super define? I find it rather confusing in
> the loop below and list_entry_is_head() would be much more
> understandable...

Fair, I just wanted a shorter name but I'll change it to
list_entry_is_head() and push it out.

> 
> 								Honza
> 
> > +
> > +static void __iterate_supers(void (*f)(struct super_block *, void *), void *arg,
> > +			     enum super_iter_flags_t flags)
> >  {
> >  	struct super_block *sb, *p = NULL;
> > +	bool excl = flags & SUPER_ITER_EXCL;
> >  
> > -	spin_lock(&sb_lock);
> > -	list_for_each_entry(sb, &super_blocks, s_list) {
> > -		bool locked;
> > +	guard(spinlock)(&sb_lock);
> >  
> > +	for (sb = first_super(flags); !invalid_super(sb, &super_blocks, s_list);
> > +	     sb = next_super(sb, flags)) {
> >  		if (super_flags(sb, SB_DYING))
> >  			continue;
> >  		sb->s_count++;
> >  		spin_unlock(&sb_lock);
> >  
> > -		locked = super_lock(sb, excl);
> > -		if (locked) {
> > +		if (flags & SUPER_ITER_UNLOCKED) {
> > +			f(sb, arg);
> > +		} else if (super_lock(sb, excl)) {
> >  			f(sb, arg);
> >  			super_unlock(sb, excl);
> >  		}
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

