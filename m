Return-Path: <linux-fsdevel+bounces-67637-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE62DC451C5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 07:41:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CEB73B1BCF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 06:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 264F62E92B4;
	Mon, 10 Nov 2025 06:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="ct5Gjmpg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DB7238C2F;
	Mon, 10 Nov 2025 06:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762756871; cv=none; b=XhWiC9NI/c9Dy89NvjKrT8vGOWGoz4prdO3rI2gUDa3x3Ss8dqYWRkJ3h+tWh7J41N//xoOpPwHYwyzjqbgwgVgyKLABt4leLth7BXzRNTXI1Wi9a46TV9ER0eP7lBn8WvaSbDwCTa1lIZMEc7wCrJ1GNzJmCHecJn+VjNec9/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762756871; c=relaxed/simple;
	bh=e2Ol+VcL+8k+1I/AMS3disA32Dlzpaf6SdIJSGyIEfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=coU/jvxMCWpkTRl9pstXanlrvUH99m2h7uPtkZdVt7tZ6uaFw6SLUe+wofN9aC20IphshIZyLXC0ckvDE0cS2uEep0WV3mOsq2JyblibLVQLGw9BW3IWK7x20pIiL3ilWmO2qo+GEEjXry/D+S2RAw2+UVaRRVBjwShL3mseyAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=ct5Gjmpg; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=e2Ol+VcL+8k+1I/AMS3disA32Dlzpaf6SdIJSGyIEfU=; b=ct5GjmpgnYFeBCCfeAZyg9SchR
	eytNo2Sb7yT6m/Z9eGbQqHP4UjGcBiqQPvwQBpV8FWz4mUqB9OnJ1lDz9EIIdwUHHlBZzIFEbgESX
	YPOPHJImzN1tTOPJlooxhL3lwGlBj5Bm7LDY/bYcV46ymEd6yVBGgnxbri6nLMpJRexq8QH4N24JV
	roReEOl1mLY14Du4ohknCHd5PKb+Qh43Gg48n04fq2/cbwcnau4wucVQfgx2UAh8mwRaVGrYE0H7u
	hXKg9sK4q0WdsXFOC37e3OFJXR4kV5KqH26ExO9fAdZXInJK/AImrgL7CbOlQ73F2k3VdvUFVWKyH
	A9NmJlUA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vILaM-00000000v0y-48tu;
	Mon, 10 Nov 2025 06:41:07 +0000
Date: Mon, 10 Nov 2025 06:41:06 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, jack@suse.cz, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [MEH PATCH] fs: move fd_install() slowpath into a dedicated
 routine and provide commentary
Message-ID: <20251110064106.GM2441659@ZenIV>
References: <20251109120259.1283435-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251109120259.1283435-1-mjguzik@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sun, Nov 09, 2025 at 01:02:59PM +0100, Mateusz Guzik wrote:

> +/*
> + * Install a file pointer in the fd array while it is being resized.
> + *
> + * We need to make sure our update to the array does not get lost as the resizing
> + * thread can be copying the content as we modify it.
> + *
> + * We have two ways to do it:
> + * - go off CPU waiting for resize_in_progress to clear
> + * - take the spin lock
> + *
> + * The latter is trivial to implement and saves us from having to might_sleep()
> + * for debugging purposes.
> + *
> + * This is moved out of line from fd_install() to convince gcc to optimize that
> + * routine better.
> + */

Does it become seriously worse if you move rcu_read_unlock_sched() into the caller?

