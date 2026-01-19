Return-Path: <linux-fsdevel+bounces-74424-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 14023D3A327
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 10:37:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 056553008734
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 09:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 112C7352FA0;
	Mon, 19 Jan 2026 09:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SznYM39M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8385D33A715;
	Mon, 19 Jan 2026 09:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768815469; cv=none; b=SHoEf2vQv1aR6fxBv56rmQg1Ng3UpwwXqDwGnQKY02d4/wnt6t32kFP5IqrMqElFI/SM5+jO0vqPTPOXFtSd8umSrm+lsEfAiB7VPFXy2CLkT+pnVVhLuW/8B2yBF65v0fzjC+6+qMYBvcq1U5rYCYYRowT7pQbBQC+2blZHPQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768815469; c=relaxed/simple;
	bh=RBf2VbnimtIf34RceomGgms6yWFk5LJNOn2qSQZujus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qC6y+NHx+yySXjg5TIYUNkEm7ov0wUcVmv9jVgFEmldo/pSTUmOgpLPT7Hv08DW3PMowV9hCIyDLbNhXBpNN6+aHB80Q1gRQf8v8A3mA2V6seXqIsLm/QXOMKCbjjzZvB0Fpfg6xYnqseRQi0rL+/byyfyTW6buXIGVEusKSaao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SznYM39M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED57CC116C6;
	Mon, 19 Jan 2026 09:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768815469;
	bh=RBf2VbnimtIf34RceomGgms6yWFk5LJNOn2qSQZujus=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SznYM39MkbNuPjE6GgyD2JDTC4+48wgplvb8cx+6psn4rh7Y1aesUKbwOwZQTFpkN
	 HSPlYMd1MuzFdC8gdjQDs2O8APVXPZAi2LdWc9mBoYWJVC6OQU0MPBX1tYx4Q5ym/i
	 PFjf8YRuS3iXWHT+TbxabZ5il8ocO56LvnPHDsmqncWz6/o7GG+7Quyl6uEJrgoIUs
	 HypWSK9Au2tf21pmlRpqPXdqvdHU6Mz2xPl+CBSOil9rNeI1Lf7CXMEwxnljxWO7JT
	 Nzs5gkzPQsHSntoMuq30y8sjPR9EOXA+qopE3oe8T504I/Owgv7GJnRqz8j67kX5R9
	 UhAzhi2xIS+sQ==
Date: Mon, 19 Jan 2026 10:37:43 +0100
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Eric Biggers <ebiggers@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, David Sterba <dsterba@suse.com>, Theodore Ts'o <tytso@mit.edu>, 
	Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>, 
	Andrey Albershteyn <aalbersh@redhat.com>, linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, fsverity@lists.linux.dev
Subject: Re: fsverity optimzations and speedups
Message-ID: <20260119-nordhalbkugel-filmabend-7c76091f3a7c@brauner>
References: <20260119062250.3998674-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260119062250.3998674-1-hch@lst.de>

On Mon, Jan 19, 2026 at 07:22:41AM +0100, Christoph Hellwig wrote:
> Hi all,
> 
> this series has a hodge podge of fsverity enhances that I looked into as
> part of the review of the xfs fsverity support series.
> 
> The first three patches call fsverity code from VFS code instead of
> requiring a lot of boilerplate in the file systems.  The first fixes a

While I'm not super excited about that I can see that it's beneficial.

