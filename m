Return-Path: <linux-fsdevel+bounces-63748-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC15BCCB48
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 13:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 47BCE354FEC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 11:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E61D02ED871;
	Fri, 10 Oct 2025 11:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TwTZOHo9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E87924634F
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Oct 2025 11:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760094637; cv=none; b=KRw+8IHgKW0yDLTlmONXfHgLzQzVzfyRjVckRVWESf3K4MixUK8jo5p3qEJ4VJDsH3BVdwvrL20r3gpf6gpDw27QmIgMN4cezwrrOC+PNsbvbBGDHjiPk+UlkuiKdoR/mk/YlJzZv5ul5loTTbJV7JvE5qHWwpewNqHVwSdXalE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760094637; c=relaxed/simple;
	bh=hwZvcAEA6/MygklFTkZ3bC3eMVB5ZRKVUCLqtzjx7Eo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uJMqmNHkv9dzXMGBSmHq7BrATNFLy8l8Ssv7k5vEfDMq91axxcOynRw0KFyCz9bpSBFcoPYC+B9K9Frlpns4O+RtXhmCLQpQJQzH0dZYBNdxj6ROCvwl2D7+t+b801Mlj+mbjViJETr3zNWcnJvzJL9YPwExDFpALj4m8tSM2l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TwTZOHo9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF1F3C4CEF1;
	Fri, 10 Oct 2025 11:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760094636;
	bh=hwZvcAEA6/MygklFTkZ3bC3eMVB5ZRKVUCLqtzjx7Eo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TwTZOHo9ZTKzWil/g4jixMWYRGh33ELeGvoWgYu6Xd5NcFHUaeBhvbYIInvTkq1ot
	 kqGjAWpxmtSrkgK+jYmbI5ZtcSXUebwJAOQ2TcVFd/7ouxfPhJ8wGV2bagC0ROFBts
	 kCFHVf5AwJKrC0YkZzKJvsIZnGWyCsvH+HtZuhcsJW82RJjnhirW9q2A8EV/NPB/99
	 G8139etWMsg6OC5QeRsamfwlOwYU8IVK2vd36ALBMJoVz5rFUenKIEtgmQwXuzBt/S
	 IRcgt7Gp0FRvrdxVv4Aj3VC1fQWXka4druhYaDrWwyLhyaq5spXLbbZlUXymIVjYLN
	 mncs4+GwjPkAg==
Date: Fri, 10 Oct 2025 13:10:33 +0200
From: Christian Brauner <brauner@kernel.org>
To: Julian Sun <sunjunchao@bytedance.com>
Cc: linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, 
	Jan Kara <jack@suse.cz>
Subject: Re: (subset) [PATCH v3 1/2] writeback: Wake up waiting tasks when
 finishing the writeback of a chunk.
Message-ID: <20251010-kreide-salzkartoffel-b2c718b7f708@brauner>
References: <20250930065637.1876707-1-sunjunchao@bytedance.com>
 <20251006-zenit-ozonwerte-32bf073c7a02@brauner>
 <CAHSKhte2naFFF+xDFQt=jQ+S-HaNQ_s7wBkxjaO+QwKmnmqVgg@mail.gmail.com>
 <CAHSKhtckJwprCQapkg-AKaz-X_gjX7n_5+LzE8G7iZ0VzHCU3Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHSKhtckJwprCQapkg-AKaz-X_gjX7n_5+LzE8G7iZ0VzHCU3Q@mail.gmail.com>

On Tue, Oct 07, 2025 at 10:37:39PM +0800, Julian Sun wrote:
> Kindly ping..

Please check vfs-6.19.writeback again.

Your patch numbering is broken btw. This should've been v4 with both
patches resent. This confuses the tooling and reviewers. ;)

> 
> On Mon, Oct 6, 2025 at 10:29 PM Julian Sun <sunjunchao@bytedance.com> wrote:
> >
> > Hi Christian,
> >
> > It looks like an earlier version of my patch was merged, which may
> > cause a null pointer dereference issue. The latest and correct version
> > can be found here:
> > https://lore.kernel.org/linux-fsdevel/20250930085315.2039852-1-sunjunchao@bytedance.com/.
> >
> > Sorry for the confusion, and thank you for your time and help!
> >
> > Best,
> >
> >
> > On Mon, Oct 6, 2025 at 6:44 PM Christian Brauner <brauner@kernel.org> wrote:
> > >
> > > On Tue, 30 Sep 2025 14:56:36 +0800, Julian Sun wrote:
> > > > Writing back a large number of pages can take a lots of time.
> > > > This issue is exacerbated when the underlying device is slow or
> > > > subject to block layer rate limiting, which in turn triggers
> > > > unexpected hung task warnings.
> > > >
> > > > We can trigger a wake-up once a chunk has been written back and the
> > > > waiting time for writeback exceeds half of
> > > > sysctl_hung_task_timeout_secs.
> > > > This action allows the hung task detector to be aware of the writeback
> > > > progress, thereby eliminating these unexpected hung task warnings.
> > > >
> > > > [...]
> > >
> > > Applied to the vfs-6.19.writeback branch of the vfs/vfs.git tree.
> > > Patches in the vfs-6.19.writeback branch should appear in linux-next soon.
> > >
> > > Please report any outstanding bugs that were missed during review in a
> > > new review to the original patch series allowing us to drop it.
> > >
> > > It's encouraged to provide Acked-bys and Reviewed-bys even though the
> > > patch has now been applied. If possible patch trailers will be updated.
> > >
> > > Note that commit hashes shown below are subject to change due to rebase,
> > > trailer updates or similar. If in doubt, please check the listed branch.
> > >
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> > > branch: vfs-6.19.writeback
> > >
> > > [1/2] writeback: Wake up waiting tasks when finishing the writeback of a chunk.
> > >       https://git.kernel.org/vfs/vfs/c/334b83b3ed81
> >
> >
> >
> > --
> > Julian Sun <sunjunchao@bytedance.com>
> 
> 
> 
> -- 
> Julian Sun <sunjunchao@bytedance.com>

