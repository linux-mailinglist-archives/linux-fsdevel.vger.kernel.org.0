Return-Path: <linux-fsdevel+bounces-23001-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9626F925544
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 10:22:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 815481C2254B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 08:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 201E2136994;
	Wed,  3 Jul 2024 08:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jnjD/CPJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8081A5B1E8
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jul 2024 08:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719994929; cv=none; b=apmWGVROiVOUKzm1YfbwCFZkpoHe+oainr5oTRtTwsatanJXS4H/YkynTXoae2PEMwIaPFnH0CzJoEEQtLvFX7aIiK3vBhc0a0mOVr8+WzRmI+D/RKxMCbDDAuO0drohLxq5Khl9lQiB4N5oLsF3E+euqJpmDhK3UmFrrMuSFts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719994929; c=relaxed/simple;
	bh=xeUz7ry2mp+PELnvscEhoB/AfMqbNYO5vGl/q7vHJrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vDMvcc6cVkKFXzUvj4i/Flby7m1fcSOWatXBVFU2GXasMQXoVK5XrxMFiny4BSrDrkNHMJ5LXba82f0VoeLi1p1gkM42OuJ6Zi2VGyBsQDmg5qYKU9/sE5k7HDPGaMQ6CZX6btHsKEh5uyUPNKPT4gTcRBJTMes9fST5qwcjXco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jnjD/CPJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AC31C2BD10;
	Wed,  3 Jul 2024 08:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719994929;
	bh=xeUz7ry2mp+PELnvscEhoB/AfMqbNYO5vGl/q7vHJrE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jnjD/CPJN3R5Mr2k2sP/mDhYJ7hZ3CB1Zfb2BDhTYh1jkSNl+pdFsSy+nQYUIAcDf
	 1zB37apqSCY9QvsFV+zmWOgehGFX4Vym2i88OBOFmo5NOgU6vO9WUkSVEwAaKOg7jK
	 yx029dIsMgJG1HABSjAIKqQHxsQadpPujhPweyePQulupoe323KPoUwFI2Ug3rRK2I
	 vx89p6wKS1XpXh2zmOdRZnrFrrbTTRCcRaCAoD1/QhI3MeLrcFPk/bMsX+cbN+APJm
	 kolzRbtTORuyA1xX+paeSVjB9iz+G7Yv6NztvS/ioFfwdPktp2O/zn7dWmqzLnogm8
	 HqpoVNmDxaNEw==
Date: Wed, 3 Jul 2024 10:22:05 +0200
From: Christian Brauner <brauner@kernel.org>
To: Ian Kent <ikent@redhat.com>
Cc: Brian Foster <bfoster@redhat.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] vfs: don't mod negative dentry count when on shrinker
 list
Message-ID: <20240703-nachwachsen-funkt-23b2e942dd87@brauner>
References: <20240702170757.232130-1-bfoster@redhat.com>
 <e2a34e4d-b529-4ee6-b921-f54c3935f253@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e2a34e4d-b529-4ee6-b921-f54c3935f253@redhat.com>

On Wed, Jul 03, 2024 at 09:48:52AM GMT, Ian Kent wrote:
> On 3/7/24 01:07, Brian Foster wrote:
> > The nr_dentry_negative counter is intended to only account negative
> > dentries that are present on the superblock LRU. Therefore, the LRU
> > add, remove and isolate helpers modify the counter based on whether
> > the dentry is negative, but the shrinker list related helpers do not
> > modify the counter, and the paths that change a dentry between
> > positive and negative only do so if DCACHE_LRU_LIST is set.
> > 
> > The problem with this is that a dentry on a shrinker list still has
> > DCACHE_LRU_LIST set to indicate ->d_lru is in use. The additional
> > DCACHE_SHRINK_LIST flag denotes whether the dentry is on LRU or a
> > shrink related list. Therefore if a relevant operation (i.e. unlink)
> > occurs while a dentry is present on a shrinker list, and the
> > associated codepath only checks for DCACHE_LRU_LIST, then it is
> > technically possible to modify the negative dentry count for a
> > dentry that is off the LRU. Since the shrinker list related helpers
> > do not modify the negative dentry count (because non-LRU dentries
> > should not be included in the count) when the dentry is ultimately
> > removed from the shrinker list, this can cause the negative dentry
> > count to become permanently inaccurate.
> > 
> > This problem can be reproduced via a heavy file create/unlink vs.
> > drop_caches workload. On an 80xcpu system, I start 80 tasks each
> > running a 1k file create/delete loop, and one task spinning on
> > drop_caches. After 10 minutes or so of runtime, the idle/clean cache
> > negative dentry count increases from somewhere in the range of 5-10
> > entries to several hundred (and increasingly grows beyond
> > nr_dentry_unused).
> > 
> > Tweak the logic in the paths that turn a dentry negative or positive
> > to filter out the case where the dentry is present on a shrink
> > related list. This allows the above workload to maintain an accurate
> > negative dentry count.
> > 
> > Signed-off-by: Brian Foster <bfoster@redhat.com>
> > ---
> >   fs/dcache.c | 5 +++--
> >   1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/fs/dcache.c b/fs/dcache.c
> > index 407095188f83..5305b95b3030 100644
> > --- a/fs/dcache.c
> > +++ b/fs/dcache.c
> > @@ -355,7 +355,7 @@ static inline void __d_clear_type_and_inode(struct dentry *dentry)
> >   	flags &= ~DCACHE_ENTRY_TYPE;
> >   	WRITE_ONCE(dentry->d_flags, flags);
> >   	dentry->d_inode = NULL;
> > -	if (flags & DCACHE_LRU_LIST)
> > +	if ((flags & (DCACHE_LRU_LIST|DCACHE_SHRINK_LIST)) == DCACHE_LRU_LIST)
> >   		this_cpu_inc(nr_dentry_negative);
> >   }
> > @@ -1846,7 +1846,8 @@ static void __d_instantiate(struct dentry *dentry, struct inode *inode)
> >   	/*
> >   	 * Decrement negative dentry count if it was in the LRU list.
> >   	 */
> > -	if (dentry->d_flags & DCACHE_LRU_LIST)
> > +	if ((dentry->d_flags &
> > +	     (DCACHE_LRU_LIST|DCACHE_SHRINK_LIST)) == DCACHE_LRU_LIST)
> >   		this_cpu_dec(nr_dentry_negative);
> >   	hlist_add_head(&dentry->d_u.d_alias, &inode->i_dentry);
> >   	raw_write_seqcount_begin(&dentry->d_seq);
> 
> 
> Acked-by: Ian Kent <ikent@redhat.com>
> 
> 
> Christian, just thought I'd call your attention to this since it's a bit
> urgent for us to get reviews
> 
> and hopefully merged into the VFS tree.

I'm about to pick it up.

