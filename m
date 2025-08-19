Return-Path: <linux-fsdevel+bounces-58238-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7CBFB2B777
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 05:14:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22C7917AC71
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 03:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE8A2D24A7;
	Tue, 19 Aug 2025 03:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="WTePi9Ls"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D745E2D2494;
	Tue, 19 Aug 2025 03:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755573245; cv=none; b=GuHfAhwaXwcNWJUkjZXJ54B+Wd8/5P8zVgbSBUPKI9XInnH1sxnEt8jWvRwyxw4cVva+svUe6sMgs83QSUHEfR6Dlr/Vnu6NoMBwsVIVbzTQKB0OAg5v/as5NMTR6DW/x1ShpnbGhbtkhS+3Vze9JZEW6CsMWMmxl6D7/RwAOqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755573245; c=relaxed/simple;
	bh=U9AiP79eOCXHplDIH6RSly7Iv7lDrsiyxvq1wFnhkVc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=UMHbvDwJ3BOt3ngzJjyzZp4rxe7+iXJJ8SEmN1c2XBiwxnaii5zX1E3y3oc2TluWT7e/i3/5fhYnRThBibr1NEyalIicirFaGtJrjkg8HZGnTi+TZPWAyyyv502O5uIpwiHrB2BO6pne0RXTcFvjl6RSismOdTbAdMB645q6fUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=WTePi9Ls; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BDE6C4CEF4;
	Tue, 19 Aug 2025 03:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1755573244;
	bh=U9AiP79eOCXHplDIH6RSly7Iv7lDrsiyxvq1wFnhkVc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WTePi9LshSVeRNN3OaGOdUsgrXFAjHRGQTU/CkE5uCy7CIayQmOw/QPiM1jS60e40
	 wKSixI0ZMt4u02QXsDpLM4VgEreEWYPxRU50R/bChCrwWB2vlQUsR0vcSZBlLiVcDL
	 aF2EDjH7DW0eS0oF/2HRYVCV3kL3YyoSi9YJ7cdo=
Date: Mon, 18 Aug 2025 20:14:03 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Pankaj Raghav <p.raghav@samsung.com>
Cc: =?UTF-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>, Christoph Hellwig
 <hch@infradead.org>, Christian Brauner <brauner@kernel.org>, Stephen
 Rothwell <sfr@canb.auug.org.au>, "Darrick J . Wong" <djwong@kernel.org>,
 "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
 <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
 <mcgrof@kernel.org>, <gost.dev@samsung.com>, <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH] iomap: use largest_zero_folio() in iomap_dio_zero()
Message-Id: <20250818201403.33f469f169957d46ef061d52@linux-foundation.org>
In-Reply-To: <43bca78e-fa89-4b0e-94f1-de7385818950@samsung.com>
References: <20250814142137.45469-1-kernel@pankajraghav.com>
	<20250815-gauner-brokkoli-1855864a9dff@brauner>
	<aKKu7jN6HrcXt3WC@infradead.org>
	<CGME20250818141331eucas1p21bf686b508f2b37883a954fd8aed891f@eucas1p2.samsung.com>
	<4b225908-f788-413b-ba07-57a0d6012145@igalia.com>
	<43bca78e-fa89-4b0e-94f1-de7385818950@samsung.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 18 Aug 2025 16:35:04 +0200 Pankaj Raghav <p.raghav@samsung.com> wrote:

> >>> Applied to the vfs-6.18.iomap branch of the vfs/vfs.git tree.
> >>> Patches in the vfs-6.18.iomap branch should appear in linux-next soon.
> >>
> >> Hmm, AFAIK largest_zero_folio just showed up in mm.git a few days ago.
> >> Wouldn't it be better to queue up this change there?
> >>
> >>
> > 
> > Indeed, compiling vfs/vfs.all as of today fails with:
> > 
> > fs/iomap/direct-io.c:281:36: error: implicit declaration of function 
> > ‘largest_zero_folio’; did you mean ‘is_zero_folio’? [-Wimplicit- 
> > function-declaration]
> > 
> > Reverting "iomap: use largest_zero_folio() in iomap_dio_zero()" fixes 
> > the compilation.
> > 
> 
> I also got some reports from Stephen in linux-next. As Christoph 
> suggested, maybe we drop the patches from Christian's tree and queue it 
> up via Andrew's tree

Thanks, I added it to mm.git.

