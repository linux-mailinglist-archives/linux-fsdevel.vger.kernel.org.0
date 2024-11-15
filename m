Return-Path: <linux-fsdevel+bounces-34873-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17EA49CDA3F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 09:10:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1836283490
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 08:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 540EB18BBAE;
	Fri, 15 Nov 2024 08:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="txAdQrwV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4622142E86;
	Fri, 15 Nov 2024 08:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731658216; cv=none; b=eeF4MlW6alDoHo2Ykh9JPErYX1dU1PWz9P8iIETJa2PCiiK50grPgmT1f1DiHILUB1Yggg+d2lkStM4FOfYuLvY0svdl81OyOzvJVqTH5DMvtBKMU3+n7/GN8VooZbA2zTBQ1g7RYxJmd/p4bkcB0QzWkXd81z3vbYArhGhMzos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731658216; c=relaxed/simple;
	bh=58pMiInwnliEvdcwGuOfuiTxI8kMEU7V7XyAXzvTUKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K5NRo54ZzAJNd86q4Mrmli/54TvTPkEXiw/2GR0r3SvReTCT1IlQTEKFWaTHFiW08kCzVVjxlVh5swW+Jepyb3/5OvP+KJmFL97jrQgBdmIlZmfPKY9d8hkVoDc9F7nyMuCeUxVCW7MUmI3rytNmJkZ1Mo1VbPnNEKRZXtKi68s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=txAdQrwV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61F6CC4CECF;
	Fri, 15 Nov 2024 08:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731658216;
	bh=58pMiInwnliEvdcwGuOfuiTxI8kMEU7V7XyAXzvTUKc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=txAdQrwVbOmQLVGsERQww/ryjcLMnpQjfRqYWkSRMbdzBlL0tjTNpyo9vn0vGB6oe
	 3lK6E7hd1/rhsqUSMtBZ1xmGG6RTW3XXAbiqBMYq7XUF2WBYVWbrU9Hb7umBCWqTa7
	 VfjV2eWY6kms4GBWRFwHeATp6Cd0cK/1Uzb2772n7JdEQujqJEO3+PY2foH9vWsPTD
	 mpvcgXsfDx0nbnzfo8FE7sBKEdN22dUszbLR3cGcY7rndp9x+qJ36W/KUU3MBf0qcT
	 YzxBbmwnbl0Ynd5ckmqKdY2YQFytj6GjMhv7gnkNFn1xVlmxENuAOTJJ+TtplgGUye
	 yzTDvLjJWiH8Q==
Date: Fri, 15 Nov 2024 09:10:11 +0100
From: Christian Brauner <brauner@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org, 
	linux-api@vger.kernel.org, Karel Zak <kzak@redhat.com>, 
	Christian Brauner <christian@brauner.io>, Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH] statmount: add flag to retrieve unescaped options
Message-ID: <20241115-beieinander-polterabend-71b4ec8fec66@brauner>
References: <20241112101006.30715-1-mszeredi@redhat.com>
 <20241113-unbeobachtet-unvollendet-36c5443a042d@brauner>
 <20241113-wandmalerei-haben-9b19b61e5118@brauner>
 <CAJfpegtLiOjbtP4np-WjJ_oyC-u3FwZ4BWQxGkSSmWxurBOQdA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJfpegtLiOjbtP4np-WjJ_oyC-u3FwZ4BWQxGkSSmWxurBOQdA@mail.gmail.com>

On Thu, Nov 14, 2024 at 03:53:44PM +0100, Miklos Szeredi wrote:
> On Wed, 13 Nov 2024 at 17:31, Christian Brauner <brauner@kernel.org> wrote:
> 
> > Please take a look at the top of #vfs.misc and tell me whether this is
> > ok with you.
> 
> One more thing I'd do is:
> 
> -       if (seq->count == start)
> +       if (seq->count <= start + 1)
> 
> This would handle the (broken) case of just a single comma in the
> options.  So it's not a bug fix per-se, but would make it clear that
> the loop will run at least once, and so the seq->count calculation at
> the end won't be skewed.
> 
> The buf_start calculation could also be moved further down before the
> loop, where it's actually used.
> 
> I don't find the variable naming much better, how about taking the
> naming from string_unescape:
> 
> opt_start -> src - pointer to escaped string
> buf_start -> dst - pointer to de-escaped string
> 
> The others make sense.

Fine by me. I'm about to send pull-requests so I would suggest you send
a cleanup that I can include post-rc1 so we don't have to rebase right
now.

