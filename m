Return-Path: <linux-fsdevel+bounces-37071-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B8249ED128
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 17:21:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A8C51887820
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 16:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAADE1DC19E;
	Wed, 11 Dec 2024 16:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Kdrjb58K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE9D1494CC;
	Wed, 11 Dec 2024 16:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733934062; cv=none; b=mQfVV6UONpqvJUxK5tmUHaHySlChlgtc/tlG/4oet2KxsQSE04ToDiv6ceajXgPkLkgA/wWSOArCcJk/GOqS95W36LhFltTuCus+2EUNoofUxUsz5dZXelyFHGyWTbxUYETiLp8jbnFq+lU0p0aJwl0YbUWvgB+QsbyYWsgUFns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733934062; c=relaxed/simple;
	bh=uw//hqCMM9HWMKRSt26zVjTfbz+Xet06m8v6VdA23xA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KYowNGXaTc8cfCyVTCX74Nri3bamIB7e73psqGWGGrEOCvPB7xTaZUixBLnjvMPZKJcJQdOlOzCKOykGTVqeDm9qhabv7wPMVKSygPlDO3VQji99HasoFRPtla805QCXhWvYfxQAzxolv3nVfM2vnkn5uUVaUrZgd21yCd+9bEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Kdrjb58K; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7Z0DEBri/4e5qFRB3rmrvUGG+X5H123cydH6+EWO8RM=; b=Kdrjb58K4q8Bm96epMm2s8XLJl
	ztCAyzNHmLDocRWJds2Q5zw/fWs7ZHgnB/2iZrgGsPKoGSIp59/dDvdvFU1vFoLxVWGsKqW/cvAAQ
	GISE51OMZIMXJlbwa349fFXGh9fAIxZ2sZekuO2omVdttECtNX2zTW4//8AmT+GkJZR4uhmn6zuks
	Np41yo/BBoNJ2WRHzmPfPrZeOXg52VE7XJDsIITJTxGo0QxMzNo2rbDDlf4DhWIBK1HnyqZJ7uuHv
	+jx2/Y5xovAo/ya5h9TrIhCg9yAOkvRxmgSNkjdqlO9v8ssVDq5f5a/VmGKZMSa9LH0dog8nNKZ1N
	yFqKXTfQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tLPSK-00000007HCV-0JfZ;
	Wed, 11 Dec 2024 16:20:56 +0000
Date: Wed, 11 Dec 2024 16:20:56 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC] Add a prctl to disable ".." traversal in path resolution
Message-ID: <20241211162056.GF3387508@ZenIV>
References: <20241211142929.247692-1-mjg59@srcf.ucam.org>
 <20241211.154841-core.hand.fragrant.rearview-Ajjgdy5TrwhO@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241211.154841-core.hand.fragrant.rearview-Ajjgdy5TrwhO@cyphar.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Dec 12, 2024 at 02:56:59AM +1100, Aleksa Sarai wrote:

> I think RESOLVE_BENEATH is usually more along the lines of what programs
> that are trying to restrict themselves would want (RESOLVE_IN_ROOT is
> what extraction tools want, on the other hand) as it only blocks ".."
> components that move you out of the directory you expect.
> 
> It also blocks absolute symlinks, which this proposal does nothing about
> (it even blocks magic-links, which can be an even bigger issue depending
> on what kind of program we are talking about). Alas, RESOLVE_BENEATH
> requires education...

So does this prctl, when you get to that - any references to "service manager"
that might turn it on are contradicted by the "after startup" bit in the
original posting.

IOW, I very much doubt that this problem is amenable to cargo-culting.

_If_ somebody wants to collect actual information about the use patterns,
something like prctl that would spew a stack trace when running into
.. would be an obvious approach, but I would strongly object to even
inserting a tracepoint of that sort into the mainline kernel.

