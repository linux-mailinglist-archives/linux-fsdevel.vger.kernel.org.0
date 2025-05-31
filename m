Return-Path: <linux-fsdevel+bounces-50251-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C92A4AC98BB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 May 2025 03:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 699AE7A2836
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 May 2025 01:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B26B1172A;
	Sat, 31 May 2025 01:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gTCUr6Pg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46F729A5;
	Sat, 31 May 2025 01:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748653725; cv=none; b=Erkz+Ua1T5Upz3hicGx75n4INVGhdpK289J3i1Qv3zY7oe1nJTrqhERp7hT9jKGIceCAyKnloUlaBwDmwZoITiOsWoQrXW8ps7BKWckaBjPMhHPMH+uuH6qvpokjCjsKb60vzDl647mJbE3GbpTNpD060dFo1idbBLzjH/SDwDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748653725; c=relaxed/simple;
	bh=Zss6ErNP613hE26q0r1vBm1FfRTxpSytRDUOM3OKQUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mSTipGgqZAabHVXSbQ/iHRVw5y77TCo8rwoqa8vjgVIKG0ifXUtI+2VRM+ink4+U+tVi0SVw4nSRbSxkL2CLseyA4Zido2dBgcB6bXJ+IU9CKchYm42CvVxQe1ywzuHTJf7LyVOQ67oeAgjso54wRsSlq4ZO9OQis2WV9MGIDXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gTCUr6Pg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 395F2C4CEEB;
	Sat, 31 May 2025 01:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748653725;
	bh=Zss6ErNP613hE26q0r1vBm1FfRTxpSytRDUOM3OKQUc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gTCUr6Pg1/dKY6BhuBD/Pvd3uzIzx9ltYOKbAs3gqfu+ObdwIIfPaWNqDbkm5LLeN
	 t21hyPtekks94ALaEtaL+ipjmp+lbF4z522/eJGJxt+BhuBnRmUbdsXPpsd8ynnkYE
	 b17f8l1V6QubibW2BMtdxYZy4zlklWc+O0BlmCnl7LASXrS2+us78wgP/dMTDb4gbf
	 Km4E+R17w8pmOMaCXBchGN0UM2V6h1JgF9SqsJgC34+v0jlpdut6rCmyKSPlD1+A3t
	 NPdfJyfkLR5Rl+S8JoiOC73B0QJ4n2P8HiEOdh7OzIfXXzCAYgsjNoOcqAkohOUaGA
	 4Ekn6iyikgKPw==
Date: Fri, 30 May 2025 18:08:44 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com,
	linux-xfs@vger.kernel.org, bernd@bsbernd.com, John@groves.net
Subject: Re: [PATCH 01/11] fuse: fix livelock in synchronous file put from
 fuseblk workers
Message-ID: <20250531010844.GF8328@frogsfrogsfrogs>
References: <174787195502.1483178.17485675069927796174.stgit@frogsfrogsfrogs>
 <174787195588.1483178.6811285839793085547.stgit@frogsfrogsfrogs>
 <CAJfpegsn2eBjy27rncxYBQ1heoiA1tme8oExF-d_C9DoFq34ow@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegsn2eBjy27rncxYBQ1heoiA1tme8oExF-d_C9DoFq34ow@mail.gmail.com>

On Thu, May 29, 2025 at 01:08:25PM +0200, Miklos Szeredi wrote:
> On Thu, 22 May 2025 at 02:02, Darrick J. Wong <djwong@kernel.org> wrote:
> 
> > Fix this by only using synchronous fputs for fuseblk servers if the
> > process doesn't have PF_LOCAL_THROTTLE.  Hopefully the fuseblk server
> > had the good sense to call PR_SET_IO_FLUSHER to mark itself as a
> > filesystem server.
> 
> The bug is valid.
> 
> I just wonder if we really need to check against the task flag instead
> of always sending release async, which would simplify things.
> 
> The sync release originates from commit 5a18ec176c93 ("fuse: fix hang
> of single threaded fuseblk filesystem"), but then commit baebccbe997d
> ("fuse: hold inode instead of path after release") made that obsolete.
> 
> Anybody sees a reason why sync release for fuseblk is a good idea?

The best reason that I can think of is that normally the process that
owns the fd (and hence is releasing it) should be made to wait for
the release, because normally we want processes that generate file
activity to pay those costs.  It's just this weird case where the fd
already got closed but aio is still going in the background.

(yeah, everyone hates aio ;))

Also: is it a bug that the kernel only sends FUSE_DESTROY on umount for
fuseblk filesystems?  I'd have thought that you'd want to make umount
block until the fuse server is totally done.  OTOH I guess I could see
an argument for not waiting for potentially hung servers, etc.

--D

> Thanks,
> Miklos

