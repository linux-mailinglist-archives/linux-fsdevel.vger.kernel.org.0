Return-Path: <linux-fsdevel+bounces-13636-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E1C8723F0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 17:18:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F4FC288E9D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 16:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF12A85C7B;
	Tue,  5 Mar 2024 16:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aiRDqVEr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D50212839F
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 Mar 2024 16:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709655492; cv=none; b=JrPeI7AzHJRei5668yyte/SZVD+WoJ37Uh9J665GLBj15WbKlrqLZ9W1+c80Y1N77RV2Aiv0XKz0VShfXGq5xJDt+vQeckr+BFM8i8a/gcZKineW3IO+31oDgs9ATa4QAlI4jhml/8es7pBb3SnlkNYWUzn2E4zcFSG3QEGofJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709655492; c=relaxed/simple;
	bh=u0KaNZjkpZCOJyJqEP00wkGIXrVZnuiNtzgm8XKsx4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=owARotrSO8/xF4IUVtc1SfVEAtj6gb+k+KJ5E/BxD3czdGgDZ4+T7bR67+nDsdbwizlqBNtGRInrD2Kd9fybg6QFsdsVBA0PPyQZ75HL0CXLSKQROyHlYZnMZGqFzfGhC8O8yEVRM36JYd9LFdn1DwJlb9+cnf2JJxULufDRPnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aiRDqVEr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EE26C43390;
	Tue,  5 Mar 2024 16:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709655491;
	bh=u0KaNZjkpZCOJyJqEP00wkGIXrVZnuiNtzgm8XKsx4c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aiRDqVErzcdsZrISLKlt7k1ccAOahRYVoD7vGoz25Bmnckk/VF/c0eIAzUEEyeX7L
	 Tk4usE8q2pvF+LI3I3P2baCDtUj/T3fngmihJ5VsT3jITdG4BBO00HFBUi/7GJ2Ydu
	 17Dl7yim9kIpU3AVyk/aSFRpS7uQZIppUPX4OuSZBtRzwFokY/RaD2gJvexFk7zdje
	 cys+d4P+WsJc6nBkXjp+o7PPJsP1S0afd7SGc+rYJSwdzRVYtNLoxGMjo2L30qJJZg
	 ltZIspqgQPlGweZDHV4YqEMkgMQo39FaeIAXLB17CvYhRlT0SDPorr8E2qBI7srLcQ
	 n3ZlpGiU9rYUw==
Date: Tue, 5 Mar 2024 17:18:07 +0100
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Eric Sandeen <sandeen@redhat.com>, linux-fsdevel@vger.kernel.org, 
	Bill O'Donnell <billodo@redhat.com>, Krzysztof =?utf-8?Q?B=C5=82aszkowski?= <kb@sysmikro.com.pl>
Subject: Re: [PATCH] freevxfs: Convert freevxfs to the new mount API.
Message-ID: <20240305-lehrmaterial-einfordern-8911096c6b53@brauner>
References: <b0d1a423-4b8e-4bc1-a021-a1078aee915f@redhat.com>
 <ZeciiH1jYeT3juD7@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZeciiH1jYeT3juD7@infradead.org>

On Tue, Mar 05, 2024 at 05:47:52AM -0800, Christoph Hellwig wrote:
> > +static int vxfs_init_fs_context(struct fs_context *fc)
> > +{
> > +	fc->ops = &vxfs_context_ops;
> > +
> > +	return 0;
> 
> Superficial nit, but I would have skipped the empty line here.
> 
> Otherwise this looks good and thanks for doing the work!
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> (and I'm fine with routing all freevxfs patches through Christian)

Oh, I didn't realize that you were active there. Thanks!

