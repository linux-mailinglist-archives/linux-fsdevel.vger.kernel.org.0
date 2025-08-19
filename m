Return-Path: <linux-fsdevel+bounces-58309-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E6F0B2C704
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 16:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0D905241AB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 14:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 010B8265631;
	Tue, 19 Aug 2025 14:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="5EEY9cHJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97BC2110;
	Tue, 19 Aug 2025 14:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755613539; cv=none; b=sEPL3YymXZyjCdjYBG5PKrm797/LpbOoI04afmRCN3MZZWzk2gu4VF9wX6csBsDZp4J4A3vvFDMqEfNh2Zg2P70cWjgTYVmfh5BHa0CfhAszfaJIV7zmfRTtPXKUGqacvVMSNiJD69puoulEF2hB6Yr8jEhXtr7dvU6dCB9593A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755613539; c=relaxed/simple;
	bh=j4Z59QeCV/XyKUb6V851SkSjQJMAdAo+zoOnV4rAbC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jHClse+lRA/Bs6M/z5T3ECaJtTXMucZstdtYoVJ6Nbs8vHEuGC5UzKExu8TdgJ4jfOrOQwi3SAa51n4/AJUOeupBlTlyx8bcCcxQ+HnQjEBZCB/3lX9vy1LfBWWJFrhbEAY/6rDIgJA/UOdmnImoAk4vgLG+G6uXAE9eTZ7d3Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=5EEY9cHJ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=j4Z59QeCV/XyKUb6V851SkSjQJMAdAo+zoOnV4rAbC4=; b=5EEY9cHJuiylMR0XqEruFMryY3
	8iq7JdDb1CpzKvPCA+kHrTPSaeRfBJBSN4jMSJ5k+CnrJHaIqcw8gdriPF0DcIYvsZuwO7Ck4daz0
	Gf4E6nFM5Y08GkjcYgyeIti87FUHgpBESZLsKhbu3NZ0GtmjZOKL6NqzdnSL+uUM0WLL8fniTbaNw
	1tUpYJO2Ii8Llc9kcoBhmB15KWoK5xOcY8mO7Inp2a0LE7pSWOnk3H/GtRmApttqEBYNfkwCBjmLA
	Nj3y31YDBgih1BEOWN8sD8jiskDtr4UalnAFX+D+fU5Z8aFieBGyuNT/YrZuezubk0lUiC7l928Ln
	v9Vh6A7w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoNHN-0000000AkP9-0rrJ;
	Tue, 19 Aug 2025 14:25:37 +0000
Date: Tue, 19 Aug 2025 07:25:37 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Trond Myklebust <trondmy@kernel.org>
Cc: Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Mike Snitzer <snitzer@kernel.org>,
	Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v4 1/3] filemap: Add a helper for filesystems
 implementing dropbehind
Message-ID: <aKSJYTJdYHDgsHwx@infradead.org>
References: <cover.1755612705.git.trond.myklebust@hammerspace.com>
 <ee863d320994130efcccf132212ec0e23f4582ca.1755612705.git.trond.myklebust@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee863d320994130efcccf132212ec0e23f4582ca.1755612705.git.trond.myklebust@hammerspace.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Aug 19, 2025 at 07:18:30AM -0700, Trond Myklebust wrote:
> +EXPORT_SYMBOL(folio_end_dropbehind);

This really should be a EXPORT_SYMBOL_GPL like for any other linux-only
functionality. Same for the next patch.


