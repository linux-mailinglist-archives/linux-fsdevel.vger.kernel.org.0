Return-Path: <linux-fsdevel+bounces-73232-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B3F9D12B8F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 14:19:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E0AC5301E1A5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 13:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C7CF3590C4;
	Mon, 12 Jan 2026 13:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p74UuvgV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1614358D12;
	Mon, 12 Jan 2026 13:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768223839; cv=none; b=rGel3aZyzwBSLt9h54DqnuFWEQYBzOIOqPhs+BsITpK4f4jLiS+24CYVenQjVRU+Ya5O0jOyirQUnxcndHOtc+6oHxuku+Ou/DKwNhz+MDm6hz6fE3OMm8t7S8l4hNbfOaKmOkidvfJnrT8BP+UhzCkkIjwFJ4RtU63YNeKRb8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768223839; c=relaxed/simple;
	bh=8RzV/DaxjV6VPb5h4RXY9LxLtYziQ2yXGU7rPDp397s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O+Hfuw0kI8frdDvg4CyOeuUmbrFXvu8LuzkBp8fE5IpEJOBfUAyV+0xCZqGxEyRQ0ocJMJclQULl1jQRq/cBU8FfZOKOCA5jr/5U71TWwLL6ctPzhTg3fMDs6DUpUJ8f6PkVR1Df4z9TCCC7udsgAwJgz/W8xUZVMm1Fdr+j1kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p74UuvgV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9DE0C16AAE;
	Mon, 12 Jan 2026 13:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768223838;
	bh=8RzV/DaxjV6VPb5h4RXY9LxLtYziQ2yXGU7rPDp397s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p74UuvgVS9LVkcETZgJVUUMgaI464b8atZz9SSPWvXq0TMyxJRTy0e/gaFuIGHzxL
	 kfjOAYCiHI54+t3mT07vKtcaiS3XyADck45peOL6/iJZN6v89PgNlG0WAr6hanZ7a6
	 QosFUIb+BlAlJR0Sm8qn7SHUk6E9W9bR8e9MUr2121SRoVrbRWwRHmhvApOTECRilU
	 VTtZUBOu5wvJ8omVyc0iM7+mIR3k5Y0Q+bmC7Nz6xKsDwmp2NiZ7kyXWOZwAc+zSwv
	 tdLjXPkXsrdlRQcPMKPSXZKgf3BucbjIF1UKKo1kiW998Jq6usCniCHeo7JbK+Oqlq
	 EjoigDUokHT2w==
Date: Mon, 12 Jan 2026 14:17:14 +0100
From: Christian Brauner <brauner@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, linux-ext4@vger.kernel.org, 
	jack@suse.cz, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	gabriel@krisman.be, amir73il@gmail.com
Subject: Re: [PATCH 2/6] fs: report filesystem and file I/O errors to fsnotify
Message-ID: <20260112-anpassen-konglomerat-fce55d3de81b@brauner>
References: <176602332085.686273.7564676516217176769.stgit@frogsfrogsfrogs>
 <176602332171.686273.14690243193639006055.stgit@frogsfrogsfrogs>
 <aUOPcNNR1oAxa1hC@infradead.org>
 <20251218184429.GX7725@frogsfrogsfrogs>
 <20251224-nippen-ganoven-fc2db4d34d9f@brauner>
 <20260106164230.GH191501@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260106164230.GH191501@frogsfrogsfrogs>

On Tue, Jan 06, 2026 at 08:42:30AM -0800, Darrick J. Wong wrote:
> On Wed, Dec 24, 2025 at 01:29:21PM +0100, Christian Brauner wrote:
> > > Nope.  Fixed.
> > 
> > I've pulled this from the provided branch which already contains the
> > mentioned fixes. It now lives in vfs-7.0.fserror. As an aside, the
> > numbering for this patch series was very odd which tripped b4 so I
> > applied it with manual massaging. Let me know if there are any issues. 
> 
> Thank you!  But, uh... do you want me to fix the things that hch and jan
> mentioned?  Or have you already fixed them?  I don't see a
> vfs-7.0.fserror branch on the vfs tree[1]...
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/refs/heads

Before Christmas and the new year I didn't push anything out so we don't
end up in a situation where -next is broken but half the people are
still on vacation or are busy catching up.

I'm back now. Please just send a version with the fixes now.

