Return-Path: <linux-fsdevel+bounces-16190-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A975899CC1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 14:18:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C5F11C20AF7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 12:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07FAB16D326;
	Fri,  5 Apr 2024 12:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ruJA5GKT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA5C16D30E;
	Fri,  5 Apr 2024 12:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712319521; cv=none; b=IDkXXGH/EtSel37Dauufz5x8Kh6Zgi0SbaGaN/JUi+t6vdT/F6/mrhomlq5zFp/5kw2uWo0RsREJ4UiqUgKpuThZfnhIx5lOFaLR28+CudfQz47qpM7bg7lU/F54uxmfEF4jOaj5kpPN1LhdIHswKkgGY+pUub8Fk/mZXcfsD2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712319521; c=relaxed/simple;
	bh=SwuG1AXYxkpbVOpYKxFxoD/c/IxVIKvdXOwhcOLwQe4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e9v7RyWVC5JifdwQNYk9PVMLicGMGNA766Uc60h9i99MGPoABG4wJ9UHxaIVgy3H/eNh7qtBtW0lJwa5F3BQN71aZRMQudziwunPFc377II5Pf3rYapHeogcs+ljHJVL6CRO6dCrxyXZM2SifFVxusaatHOjoZV5zghWEXZUlO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ruJA5GKT; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=pM8ku/k+HG+DRvbgpdHgmsq0Y2sQAqCM3oLo4AlR/Jo=; b=ruJA5GKT8MQAZXQt4R8YzVLx3q
	BponjEjS37cz7oDZzozhnIrP+VyqxjOnY6s6TgcBd23ZzhO+rfoaoarVGyNi99n1r/jgFCNausf3U
	ClItxZiQk1Aw+8AhE4DrCHliNC6oK3PSaCrXVXK1/C0Ps8STreiUWiRLjfEqG3J09/p569I/Sn0p4
	N5VEswxDPIi6MPPQUZelxVFM/iDjUbwQaz0uswbahPJ0aJW6LKgYtvjwWfCZtRbgNXYBDuam2ZWhV
	tsRDnu1PTH6l77o0/U1m10ld/koAobb/u5T6EH0DP93CJiskgX95YEjcUP2W3cv7j/42GzjyNk1Wj
	OMNzZFTQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsiWd-0000000ARWt-0dWU;
	Fri, 05 Apr 2024 12:18:31 +0000
Date: Fri, 5 Apr 2024 13:18:31 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Eugen Hristev <eugen.hristev@collabora.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	jaegeuk@kernel.org, chao@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel@collabora.com, viro@zeniv.linux.org.uk, brauner@kernel.org,
	jack@suse.cz, krisman@suse.de, ebiggers@kernel.org
Subject: Re: [PATCH v16 0/9] Cache insensitive cleanup for ext4/f2fs
Message-ID: <Zg_sF1uPG4gdnJxI@casper.infradead.org>
References: <20240405121332.689228-1-eugen.hristev@collabora.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240405121332.689228-1-eugen.hristev@collabora.com>

On Fri, Apr 05, 2024 at 03:13:23PM +0300, Eugen Hristev wrote:
> Hello,
> 
> I am trying to respin the series here :
> https://www.spinics.net/lists/linux-ext4/msg85081.html

The subject here is "Cache insensitive cleanup for ext4/f2fs".
Cache insensitive means something entirely different
https://en.wikipedia.org/wiki/Cache-oblivious_algorithm

I suspect you mean "Case insensitive".

