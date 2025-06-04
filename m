Return-Path: <linux-fsdevel+bounces-50593-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA9BACD8B1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 09:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 966227A6295
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 07:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6551C5D72;
	Wed,  4 Jun 2025 07:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UP7SG/aZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5778917A30A
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Jun 2025 07:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749022796; cv=none; b=FelkqYai60a4UlAauAF9cRQFBKv58eI9kCmeouzCqIFdzcKGx2l5zOYQ3W3hFb7a6iAuVIU5QWcCajJ37GYH0aM6owiVV7oa9CjIUztnE9odn1ugCY7X44humTFt9aA9DD5XSlqRxQlqALKi5+7qVr3+KWzus/uOHavnZ8nlS5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749022796; c=relaxed/simple;
	bh=bVBg/52UIluVdJ1D1F0wzRzL5kfntjBq13G5UV04js0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aabVNFrdZ7gvVRhaYFylEp6OcoC2b5wVjYkFbqxjQjk9wGvsvswJpwS+6Ixt6kmToJRRYyoRFHtzRKo9Pw4Oxz0xYYXVJX36r7rzXWgV4xoipqsMrc5p5Tblvt5ft5g+COeGq39PDu1aIKNiGdP7/y/dQvZlMMu9s/+YrNtKOYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UP7SG/aZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6047C4CEED;
	Wed,  4 Jun 2025 07:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749022796;
	bh=bVBg/52UIluVdJ1D1F0wzRzL5kfntjBq13G5UV04js0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UP7SG/aZ9pN6/gSIdnCNmRkrzY2TS3rTnqXMnxMRULbYWJpeH0ya9JDMpRCNyGlQm
	 xwOLyhRRwsOaiONB/EmxcIEYkYFvp3CrNcSL9NCKyhfmVm6BAiHk5JkAb52MFr0IRE
	 3qtIqftQy/4cRexeOY644B6a3PZASRDkP9oay6OgFDV9rS2iXRVL4IVxwsE4zluSwp
	 x2DsPgKVh0hGR86IPLc6DYtk2qN8mSuAbZY07gXJSVVuarB0UHQPZMziTKAVHf7QbT
	 D8H9/2kqiyJF5QD1Xx1W5ps24Q2S/AApkkEUu8ZmcFir6pz8A7uHOk+evyNArT/Avv
	 MJ17Upyv7OsXw==
Date: Wed, 4 Jun 2025 09:39:52 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Jan Kara <jack@suse.cz>, 
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Subject: Re: [PATCH 4/5] fix propagation graph breakage by
 MOVE_MOUNT_SET_GROUP move_mount(2)
Message-ID: <20250604-ungern-wahlgang-515d5cfec5df@brauner>
References: <20250603231500.GC299672@ZenIV>
 <20250603231911.GD145532@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250603231911.GD145532@ZenIV>

On Wed, Jun 04, 2025 at 12:19:11AM +0100, Al Viro wrote:
> 9ffb14ef61ba "move_mount: allow to add a mount into an existing group"
> breaks assertions on ->mnt_share/->mnt_slave.  For once, the data structures
> in question are actually documented.
> 
> Documentation/filesystem/sharedsubtree.rst:
>         All vfsmounts in a peer group have the same ->mnt_master.  If it is
> 	non-NULL, they form a contiguous (ordered) segment of slave list.
> 
> do_set_group() puts a mount into the same place in propagation graph
> as the old one.  As the result, if old mount gets events from somewhere
> and is not a pure event sink, new one needs to be placed next to the
> old one in the slave list the old one's on.  If it is a pure event
> sink, we only need to make sure the new one doesn't end up in the
> middle of some peer group.
> 
> "move_mount: allow to add a mount into an existing group" ends up putting
> the new one in the beginning of list; that's definitely not going to be
> in the middle of anything, so that's fine for case when old is not marked
> shared.  In case when old one _is_ marked shared (i.e. is not a pure event
> sink), that breaks the assumptions of propagation graph iterators.
> 
> Put the new mount next to the old one on the list - that does the right thing
> in "old is marked shared" case and is just as correct as the current behaviour
> if old is not marked shared (kudos to Pavel for pointing that out - my original
> suggested fix changed behaviour in the "nor marked" case, which complicated
> things for no good reason).
> 
> Fixes: 9ffb14ef61ba ("move_mount: allow to add a mount into an existing group")
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

