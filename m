Return-Path: <linux-fsdevel+bounces-49119-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B67AB838F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 12:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6E0C9E26E9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 10:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB19B296D27;
	Thu, 15 May 2025 10:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HypVaWrf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D8A284662
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 May 2025 10:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747303847; cv=none; b=s6O7/UPkDj/mKIEoPfGoaUeqwbGQ33diBzXCEtC6ddIvubsdm2YKcawBqkfngieb1AN4yExpAhdN0XHNdxeUC9WoiQsetn+EwV6bFyNjewxXAfr/MCXpZKXl7TOS78kIpO25CWbvEmKU0QA3PG3nBQdzsO8yPra3H1587/AuxDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747303847; c=relaxed/simple;
	bh=lhCMy40KVFVLYdDDCZZP5FPfRzSS1dGQ3/gaEcXz5sI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VL1VxK5MfY0F8P3hFVdslan3DFZeSyvjBnU6Wl9qLBba/Rl+b+8KiYK0CZVBM54cO8C3BZq/Jl6fWnaNhehMmEx1l7JZYu/j8FPo5qlL8XAT5MCcabFtb5D88vnNsEgVI7++/l//hd8Kw5h6JnxMPd24CT7oFY5c+93xdwQq/TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HypVaWrf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68CE0C4CEE7;
	Thu, 15 May 2025 10:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747303846;
	bh=lhCMy40KVFVLYdDDCZZP5FPfRzSS1dGQ3/gaEcXz5sI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HypVaWrfmhF2MQzAqudMK61t5Q4bbC8JLwp4DIkCCDtPfRUh0kTrISn+4f/F2tOm+
	 IGseZtKts5imleNUFhd2hZmFMqfP4FH4/+Bv3KcLhbiJdZbnZV56eAhGAwad79DSn1
	 w4Bbv8PY+J4YWYcNB92J1Brew9l8inawQ9Vjx9/5Ah9kgOgZYyFbLVpx3EkIXSa5bC
	 CMC+ljp7bSTZTOdvi56EHg153I7EcAn+1QKPNjrpcgFkpRqy52Ofi2y0JanCOcwu9j
	 SSEdOm684QyRzhd60eIuOd9zlfuyL+sF8jjzn4Ci1IbS20vsFhGHydoFBeh5mjrxHn
	 hnruu13OQbD7g==
Date: Thu, 15 May 2025 12:10:43 +0200
From: Christian Brauner <brauner@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Allison Karlitskaya <allison.karlitskaya@redhat.com>, 
	linux-fsdevel@vger.kernel.org, lis@redhat.com
Subject: Re: [PATCH] fuse: add max_stack_depth to fuse_init_in
Message-ID: <20250515-dunkel-rochen-ad18a3423840@brauner>
References: <CAJfpegtdy7BYUpt795vGKFDHfRpyPVhqrL=gbQzauTvNawrZyw@mail.gmail.com>
 <20250514121415.2116216-1-allison.karlitskaya@redhat.com>
 <CAJfpegtS3HLCOywFYuJ7HLPVKaSu7i6pQv-GhKQ=PK3JAiz+JQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJfpegtS3HLCOywFYuJ7HLPVKaSu7i6pQv-GhKQ=PK3JAiz+JQ@mail.gmail.com>

On Thu, May 15, 2025 at 10:42:30AM +0200, Miklos Szeredi wrote:
> On Wed, 14 May 2025 at 14:14, Allison Karlitskaya
> <allison.karlitskaya@redhat.com> wrote:
> > Use one of the unused fields in fuse_init_in to add a max_stack_depth
> > uint32_t (matching the max_stack_depth uint32_t in fuse_init_out).
> 
> This is not a fuse-only thing.
> 
> What about making it a read-only sysctl attribute? E.g.
> /proc/sys/fs/max-stack-depth.

Before making this a kernel wide sysctl attribute we should have actual
users that need more than two right now. IIUC, then making this an
attribute in FUSE will happen at some point anyway. For example, if
userspace wants to have a FUSE specific stacking limit that's different
from the global limit.

