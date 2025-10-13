Return-Path: <linux-fsdevel+bounces-63901-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E60EBD150B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 05:14:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C33FB3BFE90
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 03:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02CC027A129;
	Mon, 13 Oct 2025 03:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vZW84afp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B111C8FBA
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Oct 2025 03:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760325240; cv=none; b=PvV2/7FM+ZroSiPiywP75/wkiuMQs0ASegNhE70rbYeTQTJanwW/94shIl58Kt8OTq3dOPokVZqUU+aDdaehTgjVAZjcGhEP+kdAGqUGVuAIb3H54ie0s1Vb6I/5+JaN9EBWPvIQv6ZQ0jCD+tB13ZnfnE61J8W+bkabMToiwFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760325240; c=relaxed/simple;
	bh=1KuM07DklDEJVSvMk1pn3hUqPwuRFYLWS14waLmLVDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dIlgutX2KNHXOvfrXsluPqdEZl1IoRipbr2lmWhz3Nbd1RGy1lI5NZxRP22G60hJiBipekL0nb8mLe0YsW50NyzvG4/AuvbaF+Z2Cl0jmKy0av5YHflvmf28CdgfLDJyu1Qpbt0bW4fily/FrdtFunCTBGveztZkycfXXQYwYF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vZW84afp; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1KuM07DklDEJVSvMk1pn3hUqPwuRFYLWS14waLmLVDU=; b=vZW84afpWro2kibpXNMbl4Muae
	raQuvVJdujI7PA5OJQ+2Jw+5iWdBpIwbPif1NZAK5HJ5pFFAtMTCK+3SSvAPn1hbweD2rUg0XMDBa
	ciz/lo+wOupskQmkTAJrDQZ84IuJMc+BxcrjAw1u1VC6OmIbDvdZs1v0M9IG3zAC1B9VojXQMwx7n
	V9RNzJ8jl7icUgofzxxPoDVtf8PKb7eJq/uAnvZcQQ8NOCq34qnu9tlXkBYCcxWxBLZZzXG19tPBm
	hYT0j0BjnNgFRIC79c7CwcRvTUSPnzQNe/0fOeBgS0HAzWCn4pXWzp5sQEDkBW+SseM1Ss9W7pZxH
	sVlQ86Rw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v890Y-0000000C9Zs-3KJe;
	Mon, 13 Oct 2025 03:13:58 +0000
Date: Sun, 12 Oct 2025 20:13:58 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: brauner@kernel.org, djwong@kernel.org, hch@infradead.org,
	bfoster@redhat.com, linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH v1 9/9] iomap: use find_next_bit() for uptodate bitmap
 scanning
Message-ID: <aOxudlu0DMClP_IT@infradead.org>
References: <20251009225611.3744728-1-joannelkoong@gmail.com>
 <20251009225611.3744728-10-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009225611.3744728-10-joannelkoong@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Same comment about the kerneldoc comments as for the last patch, but
otherwise this looks good.


