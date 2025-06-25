Return-Path: <linux-fsdevel+bounces-52978-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F93BAE918D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 01:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CD3B3AD584
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 23:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878052D8797;
	Wed, 25 Jun 2025 23:05:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23AC225A33F;
	Wed, 25 Jun 2025 23:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750892707; cv=none; b=Jfre1eebV1iGvO48lCwM1d0Y1CWvr47sKfsR61/+S94XiCbJJgrlBGaOvKyils8+tF+HBriDhh3jE03DB08jFC9gNz3c1BtAFec6l4VT784LFuSAA/qPEWmcXyT8bnB2/L8IftI3ul+wE76sBLLizzjheAAXLFE131vuf0nomng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750892707; c=relaxed/simple;
	bh=u7ptJ2XReCH4v22yKtQsXDi9KrS1wW909Hht8Ak/I6k=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=t8GF8RFvijcDt0TiS3YeXd+PSWAZrw7bcbFOEa8yqrk5OaeGQBSjIuciNt6RRglRcjel63PeAiCD2etBLk53YLWJvM0/GO1l7aKm49MXgfhgtrLmnN8Y0rl6q7SVHHSA7riHaM+8fzoxvfJJN0FEk59zNULMKtd/bMjsT6RYVJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uUZAn-004tNX-Di;
	Wed, 25 Jun 2025 23:04:57 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neil@brown.name>
To: =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: "Song Liu" <song@kernel.org>, bpf@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org, brauner@kernel.org,
 kernel-team@meta.com, andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, viro@zeniv.linux.org.uk,
 jack@suse.cz, kpsingh@kernel.org, mattbobrowski@google.com,
 "Tingmao Wang" <m@maowtm.org>,
 =?utf-8?q?G=C3=BCnther?= Noack <gnoack@google.com>
Subject: Re: [PATCH v5 bpf-next 0/5] bpf path iterator
In-reply-to: <20250625.Ee2Ci6chae8h@digikod.net>
References: <>, <20250625.Ee2Ci6chae8h@digikod.net>
Date: Thu, 26 Jun 2025 09:04:56 +1000
Message-id: <175089269668.2280845.5681675711269608822@noble.neil.brown.name>

On Wed, 25 Jun 2025, Mickaël Salaün wrote:
> On Wed, Jun 25, 2025 at 07:38:53AM +1000, NeilBrown wrote:
> > 
> > Can you spell out the minimum that you need?
> 
> Sure.  We'd like to call this new helper in a RCU
> read-side critical section and leverage this capability to speed up path
> walk when there is no concurrent hierarchy modification.  This use case
> is similar to handle_dots() with LOOKUP_RCU calling follow_dotdot_rcu().
> 
> The main issue with this approach is to keep some state of the path walk
> to know if the next call to "path_walk_parent_rcu()" would be valid
> (i.e. something like a very light version of nameidata, mainly sequence
> integers), and to get back to the non-RCU version otherwise.
> 
> > 
> > My vague impression is that you want to search up from a given strut path,
> > no further then some other given path, looking for a dentry that matches
> > some rule.  Is that correct?
> 
> Yes
> 
> > 
> > In general, the original dentry could be moved away from under the
> > dentry you find moments after the match is reported.  What mechanisms do
> > you have in place to ensure this doesn't happen, or that it doesn't
> > matter?
> 
> In the case of Landlock, by default, a set of access rights are denied
> and can only be allowed by an element in the file hierarchy.  The goal
> is to only allow access to files under a specific directory (or directly
> a specific file).  That's why we only care of the file hierarchy at the
> time of access check.  It's not an issue if the file/directory was
> moved or is being moved as long as we can walk its "current" hierarchy.
> Furthermore, a sandboxed process is restricted from doing arbitrary
> mounts (and renames/links are controlled with the
> LANDLOCK_ACCESS_FS_REFER right).
> 
> However, we need to get a valid "snapshot" of the set of dentries that
> (could) lead to the evaluated file/directory.

A "snapshot" is an interesting idea - though looking at the landlock
code you one need inodes, not dentries.
I imagine an interface where you give it a starting path, a root, and
and array of inode pointers, and it fills in the pointers with the path
- all under rcu so no references are needed.
But you would need some fallback if the array isn't big enough, so maybe
that isn't a good idea.

Based on the comments by Al and Christian, I think the only viable
approach is to pass a callback to some vfs function that does the
walking.

   vfs_walk_ancestors(struct path *path, struct path *root,
		      int (*walk_cb)(struct path *ancestor, void *data),
		      void *data)

where walk_cb() returns a negative number if it wants to abort, and is
given a NULL ancestor if vfs_walk_ancestors() needed to restart.

vfs_walk_ancestors() would initialise a "struct nameidata" and
effectively call handle_dots(&nd, LAST_DOTDOT) repeatedly, calling
    walk_cb(&nd.path, data)
each time.

How would you feel about that sort of interface?

NeilBrown

