Return-Path: <linux-fsdevel+bounces-44585-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F38A6A7EA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 15:07:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35B6017F1B1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 14:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EC061DF26A;
	Thu, 20 Mar 2025 14:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qckZgwbG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A764223327;
	Thu, 20 Mar 2025 14:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742479449; cv=none; b=D/MxOGHAY5x/6zXggDHLfwZJyXt/7gH8oJLCVWMi1leit4sZHAcW9nZtx0mHyJg6oIoewXvIxd36AdjEu/Nvd/LLfdZNgGDL1nHfbzWFmgQH3CCAxY8094NQlj68iasqFnwH7WhyrXt5zDfGYeud1rNsxoR3kMLWi2ZDJf0Rzss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742479449; c=relaxed/simple;
	bh=KdGTcau9+SJS9CSWGq7TBl9V6nm+hHWTO0B1pT3se2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ErLLaK1deXUfa0d+BQ+sIEkpR5UhcOkXknAuGgC4dde3K9bNKeuapectR5YwE99NgbCDvtJDIhcyzlPwImRcqnhxaAUYkQeHlZQfKAff9FHGsRyxznW4/ThlTk2HLoJa0vN62mc204vg6V5Dp1RSSyI7VvdmSdb0pVGSQasllWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qckZgwbG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F834C4CEDD;
	Thu, 20 Mar 2025 14:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742479448;
	bh=KdGTcau9+SJS9CSWGq7TBl9V6nm+hHWTO0B1pT3se2U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qckZgwbGBfIFsYC5+kKyLRkgRuuc8erSc0QgWpImdT3j9VH22JqEkbTw1IvMeDI9p
	 nJOyFgIxtO9pj9vAyAA1elKUL+XTX+YTcUEG/qZi9+uONQaRVS1mtf8zWfIG7gvAuU
	 DLukU/Jqms9kr4xzWU8UGmm/UpKk0peJHKF6evDiPV81wAgoxiVAaurcB0iobFKAiV
	 RoayGOCgJIoURhsQVYM49TXI43dkd9qmzrzZeYMSa9H/oWXag8K+sShv9r0ckp0EvP
	 DNw0oxeszERyUhz3FPtt/BqYGF5ZIremgkaR+Z2Xwr44Rs9v6XrV8mM/LNwF0LbMBg
	 s51a44cd2PVTQ==
Date: Thu, 20 Mar 2025 15:04:04 +0100
From: Christian Brauner <brauner@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Chuck Lever <chuck.lever@oracle.com>, 
	linux-nfs@vger.kernel.org, netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/6] cachefiles: Use lookup_one() rather than
 lookup_one_len()
Message-ID: <20250320-dreck-landzunge-1d090b52153a@brauner>
References: <20250320-goldbarren-brauhaus-6d6ff0a7be72@brauner>
 <20250319031545.2999807-1-neil@brown.name>
 <20250319031545.2999807-4-neil@brown.name>
 <ee36dab38583d28205c4b40a87126c44cab69dc9.camel@kernel.org>
 <3170280.1742478565@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3170280.1742478565@warthog.procyon.org.uk>

On Thu, Mar 20, 2025 at 01:49:25PM +0000, David Howells wrote:
> Christian Brauner <brauner@kernel.org> wrote:
> 
> > > > It also uses the lookup_one_len() family of functions which implicitly
> > > > use &nop_mnt_idmap.  This mixture of implicit and explicit could be
> > > > confusing.  When we eventually update cachefiles to support idmap mounts
> > > > it
> > > 
> > > Is that something we ever plan to do?
> > 
> > It should be pretty easy to do. I just didn't see a reason to do it yet.
> > 
> > Fwiw, the cache paths that cachefiles uses aren't private mounts like
> > overlayfs does it, i.e., cachefiles doesn't do clone_private_mount() before
> > stashing cache->mnt. ...
> 
> This is probably something cachefilesd needs to do in userspace before telling
> the kernel through /dev/cachefiles where to find the cache.

Afaict, I don't think it matters whether the mount is actually attached
to a mount namespace so cachefilesd could just do:

fd_tree = open_tree(AT_FDCWD, "/path/to/cache", AT_EMPTY_PATH | OPEN_TREE_CLONE);

and use the detached mount for all cachefilesd interactions.

