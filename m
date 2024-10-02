Return-Path: <linux-fsdevel+bounces-30695-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E73298D70B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 15:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 317D21F245C0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 13:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA2491D0B9B;
	Wed,  2 Oct 2024 13:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BB3NM2dg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2357E1CF5FB;
	Wed,  2 Oct 2024 13:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727876716; cv=none; b=NgmNmefZ7qc66Axf5v12tafkc0UVPpn5adFDJII50sCXUh1+GM70sYy0ZhEdOwqEgS0aV2d769dmD70pKeMBrHKFZLa6YnVVMTYcKrZBqfNR4aqyw3ku3OdKWuM43bfK2WLQYEhxwz73FS/BHPM398rksXEpNWuLybpcmXda/pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727876716; c=relaxed/simple;
	bh=95aln3qOco0qmCKlUm1UX+qk6i1JsLaMsPR6i3qKkoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TSGWdTIw0UAOXinDVtS4efner2ynpq/7yQQBkoDOI4JsMcnVF8beel9iWDX90LTJaYrM1A9W6XGU/ZfzYrpMDC1UbW0gmTKhDegIxu4EZmLwTiuWqm4e2CwXZ+NZnMRpBU9lfooc/fQ4zD6lhARfAroDA6bh/NwHYk4M6ey2hHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BB3NM2dg; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=VhL7rMfUxdeWtUmY1afN+IW8AF2DhKEBgefO1sz1kgY=; b=BB3NM2dgPaSTHJa1yRMSmLuQxu
	L297wgFbCX1AII8nNjfivYqvhXWVBnff9iQSmS9A47jQWXV5sgvx5q0lrNMg9RV1KNj6U1m1ppzRA
	X5ki3WCfav3pjfUTQ53VHe2F1xGEo6Cxgl6wn+cIj3tfgG2bbBsY2wpKy2HQN2cGwJJQruqL/U1sF
	8UAppd1WcFDQkNAKs66M4ENnmZKtT34gcLsOeCOvZV7fuRbC7iwS0MaUxpT9/7UJEzf8YisSl2Bc9
	jnOtbMDgHBAWE8325eRxczG4J96qAsZmVxJqzo5nFMc1VqS+aK/VmMDGgOQos9EWrqWL4BmMBkCUT
	ExVTNP1Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1svzf9-00000006CLW-3pRa;
	Wed, 02 Oct 2024 13:45:07 +0000
Date: Wed, 2 Oct 2024 06:45:07 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Tang Yizhou <yizhou.tang@shopee.com>
Cc: willy@infradead.org, akpm@linux-foundation.org, chandan.babu@oracle.com,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 3/3] xfs: Fix comment of xfs_buffered_write_iomap_begin()
Message-ID: <Zv1OYxSYWUHarUrL@infradead.org>
References: <20241002130004.69010-1-yizhou.tang@shopee.com>
 <20241002130004.69010-4-yizhou.tang@shopee.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002130004.69010-4-yizhou.tang@shopee.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Oct 02, 2024 at 09:00:04PM +0800, Tang Yizhou wrote:
> From: Tang Yizhou <yizhou.tang@shopee.com>
> 
> Since macro MAX_WRITEBACK_PAGES has been removed from the writeback
> path, change MAX_WRITEBACK_PAGES to the actual value of 1024.

Well, that's an indicator that this code need a bit of a resync with
the writeback code so that the comment stays true.

