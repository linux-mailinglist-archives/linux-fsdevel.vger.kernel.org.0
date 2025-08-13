Return-Path: <linux-fsdevel+bounces-57635-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 095FDB2403E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 07:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39EFE584AF6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 05:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50BCA2BEFF9;
	Wed, 13 Aug 2025 05:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="egPHiuC/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A9062BDC3E;
	Wed, 13 Aug 2025 05:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755063289; cv=none; b=pKEfZvimQKHdLRhQ9M19R5icGFlwJ2eORG+1K3p/1hpwavC5CzKpv4eRnq4lBOybM9KR2a00qtPQN7DE2Q+vgr6PiVUvvrKeFconSbTtZqRwyMwxcK+JdgrVJW+Oiurf1tu78HfrS5CFClox521f6Z1mA4LwgDhbDltrfLpBx9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755063289; c=relaxed/simple;
	bh=FDQ2bMLRusEapD25iBwCb7gdZGFnPUtA5/Dgwn3dckg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s79BqjhmUI4UPooyBzt9NO3Vz8BWSEjPDECZcVBYiPKFTEoelUdU0uG4PeLLfnRVHNOzNEUPuzf4ZS7Y7j0xFepnJETmzNVVaV/NTsb0CVk7TQN1Mq0A3OIWqaz04mlc1cxSvvlAHNa4w10HGpfWdV1ys3w/0nHHQ5gEVwxleqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=egPHiuC/; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 1CB7814C2D3;
	Wed, 13 Aug 2025 07:34:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1755063287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XjWBHGXAcgSV563xYk+j+40WjifMEzSXGjNe9KQBgLk=;
	b=egPHiuC/UC4UD4nFojr3h+78xh94q0eLp3Zq21uBe8/LCpwZK5VBHhPh9biDCwsjmCVJnC
	CFyJ0T1fh3cJfPengyIw1VXIKESumJNM2n9UFWGwG0KkXgd34hp2B/yF1MQZjSAYiQ/d60
	8PWe6PSIJFyJHf2TRZISebDIzWprvPBpvm55mgMY+d3Ib8JIirsbnKbO7ECSm+j9b5DenO
	NJa+UHGLhlCaA8/WWL7kOYYRzgNKmLAq/YaBH5oieeCCQGoPB7YE+okWPLuEmWJhY6T4Rj
	zmwT6YJssNSgb9Sb+7caUlK2ahGNWZaFZgv6Trd5sguwsYKpqxLITSfw0KCw1g==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 2a270480;
	Wed, 13 Aug 2025 05:34:40 +0000 (UTC)
Date: Wed, 13 Aug 2025 14:34:25 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: kernel test robot <lkp@intel.com>,
	Dominique Martinet via B4 Relay <devnull+asmadeus.codewreck.org@kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Andrew Morton <akpm@linux-foundation.org>, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	Maximilian Bosch <maximilian@mbosch.me>,
	Ryan Lahfa <ryan@lahfa.xyz>, Christian Theune <ct@flyingcircus.io>,
	Arnout Engelen <arnout@bzzt.net>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] iov_iter: iterate_folioq: fix handling of offset >=
 folio size
Message-ID: <aJwj4dQ3b599qKHn@codewreck.org>
References: <20250811-iot_iter_folio-v1-1-d9c223adf93c@codewreck.org>
 <202508120250.Eooq2ydr-lkp@intel.com>
 <20250813051633.GA3895812@ax162>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250813051633.GA3895812@ax162>

Nathan Chancellor wrote on Tue, Aug 12, 2025 at 10:16:33PM -0700:
> >    1 warning generated.
> 
> I see this in -next now, should remain be zero initialized or is there
> some other fix that is needed?

A zero-initialization is fine, I sent a v2 with zero-initialization
fixed yesterday:
https://lkml.kernel.org/r/20250812-iot_iter_folio-v2-1-f99423309478@codewreck.org

(and I'll send a v3 with the goto replaced with a bigger if later today
as per David's request)

I assume Andrew will pick it up eventually?
-- 
Dominique Martinet | Asmadeus

