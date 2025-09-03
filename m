Return-Path: <linux-fsdevel+bounces-60171-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD77B42601
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 17:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E285D165036
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 15:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA1028D8FD;
	Wed,  3 Sep 2025 15:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fMr3KUk0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90DA28C2A6
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Sep 2025 15:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756914846; cv=none; b=iLox7+IunBEzqPQYu5jLpmdQDNzNWbFuUOOTLK5WPCtPma3vlO0vC+Ld9YpZDw8NF0MFyVaVME3SW1wRavOmilW8KFawAiO0lzbB1sxyl11gLfAcOmHNxl/n4WsSGKqPRJqKvHEJW4pBb+CzQJPtm9ZWVaN3LFeQptvde8w8Nn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756914846; c=relaxed/simple;
	bh=n20ECwmy30RM4WGUaP+6BdQK90jlaFH/w+la67Mkvp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l2vw5tDTBZoPXo9von36M/y6FpVJGDDXOnc7lRWa70btEWszddXDgJIOhr+xgQ4lQ0fUnG0td76+26NffoAYQihdA9g0c05F5T+elQnd1nB+Np6FNYJvqA+Y6G8YejkZE/JvRZ40ZLQFTvGX6TEEPeRLr6lzuBx32/OiROIjKfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fMr3KUk0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67F4CC4CEE7;
	Wed,  3 Sep 2025 15:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756914846;
	bh=n20ECwmy30RM4WGUaP+6BdQK90jlaFH/w+la67Mkvp4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fMr3KUk00SdhLro2/zoDFccWs9g9txy47nGPeiefDOYDdSC131c/phucAFdGRw3Nz
	 vmAwClqnQODt2inOWKJpxrrOpI16QAq37pSnupcV3tgCBJzMdlyyQhv8gvU0j73Rl1
	 ZjVhOjdcBQlnlQkmzmPaSIP+L3mwRC1jJw+dKTKrZ73fKAQbg9HEQMau9WhMGropJ/
	 5aosAK1XzgB0ejqVaCDnp3K/xno6gRcpp6hvQZYjf/8Ww01ujNt/XcdXj7YGuEu1d4
	 pbDJKhwIBtuqjfB2/57yucB77QvZuTzMd45uTeATCm3doKNMWoeM1cpIzfHkat5Dty
	 tFqbfAejALc+w==
Date: Wed, 3 Sep 2025 08:54:05 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Joanne Koong <joannelkoong@gmail.com>, bernd@bsbernd.com,
	neal@gompa.dev, John@groves.net, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/7] fuse: capture the unique id of fuse commands being
 sent
Message-ID: <20250903155405.GE1587915@frogsfrogsfrogs>
References: <175573708506.15537.385109193523731230.stgit@frogsfrogsfrogs>
 <175573708609.15537.12935438672031544498.stgit@frogsfrogsfrogs>
 <CAJnrk1Z_xLxDSJDcsdes+e=25ZGyKL4_No0b1fF_kUbDfB6u2w@mail.gmail.com>
 <20250826185201.GA19809@frogsfrogsfrogs>
 <CAJfpegs-89B2_Y-=+i=E7iSJ38AgGUM2-9mCfeQ9UKA2gYEzxQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegs-89B2_Y-=+i=E7iSJ38AgGUM2-9mCfeQ9UKA2gYEzxQ@mail.gmail.com>

On Wed, Sep 03, 2025 at 05:48:46PM +0200, Miklos Szeredi wrote:
> On Tue, 26 Aug 2025 at 20:52, Darrick J. Wong <djwong@kernel.org> wrote:
> 
> > Hrmm.  I was thinking that it would be very nice to have
> > fuse_request_{send,end} bracket the start and end of a fuse request,
> > even if we kill it immediately.
> 
> I'm fine with that, and would possibly simplify some code that checks
> for an error and calls ->end manually.  But that makes it a
> non-trivial change unfortunately.

Yes, and then you have to poke the idr structure for a request id even
if that caller already knows that the connection's dead.  That seems
like a waste of cycles, but OTOH maybe we just don't care?

(Though I suppose seeing more than one request id of zero in the trace
output implies very strongly that the connection is really dead)

--D

> Thanks,
> Miklos
> 

