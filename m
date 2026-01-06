Return-Path: <linux-fsdevel+bounces-72526-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C2E6CF97A5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 06 Jan 2026 17:56:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A51CA30BCA91
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jan 2026 16:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC7C338934;
	Tue,  6 Jan 2026 16:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NyknMNPa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1F93019D9;
	Tue,  6 Jan 2026 16:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767717752; cv=none; b=CJc0DMeeG/fCE6B4GDzMbjemes68mnVAiNAvR2kr8qHn5juUPDpg6NhFm/Fkq7OJ4+N9XvK7NMtsyAuPVGaUTUSNInu6gfW/pLixEO0hvmoxdnsuoSSJ/7ORRiOY2DVcrZbSSHH+jtgTApBQXhIJLSRJaInMbKmDeSDvVCigem4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767717752; c=relaxed/simple;
	bh=b5o72TRYISPGDuDnS+vuJOBZZyttfZi3PN40F0MwqRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qtVh+JNZuxu7U1j5HVhKtBcctEi9ww89W4Jvs/miBWByxuSbv2nYP4abRCdHWjsZw07/CM8lIGY2iGOUutXPKBfVzgfuZkfnqL4I649urqCUIuuJm8EiC9p1sHLB9wlQX4r/0JK9iH7vlni7Ql35y9Lf4guzwdnVm7GWpfONuUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NyknMNPa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 914C6C116C6;
	Tue,  6 Jan 2026 16:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767717751;
	bh=b5o72TRYISPGDuDnS+vuJOBZZyttfZi3PN40F0MwqRk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NyknMNPawu2M36n7+lO6hUq2iSoRtU4pGLWDuJh3a20q6YdThOxVPJfnOS++YmQ3S
	 tDknihvO3d3jFbyvteUW+tVjD12uQQ/VCzWtW12qWbO95AfoezWyLJ39Fk9KV+Y0cx
	 GPpypIxKFul/a058OgaIGXG7SuTDh//2y9uN3eoMnVDc6mEhnapwWqYqZlpB+p6+pv
	 /meEk93/mu1B5rz3ZeYWhtunHICtR5E4tFXyOgjPfHTQbkobdyQBfcs2T+Fc6MNd/K
	 NkSEyXSxX6OmaducYiob4re5Ix4+YnPCyXP3IqUovPoF20vLVJTcfH6LLc4R3Ipu20
	 cZVFDpRoUCpng==
Date: Tue, 6 Jan 2026 08:42:30 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, linux-ext4@vger.kernel.org,
	jack@suse.cz, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, gabriel@krisman.be,
	amir73il@gmail.com
Subject: Re: [PATCH 2/6] fs: report filesystem and file I/O errors to fsnotify
Message-ID: <20260106164230.GH191501@frogsfrogsfrogs>
References: <176602332085.686273.7564676516217176769.stgit@frogsfrogsfrogs>
 <176602332171.686273.14690243193639006055.stgit@frogsfrogsfrogs>
 <aUOPcNNR1oAxa1hC@infradead.org>
 <20251218184429.GX7725@frogsfrogsfrogs>
 <20251224-nippen-ganoven-fc2db4d34d9f@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251224-nippen-ganoven-fc2db4d34d9f@brauner>

On Wed, Dec 24, 2025 at 01:29:21PM +0100, Christian Brauner wrote:
> > Nope.  Fixed.
> 
> I've pulled this from the provided branch which already contains the
> mentioned fixes. It now lives in vfs-7.0.fserror. As an aside, the
> numbering for this patch series was very odd which tripped b4 so I
> applied it with manual massaging. Let me know if there are any issues. 

Thank you!  But, uh... do you want me to fix the things that hch and jan
mentioned?  Or have you already fixed them?  I don't see a
vfs-7.0.fserror branch on the vfs tree[1]...

[1] https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/refs/heads

--D

