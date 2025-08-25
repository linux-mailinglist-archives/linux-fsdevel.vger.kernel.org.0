Return-Path: <linux-fsdevel+bounces-59131-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B08F2B34ADC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 21:26:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 741DA166D5A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 19:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1F30283CB8;
	Mon, 25 Aug 2025 19:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="gifK/GuQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1C728137E
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 19:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756149976; cv=none; b=rEFsQs9ykBGEts5NOBfMrN6VRAt6ZMGSiWrShUq6hoI6sw5ohQZrACK8LHF+91oSzo21Vp+39/ZZTf4jQaUZMz49bU2+kuCSMk7ZlAwTGe1VF/P3Xxnes4pqFyPaOYF1Vp2NH6qB5Ec531BcgLz3JDkJiHH24DKL51d7XXv0NEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756149976; c=relaxed/simple;
	bh=OVo/nnDHoAM+dyoQZoqa2tMCaLxG9KPpqdz7u06+QkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mlg2lgUVbH3lG0SrFupYaPzDcABc4rylI8l3/3aLM4XLIGUn8q3yxnv5e4Ct1YVPiCHJOVgpV6Hax86oOTNps5Jxeh8BgdkR3hKjDUJpc9Xm4JAjDpTCcHT56UiGjXtzCrdH5prCovq0BlCX06zR/BRnYMYA9AlbmHIVJHwn4gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=gifK/GuQ; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e96c6201654so1263213276.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 12:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1756149973; x=1756754773; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mp7hrAC+z9ITkZMGbXSePlctrkwigE1uRQddy7FPWjw=;
        b=gifK/GuQq9K4U4Oe8HSxzb1UVEs7xOFF9LajWJLKNk6i8UnYSHAC4oVSHbclZQH2oR
         8Uis8HWxt3BZihbqMX6lvEh3OdyD1AXGVtj9aJ+nY0EuOucJ85zNGOek4Zrev1kf0jSr
         EigyG7m0CKuiaLswo0rW5ybSxIA0HyHdRob6iBdkNHEXVwvJCy6jHSW54MWXu23E/UNF
         mVKpSgnT7IiW2T6ibj/uCtWCCJPi4pNdIt/zLidST0x9cuToz6/JVmZvCp/6ifHUmfiv
         l7QEJm8P4vy8XM1T1D9dcE2KbWYj45SAkVJU1PpWMlQ0sijVxQkJQfCu1aRQQrNievNy
         Pk2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756149973; x=1756754773;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mp7hrAC+z9ITkZMGbXSePlctrkwigE1uRQddy7FPWjw=;
        b=b01jDpDXU9AE66sXZeavYn7RrDnUhyhJ7UwYIooowaAAaNODoyJbDuXX8EHp4O8pV6
         ljLL4lW0exTp05oMHwhzgy/gQtNgeW1/tRh84JavnjP5bIVpht4/pe5PxuPkwK/2QYuW
         EMJxTVr+Ii18JaZLXqOfZ11gDfAhztW5LMaGHpw4JaSPw0ydv3JF+bIO8AzuonCKwZWO
         /RO0xphbNVSGq4gD2urFQUjCKK/d5AjuSZS/ENH73tCXgGYzW2c3l5OZpgN0VK1toT61
         DmKF7DRZVePxxjT67Nz2oim2TGDQvdm82iKT2LoFmlrk5jb8+xqpRzCMowtLkrLIbRUJ
         t4BQ==
X-Gm-Message-State: AOJu0YwNyCeq1bJmDvhMvTy2ddxHv0sKV1M58BFK8KMSwasfvcy5JxyQ
	FWQdkQ89jyxQv1e3k0kizSsMl+rXGkbB6jTcjT2/hSxUy5y52fTRiF0BnvFgaUKP0FE=
X-Gm-Gg: ASbGnctVoP2yuaznO0QUqBbeL8NQxT5iMnmO4MgVMtqzSmM/Yrg7PIUe8eWTeNnNvqE
	AoWur0tUIx90HnYiyJ8hatqFp2G2d4IUzrULd6mVjoFn4YlvRbt6kyzAllOw2pWDp94ALHo2B4e
	zv9fJdmbh3L6MMu2qOTR+3A1jcTaS97L33WxLRPam7IoDsmzFoTGbYnoT5Vcqgxe3tm7XFhuslC
	JU1E9gVvKrd66GyICw7kTKuqSxUHnje4PYRumrV8Od/UXKrivTFp9rggtSCdl2rwAuycylIjlgI
	cENF7zrPJo61v+rD2aluDEvYUN+6v8PTZNdPc5rumOJMLYErV30SNETiU7hrla3zsfwABYy9V8+
	+5Y61TiBFcKTdEmUG492jmm8bsmZE8UAZnnb2qIJbBzjslThQaSLNsH32yPFoS/PlaAXbC73YxG
	F7f9ae
X-Google-Smtp-Source: AGHT+IHEx37a3oXB5tv663eJfw1dYbVgBWHF+M2D92Pt6vUhFsXxqSKLHwZGoJ033niO4gVVY5tSNg==
X-Received: by 2002:a05:690c:6102:b0:71f:f866:bba4 with SMTP id 00721157ae682-71ff866f374mr97051877b3.17.1756149972656;
        Mon, 25 Aug 2025 12:26:12 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71ff18b3794sm19329237b3.63.2025.08.25.12.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 12:26:11 -0700 (PDT)
