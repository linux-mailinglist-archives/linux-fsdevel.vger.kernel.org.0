Return-Path: <linux-fsdevel+bounces-24138-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF8A493A1C1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jul 2024 15:42:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F8F3B22A37
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jul 2024 13:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B8C153567;
	Tue, 23 Jul 2024 13:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UgHeI8M/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244C8152DED
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Jul 2024 13:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721742101; cv=none; b=J8oZtV0z9Q94JkHll3nOGk7Zh68UHLKvDfONMatDFTAHHd1MmH7PnvQYvS/yk+KR5v+DVxUJqL77YBivU3C25JM40zodJAf1Xs6ErN83G2UU1sUhQC0RKQTQIaktW1P/MpQuFVpYtyAb0aSzvILM7OeUciWVzFa2PQpYAvqZS9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721742101; c=relaxed/simple;
	bh=rMOByJQHI2khDtaiv+xcSKk6ouhnYnI5/jz0qh3TF90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WJ78zqg5CNTgFSPcetVVy1he829cFdpJlEF+4fqksR63K1MCW8IsAn/8QUYni3vwTSgsF+O62+A5WU5eDJnoeFmlh8bVjKBk2/SVSEJhDyLFY1F2tS1ebAcBhqIFUCtyms/xavWhMV1V1yjHeouEsIv4RbPkVCxjSy0Wa6U2fzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UgHeI8M/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0192EC4AF0A;
	Tue, 23 Jul 2024 13:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721742100;
	bh=rMOByJQHI2khDtaiv+xcSKk6ouhnYnI5/jz0qh3TF90=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UgHeI8M/NTh5bruXfVrFBZ6pd9A0t1X9N8UEoofiTpoMFb+z8KgHZTiZrYMRsyFRe
	 ttn/DShW5Ze7J4QczKgSrIXo7oc3/b3+nw/OmO2kMwRvcVX1H2AIBPEUHqc/+9CI8m
	 KT7gLfZRRUAOIWmttnXj0pNcfyyb6PnfUEAU0Xc+u7BBqSsj7J2biX9JfjCMk3Eh3D
	 +nS8WaKyP66UAndoKz1qRwdhD0m663jiQCelZheE3+drP7MEgnX+UNnBoYL2EkVUR2
	 6hbZodHuIJEVHkIaW9AN81OZVX/rmJ2sFLYlVochPWAo9S/KsF7+9No75zJvDCN3Ol
	 lRN43xKU4tjyg==
Date: Tue, 23 Jul 2024 15:41:37 +0200
From: Christian Brauner <brauner@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 00/23] Convert write_begin / write_end to take a folio
Message-ID: <20240723-gelebt-teilen-58ffd6ae35ec@brauner>
References: <20240717154716.237943-1-willy@infradead.org>
 <20240723-einfuhr-benachbarten-f1abb87dd181@brauner>
 <Zp-uLk9wCP5tIc6c@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zp-uLk9wCP5tIc6c@casper.infradead.org>

On Tue, Jul 23, 2024 at 02:20:46PM GMT, Matthew Wilcox wrote:
> On Tue, Jul 23, 2024 at 09:49:10AM +0200, Christian Brauner wrote:
> > On Wed, Jul 17, 2024 at 04:46:50PM GMT, Matthew Wilcox wrote:
> > > You can find the full branch at
> > > http://git.infradead.org/?p=users/willy/pagecache.git;a=shortlog;h=refs/heads/write-end
> > > aka
> > > git://git.infradead.org/users/willy/pagecache.git write-end
> > > 
> > > On top of the ufs, minix, sysv and qnx6 directory handling patches, this
> > > patch series converts us to using folios for write_begin and write_end.
> > > That's the last mention of 'struct page' in several filesystems.
> > > 
> > > I'd like to get some version of these patches into the 6.12 merge
> > > window.
> > 
> > Is it stable enough that I can already pull it from you?
> > I'd like this to be based on v6.11-rc1.
> 
> It's stable in that it works, but it's still based on linux-next.  I think
> it probably depends on a few fs git pulls that are still outstanding.
> More awkwardly for merging is that it depends on the four directory
> handling patch series, each of which you've put on a separate topic
> branch.  So I'm not sure how you want to handle that.

I've put them there before this series here surfaced. But anyway,
there's plenty of options. I can merge all separate topic branches
together in a main branch or I can just pull it all in together. That
depends how complex it turns out to be.

