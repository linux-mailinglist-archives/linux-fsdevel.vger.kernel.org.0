Return-Path: <linux-fsdevel+bounces-46116-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC83A82C0B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 18:14:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2850919E0C83
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 16:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A97C225DD03;
	Wed,  9 Apr 2025 16:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vxirqlin"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3531D5175;
	Wed,  9 Apr 2025 16:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744214956; cv=none; b=dYlRsl5SpITkIDmZgjPUvpfGpU++KmTKslwovEFHTIari3iPRCXSxuLVD2B/yTuVx9wWgKvXCz/R+dxSgZZ26A0GOmC/lfs3HyfmL9AAONPkPqqrIQMlEDC3uugbEeS7kxJgafXCETHdUwRGjNBa7VdelW1aiHcwrD9GvZmBYh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744214956; c=relaxed/simple;
	bh=Wky+fZWyHyGGeDpD9K7UMOkkWPbSls7RgBx5lKyqYDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DEdTcYu3B8ym0G2RE3Td4wP4CRZGKIWtR7qi1Ce+cGCp+m/4F9zK6msflIhdmd+Hvi/FqZOzLo1nKzt2Dhu3WeZq9aH+miZYd3OFO3lMD/OhMDpIpdCwj5alh7g5FnonmE/bQDbGcTMzLWba7yKRD6zwa3bZR0pXXEIwjhotRmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vxirqlin; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C3B5C4CEE2;
	Wed,  9 Apr 2025 16:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744214955;
	bh=Wky+fZWyHyGGeDpD9K7UMOkkWPbSls7RgBx5lKyqYDw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VxirqlinyuN7+pY0T4gY4pdGxqbPOg+DQLbhjbs4Y/g7IsIn94a1XUrxe2w5FCMpS
	 2WgsLfJG1LX5AEecW+Ev9N0viXUJf2UI5nZXLWbS2aEmxF6VF7+ADvuGX7LOiccDSS
	 4wefyow3dQEeskNIWgaKypFxtNjKrK3jIQiGA0jdvD6c8MNy5dTBW+EP3NrXiNh7Dv
	 kMjfeJ8DRGmOmoobdufWGl/SmRLC9SFYb0aci6dZMoDTF96KSY1/wxoqlCXcjQF+j7
	 L8Q2MRPLvwQ3RbGff9f/KSXCf1Ure7jGahqcQ3WdN/j2Elqy6doPyuKg+s7yI15hEH
	 miK6Ks/Bm7sHw==
Date: Wed, 9 Apr 2025 18:09:10 +0200
From: Christian Brauner <brauner@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Eric Chanudet <echanude@redhat.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Ian Kent <ikent@redhat.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	Alexander Larsson <alexl@redhat.com>, Lucas Karpinski <lkarpins@redhat.com>
Subject: Re: [PATCH v4] fs/namespace: defer RCU sync for MNT_DETACH umount
Message-ID: <20250409-nothilfen-berieseln-dd8a1ee401a1@brauner>
References: <20250408210350.749901-12-echanude@redhat.com>
 <20250409-egalisieren-halbbitter-23bc252d3a38@brauner>
 <20250409131444.9K2lwziT@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250409131444.9K2lwziT@linutronix.de>

On Wed, Apr 09, 2025 at 03:14:44PM +0200, Sebastian Andrzej Siewior wrote:
> On 2025-04-09 12:37:06 [+0200], Christian Brauner wrote:
> > I still hate this with a passion because it adds another special-sauce
> > path into the unlock path. I've folded the following diff into it so it
> > at least doesn't start passing that pointless boolean and doesn't
> > introduce __namespace_unlock(). Just use a global variable and pick the
> > value off of it just as we do with the lists. Testing this now:
> 
> I tried to apply this on top of the previous one but it all chunks
> failed.

See https://web.git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/log/?h=vfs-6.16.mount