Date: Mon, 25 Aug 2025 15:26:10 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
	kernel-team@fb.com, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, viro@zeniv.linux.org.uk
Subject: Re: [PATCH 18/50] fs: disallow 0 reference count inodes
Message-ID: <20250825192610.GA1310133@perftesting>
References: <cover.1755806649.git.josef@toxicpanda.com>
 <6f4fb1baddecbdab4231c6094bbb05a98bbb7365.1755806649.git.josef@toxicpanda.com>
 <20250825-person-knapp-e802daccfe5b@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825-person-knapp-e802daccfe5b@brauner>

On Mon, Aug 25, 2025 at 12:54:01PM +0200, Christian Brauner wrote:
> On Thu, Aug 21, 2025 at 04:18:29PM -0400, Josef Bacik wrote:
> > Now that we take a full reference for inodes on the LRU, move the logic
> > to add the inode to the LRU to before we drop our last reference. This
> > allows us to ensure that if the inode has a reference count it can be
> > used, and we no longer hold onto inodes that have a 0 reference count.
> > 
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > ---
> >  fs/inode.c | 53 +++++++++++++++++++++++++++++++++--------------------
> >  1 file changed, 33 insertions(+), 20 deletions(-)
> > 
> > diff --git a/fs/inode.c b/fs/inode.c
> > index de0ec791f9a3..b4145ddbaf8e 100644
> > --- a/fs/inode.c
> > +++ b/fs/inode.c
> > @@ -614,7 +614,7 @@ static void __inode_add_lru(struct inode *inode, bool rotate)
> >  
> >  	if (inode->i_state & (I_FREEING | I_WILL_FREE))
> >  		return;
> > -	if (atomic_read(&inode->i_count))
> > +	if (atomic_read(&inode->i_count) != 1)
> >  		return;
> >  	if (inode->__i_nlink == 0)
> >  		return;
> > @@ -1966,28 +1966,11 @@ EXPORT_SYMBOL(generic_delete_inode);
> >   * in cache if fs is alive, sync and evict if fs is
> >   * shutting down.
> >   */
> > -static void iput_final(struct inode *inode, bool skip_lru)
> > +static void iput_final(struct inode *inode, bool drop)
> >  {
> > -	struct super_block *sb = inode->i_sb;
> > -	const struct super_operations *op = inode->i_sb->s_op;
> >  	unsigned long state;
> > -	int drop;
> >  
> >  	WARN_ON(inode->i_state & I_NEW);
> > -
> > -	if (op->drop_inode)
> > -		drop = op->drop_inode(inode);
> > -	else
> > -		drop = generic_drop_inode(inode);
> > -
> > -	if (!drop && !skip_lru &&
> > -	    !(inode->i_state & I_DONTCACHE) &&
> > -	    (sb->s_flags & SB_ACTIVE)) {
> > -		__inode_add_lru(inode, true);
> > -		spin_unlock(&inode->i_lock);
> > -		return;
> > -	}
> > -
> >  	WARN_ON(!list_empty(&inode->i_lru));
> >  
> >  	state = inode->i_state;
> > @@ -2009,8 +1992,29 @@ static void iput_final(struct inode *inode, bool skip_lru)
> >  	evict(inode);
> >  }
> >  
> > +static bool maybe_add_lru(struct inode *inode, bool skip_lru)
> > +{
> > +	const struct super_operations *op = inode->i_sb->s_op;
> > +	struct super_block *sb = inode->i_sb;
> > +	bool drop = false;
> > +
> > +	if (op->drop_inode)
> > +		drop = op->drop_inode(inode);
> > +	else
> > +		drop = generic_drop_inode(inode);
> > +
> > +	if (!drop && !skip_lru &&
> > +	    !(inode->i_state & I_DONTCACHE) &&
> > +	    (sb->s_flags & SB_ACTIVE))
> > +		__inode_add_lru(inode, true);
> > +
> > +	return drop;
> > +}
> 
> Can we rewrite this as:
> 
> static bool maybe_add_lru(struct inode *inode, bool skip_lru)
> {
> 	const struct super_operations *op = inode->i_sb->s_op;
> 	const struct super_block *sb = inode->i_sb;
> 	bool drop = false;
> 
> 	if (op->drop_inode)
> 		drop = op->drop_inode(inode);
> 	else
> 		drop = generic_drop_inode(inode);
> 
> 	if (drop)
> 		return drop;
> 
> 	if (skip_lru)
> 		return drop;
> 
> 	if (inode->i_state & I_DONTCACHE)
> 		return drop;
> 
> 	if (!(sb->s_flags & SB_ACTIVE))
> 		return drop;
> 
> 	__inode_add_lru(inode, true);
> 	return drop;
> }
> 
> so it's a lot easier to follow. I really dislike munging conditions
> together with a bunch of ands and negations mixed in.
> 
> And btw for both I_DONTCACHE and !SB_ACTIVE it seems that returning
> anything other than false from op->drop_inode() would be a bug probably
> a technicality but I find it pretty odd.

Not necsessarily, maybe we had some delayed iput (*cough* btrfs *cough*) that
didn't run until umount time and now we have true coming from ->drop_inode()
with SB_ACTIVE turned off.  That would be completely valid.  Thanks,

Josef

