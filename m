Return-Path: <linux-fsdevel+bounces-34791-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11EF99C8CCB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 15:25:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49B66B35080
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 14:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB9414A0B8;
	Thu, 14 Nov 2024 14:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sdfMH1Mj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3473BB48;
	Thu, 14 Nov 2024 14:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731593598; cv=none; b=oDtmcypywtFm4umpTvwX7G7+t+kVc/XJlvLrnHWkIopvt64YTrPW1G9ydnWUhXiRSpQz2r9xfOZBPG2vwllWXckhhYXThMRo08uPYXV1oz5j5SlmlabN/2jqLsH40KVJEfDwUHk/16pa+jfUHwBHa1ph3hLwjx1Xu64a0Mvys7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731593598; c=relaxed/simple;
	bh=Qeez2iGY+LdLYp8HN9KemZXLzOhM/Olnn7We9SGzw/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bMWkvyWO7Jpz1N2fVuq9Y0tURAYVK9qffdmgIHexgvjXYK8oXvtgFu4QAA0aLsmcNHDIP983mEO+6WoC/liNIArkKWcjzI0yD72Cve7Fsbel6SEospVUGsbImVOA3rbzXXWwAIqiD6JIu7FSE/Nw4o6s7TovE+j6aOxYHrV73T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sdfMH1Mj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30B32C4CECD;
	Thu, 14 Nov 2024 14:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731593597;
	bh=Qeez2iGY+LdLYp8HN9KemZXLzOhM/Olnn7We9SGzw/w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sdfMH1MjRsof8l8xsDqolaCNM8UF686k+3n65TrjLVjmkuoIh9ePPKElVEIbsp2Rl
	 bGuJL49Ej6/K2wyZj6LuoA9a4zYkRTPu9Lgb92S0zvlCWlO9/X8fjKik/mrseJ+WRA
	 +3pa4cWGbYrvQ7B5xVdb3w/SQdc1YE22KM4oACSt3Y/sgz8wFtsr0Hn01iYhGTVshx
	 AnUv8yHzcDe67WOljM2UmxF/GBsvNupLjQ8WDd1OpysGBHsB7zgtct+pp9ydWxO7XD
	 2GiB3tGH/E3oHten0HUva3JmPzhU0rbjiQOogCYG+CXKZIKw9cg/sKXLoQdB9+04t/
	 8YcSpw679tDzw==
Date: Thu, 14 Nov 2024 15:13:12 +0100
From: Christian Brauner <brauner@kernel.org>
To: Erin Shepherd <erin.shepherd@e43.eu>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Chuck Lever <chuck.lever@oracle.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 3/3] pidfs: implement file handle support
Message-ID: <20241114-monat-zehnkampf-2b1277d5252d@brauner>
References: <20241113-pidfs_fh-v2-0-9a4d28155a37@e43.eu>
 <20241113-pidfs_fh-v2-3-9a4d28155a37@e43.eu>
 <20241114-erhielten-mitziehen-68c7df0a2fa2@brauner>
 <1128f3cd-38de-43a0-981e-ec1485ec9e3b@e43.eu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1128f3cd-38de-43a0-981e-ec1485ec9e3b@e43.eu>

On Thu, Nov 14, 2024 at 02:13:06PM +0100, Erin Shepherd wrote:
> On 14/11/2024 13:52, Christian Brauner wrote:
> 
> > I think you need at least something like the following completely
> > untested draft on top:
> >
> > - the pidfs_finish_open_by_handle_at() is somewhat of a clutch to handle
> >   thread vs thread-group pidfds but it works.
> >
> > - In contrast to pidfd_open() that uses dentry_open() to create a pidfd
> >   open_by_handle_at() uses file_open_root(). That's overall fine but
> >   makes pidfds subject to security hooks which they aren't via
> >   pidfd_open(). It also necessitats pidfs_finish_open_by_handle_at().
> >   There's probably other solutions I'm not currently seeing.
> 
> These two concerns combined with the special flag make me wonder if pidfs
> is so much of a special snowflake we should just special case it up front
> and skip all of the shared handle decode logic?

Care to try a patch and see what it looks like?

> 
> > - The exportfs_decode_fh_raw() call that's used to decode the pidfd is
> >   passed vfs_dentry_acceptable() as acceptability callback. For pidfds
> >   we don't need any of that functionality and we don't need any of the
> >   disconnected dentry handling logic. So the easiest way to fix that is
> >   to rely on EXPORT_OP_UNRESTRICTED_OPEN to skip everything. That in
> >   turns means the only acceptability we have is the nop->fh_to_dentry()
> >   callback for pidfs.
> 
> With the current logic we go exportfs_decode_fh_raw(...) ->
> find_acceptable_alias(result) -> vfs_dentry_acceptable(context, result).
> vfs_dentry_acceptable immediately returns 1 if ctx->flags is 0, which will
> always be the case if EXPORT_OP_UNRESTRICTED_OPEN was set, so we immediately
> fall back out of the call tree and return result.
> 
> So I'm not 100% sure we actually need this special case but I'm not opposed.

Oh right, I completely forgot that find_acceptable_alias() is a no-op
for pidfs.

