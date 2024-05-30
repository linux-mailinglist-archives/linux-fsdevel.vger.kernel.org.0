Return-Path: <linux-fsdevel+bounces-20513-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBEDE8D49D0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 12:42:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B2B9B225B9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 10:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8091217C7AA;
	Thu, 30 May 2024 10:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="he9Y9voX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16291761B1
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 May 2024 10:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717065734; cv=none; b=NVqhMI67NPl8iNq8M7OJZvBpnF+RRf348gWQe2bSd+AWlEk9tqnxkGIp4ErIFVVVibHWWnv/RRQpxQISq5WcHI1xxx3wS6k/Dhn4ILPN4lFNxMR8TgvZ8GYUW85TlraukerwNePqzi2so9cySFabvx8niZbpno1TmQb93oOsvGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717065734; c=relaxed/simple;
	bh=20YUpx6IBHeJ6a3aSYNwUx68hubjr5XhdJNsN3xkMgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QcKoUoTApYVsFScXOcOfRMFyDS0DyqxsnZQb72Nn0GX4wf6Uf6zUvg37lDfrn0xvIL8Na3uur2JsSPQy9pTTTcI86/UbzFjady6dt9pHxHAG7FrmA4a60WPVQri6q7bSZQzqhP6eKZ3xPkdbGxCHRO9dRcEHiEGuyGc2rrXSTB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=he9Y9voX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A8DEC2BBFC;
	Thu, 30 May 2024 10:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717065733;
	bh=20YUpx6IBHeJ6a3aSYNwUx68hubjr5XhdJNsN3xkMgQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=he9Y9voXrwgFKaYB91YpBTgAMuuaCsWmb3/fG6SCTjdKPeNcf6msPmRfo11IBl8gz
	 WYCv9OJAWkEVRwyc5/3JolGybajtHU9oTH1wZppLmImMztX1R//T+CqtZhd22tflO3
	 jw2fO0loseWgo02irnXf0jgcBV9nH5CwbhsgkaGi7YtMYYIM6YvxPgZuAR2pK7+1gf
	 ByUX630vBC0rMs0L4ubVUEnmZnirGw7fSpuRmNIWeLLD/KtheXJuBDKi0ALpygL9gL
	 yG2GCMkWM2hno4VRvbdcLd3WkjjWStjgbUXm+NrslUU3QTvdXBkiUin0m0kuJTm2Hv
	 XJK85GPlNSPUA==
Date: Thu, 30 May 2024 12:42:09 +0200
From: Christian Brauner <brauner@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Thiago Macieira <thiago.macieira@intel.com>, 
	linux-fsdevel@vger.kernel.org, Miklos Szeredi <mszeredi@redhat.com>
Subject: Re: statmount: requesting more information: statfs, devname, label
Message-ID: <20240530-heilen-haftpflicht-c696306f5287@brauner>
References: <11382958.Mp67QZiUf9@tjmaciei-mobl5>
 <20240530-hygiene-einkalkulieren-c190143e41d9@brauner>
 <CAJfpegv_6K-tFtNjOnTBxc0KTSy7Horpu4OFAvkLBkPtv=CoRw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJfpegv_6K-tFtNjOnTBxc0KTSy7Horpu4OFAvkLBkPtv=CoRw@mail.gmail.com>

> I'd put fs options in there too, but that was something Christian
> disliked.  We should have a discussion about how to retrieve options,
> and maybe the other things like label, devname, etc will fall out of
> that too.

Let me rephrase what I mean as I probably wasn't clear enough in my
first mail. My objection is mostly that I don't want us to start putting
stuff in there that's not generic. And yes, some statfs() fields might
make sense to put in statmount(). But I think stuff like "f_files" or
"f_ffree" is really something that's misplaced in statmount().

