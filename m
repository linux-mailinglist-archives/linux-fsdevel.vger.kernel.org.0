Return-Path: <linux-fsdevel+bounces-40389-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D447A2301F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 15:29:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96AE418849C6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 14:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C6D71E522;
	Thu, 30 Jan 2025 14:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="XvLqosox"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF4A1E7C27
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jan 2025 14:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738247335; cv=none; b=o8ZFYVsKlkjuWXj8yoKAU1OM66Tcfw5+2xz1/QWvu21NetHSWDFfPNec9qQnIqNffn+pQwf5ot37N37d0pI9cHq6s0BlwnjBDv/7NQpTtAes9EZjC9me/rp0CraIL7WSri3Cm8XCMYXPbCKhn9FqeLfVP2pA8kIilYmV3rqOHXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738247335; c=relaxed/simple;
	bh=p4SQfGHbefOrINb9VL4c5TVdUt6cAmmACaBZ2nBJHcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=robuCl8GlN8jD42uP0av7zE6eKw5wEYgdiIc0/2szpTLm6QVqRPepQ8Q7eK9j0PuevP/8cjCepr4jl58Fv13USu7U89rEED+t38DJkz5eqNioWuZbYMpNSkcZevS8t7aQjMN3+8Ms71owfkHaDs/vXsdjxi0TEtML8LJc4UpMR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=XvLqosox; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org ([12.221.73.181])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 50UESL2Y005796
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jan 2025 09:28:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1738247304; bh=klABsmnuDIAJjdAM408x650Bg8f7t4e7sBQE/fwXr1M=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=XvLqosoxlaNG0WjE4Y6C5Cb2R/lCJOGKU+d1a6ee6hAKYDTLSKd9TaSMu+wRDM7Pa
	 I+KpCIsZzOsxKFWWPcu25EMcM2f7y/c0YzZ7YSvIaarHD9wbN6MAE1CrPGxHCO+VoL
	 0fVUgk0rlMWMeOadzataMbG3APVjmG52ZYzLhS7Jtcvel2jTtBkemyz2IRfBJ5y+Vz
	 ll69vUiqHRqX1nYLDu4GJDVGhKN9Q2NZZg7tw4x5UtEwid08/tm3DWHrcWTpjU70Dg
	 q47Vk8VnSG+YojNZaAaXLRd5jsiN664/WcL84/azJxgog48iMYkBjLW9PmpG9idjVn
	 T7FNKAEcoZsqQ==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id F29C83404C7; Thu, 30 Jan 2025 06:28:20 -0800 (PST)
Date: Thu, 30 Jan 2025 06:28:20 -0800
From: "Theodore Ts'o" <tytso@mit.edu>
To: "Day, Timothy" <timday@amazon.com>
Cc: Christoph Hellwig <hch@infradead.org>,
        "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "jsimmons@infradead.org" <jsimmons@infradead.org>,
        Andreas Dilger <adilger@ddn.com>, "neilb@suse.de" <neilb@suse.de>
Subject: Re: [LSF/MM/BPF TOPIC] Lustre filesystem upstreaming
Message-ID: <20250130142820.GA401886@mit.edu>
References: <5A3D5719-1705-466D-9A86-96DAFD7EAABD@amazon.com>
 <Z5h1wmTawx6P8lfK@infradead.org>
 <DD162239-D4B3-433C-A7C1-2DBEBFA881EC@amazon.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DD162239-D4B3-433C-A7C1-2DBEBFA881EC@amazon.com>

On Tue, Jan 28, 2025 at 04:35:46PM +0000, Day, Timothy wrote:
> My biggest question for LSF is around development model:
> Our current development model is still orthogonal to what
> most other subsystems/drivers do. But as we evolve, how do
> we demonstrate that our development model is reasonable?
> Sending the initial patches is one thing. Convincing everyone
> that the model is sustainable is another.

I suspect one of the reasons why most development is happening out-of-tree
is pretty much all of the users of Lustre are using distro (and very
often, Enterprise) kernels.  Are there any people outside of the core
Lustre team (most of whom are probably working for DDN?) that use
Lustre or can even test Lustre using the upstream kernel?

I'll let Andreas to comment further, but from my perspective, if we
want to upstreaming Lustre to be successful, perhaps one strategy
would be to make it easier for upstream users and developers to use
Lustre, perhaps in a smaller scale than what a typical DDN customer
would typically use.

Cheers,

					- Ted

