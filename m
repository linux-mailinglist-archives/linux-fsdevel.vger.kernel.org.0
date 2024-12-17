Return-Path: <linux-fsdevel+bounces-37573-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CEB69F4193
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 05:12:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48C4416C78C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 04:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EC7F147C91;
	Tue, 17 Dec 2024 04:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DgP6mLLL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C907C6E6;
	Tue, 17 Dec 2024 04:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734408733; cv=none; b=Y/gCUHlEh/HVXqpYgHQ/sZK23nyF2T/VKRO7h4YDeV6juL5kSTkq6gIR0CGIn8sVr4S32BLa5Xb5rRadpUHdRU220fdaHy7iSgH342ND83mg692ogf2A5MvZrcw0gg/Bwn5ej6/HEztj/JBHPGS5Ucfws1Ii89McJztA/a14xBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734408733; c=relaxed/simple;
	bh=xborGa0kFypIH3PZUTiOBQknQmZzTP+YM8juKVCk8aE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TZvuMJ4Gt1Yx/HE1K6rTo3B/e2q/JHIacDsST4HFEz9a53A8pG6rD+mgPWqHUxYhvmOAnUYbgBRIu1AKVbVCNrENB2NcCCLjyAFw+G+my95sP3SVfeLOSUImVuElBc+iAKQXvZOmXXqbvG+Fdg9GQIxzPcuaUTUNGkk2ffiJiyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DgP6mLLL; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=p9e56CrBYZ7LkPiA+QF9fwN93hG/ij/v5BLEYDF9kPk=; b=DgP6mLLL4BOsn5S2o4/0MRN5/k
	U79B/jKb+/IqVq7PZPvRoXGYoDRN7y0V27Cffg/h91Vr6lVPGOozOKXwFj0BLniwnHcD4tax+9oPY
	YEbP8mWxPqKfBRhU/xjEbhfVlQfkEDM2dWhYQ9XpU6uptJiqUQ6Gyh+yG+ZSBYgrviSTf2sDj+rch
	dc3i8HYclxmpUMfT/ItTsfFMUL67KScCBxY3C3/vCwYd28+MZO2da1DEz8VuCDyZLkPwMT4aVKsUB
	GHN7jmZ0tmUbpL0CJijiCIKlSYjQckgXXx/7GOlgIjo9+jrR4kZyOK+TaVScb45IhlL5dMRdHghAr
	Drv3CURg==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tNOwK-00000004k4A-09DI;
	Tue, 17 Dec 2024 04:12:08 +0000
Date: Tue, 17 Dec 2024 04:12:07 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Kees Cook <kees@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] inotify: Use strscpy() for event->name copies
Message-ID: <Z2D6FzPgomC442vW@casper.infradead.org>
References: <20241216224507.work.859-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241216224507.work.859-kees@kernel.org>

On Mon, Dec 16, 2024 at 02:45:15PM -0800, Kees Cook wrote:
> Since we have already allocated "len + 1" space for event->name, make sure
> that name->name cannot ever accidentally cause a copy overflow by calling
> strscpy() instead of the unbounded strcpy() routine. This assists in
> the ongoing efforts to remove the unsafe strcpy() API[1] from the kernel.

Since a qstr can't contain a NUL before the length, why not just use
memcpy()?

>  	event->name_len = len;
>  	if (len)
> -		strcpy(event->name, name->name);
> +		strscpy(event->name, name->name, event->name_len + 1);

