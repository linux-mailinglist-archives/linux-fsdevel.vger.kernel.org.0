Return-Path: <linux-fsdevel+bounces-73143-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C2761D0E144
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Jan 2026 06:20:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 992AC300645F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Jan 2026 05:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0B01EBFF7;
	Sun, 11 Jan 2026 05:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RvGej+xI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A319476
	for <linux-fsdevel@vger.kernel.org>; Sun, 11 Jan 2026 05:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768108811; cv=none; b=YLtSPwWHFFG4CGz18dndHikvPCWQSSUUceHMECgNG8r5Qvsz6g+tzfqwd3OsJqAhoaROgIUUrBT1HgF3GTre7fMVXKZ+y2seZZHwELnjnIpHh/37/XmPMBOwFFgxluFQV2LtCt7JoahkJ8e+9uaDWvGIkM+IdaKtuz3/S+MaM14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768108811; c=relaxed/simple;
	bh=fHq80VtejPmDT8LHfsquHD3AQWILmZeo8X4m5YmWkzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DMYpm83PKY1njBrEzSuFXrApUX7IXVg2+W3D5x0y36rfKJoWVCYGzuar5qewa5WLU1S+4jUIt/TBbhTT4a4siCTXfFw4Xits6LpSZFk9hEZwOek955YHuu9NrflF8MHtyVg0mjhlboCx9ub4jPxj7bSoxO3ftnHtKGsJpBYYQaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RvGej+xI; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=YneoakZxZ6NvpJ6KmJ4KAf/obqoS6Em1w3b8fAAUv8s=; b=RvGej+xIGxg2VvbqIjQroFa28R
	R8RNaEA5UYgXaaIxctbuTU0/hRl977Ao1yjnWKND6fuHTAf0oQ+aeL7xkDV+Wrz5X2ubcPnXjAZ/I
	/KjEhITXoENXLf+Hb5aAj4uRoJG/wjX5bf0CIOkdH5h1bsfowGH4wChCU4QLzpE+QelcGVEdcSr+Y
	nqpIdIpiQZg8skrFd1vkvbQqs2JNfqyoZltiCs84ijvs3sdt1q2LbY1LZ3nMFl9H+wczLpudOU0CN
	vm0g6aKFW0l8HOrWQ0GO9A1SzQSK5Q+TNRA0JYRbDU1tbKN+lvMBmgG7LLEpL8h4LTcYr2moZHM67
	pjGRnRHw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1venrn-00000001USU-3ejh;
	Sun, 11 Jan 2026 05:19:55 +0000
Date: Sun, 11 Jan 2026 05:19:55 +0000
From: Matthew Wilcox <willy@infradead.org>
To: yuling-dong@qq.com
Cc: linkinjeon@kernel.org, sj1557.seo@samsung.com, yuezhang.mo@sony.com,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v1] exfat: reduce unnecessary writes during mmap write
Message-ID: <aWMy-4X75vkHmtDE@casper.infradead.org>
References: <tencent_E7EF2CBD4DBC5CC047C3EB74D3C52A55C905@qq.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_E7EF2CBD4DBC5CC047C3EB74D3C52A55C905@qq.com>

On Thu, Jan 08, 2026 at 05:38:57PM +0800, yuling-dong@qq.com wrote:
> -	start = ((loff_t)vma->vm_pgoff << PAGE_SHIFT);
> -	end = min_t(loff_t, i_size_read(inode),
> -			start + vma->vm_end - vma->vm_start);
> +	new_valid_size = (loff_t)vmf->pgoff << PAGE_SHIFT;

Uh, this is off-by-one.  If you access page 2, it'll expand the file
to a size of 8192 bytes, when it needs to expand the file to 12288
bytes.  What testing was done to this patch?

