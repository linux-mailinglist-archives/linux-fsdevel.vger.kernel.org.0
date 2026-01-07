Return-Path: <linux-fsdevel+bounces-72597-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 73778CFCC9E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 07 Jan 2026 10:16:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C07D3067F6D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jan 2026 09:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F17D2F2914;
	Wed,  7 Jan 2026 09:08:51 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB652C3242;
	Wed,  7 Jan 2026 09:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767776930; cv=none; b=JP/XKd9ypvmXYbAvrYG1EKJPvHwQPTNbN7i2zchuJ//2WkVgTXDpR5TxWVouGmxuyziVfiqGoXC8Ar8IBr5UhE5z4gQTPLkW9xQh+oxdHxiLWTt5fa5egJd2qZuzhUkdqW/EWKGekFOnYVb0CFQP5i5lnsAMRHtXzsQgROPKpt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767776930; c=relaxed/simple;
	bh=DXdYcAGfp1+pkcUUk1rRAN5+D0I2gQcz4uFbIOTNuMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rf3FNKoRjgQ0+FPGYxs92q+dRu00DNNgiRCCVXGUAuy6uhbDz//oBQSjxlBy8KxCO7bkMBstfu9BA1b1LeWuxZoCgGxSfUJn+4iXIqVedEaKEKyjkyz89aBqFVg4SNpVQo6AvId1D+KhxNEd3d9zec9yUsW9zt6Aey0I/E5l1N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1DB9E6732A; Wed,  7 Jan 2026 10:08:45 +0100 (CET)
Date: Wed, 7 Jan 2026 10:08:44 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: cem@kernel.org, linux-xfs@vger.kernel.org, hch@lst.de,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 01/11] docs: discuss autonomous self healing in the xfs
 online repair design doc
Message-ID: <20260107090844.GA22838@lst.de>
References: <176766637179.774337.3663793412524347917.stgit@frogsfrogsfrogs> <176766637268.774337.4525804382445415752.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176766637268.774337.4525804382445415752.stgit@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jan 05, 2026 at 11:10:52PM -0800, Darrick J. Wong wrote:
> +The filesystem must therefore create event objects in response to stimuli
> +(metadata corruption, file I/O errors, etc.) and dispatch these events to
> +downstream consumers.
> +Downstream consumers that are in the kernel itself are easy to implement with
> +the ``xfs_hooks`` infrastructure created for other parts of online repair; these
> +are basically indirect function calls.

These hooks mostly went away, didn't they?

> +Being private gives the kernel and ``xfs_healer`` the flexibility to change
> +or update the event format in the future without worrying about backwards
> +compatibility.

I think that ship has sailed once the ABI is out in the wild.

This whole why not use XYZ discussion seems vaguely interesting for a
commit log, but does it belong into the main documentation?

> +*Answer*: Yes.
> +fanotify is much more careful about filtering out events to processes that
> +aren't running with privileges.
> +These processes should have a means to receive simple notifications about
> +file errors.
> +However, this will require coordination between fanotify, ext4, and XFS, and
> +is (for now) outside the scope of this project.

Didn't this already get merged by Christian, and thus this information
is stale already?

> +When a filesystem mounts, the Linux kernel initiates a uevent describing the
> +mount and the path to the data device.

This also isn't true anymore, is it?


