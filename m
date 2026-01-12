Return-Path: <linux-fsdevel+bounces-73225-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 54782D129B6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 13:49:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 352D5301DE8A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 12:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED67357A5A;
	Mon, 12 Jan 2026 12:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IvulzzvO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31AD934DB7C;
	Mon, 12 Jan 2026 12:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768222135; cv=none; b=ZKwTuCYqQuNlKCK1gYdEiAKJS5UYc2CjqTA9wzTfaPU8zTpWaHNZYkfYxYzJsIlvAKcQob2nCN8oTnNJm3EVAY8PNxhqt+5+l0CgGyKMxKVyQRDpIwKfGC++i77RjA2b0mFfcscE0ykET5nT4yVAjCktRdAIddUfowrKo76V8uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768222135; c=relaxed/simple;
	bh=RmC5fFTY83NZXuYaTscyfYhCMn2DaAIo5s2lhxtmxqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X74zLUFj1QzjOYnP6HQCGzfb+0lyreTnEljt446P4jRO77gYUd+9lFrarUFd+SF/CQhFW++3FvBwSkG36DJ2mCuw1V7cgq6yydItuMyFdJ/kEM9I66XeINPnV55a8+BtfRgvwtpeXhzpbM2RUXLsy/ALIu6gALAd11QlbNPAAvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IvulzzvO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58A5DC16AAE;
	Mon, 12 Jan 2026 12:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768222134;
	bh=RmC5fFTY83NZXuYaTscyfYhCMn2DaAIo5s2lhxtmxqg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IvulzzvOMTvJ9gY3RP8fknnfrw34vOmQnYDZiRGfbH1t/FYue9uk2LYvJDlJk4Dtg
	 kffxMk7jciU0SZxq2c/8ISjv3QUQ+VntvzDAVg0HLkFyyWBWx7SQsA+SAyApzIzzEr
	 L1A4cVQIIq7xNGTaeZ44gP3OFyRBny8/7C6FLTQgJKPwi1KqKHV1EH9NC3x4sjg8Ig
	 5W+fd6D5CQt2bg9lfAsw222RVVP7zfXl9NGX7Dnho/zkOiNZG96ENJkbPyVexuW0Kb
	 xarctrWtbPrlHVxY8rhjpcefeUKl/MEOclYsBML2ZRlWmc86vEbhtw6uI4rCwzG1U6
	 SQR5b2tLXMJKQ==
Date: Mon, 12 Jan 2026 13:48:51 +0100
From: Christian Brauner <brauner@kernel.org>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	viro@zeniv.linux.org.uk, Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH 0/4] btrfs: stop duplicating VFS code for
 subvolume/snapshot dentry
Message-ID: <20260112-wonach-mochten-cd6c14b298ae@brauner>
References: <cover.1767801889.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1767801889.git.fdmanana@suse.com>

On Thu, Jan 08, 2026 at 01:35:30PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Currently btrfs has copies of two unexported functions from fs/namei.c
> used in the snapshot/subvolume creation and deletion. This patchset
> exports those functions and makes btrfs use them, to avoid duplication
> and the burden of keeping the copies up to date.

Seems like a good idea to me.
Let me know once it's ready and I'll give you a stable branch with the
VFS bits applied where you can apply the btrfs specific changes on top.
Thanks!

