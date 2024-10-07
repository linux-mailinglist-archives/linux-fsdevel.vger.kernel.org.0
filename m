Return-Path: <linux-fsdevel+bounces-31143-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EACE9923EB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 07:41:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBDF81C2219C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 05:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE2E13B294;
	Mon,  7 Oct 2024 05:41:15 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD73327726;
	Mon,  7 Oct 2024 05:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728279674; cv=none; b=Cp3lXPUgzwKkWXuOBIogSQpBPn1YAoIHmZ1ls/PSzs3GPkpMoyHwzlPsjmeCGa7/2FhJBVB80ZgJEEWO2e7hNc1213cgX+ISIthpw3IzGzAoVqvF7fc0hxY5uTkf3HjO0HV8M2wXnjREu2O/7Ljy1ytMQqivPNqYo9U0r7CxdgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728279674; c=relaxed/simple;
	bh=3rmfuYqFvxZSpPkPu3avf0MagV/I61EnJUtADx4nSnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dtLFU5MbhVWaqcXJin9JlYUuHxg+/29mDMoXKYJemRpVvJNBXWiU5jU9lxSUdnBjHRI3xjk0NTYqe8M7FF3XGd4mTH5XgFM5/4TOMiWmtNf4EvRI7Pf0PehPOHr1+aAZjY9GwVlnbrterl3AqLvepg44f25Zn2c9gXl2gwtRLNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0F621227A8E; Mon,  7 Oct 2024 07:41:02 +0200 (CEST)
Date: Mon, 7 Oct 2024 07:41:01 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>,
	Chandan Babu R <chandan.babu@oracle.com>,
	Carlos Maiolino <cem@kernel.org>,
	Christian Brauner <brauner@kernel.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: fix stale delalloc punching for COW I/O v4
Message-ID: <20241007054101.GA32670@lst.de>
References: <20240924074115.1797231-1-hch@lst.de> <20241005155312.GM21853@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241005155312.GM21853@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Sat, Oct 05, 2024 at 08:53:12AM -0700, Darrick J. Wong wrote:
> Hmmm so I tried applying this series, but now I get this splat:
> 
> [  217.170122] run fstests xfs/574 at 2024-10-04 16:36:30

I don't.  What xfstests tree is this with?

> I think this series needs to assert that the invalidatelock is held
> (instead of taking it) for the IOMAP_UNSHARE case too, since UNSHARE is
> called from fallocate, which has already taken the MMAPLOCK.

Yes.  I'll look into fixing it, but so far I haven't managed to
reproduce the actual splat.


