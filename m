Return-Path: <linux-fsdevel+bounces-73610-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E0FD1CA61
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 07:16:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CEDAC300F8B5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 06:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE42436A024;
	Wed, 14 Jan 2026 06:16:22 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF221531C8;
	Wed, 14 Jan 2026 06:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768371372; cv=none; b=ZwLG94u1hIRAax2+DC622WAfdAx7T/JWO7zs5JfPJ69KK1TSLXfRZztLM35IeFqnfYw0W7ndIsmXXbfXlYgyJcJa6/JV5FfIdhj+XxeavAbBesjCmBy4rPF6C6VSEoVakreAnTQsaRu0WX1yAdjHeWVKKd8610ZQqirK8EwEwqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768371372; c=relaxed/simple;
	bh=UvSCkCDkzow8qwTADBwA1wwYNxe0B8t1atfZ2xkipi8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mYlmtXJF3XJ3FmLA5JhHFsvlUxJynloLX8rtNbK5oSRGXsikUwjhR7AXFIAxnw9T6H6+a6bQhPL/F0OCv1aneGYr9ZyLFpm0YWoYbsArMB/T0DMH3bci69qhDBn/ycLuu9B/p/VE2yOlSRkhEg0BvwCcf3XWVxLCGh+O0DRFzVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2B9DE227A8E; Wed, 14 Jan 2026 07:16:00 +0100 (CET)
Date: Wed, 14 Jan 2026 07:15:59 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, cem@kernel.org,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 11/11] xfs: add media verification ioctl
Message-ID: <20260114061559.GA10613@lst.de>
References: <176826412644.3493441.536177954776056129.stgit@frogsfrogsfrogs> <176826412941.3493441.8359506127711497025.stgit@frogsfrogsfrogs> <20260113155701.GA3489@lst.de> <20260113232113.GD15551@frogsfrogsfrogs> <20260114060214.GA10372@lst.de> <20260114060705.GK15583@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114060705.GK15583@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Jan 13, 2026 at 10:07:05PM -0800, Darrick J. Wong wrote:
> > a tunable is a better choice here at least for now.
> 
> <nod> I'll set iosize to 1MB by default and userspace can decrease it if
> it so desires.
> 
> Also it occurs to me that max_hw_sectors_kb seems to be 128K for all of
> my consumer nvme devices, and the fancy Intel ones too.  Funny that the
> sata ssds set it to 4MB, but I guess capping at 128k is one way to
> reduce the command latency...?  (Or the kernel's broken?  I can't figure
> out how to get mpsmin with nvme-cli...)

mpsmin is basically always 4k.


On something unrelated:  SSDs remap all the time by definition, and
HDDs are really good at remapping bad sectors these days as well.
So verifying blocks that do not actually contain file system (meta)data
is pretty pointless.   Can we come up with a way to verify only blocks
that have valid data in them, while still being resonably sequential?
I.e. walk the rmap?

