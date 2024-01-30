Return-Path: <linux-fsdevel+bounces-9506-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64ECD841EE6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 10:11:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97AA71C24927
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 09:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E38759147;
	Tue, 30 Jan 2024 09:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NUtUl+gO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097FC58AA1;
	Tue, 30 Jan 2024 09:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706605877; cv=none; b=UHtgKoT7XqpLLhAx9SrbtPi9XwSW/Y5sdoBWYrZf6WIKYj+SMrt+GowdDdjLvETls7e+llTcBjTeyEmTRXf9qrLlJlafvBK5hrypThI4x+K6Hp0b+m/PdIkB6nfkn3rDNfhcTCmUaC04l9mc9pozftByuirlbJpHkU4C50Tkl30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706605877; c=relaxed/simple;
	bh=zxMztCT5JyY+YRcSnp0V/2OMXGxLgnqtdzVLJMz21ic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m2mJp6v4bNAzuaAISuR86d5ukmPjzT32izQZTGLC3dZvOS/DBvus0Eum6694gS+yG66AAmeM97boFMIjphvs+Hcjk52Ov2OKkoWbw9n3EmTvAjGenD+cRa8fXQdvsaAgflQUuEiLz2jeUVzxcCL4qxLLW4C0zfBl59Pfqhmyr20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NUtUl+gO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C07FC433C7;
	Tue, 30 Jan 2024 09:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706605876;
	bh=zxMztCT5JyY+YRcSnp0V/2OMXGxLgnqtdzVLJMz21ic=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NUtUl+gOAL5noqt1nR+J9G6nosQzXcpRXuP72/iHywg9Twz7+fSoiVMxBktExY5r9
	 tpnNB421SGosYy3bAap1edp5cUMoXMKilZCk+mBoXSOSjYY5LUFL9xwxtXax736RFa
	 EIKt7WgA0511cLxgyKLVvy6mxrFL7njyAXyiVeZlNAanhrzA39aDpCTLHKjDJ0p2f3
	 hpzdboptFCvvQIpg3yrY7Cp7g1P/fva/ROgNPaAHRO9s2TMnYtmRvkYTxlGvnzjAey
	 rFWo8bQNn5tcB6rqpi/Sby8hgPqXtMlBz0XfNpBouNBlXPUBWiiXqc3uh3rEIh1R4d
	 TpEgObFQM1GvQ==
Date: Tue, 30 Jan 2024 10:11:12 +0100
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>, 
	"Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 31/34] block: use file->f_op to indicate restricted
 writes
Message-ID: <20240130-rinnsal-irrfahrt-dcf83901c9d2@brauner>
References: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
 <20240123-vfs-bdev-file-v2-31-adbd023e19cc@kernel.org>
 <20240129164934.GA4587@lst.de>
 <20240129-gastmahl-besoldung-33a6261b10d9@brauner>
 <20240130083213.GA23465@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240130083213.GA23465@lst.de>

On Tue, Jan 30, 2024 at 09:32:13AM +0100, Christoph Hellwig wrote:
> On Mon, Jan 29, 2024 at 06:09:37PM +0100, Christian Brauner wrote:
> > I don't think it's that bad and is temporary until we can
> > unconditionally disable writing to mounted block devices. Until then we
> > can place all of this under #if IS_ENABLED(CONFIG_BLK_DEV_WRITE_MOUNTED)
> > in a single location in block/fops.c so its nicely encapsulated and
> > confined.
> 
> Oh well.  If Jens is fine with this I can live with it even if I don't
> like it too much.  I'll probably just clean it up as a follow up.
> 
> OTOH I fear we won't be able to unconditionally disable writing to
> mounted block devices anytime soon if ever.

One my dream. Put another way, if we don't even allow us to think that
we can remove insecure functionality in the future then we have to
accept that we'll be piling on #ifdefine's and mostly unused code
forever which is just sad. :/

I'm hopeful that writing to mounted block devices is something that we
can make all major distros move away from. We should start just because
we need to figure out what tools do actually try to do stuff like that.

