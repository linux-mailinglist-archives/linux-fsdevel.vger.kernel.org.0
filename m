Return-Path: <linux-fsdevel+bounces-39663-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 058F9A16B7D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 12:23:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADF5D1886410
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 11:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F7EF1DF244;
	Mon, 20 Jan 2025 11:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aSDx9uLT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF83167DAC
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jan 2025 11:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737372229; cv=none; b=i5vq98ZHvZrcEOkPr/dCMr1r5gcGsdFaBbLf28ZlGgrEzP6qoxB1815EvFVOl5I+leAoCC2LFCKsoC8vtMMec3C6uGQIBwgriWFppgvNUWg5ibnbBlclzgD7WxCUyv4OR3Jxw5nMq5JhUkD7g1hAD04b8Md5cdyKo1sRH0wqLM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737372229; c=relaxed/simple;
	bh=lkFv5j59epXUjBKhPurfUdkX0qFim+3pG9W6WLlxq6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hf7ujhd0xHBEKJqAfIZDo2QQKDYJ+946TByyn81KoVg+/iUUbyyZGeu8R87jPPcHq3GPJG6RwsnhNuhT59jdByZDqLuNeyP1/M5wiu/xePFvf1nyv/gP+Sd3hPQlWHTlLDZKSYB6x5E/CrNQyCfxg/7qbJrgGorhHuiPsBMEd0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aSDx9uLT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96B20C4CEDD;
	Mon, 20 Jan 2025 11:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737372228;
	bh=lkFv5j59epXUjBKhPurfUdkX0qFim+3pG9W6WLlxq6U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aSDx9uLT0bYSEobux0MbvqmITxbiK4PNd68gj5iatTqHz0S+7RT8fLEKoIw8QBBtD
	 Mr+ZzVVwQC6Y6DZY7sbmTy8ap0U9wr6crhdx8OuQk6OSGDY7quHFBKjuQTkzTTt8om
	 nQkdQAl28zpV5OZq575J+4gtxDNNPFDIwHXykJGEeCVu+qGIqL6mHAvnYtQLKtOmXg
	 yH6RUmFIqxGQFkP5iitn9IVLwpNmsL3aSMnTdAej3CZiIsI8U0porNsyrAFNT3lVpG
	 v4TMfy9vhjHleLv/2/95hZY0sgogTrKjXmZ5FAf1vVPB5yxqJJVKF3xh5pnQ13SgDS
	 2J6tVXPznUt8g==
Date: Mon, 20 Jan 2025 12:23:44 +0100
From: Christian Brauner <brauner@kernel.org>
To: Eric Sandeen <sandeen@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, David Howells <dhowells@redhat.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: mount api: Q on behavior of mount_single vs. get_tree_single
Message-ID: <20250120-klappen-peitschen-824d2eb8b953@brauner>
References: <732c3de1-ef0b-49a9-b2c2-0c3c5e718a40@redhat.com>
 <20250116-erbeben-waren-2ad516da1343@brauner>
 <efb93d2c-c48f-4b72-b9fd-09151d2e74d6@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <efb93d2c-c48f-4b72-b9fd-09151d2e74d6@redhat.com>

On Thu, Jan 16, 2025 at 09:38:07AM -0600, Eric Sandeen wrote:
> On 1/16/25 4:28 AM, Christian Brauner wrote:
> > On Wed, Jan 15, 2025 at 10:50:31AM -0600, Eric Sandeen wrote:
> >> I was finally getting back to some more mount API conversions,
> >> and was looking at pstore, which I thought would be straightforward.
> >>
> >> I noticed that mount options weren't being accepted, and I'm fairly
> >> sure that this is because there's some internal or hidden mount of
> >> pstore, and mount is actually a remount due to it using a single
> >> superblock. (looks like it was some sort of clone mount done under
> > 
> > Yes, some legacy filesystems behave that way unforunately.
> 
> Is it not the case that every current (or past) user of mount_single
> behave[sd] this way due to the internals of mount_single()?
> 
> gadgetfs, configfs, debugfs, tracefs, efivars, openpromfs and more all
> currently call get_tree_single (and used to call mount_single, which did
> the reconfigure for them).
> 
> Or am I missing something?
> 
> ...
> 
> > I would think we should make this the filesystems problem or add a
> > get_tree_single_reconfigure() helper that the few filesystems that need
> > this behavior can use. Thoughts?
> 
> I wasn't seeing this as individual filesystems needing it, it looked to
> me like every filesystem that used to call mount_single() automatically
> got the behavior. So was looking at this from a consistency/regression
> POV.
> 
> While it seems odd to me that mounting any "_single" sb filesystem would
> reconfigure all of its current mounts on a new mount, that's the way it
> used to work for everyone, as far as I can tell, so I was assuming that
> we'd need to keep the behavior. But if it's a question of just fixing it
> up per-filesystem, I don't mind going that route either.

So far it hasn't lead to any regressions and we had the new behavior for
quite a while.

