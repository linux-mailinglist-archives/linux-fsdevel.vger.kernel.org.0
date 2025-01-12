Return-Path: <linux-fsdevel+bounces-38985-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F9C1A0A8DE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Jan 2025 12:59:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52EF216519D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Jan 2025 11:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFBED1B0422;
	Sun, 12 Jan 2025 11:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="G33HwEm+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84BF51ACEAC;
	Sun, 12 Jan 2025 11:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736683139; cv=none; b=GTinc5ZqGl4NG3gFiLLw0ZAkKVLEfnpqAj1cxjEK2E8wis8No2E6/SMm99RS5d/8uJrjpcXU2WTSYktpm0ZNQltT90PRF2kiWk7xpQV8nZmqHyUxHqa9GRH6f4YlQeztgdb7VkYXgsegVLrbbxotVOAqUj+x/bvbv2bCKLu2OnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736683139; c=relaxed/simple;
	bh=BPruqB40aMj8gIc7Va/pLZ0tMSTE4p+LwA24k9SiqtM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fZvOESo6W/CQuHwb3sOFsEVePaLItin1wk3Va5k8HgpOKJT+cQO+hZWL+utl9pHTMCaX6RdCvMMyU6EUvcPTK3jeEFS5sX6iT9vJdYjVJ7BtCcSIAwxtO/SH49QUsSdn6rEvzq26A4ba3Gpcj1wqyekjy7FQ/UfNbGLMRpMAMoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=G33HwEm+; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=tnSwMGjdQE1yO4UEe5Lapm1V7aPPSrWMgUE1eOWu6Kk=; b=G33HwEm+CjHq9AvFm2JrGXM80T
	3ZbbOD3+0vXk3eJ30CfR7TyI0RLmXGYL0zg/hpyclbXzDDRO9IApsRs6eUjN5EgBXR9TNUq9mCY4G
	F1xC00GPNmLA/XJYrslwHleyXP7b4mSKnX0qtx1vPD6WTAkqly1e72moj+2I5e+K7ys/Gm58+brpu
	0xxu7BXNRCQO2QfV4CCNc+tKQNbMbwB5Rju+32kEkMkqN9ltozd5zO+yGw2e/uE2mYtkZVyW3AKu6
	gf0ku9hzm3GVPE9bWMTDOirAgFPRifF8smDrWeY5LYWD+0KFmd9xjnYOPRbIQUTKhLG9DsbGg4X7x
	VrJCWO0g==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tWwcI-0000000GVX8-0IfB;
	Sun, 12 Jan 2025 11:58:54 +0000
Date: Sun, 12 Jan 2025 11:58:53 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Theodore Ts'o <tytso@mit.edu>
Cc: "Artem S. Tashkinov" <aros@gmx.com>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: Spooling large metadata updates / Proposal for a new API/feature
 in the Linux Kernel (VFS/Filesystems):
Message-ID: <Z4OufXVYupmI8yuN@casper.infradead.org>
References: <ba4f3df5-027b-405e-8e6e-a3630f7eef93@gmx.com>
 <20250112052743.GH1323402@mit.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250112052743.GH1323402@mit.edu>

On Sun, Jan 12, 2025 at 12:27:43AM -0500, Theodore Ts'o wrote:
> So yes, it basically exists, although in practice, it doesn't work as
> well as you might think, because of the need to read potentially a
> large number of the metdata blocks.  But for example, if you make sure
> that all of the inode information is already cached, e.g.:
> 
>    ls -lR /path/to/large/tree > /dev/null
> 
> Then the operation to do a bulk update will be fast:
> 
>   time chown -R root:root /path/to/large/tree
> 
> This demonstrates that the bottleneck tends to be *reading* the
> metdata blocks, not *writing* the metadata blocks.

So if we presented more of the operations to the kernel at once, it
could pipeline the reading of the metadata, providing a user-visible
win.

However, I don't know that we need a new user API to do it.  This is
something that could be done in the "rm" tool; it has the information
it needs, and it's better to put heuristics like "how far to read ahead"
in userspace than the kernel.

