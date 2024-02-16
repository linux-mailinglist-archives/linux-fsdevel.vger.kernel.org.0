Return-Path: <linux-fsdevel+bounces-11823-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C628576AC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 08:13:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B08A31F22AE2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 07:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACCE814F62;
	Fri, 16 Feb 2024 07:13:32 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053481640B;
	Fri, 16 Feb 2024 07:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708067612; cv=none; b=Tjv0oFuZ9MFg26KdaQZRvhkedlKo97CYNP4tjy9RM06Hh6rBr3ZOQ3AJGPnT+DFN0IV/nnR4nK0r/Jl8jijbh3yL5dtjVajBku/Ak7PRWeDPSPl9vFpxMxFm8zLMR5Lo9kdAZyzQGSqNyjYLFOqEwSXe8z2aapikGQCAuifTwKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708067612; c=relaxed/simple;
	bh=ipIoSMeWfPxHI8AJiQjHPEUF71/wdxednTA8hvefudc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pqcYUiaM7tqROBjcgOABvhSR7jxVIF8apZAzH5PmoLLNNiSby6vp0w9E644z1EooCW2mOkHWRszbF6r5p7DNdJcJID1F7OVVBgnCONrP/fzZo70WUOhgOr1vJqtHwmh923Q8YqJ0MGnn1P1RMI2ASy/L6CxkCFPoOHZaLEwPuCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 750E468B05; Fri, 16 Feb 2024 08:13:25 +0100 (CET)
Date: Fri, 16 Feb 2024 08:13:25 +0100
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Avi Kivity <avi@scylladb.com>, Sandeep Dhavale <dhavale@google.com>,
	Jens Axboe <axboe@kernel.dk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kent Overstreet <kent.overstreet@linux.dev>, stable@vger.kernel.org
Subject: Re: [PATCH v4 2/2] fs/aio: Make io_cancel() generate completions
 again
Message-ID: <20240216071325.GA10830@lst.de>
References: <20240215204739.2677806-1-bvanassche@acm.org> <20240215204739.2677806-3-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215204739.2677806-3-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Feb 15, 2024 at 12:47:39PM -0800, Bart Van Assche wrote:
> The following patch accidentally removed the code for delivering
> completions for cancelled reads and writes to user space: "[PATCH 04/33]
> aio: remove retry-based AIO"
> (https://lore.kernel.org/all/1363883754-27966-5-git-send-email-koverstreet@google.com/)

Umm, that was more than 10 years ago.  What code do you have that
is this old, and only noticed that it needs the completions now?

I'd much prefer your older patch to simply always fail the cancelations.


