Return-Path: <linux-fsdevel+bounces-30938-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A70998FDBC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 09:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD8762840BF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 07:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D6C139579;
	Fri,  4 Oct 2024 07:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R4jeFEId"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1958C1A;
	Fri,  4 Oct 2024 07:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728026485; cv=none; b=ozgFo1+V9y5VEOJwPQK6xtcxvxO1R3VR88xb63Y/CmYpfVd6++/rWSPAWwJlYmG1M8xy6R8og+FUiD9m3zza4kpS8LEzLWVC1El85eZyFoKTccX4fW42+HzCbNBgcdrtylYlqfUojaE4TFsa6z+zNt8z8Xv40YPeIfpRtNBK90A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728026485; c=relaxed/simple;
	bh=n/54bgSIzo01R4ZrkXvfkm2/9pgFHNkd2Tqp8OzR28Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B9ycqhWgG7t3KcOrCXj9aKLgHYajUYVEaTGv0jGHDhstMI1Wxb2pqX/wYnwfJWkgZ+TgaGVQ3iCSsYW1O3fer50ehFg8+WNRMx634QGkeZx9y+11FQPMxnH/ESIqXAYnzBNAnhZ2Hx4lJj1FxH2KtkDQDzSUlrsaq2n4cCt8Bxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R4jeFEId; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 652EDC4CEC6;
	Fri,  4 Oct 2024 07:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728026485;
	bh=n/54bgSIzo01R4ZrkXvfkm2/9pgFHNkd2Tqp8OzR28Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R4jeFEIdbUdRnMhuPRZd+fY4uCZe5og7w9s0i9zphoCi2lo5KNMlDkvXKaZhdfEl3
	 j090edszQIjuPEidbSwREM27YkZd2tGGMzEXkx8TIZWEzgZgtZI2j2YXeBMD/sr2ng
	 ckOE4v8cvXQeLcHWOTTa3hbF8vARUk1R+WJZW73jk97C66AAqx0jcwisc5d72HGIWF
	 SHE9JBt/g3/Tb3aaE977AbtQxExPSa3IGiDzq5foZALjvfGVqOnJIOqA5QtdrBBJlY
	 QMtOuzLWZ3IOKjBuHVfULsfazmpK/ibw06PJwGrOzWxr1ktxli1YammjoR7t8cAo+c
	 3NdftA9G/95Pw==
Date: Fri, 4 Oct 2024 09:21:19 +0200
From: Christian Brauner <brauner@kernel.org>
To: Dave Chinner <david@fromorbit.com>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>, 
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-bcachefs@vger.kernel.org, 
	kent.overstreet@linux.dev, torvalds@linux-foundation.org, 
	=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@linux.microsoft.com>, Jann Horn <jannh@google.com>, Serge Hallyn <serge@hallyn.com>, 
	Kees Cook <keescook@chromium.org>, linux-security-module@vger.kernel.org, 
	Amir Goldstein <amir73il@gmail.com>
Subject: Re: lsm sb_delete hook, was Re: [PATCH 4/7] vfs: Convert
 sb->s_inodes iteration to super_iter_inodes()
Message-ID: <20241004-abgemacht-amortisieren-9d54cca35cab@brauner>
References: <Zv5GfY1WS_aaczZM@infradead.org>
 <Zv5J3VTGqdjUAu1J@infradead.org>
 <20241003115721.kg2caqgj2xxinnth@quack3>
 <Zv6J34fwj3vNOrIH@infradead.org>
 <20241003122657.mrqwyc5tzeggrzbt@quack3>
 <Zv6Qe-9O44g6qnSu@infradead.org>
 <20241003125650.jtkqezmtnzfoysb2@quack3>
 <Zv6jV40xKIJYuePA@dread.disaster.area>
 <20241003161731.kwveypqzu4bivesv@quack3>
 <Zv8648YMT10TMXSL@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zv8648YMT10TMXSL@dread.disaster.area>

On Fri, Oct 04, 2024 at 10:46:27AM GMT, Dave Chinner wrote:
> On Thu, Oct 03, 2024 at 06:17:31PM +0200, Jan Kara wrote:
> > On Thu 03-10-24 23:59:51, Dave Chinner wrote:
> > > As for the landlock code, I think it needs to have it's own internal
> > > tracking mechanism and not search the sb inode list for inodes that
> > > it holds references to. LSM cleanup should be run before before we
> > > get to tearing down the inode cache, not after....
> > 
> > Well, I think LSM cleanup could in principle be handled together with the
> > fsnotify cleanup but I didn't check the details.
> 
> I'm not sure how we tell if an inode potentially has a LSM related
> reference hanging off it. The landlock code looks to make an
> assumption in that the only referenced inodes it sees will have a
> valid inode->i_security pointer if landlock is enabled. i.e. it
> calls landlock_inode(inode) and dereferences the returned value
> without ever checking if inode->i_security is NULL or not.
> 
> I mean, we could do a check for inode->i_security when the refcount
> is elevated and replace the security_sb_delete hook with an
> security_evict_inode hook similar to the proposed fsnotify eviction
> from evict_inodes().
> 
> But screwing with LSM instructure looks ....  obnoxiously complex
> from the outside...

Imho, please just focus on the immediate feedback and ignore all the
extra bells and whistles that we could or should do. I prefer all of
that to be done after this series lands.

