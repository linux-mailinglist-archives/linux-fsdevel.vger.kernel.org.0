Return-Path: <linux-fsdevel+bounces-2765-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E237E8E82
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Nov 2023 07:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FAFA280D1C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Nov 2023 06:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AECD65238;
	Sun, 12 Nov 2023 06:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FQ2HdP3F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02F85220
	for <linux-fsdevel@vger.kernel.org>; Sun, 12 Nov 2023 06:00:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 257FAC433C8;
	Sun, 12 Nov 2023 06:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699768822;
	bh=l+L09L563+pGJYcgLbAkZAdd2BZHKLgIRaiaDG/DoAU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FQ2HdP3FLOFJHJmtdJPEDfxQiVeqgz/t86enBvDRmdI/YwI6VlVGP4/yLG1E9wQb3
	 queBR1j65xWqEowV59fAYaZRrVBl3bRpZ+Z9y0uUgo33PYeCVIfoM8Kpox1HPucTMB
	 U0HWDmFT1yOuXYikli8LNFre8e6Co1uQ03h6880ri0sev5Vo4TdCjezwjwynkZh5ho
	 wesHCigRhM/7m+puujM0o2D4tQDzUO8+I7tcCsR0AmIivfCbECaaot/wKCXQ1/5V8j
	 uZVHHjxK3l0YjakO3InNiM88j+Wea7r04F9aRwuOqKx8q2SWyprlu5eygYauRAHJoE
	 dDEtPDzdeb63g==
Date: Sat, 11 Nov 2023 22:00:20 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Hannes Reinecke <hare@suse.de>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Pankaj Raghav <p.raghav@samsung.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 7/7] buffer: Fix more functions for block size >
 PAGE_SIZE
Message-ID: <20231112060020.GA578127@sol.localdomain>
References: <20231109210608.2252323-1-willy@infradead.org>
 <20231109210608.2252323-8-willy@infradead.org>
 <20231110045019.GB6572@sol.localdomain>
 <ZU49o9oIfSc84pDt@casper.infradead.org>
 <20231111180613.GC998@sol.localdomain>
 <ZVBaKPHNM+9Ry7eq@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZVBaKPHNM+9Ry7eq@casper.infradead.org>

On Sun, Nov 12, 2023 at 04:52:56AM +0000, Matthew Wilcox wrote:
> On Sat, Nov 11, 2023 at 10:06:13AM -0800, Eric Biggers wrote:
> > On Fri, Nov 10, 2023 at 02:26:43PM +0000, Matthew Wilcox wrote:
> > > Would you want to invest more engineering time in changing it?
> > 
> > It seems logical to just keep the existing approach instead of spending time
> > trying to justify changing it to a less efficient one (divides).
> 
> Except the existing approach doesn't work for block size > PAGE_SIZE

A shift does still work; the block size is still a power of 2, after all.
'(sector_t)folio->index << (PAGE_SHIFT - bbits)' just needs to be changed to
'folio_pos(folio) >> bbits'.

- Eric

