Return-Path: <linux-fsdevel+bounces-14966-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3443885908
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Mar 2024 13:24:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 210A21C2092B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Mar 2024 12:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EBD5762C6;
	Thu, 21 Mar 2024 12:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XCC37G0t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D8676036;
	Thu, 21 Mar 2024 12:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711023833; cv=none; b=L5XnVIfUO+AaJjqjo8cZFD+gkaT7B6IjoQV/Qdg+HfcWGWA5hlm61EIREpZDx8gYMBnrtu2HySfuAiDrkZ6VW62Nqq19yjNvSEcy+RKP5kX+QK2+lQ/RdwkGzAV/stCUlG1NmqBrZ2zT75fSkLb/Am9Ujzi4eUYN8j4IOl8x6u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711023833; c=relaxed/simple;
	bh=xiasNIBZOqw1cYdYjNN5AKStifHdqUgg5zBqP7kv5S4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Myxj8rV7G95gvhog35nfkgKA52E3tvhCcu3pc8JlkFZjV3uuzDG8EPeqBi0jcwopNigeFCY7NoAL8lDCptjkP2T6BHp0eUy8hyhvmwxKNd4aDKZUAG+aAvByuKQa9y4fOzKG6alOa+h/MZQGYlFTfFN5DE1fwr6g1PGZ1rJ4h/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XCC37G0t; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=w+60oXtOYQe8xUgVPdhKzujQQbWCeTry0UWI16et6do=; b=XCC37G0t/VDxrWlnbkb64x5eut
	GTJs+sIWygUT16RO47628u8rSc+FX0nX4Pzdg4bfIrnjaXxmT/P0XoO4W7qa5JDbrZI7OwxXJEkLf
	OhUDw6JqyiQPiB83pOI4sSqGvmLY9zOCTeUCW0rgXtSXc7Cg9UsyaDHTcSeZoAyGHtmk67bPq+vDD
	foCufIRJsGFyCnsxtuAARNaWaySvJkcwsZry6pEdBBlvkbx5DMD+7KBc+NH8xeYoJJzC7qDxLph7T
	MN6lKtKSszy70WetzejQOUfzYrgWTT+GXeaZhNW4m2XSL6vIjGs8ABQCN5C6jCS9A1S3kjdnczIG5
	oOIbRA0Q==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnHSP-00000006hw8-0ZZw;
	Thu, 21 Mar 2024 12:23:41 +0000
Date: Thu, 21 Mar 2024 12:23:41 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Benjamin LaHaise <bcrl@kvack.org>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-kernel@vger.kernel.org, linux-aio@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/3] fs: aio: use a folio in aio_setup_ring()
Message-ID: <ZfwmzeRk3ysl6TtV@casper.infradead.org>
References: <20240321082733.614329-1-wangkefeng.wang@huawei.com>
 <20240321082733.614329-2-wangkefeng.wang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240321082733.614329-2-wangkefeng.wang@huawei.com>

On Thu, Mar 21, 2024 at 04:27:31PM +0800, Kefeng Wang wrote:
> +		pr_debug("pid(%d) [%d] folio->count=%d\n", current->pid, i,
> +			 folio_ref_count(folio));
> +		folio_mark_uptodate(folio);
> +		folio_unlock(folio);

You can use folio_end_read() here.


