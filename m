Return-Path: <linux-fsdevel+bounces-35732-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE1EB9D789A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 23:35:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74B16282B21
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 22:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EEDE17B4EC;
	Sun, 24 Nov 2024 22:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="N2mH134/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F1915F3FF;
	Sun, 24 Nov 2024 22:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732487698; cv=none; b=u8lyGN03K5BFJnaXSpZNG+yT/ogLPpegeSZUc7W5cl4Jw2fkdoiwooA+KsLrFuwZUTILmdZrR3zgtfuAjFRd0F0s8nZEgXoc4xsdUtTVkv6L6x9y9BpcY6xHWvpphraX1tGDeBWXUCePLxPut9fNKuXlrIy7vPps+/XSFus9MBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732487698; c=relaxed/simple;
	bh=s+rOOU1n30WbMHTTglw6fhdjGiwDea+Z5nnW6PRNquU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sMx8f6kxR5JEaH9xdCtZ6qCUaJyCXGqpUUuXrFKODgD8lwuYYQ3mllqsR+/ASAPkUOEiON3LlRQJDrit12jaZC4Fmzicrj+4owwy3NHZlNL+Fdf+xEXZgbeEKSCpSVdRfy8m7p/q8rfplaYIZ0ejX+/GDCqfX7jwvmFNzDyFRkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=N2mH134/; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Kb1lUUE4FLlwB3StPCrJvFMctiJp+GPXX3AwqlY/5bs=; b=N2mH134/zpb33+gN3IItJdDS7L
	BHWjED5agtUwzs8PZj5hSRf9/HdJy26ACbmybWtPNcKCebqVtaDr26t+RdikaaX3bQjMnSEJ/or99
	N7Umt948VC8PCmWP4tzAAyxLSP/LwEBOB6Fo6ousGnVyeZNhiaFT6gzfke5PPpFiXdo5iHa/3V9Qa
	J169liCJ1fvaSiR7CZcY4kYTMTYceh2Jmpt4nj3OJXwWtyaJRHK0K6YPJzOQ9mjpAzMH1uthO9K9D
	uxhOJR3WkSfFtKT/kDMc+zmTyTq57zdspaO7zSInfjFLG9Nwt2jrGENFqdNNARQWDo94yCN50XbxP
	PnfjTKXA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tFLBr-0000000B0tB-0OER;
	Sun, 24 Nov 2024 22:34:51 +0000
Date: Sun, 24 Nov 2024 22:34:50 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Mateusz Guzik <mjguzik@gmail.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Hao-ran Zheng <zhenghaoran@buaa.edu.cn>, brauner@kernel.org,
	jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, baijiaju1990@gmail.com,
	21371365@buaa.edu.cn
Subject: Re: [RFC] metadata updates vs. fetches (was Re: [PATCH v4] fs: Fix
 data race in inode_set_ctime_to_ts)
Message-ID: <Z0OqCmbGz0P7hrrA@casper.infradead.org>
References: <61292055a11a3f80e3afd2ef6871416e3963b977.camel@kernel.org>
 <20241124094253.565643-1-zhenghaoran@buaa.edu.cn>
 <20241124174435.GB620578@frogsfrogsfrogs>
 <wxwj3mxb7xromjvy3vreqbme7tugvi7gfriyhtcznukiladeoj@o7drq3kvflfa>
 <20241124215014.GA3387508@ZenIV>
 <CAHk-=whYakCL3tws54vLjejwU3WvYVKVSpO1waXxA-vt72Kt5Q@mail.gmail.com>
 <20241124222450.GB3387508@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241124222450.GB3387508@ZenIV>

On Sun, Nov 24, 2024 at 10:24:50PM +0000, Al Viro wrote:
> On Sun, Nov 24, 2024 at 02:10:30PM -0800, Linus Torvalds wrote:
> > I *do* think that we could perhaps extend (and rename) the
> > inode->i_size_seqcount to just cover all of the core inode metadata
> > stuff.
> 
> That would bring ->i_size_seqcount to 64bit architectures and
> potentially extend the time it's being held quite a bit even
> on 32bit...

Could we just do:

again:
	nsec = READ_ONCE(inode->nsec)
	sec = READ_ONCE(inode->sec)
	if (READ_ONCE(inode->nsec) != nsec)
		goto again;

?

