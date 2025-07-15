Return-Path: <linux-fsdevel+bounces-54934-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A5EB0575E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 12:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 375D51C20CDF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 10:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0A0274B41;
	Tue, 15 Jul 2025 10:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LpKqz9sH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E23233722;
	Tue, 15 Jul 2025 10:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752573731; cv=none; b=f74W6f1wPdAnPygQ5S9kOhRF+jlpcV+0q2waVzvJMGHuitUkOdTJpHuQIi0LdQMGoiwjkmlJuyrxxuVamRFdVN27+MXuGdoJLXiw3o9tX4d5lSj6mcgJHqxMyjk/YTWGHxlJpyWlECkCMLElI7hMltTPSHPASyi9IbvqVkS0bg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752573731; c=relaxed/simple;
	bh=SOfcU+iTyg8H0Sg4mB6xITzhMhY8+TF6KRQHztAOU9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z/u5pcq9H/owyKn14NZ+m93B1/k36mTVh7q0OEJh7GU32be1tHZYGZzKgPILnHSC0Asp/A73rteis0TeSLaD8ID6yguEcdECDXS/FXdd9attyy53hooI8TVNsmqkycC7FFwMfkl7YXVlFPFUA06/ZDS0K0uYS/L8pkzfIKOPAe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LpKqz9sH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1223DC4CEE3;
	Tue, 15 Jul 2025 10:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752573730;
	bh=SOfcU+iTyg8H0Sg4mB6xITzhMhY8+TF6KRQHztAOU9k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LpKqz9sHm/8RPY1NnA7PM38L2AwywOS8Ht3k9v+hLM7o7fePXsi0FMK3HPHRqxYMz
	 9RrhUH5yI07atCTRlirLbOzr/LUQIbpaisoyMXlbzkZ6ZdHE/5kZi1yMzUCmlky6k8
	 qfosfeEgVQEl2IvSrtTZAbENnul6w+fqmFrs238KwuqG8VXeauoBrLk2/GxWgQloFB
	 ttfOykGyKXnIyQHnIbgf9ZtWbSLgEZkDlmalj5LqtWuiCvotMvGHLu7kyjpiIg9+NI
	 iZy5AIkMpIHzJRGuci0jc4OiemW+6haUQdgZ/8QXNAGqeJkR6rEiNxKJ5lRxRLTpYM
	 hVQO3ctrWenIw==
Date: Tue, 15 Jul 2025 12:02:06 +0200
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: John Garry <john.g.garry@oracle.com>, 
	Christoph Hellwig <hch@infradead.org>, "Darrick J. Wong" <djwong@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-nvme@lists.infradead.org
Subject: Re: Do we need an opt-in for file systems use of hw atomic writes?
Message-ID: <20250715-rundreise-resignieren-34550a8d92e3@brauner>
References: <20250714131713.GA8742@lst.de>
 <6c3e1c90-1d3d-4567-a392-85870226144f@oracle.com>
 <aHULEGt3d0niAz2e@infradead.org>
 <6babdebb-45d1-4f33-b8b5-6b1c4e381e35@oracle.com>
 <20250715060247.GC18349@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250715060247.GC18349@lst.de>

On Tue, Jul 15, 2025 at 08:02:47AM +0200, Christoph Hellwig wrote:
> On Mon, Jul 14, 2025 at 04:53:49PM +0100, John Garry wrote:
> > I see. I figure that something like a FS_XFLAG could be used for that. But 
> > we should still protect bdev fops users as well.
> 
> I'm not sure a XFLAG is all that useful.  It's not really a per-file
> persistent thing.  It's more of a mount option, or better persistent
> mount-option attr like we did for autofsck.

If we were to make this a mount option it would be really really ugly.
Either it is a filesystem specific mount option and then we have the
problem that we're ending up with different mount option names
per-filesystem.

And for a VFS generic mount option this is way too specific. It would
be extremely misplaced if we start accumulating hardware opt-out/opt-in
mount options on the VFS layer.

It feels like this is something that needs to be done on the block
layer. IOW, maybe add generic block layer ioctls or a per-device sysfs
entry that allows to turn atomic writes on or off. That information
would then also potentially available to the filesystem to e.g.,
generate an info message during mount that hardware atomics are used or
aren't used. Because ultimately the block layer is where the decision
needs to be made.

