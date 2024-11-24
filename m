Return-Path: <linux-fsdevel+bounces-35730-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F384E9D7884
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 23:19:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA5F82821C3
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 22:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4541D17AE1C;
	Sun, 24 Nov 2024 22:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="e49B6u6q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9746E5103F;
	Sun, 24 Nov 2024 22:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732486772; cv=none; b=ZvD/eNmmD9qU+fD6oBm8StQ00nsq97CywJDQ0CaZBKNHsBXxsR8cxSXgtZa8MkNgAbcUwwM1tJ+zgjBUUXJNZ41rbCCMMmtfdxAmAXClh8pOgsFavoixpGY0NlbrWJ/8EyX9FgRIgpen061TFLRRF7GYdwEBlSXJH+E02JqMCVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732486772; c=relaxed/simple;
	bh=I6XcnF4uPfGIhYwutMp/1qPD5A7OWZPJ7kTiDJXqtOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gVzjTS28TlUxo2CAF3M3nIVCBiiuyI8jqCF48ZGMo43eOaTaBUHhxDkH0dku9ZmewWFJ6bJ3lWVwQ3C/polmHPwB4ySMvVCR/0LtagQu9Zjsih0Zay8R8w/uTzjZLWwAI8ZsbVoK5GuPIGnCaqVKB1ZEKeqW5qPaQsjFSCijBi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=e49B6u6q; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=H+Hi17+UR537uG7/2wDzUFFHiduHGQ5A/QTxNFhITOw=; b=e49B6u6qmob3e/Dq3maNxDYtF+
	jGWA+dyLGBu7GH0Zrnr2a9Uy41iaXU3GoirQ0U04oEzlw0UjjP4otwgyHSxsCNC8hiT6z1N0jCKEE
	z17kjySp4I91sQPyiGmTJPRRGKXl4cJZqAygxAN9K5+3efnvSS5iO+0EFBE4ff6VJ5BqsLiu3Dy4x
	wkeMYfjznolV6dzRdZuY1DTSvMCvWsj9tNE8gTGMJpfeq7JpkJcx5DUuiChaEuEiGuwOzqft/bIzm
	Ex+X7617Hg+UrR3seyj3ndHC4XPHdR4iw9/rROvu6rslJPu5B5wFIsKoErLC2eCquxJga4k7bJCIU
	cncIGSeA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tFKwq-0000000Azuw-3EWK;
	Sun, 24 Nov 2024 22:19:20 +0000
Date: Sun, 24 Nov 2024 22:19:20 +0000
From: Matthew Wilcox <willy@infradead.org>
To: "Dr. David Alan Gilbert" <linux@treblig.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Mateusz Guzik <mjguzik@gmail.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Hao-ran Zheng <zhenghaoran@buaa.edu.cn>, brauner@kernel.org,
	jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, baijiaju1990@gmail.com,
	21371365@buaa.edu.cn,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC] metadata updates vs. fetches (was Re: [PATCH v4] fs: Fix
 data race in inode_set_ctime_to_ts)
Message-ID: <Z0OmaPQ4HAdgfJyK@casper.infradead.org>
References: <61292055a11a3f80e3afd2ef6871416e3963b977.camel@kernel.org>
 <20241124094253.565643-1-zhenghaoran@buaa.edu.cn>
 <20241124174435.GB620578@frogsfrogsfrogs>
 <wxwj3mxb7xromjvy3vreqbme7tugvi7gfriyhtcznukiladeoj@o7drq3kvflfa>
 <20241124215014.GA3387508@ZenIV>
 <Z0OkVxY3CW9fV8tp@gallifrey>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z0OkVxY3CW9fV8tp@gallifrey>

On Sun, Nov 24, 2024 at 10:10:31PM +0000, Dr. David Alan Gilbert wrote:
> * Al Viro (viro@zeniv.linux.org.uk) wrote:
> > [Linus Cc'd]
> > On Sun, Nov 24, 2024 at 06:56:57PM +0100, Mateusz Guzik wrote:
> > 
> > > However, since both sec and nsec are updated separately and there is no
> > > synchro, reading *both* can still result in values from 2 different
> > > updates which is a bug not addressed by any of the above. To my
> > > underestanding of the vfs folk take on it this is considered tolerable.
> > 
> > Well...   You have a timestamp changing.  A reader might get the value
> > before change, the value after change *or* one of those with nanoseconds
> > from another.  It's really hard to see the scenario where that would
> > be a problem - theoretically something might get confused seeing something
> > like
> > 	Jan 14 1995 12:34:49.214 ->
> > 	Jan 14 1995 12:34:49.137 ->
> > 	Nov 23 2024 14:09:17.137
> > but... what would that something be?
> 
> make?
> i.e. if the change was from:
>  a) mmm dd yyyy hh::MM::00:950 ->
>  b) mmm dd yyyy hh::MM::01:950 ->
>  c) mmm dd yyyy hh::MM::01:200 ->
>    
> If you read (b) then you'd think that the file was 750ms newer
> than it really was; which is a long time these days.

... and file fs/inode.c might have a timestamp of :01:717 so inode.o
doesn't get rebuilt when it ought to have been?

