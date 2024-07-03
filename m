Return-Path: <linux-fsdevel+bounces-23078-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2330926AAA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 23:45:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A3FA1F237EA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 21:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 253FE1990BD;
	Wed,  3 Jul 2024 21:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="wm8hzuPb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E15198836;
	Wed,  3 Jul 2024 21:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720043027; cv=none; b=ue+aO/NmHVMI1AwGNfvul+mrBVoy0t7pI3UiVeCF47nqr3XR/QnaSPHLTjz3UVD3l4yCmADDCjwpxES1UiiPf+j1ypayVhQEu11/zg1e7oX6g7l9e9Xu6TUorLyrp0YsMFlC+EwoUADyFNsgV2kkOGXnRGN6C5gHksj8KCFKaCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720043027; c=relaxed/simple;
	bh=CpC1+7GyO7O8zAq0nMpMmymsg6eQS97CVLhpi3orCkE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=SBbsjPZtAYo+VW7HF/1ur9Ni7B4TfEvv/WQMBijDh2E8kt8RUM/U2AvDRGV59IHEzebOMhNPEUR6IGZY2OuRZ923QBvE8IufJWq7jQlGm6vJP2Bdk46r98/hb2yy8Gn3d62PEdNZ+1VFztEvLGslpIeiJ1TUlPUeMA+8DPGVf0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=wm8hzuPb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53CAFC4AF07;
	Wed,  3 Jul 2024 21:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1720043026;
	bh=CpC1+7GyO7O8zAq0nMpMmymsg6eQS97CVLhpi3orCkE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=wm8hzuPbtf99HljIKgn5ihS5pWJJounqB04L8GR/czcjjFyTRXIT14ZBWeG+3vRJE
	 BcJdcWULuIzHhL+D5VPzQiBBvq2ziOiZs5sQFWJnIQvqXCH9RF8bYalQ4Ym3xrjL2Z
	 sb8ezQfQ4fBfmVNQWO6N8x2a5nBa/efjSLj1hyO4=
Date: Wed, 3 Jul 2024 14:43:45 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, "Liam R . Howlett" <Liam.Howlett@oracle.com>, Vlastimil
 Babka <vbabka@suse.cz>, Matthew Wilcox <willy@infradead.org>, Alexander
 Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan
 Kara <jack@suse.cz>, Eric Biederman <ebiederm@xmission.com>, Kees Cook
 <kees@kernel.org>, Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH 0/7] Make core VMA operations internal and testable
Message-Id: <20240703144345.530d82e0f337fe7b57704df6@linux-foundation.org>
In-Reply-To: <1a41caa5-561e-415f-85f3-01b52b233506@lucifer.local>
References: <cover.1720006125.git.lorenzo.stoakes@oracle.com>
	<20240703132653.3cb26750f5ff160d6b698cae@linux-foundation.org>
	<1a41caa5-561e-415f-85f3-01b52b233506@lucifer.local>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 3 Jul 2024 21:33:00 +0100 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:

> >
> > >  51 files changed, 3914 insertions(+), 2453 deletions(-)
> >
> > eep.  The best time for me to merge this is late in the -rc cycle so
> > the large skew between mainline and mm.git doesn't spend months
> > hampering ongoing development.  But that merge time is right now.
> 
> Argh. Well, the numbers are scary, but it's _mostly_ moving code around
> with some pretty straightforward refactorings and adding a bunch of
> userland code that won't impact kernels at all.
> 
> So I'd argue this is less crazy in size than it might seem...

OK, let's leave it a couple of days for some feedback then decide. 
It's still a couple of weeks until we go upstream.

