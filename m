Return-Path: <linux-fsdevel+bounces-10305-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 519D2849A2C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 13:29:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 066461F22553
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 12:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D6001BC3D;
	Mon,  5 Feb 2024 12:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jVt8RHHC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66351BC2A;
	Mon,  5 Feb 2024 12:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707136163; cv=none; b=pCjf3HsNvAHpDALuOdE/5eW2vAK6V6d9OMvixBnR2bQsxPZNYfrBGxENBA+rRomhde65V0YBIa7ENwhXpqImBxBqMrNMyLy9YpC0aVAtKslGKSyJW23utjrz62cKyp7Sh0jEhRDg3VLb66d7we5Q8tuCoioyIQEIvG5T2M8oBfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707136163; c=relaxed/simple;
	bh=9VIzpldlja628eXYs80Y0yTHhn7IvngD/q5QyIraPJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CXGlm2I0Oi4jShe5ayUYwE6UeY4JbUS/QtvdXNENY2keNhR5vPJfQQGV0NNbc3MgrtJ2mDXXUrVFSzC1kUYlmidUGTa5/HuunPF1LdkfegRRiOuPRvnzHJ599iHZ8Lmqvz1/C4LQhCpLQdwRLY9KcS97W85eKjKrbRVjWhNGlH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jVt8RHHC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D2B6C433C7;
	Mon,  5 Feb 2024 12:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707136163;
	bh=9VIzpldlja628eXYs80Y0yTHhn7IvngD/q5QyIraPJk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jVt8RHHCjgJbGVUufVEgE+ew/q0FQykZxtC2OGR5xFX8Wk0tB8E+QVWiWUEQl+wx8
	 VFJ1fqJtfaD6S2errcATpW23qQsNhPkrstOtaa9ouGdoSjwlOJnuv6EGdXqx374NZW
	 iRJWDdOnOHHf6es2WbT2LyNEw93IjgLXG2Im29A6ZYKWpr8kNSLgM5hHjQIPo7Xryn
	 54G0tMi0+C70Nswm35KOYbM8ADmSyx4N5T8slkYFuw6+WR7oL+ZDyplevEmtO7LhpA
	 n2cOcRZYgU+GkfiZwdtRaofPH88U12zZkm8ahsctDrJYRG/Hd0pdmp+TJf0zvUXmzl
	 5BudX+sdVb59w==
Date: Mon, 5 Feb 2024 13:29:18 +0100
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, linux-ext4@vger.kernel.org, linux-nfs@vger.kernel.org, 
	Miklos Szeredi <miklos@szeredi.hu>, linux-cifs@vger.kernel.org
Subject: Re: [PATCH 07/13] nfs: make nfs_set_verifier() safe for use in RCU
 pathwalk
Message-ID: <20240205-finessenreich-mieten-bcbd5bb2e6cb@brauner>
References: <20240204021436.GH2087318@ZenIV>
 <20240204021739.1157830-1-viro@zeniv.linux.org.uk>
 <20240204021739.1157830-7-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240204021739.1157830-7-viro@zeniv.linux.org.uk>

On Sun, Feb 04, 2024 at 02:17:33AM +0000, Al Viro wrote:
> nfs_set_verifier() relies upon dentry being pinned; if that's
> the case, grabbing ->d_lock stabilizes ->d_parent and guarantees
> that ->d_parent points to a positive dentry.  For something
> we'd run into in RCU mode that is *not* true - dentry might've
> been through dentry_kill() just as we grabbed ->d_lock, with
> its parent going through the same just as we get to into
> nfs_set_verifier_locked().  It might get to detaching inode
> (and zeroing ->d_inode) before nfs_set_verifier_locked() gets
> to fetching that; we get an oops as the result.
> 
> That can happen in nfs{,4} ->d_revalidate(); the call chain in
> question is nfs_set_verifier_locked() <- nfs_set_verifier() <-
> nfs_lookup_revalidate_delegated() <- nfs{,4}_do_lookup_revalidate().
> We have checked that the parent had been positive, but that's
> done before we get to nfs_set_verifier() and it's possible for
> memory pressure to pick our dentry as eviction candidate by that
> time.  If that happens, back-to-back attempts to kill dentry and
> its parent are quite normal.  Sure, in case of eviction we'll
> fail the ->d_seq check in the caller, but we need to survive
> until we return there...
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Acked-by: Christian Brauner <brauner@kernel.org>

