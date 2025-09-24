Return-Path: <linux-fsdevel+bounces-62541-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25115B98191
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 04:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F36B73AE813
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 02:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C8262248A4;
	Wed, 24 Sep 2025 02:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="hJ5sdKPV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 898C02147F9;
	Wed, 24 Sep 2025 02:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758682523; cv=none; b=dFUj6o4WRYe/wLZPrU8cvWlCftokbxnf0VJj7g1Aqi9gtXXRaFw/+v+VqR0o/NL2VZv1Z0l62UzyO+izyxzXRs+LFEjpDFT4obYuGDLUY/iqUHmkXU75mTqbgq5CBaQhwwHz8Due7k5j2j0o6iIuVsbJKwz6TDswcv2kSc8ZWEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758682523; c=relaxed/simple;
	bh=5USoQlt1ooy6nsU5wNWS0UuXPfJFYjaLYXbt2w23uRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ujxaJzigfaR6zSWfuIFfYEsXxsvMUk2Qc6bMjX9H0as/4bo8ogkvL09ZPQ6hKGKY3dH8vOY9S+vlX4z/9WUSwD13/LV5axeqjZoUS9tCCHdqkdgH458Ie1euCOhd6okyaQtzXXcS//fJTLlo+m3W7yC6Fzy4WgJPcpTs2xsS+KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=hJ5sdKPV; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 71D2214C2D3;
	Wed, 24 Sep 2025 04:55:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1758682512;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MX1GFon4vtGfl3JPV2segkelrrqe31tGsosMdNjHGMA=;
	b=hJ5sdKPVVMSh4D/n8dTonzlrtP9kYbkiC+NljV5Ye4WJVBEtf8fQ51NS3nZDVsYQo4f9ze
	5HlbesLSqt6FCIxAltkg9pb1rx+4hFPF2tE4oZLvsUUL73pK+ddjoOJJXxBgNy081snmtY
	2+l2BZINztx6tZgdKen37vO0B2LFSheezsCaXVyR3nnTvsamyq+eDzhWt9i0x859Q4I8Af
	Kg2uDDkxS/V7gmKfHX1077yxz3TNFZ3uCjXHQNAgSWk8VC/3dCOV2bU2GnI6U0RdCNENSE
	9EFSoZsLJqA6ozrpjTPsn+re8N+q26buYZvjEw1KhV94Mg24J433Fq6dF1sBDw==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 35aa545c;
	Wed, 24 Sep 2025 02:55:07 +0000 (UTC)
Date: Wed, 24 Sep 2025 11:54:52 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Eric Sandeen <sandeen@sandeen.net>
Cc: Christian Brauner <brauner@kernel.org>,
	Eric Sandeen <sandeen@redhat.com>, v9fs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	ericvh@kernel.org, lucho@ionkov.net, linux_oss@crudebyte.com,
	dhowells@redhat.com
Subject: Re: [PATCH V2 0/4] 9p: convert to the new mount API
Message-ID: <aNNdfO4WIJmBQ2uO@codewreck.org>
References: <20250730192511.2161333-1-sandeen@redhat.com>
 <aIqa3cdv3whfNhfP@codewreck.org>
 <6e965060-7b1b-4bbf-b99b-fc0f79b860f8@sandeen.net>
 <aJ6SPLaYUEtkTFWc@codewreck.org>
 <20250815-gebohrt-stollen-b1747c01ce40@brauner>
 <aJ-eNBtjEuYidHiu@codewreck.org>
 <fe6ecd47-2c6d-45b4-a210-230a162b39b2@sandeen.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fe6ecd47-2c6d-45b4-a210-230a162b39b2@sandeen.net>

Eric Sandeen wrote on Tue, Sep 23, 2025 at 05:21:14PM -0500:
> On 8/15/25 3:53 PM, Dominique Martinet wrote:
> > Christian Brauner wrote on Fri, Aug 15, 2025 at 03:55:13PM +0200:
> >> Fyi, Eric (Sandeen) is talking about me, Christian Brauner, whereas you
> >> seem to be thinking of Christian Schoenebeck...
> > 
> > Ah, yes.. (He's also in cc, although is name doesn't show up in his
> > linux_oss@crudebyte mail)
> > 
> > Well, that makes more sense; I've picked up the patches now so I think
> > it's fine as it is but happy to drop the set if you have any reason to
> > want them, just let me know.
> 
> Hi Dominique - not to be pushy, but any chance for this in the current
> merge window, if it's had enough soak time? If not it's not really urgent,
> I just don't want it to get lost.

Thanks for the mail;

This ran into a syzbot bug a while ago and I've been meaning to check
the v9ses setup as I wrote here:
https://lkml.kernel.org/r/aKlg5Ci4WC11GZGz@codewreck.org

Unfortunately I still haven't gotten around to it; my feeling is that
Edward's patch only papers over the issue and there's a problem with two
sessions hanging around when we really only should have one to avoid
such "woops I'm looking at the wrong one" errors.

If we can clear that up this week I'll happily retake the patches and I
think it can still make it this window, but I honestly don't think I'll
have time to look on my end sorry

-- 
Dominique

