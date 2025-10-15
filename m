Return-Path: <linux-fsdevel+bounces-64201-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B4027BDC9CE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 07:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A7D544ED29C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 05:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C34E3043B7;
	Wed, 15 Oct 2025 05:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zwJW2Y49"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C65303A0D;
	Wed, 15 Oct 2025 05:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760506815; cv=none; b=bRHzMDTTUMVeuoevV3Oi/OFOs0UsLB+AdtzLXbF+PeXapFBD/2n93sx30iW42hUa8uuSWscrxTGtcjtXq7M+CgY0QVV0G60qjJnXKH3OP1UsyrH6I5X0yDF0v5CAVeHIR0YeuGvOMICqKWDCD242iu3C7gHz6ty4LOrVui9p51U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760506815; c=relaxed/simple;
	bh=/Ui1aBa4w54NRXCNQAuBnmnjLTLChY/YiIJH0ydYAk0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PodmFNQtgEhQWmjuPZAgdXkZAbPINJCpqNEuLNHb0ALx0vHwh9J8y1nbW8tPjmJTCPeiEpdPxsZUfWTNfarlsounade2uKYcegxXMq92u0hD/9olWCtjV5e3pgiZJ+nNIZAnDjx3l6tLD5cBXPf3wMsn4qScf1TmuWYhiYjkhGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zwJW2Y49; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75125C4CEF8;
	Wed, 15 Oct 2025 05:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760506815;
	bh=/Ui1aBa4w54NRXCNQAuBnmnjLTLChY/YiIJH0ydYAk0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=zwJW2Y49coyg+4P8/Be9WxyuS3CR2/GJRi7AuAQhRjRaErziH5I6kEzlYCmROIKx+
	 NV0jFVJtnbLPHPxeeoNqZpdLwhZdaroXtcy7F2DnpiO/3Cs7/GmfZgIa8Gfs2ckF4S
	 Gm7R61VPvFgzXHNB0SuhsjfhT8O7N4kK0IZyGTiA=
Date: Wed, 15 Oct 2025 07:40:12 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Ryosuke Yasuoka <ryasuoka@redhat.com>
Cc: arnd@arndb.de, ojeda@kernel.org, alex.gaynor@gmail.com,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com,
	tmgross@umich.edu, dakr@kernel.org, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH rust-next v2 0/3] rust: miscdevice: add llseek support
Message-ID: <2025101544-stopper-rifling-00e0@gregkh>
References: <20251015040246.151141-1-ryasuoka@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015040246.151141-1-ryasuoka@redhat.com>

On Wed, Oct 15, 2025 at 01:02:40PM +0900, Ryosuke Yasuoka wrote:
> Hi all,
> 
> This patch series add support for the llseek file operation to misc
> devices written in Rust.

Cool, but what miscdevice driver needs llseek support?  Do you have a
real user for this that we can see as well?

thanks,

greg k-h

