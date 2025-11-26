Return-Path: <linux-fsdevel+bounces-69869-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 662ABC8930B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 11:08:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0A87E34FC6F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 10:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 019D02FB96A;
	Wed, 26 Nov 2025 10:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bIwARS8H"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572391D63F3;
	Wed, 26 Nov 2025 10:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764151695; cv=none; b=XwtV9fiNo2EFVCFirm6+N1h0erq58UBCbWcyqdHC5mhDQcBy8uWfkcS0fXsVKNGYUfFBETT3bUMoWZ5LC3z4VzpYC4Ti1YxSE1XOZZsqH6h0MiMQ0cXS2v9LxFG8MRRTgNZZjfPSt4mf/qBbU6wDMyHVo1axZz27LibyBR2ms/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764151695; c=relaxed/simple;
	bh=J2amtbAL4AoBVIXNA2h1zI+jiMqajl/5FLqHjIHMIFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ogtl6JZWTzUuQaV8EfKg03ITOuRxHh1i1Z76py7fWh4R1Jz6IQZxUgKGv4tf9Y8wHoPG1x2xmUKJNrhEinXLQs0jcAuZvK5q0WfFp8e6xs+yMmsp1urZSaSiIKFITHTO5X1M6VVoIhcj0DMNoVIKBQTpy3og+ab7MqDoDJoFhzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bIwARS8H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8952AC113D0;
	Wed, 26 Nov 2025 10:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764151694;
	bh=J2amtbAL4AoBVIXNA2h1zI+jiMqajl/5FLqHjIHMIFE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bIwARS8H5bs26q/tiAHi3IcvLDbsKEIfDmQeQaRg//XqPZAOkyFTXZ7DBfAp888mn
	 Az9zcHue7O2Syj9OGBUXKMe/7rDTc+3qTFQISBpdLAJ9uB+AU5sVUm6vqrkT0Hcz7F
	 nZXafVhrdoJueR9+BbN1o3NFVofk/cj+uXVXf9fhTrX6bSRV+3cSOLZQor9AadE85D
	 bmTGMDBw1VFSXP9+62gjSMdxUilUUczmhxWss1zaaXFWt3CHZzQ0smNw6CvaGCsk5F
	 QNlecAnaNBBLYYysASJEaGxEWP5vKrjfgNuUcNN+ESTn8/rIxisC4ZLZvFQSobG0ry
	 peXfGWV/QjKBA==
Date: Wed, 26 Nov 2025 11:08:10 +0100
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: mark lookup_slow() as noinline
Message-ID: <20251126-vermachen-sahne-c4f243016180@brauner>
References: <20251119144930.2911698-1-mjguzik@gmail.com>
 <20251125-punkten-jegliche-5aee8187381d@brauner>
 <CAGudoHHzXjvMXUZhCKMvdPxzwg71MOAUT+8c6qgiKhUfS0UoNA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGudoHHzXjvMXUZhCKMvdPxzwg71MOAUT+8c6qgiKhUfS0UoNA@mail.gmail.com>

On Tue, Nov 25, 2025 at 10:54:25AM +0100, Mateusz Guzik wrote:
> On Tue, Nov 25, 2025 at 10:05 AM Christian Brauner <brauner@kernel.org> wrote:
> >
> > On Wed, Nov 19, 2025 at 03:49:30PM +0100, Mateusz Guzik wrote:
> > > Otherwise it gets inlined notably in walk_component(), which convinces
> > > the compiler to push/pop additional registers in the fast path to
> > > accomodate existence of the inlined version.
> > >
> > > Shortens the fast path of that routine from 87 to 71 bytes.
> > >
> > > Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> > > ---
> >
> > Fwiw, the biggest problem is that we need to end up with something
> > obvious so that we don't accidently destroy any potential performance
> > gain in say 2 years because everyone forgot why we did things this way.
> >
> 
> I don't think there is a way around reviewing patches with an eye on
> what they are doing to the fast path, on top of periodically checking
> if whatever is considered the current compiler decided to start doing
> something funky with it.
> 
> I'm going to save a rant about benchmarking changes like these in the
> current kernel for another day.

Without knocking any tooling that we currently have but I don't think we
have _meaningful_ performance testing - especially not automated.

