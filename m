Return-Path: <linux-fsdevel+bounces-29814-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4E897E4AC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 03:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DF2B1C20FA9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 01:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5664F28EB;
	Mon, 23 Sep 2024 01:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="BNsVPb82"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8521E184;
	Mon, 23 Sep 2024 01:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727056249; cv=none; b=L2GeFONjZ7TEWnCaNjGRxSe7cfyc1kjZR8oFhqG209blMq2u0VxGFf9R6k9a1sXhRF76GlBPoChTfvuXcK/GXuygwqDC7Is9Dv0HU0XXOKO4JIPyLEEoZjKQZML2u8LIwqbhapzU+pAFV3t88Ut/Y9zlqRJw8dx9JqA1+baNwJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727056249; c=relaxed/simple;
	bh=/49uGwB0qlBLocmTcOLeUU5CMhsTjQYX8r8PaWL5O5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ilKl1W5d2+XuZ8sVpMd3UtCytEAPplMD+Ml9Rp7yFZhxxPOFDhhG2NtubT4r2kTeRTku9Ehlp+0CFveWGza0AV/uhImsIauVZlb4D5PK1Jl98lN3Pz/xZTAR96sAAaov7pzqCrtkw8hlrh8tsckA1YUAQPUZWYDVYqeNMQUVdM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=BNsVPb82; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=WbnX2PFeOwXXpGiIQclQtW3QUTb2yMZdD5iQ+JruR14=; b=BNsVPb82bFRt3/hG3hnRIlhQGD
	so/40KEe4FbpZYmOlYgBkvW8wAFQTZWlY+zdG99yR9XpZuksRLZAYoWQaCIzmXTryweE4Vu0vePXn
	CCKytGBwOEhRbfhaIWfsLWxhb2Cin4lW+E/qGExSkbwRRXg+/ECU40J/5fGWX+ltkdx/wPe/2FsE1
	ilCUHrEcJIyzPGQjtvdGK9O6KcQK6dlxn+kyHUAZpVloOtMamEAhVyay6eWwGkiHWAGB4PXutqLvy
	hm32Zd3vX1FiAw8E/0ydkvWL92cuU5PDNoUzJ7TiOrycstCjGODAzol7bTGtVoMFLSDqDtZHukcv2
	sFWE9irA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1ssYDs-0000000Eldh-2l3Y;
	Mon, 23 Sep 2024 01:50:44 +0000
Date: Mon, 23 Sep 2024 02:50:44 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: audit@vger.kernel.org, io-uring@vger.kernel.org
Subject: Re: [RFC] struct filename, io_uring and audit troubles
Message-ID: <20240923015044.GE3413968@ZenIV>
References: <20240922004901.GA3413968@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240922004901.GA3413968@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sun, Sep 22, 2024 at 01:49:01AM +0100, Al Viro wrote:

> 	Another fun bit is that both audit_inode() and audit_inode_child()
> may bump the refcount on struct filename.  Which can get really fishy
> if they get called by helper thread while the originator is exiting the
> syscall - putname() from audit_free_names() in originator vs. refcount
> increment in helper is Not Nice(tm), what with the refcount not being
> atomic.

*blink*

OK, I really wonder which version had I been reading at the time; refcount
is, indeed, atomic these days.

Other problems (->aname pointing to other thread's struct audit_names
and outliving reuse of those, as well as insane behaviour of audit predicates
on symlink(2)) are, unfortunately, quite real - on the current mainline.

