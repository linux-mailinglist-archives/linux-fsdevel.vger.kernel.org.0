Return-Path: <linux-fsdevel+bounces-9807-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68AD0845158
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 07:18:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06B8C1F2BC13
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 06:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC0CD83CDC;
	Thu,  1 Feb 2024 06:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dwybIUqw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E7862A00;
	Thu,  1 Feb 2024 06:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706768317; cv=none; b=c3zPVO//Sh/uX/AVXwjL5Wpj5wuFPtkZ7YPyCRmLrrLIwcKqU06h/DtebPJllr8HE/EXw6+o49UEM2k/RzJcKkR2gFw7E/MSI91pg2BQxeqEk724Q7LIE+jFDeJz6WxxG+GcSVjlcYzOL2iUTWGyc1vWQn0gvbJ9VjEYvPX1kpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706768317; c=relaxed/simple;
	bh=7lPao0EeRa+duvgbDVDws3GUnXCSHK1RnAbhNYvktCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o/fxHWArZfypfMdGry6AXo3b6xDHvFGaUQoWcjEjzQk3BxBHEFK8oCd6+N3zgLW7SMvTEKfp5d0dT1SCSK+HuNF+LQGB5tovMP2OYW/RDxzvWFOaPExd4rfvfwrsmPQPypp5LCnEd3Mm5UIFzrNozDOyX6xAMVjx/f+s+vaQois=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dwybIUqw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75E67C433C7;
	Thu,  1 Feb 2024 06:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706768316;
	bh=7lPao0EeRa+duvgbDVDws3GUnXCSHK1RnAbhNYvktCI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dwybIUqwU91BDczF5jGT4+MDO6CDJMTOX971ulyo41C6c440zNVnQHXrRD8zkZ95M
	 eTRw2WdYohn0o2uHYhpCjRpaPDL4reUWqCHqgSX9vLCrxgJYVs6LSpgqKvYkeiIRgh
	 0E6LH+cnlVT/lLPzAbYEYNQ2bDPgz9vFNGGy++FfAkuBK7OBdjctPF8laagoLW5wZV
	 AyGTafKkgFRhmMXceJ3ixulghuVKME2MmAWEgHs2hhL8wYK3VBOj2ueN1yiaimKbsx
	 NelTzcGV+fZPSts5Fjq2bLnTWZFh6HbOGVBK9I+6djjplAjQOxnUalG1R6Rtws9Aef
	 4DqyU6XY+9YWQ==
Date: Wed, 31 Jan 2024 22:18:35 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>,
	Chandan Babu R <chandan.babu@oracle.com>,
	Zhang Yi <yi.zhang@huaweicloud.com>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Jens Axboe <axboe@kernel.dk>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <jth@kernel.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	gfs2@lists.linux.dev
Subject: Re: map multiple blocks per ->map_blocks in iomap writeback
Message-ID: <20240201061835.GC616564@frogsfrogsfrogs>
References: <20231207072710.176093-1-hch@lst.de>
 <20231211-listen-ehrbaren-105219c9ab09@brauner>
 <20240201060716.GA15869@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201060716.GA15869@lst.de>

On Thu, Feb 01, 2024 at 07:07:16AM +0100, Christoph Hellwig wrote:
> On Mon, Dec 11, 2023 at 11:45:38AM +0100, Christian Brauner wrote:
> > Applied to the vfs.iomap branch of the vfs/vfs.git tree.
> > Patches in the vfs.iomap branch should appear in linux-next soon.
> 
> So it seems like this didn't make it to Linus for the 6.8 cycle, and
> also doesn't appear in current linux-next.  Was that an oversight
> or did I miss something?

Speaking solely for myself, I got covid like 2 days before you sent this
and didn't get my brain back from the cleaners until ~2.5 weeks after.
I totally forgot that any of this was going on. :(

--D

