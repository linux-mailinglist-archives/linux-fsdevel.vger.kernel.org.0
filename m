Return-Path: <linux-fsdevel+bounces-28856-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF98796F8FE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2024 18:04:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3B5F1C2132D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2024 16:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876311D3633;
	Fri,  6 Sep 2024 16:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F44be4vD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB56F156880;
	Fri,  6 Sep 2024 16:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725638685; cv=none; b=YM1KXi8BjxrW+/I6FY1tok8sO3NukV4sUttzCIqQOkjqkEt09qyQGAfsdp1NHdv+PABgHk13PHQeZ72WdTaLPNb57KtQmNuiqqPinZwwb+Y2MQmvDYzBJY7WlOykk9mRgcsUqYh2Ik5vBYYT2I0mE7pssNuBrVkH+jJuJd3fmqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725638685; c=relaxed/simple;
	bh=BZenlBD2N8AAYL+2OT/3WcZoQCY+AVCkF1sXui4p35Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WR/LrRMAziuLsqCpyYhfbt5YJP4iBdQB+/KblgYPzp6C82Y9YlFHPdFj2fmuJTm7l/tYoSxwySGSXHTtKuXV+yAb00p4Gnb813Dy99XN/J+lgJNhVXWrh82G1ygf/ySy6c0aODZ9hKVVtAF4DTwibNkSJtv8uJtjd8wEUCe9+d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F44be4vD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AE2BC4CEC4;
	Fri,  6 Sep 2024 16:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725638684;
	bh=BZenlBD2N8AAYL+2OT/3WcZoQCY+AVCkF1sXui4p35Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F44be4vDFLCx4ewpp8POzx1WytGmpAJBWrkhnXMOdWZdPJlVz2kRfiKwhdznK2HDH
	 opmZNx1MGv+Ot9ffc1C52s2VRqmwR1+Of+AjJCAtAsF+gcLYZb+hD3RDiO0gqApc2n
	 2JpJCk/LkxV87d0eg/d63pqJaqhdDEIoFol1Z3x6rv1c+GMZVnl/XYM3RYvUcgFctx
	 IvltQxB3DnHjdi0hAXGlcKUCrn2he5m85TiQGBZlJG0mzCOc5NB1zzf6swc/B8xPHQ
	 bY+Xs9ZajwrORdx1JJQ1VQ2A+66EAIwjagZueN9BKO2sRMv6zySdjZ6i6wCYCU99LP
	 59fLRfoE1AW3w==
Date: Fri, 6 Sep 2024 10:04:41 -0600
From: Keith Busch <kbusch@kernel.org>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	martin.petersen@oracle.com, James.Bottomley@hansenpartnership.com,
	brauner@kernel.org, jack@suse.cz, jaegeuk@kernel.org,
	jlayton@kernel.org, chuck.lever@oracle.com, bvanassche@acm.org,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org, gost.dev@samsung.com,
	vishak.g@samsung.com, javier.gonz@samsung.com,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Hui Qi <hui81.qi@samsung.com>
Subject: Re: [PATCH v4 5/5] nvme: enable FDP support
Message-ID: <ZtsoGX2QY-TjBolb@kbusch-mbp.mynextlight.net>
References: <20240826170606.255718-1-joshi.k@samsung.com>
 <CGME20240826171430epcas5p3d8e34a266ced7b3ea0df2a11b83292ae@epcas5p3.samsung.com>
 <20240826170606.255718-6-joshi.k@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826170606.255718-6-joshi.k@samsung.com>

On Mon, Aug 26, 2024 at 10:36:06PM +0530, Kanchan Joshi wrote:
> Flexible Data Placement (FDP), as ratified in TP 4146a, allows the host
> to control the placement of logical blocks so as to reduce the SSD WAF.
> 
> Userspace can send the data placement information using the write hints.
> Fetch the placement-identifiers if the device supports FDP.
> 
> The incoming placement hint is mapped to a placement-identifier, which
> in turn is set in the DSPEC field of the write command.
> 
> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
> Signed-off-by: Hui Qi <hui81.qi@samsung.com>

I'm still fine with this nvme implementation.

Acked-by: Keith Busch <kbusch@kernel.org>

The reporting via fcntl looks okay to me, but I've never added anything
to that interface, so not sure if there's any problem using it for this.

