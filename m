Return-Path: <linux-fsdevel+bounces-29751-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34EFB97D6C6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Sep 2024 16:19:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0442A283F09
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Sep 2024 14:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F41317BB2B;
	Fri, 20 Sep 2024 14:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZvlwmYzp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC73417C7C6;
	Fri, 20 Sep 2024 14:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726841971; cv=none; b=iFfjbcXBjjTXCQW1qbCmPM7whoniM5tJKKlRBzfH7XEMH+9BDy6zyr+ZuaiZrgfkmZqAvMiZ35NwJITEk3vJYYD+pPFDVCAvBmgdphPh+2VBxIqGDkYwuh2MZ8wKn9UY/YkN9fWhLrB9uI+rWWr3vH7o6lMfJeAsk6L8eZDyeP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726841971; c=relaxed/simple;
	bh=B88Ww65HFmZO81ZNyaVCvWXkUAFmrDys+/L1tNggPvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tx6nata63wnmBn2EGsz2nMp4C2B61r5fmjmPuPJEPslgJC4y70Um/nfztPTA6YpXHKktYditTDfi36g6++JXXJbaNYEc/vRmQbLRysAGVyHjr6agomZE8dKDmqKGduLvGhxJyIL6ullVdCv3G7bY9r9eMVEs4zjHKPSVdflVW4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZvlwmYzp; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=B88Ww65HFmZO81ZNyaVCvWXkUAFmrDys+/L1tNggPvI=; b=ZvlwmYzpoYSG38I5jUJN1pM3Rz
	LKkSlyl6kK9UeBPPo+6VQoJweEea/Lfjuk3iKAE5uLnyR9bbuQwUZ3XD3kuQdGnp6+XpKyN38YyqD
	d6qz93IrWnnbwZQ0ugosITOVHuBK9OnIUFpo4VtkqIkWN9EZycyBPRNpmPdgYm17DNyu5PU9Tys7Z
	rue+w9PVDBqy7ZdamYGuPP7GnePHxqPz9J91S7Rc1gPCnTgDb148WunUcX5ws2vw9MQ/wX6fffWy7
	ouBcXvpVH7Xi9+7sH+6+2VN9iDAUV7ScMOQNV1Ii0gGF02C9gDoJbxL3yAlbw5wXbVHVPP0m20NaF
	onZI3PdA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sreTo-0000000CMeX-1zmM;
	Fri, 20 Sep 2024 14:19:28 +0000
Date: Fri, 20 Sep 2024 07:19:28 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Julian Sun <sunjunchao2870@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	stable@vger.kernel.org
Subject: Re: [PATCH 3/3] vfs: return -EOVERFLOW in generic_remap_checks()
 when overflow check fails
Message-ID: <Zu2EcEnlW1KJfzzR@infradead.org>
References: <20240920123022.215863-1-sunjunchao2870@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240920123022.215863-1-sunjunchao2870@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Sep 20, 2024 at 08:30:22PM +0800, Julian Sun wrote:
> Keep it consistent with the handling of the same check within
> generic_copy_file_checks().
> Also, returning -EOVERFLOW in this case is more appropriate.

Maybe:

Keep the errno value consistent with the equivalent check in
generic_copy_file_checks() that returns -EOVERFLOW, which feels like the
more appropriate value to return compared to the overly generic -EINVAL.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

