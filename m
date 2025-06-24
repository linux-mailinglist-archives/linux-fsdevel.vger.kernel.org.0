Return-Path: <linux-fsdevel+bounces-52768-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 191F8AE65AE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 14:57:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79F3A165917
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 12:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C2129AAEC;
	Tue, 24 Jun 2025 12:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TOXe86FT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613CE293C6C;
	Tue, 24 Jun 2025 12:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750769657; cv=none; b=UHbgn021Q0ZvdUAN6GOqiDyUH4hMLiCfxfB/+lrz9pkMSeV9E8+9ZCAk9dsMzHGIdVgB4bDS4cK5lStieoDqQSViiQIJ5Iux5iwBWy0ImcC8GGOPSrx2D4R6IfV09o29FqdMB03+IvlxI5BXftOA5x150jxzIY9lrgMixjL2IaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750769657; c=relaxed/simple;
	bh=5ovYbXQYys+DyZKG9JRf4Df0UI9wgCclm0f3wvOkCL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MuIiqT+9WiQPKXPz1+flRv1fpIDMSNJWKsGBnKLJRYbCzMRtFPBBuyLGZdbGNyQPb1SP9u4p2onnMayD1aDXiO7e59A9xCC7qXsmk7N6iIeggsRmlvCAilHMKkUfPIsWJiNTAJrU9u9QyLwrL11SsGdfxeSTM/+OmK28Lr3HPHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TOXe86FT; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=FvVXFAHgqlVXaYjZe73wCkbdcF0aH935v03BBBUDZRY=; b=TOXe86FTv0MPRze00++nXzCcJA
	+5PyOKUZ7cpy6JL2U5kGvgMu8ORyFaZziNTER/jEp4X62HR4Ibj3jFCUUFP9BzEHGo/EOKRRtkMUG
	QFladtV50stPYTTm/+Ui8/nB+VdNdi6nXE6cBhsrXkN5TrMABlbLnzZvhIqJHBshB9CSF5hJ7Tfrx
	yup8lhHQJR9weUS7kmICBfirR7/u4A5u61/IZxu+gVxvfyRocRkN1DePS0jMuM+GMRCaOagHMGIH6
	aBO2xir65idRZ2xulTdiQBi0jWpVLfs6t7VVEY5jijZ4TUG6QZVY03q+aL71XwHitc7/vBvc5gawa
	KxFqJ/sw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uU3AA-00000006cFM-28B1;
	Tue, 24 Jun 2025 12:54:10 +0000
Date: Tue, 24 Jun 2025 13:54:10 +0100
From: Matthew Wilcox <willy@infradead.org>
To: =?utf-8?B?6ZmI5rab5rab?= Taotao Chen <chentaotao@didiglobal.com>
Cc: "tytso@mit.edu" <tytso@mit.edu>,
	"hch@infradead.org" <hch@infradead.org>,
	"adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
	"brauner@kernel.org" <brauner@kernel.org>,
	"jani.nikula@linux.intel.com" <jani.nikula@linux.intel.com>,
	"rodrigo.vivi@intel.com" <rodrigo.vivi@intel.com>,
	"tursulin@ursulin.net" <tursulin@ursulin.net>,
	"airlied@gmail.com" <airlied@gmail.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"chentao325@qq.com" <chentao325@qq.com>
Subject: Re: [PATCH v2 0/5] fs: refactor write_begin/write_end and add ext4
 IOCB_DONTCACHE support
Message-ID: <aFqf8sbGsQ0kEme3@casper.infradead.org>
References: <20250624121149.2927-1-chentaotao@didiglobal.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250624121149.2927-1-chentaotao@didiglobal.com>

On Tue, Jun 24, 2025 at 12:11:59PM +0000, 陈涛涛 Taotao Chen wrote:
> From: Taotao Chen <chentaotao@didiglobal.com>
> 
> This patch series refactors the address_space_operations write_begin()
> and write_end() callbacks to take struct kiocb * as their first argument,
> allowing IOCB flags such as IOCB_DONTCACHE to propagate to filesystem’s
> buffered write path.
> 
> Ext4 is updated to implement handling of the IOCB_DONTCACHE flag in its
> buffered write path and to advertise support via the FOP_DONTCACHE file
> operation flag.
> 
> Additionally, the i915 driver’s shmem write paths are updated to bypass
> the legacy write_begin/write_end interface in favor of directly calling
> write_iter(), using a constructed synchronous kiocb. Another i915 patch
> replaces a manual write loop with kernel_write() in shmem object creation.

Thanks, this is a really good cleanup.

