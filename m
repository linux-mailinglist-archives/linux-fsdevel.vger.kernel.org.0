Return-Path: <linux-fsdevel+bounces-29631-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD3197BA5C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2024 11:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C2C4B24295
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2024 09:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC52C17E44F;
	Wed, 18 Sep 2024 09:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ODkjPOlU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4657B16E860;
	Wed, 18 Sep 2024 09:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726653076; cv=none; b=jyP+xH7H4Ux3b/E2Y+cbFFl9d9m8vEKCgzK7NNWEkTMpTiX59nonS/f+62zBfRz+geKrOpGWBOtewslgup2ppd7HD3sUdeQ+3yZguLLZJ7+tJvc/9oshtGEWZ+YV2MIWApJoNN8glwC8piyFjnPblUY9wfNeiCeOZIKbWmNzAu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726653076; c=relaxed/simple;
	bh=L28pSEH2Qs5aYQHvisV8vDOvgSb7Lbzbx9KlpIjyxG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tRQJd9PJMKhAGImuHOVUytCRCp7DcM8mCmeuiun2rnrX90ZNgy/qWPfujy4yvJXZvXP2nN+YnLv11a+IYCMQyp7NOJElrQCgzlr7s/eYDScPG/mAXAjRkNIt74gvEUDxU3m2RKamXZf1dGVv+wj08wjf0Q86ay0KVLaQpLM2Sbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ODkjPOlU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E97ABC4CECF;
	Wed, 18 Sep 2024 09:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726653075;
	bh=L28pSEH2Qs5aYQHvisV8vDOvgSb7Lbzbx9KlpIjyxG0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ODkjPOlUTZmXZB+TH1d/ul+Smkw5Y03ibLg63CmNrHfAikVkAyIZoHeYaZv0nfz41
	 xKWykYRjXfzAUlx0JJC96cScMJRlJWTPVSHPQ5F65+5X0UKu2mVO7CIyz0MiMx2ZdZ
	 0NzCHkaOmNCQUqSq0Y1qOWBdg30tZtJljrqzUfumiuwojU0uG6VwKovOaq/gjyZyXz
	 UcisB7Mj5Q/iuAAwFxTxusZaGDD45SRJ6hSiBUoZfzPixhGLOd45PIjAT5TxQiNzp1
	 CIfHveBHormIvxcZwKNah6l+KQa0tLn9fDDZJ/ioOYT3NYL1k8HxZBJr/SBBQTb97Y
	 lqB8FQ7fXB1WQ==
Date: Wed, 18 Sep 2024 11:51:09 +0200
From: Christian Brauner <brauner@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Pankaj Raghav <p.raghav@samsung.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, Christian Theune <ct@flyingcircus.io>, linux-mm@kvack.org, 
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Daniel Dao <dqminh@cloudflare.com>, Dave Chinner <david@fromorbit.com>, clm@meta.com, 
	regressions@lists.linux.dev, regressions@leemhuis.info
Subject: Re: Known and unfixed active data loss bug in MM + XFS with large
 folios since Dec 2021 (any kernel from 6.1 upwards)
Message-ID: <20240918-geordert-bedecken-93c97e15e82e@brauner>
References: <A5A976CB-DB57-4513-A700-656580488AB6@flyingcircus.io>
 <ZuNjNNmrDPVsVK03@casper.infradead.org>
 <0fc8c3e7-e5d2-40db-8661-8c7199f84e43@kernel.dk>
 <CAHk-=wh5LRp6Tb2oLKv1LrJWuXKOvxcucMfRMmYcT-npbo0=_A@mail.gmail.com>
 <20240913-ortsausgang-baustart-1dae9a18254d@brauner>
 <ZugyzR8Ak6hJNlXF@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZugyzR8Ak6hJNlXF@casper.infradead.org>

On Mon, Sep 16, 2024 at 02:29:49PM GMT, Matthew Wilcox wrote:
> On Fri, Sep 13, 2024 at 02:11:22PM +0200, Christian Brauner wrote:
> > So this issue it new to me as well. One of the items this cycle is the
> > work to enable support for block sizes that are larger than page sizes
> > via the large block size (LBS) series that's been sitting in -next for a
> > long time. That work specifically targets xfs and builds on top of the
> > large folio support.
> > 
> > If the support for large folios is going to be reverted in xfs then I
> > see no point to merge the LBS work now. So I'm holding off on sending
> > that pull request until a decision is made (for xfs). As far as I
> > understand, supporting larger block sizes will not be meaningful without
> > large folio support.
> 
> This is unwarranted; please send this pull request.  We're not going to
> rip out all of the infrastructure although we might end up disabling it
> by default.  There's a bunch of other work queued up behind that, and not
> having it in Linus' tree is just going to make everything more painful.

Now that there's a reproducer and hopefully soon a fix I think we can
try and merge this next week.

