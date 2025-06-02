Return-Path: <linux-fsdevel+bounces-50301-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5316EACAB3E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 11:17:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B80817974D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 09:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 783261C863B;
	Mon,  2 Jun 2025 09:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ayaz87gZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E191A5B99
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Jun 2025 09:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748855849; cv=none; b=LnI0+vlusd1rrjM84awO9DNgxjAeQxKw1ZDr2QHvgprgBnb5i5mvW+5PuP8ndyX2AJTyUEEKrtCu4n7s1zzt0nmYBFySnr+gzmogSDvw6h4CG+FMnrMH3S+BvO8KdKXkJfxkkp5GxSJfOvC6QQvCx6YPDXiHWtMQvldxV13xjAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748855849; c=relaxed/simple;
	bh=1vW/l8Y3wlLAt4sd+7TLE6qAKH6kjyG37E14zI6kpdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hOEL2CsnazT/ESBNzVTmw3DNH1+RX0Se7R2vY7nyptmjJ4eFUFvl9EiwWs21N+1a65EJenF6Bzy4poxgDJhZ6AHWbzNlLySxQoFotBGeeoWnAeeORBcWiMEK5to48+9D9Bh1DEXeQmOPNenV++eMFptz5EQA/y5RVH18dYtj4HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ayaz87gZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 899E4C4CEEB;
	Mon,  2 Jun 2025 09:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748855849;
	bh=1vW/l8Y3wlLAt4sd+7TLE6qAKH6kjyG37E14zI6kpdY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ayaz87gZ9liEj4TcIBfN2faJ/UaztiuRPlb73l/mInfDWDNtaQJalm+h/7R0M4u60
	 eEa83bLUgSewxCCSv8WFgfp5BOlCQaXfBB/RVdRTjDCWxoRw9CDJrJcd0kgXbHTgwr
	 /SUSayr1tnNLyxsmWCByw7mKKxE8KipOsvWpDYFQLg4Reimkb4gc6Sc/Bt9XAdhT+0
	 u6zmDxuV1cNAFi/MrWl2C2aNQ9r9m+6T/cokvej+KKpSqrBg3aZEzvoJKtqLHOkCJq
	 gSORqC84Q6V656koMv6A4kqo5zF88eomiwKbD5V+VTFw+KDc3ybqP+Sc+SA2ITHRPE
	 zV1LbrocmuVQg==
Date: Mon, 2 Jun 2025 11:17:25 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: [BUG][RFC] broken use of __lookup_mnt() in path_overmounted()
Message-ID: <20250602-zugeneigt-abgepfiffen-c041e047f96e@brauner>
References: <20250531205700.GD3574388@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250531205700.GD3574388@ZenIV>

On Sat, May 31, 2025 at 09:57:00PM +0100, Al Viro wrote:
> 	More audit fallout.
> 
> Rules for using mount hash (will go into the docs I'm putting together):
> 	* all insertions are under EXCL(namespace_sem) and write_seqlock(mount_lock)
> 	* all removals are under write_seqlock(mount_lock)
> 	* all removals are either under EXCL(namespace_sem) or have parent's
> refcount equal to zero.
> 	* since all changes to hash chains are under write_seqlock(mount_lock),
> hash seatch is safe if you have at least read_seqlock_excl(mount_lock).  In
> that case the result is guaranteed to be accurate.
> 	* removals are done with hlist_del_init_rcu(); freeing of the removed
> object is always RCU-delayed, so holding rcu_read_lock() over traversal is
> memory safe.  HOWEVER, it is entirely possible to step into an object being
> removed from hash chain at the time of search and get a false negative.
> If you are not holding at least read_seqlock_excl(mount_lock), you *must*
> sample mount_lock seqcount component before the search and check it afterwards.
> 	* acquiring a reference to object found as the result of traversal needs
> to be done carefully - it is safe under mount_lock, but when used under rcu_read_lock()
> alone we do need __legitimize_mnt(); otherwise we are risking a race with
> final mntput() and/or busy mount checks in sync umount.
> 
> Search is done by __lookup_mnt().
> Callers under write_seqlock(mount_lock):
> 	* all callers in fs/pnode.c and one in attach_recursive_mnt().
> Callers under rcu_read_lock():
> 	* lookup_mnt() - seqcount component of mount_lock used to deal
> with races.  Check is done by legitimize_mnt().
> 	* path_overmounted() - the callers are under EXCL(namespace_sem)
> and they are holding a reference to parent, so removal of the object we
> are searching for is excluded.  Reference to child is not acquired, so
> the questions about validity of that do not arise.  Unfortunately, removals
> of objects in the same hash chain are *not* excluded, so a false negative
> is possible there.
> 
> Bug in path_overmounted() appears to have come from the corresponding
> chunk of finish_automount(), which had the same race (and got turned
> into a call of path_overmounted()).
> 
> One possibility is to wrap the use of __lookup_mnt() into a sample-and-recheck
> loop there; for the call of path_overmounted() in finish_automount() it'll
> give the right behaviour.
> 
> The other one, though...  The thing is, it's not really specific to
> "move beneath" case - the secondary copies always have to deal with the
> possibility of "slip under existing mount" situation.  And yes, it can
> lead to problems - for all attach_recursive_mnt() callers.

Fwiw, I have pointed this out in one of my really early submission of
this work and had asked whether we generally want the same check. That's
also why I added the shadow-mount check into the automount path because
that could be used for that sort of issue to afair but my memory is
fuzzy here.

> 
> Note that do_loopback() can race with mount(2) on top of the old_path
> - it might've happened between the pathname resolution for source and
> lock_mount() for mountpoint.  We *can't* hold namespace_sem over the
> pathname resolution - it'd be very easy to deadlock.

Yes.

> 
> One possibility would be to have all of them traverse the chain of
> overmounts on top of the thing we are going to copy/move, basically
> pretending that we'd lost the race to whatever had done the overmount.
> The problem with that is there might have been no race at all - it
> might've come from "." or a descriptor + empty path.  In this case
> we currently copy/move the entire thing and it just might be used
> deliberately.
> 
> Another possibility is to teach attach_recursive_mnt() to cope with the
> possibility of overmounts in source - it's not that hard, all we need is
> to find the top of overmount chain there in the very beginning and in all
> "slip under existing mount" cases have the existing mount reparented to
> the top of that chain.

I'm seeing you have already sent a second mail so I take it you made a
decision already but the second option seems sanest to me.

