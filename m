Return-Path: <linux-fsdevel+bounces-28327-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 999B0969630
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 09:54:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC1FC1C232DE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 07:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 065CE200129;
	Tue,  3 Sep 2024 07:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JNkzqV9+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E7D20011A;
	Tue,  3 Sep 2024 07:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725350027; cv=none; b=edGKOjfyCZihH+wHqd6upgOzGWjBKn/JmGxS72VW86O2DxpCHC3nLsQLmQ/7M+aVxKjZmQ7OxrLAIgls5X5ZtgCoq/cIZYVVA/qMyzZ6kWQmkJfjdGyKL//W4ZnMkwN49F7u/HHMkS1lBVD1nvlfap6ocYktRoxhFbmAcOzrGZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725350027; c=relaxed/simple;
	bh=wi97ztJZt4//LuOM70DFndgCCb8iG8N6VoALz1a2qLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gUlK+Tv4qfAz/VBeBmGrSw9LyFq50DiWI/pM6OObkpEpONowkRY3jQofloJaBQJHJsWPQiBCxuQ/rs0A8AWNam5AeTlMD+nIoDucZ65PNyalq4yBb1V2ETt+VImEJCEC810qxw+zga3fb+GNorEkAIxOzHQWOEa19uTpLb8+mws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JNkzqV9+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50385C4CEC9;
	Tue,  3 Sep 2024 07:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725350027;
	bh=wi97ztJZt4//LuOM70DFndgCCb8iG8N6VoALz1a2qLQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JNkzqV9+zSHQFCYe21kFf+c9yLni+bwTAn8iPnvdizzzOF7w4Q38VVSrF20V3RFwu
	 AI3ozPaYrQQKnJ1fGGmQIqLAJy0KTTETiyrv3Y5c7Wkh037WDXf3ul6XqgPgenHelx
	 m09aPF0rW0HuzqE20/ISZ+LK3KlwUtvJjZ17stiaa6FWHGumRYSrUIjbqRa7G0LT8n
	 uAuOQHXh/F8QGSPChaRctR7SxMwUB62Wdh1lqJh8EIbmmAVVHzpT+QghOlYSd3dFYQ
	 ZEyCqRVIuv5Z2NlOZ9WWVH0bo0RFMrPPE37/vh2WbeiFyQc0vQlLzAPJqenRJcwKXG
	 ZCk5TpV81ah1Q==
Date: Tue, 3 Sep 2024 09:53:41 +0200
From: Christian Brauner <brauner@kernel.org>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: Matthew Wilcox <willy@infradead.org>, sfr@canb.auug.org.au, 
	akpm@linux-foundation.org, linux-next@vger.kernel.org, mcgrof@kernel.org, ziy@nvidia.com, 
	da.gomez@samsung.com, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	Pankaj Raghav <p.raghav@samsung.com>, Sven Schnelle <svens@linux.ibm.com>
Subject: Re: [PATCH] mm: don't convert the page to folio before splitting in
 split_huge_page()
Message-ID: <20240903-eidesstattlich-ununterbrochen-bdda2e9eba98@brauner>
References: <20240902124931.506061-2-kernel@pankajraghav.com>
 <ZtXFBTgLz3YFHk9T@casper.infradead.org>
 <20240902-wovor-knurren-01ba56e0460e@brauner>
 <20240902144841.gfk4bakvtz6bxdqx@quentin>
 <20240902-leiblich-aufsehen-841e42a5a09d@brauner>
 <20240902193520.hvtjrnyqmosnkfff@quentin>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240902193520.hvtjrnyqmosnkfff@quentin>

On Mon, Sep 02, 2024 at 07:35:20PM GMT, Pankaj Raghav (Samsung) wrote:
> > > > > This should be folded into the patch that is broken, not be a separate
> > > > > fix commit, otherwise it introduces a bisection hazard which are to be
> > > > > avoided when possible.
> > > > 
> > > > Patch folded into "mm: split a folio in minimum folio order chunks"
> > > > with the Link to this patch. Please double-check.
> > > Thanks a lot!
> > > 
> > > I still don't see it upstream[1]. Maybe it is yet to be pushed?
> > > 
> > > [1] https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/commit/?h=vfs.blocksize&id=fd031210c9ceb399db1dea001c6a5e98f3b4e2e7
> > 
> > Pushed now.
> 
> I can see it now. Thanks Christian. :)
> 
> This patch has a merge conflict in linux-next. It should be a trivial
> merge but let me know if you want me to send a patch for it.

No need, Linus will usually just sort those out.

