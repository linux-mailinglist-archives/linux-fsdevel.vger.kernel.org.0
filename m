Return-Path: <linux-fsdevel+bounces-65198-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF5F0BFDE0F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 20:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B35ED3A7332
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 18:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF9D34CFB9;
	Wed, 22 Oct 2025 18:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="xdxcVq5i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28FE2701BB;
	Wed, 22 Oct 2025 18:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761158306; cv=none; b=kr6gcfVXkTlXSiAcb9dUmoQXkbtJjRkUvrNuodBxPd41kkYxWeqt9azE2ZulPqSW4ew7gIikt+Ym+xJ5IPC+kVPvlTlfYLDoNLn2aN1M4FQv+B7rAlo4EFjsvB8N5vYEmD92Y0F9KjBXLyFGIKHpcVutq6LMP3MHJNrPJYF45Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761158306; c=relaxed/simple;
	bh=RqQlQORqCXLRUiL3vVHJ9CCKwIACu95r35ar8HrBFHk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=n0oOToetuwHg0erVYkS+Uhrf3QwwFPs5V5l3jYUPTLN0BrJCqxZ4XPsAIAiUI++677z5+ZYU95wy3d8KUEoq+SHDutMkQYvH+u21/c+BSOJuBT28Dh/d80vl4vE7V92jd48KC15KuZ02RnEchuK0hSZ7xl2nDhD0CW4fbBzDkNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=xdxcVq5i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD5A1C4CEE7;
	Wed, 22 Oct 2025 18:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1761158306;
	bh=RqQlQORqCXLRUiL3vVHJ9CCKwIACu95r35ar8HrBFHk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=xdxcVq5ibAI/IsUG0H8rVpGBwxOnQMNU7VqKSG7xATvkS/+qPe3WUCQBIASqQ0H0T
	 w/9dnj+Iidsy4zJM9DUPzjdnpM+mqQ4BLeH0R3gkfB4+Kv6DvvWJmiWOvYGneKiyq3
	 JG5YgmHEHV4rOSDrvoIt293Mfutg55DryndAMF3E=
Date: Wed, 22 Oct 2025 11:38:25 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Carlos
 Maiolino <cem@kernel.org>, willy@infradead.org, dlemoal@kernel.org,
 hans.holmberg@wdc.com, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-xfs@vger.kernel.org
Subject: Re: allow file systems to increase the minimum writeback chunk size
 v2
Message-Id: <20251022113825.f9d0a2f3143929f9e1f2967d@linux-foundation.org>
In-Reply-To: <20251022053434.GA3729@lst.de>
References: <20251017034611.651385-1-hch@lst.de>
	<20251022053434.GA3729@lst.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Oct 2025 07:34:34 +0200 Christoph Hellwig <hch@lst.de> wrote:

> Looks like everything is reviewed now, can we get this queued up
> as it fixes nasty fragmentation for zoned XFS?
> 
> It seems like the most recent writeback updates went through the VFS
> tree, although -mm has been quite common as well.

mpage, writeback, readahead, filemap, buffer.c  etc have traditionally
been MM tree things (heck, I basically wrote them all a mere 20 years
ago).

They're transitioning to being fs things nowadays, and that makes sense
- filesystems are the clients for this code.

But please do keep cc'ing linux-mm and myself on this work.

> >  fs/fs-writeback.c         |   26 +++++++++-----------------
> >  fs/super.c                |    1 +
> >  fs/xfs/xfs_zone_alloc.c   |   28 ++++++++++++++++++++++++++--
> >  include/linux/fs.h        |    1 +
> >  include/linux/writeback.h |    5 +++++

VFS tree, please.

