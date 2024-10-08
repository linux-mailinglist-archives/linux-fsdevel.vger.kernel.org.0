Return-Path: <linux-fsdevel+bounces-31284-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C9C9942F9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 10:57:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BF511C210CB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 08:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BA3518C00D;
	Tue,  8 Oct 2024 08:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kDY9HX/c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E5313C827
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Oct 2024 08:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728377188; cv=none; b=DdrEM7JN4YJ6zTgEatFqZ6tZEzd6lkV9j8haiZ+jTST200pBJbEVBTJDvQ/dwv+PE74fL29kOudl00ZPTWV44QJzz33bF9MHETdN00NBW7Y0KFJ5sG0CqVPk2Tw9ob4J7l90ep83+WCfghjrpZ7q6tmcw+r37Go9B3km5cuf0/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728377188; c=relaxed/simple;
	bh=8szYLqKKyxTax3jide3X0jKr5gWhHG0hju86NR+iJ9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bXiMmR/Tj1ja48x3Htq63XiIItivmPRBcTjP6ZHPDwIFsH91LfXEG6FgCxGq1poAFP4itwU4xcTR6KyoDJNI67zMzW8RJeOMbhxTe/aL2mDtSoCDXCCY3JhvgtDSzsoiWsSh5Vu2UlLwTVN/QD1u1CO39QMfIEYUSdBwBSZJh3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kDY9HX/c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A2CCC4CEC7;
	Tue,  8 Oct 2024 08:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728377188;
	bh=8szYLqKKyxTax3jide3X0jKr5gWhHG0hju86NR+iJ9o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kDY9HX/c9secNidyfMA6UUWTyk1YRhsTY4tF4/rW3Emgk4ahbRIZzmkEciBHUEUmd
	 BzCSPfSLlYo4uz0eKmmMQInE67o16lG2e8gXTZFbAXRc3WikZ4SOojcQYMlQW1akBR
	 Blk1uvZ7FmRiV1b7F/+6ZIfGqN7el/OHtwpAS5VxwSCquRP5xw20SSpbkM6JwpMAb5
	 1OF8/HiEWNu64LK0lIs56RQHkBMBjsEQjhwRVMWw4Gu0hk/uIgqJcaQ9eW1kNhgZuf
	 R70fQnWA8v2QMnYp/kKXxqf01D3EpQOu1P4JRiSOM8jlbObZsqyum/5Wd+Ezt4wzfY
	 +yOjkftl/pznQ==
Date: Tue, 8 Oct 2024 10:46:24 +0200
From: Christian Brauner <brauner@kernel.org>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Allison Karlitskaya <allison.karlitskaya@redhat.com>, 
	Gao Xiang <xiang@kernel.org>, linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org, 
	Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: Incorrect error message from erofs "backed by file" in 6.12-rc
Message-ID: <20241008-blicken-ziehharmonika-de395b6dd566@brauner>
References: <CAOYeF9VQ8jKVmpy5Zy9DNhO6xmWSKMB-DO8yvBB0XvBE7=3Ugg@mail.gmail.com>
 <bb781cf6-1baf-4a98-94a5-f261a556d492@linux.alibaba.com>
 <20241007-zwietracht-flehen-1eeed6fac1a5@brauner>
 <b9565874-7018-46ef-b123-b524a1dffb21@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b9565874-7018-46ef-b123-b524a1dffb21@linux.alibaba.com>

On Tue, Oct 08, 2024 at 10:13:31AM GMT, Gao Xiang wrote:
> Hi Christian,
> 
> On 2024/10/7 19:35, Christian Brauner wrote:
> > On Sat, Oct 05, 2024 at 10:41:10PM GMT, Gao Xiang wrote:
> 
> ...
> 
> > > 
> > > Hi Christian, if possible, could you give some other
> > > idea to handle this case better? Many thanks!
> 
> Thanks for the reply!
> 
> > 
> > (1) Require that the path be qualified like:
> > 
> >      fsconfig(<fd>, FSCONFIG_SET_STRING, "source", "file:/home/lis/src/mountcfs/cfs", 0)
> > 
> >      and match on it in either erofs_*_get_tree() or by adding a custom
> >      function for the Opt_source/"source" parameter.
> 
> IMHO, Users could create names with the prefix `file:`,
> it's somewhat strange to define a fixed prefix by the
> definition of source path fc->source.
> 
> Although there could be some escape character likewise
> way, but I'm not sure if it's worthwhile to work out
> this in kernel.
> 
> > 
> > (2) Add a erofs specific "source-file" mount option. IOW, check that
> >      either "source-file" or "source" was specified but not both. You
> >      could even set fc->source to "source-file" value and fail if
> >      fc->source is already set. You get the idea.
> 
> I once thought to add a new mount option too, yet from
> the user perpertive, I think users may not care about
> the source type of an arbitary path, and the kernel also
> can parse the type of the source path directly... so..
> 
> 
> So.. I wonder if it's possible to add a new VFS interface
> like get_tree_bdev_by_dev() for filesystems to specify a
> device number rather than hardcoded hard-coded source path
> way, e.g. I could see the potential benefits other than
> the EROFS use case:
> 
>  - Filesystems can have other ways to get a bdev-based sb
>    in addition to the current hard-coded source path way;
> 
>  - Some pseudo fs can use this way to generate a fs from a
>    bdev.
> 
>  - Just like get_tree_nodev(), it doesn't strictly tie to
>    fc->source too.
> 
> Also EROFS could lookup_bdev() (this kAPI is already
> exported) itself to check if it uses get_tree_bdev_by_dev()
> or get_tree_nodev()... Does it sounds good?  Many thanks!

Sounds fair to me.

