Return-Path: <linux-fsdevel+bounces-10216-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 070F9848CEC
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Feb 2024 11:39:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A7F21C21C03
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Feb 2024 10:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 733F621A06;
	Sun,  4 Feb 2024 10:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R0+vADoN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93C9210F8;
	Sun,  4 Feb 2024 10:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707043183; cv=none; b=tn1FNRf9SxmcFZGe8DM0KMoEOD1bJp2MXCfKaaSk1GdiVom6ijV4mDOOyt9Be/67U1pn1Q3A3N8sesVuqig4ESE8wEx8wx0RtsMc/fvn7gQPkHzDxSq8cou9aRqtB75qJRTZADxZgjP4fSG4WJ6vMSrpEgEWv7F9rgksmPMjCQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707043183; c=relaxed/simple;
	bh=iyoxJyYS1ovHgfgZClsPvcow6R3PPCC0we47Uz+xt0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fiMmWHZl52+XCPXiF8jhmVUHL+LVtyh6jr5zXfJYlvePxoq/JCBv+r6Ha7sO+ntDCnffaFO6mXw3k6G8EhLidHB2bFT6B0aQBRbXJB+G7WFS8VcjduFUU4sPyYEdcL8wOlm/P2aAoMpa2pGUodPm8u0xaOo6Yl/Fe6fhHKKYZrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R0+vADoN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 182E9C433C7;
	Sun,  4 Feb 2024 10:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707043183;
	bh=iyoxJyYS1ovHgfgZClsPvcow6R3PPCC0we47Uz+xt0M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R0+vADoNlIEK5wCnNQUPTWplg8vqRoOQ4lErZPgwdFQHb6X028MomFpHeBXXxYqQW
	 ewbTxmEY40Ffr8SbpyQqvQCmf5eAb9Gbi2qIc0eqUyRdmKwkrS8K+EE12tFZpAgSDb
	 duK0oUTehJb7GDqCv+SeDW+buwKdH/1sxkFn49uTRHpkxRCJbWYINuL3Z3CeY/46GE
	 eANkCxw7ZyWaPDphTfuuQ6nme1uck+O3CAxa1n9lCCHqS2YFK309CEOXohK+ggkkZE
	 dtoZtoe8t+kA8hwH9jeFbG/l3ydjG65LLwk17sCIr5C9D1NAfZf7JwE8mtaSSU2pkO
	 qBHfhlIXCe33w==
Date: Sun, 4 Feb 2024 11:39:33 +0100
From: Mike Rapoport <rppt@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-block@vger.kernel.org,
	linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-nvme@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] Reclaiming & documenting page flags
Message-ID: <Zb9pZTmyb0lPMQs8@kernel.org>
References: <Zbcn-P4QKgBhyxdO@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zbcn-P4QKgBhyxdO@casper.infradead.org>

On Mon, Jan 29, 2024 at 04:32:03AM +0000, Matthew Wilcox wrote:
> Our documentation of the current page flags is ... not great.  I think
> I can improve it for the page cache side of things; I understand the
> meanings of locked, writeback, uptodate, dirty, head, waiters, slab,
> mlocked, mappedtodisk, error, hwpoison, readahead, anon_exclusive,
> has_hwpoisoned, hugetlb and large_remappable.
> 
> Where I'm a lot more shaky is the meaning of the more "real MM" flags,
> like active, referenced, lru, workingset, reserved, reclaim, swapbacked,
> unevictable, young, idle, swapcache, isolated, and reported.
> 
> Perhaps we could have an MM session where we try to explain slowly and
> carefully to each other what all these flags actually mean, talk about
> what combinations of them make sense, how we might eliminate some of
> them to make more space in the flags word, and what all this looks like
> in a memdesc world.
> 
> And maybe we can get some documentation written about it!  Not trying
> to nerd snipe Jon into attending this session, but if he did ...

I suspect Jon will be there anyway, but not sure he'd be willing to do the
writing :)

I was going to propose the "mm docs" session again, but this one seems more
useful than talking yet again about how hard it is to get MM documentation
done.

And I can take on myself putting the explanations from this session into
writing.
 
> [thanks to Amir for reminding me that I meant to propose this topic]
> 

-- 
Sincerely yours,
Mike.

