Return-Path: <linux-fsdevel+bounces-45077-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41FCFA715FC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Mar 2025 12:43:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6397618924AD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Mar 2025 11:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4102719CC3E;
	Wed, 26 Mar 2025 11:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fPPylndl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B2E1DD539;
	Wed, 26 Mar 2025 11:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742989356; cv=none; b=lCBf3RTOV8PtOfXb1VvhgaicuTOze4HxQCyCl6cAbK1UACn6a39KeaxY/ny4b2JL7fo4qDnNmVWT6ytGa7R5lE8ySZdvygsEJaOt42Ex1Ry6M+78EY7DUUmcONjm9z0Vign3tp+hOvVJyOPhcpZgDUPj/hdP+nNmZEHZSQWq4nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742989356; c=relaxed/simple;
	bh=v7ZMOO35vU/6iDB7/2yQJPgyi3G0An8BkvlxvSgQTZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IEVKj0ekmKnt4SCfV6pPN8H+B+G+7BvvkR6sGxap1t78lVmjZadMT3555XAqWdTf/ka/39yn9T0GUvn8JGCABoADW6+3Uj1SmAtOun4/m9wcH3u+7lKzgbDydqELra6SdfdXTj6XJrATMCkSXl3gEgHJj6GMHR0krqEoutTkxto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fPPylndl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B400FC4CEE2;
	Wed, 26 Mar 2025 11:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742989356;
	bh=v7ZMOO35vU/6iDB7/2yQJPgyi3G0An8BkvlxvSgQTZc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fPPylndlVuEOOtsg+EFcIJOe5PBDJWrL6fLi5/Qisxgk/P/0J67tyFdPgzQH30NOz
	 g8XAjtn1p9dYj8qEUaKF40fpFM6WDs0S7dOes1G5MrDTrFMFUpXfZSlUkXT78bVrRQ
	 5IfudNeyC8ynw3hXjW9+SEA+B9ykFreE+1g8aV2wuTJBEXD+sDZrACxgsrspg5Vv6/
	 l5bt9ynaSIgGx+ySvkl9ccplrBEW23gAy1UZGBNqRpdknyqvY7xr9pPscH1iwWEz2z
	 LNvS3fswNpTtOOKljWo8D4Wd4F7yRG/TS+bOx8o1OhpTQLxmk8a+tm9HVzP5BmjXca
	 uL1e8MJyvKUAg==
Date: Wed, 26 Mar 2025 04:42:34 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: jack@suse.cz, hch@infradead.org, James.Bottomley@hansenpartnership.com,
	david@fromorbit.com, rafael@kernel.org, djwong@kernel.org,
	pavel@kernel.org, song@kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	gost.dev@samsung.com, amir73il@gmail.com
Subject: Re: [RFC 0/6] fs: automatic kernel fs freeze / thaw
Message-ID: <Z-PoKps9bY-dZ2pU@bombadil.infradead.org>
References: <20250326112220.1988619-1-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250326112220.1988619-1-mcgrof@kernel.org>

On Wed, Mar 26, 2025 at 04:22:14AM -0700, Luis Chamberlain wrote:
> I did a quick boot test with this on my laptop and suspend doesn't work,
> its not clear if this was an artifact of me trying this on linux-next or
> what, I can try without my patches on next to see if next actually
> suspends without them. And so, we gotta figure out if there's something
> stupid still to fix, or something broken with these changes I overlooked
> on the rebase.

next-20250321 has suspend broken, so it was not my patches which broke
suspend. So we need baseline first on a kernel revision where it is not
broken.

  Luis

