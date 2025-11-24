Return-Path: <linux-fsdevel+bounces-69642-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B7120C7F8E0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 10:20:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D0D2B34317F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 09:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18FDE2F5A2E;
	Mon, 24 Nov 2025 09:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BMJlNHuz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDCE2F5A16;
	Mon, 24 Nov 2025 09:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763975892; cv=none; b=W5W/t4dlpzh6sSsCpJB+6nL8TLrNRpFXO9b1UplI0ax2cKIwoOl5wLyRBgxWMv8NOJisFubvfL4AgNXyod9hHuWp8x+W04fLPZs9h6UZ7901arm/nTIZcof6xjiW1Y70gnQKqWPSQKi3T1CuA4sGGUWZXLFp7U4g64d/9UtnxWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763975892; c=relaxed/simple;
	bh=VMT3O+H4aucYaML2+XobPbAF+e72DtPp1C+cHKrd6Rw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JsV/mAhYVJl9Q0fCIqpfGWfZuh117ouQqqECoSH5qIIdouXmtp+cgT+5nMKvpA/BijE3/wgqaeIBkwB1EPBVWvuEAwY6UnCrz24GxyVisQN+vafPhYGGazQVOyiSDrhqAhymbx6VvJwQy+YqAm2NqRE44BRn4XsVRjsKDNQQ0OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BMJlNHuz; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=W2F/adHZGDVImEoRBSp+dIUFq+ETbkxrVwhRAz6tSTA=; b=BMJlNHuzF6Tjl009ADmBcnXcAc
	Xm+bdrdMdhelo2G8jjypp6V0/Sxt2QTl9uTi1TKzw0pgrfRwCqbs01691MX+tcXuACLXCToOYKix4
	BX/g87rIAunTPhU17ZqaRz6Kb06b+f8JJEWK+WMlOHCCfLd6d79/OOYK82Ekg1Esm25ob8vOtxKjH
	mNNz/NEl/MzTRsh/SkdeiZzPqGYKSTyZPpHh685oAcOHbjoLM91h24pbqAGmG53Y3B6oUmQGaMIra
	sWbZIuhX7zCKxQsXhS2gNYrh9kyskkKM9u0v3iucFfohEu78Ev0JW0MLZbGFZ1uBGiw1fDlaFpsK9
	3DyUuLrA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNSi1-0000000BKUh-2UEG;
	Mon, 24 Nov 2025 09:18:09 +0000
Date: Mon, 24 Nov 2025 01:18:09 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Edward Adam Davis <eadavis@qq.com>
Cc: syzbot+a2b9a4ed0d61b1efb3f5@syzkaller.appspotmail.com,
	brauner@kernel.org, djwong@kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH Next] iomap: Add sanity check for dio done workqueue
Message-ID: <aSQi0e8SmY5OVLcS@infradead.org>
References: <6923a05a.a70a0220.2ea503.0075.GAE@google.com>
 <tencent_734A1B432559BAF7BBA333429E581B034B08@qq.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_734A1B432559BAF7BBA333429E581B034B08@qq.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Nov 24, 2025 at 04:53:04PM +0800, Edward Adam Davis wrote:
> The s_dio_done_wq was not allocated memory, leading to the null-ptr-deref
> reported by syzbot in [1].
> 
> As shown in [1], we are currently in a soft interrupt context, and we cannot
> use sb_init_dio_done_wq() to allocate memory for wq because it requires a
> mutex lock.
> 
> Added a check to the workqueue; if it is empty, it switches to using a
> synchronous method to end the dio.

Err no.  That sanity check doesn't do anything useful.  Whatever caused
it to be not allocated and allow I/O needs to be fixed.  And I suspect
it's my fault and I already have an idea how to fix, so don't rush it.


