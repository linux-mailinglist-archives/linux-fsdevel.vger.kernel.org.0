Return-Path: <linux-fsdevel+bounces-34677-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 87CBC9C79F7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 18:32:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DE28B399C3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 16:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA7D7167D80;
	Wed, 13 Nov 2024 16:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UU/+B1QB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E8A2309AF;
	Wed, 13 Nov 2024 16:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731515456; cv=none; b=OJbZgN3HEDzChr4dG0wzhVpNuaAMkhhPqQtO/U68BRpVIoNHfF/zOOYzILB6B6//ig8lbG6WRqkkIfaEBevnIzdoIcGdWYfuFE9ZHpJ5aDHHgmJhm2g+SEc5Vgs+91pqxzLntsRz6ip9jADCyY5v0hSztZYoExFPD7qy5WKZaIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731515456; c=relaxed/simple;
	bh=/Pc+XoKRa5TA1javHVNq4frDw/xLYCpyj8F1hq0KAPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hEdR6PzcAHvg8QY7Zgeg/1HNBOf4XjHlm2IRW396tSbkX5l1ZrerHzRPUR70I8lFLuwTyZaemicKgmo3r5odGTjXK6nIUz27fLv9iQqdABgZixMm4wj+0xYyNMmorgM4KLu7bZVigbME97b/Z6BaTM7jlL21NpyzDZAyWWIPIlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UU/+B1QB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42F40C4CECF;
	Wed, 13 Nov 2024 16:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731515455;
	bh=/Pc+XoKRa5TA1javHVNq4frDw/xLYCpyj8F1hq0KAPc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UU/+B1QB4s32mczM4WhANX+V3HaRMPrrThS187b0YtNrHFAwxIH29ku3QOunle2zX
	 iKVXKctG6klFIYBsXMMmJ7HclUVUFzuot1HsXMV6uUBvIlOMtuTEUIlybJ1uSgSbSO
	 xsgV8qwlTHVLCGUOVYOZcU3O6tMsUN5X68+4s9JlZNeYXdRzK3eusZ4QmfH2hnk+kY
	 DKLz2HZwHD70KEpvdkOhI9FvSMeKbjFQ0JXNhng+t8vgyxd8aVHcYIylXvrOREP99s
	 wfjcUePRl/1QUtljbqcBMWaVPE/P/3UedP9tPX/oNf8oSsAZPe+SpCfkwJpcZYFAul
	 /WZwvK6WFaFhA==
Date: Wed, 13 Nov 2024 17:30:51 +0100
From: Christian Brauner <brauner@kernel.org>
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, 
	Karel Zak <kzak@redhat.com>, Christian Brauner <christian@brauner.io>, 
	Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH] statmount: add flag to retrieve unescaped options
Message-ID: <20241113-wandmalerei-haben-9b19b61e5118@brauner>
References: <20241112101006.30715-1-mszeredi@redhat.com>
 <20241113-unbeobachtet-unvollendet-36c5443a042d@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241113-unbeobachtet-unvollendet-36c5443a042d@brauner>

On Wed, Nov 13, 2024 at 01:27:08PM +0100, Christian Brauner wrote:
> On Tue, Nov 12, 2024 at 11:10:04AM +0100, Miklos Szeredi wrote:
> > Filesystem options can be retrieved with STATMOUNT_MNT_OPTS, which
> > returns a string of comma separated options, where some characters are
> > escaped using the \OOO notation.
> > 
> > Add a new flag, STATMOUNT_OPT_ARRAY, which instead returns the raw
> > option values separated with '\0' charaters.
> > 
> > Since escaped charaters are rare, this inteface is preferable for
> > non-libmount users which likley don't want to deal with option
> > de-escaping.
> > 
> > Example code:
> > 
> > 	if (st->mask & STATMOUNT_OPT_ARRAY) {
> > 		const char *opt = st->str + st->opt_array;
> > 
> > 		for (unsigned int i = 0; i < st->opt_num; i++) {
> > 			printf("opt_array[%i]: <%s>\n", i, opt);
> > 			opt += strlen(opt) + 1;
> > 		}
> > 	}
> > 
> > Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> > ---
> 
> I'm likely going to snatch this for v6.13 still. I just need to reflow
> the code as the formatting is broken and maybe rename a few variables
> and need to wrap my head around the parsing. I'm testing this now.

Please take a look at the top of #vfs.misc and tell me whether this is
ok with you.

