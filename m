Return-Path: <linux-fsdevel+bounces-9393-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D108840A11
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 16:32:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A59E1F28D3A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 15:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B32154448;
	Mon, 29 Jan 2024 15:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ChG+i6Q9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25431153BE2
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jan 2024 15:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706542357; cv=none; b=QbfhYmqZIsf10yiro5MBQWNcw1vE6S4Gz/4apI5hweRq7iGWgpbG+AzbzA+2cgk9EP+Xujz5+3zlbQ9XYYmnjRMgHW2mhH0r2yNrDOh5tO15iN8kMvCyn8ZvnZqPy6DlN09/nzGAs0zorQd+SE/jERptn8dK91My7kUpPP5XAB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706542357; c=relaxed/simple;
	bh=Mw0j4P1xB2c0V+gMkZ2qFb7wY8Y0fpTTiOBCogVEzVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dfjbLRXiMEXPqI+xt+Ra5lqqIwNEtOwm7dKfC9LIgGMVI6et2ErtK+do/zaDpI+hHWY6/6Hszo24qZNfU4KMaXSSM+omXq2i+osOVS7xIHvUmmbTHjSZYXpyb2VfHc6IX0uXD75lDS9Qi1vs0RAOSlOSlvdKMQAZkWLCd2yDIBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ChG+i6Q9; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3aVnCGk29L2rhujr2aTpW9aLlGfIegjqrzrJzIw5iLw=; b=ChG+i6Q9gxVGP2F149zZNEk/LJ
	qm03Dn1AtPgV0I3AWoNOjkXTczRbOaMwqDg/qdM+YNU4p6XISMSFEkomxX7cIf8c/s27tBcqEZ93G
	2rbOqWCII7PB8EcMkuSKPG2SZDv0wsVXj66qI2kdp6q0oVK4z2VEU+BwMXc3NuI+IzQyu60Vk0DfU
	Vt0SjEa1AUiw7j9I+Q7inTndbfS6Kxa7ZCjY9IaCBkK9BhazLlrwFgDgyNUn/NVVNutAptem3itWe
	f9pNFWhmBHTMaZxvd3gVAlJNVJTN7Ngy6eZXvffYsQO/HbpeIpT3aV1dXxIb982I4QYzZEA5OiAJf
	L2mObySw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUTcf-00000006zLO-2nnk;
	Mon, 29 Jan 2024 15:32:33 +0000
Date: Mon, 29 Jan 2024 15:32:33 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Tony Solomonik <tony.solomonik@gmail.com>
Cc: axboe@kernel.dk, linux-fsdevel@vger.kernel.org, brauner@kernel.org
Subject: Re: [PATCH v8 1/2] Add do_ftruncate that truncates a struct file
Message-ID: <ZbfFEanD93PpK8ma@casper.infradead.org>
References: <20240124083301.8661-1-tony.solomonik@gmail.com>
 <20240129151507.14885-1-tony.solomonik@gmail.com>
 <20240129151507.14885-2-tony.solomonik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129151507.14885-2-tony.solomonik@gmail.com>

On Mon, Jan 29, 2024 at 05:15:06PM +0200, Tony Solomonik wrote:
> do_sys_ftruncate receives a file descriptor, fgets the struct file, and
> finally actually truncates the file.
> 
> do_ftruncate allows for passing in a file directly, with the caller
> already holding a reference to it.
> 
> Signed-off-by: Tony Solomonik <tony.solomonik@gmail.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

