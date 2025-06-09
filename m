Return-Path: <linux-fsdevel+bounces-51069-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 794A7AD280C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 22:49:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA5D37A7602
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 20:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE53221278;
	Mon,  9 Jun 2025 20:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="T5Pt7E/v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E586D8F40;
	Mon,  9 Jun 2025 20:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749502135; cv=none; b=hQBJHvjXNl1HY/zaSlz7vNO7BfZHdTdKfdrKeg7y99lWAMw63zKxfb8y1fb1E8tlPHh6A85i/U+KJmx5zMLvJsiMesjLBQQhtYccoxKUaJoDLCwxv3pIiLB5y73e1WPqz2onZyRC4WzCz7Nx7Qxt9WZc4QmIVXwfdLEc0YbiISM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749502135; c=relaxed/simple;
	bh=BbylnXMDljaBHyc9rSMVIJONPpTA1nJHbzOSVi4nMPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s/whtjzVCBokQVNgpiq2IUYZfeK12EyPy4I706leU57oqbj6aS+w32bgDAlEKHAyQ2+S8+0Dl1BQpMTWdqSRHQnsEzgCEEZD/ID4yzgzhYOBX8QLOut1rb6pd4i9Uo8Wf4+Z5AOw4yZuMYW0yPtrtfDD5Dyf14SiFVwau6Mi3P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=T5Pt7E/v; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=oJ0XlIsk5G25C5qCHOroSyNzywC12UcQLttP2Js+zCc=; b=T5Pt7E/vG5+N3/LLA/JnM8K4EY
	mp5tZW7D4q0WBssO3i5R3PIK/qRbn5zKfmumaSPz85IicFCYA7f+XiL40CE/ovVbwBzOj/ALf8TFh
	MG7IoZz5AZRNNPkq2KtwncNmAKsD/Ky79gwagUlRS/BP1mOrmupg6xzNaYih6u77fhdM/o0fFr/AZ
	9a/IOg5p3e/TJl7E2uhGpphrxapCUhb01Kd8SP8ScyuQjyB1LhMDAwDf+z+1nikwhxVpMsUckepAV
	dky8rUzl6P8TNz8qPzgQSqho3fniszDxP/y5pX5bZk/iFgCDRn3uOODfuKBxihWFgM/tcM5dxkuyy
	+xVpkzsA==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOjQH-00000008doG-3sQP;
	Mon, 09 Jun 2025 20:48:49 +0000
Date: Mon, 9 Jun 2025 21:48:49 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Jan Kara <jack@suse.cz>
Cc: Xianying Wang <wangxianying546@gmail.com>, viro@zeniv.linux.org.uk,
	brauner@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [BUG] WARNING in bdev_getblk
Message-ID: <aEdIsaZIcR_co42X@casper.infradead.org>
References: <CAOU40uAjmLO9f0LOGqPdVd5wpiFK6QaT+UwiNvRoBXhVnKcDbw@mail.gmail.com>
 <x3govm5j2nweio5k3r4imvg6cyg3onadln4tvj7bh4gmleuzqn@zmnbnjfqawfo>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <x3govm5j2nweio5k3r4imvg6cyg3onadln4tvj7bh4gmleuzqn@zmnbnjfqawfo>

On Mon, Jun 09, 2025 at 03:54:01PM +0200, Jan Kara wrote:
> Hi!
> 
> On Mon 09-06-25 16:39:15, Xianying Wang wrote:
> > I encountered a kernel WARNING in the function bdev_getblk() when
> > fuzzing the Linux 6.12 kernel using Syzkaller. The crash occurs during
> > a block buffer allocation path, where __alloc_pages_noprof() fails
> > under memory pressure, and triggers a WARNING due to an internal
> > allocation failure.
> 
> Ah, this is a warning about GFP_NOFAIL allocation from direct reclaim:

It's the same discussion we had at LSFMM.  It seems like we have a lot
of "modified syzkaller" people trying this kind of thing.

