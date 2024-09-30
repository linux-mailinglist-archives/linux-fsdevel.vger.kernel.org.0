Return-Path: <linux-fsdevel+bounces-30397-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2765B98ABC2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 20:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8937281E0A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 18:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CDAF191F67;
	Mon, 30 Sep 2024 18:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tY8sFwM/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A319191F82;
	Mon, 30 Sep 2024 18:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727720103; cv=none; b=XtkBMgtRRXmF5Xwr2v338I6ntRtZ2Hh+jBvbELQgV+CJNYewbQZLvIaWRsa1nmHC94bZfisyI2ZHrI+eJrM3+ANNm3Di9/t4+KjlT9nS7YTc3n3R28Uz/IiuhsQHda9CPzLlrq8WGxzyAJo0iAFWCEpT/kVOMChdjDuZ23gnl6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727720103; c=relaxed/simple;
	bh=Y9UIpHe+siA8FR+ez2E5i3b+gbJKwzDjhBVYk4GyLaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bpFTIypTfyVLFyd0/Jfbx+kBt8uTwuv0c/gOHrMFWrQd4PWB1ORggYE/Luyv+HkCub5NBUcqig3vEzu7WFWDlwi0jKhWJwvBbr40g9bzX41PKhTV/SWx8/R29aPpDItMOzLlCcKMnBWcj1Q1pT6ljmrmFiyH+Sp7VsXinC94Bfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tY8sFwM/; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wOCs00RL/8YdRkEJRfFh/lmIJtXzREnR4LZwIYVds8U=; b=tY8sFwM/UPJOVlNnRtqgeVINuu
	YTywwj0+LVVutFg+BCjyc3UXVwt+4Ewdu5LPer24IMeYcTpg4+6X3fHff7G05aUx7cVLcRtd2olyT
	ZoRcwDi0Pfv88DRDOudHTVSTpbQmghhxZgu084Je2YkAwvBHKw0032R2END4SPDvUI0hHsH1V/x8w
	2qFrdqnoBbPwpV0w3pIqPTCn0iZ8MkMA8t/BclrxjsyqkL5IGKLecEY3BhwzJu+m/2KChnId+Eate
	5j4XM1B1h+gx8csuzA/Q4eGpHpOF3mb4XRo9PIXbsvdqvA7H6gqRN7oofpHEMchanvd64DLQ3DnTV
	JCiX2sQg==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1svKvC-00000000Jgz-3OLb;
	Mon, 30 Sep 2024 18:14:58 +0000
Date: Mon, 30 Sep 2024 19:14:58 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Gianfranco Trad <gianf.trad@gmail.com>
Cc: akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	skhan@linuxfoundation.org,
	syzbot+4089e577072948ac5531@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] Fix NULL pointer dereference in read_cache_folio
Message-ID: <ZvrqotTfw06vAK9Y@casper.infradead.org>
References: <20240929230548.370027-3-gianf.trad@gmail.com>
 <20240930090225.28517-2-gianf.trad@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240930090225.28517-2-gianf.trad@gmail.com>

On Mon, Sep 30, 2024 at 11:02:26AM +0200, Gianfranco Trad wrote:
> @@ -2360,6 +2360,8 @@ static int filemap_read_folio(struct file *file, filler_t filler,
>  	/* Start the actual read. The read will unlock the page. */
>  	if (unlikely(workingset))
>  		psi_memstall_enter(&pflags);
> +	if (!filler)
> +		return -EIO;

This is definitely wrong because you enter memstall, but do not exit it.

As Andrew says, the underlying problem is that the filesystem does not
implement ->read_folio.  Which filesystem is this?

>  	error = filler(file, folio);
>  	if (unlikely(workingset))
>  		psi_memstall_leave(&pflags);
> -- 
> 2.43.0
> 

