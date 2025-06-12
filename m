Return-Path: <linux-fsdevel+bounces-51449-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A520AD7027
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 14:22:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06A68189B033
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 12:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67587221739;
	Thu, 12 Jun 2025 12:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jU8PmONx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39881A8405;
	Thu, 12 Jun 2025 12:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749730860; cv=none; b=kt1K0Wg2a3TCa5A4vsKnORHRNPkdM1bP5LSFEm69iIh/Jy9AGKqMik6P2PXydXvaHGma+TUAEnJ9VcoHKZuuB4x1U9RQgMZZOnh4yvPoqei/pOAtUHF4RfqMrlvK1+pw5cWmgqZJAjIxh7Uw9z/qRYSV4TbdXKf63ZJ7YfXYSrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749730860; c=relaxed/simple;
	bh=p8jgSZktNOJHcfNWGLNQiVNCBp7VCoqC0zrDMLSzatU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EvrEdpU/kDBTcBSzHt6E4DjivCEn/oS7vDDhGigBqFkcwVNUi15Hqj+397UOf0zISzMdiPgvfC7HFsa9lwOSoopgAr2w8hrHBqr7Tp1vOoFkXJ0724Mv0P3vZX68K31yyGLN0wpx4ugR+faAj1q6jvNOwKugRs4Jnj261AqauOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jU8PmONx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 277B2C4CEEA;
	Thu, 12 Jun 2025 12:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749730860;
	bh=p8jgSZktNOJHcfNWGLNQiVNCBp7VCoqC0zrDMLSzatU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jU8PmONxx/yx3wtIGqGZkWR8jV4k7q4jkXYk1KvWU5sZZckAyFVrEmo7TlumRl/P6
	 bPfAeOKTLO2ZwpnTHAICppwHFuDqAtH/et90Ce6OT76WP8lak9TduQmbnBMXacbjFH
	 8jPmH6vC5lF+AmA1dtvecTTncdyvJ5HT6ObOO4AvhgA+e4axlP8zrIf1jNC21woBa3
	 NQIFTjiwFzGdi4m1T/90ZJJlnfW3aewYYiXHHMc2h0Rn27Dui3CrgF5zQjj59u4lF7
	 TXmJWWjtX7z22IqozAt3nQjRsEye/Ui+jnj3bfp4XbDgiP+QvkrChNclwOX48J6/gC
	 v5V62nC8oSjpg==
Date: Thu, 12 Jun 2025 14:20:54 +0200
From: Christian Brauner <brauner@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	linux-kernel@vger.kernel.org, James Bottomley <James.Bottomley@hansenpartnership.com>, 
	mcgrof@kernel.org, hch@infradead.org, david@fromorbit.com, rafael@kernel.org, 
	pavel@kernel.org, peterz@infradead.org, mingo@redhat.com, will@kernel.org, 
	boqun.feng@gmail.com
Subject: Re: [PATCH v2 1/6] super: remove pointless s_root checks
Message-ID: <20250612-unbegreiflich-global-d7633c59da8e@brauner>
References: <20250329-work-freeze-v2-0-a47af37ecc3d@kernel.org>
 <20250329-work-freeze-v2-1-a47af37ecc3d@kernel.org>
 <20250611162629.GE6138@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250611162629.GE6138@frogsfrogsfrogs>

On Wed, Jun 11, 2025 at 09:26:29AM -0700, Darrick J. Wong wrote:
> On Sat, Mar 29, 2025 at 09:42:14AM +0100, Christian Brauner wrote:
> > The locking guarantees that the superblock is alive and sb->s_root is
> > still set. Remove the pointless check.
> > 
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > ---
> >  fs/super.c | 19 ++++++-------------
> >  1 file changed, 6 insertions(+), 13 deletions(-)
> > 
> > diff --git a/fs/super.c b/fs/super.c
> > index 97a17f9d9023..dc14f4bf73a6 100644
> > --- a/fs/super.c
> > +++ b/fs/super.c
> > @@ -930,8 +930,7 @@ void iterate_supers(void (*f)(struct super_block *, void *), void *arg)
> >  
> >  		locked = super_lock_shared(sb);
> >  		if (locked) {
> > -			if (sb->s_root)
> > -				f(sb, arg);
> > +			f(sb, arg);
> >  			super_unlock_shared(sb);
> >  		}
> >  
> > @@ -967,11 +966,8 @@ void iterate_supers_type(struct file_system_type *type,
> >  		spin_unlock(&sb_lock);
> >  
> >  		locked = super_lock_shared(sb);
> > -		if (locked) {
> > -			if (sb->s_root)
> > -				f(sb, arg);
> > -			super_unlock_shared(sb);
> > -		}
> > +		if (locked)
> > +			f(sb, arg);
> 
> Hey Christian,
> 
> I might be trying to be the second(?) user of iterate_supers_type[1]. :)
> 
> This change removes the call to super_unlock_shared, which means that
> iterate_supers_type returns with the super_lock(s) still held.  I'm
> guessing that this is a bug and not an intentional change to require the
> callback to call super_unlock_shared, right?
> 
> --D
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/commit/?h=health-monitoring&id=3ae9b1d43dcdeaa38e93dc400d1871872ba0e27f

Yes, that's a bug. Can you send me a fix, please?

