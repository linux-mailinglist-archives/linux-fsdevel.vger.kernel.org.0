Return-Path: <linux-fsdevel+bounces-999-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35BD87D4AB9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 10:44:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3C3D2818BE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 08:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ACB6134BD;
	Tue, 24 Oct 2023 08:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i8Q0g6B8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BE411701
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 08:44:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C348CC433C7;
	Tue, 24 Oct 2023 08:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698137075;
	bh=spgpNFU470w+i5R/iihyxIaQCbIvjCGM+TkdU8WIWZo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i8Q0g6B8gPBrQsp/Kz5f2T5y/IvMbOR+U8IFZlw4TvnyQ+GBk4Rui6ds9bI6VwL0c
	 /iXIP8mNxCEF6xRHEvKoj5+L1azcILd+fhdEcRJ0rca7s9byBNpT9afe2AhGSjHQUt
	 2nk13BtFQChn5OM9F/YLctPsOWAsA1EqiPEsPwFolm10u42g3gNQx0hu7U6SDaQ+Zt
	 Kgp4++mnJ7TUzmCzFjNufRALX8zX0jmxDTI4LOk314pmzi5mIjX3suLpfM8LOY1NFi
	 3AU9/Ts2guqh0O/uJa+6RnOcAjVQRpVINTasvpSBpbpuLFsEifHlJSscWTUQqAovxF
	 sFXGzBohuixgg==
Date: Tue, 24 Oct 2023 10:44:30 +0200
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: loop change deprecation
Message-ID: <20231024-entfuhr-sachbezogen-aab33dec4087@brauner>
References: <20231018152924.3858-1-jack@suse.cz>
 <20231019-galopp-zeltdach-b14b7727f269@brauner>
 <ZTExy7YTFtToAOOx@infradead.org>
 <20231020-enthusiasmus-vielsagend-463a7c821bf3@brauner>
 <20231020120436.jgxdlawibpfuprnz@quack3>
 <20231023-ausgraben-berichten-d747aa50d876@brauner>
 <20231023-fungieren-erbschaft-0486c1eab011@brauner>
 <ZTdsPUgCA5TK1hfj@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZTdsPUgCA5TK1hfj@infradead.org>

(Sorry for the broken "Subject:" btw in the first mail.)

On Tue, Oct 24, 2023 at 12:03:25AM -0700, Christoph Hellwig wrote:
> On Mon, Oct 23, 2023 at 05:35:25PM +0200, Christian Brauner wrote:
> > I just realized that if we're able to deprecate LOOP_CHANGE_FD we remove
> > one of the most problematic/weird cases for partitions and filesystems.
> 
> > change fd event on the first partition:
> > 
> > sudo ./loop_change_fd /dev/loop0p1 img2
> > 
> > we call disk_force_media_change() but that only works on disk->part0
> > which means that we don't even cleanly shutdown the filesystem on the
> > partition we're trying to mess around with.
> 
> Yes, disk_force_media_change has that general problem back from the
> early Linux days (it had a different name back then, though).  I think
> it is because traditionally removable media in Linux never had
> partitions, e.g. the CDROM drivers typically only allocated a single
> minor number so they could not be scanned.  But that has changed because
> the interfaces got used for different use cases, and we also had
> dynamic majors for a long time that now allow partitions.  And there
> are real use cases even for traditional removable media, e.g. MacOS
> CDROMs traditionally did have partitions.
> 
> > For now, we should give up any pretense that disk_force_media_change()
> > does anything useful for loop change fd and simply remove it completely.
> > It's either useless, or it breaks the original semantics of loop change
> > fd although I don't think anyone's ever used it the way I described
> > above.
> 
> Maybe we can just drop the CHANGE_FD ioctl and see if anyone screams?

Yes, I suggested that in the prior mail. I think we should do that.
We'd need changes to LTP and blktests but there are no active users in
either codesearch.debian, cs.github, or cs.android.

