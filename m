Return-Path: <linux-fsdevel+bounces-30469-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB0698B8BB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 11:56:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23029B221F5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 09:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2216819F42C;
	Tue,  1 Oct 2024 09:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h/7k+mvX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840FA19D8B3
	for <linux-fsdevel@vger.kernel.org>; Tue,  1 Oct 2024 09:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727776599; cv=none; b=Te11HZ/Gtfwq+dYJ8njnVpQG4OzWrvBuZb2Ew8y+soAqLOE5XOIM049TXk8V7tIcLhVHAUqXqsH00sDRYeipJ0ccebRv67dYusyoPzE3VKNUK9qSigi+IDOy+TnVeFIZC0FLRTYNJW9XO6OzEOAc+pZl3sFsr42TVq/11trfz3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727776599; c=relaxed/simple;
	bh=SwAIo8/Hc6zNugBXtGuo36Ti1JiRN3h2q6gaPtL+YEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sHKVmd5vnEiNQT4N4mwhFmOxrKe0AKOb4g3Kz2gbjz/jN+hgJdWF0jlvz/B5CMlHAKpNkkRpO8ckDutCcSOM4FXNpvWU3hTeWxSK8AYq1nPiZOGshWfx1wZPEoclKGxA6CG1i+yL/EBxM35vlZjwKgxPbM9i5Qhbb9uDO1mhGKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h/7k+mvX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B859C4CEC6;
	Tue,  1 Oct 2024 09:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727776599;
	bh=SwAIo8/Hc6zNugBXtGuo36Ti1JiRN3h2q6gaPtL+YEo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h/7k+mvXQmAT0fo1fmzFfEwUn/2lalzWYajO8ovkj76WBfHQw8cNOtcw+kR4ys+C/
	 8exhcMKPb6BBtqlH6BePQHFUxKRtlA1thzC3jGV5N9yuNNpOQkOvA9sJ6KnedPPPWx
	 IiEARRbfkmEW0J/P1FrSB/9eM6whxD7QycUn8WWL/NZa99IRFO+VNRLCcKbi34b1ks
	 Qr01hEeOmdTP653SY7/fPJ8FYKmsL7C62VL/p6Gq9ErTCUpc/2xvFnl8foHutFflmP
	 QcGhIFStu5rSUZfR62QTUnr0JbYw6kezVLzBmgQWJhmCHoXs/5imnU9FHMVUzfabML
	 CC27UHq+PGT0A==
Date: Tue, 1 Oct 2024 11:56:34 +0200
From: Christian Brauner <brauner@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Amir Goldstein <amir73il@gmail.com>, 
	Bernd Schubert <bernd.schubert@fastmail.fm>, Jakob Blomer <jakob.blomer@cern.ch>, 
	Jann Horn <jannh@google.com>, Laura Promberger <laura.promberger@cern.ch>, 
	Valentin Volkl <valentin.volkl@cern.ch>, linux-fsdevel@vger.kernel.org
Subject: Re: optimizing backing file setup
Message-ID: <20241001-umbenannt-steif-f42a8d03b106@brauner>
References: <CAJfpegsmxdUwKWqeofn9-DYvqmPWafwxQfy4nLgfvosvhXfjOA@mail.gmail.com>
 <CAOQ4uxji-2L-W2+e==NgmhS7i9mMjR4rW9A1_Bkx3aSzB5roAA@mail.gmail.com>
 <CAJfpegv2vVpzZysQrQs5dKv7eN_sTMq-=p-x1d-LC41CFOCzpg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJfpegv2vVpzZysQrQs5dKv7eN_sTMq-=p-x1d-LC41CFOCzpg@mail.gmail.com>

On Mon, Sep 30, 2024 at 05:43:24PM GMT, Miklos Szeredi wrote:
> On Thu, 26 Sept 2024 at 14:24, Amir Goldstein <amir73il@gmail.com> wrote:
> 
> > Daniel took a different approach for averting the security issue
> > in the FUSE BPF patches.
> > The OPEN response itself was converted to use an ioctl instead of write:
> > https://lore.kernel.org/linux-fsdevel/20240329015351.624249-6-drosen@google.com/
> > as well as the LOOKUP response.
> >
> > Are there any negative performance or other implications in this approach?
> 
> It would work, but I'd try to avoid adding more ioctls if possible.
> Hence the io-uring suggestion.
> 
> OTOH I'm not sure io_uring is the best interface for all cases, so it
> might make sense to cherry pick some features from the io-uring API
> (like COMMIT_AND_FETCH) to the regular synchronous API.  And that
> would need new ioctl commands anyway.

A few years ago I vowed to not add ioctl()s anymore because of my
dislike of multiplexers. Fast-foward to now and over the last few cycle
I probably added around 10...

