Return-Path: <linux-fsdevel+bounces-61403-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9514B57DB5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 15:45:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 761A616996D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 13:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FC0C31D748;
	Mon, 15 Sep 2025 13:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z3y0uAGt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81B831AF17;
	Mon, 15 Sep 2025 13:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757943725; cv=none; b=j2REE8ibOZl03j4lLk6LQjq2o6cTDjJeB4H2Nst326brw75X2p52Zi5EHCtUYzwk8zxSciWfcMCn5GFO7glLqriA5Sl6ti5DSIObi0xb1Kb5FhekCTVb9QmOsVYGZmyYMzfLwppbImuGaiBWaio/mHmlz1JItCjlgzJjSen7TfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757943725; c=relaxed/simple;
	bh=eKUAdKXKip2untvKR6K3cytYQ7wKSn+VA+gK2qUnF5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dfJaMOlS7IjJ4JGKDHysL+S+O5J59wTZ079o+3f21GUToZCOdQLZUUQF5gzF+fOCsVVTmWEbdfAnlF/JO7Hk0S7T5XqDbooTjkOxUllhxQcLvROGJ9aLOkSVTI+vyqYNcrcE9ClqoTkQ1DUzWnCdcD9ILu8a7Qksk1lYfF8Dsww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z3y0uAGt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07495C4CEF1;
	Mon, 15 Sep 2025 13:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757943725;
	bh=eKUAdKXKip2untvKR6K3cytYQ7wKSn+VA+gK2qUnF5M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z3y0uAGtmrKGQOMf5owWAaxnrfR48fVKI+BMseplMdycUTeJOZD2MA+u29n0fwxor
	 58yI+x8k82L5DQrR0/M67t+gOx+rZSeodXJi+dRcrdfi5cJQwgrJgq8KyfmkQG27Mg
	 puYYyzGstGuuWH+qfuEldinlhX94ELwZuEpMyZFtBESm+vtYhZAoUEs95QNXm3FUbY
	 BJej+gX7X/RoHuqoY7AwPzdwNk/jzFKZmy1sw5jcC9MFN5lYDfls4vraYyQB0QOtrp
	 7mJQceF9FuyKkS/SjWvgSEpw/009QqSfRjSF5LcY1JeS+B/8wPdLG19z9TgG+lNX3j
	 smBwBPQs9P/1A==
Date: Mon, 15 Sep 2025 15:42:01 +0200
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: expand dump_inode()
Message-ID: <20250915-glitzer-fachrichtung-b3e984baace2@brauner>
References: <20250909082613.1296550-1-mjguzik@gmail.com>
 <20250915-meilenstein-simulation-7e220d91b339@brauner>
 <CAGudoHF5xc0KYsV6H0S8tDt9=ipV5EB7RZzGzxVfkpbgVuF0Rw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGudoHF5xc0KYsV6H0S8tDt9=ipV5EB7RZzGzxVfkpbgVuF0Rw@mail.gmail.com>

On Mon, Sep 15, 2025 at 02:17:22PM +0200, Mateusz Guzik wrote:
> On Mon, Sep 15, 2025 at 2:15 PM Christian Brauner <brauner@kernel.org> wrote:
> >
> > On Tue, Sep 09, 2025 at 10:26:13AM +0200, Mateusz Guzik wrote:
> > > This adds fs name and few fields from struct inode: i_mode, i_opflags,
> > > i_flags and i_state.
> > >
> > > All values printed raw, no attempt to pretty-print anything.
> > >
> > > Compile tested on for i386 and runtime tested on amd64.
> > >
> > > Sample output:
> > > [   31.450263] VFS_WARN_ON_INODE("crap") encountered for inode ffff9b10837a3240
> > >                fs sockfs mode 140777 opflags c flags 0 state 100
> > >
> > > Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> > > ---
> >
> > Applied to vfs-6.18.misc.
> 
> I posted a v2: https://lore.kernel.org/linux-fsdevel/20250911065641.1564625-1-mjguzik@gmail.com/

Yeah, I picked that.

