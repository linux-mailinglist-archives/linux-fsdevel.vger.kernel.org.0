Return-Path: <linux-fsdevel+bounces-28830-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99CA996EAFB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2024 08:49:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04EFA285AA6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2024 06:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA9B413D613;
	Fri,  6 Sep 2024 06:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XaUaZ9/S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFF73B1A2
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Sep 2024 06:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725605387; cv=none; b=E2sFemuS8kBBkrJ6IXzXH7Vi++NWA67QQUJVqnui5JtoV2+GTw6mt5pkEvIWcEKXxjZKj3vwCDwa1WQtJ//F0eLgfMJ3ay7YWGHgEZOhjkFoLG0fQ1bNREnP8lmSXQp4wwhTiimcsq/yQUrFrWGXTUZ2ymVV7nYedooAdUa724g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725605387; c=relaxed/simple;
	bh=UdNV5VxTTuacHvvbSB2uMlZ6/Hb2KFP95rXNfivVWHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tc85COSdgbqo8tySCLtaCPSNbe4TWV1pSCEnuJeO92BVT9rkgLh3fG1H5OeqO/CVf1NEsRuBiAqXt6fneF1tJ4vy4/lLGCED5VShcpZ9Dnu5+sTZgBuD8Njk5mRCThNXP+AZKx8bAo4cC/THvDD/rPBlFsMMC6Rr61tY7oxvYEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XaUaZ9/S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DA71C4CEC4;
	Fri,  6 Sep 2024 06:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725605386;
	bh=UdNV5VxTTuacHvvbSB2uMlZ6/Hb2KFP95rXNfivVWHc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XaUaZ9/S4k3CzjqdVSiECN/4ZFVsJBZxlOXStO1eXkm6wYZyBBVad85q8ZL4Thmpt
	 nULHwUMcejwFIPfuEbvaBWOUu7g4+E4D9qP36ZuXHPyqIgY0bVGrH2InrQH36M8uSo
	 8XZ8izdms7NrJCfx+M0M57A69dx04JB4ZjYIM6YhuTQKy3IJYE8UnwUqS5EF4gYM2c
	 gX3Ms6ruDhwWv4HyzTUpquMHA87a6FzrNkbVqg5Y2rHQmsVR5YASVNr6CVsMHSwGjQ
	 9Sm0b2waLyprtzPvreaIGsiGixXQBP7aMsrEmDRuItXCEv7cpyBp6H30OMJ5Kmwncl
	 RUlgy7DoSXeFQ==
Date: Fri, 6 Sep 2024 08:49:41 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 00/15] slab: add struct kmem_cache_args
Message-ID: <20240906-esskultur-chihuahua-f906a252f1d2@brauner>
References: <20240903-work-kmem_cache_args-v2-0-76f97e9a4560@kernel.org>
 <2270dc9a-aa60-497d-896d-fe51974db588@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2270dc9a-aa60-497d-896d-fe51974db588@kernel.dk>

On Tue, Sep 03, 2024 at 01:25:22PM GMT, Jens Axboe wrote:
> Hi,
> 
> This is a really nice improvement! With fear of offending someone, the
> kmem_cache API has really just grown warts over the years, with
> additions slapped on top without anyone taking the time to refactor it a
> bit and clean it up. It's about time.

Thank you! I'm sure there's more to improve here in the future. :)

