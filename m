Return-Path: <linux-fsdevel+bounces-21668-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A7B1907BCB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 20:56:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70B131C248BE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 18:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE5A14C59C;
	Thu, 13 Jun 2024 18:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="TRV4oeXJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB8584A48;
	Thu, 13 Jun 2024 18:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718304953; cv=none; b=Ox7+A7wzfJtMF3qchNxRvd8XO8fPvvyFgUvdZfHWr7PreicDxlIvXmT5QuL7wBvAiVU0TZDKdOEoG+Jh6SMu96HcLHHgsNs2VlWdXzqwJDg2tHfsdSfNNKMVQzJ3Ybs0sby6Nb1kiOIb0Ca+vPzqK132Q3/VXGFVyzQZVIm+L88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718304953; c=relaxed/simple;
	bh=63ugLzPkZISDkE/R2ja4qO6bJ89KfrEGKAD4KlJR1D8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Et1CEzyt9lqbwZjFLr9YEO38VFEktfS5t74bC69U07sYgjULgGF62cWUIJaQJuKr3N5RCWWPfs9sSToGFgHOJeOaAUUEG5F+ZP8clKZpICdSmEkegIMMIs0oiHC1V5KHBp42RDzNGjm+KF5co0kPhNZcB77zUVXrZM/dJcZNT0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=TRV4oeXJ; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=AY43+HBOJx3kLbSrEpkOfh/9TQVZmcpW+OF54BWBDDQ=; b=TRV4oeXJcTNJAIbe6ATskhY2ag
	C8V5GUmUSmL8RPcf+68GRFJbhJgOwqhTkDQ+PIESxdG5atvY47szMRa/KEID9XEVHKcrGO9QCtK+D
	1eg+90U83W2ORq0rqJyKKeHMKBcGbcnWOGWdFy6LusE8sGW0vZaFy+zLOkBH/Rm8errXpNAyh+JHr
	rDex33PIa/Gq6orzytnoXse3Jrjq5rslmD+Hhocsb2JyuuvVbp+MDX5Ua2M/zHjBVUFlhEdQVo4DY
	k7dXy2F7xSRwEjEjhE8xkjyLeLG2lHRICSRKHn/0VyoNRL7nkCH/IGcO2vVLqUklF+bgRQI75nizR
	v3pehW9Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1sHpbt-00336k-0s;
	Thu, 13 Jun 2024 18:55:45 +0000
Date: Thu, 13 Jun 2024 19:55:45 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mateusz Guzik <mjguzik@gmail.com>,
	Christian Brauner <brauner@kernel.org>, jack@suse.cz,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] lockref: speculatively spin waiting for the lock to
 be released
Message-ID: <20240613185545.GI1629371@ZenIV>
References: <20240613001215.648829-1-mjguzik@gmail.com>
 <20240613001215.648829-2-mjguzik@gmail.com>
 <CAHk-=wgX9UZXWkrhnjcctM8UpDGQqWyt3r=KZunKV3+00cbF9A@mail.gmail.com>
 <CAHk-=wgPgGwPexW_ffc97Z8O23J=G=3kcV-dGFBKbLJR-6TWpQ@mail.gmail.com>
 <5cixyyivolodhsru23y5gf5f6w6ov2zs5rbkxleljeu6qvc4gu@ivawdfkvus3p>
 <20240613-pumpen-durst-fdc20c301a08@brauner>
 <CAHk-=wj0cmLKJZipHy-OcwKADygUgd19yU1rmBaB6X3Wb5jU3Q@mail.gmail.com>
 <CAGudoHHWL_CftUXyeZNU96qHsi5DT_OTL5ZLOWoCGiB45HvzVA@mail.gmail.com>
 <CAHk-=wi4xCJKiCRzmDDpva+VhsrBuZfawGFb9vY6QXV2-_bELw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi4xCJKiCRzmDDpva+VhsrBuZfawGFb9vY6QXV2-_bELw@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Jun 13, 2024 at 11:43:05AM -0700, Linus Torvalds wrote:

>        seqcount_spinlock_t        d_seq;
> 
> because seqcount_spinlock_t has been entirely broken and went from
> being 4 bytes back when, to now being 64 bytes.

1ca7d67cf5d5 "seqcount: Add lockdep functionality to seqcount/seqlock structures"

