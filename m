Return-Path: <linux-fsdevel+bounces-27978-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2977696572D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 07:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAE49B23AE6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 05:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0381531CB;
	Fri, 30 Aug 2024 05:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JitC6YoQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBCF1509BF;
	Fri, 30 Aug 2024 05:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724997396; cv=none; b=SDi1rV/cB7rdVz+SULPrB6l2ODBxxEV+nRdGXAI08r9HICE8ypTFevTybt77ARLILb8cZIIAgY3IGeRd/nVg7OtKbdHqiIy/QIDj2Hrd2Z1MQJmNghsXY3DzzTxwVOY6oCmDtWPehQr0EFqXyAv16DLrqyow2zrMnf10v49y/X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724997396; c=relaxed/simple;
	bh=k+NZDgzSu0cZNTsLS/z3ZKDbCNdSt6hFMai1qhKLkbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V7E2hKNc9oPdkkSLCkv5a+VeGFYkgurNJDGARIhPuXmxeTf8/9TsgjwOf2l38/+6laKDc/6QtbWpK30xAnkSHEs9a1eRnuOKeqwHB/SB+WJPxNX+c74DTTIchv/EGvYBI6ie8CToZA29Duyv4LdO9D0hqI/9VeNaFf0W5aPDmCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JitC6YoQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27D9CC4CEC4;
	Fri, 30 Aug 2024 05:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724997395;
	bh=k+NZDgzSu0cZNTsLS/z3ZKDbCNdSt6hFMai1qhKLkbc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JitC6YoQMssWpRrnSH+oe4iYVzqEqPk/8Xsps7iVv6EmM70mXNtYN4SvbFV4XESQv
	 BEARbPjYgxviLb5msYbuza+O/ByMkjfOx4Nv4R/EnTgjenf+dYoK+hfBK2x9DHbdEe
	 DGLimLQsASxhNB2IC0HK3jm0GpgdudhPvbZKxlJTklxMwV7BLYrHuHkLJBwp18zNul
	 Ri+/W7SqkXJNOH8YsDTBIMkCJmvFH6h7ebRBX0bcUJ4L6nQncnnjg5wx5+rRVNlqYX
	 RPpvR6o8fh0TiP7Rf7j2fnDKSEJ+s1SdvFpxoMXwcy8snePGafgUOqdAeMklB6vE6Z
	 HIarfeVAHtNCQ==
Date: Fri, 30 Aug 2024 01:56:34 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: NeilBrown <neilb@suse.de>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v14 15/25] nfs_common: introduce nfs_localio_ctx struct
 and interfaces
Message-ID: <ZtFfEhl5tEeVnHjL@kernel.org>
References: <20240829010424.83693-1-snitzer@kernel.org>
 <20240829010424.83693-16-snitzer@kernel.org>
 <172499679141.4433.17192274712086631600@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172499679141.4433.17192274712086631600@noble.neil.brown.name>

On Fri, Aug 30, 2024 at 03:46:31PM +1000, NeilBrown wrote:
> On Thu, 29 Aug 2024, Mike Snitzer wrote:
> > +
> > +struct nfs_localio_ctx {
> > +	struct nfsd_file *nf;
> > +	struct nfsd_net *nn;
> > +};
> 
> struct nfsd_file contains "struct net *nf_net" which is initialised
> early.
> So this structure is redundant.

Oof, unwinding returning nfs_localio_ctx and going back to nfsd_file it is.
 
> Instead of exporting nfsd_file_put() to nfs-localio, export
> nfsd_file_local_put() (or whatever) which both does the nfs_serv_put()
> and the nfsd_file_put().

OK, no more.. I have to catch up! ;)

