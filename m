Return-Path: <linux-fsdevel+bounces-31894-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D03DA99CDBC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 16:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49FD7B21884
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 14:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726851AB6EB;
	Mon, 14 Oct 2024 14:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dvVdkXZG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9CE1AB6C1;
	Mon, 14 Oct 2024 14:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728916529; cv=none; b=I0ndG/yg/2NKJRX1P/Jc47sUkiY1Tn0/B7fnDwMPgdPaYRqbNxp0mSb6ZBZ+ngn4daev6va6lNPzLZNIIRQBo6/fYf2B2Nq7LEbI+c8aeBT2nMmPGXVxXq4owscY9jYhQuSHpNyM3wSgFTqG0bwhNdVmp7H62Is6PQG9CNMxZ4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728916529; c=relaxed/simple;
	bh=pCrI3SGshsUIg93Vi7KCqG4Ty3KZmeRqwf3Q/tQyiIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QqU/K8lNyIuMwb4e3h6wVHLlmV3NnNPkKVYFi6kWoSAlgzObTisU950DKgZcYinIpTiwF6t3H+0C1mjgF/Af+M09BeimG2rFbnUpdXzTHxc1K18WdC7nRQISF636IN3Hw5Jok+Dy33QnWsnc+2ZYCjVuDADg7zdcLytTuknAxgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dvVdkXZG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B58BC4CEC3;
	Mon, 14 Oct 2024 14:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728916529;
	bh=pCrI3SGshsUIg93Vi7KCqG4Ty3KZmeRqwf3Q/tQyiIc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dvVdkXZGgEh4IgH16Zexalh/iZBYvfiObSWPQ97Y8eAtNcQYcCKUUFlL1xdtmx4jI
	 0C29BLxVCWVz5G8PnRhUMKTSHR5PHJlN+qLwuOMSoM2/diSE5cLF4Sc7XdID9C+vu6
	 NZ5UovyvBnawZLUoPFPsC5ITQYj6d5eHRGH1BBtPs9tXtLcA0Qtjnt1XeBruGDeUzj
	 ytuoyuKtwNx3qfHiA7yQHpf2l+Z4MIWYUDTlb0sf9rc+jrrq+pu3lWyiKVZs6Zge/e
	 aOOsK6dambJtoHfE3NENAbc0dVoR+H19Ma04PSHo+JmQkZPMP+8bGQna7FHSGJfMmB
	 6US4S8h3ZE22A==
Date: Mon, 14 Oct 2024 16:35:24 +0200
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, 
	Paul Moore <paul@paul-moore.com>, linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-security-module@vger.kernel.org, audit@vger.kernel.org, Trond Myklebust <trondmy@kernel.org>, 
	Anna Schumaker <anna@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>
Subject: Re: [RFC PATCH v1 1/7] fs: Add inode_get_ino() and implement
 get_ino() for NFS
Message-ID: <20241014-nostalgie-gasflasche-ccef8ea53bc8@brauner>
References: <20241010152649.849254-1-mic@digikod.net>
 <ZwkaVLOFElypvSDX@infradead.org>
 <20241011.ieghie3Aiye4@digikod.net>
 <ZwkgDd1JO2kZBobc@infradead.org>
 <20241011.yai6KiDa7ieg@digikod.net>
 <Zwkm5HADvc5743di@infradead.org>
 <20241011.aetou9haeCah@digikod.net>
 <Zwk4pYzkzydwLRV_@infradead.org>
 <20241011.uu1Bieghaiwu@digikod.net>
 <ZwlFi5EI08LlJPSw@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZwlFi5EI08LlJPSw@infradead.org>

On Fri, Oct 11, 2024 at 08:34:35AM -0700, Christoph Hellwig wrote:
> On Fri, Oct 11, 2024 at 05:30:59PM +0200, Mickaël Salaün wrote:
> > > It still is useless.  E.g. btrfs has duplicate inode numbers due to
> > > subvolumes.
> > 
> > At least it reflects what users see.
> 
> Users generally don't see inode numbers.
> 
> > > If you want a better pretty but not useful value just work on making
> > > i_ino 64-bits wide, which is long overdue.
> > 
> > That would require too much work for me, and this would be a pain to
> > backport to all stable kernels.
> 
> Well, if doing the right thing is too hard we can easily do nothing.
> 
> In case it wan't clear, this thread has been a very explicit:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

This must be typo and you want a NAK here, right?

