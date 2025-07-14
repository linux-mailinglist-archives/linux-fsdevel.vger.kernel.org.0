Return-Path: <linux-fsdevel+bounces-54864-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40284B042B9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 17:09:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B45561891C58
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 15:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EADF25A320;
	Mon, 14 Jul 2025 15:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="cjrGdaLS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D44259CA0
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Jul 2025 15:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752505777; cv=none; b=lPuYGWdzNe5L06A3G7TxK64/Lgn/Q5spuXU2i62pl9t2G3jB82MMcqUZpFNu800sYKMoZveGjTPZ+8xu/81BdpHibuX9O5y4Bzyu1oSLAFCycfZdHmh4NM3koZNxOSvKwRnAVZATSAmSKSPHFDaX3CnKHml5GYsumndndjpr6EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752505777; c=relaxed/simple;
	bh=lAyCQfJ/iOwah7cbexFLKyE7u1HnOq6y3ZYToGoBkVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t3bm5K6A2K/wLckYeSPIJ3Q5a6c1J1L4tCCrRGCU2lElHJYIHIeH2P9O0wZo95CtTLkOefCsobeOK0tMqT0Zkhv7jV2htyfm8hSa2NiBteIV6hhvBJP6Wznttcjt9PhpOLdBriqC9P0P4iUymezFp3p9EkDfeEWrytax78QauY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=cjrGdaLS; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=owSnA+4u5+/893B2fxQ4m1N2YZIi71s1A0PUnJYJrNU=; b=cjrGdaLSXvbwMY2ojFxrfGktMt
	ZNb2TMWjxQT0KZeS7aYkm71ftodnrV6JcWyuG009R5igitHe5b39rLE3uZlzcKRXPdlB9s1u+X/na
	I2nyZRWp62eG5xTQ4dKEscntciOoUqxSFr7gJQ0deHJ35VahC1vifEBsz+XwqMmpIpVnk4d5MV18c
	Q0cLNlHkzuAHou9RTqER5mHdVn0kInW5yk4rjMrkg9/Sun54q8HjvJ3HXft6jcLrYwZxultgUje9Q
	sh0gKf7DokVCyYQHpjQmC/C6ueMtkq/BvB0HIsRC6iIyb7x2B++TTu9ATwPLXQWaNexZwxOphOwW/
	eRKEUZVg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubKo9-00000008xzI-0HHq;
	Mon, 14 Jul 2025 15:09:33 +0000
Date: Mon, 14 Jul 2025 16:09:33 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: =?iso-8859-1?Q?J=FCrgen_Gro=DF?= <jgross@suse.com>
Cc: linux-fsdevel@vger.kernel.org,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Subject: Re: [PATCH 2/2] xen: fix UAF in dmabuf_exp_from_pages()
Message-ID: <20250714150933.GH1880847@ZenIV>
References: <20250712050231.GX1880847@ZenIV>
 <20250712050916.GY1880847@ZenIV>
 <107f0e09-cd9a-4e09-9f1a-d9c892dfa04a@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <107f0e09-cd9a-4e09-9f1a-d9c892dfa04a@suse.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Jul 14, 2025 at 09:57:02AM +0200, Jürgen Groß wrote:
> On 12.07.25 07:09, Al Viro wrote:
> > [dma_buf_fd() fixes; no preferences regarding the tree it goes through -
> > up to xen folks]
> 
> I'll take it via the Xen tree.

Thanks, I'm dropping that one on my side...

