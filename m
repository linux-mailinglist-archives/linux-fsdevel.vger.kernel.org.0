Return-Path: <linux-fsdevel+bounces-37265-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E4CF9F03E9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 05:51:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F922282B46
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 04:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8165616EB76;
	Fri, 13 Dec 2024 04:51:49 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B679863D;
	Fri, 13 Dec 2024 04:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734065509; cv=none; b=lr55nbyzGNCewNDBeYfX32629MjgSlapQ/jBX4N4SBPWrJsl5OjK4q75fG+6krt39970r+DmszOldEZUa5VlKayKfa2hry7hc40IWVI6xELVJuMR1WezPxE1AN4Vm6hYA2L+t0uTTzMAKJyi+sEhsd7dSG+nBkV2QQoTviuYb64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734065509; c=relaxed/simple;
	bh=OyxOfgY7HZSHCE+cEVtm3KUf2a9dNfP7/thCJWWUkwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=on5tr1L1Kl6td3LibMvqF5yHO/SkrG/WCcNOV09NG8kAFC3kgo5Rrsul9DJQ7XNd8eYMiD4UB0r+JVQUXbj+WqB2mYrejOiYhPW8f/kygOWlzhf13DJLEKtCE38VrbgSUGHqdymGUlJln/ZWObUPLwVmYitNmFO2q96tn/EVv28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id E6F2868BEB; Fri, 13 Dec 2024 05:51:44 +0100 (CET)
Date: Fri, 13 Dec 2024 05:51:44 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>,
	Carlos Maiolino <cem@kernel.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 5/8] iomap: optionally use ioends for direct I/O
Message-ID: <20241213045144.GE5281@lst.de>
References: <20241211085420.1380396-1-hch@lst.de> <20241211085420.1380396-6-hch@lst.de> <20241212195624.GI6678@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212195624.GI6678@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Dec 12, 2024 at 11:56:24AM -0800, Darrick J. Wong wrote:
> >  		return 0;
> > +	if (ioend->io_flags & IOMAP_IOEND_DIRECT)
> > +		return iomap_finish_ioend_direct(ioend);
> >  	return iomap_finish_ioend_buffered(ioend);
> >  }
> 
> I'm a little surprised that more of the iomap_ioend* functions didn't
> end up in ioend.c.

See the cover letter.  For development I wanted to avoid churn.  Once
we have general approval for the concept I'd like to move more code.

> > +			WRITE_ONCE(dio->submit.waiter, NULL);
> > +			blk_wake_io_task(waiter);
> > +		} else if (!inode->i_mapping->nrpages) {
> > +			WRITE_ONCE(iocb->private, NULL);
> > +
> > +			/*
> > +			 * We must never invalidate pages from this thread to
> > +			 * avoid deadlocks with buffered I/O completions.
> > +			 * Tough luck if you hit the tiny race with someone
> > +			 * dirtying the range now.
> 
> What happens, exactly?  Does that mean that the dirty pagecache always
> survives?

Yes.


