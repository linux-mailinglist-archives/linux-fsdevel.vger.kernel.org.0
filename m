Return-Path: <linux-fsdevel+bounces-22437-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 812D19170C4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 20:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1E431C214D0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 18:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BDFE17B428;
	Tue, 25 Jun 2024 18:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="hgSVGb09"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5CD18637;
	Tue, 25 Jun 2024 18:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719341936; cv=none; b=YEUuqEp0ef0BQbggGIi92LznK0qf2OWxgNZNJOU/zXGRMs2q/T+tt2PxppX4q5ieDJ3oAXhpndm4gpeSmh9a+o2dIXhvVxaPp8UTcINwoOVePWorK3DVA7zlaHNtd3X/+D5n3yZG3B6unKHJh1ou+Kv3zZ7aq4fzUpqNjHO2slI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719341936; c=relaxed/simple;
	bh=HnzguDloUEtpKY0hUDF6LolHIiTC4/EVM6A0YIqbboY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=sjfwm7P8YLKS+sPSvLbu0MATLK/4k0FaFqMVaOpBEsNM3Ro7towvLWbIm/Pe/J1KZDJgQFYLYQlsKn+vUKoHwuhHaWRyOHMpmQF0k7MMt9tWon/ALvVIsgsCdGiME6wizp/1wlRjwpJzbIJSBGkIFI2j/+jt9xHJi3Jq485uvvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=hgSVGb09; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E255C32781;
	Tue, 25 Jun 2024 18:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1719341935;
	bh=HnzguDloUEtpKY0hUDF6LolHIiTC4/EVM6A0YIqbboY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hgSVGb09p6RVPa4VD4wM6ajuJroxiqb5xQdfqesS5PCPPRXDunHNOTSEVcSJHy9aG
	 +AuPVRaLbE+4K02gIVLz9bVDxefp/JOMbeEGZFYNJBMU6CMbqHiqdiA3q0ovQILLFr
	 vALgd9Ze5FR2OAiJ1268wWqu4HG99NS5CHNrS4hA=
Date: Tue, 25 Jun 2024 11:58:55 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: David Hildenbrand <david@redhat.com>
Cc: Gavin Shan <gshan@redhat.com>, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 djwong@kernel.org, willy@infradead.org, hughd@google.com,
 torvalds@linux-foundation.org, zhenyzha@redhat.com, shan.gavin@gmail.com
Subject: Re: [PATCH 0/4] mm/filemap: Limit page cache size to that supported
 by xarray
Message-Id: <20240625115855.eb7b9369c0ddd74d6d96c51e@linux-foundation.org>
In-Reply-To: <33d9e4b3-4455-4431-81dc-e621cf383c22@redhat.com>
References: <20240625090646.1194644-1-gshan@redhat.com>
	<20240625113720.a2fa982b5cb220b1068e5177@linux-foundation.org>
	<33d9e4b3-4455-4431-81dc-e621cf383c22@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Jun 2024 20:51:13 +0200 David Hildenbrand <david@redhat.com> wrote:

> > I could split them and feed 1&2 into 6.10-rcX and 3&4 into 6.11-rc1.  A
> > problem with this approach is that we're putting a basically untested
> > combination into -stable: 1&2 might have bugs which were accidentally
> > fixed in 3&4.  A way to avoid this is to add cc:stable to all four
> > patches.
> > 
> > What are your thoughts on this matter?
> 
> Especially 4 should also be CC stable, so likely we should just do it 
> for all of them.

Fine.  A Fixes: for 3 & 4 would be good.  Otherwise we're potentially
asking for those to be backported further than 1 & 2, which seems
wrong.

Then again, by having different Fixes: in the various patches we're
suggesting that people split the patch series apart as they slot things
into the indicated places.  In other words, it's not a patch series at
all - it's a sprinkle of independent fixes.  Are we OK thinking of it
in that fashion?


