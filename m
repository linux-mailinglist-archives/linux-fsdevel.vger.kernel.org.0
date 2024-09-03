Return-Path: <linux-fsdevel+bounces-28407-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DEB996A0C3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 16:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BB0A282F47
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 14:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0D513D296;
	Tue,  3 Sep 2024 14:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eI2Ty3YG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5365BAF0;
	Tue,  3 Sep 2024 14:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725374121; cv=none; b=MpL5LTVjSWB8VrXMAc/X8OsmEKyepDVAqqMFeyy3pj5ejkdCnO5BTgRZpHxfp4Jdwzse/cn5kEWteM0DmvzEb7JRfh+vQQ3cCJtz/3O3fOYj1lG04sNo4Nt+ZU7kOiPl7CGeDkmKtlvQkEUxou2WlxcK75wJ3lDn85HAntTWjLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725374121; c=relaxed/simple;
	bh=SXW9Lb7ZYF60TtJNxa2tzxDrQEAQyWEpctMJfc6+Lnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZxNk/1WDgRWUYgRnlxk1hdtbvrZeAx3gkn8YLEFBpU37nzwlv/B8eKeypFjP6zauoAja12bN+cvRuxZTfrDc5b/Z6BADy9RWgK3DZJpknrudYULNaJwMaKdT/0wNnNy7Ykpsej4Zzgl/xONrKoITkKRXWR0l4wGL7grudrTrUco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eI2Ty3YG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0B35C4CEC7;
	Tue,  3 Sep 2024 14:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725374121;
	bh=SXW9Lb7ZYF60TtJNxa2tzxDrQEAQyWEpctMJfc6+Lnw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eI2Ty3YGWuQvGA9egzniLii9YQG8AfW76NMVfcefuZrmPyHF4bE1yl47co3r94xpr
	 lNhNFIBfd7Y0gztaRlvnjUyXb19Ngt5hz/WgwYyYjoo9lfHoSQKPf3wWH65zGJMKi2
	 Arx90hFQceXXoDMQtcWokmLo9jzFEWRZ4rbh/iLoGd87XjmjfDpuSvH++Lr66wZg82
	 +zkUu/rWYqR291y8VeN48DA80+O0xdnW9HQFM+n8h6Tg+pInvmX70OxcqbV8yJi/V7
	 I8xz7TmjCusWsM7jIh9ivWozgayqxQXB9TjsCfQpdOeXT9BWK58O0HMtvrXSJ4s4ao
	 yaUovB82siFIQ==
Date: Tue, 3 Sep 2024 16:35:14 +0200
From: Christian Brauner <brauner@kernel.org>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: amir73il@gmail.com, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, 
	martin.petersen@oracle.com, James.Bottomley@hansenpartnership.com, jack@suse.cz, 
	jaegeuk@kernel.org, jlayton@kernel.org, chuck.lever@oracle.com, bvanassche@acm.org, 
	"axboe@kernel.dk" <axboe@kernel.dk>, linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org, linux-scsi@vger.kernel.org, 
	gost.dev@samsung.com, vishak.g@samsung.com, javier.gonz@samsung.com
Subject: Re: [PATCH v4 0/5] Write-placement hints and FDP
Message-ID: <20240903-erfassen-bandmitglieder-32dfaeee66b2@brauner>
References: <CGME20240826171409epcas5p306ba210a9815e202556778a4c105b440@epcas5p3.samsung.com>
 <20240826170606.255718-1-joshi.k@samsung.com>
 <20a9df07-f49e-ee58-3d0b-b0209e29c6af@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20a9df07-f49e-ee58-3d0b-b0209e29c6af@samsung.com>

On Tue, Sep 03, 2024 at 07:58:46PM GMT, Kanchan Joshi wrote:
> Hi Amir,
> 
> 
> On 8/26/2024 10:36 PM, Kanchan Joshi wrote:
> > Current write-hint infrastructure supports 6 temperature-based data life
> > hints.
> > The series extends the infrastructure with a new temperature-agnostic
> > placement-type hint. New fcntl codes F_{SET/GET}_RW_HINT_EX allow to
> > send the hint type/value on file. See patch #3 commit description for
> > the details.
> > 
> > Overall this creates 128 placement hint values [*] that users can pass.
> > Patch #5 adds the ability to map these new hint values to nvme-specific
> > placement-identifiers.
> > Patch #4 restricts SCSI to use only life hint values.
> > Patch #1 and #2 are simple prep patches.
> > 
> > [*] While the user-interface can support more, this limit is due to the
> > in-kernel plumbing consideration of the inode size. Pahole showed 32-bit
> > hole in the inode, but the code had this comment too:
> > 
> > /* 32-bit hole reserved for expanding i_fsnotify_mask */
> > 
> > Not must, but it will be good to know if a byte (or two) can be used
> > here.
> 
> Since having one extra byte will simplify things, I can't help but ask - 
> do you still have the plans to use this space (in entirety) within inode?

I just freed up 8 bytes in struct inode with what's currently in -next.
There will be no using up those 8 bytes unless it's for a good reason 
and something that is very widely useful.

