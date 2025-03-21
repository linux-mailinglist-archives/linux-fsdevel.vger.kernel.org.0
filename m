Return-Path: <linux-fsdevel+bounces-44689-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A5AA6B63F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Mar 2025 09:48:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5B3F19C445D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Mar 2025 08:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B1CB1EFFB0;
	Fri, 21 Mar 2025 08:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jpx2JQKM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D909F8BEE;
	Fri, 21 Mar 2025 08:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742546895; cv=none; b=Aa1z6kWFRuN9BTkEogmjYvXegfLxGI0UtxiBVkAHuyVoUXFLGlfNZvODRrBCW9HCifQ+NY8MF9vXgrgzg16k/fST7JvI7I/JF+zAji1UmAr0XR5lPYYr/EDUeDSkzebTxnt0G/lnEl9bRlerjNW51kNDAbrLiROauPkMYcnO7DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742546895; c=relaxed/simple;
	bh=abnke97pmn3LBsknfmstS32PS5U8YYNFemuTZzZ2jAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QFE6qeF/YQuNnl59jWECm4cRmkDD+BRSXEVw2W5XaZzoI+ifBw6x/wVQ4//kQXR+8lXIeYcYyaLG3/TXbTyxMr5Kj+bc42UNwFbCj6xE65Umea8mD2FutFU2DDwbKuit2+ebyn9mUmJCEPCio5c/TMKx86LYpJqI1+TBUy8p0SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jpx2JQKM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C53B1C4CEE3;
	Fri, 21 Mar 2025 08:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742546895;
	bh=abnke97pmn3LBsknfmstS32PS5U8YYNFemuTZzZ2jAs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jpx2JQKMjlOfaLLciP0WFr10Qq9Q0XC5Lz/8zsnWaHEPuClWxeCkB5696Lq2EFvuN
	 VaR+hZjYS+DaYn8B1e3MiYp+PtKy8/6C0KlDGdA1qRLbgBs1g5at6jwvg/bEizlF38
	 kFF04ScJxIoDvhS64YRP1eU4JI36wFkpGXrC6XF3C8XZ0+DqPfjGCaKIbC22YCJag9
	 dMC9Iz7/x+MWyZxveoSJwt7ZJ7hd+PmPYNU626mpzQw25/i6sA5MouFz3uGVoNa65o
	 2v76J4qqS+kUN/4m5Ei2qfF+mUH6kbLvkw1YA44FvCXUp2Vt6i/S4andmXXwKvByjK
	 D7kw0lwGYB0kg==
Date: Fri, 21 Mar 2025 09:48:09 +0100
From: Christian Brauner <brauner@kernel.org>
To: julian.stecklina@cyberus-technology.de
Cc: Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] initrd: support erofs as initrd
Message-ID: <20250321-adrett-umgeladen-e1f5f0171d8a@brauner>
References: <20250320-initrd-erofs-v1-1-35bbb293468a@cyberus-technology.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250320-initrd-erofs-v1-1-35bbb293468a@cyberus-technology.de>

On Thu, Mar 20, 2025 at 08:28:23PM +0100, Julian Stecklina via B4 Relay wrote:
> From: Julian Stecklina <julian.stecklina@cyberus-technology.de>
> 
> Add erofs detection to the initrd mount code. This allows systems to
> boot from an erofs-based initrd in the same way as they can boot from
> a squashfs initrd.
> 
> Just as squashfs initrds, erofs images as initrds are a good option
> for systems that are memory-constrained.

I think this can be valuable and I know we've had discussion about this
before but it should please come with a detailed rationale for using
erofs and what project(s) this would be used by. Then I don't think
there's a reason per se not to do it.

