Return-Path: <linux-fsdevel+bounces-62143-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11764B8578E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 17:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 886C25858DD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 15:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC63307AEB;
	Thu, 18 Sep 2025 15:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="doqxYFxl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3CC1EB36;
	Thu, 18 Sep 2025 15:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758208001; cv=none; b=T16t78Lvv2B8UQ+/Hu+bO/Nfn4IgZVlFUwqtTKmr96Fo0NU28NWSY/QB2flGo7HRkhfhpApabJ1n6jjgemF4G1hbKZTigvN/7XgK1w2HLhS4MrxLk3nGRNYiTF+mF8NB2sXAjLTmKGq4vCkn7mc2g22ZtTP30ccE5Brq6WNpQzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758208001; c=relaxed/simple;
	bh=tznCZMZuP/QxmVCF9p6ZdTXuE2XL+BU3sgP+bbyFfy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PhYyLhxodWSbTCwUjB2lHzJS5KoCnK1mq0tGawiTDIgjHpjsZu4eqf7qtCuiSOME89r/H+ZdgSQHbx+GylFYwTvQ7g2Voam4+rwxn59SsqXvMaFoXHh1L0Pl8L1ZXPVi99W1TEaaK+KjvKpLv2YoMkK7ROS+sLDxts1GKP6QOjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=doqxYFxl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EB7FC4CEE7;
	Thu, 18 Sep 2025 15:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758208000;
	bh=tznCZMZuP/QxmVCF9p6ZdTXuE2XL+BU3sgP+bbyFfy8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=doqxYFxlaHSajDoyLkecHqkZa/cRzEepzAeUy7AUwMaZ3SElWLMYuohPd2D/EJ9gz
	 uh4mr58YlLufv8vVBXwgeTSJGPDcAdS2Lab7vEiPPCT4xhGBzhIxI4XQ6Oy+pNdl25
	 tI4OKnfPGWtZv/oAxlt5hXEPzTY2TjIBu2Kr1fFM=
Date: Thu, 18 Sep 2025 17:06:37 +0200
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: ManeraKai <manerakai@protonmail.com>
Cc: "aliceryhl@google.com" <aliceryhl@google.com>,
	"arnd@arndb.de" <arnd@arndb.de>,
	"rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] rust: miscdevice: Implemented `read` and `write`
Message-ID: <2025091841-remindful-manned-a57f@gregkh>
References: <20250918144356.28585-1-manerakai@protonmail.com>
 <20250918144356.28585-3-manerakai@protonmail.com>
 <2025091820-canine-tanning-3def@gregkh>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025091820-canine-tanning-3def@gregkh>

On Thu, Sep 18, 2025 at 04:59:01PM +0200, gregkh@linuxfoundation.org wrote:
> On Thu, Sep 18, 2025 at 02:45:36PM +0000, ManeraKai wrote:
> > Added the general declaration in `FileOperations`. And implemented the
> > safe wrapping for misc.
> 
> While read/write is "traditional", perhaps instead you should just
> export read_iter and write_iter as that is the proper way forward for
> drivers to be using.

Wait, maybe not.  The _iter stuff is "hard" for misc devices, and I
don't think that any of the current ones use that, so nevermind, a
simple read/write should be all that we need here.

What type of real misc driver do you want to write in rust that you need
a read/write callback and not just an ioctl one?

thanks,

greg k-h

