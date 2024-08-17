Return-Path: <linux-fsdevel+bounces-26172-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F09955570
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Aug 2024 06:48:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67CEA1C21D61
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Aug 2024 04:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C48181723;
	Sat, 17 Aug 2024 04:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UVwKGg4Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7053243178;
	Sat, 17 Aug 2024 04:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723870112; cv=none; b=hM9PYTXS9SzoE6YZFV4Ko4JflfhTXfG/fJ/GA9DFmpAYYYoFWtdZ4O0A5wxaw2sPCJqoxs9JlWruxEiZobFbZzFuQzyGEIzh3g0dd+ftM6u9QWvYhxYJQGhtx7tLeVMQ7bHj3aVZCA1axuCk3MLIstZp3BLXfbvTZx3+iqBVS1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723870112; c=relaxed/simple;
	bh=PygpxpNUk2hRyp2qs2HzQVUPLPgtvswr524+KQ2mjv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GGeibo3nCFfmS9V8JY5RqPTWYbJnoyqhAm2+091H2IPXH8xYtf8Cu1TYjpR2vrwkXqgBL8BQ5buV0QLk4RBtyso/TLK8REoOyd43xgds4ngHKLBvCzCqLH7HNcd8tZ4HldmfCag+MDbrHerHT7J0vA2st5+gztAFg7dDeVuS/Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UVwKGg4Y; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=FsyxxZkasH40L6wFWVwYUwPYeqZ7jmVoPtZhDwMuPMI=; b=UVwKGg4YO7Qg6+X87AT+QYEG8X
	nnS65pW1iYLUuzKlGFYEqObaA/Dnxwl/M5UAjMsnJCmwjy0+uF//lCzYEjGxMCFs3YHNhtFtom4KM
	LfQdhqf1PzJiDJAKMpXE3ryxXU7Nbr5gexNzdnmLdE+6ry5ImJLg6I3GP/niRgGoEZ6VpAswdYu+5
	gHEp4iAlrfHhmKK5uVXwEvJ1on0KwVuoz2ntfNoYwoYRJm4hXOLCUchJmwhWLYHY9003hEsLle7P9
	DILzl6K6rGWUARjdVfrGTEuNb9xSXXf2rNWi5FtP6BpmUnH8F1o3KpMIBNlmUXojDB0Te5qT0aiLa
	Jsa3i5qg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sfBMb-00000004Rk1-0Y60;
	Sat, 17 Aug 2024 04:48:29 +0000
Date: Sat, 17 Aug 2024 05:48:28 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, djwong@kernel.org, hch@infradead.org,
	brauner@kernel.org, david@fromorbit.com, jack@suse.cz,
	yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v2 5/6] iomap: don't mark blocks uptodate after partial
 zeroing
Message-ID: <ZsArnB9ItrxUmXHW@casper.infradead.org>
References: <20240812121159.3775074-1-yi.zhang@huaweicloud.com>
 <20240812121159.3775074-6-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812121159.3775074-6-yi.zhang@huaweicloud.com>

On Mon, Aug 12, 2024 at 08:11:58PM +0800, Zhang Yi wrote:
> +++ b/fs/iomap/buffered-io.c
> @@ -744,8 +744,8 @@ static int __iomap_write_begin(const struct iomap_iter *iter, loff_t pos,
>  					poff, plen, srcmap);
>  			if (status)
>  				return status;
> +			iomap_set_range_uptodate(folio, poff, plen);
>  		}
> -		iomap_set_range_uptodate(folio, poff, plen);
>  	} while ((block_start += plen) < block_end);

Um, what I meant was to just delete the iomap_set_range_uptodate()
call in __iomap_write_begin() altogether.  We'll call it soon enough in
__iomap_write_end().

