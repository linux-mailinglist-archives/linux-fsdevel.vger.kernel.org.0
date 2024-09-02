Return-Path: <linux-fsdevel+bounces-28263-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 509BF9689CD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 16:21:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82C5B1C229A9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 14:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A4D19E97C;
	Mon,  2 Sep 2024 14:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jd7uHjY0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4451E179AA;
	Mon,  2 Sep 2024 14:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725286875; cv=none; b=tweNjAOWIfTjJVFLFIYHyA7CxvAhF7ca/j0VoQ8mqS1GHyDftPfapoSY+fCf9K81CSEm/IK0BeMdRuBOod4DHA5eGJttJ9v27kjfAZVOCwORVYiC1ycE1629CtcPUi5cGaGPmtR0qTxQg5OaBDBFVQ4nrYy1bGNuC5bsMgeUEpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725286875; c=relaxed/simple;
	bh=Rf8IRDfTz4kH7RDQ5fkcSZ15ZZH4xdrWwGbRA5GROZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NvpghyOjIp0ophXf8+8sIfPp+tmM2BVTzNkUau83rZcDUbHDa+fXZZeVAcrLWtK4B3kpd2BI4mpj/t/ckk5WzPbMewzh76fpya0rDmE6Gib3rSfxjI8N2tqjupAZmhfY2rKbryrK5sAuWjACHTNUhVPEfVRdizF5KCyyti5NHHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jd7uHjY0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BE19C4CEC2;
	Mon,  2 Sep 2024 14:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725286874;
	bh=Rf8IRDfTz4kH7RDQ5fkcSZ15ZZH4xdrWwGbRA5GROZ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jd7uHjY0rT97aWkhW+uvWagPzLhpTIpnVX1P+4zXYSoEihJj3TO4Su2GB/OJtkGts
	 I5aBvcoEgPpu/ylyHr+CAy8qEEcPbPClOMLu4kVj+1+66PFzaM5cLG++HybBUE5k9S
	 V4NWqpLFpCqSyCrXpwBIS2oM/DBGGf30pxQosp8oVMDgbAAYvFmHctdnquJ5+mRMUy
	 Jd5OSloYqUa5Q5PQBsw97UWA2WG7xOhEuoH+gKGWgbVrj0HtKkgvAIcT+FtrnzSBWT
	 /F34102/l6pDKi8ZgrEI5Z4cVDSmOXXB5LBq7S03Z9bCesj6IrDVpcRaaJCju4jg95
	 6sfIT4CJrh+XA==
Date: Mon, 2 Sep 2024 16:21:09 +0200
From: Christian Brauner <brauner@kernel.org>
To: Matthew Wilcox <willy@infradead.org>, 
	"Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: sfr@canb.auug.org.au, akpm@linux-foundation.org, 
	linux-next@vger.kernel.org, mcgrof@kernel.org, ziy@nvidia.com, da.gomez@samsung.com, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, Pankaj Raghav <p.raghav@samsung.com>, 
	Sven Schnelle <svens@linux.ibm.com>
Subject: Re: [PATCH] mm: don't convert the page to folio before splitting in
 split_huge_page()
Message-ID: <20240902-wovor-knurren-01ba56e0460e@brauner>
References: <20240902124931.506061-2-kernel@pankajraghav.com>
 <ZtXFBTgLz3YFHk9T@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZtXFBTgLz3YFHk9T@casper.infradead.org>

On Mon, Sep 02, 2024 at 03:00:37PM GMT, Matthew Wilcox wrote:
> On Mon, Sep 02, 2024 at 02:49:32PM +0200, Pankaj Raghav (Samsung) wrote:
> > From: Pankaj Raghav <p.raghav@samsung.com>
> > 
> > Sven reported that a commit from bs > ps series was breaking the ksm ltp
> > test[1].
> > 
> > split_huge_page() takes precisely a page that is locked, and it also
> > expects the folio that contains that page to be locked after that
> > huge page has been split. The changes introduced converted the page to
> > folio, and passed the head page to be split, which might not be locked,
> > resulting in a kernel panic.
> > 
> > This commit fixes it by always passing the correct page to be split from
> > split_huge_page() with the appropriate minimum order for splitting.
> 
> This should be folded into the patch that is broken, not be a separate
> fix commit, otherwise it introduces a bisection hazard which are to be
> avoided when possible.

Patch folded into "mm: split a folio in minimum folio order chunks"
with the Link to this patch. Please double-check.

