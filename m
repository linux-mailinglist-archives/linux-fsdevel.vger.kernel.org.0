Return-Path: <linux-fsdevel+bounces-43264-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC633A502B5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 15:52:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6900D3A2293
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 14:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A4A24E4AD;
	Wed,  5 Mar 2025 14:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MU/UkorE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4940A248885;
	Wed,  5 Mar 2025 14:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741186012; cv=none; b=GDFQ679KkzR9aUgr4gSis44LlWohnFr3VuXFLBHWriLJM+8Mh1e2oIWsQxondPriMCyJ5oI7/CKkVGvNqTTOtbKhyjecMD14GyoFp8I0QlronXYec2hOdVjmG0xPwzg1vLlmChxjmkaxfP4TTbBxYByqkGk5aFf69B8dH3FL7zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741186012; c=relaxed/simple;
	bh=td9GWGpZCmiEAG4NRmj3Vt6e3H57F2nliCpx9zjtguE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s5H7Pbv4TMGZdayLO+UdTdtuuZSykns3bFcVUGHfWdoSXGM6BG2yOGrFsU1xr1bf7fRBVEvNZGAMemm0RLTmDwN0mlFs0rAymKNdTzQNEJSy4Sd5JT6v0HPJVTImZEGZrhBPmn1TRccFI4t0Y7ky08dKOJXSTlPAOJx8Dh+BmyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MU/UkorE; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=NQiHiWBYuLEjIBCwbtDawYA0OWXgtE0nlWIHtE9qJ/A=; b=MU/UkorEJtYCTL/69PWWpAlTQS
	lJT1aQCWoVw57XnjyZJ0/P/XqTFLRedcJCU/f1ph8GVU+cS34ocBKwUyk7YDkboGQ1zN1L0hJ23+n
	AxGrg6p5FVoU6pKjYlwxPQAqU8cSdK/N1A1JnJouGIYJEhw7/qa2ds+gGhv59Fhkvr986eXOI8CWU
	ckgI4iliDeVkHKL8ZTJeK4hKJDMx+Mq6QwYwIgHV3WVVEc8Mol+cUeB9v+P+iolg18BqA7S/Qp5Zk
	58aBWO3aRzO0sinW0PiM/q/9BZMU+1+jCAH0mR6wOp6E01O9xWbHa3+jkcMaB1A2bKkjezmhmQ1/h
	CboY8POA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tpq1K-00000008Or0-3uVK;
	Wed, 05 Mar 2025 14:46:50 +0000
Date: Wed, 5 Mar 2025 06:46:50 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Chao Yu <chao@kernel.org>, jaegeuk@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] f2fs: support F2FS_NOLINEAR_LOOKUP_FL
Message-ID: <Z8hj2g_fj1zH1t_m@infradead.org>
References: <20250303034606.1355224-1-chao@kernel.org>
 <20250303230644.GA3695685@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303230644.GA3695685@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Mar 03, 2025 at 11:06:44PM +0000, Eric Biggers wrote:
> > +/* used for FS_IOC_GETFLAGS and FS_IOC_SETFLAGS */
> > +enum {
> > +	F2FS_NOLINEAR_LOOKUP_FLAG = 0x08000000,
> > +};
> 
> FS_IOC_GETFLAGS and FS_IOC_SETFLAGS are not filesystem-specific, and the
> supported flags are declared in include/uapi/linux/fs.h.  You can't just
> randomly give an unused bit a filesystem specific meaning.

Eww, yes.  This needs to be reverted ASAP.

And I'd like to repeat my reminder that we need to stop file systems
(and f2fs is particularly bad for this) to stop just adding random
uapis without review from linux-fsdevel and linux-api.


