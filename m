Return-Path: <linux-fsdevel+bounces-36799-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 733E09E9792
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 14:45:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5E852830D4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 13:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B5621ACEA2;
	Mon,  9 Dec 2024 13:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jwBxK1Rs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D80935953;
	Mon,  9 Dec 2024 13:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733751912; cv=none; b=O1OHzva6HkeK4oXCiN6dN5BpcO6FdUeFfZjLcDEu97OtYmned24ANVk8Azv1ha4geUnyw2werveeXc7d41nnFibSBsnw46N5w8twdsRf4nBF99+gjm509tTkV0ROz+DrkHO2WELTR9KcuDmAjF8OAKFnV3iBGXc/TQ23++j9nnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733751912; c=relaxed/simple;
	bh=1a6G46JfjtTX9I6SjXR1A7pNkXwaTOdnMXH2In3vczQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MAlRvXjih7ppEFi6Xf8b4jqIyh8X/t4r2ssG6C1GJzaRWOJfCFJnGIrTF9a2oozTi6y13AVK6qfBLuy4U/fxpazuWLuakwB/8qjBZVf1IXmHh518qZ3jQaeLmMS+Jv5hg3IVtogNA8NVL0AKszF4GQ1HZcrQwN2oYuy/Z4666zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jwBxK1Rs; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=FVpmPI05TSIP+K81Kd1Fzbdes5yFYSHh6V7vfJ86r/4=; b=jwBxK1RsoDnn1OE6ohrOqQJnCq
	aeU2BNeJzd8PaAMbkVibitfScV8PpDhw2C5qqk/SNj6rmGAs7N6lDReltM2egjeIQTEXw6TlSji47
	ZbDGZFds0RfIne5sQ3dXPi4yp6bfUAYqTuCRjsSGz/KGIciDN8oGyx1Fh0qyQCagb0S3dq4dqhIW6
	PF/Lquz8G+boUHRdnf7n9JbV67TEXc/EvFJJCJc7ShZ/88gvxvHiUSkLfWxvxQe//5qscocXBWAUb
	F9qEUVAlI6tpwDXW5KlLl4tc3LxcPqAWVut9H0Vq2ouiA4iSzWf4bEaL/0cEL0M49/3OgcgF4DZD5
	0MaCOxPg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tKe4T-000000083PB-3joO;
	Mon, 09 Dec 2024 13:45:09 +0000
Date: Mon, 9 Dec 2024 05:45:09 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Amir Goldstein <amir73il@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Erin Shepherd <erin.shepherd@e43.eu>,
	Chuck Lever <chuck.lever@oracle.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org,
	stable <stable@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Shaohua Li <shli@fb.com>
Subject: Re: [PATCH 0/4] exportfs: add flag to allow marking export
 operations as only supporting file handles
Message-ID: <Z1b0ZQAstSIf-ZMo@infradead.org>
References: <20241201-work-exportfs-v1-0-b850dda4502a@kernel.org>
 <Z1D2BE2S6FLJ0tTk@infradead.org>
 <CAOQ4uxjPSmrvy44AdahKjzFOcydKN8t=xBnS_bhV-vC+UBdPUg@mail.gmail.com>
 <20241206160358.GC7820@frogsfrogsfrogs>
 <CAOQ4uxgzWZ_X8S6dnWSwU=o5QKR_azq=5fe2Qw8gavLuTOy7Aw@mail.gmail.com>
 <Z1ahFxFtksuThilS@infradead.org>
 <CAOQ4uxiEnEC87pVBhfNcjduHOZWfbEoB8HKVbjNHtkaWA5d-JA@mail.gmail.com>
 <2024120942-skincare-flanking-ab83@gregkh>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024120942-skincare-flanking-ab83@gregkh>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Dec 09, 2024 at 10:16:36AM +0100, Greg KH wrote:
> > Maybe we were wrong about the assumption that cgroupfs should be treated
> > specially and deny export cgroups over nfs??
> 
> Please don't export any of the "fake" kernel filesystems (configfs,
> cgroups, sysfs, debugfs, proc, etc) over nfs please.  That way lies
> madness and makes no sense.

Umm, yes: it sounds like a pretty useless idea.  But you can do that
today with a userland nfs server, so why explicitly forbid it for
the kernel nfs server.  In either case you absolutely have to want it,
you're not going to accidentally NFS export a file system.

I'm still trying to understand what problem we're trying to solve here.


