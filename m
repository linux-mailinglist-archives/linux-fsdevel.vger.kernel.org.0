Return-Path: <linux-fsdevel+bounces-32473-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB08B9A6862
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 14:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C63F1C2270E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 12:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3431EBFE1;
	Mon, 21 Oct 2024 12:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UzyRfExx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EA81E7C32;
	Mon, 21 Oct 2024 12:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729513633; cv=none; b=JYREsL4RxaZBbDMbDHh+1kcMIBDjUL5GQXI3draXqgAcWmM5Trv9xpo9t9XnpN9WcfArAv3Dmvl4q3QE9megfCZ4Z8hz4D/8PtDYL/MjiH267AC8FNj3Ata2NMWjo97ujuOMZbjafkx5mC3M4ecBd+banY4Rd4UPThF+Sf4jiwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729513633; c=relaxed/simple;
	bh=kYjiKbopU3nHCtbQJu6rvBASdvuKeELUFFKYISpb/sQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gFJ2yMMPzt9eZsXnx0NIsOdZxBk5Qx8fZzWlb2X7L7Rpojrjt5QXmCB6Pqg0D5JfLC9UE0h4CSSmpYB0XnNctyTMDfDyiYI77SOio16mUnHmgTLFqx1M6+r2G+RrgmDe//m8vz8cdM6t8bzgca1h5+EXTJHLKbPK6cEEhoQ/olM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UzyRfExx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34FCCC4CEC3;
	Mon, 21 Oct 2024 12:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729513632;
	bh=kYjiKbopU3nHCtbQJu6rvBASdvuKeELUFFKYISpb/sQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UzyRfExx3I0AZj3W96QbCWdo+ZGE2EjZ8RlagAj7q+gzmFRpr7587s5qGTcTc1vLF
	 w+Y4Xkw4dWz9a0v9moVieSSsVe8gAtZtp5Istt76SlYVdntv9iH7ffR5XJMMs1mBYI
	 02X7TCA2HhqdjHJelBwHcGzqUke+V7oUHRUCFlU2/BU+Cz1DdjKIYApBo9yR017Wgv
	 duMFtTfLw8ZGEOCA+sJX8kWpUQHoP+R5RrH/CHwzrlavPFR7AWxxnTCOZZkYAvkOad
	 bwfdzj8CsLUEWzbRT7E9MdwrGE38aOHK0Pt8XwttpveHlLXtD+zTIUMHqleSU4k3hJ
	 CVQRhVIRHAa9w==
Date: Mon, 21 Oct 2024 14:27:07 +0200
From: Christian Brauner <brauner@kernel.org>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Gao Xiang <xiang@kernel.org>, 
	Allison Karlitskaya <allison.karlitskaya@redhat.com>, Chao Yu <chao@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 1/2] fs/super.c: introduce get_tree_bdev_flags()
Message-ID: <20241021-geldverlust-rostig-adbb4182d669@brauner>
References: <20241009033151.2334888-1-hsiangkao@linux.alibaba.com>
 <20241010-bauordnung-keramik-eb5d35f6eb28@brauner>
 <ab1a99aa-4732-4df6-97c0-e06cca2527e3@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ab1a99aa-4732-4df6-97c0-e06cca2527e3@linux.alibaba.com>

On Mon, Oct 21, 2024 at 03:54:12PM +0800, Gao Xiang wrote:
> Hi Christian,
> 
> On 2024/10/10 17:48, Christian Brauner wrote:
> > On Wed, 09 Oct 2024 11:31:50 +0800, Gao Xiang wrote:
> > > As Allison reported [1], currently get_tree_bdev() will store
> > > "Can't lookup blockdev" error message.  Although it makes sense for
> > > pure bdev-based fses, this message may mislead users who try to use
> > > EROFS file-backed mounts since get_tree_nodev() is used as a fallback
> > > then.
> > > 
> > > Add get_tree_bdev_flags() to specify extensible flags [2] and
> > > GET_TREE_BDEV_QUIET_LOOKUP to silence "Can't lookup blockdev" message
> > > since it's misleading to EROFS file-backed mounts now.
> > > 
> > > [...]
> > 
> > Applied to the vfs.misc branch of the vfs/vfs.git tree.
> > Patches in the vfs.misc branch should appear in linux-next soon.
> > 
> > Please report any outstanding bugs that were missed during review in a
> > new review to the original patch series allowing us to drop it.
> > 
> > It's encouraged to provide Acked-bys and Reviewed-bys even though the
> > patch has now been applied. If possible patch trailers will be updated.
> > 
> > Note that commit hashes shown below are subject to change due to rebase,
> > trailer updates or similar. If in doubt, please check the listed branch.
> > 
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> > branch: vfs.misc
> > 
> > [1/2] fs/super.c: introduce get_tree_bdev_flags()
> >        https://git.kernel.org/vfs/vfs/c/f54acb32dff2
> > [2/2] erofs: use get_tree_bdev_flags() to avoid misleading messages
> >        https://git.kernel.org/vfs/vfs/c/83e6e973d9c9
> 
> Anyway, I'm not sure what's your thoughts about this, so I try to
> write an email again.
> 
> As Allison suggested in the email [1], "..so probably it should get
> fixed before the final release.".  Although I'm pretty fine to leave
> it in "vfs.misc" for the next merge window (6.13) instead, it could
> cause an unnecessary backport to the stable kernel.

Oh, the file changes have been merged during the v6.12 merge window?
Sorry, that wasn't clear.

Well, this is a bit annoying but yes, we can get that fixed upstream
then. I'll move it to vfs.fixes...

