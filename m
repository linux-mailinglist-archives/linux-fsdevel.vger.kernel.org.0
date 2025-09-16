Return-Path: <linux-fsdevel+bounces-61777-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B35B59D58
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 18:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5BAC3B79C0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 16:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A5B731FEDA;
	Tue, 16 Sep 2025 16:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ualAB/HV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6926432857A
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 16:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758039362; cv=none; b=KvRy1tvqys41rJ6mJlFLp2DRm691yAkWg00wGBP8MyypBooqLb9BvIg+Cqoqlddw5wHtioe7mJyH2Zv41nGenphQhj0Ew2ysVAaspjX/sq720A6MZYixwdRNTedDIkFGbxyTcGkpk/YsqiHuuxj5p+yxRvTCjvWjKbSBF8U8tQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758039362; c=relaxed/simple;
	bh=MDH9Nm1u1rtXbqBgkEmzRadtnx1mRwGxtyvHWLltcLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bb54IMtGt+qXSVXojHDkkKyPhpK6iE7XtziseR7poiF8l7/lcJf6o9+4Jd8VOStxItlg2b4fpxEN3FOmQGJQ7v42U0i0LFmPzGmi8M6meZ4NHjNDbJkaD12N91GkgJ2aa32c6upEK/JouMAkE+p8DWLHno7TeJLA0JdBPV8Lc3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ualAB/HV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EA97C4CEEB;
	Tue, 16 Sep 2025 16:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758039362;
	bh=MDH9Nm1u1rtXbqBgkEmzRadtnx1mRwGxtyvHWLltcLI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ualAB/HVlG+TGeBsO6s5lHxqBHeI0iLP+fhFSdo3dX7MWfbOGuAt+PkZPARjfxeKj
	 z6VuQUHtiOHrVqjoRD/fpNvRA+uj0n08myXmderIpU9JLAyfeYRb3k0l2WDtjIazY0
	 G6IMhM3As0x3WtXqrn9C3D7vG3fxnfdZsgRWBZo162DWO3UTXud7xV6aonQy4b2TKv
	 dqK6LeWMuxJODUnuwmdJwXaDIJeBgFZn4xKT7eqEykAOq0dM/yG8og2/48/TDMlFDd
	 EXis2aLl2nE0C16PYo/0LkrGjuAILxyftdf6IvCSSkzmv33NrfhikcJut4v3xw6KrI
	 bRtKMLO+dpBKQ==
Date: Tue, 16 Sep 2025 09:16:01 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Bernd Schubert <bschubert@ddn.com>
Cc: "John@groves.net" <John@groves.net>, "neal@gompa.dev" <neal@gompa.dev>,
	"bernd@bsbernd.com" <bernd@bsbernd.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"miklos@szeredi.hu" <miklos@szeredi.hu>,
	"joannelkoong@gmail.com" <joannelkoong@gmail.com>
Subject: Re: [PATCH 1/1] libfuse: don't put HAVE_STATX in a public header
Message-ID: <20250916161601.GP1587915@frogsfrogsfrogs>
References: <175798154222.386823.13485387355674002636.stgit@frogsfrogsfrogs>
 <175798154240.386823.11914403737098230888.stgit@frogsfrogsfrogs>
 <22f77d71-03d3-486a-b3d3-0532804aaaf8@ddn.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22f77d71-03d3-486a-b3d3-0532804aaaf8@ddn.com>

On Tue, Sep 16, 2025 at 02:38:07PM +0000, Bernd Schubert wrote:
> On 9/16/25 02:41, Darrick J. Wong wrote:
> > From: Darrick J. Wong <djwong@kernel.org>
> > 
> > fuse.h and fuse_lowlevel.h are public headers, don't expose internal
> > build system config variables to downstream clients.  This can also lead
> > to function pointer ordering issues if (say) libfuse gets built with
> > HAVE_STATX but the client program doesn't define a HAVE_STATX.
> > 
> > Get rid of the conditionals in the public header files to fix this.
> 
> Thank you, PR with an updated commit message and removal of HAVE_STATX
> from the public libfuse_config.h created here
> https://github.com/libfuse/libfuse/pull/1333

That looks reasonable, thanks for picking this up. :)

--D

