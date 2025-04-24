Return-Path: <linux-fsdevel+bounces-47304-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE2BA9B9EA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 23:31:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 922134460B7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 21:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62823214A7A;
	Thu, 24 Apr 2025 21:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CmAS3BBD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB288C11;
	Thu, 24 Apr 2025 21:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745530250; cv=none; b=Y6ip7YMBd1tZWKYZ/fBBkg8o4YSNwWUXk5WzlxFz+UJ1qTNd7ZGZkNSDw3CO5t3SUwLtywpPmWzHFIK1OTUOmG8ABkcrDm7zW7HC8f0XmTUDn7qaCrfEhe5Jz7KIfi862IO6d8wuPooGlfVF6HjD3gp1DVmMSruQQZHzhpDIke0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745530250; c=relaxed/simple;
	bh=pV6rDLmzPyHgpmM5/gG0mAXX2tH37m1X1EYgl27WsuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pEIWAZ2FW4y/rt2GTS15CHM43yMCBSoqucmHL8IriQXZNKCWDBwIGieYV0hYoFJGULV0MhP9Q/nVQnfhfybL0Q27eu5FRYc83w45B+71IwykaVAKtOTdZEIY0lgWJsRqXvxUAZhoGl0VXacrH50g6xzeaLr8IY2d1CFNH4dwQeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CmAS3BBD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17720C4CEE3;
	Thu, 24 Apr 2025 21:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745530250;
	bh=pV6rDLmzPyHgpmM5/gG0mAXX2tH37m1X1EYgl27WsuE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CmAS3BBDPLzzZ4lbb+TZ8fX+06Z7wtRRqaHNGBmCRR1U+QwE+E7e8JDq3voa29DYM
	 MIP7AwlNRcqU2ku7KCwsQ85/hgtKAjPtOyXBSeDBS54RmlKe7fAcNUhUd0g6KZ4Lf+
	 VwSS554olrTQWCtFj40BI4fNzXCX6DM3oM+xEiZh5BS6FkE6VRzA249f2I9yp9SGbp
	 GgdiBmS8DEpXBrU6me6ZZ5TfavrUG+X8DXujPbFqHZ29rylumjvEcPNs8A95ZFbKzp
	 b1UY7Je87xvhUm66WcQyGXDzyYLhsh59BseJf3Y8/KWwetC9xUTjThUEKnzqtYnrIo
	 e/eSNWrEblC9A==
Date: Thu, 24 Apr 2025 17:30:49 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: trondmy@kernel.org
Cc: linux-nfs@vger.kernel.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH 2/3] filemap: Mark folios as dropbehind in
 generic_perform_write()
Message-ID: <aAqtiY7c6qhmPFHK@kernel.org>
References: <cover.1745381692.git.trond.myklebust@hammerspace.com>
 <b7ea4a2b3a8f38e2777ac0363a364141cf3db2e8.1745381692.git.trond.myklebust@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7ea4a2b3a8f38e2777ac0363a364141cf3db2e8.1745381692.git.trond.myklebust@hammerspace.com>

On Wed, Apr 23, 2025 at 12:25:31AM -0400, trondmy@kernel.org wrote:
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
> 
> The iocb flags are not passed down to the write_begin() callback that is
> allocating the folio, so we need to set the dropbehind folio flag from
> inside the generic_perform_write() function itself.
> 
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>

Reviewed-by: Mike Snitzer <snitzer@kernel.org>

