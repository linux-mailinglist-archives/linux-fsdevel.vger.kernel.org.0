Return-Path: <linux-fsdevel+bounces-51359-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A74AD5F9B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 21:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 070D618977B8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 19:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6851D2BD59B;
	Wed, 11 Jun 2025 19:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V+9atuFp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3E12E6102;
	Wed, 11 Jun 2025 19:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749671937; cv=none; b=U2m/O7Qc8dJCO6ESJK2Rwo23k00ku3Fqcuvldq1htemfb9MTFNS8YnfuekYma07Gebq/HJ9m0ruZGpjV+KzuY74ehDiKUmYHMH6zJ45X5FG4QCOspn/7qhHpAIpXzw/nREj2BJxGkEbB0m/TueI3hLTJtS6OTNDWxEkfhcul7Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749671937; c=relaxed/simple;
	bh=NuY3l4OhRrsl852TdNYcQFsrdJA2+fJ1FYEogE8kGS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hWwsBgrzMQSwfzEP4M0fIRgj4FoIQ8icUDxMd5aUycXuJFAbyP6Trm/Rqgt/QIvPauW21PZt2zvn4/6ZE7KEnRmwagv3Og0k7nZGCYYxT3TSUqY4zURTrDzGCBReolTGPRUyqhG8s3J/GElhaqV57RwcURBkwsR3qv50TxBd8c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V+9atuFp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2506CC4CEEA;
	Wed, 11 Jun 2025 19:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749671937;
	bh=NuY3l4OhRrsl852TdNYcQFsrdJA2+fJ1FYEogE8kGS4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V+9atuFpj11otwThUBiuK/oO8i7eOK/w10ArTKPp0M+BLg7og1unn2D7fPLMj2Vx9
	 yuF3Lb+Kk9YRT7Dl8J6wzSfcFqiHve6HzGXCrDczkaNNYzxaEp5+h5IsTzahP9JdUK
	 oUcmyGGnqi9YalPL2/syt/cKOzorW+naH/FLX/nI5Sp4Cqmaxbl/8vLP1YjMdnP1MY
	 yXST16PG9c/uzFrk/X3ktCgcN0G6y0ldeINJAZb6mhvDRWpvElTBo+9KuzNdFDOvSL
	 N7Egi7L/rdiiWze26CrNXoqCcDaHmCZKAKwWHCKzV0e9jz0LBTYRvpY1MGHLKjb51A
	 ZHFEC2SiPJbVA==
Date: Wed, 11 Jun 2025 15:58:56 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 0/6] NFSD: add enable-dontcache and initially use it to
 add DIO support
Message-ID: <aEngAEPWmum2KWpU@kernel.org>
References: <20250610205737.63343-1-snitzer@kernel.org>
 <9f96291b-3a87-47db-a037-c1d996ea37c0@oracle.com>
 <aEnEnTEYaQ07XOb5@kernel.org>
 <6e94051a-6a90-4ab8-8ebb-7cf6192e0716@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e94051a-6a90-4ab8-8ebb-7cf6192e0716@oracle.com>

On Wed, Jun 11, 2025 at 03:06:34PM -0400, Chuck Lever wrote:
> On 6/11/25 2:02 PM, Mike Snitzer wrote:
> > On Wed, Jun 11, 2025 at 10:16:39AM -0400, Chuck Lever wrote:
> >> A few general comments:
> >>
> >> - Since this isn't a series that you intend I should apply immediately
> >> to nfsd-next, let's mark subsequent postings with "RFC".
> > 
> > Yeah, my first posting should've been RFC.
> > 
> > But I'd be in favor of working with urgency so that by v6.16-rc4/5 you
> > and Jeff are fine with it for the 6.17 merge window.
> 
> Since this series doesn't fix a crasher or security bug, and since I
> have plenty of other swords in the forge, I can't commit to a
> particular landing spot yet.

Completely understood, you asked my intention so I spoke to it in
reply. Obviously we just take it as it comes. See how things go.

Thanks,
Mike


