Return-Path: <linux-fsdevel+bounces-23535-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F26492DEA5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2024 04:54:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 062DA1F21F43
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2024 02:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFB1810A36;
	Thu, 11 Jul 2024 02:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="1PWwHz0w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F408F72;
	Thu, 11 Jul 2024 02:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720666450; cv=none; b=ZWaRlVPgDndPwUT4LcUvOCpewc4talbb4XqeQxWvZZOeE4dD3x389K1rTOxl5/1CdXJwvlqmOh+a+oNMlj0TPvki2TM8mpqzk4FMt2LQsvznK99WRDbTa0u9b6g7Oj5n7kb+sma8/bDxpt1ZOGVkS8JuUNvEXw6fdkKLGfMoTwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720666450; c=relaxed/simple;
	bh=P4gfxTD1rLSFZX17JW++6WtqSz3tvVefep02FlLkYwo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=iEh4X1Z0pSeOeV9w2rlLJqf5WUxp/i7eQnxdpUFTjxoIRvk/WwWD3ORJkF440AmVWI7Cz7z7+sGNa8BdN63IDnnfeqQUS73Bb/YeHn94C/q/51XGgVYoFCkqYiYcc+JUswm3jn23wuEp1kZhuEc8wVuGZlZvNowysp45vZsgkVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=1PWwHz0w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 081C6C32781;
	Thu, 11 Jul 2024 02:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1720666449;
	bh=P4gfxTD1rLSFZX17JW++6WtqSz3tvVefep02FlLkYwo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=1PWwHz0wwbI/Mrq8tpOSiydwAAa8r4NY1fxs0DcR51Kp02EPFgJ+L56MnApm6soiE
	 SQ0ThVxXLuINj8gy6jovFVUD2xf50tOC7MHsriu4yYzPmTcfFEIQzjNYggbbGYet8W
	 iuKDiG5tKWDUsTFyScAs1TEnXCK6RPO8miAskeY0=
Date: Wed, 10 Jul 2024 19:54:08 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, "Liam R . Howlett" <Liam.Howlett@oracle.com>, Vlastimil
 Babka <vbabka@suse.cz>, Matthew Wilcox <willy@infradead.org>, Alexander
 Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan
 Kara <jack@suse.cz>, Eric Biederman <ebiederm@xmission.com>, Kees Cook
 <kees@kernel.org>, Suren Baghdasaryan <surenb@google.com>, SeongJae Park
 <sj@kernel.org>, Shuah Khan <shuah@kernel.org>, Brendan Higgins
 <brendanhiggins@google.com>, David Gow <davidgow@google.com>, Rae Moar
 <rmoar@google.com>
Subject: Re: [PATCH v2 0/7] Make core VMA operations internal and testable
Message-Id: <20240710195408.c14d80b73e58af6b73be6376@linux-foundation.org>
In-Reply-To: <8a2e590e-ff4c-4906-b229-269cd7c99948@lucifer.local>
References: <cover.1720121068.git.lorenzo.stoakes@oracle.com>
	<8a2e590e-ff4c-4906-b229-269cd7c99948@lucifer.local>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Jul 2024 20:32:05 +0100 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:

> On Thu, Jul 04, 2024 at 08:27:55PM GMT, Lorenzo Stoakes wrote:
> > There are a number of "core" VMA manipulation functions implemented in
> > mm/mmap.c, notably those concerning VMA merging, splitting, modifying,
> > expanding and shrinking, which logically don't belong there.
> [snip]
> 
> Hi Andrew,
> 
> Wondering if we're good to look at this going to mm-unstable? As this has
> had time to settle, and received R-b tags from Liam and Vlasta.
> 
> It'd be good to get it in, as it's kind of inviting merge conflicts
> otherwise and be good to get some certainty as to ordering for instance
> vs. Liam's upcoming MAP_FIXED series.
> 
> Also I have some further work I'd like to build on this :>)

It's really big and it's quite new and it's really late.  I think it best to await the
next -rc cycle, see how much grief it all causes.


