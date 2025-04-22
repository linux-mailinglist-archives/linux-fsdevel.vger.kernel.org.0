Return-Path: <linux-fsdevel+bounces-46951-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6600BA96DE6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 16:05:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E39A7A7DC4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 14:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3414C28150B;
	Tue, 22 Apr 2025 14:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nEYns9o3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967EC1632E6
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Apr 2025 14:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745330745; cv=none; b=d51kMv0S/7x7OcIuRkx13k2rfiHK5PvXT9ZZuuOdYQulZ9oUOdu1SOgcxvBEpnNmpeVrtVL2DXj5PgCodptUvATQ+d3CLHsErQAAhks1SJxYT7MdFuryXUso9ibf221Z75Uyiz3t8WcdOQWypZOYAqd0loiGEq/h+TAyLMRrhgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745330745; c=relaxed/simple;
	bh=5hFhbUROWG7JCH/PHzH+RYt66Zv9btiPZFfRXm8C3UU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T8AqTQ/LDYVXKPqUZR8yrIHjuX/eevi/nn8OA2KVc/3FJhg80PJ7Coz6emXtk8IOIsANoVmIH6vr7S7GDy5pUjfivdErOdghG/Ho/FO4zLcUYDZbN0JaEvkA6XH7izKYWt0d15FDqSGaqSTWCEsBCqMDbfKRjgOSWmqm2+noz2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nEYns9o3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F4EBC4CEEA;
	Tue, 22 Apr 2025 14:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745330745;
	bh=5hFhbUROWG7JCH/PHzH+RYt66Zv9btiPZFfRXm8C3UU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nEYns9o3daLvzg2AIerc4SCEWONJjPWyTKhhg1YVFfNydMNLYy/mpOxLOYCb7K0cG
	 wf8SJt5LSjRj5/+XYU6/JRIPxtZsaF6H1p//SyzmZQLdCL49reacdOwb8dgqOrhkAk
	 WkFMcpV9T+yhyKl0yBixk3+NmUBtjCyvQmcLU5kij8bRyqhF8cq5y4Ss8dX//NUrom
	 v8IIunHQ3+XqHQzIR9rwSsdgV/lyN3bk1PX9Ygt22scGUuGEmACgQXF+c5x63uzrw2
	 ule3TCy/bUjStHehRffpJ6w5kIfYXdorMY5Yb52j/azi47ah6po1TjvRGbM5QTICxE
	 dhTezMV1ZT5Aw==
Date: Tue, 22 Apr 2025 16:05:40 +0200
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Jan Kara <jack@suse.cz>, 
	Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Jeff Layton <jlayton@kernel.org>, 
	Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH RFC 1/3] inode: add fastpath for filesystem user
 namespace retrieval
Message-ID: <20250422-flexibel-notfall-342ac4891b1a@brauner>
References: <20250416-work-mnt_idmap-s_user_ns-v1-0-273bef3a61ec@kernel.org>
 <20250416-work-mnt_idmap-s_user_ns-v1-1-273bef3a61ec@kernel.org>
 <mzryrjmph2ws7kprtnxj34xqp4cyhfdwpfnltkx4ziugwdqmu7@f4myyqyrmta3>
 <CAGudoHFv6u5DrWbXt6C_LPmzzQ1Gmia6-h1QZ=RDWzct63N_mA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGudoHFv6u5DrWbXt6C_LPmzzQ1Gmia6-h1QZ=RDWzct63N_mA@mail.gmail.com>

On Tue, Apr 22, 2025 at 03:33:03PM +0200, Mateusz Guzik wrote:
> On Tue, Apr 22, 2025 at 12:37 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Wed 16-04-25 15:17:22, Christian Brauner wrote:
> > > We currently always chase a pointer inode->i_sb->s_user_ns whenever we
> > > need to map a uid/gid which is noticeable during path lookup as noticed
> > > by Linus in [1]. In the majority of cases we don't need to bother with
> > > that pointer chase because the inode won't be located on a filesystem
> > > that's mounted in a user namespace. The user namespace of the superblock
> > > cannot ever change once it's mounted. So introduce and raise IOP_USERNS
> > > on all inodes and check for that flag in i_user_ns() when we retrieve
> > > the user namespace.
> > >
> > > Link: https://lore.kernel.org/CAHk-=whJgRDtxTudTQ9HV8BFw5-bBsu+c8Ouwd_PrPqPB6_KEQ@mail.gmail.com [1]
> > > Signed-off-by: Christian Brauner <brauner@kernel.org>
> >
> > Some performance numbers would be in place here I guess - in particular
> > whether this change indeed improved the speed of path lookup or whether the
> > cost just moved elsewhere.
> 
> Note that right now path lookup is a raging branchfest, with some
> avoidable memory references to boot.
> 
> I have a WIP patch to bypass inode permission checks with an
> ->i_opflag and get over 5% speed up when stating stuff in
> /usr/include/linux/. This might be slightly more now.
> 
> Anyhow, this bit here probably does not help that much in isolation
> and I would not worry about that fact given the overall state.
> Demonstrating that this indeed avoids some work in the common case
> would be sufficient for me.
> 
> To give you a taste: stat(2) specifically around 4.28 mln ops/s on my
> box. Based on perf top I estimate sorting out the avoidable
> single-threaded slowdowns will bring it above 5 mln.
> 
> The slowdowns notably include the dog slow memory allocation (likely
> to be sorted out with sheaves), the smp_mb fence in legitimize_mnt and
> more.
> 
> Part of the problem is LOOKUP_RCU checks all over the place. I presume
> the intent was to keep this and refwalk closely tied to reduce code
> duplication and make sure all parties get updated as needed. I know
> the code would be faster (and I *suspect* cleaner) if this got
> refactored into dedicated routines instead. Something to ponder after
> the bigger fish is fried.

I think the cleanup itself the right thing to do because it makes it
obvious that we're not doing any work when no idmapped mounts are
involved. v2 is a lot cleaner and simpler as well.

