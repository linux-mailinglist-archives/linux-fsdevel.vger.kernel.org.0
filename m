Return-Path: <linux-fsdevel+bounces-8466-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8451D836F7A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 19:16:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 396FD1F26D23
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 18:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8412646BB1;
	Mon, 22 Jan 2024 17:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UQvIBgEc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FDE04642F
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jan 2024 17:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705945350; cv=none; b=Bwuwu8C4n8+BLrBM6fXEGgQJHzW9a4XgynWQoH/P9iv/BN1St8wPgc8hLTQltb8UbBX4z1qBme0kJCMNfhFUnzm00Pco17/w8jSSGh4hE4/t6y5lCxm8vk0UTThgTw/QPNg+Vj1pY/AT0Cn5q0Smd1lXaXZmCHTgEfhZR0K5OWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705945350; c=relaxed/simple;
	bh=gj9qLw1tQ84HJlkMwWSeCO447oh/wRG2lRtRfaFUyIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sGVh7VPHUGiPhBvJBr7BYeaGIc0OV7cx5wboGzbOl4DCXWBspKkzx64lqgtq7haTI9As2XUsbVFkJFT10Rs44ULGHe6hRUiN19cZgrLAhOnFdTa52dMDpgvVTgElKvoMF37gQA6u0zGQTQr6Tk389r7gQyIbgrqc8OmdN0jvjDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UQvIBgEc; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 22 Jan 2024 12:42:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705945346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7ty78UTcDEPkGWAbT8QZy4zXIuGDbN0PS7GrkuXlRwQ=;
	b=UQvIBgEcr5vKCrm143csud8eE+w8mU0A+pLQYk2jtsynfCESs2crcq3Dr5jdATlvF6bTvT
	3tIdqDKNG81O0GYX4QV+0k9xggdw/CkMvsnfemP6vJXsewzosX3u9AMBPTT28Nt7j0JqLP
	3L4poLtDohvR0fBbNjP5AhsI3fYEYWg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Christoph Hellwig <hch@lst.de>
Cc: bfoster@redhat.com, linux-bcachefs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] bcachefs: fix incorrect usage of REQ_OP_FLUSH
Message-ID: <6jhgnewkmex25jgtw2s3fifyyje4w3yja2exdrnx2vesk6bp5w@gysfpght3cbo>
References: <20240111073655.2095423-1-hch@lst.de>
 <ueeqal442uw77vrmonr5crix5jehetzg266725shaqi2oim6h7@4q4tlcm2y6k7>
 <20240122063007.GA23991@lst.de>
 <eyyg26ls45xqdyjrvowm7hfusfr7ezr3pjve6ojikg4znys6dx@rd2ugzmo44r4>
 <20240122065038.GA24601@lst.de>
 <3cs7zhkf3gz7fmytpxqjvstr6oegvhy3ehwu3mzomfllvjqlmc@yaq6ophbgbfr>
 <20240122173809.GA5676@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122173809.GA5676@lst.de>
X-Migadu-Flow: FLOW_OUT

On Mon, Jan 22, 2024 at 06:38:09PM +0100, Christoph Hellwig wrote:
> On Mon, Jan 22, 2024 at 12:37:10PM -0500, Kent Overstreet wrote:
> > Ahh - I misread the bug report (fedora puts out kernels before rc1!?).
> > Thanks, your patch is back in :)
> 
> Please throw it in your test setup and watch the results carefully.
> I'm pretty sure it is correct, but I do not actually have a way to
> verify it right now.

updating my tests for the MD_FAULTY removal, then will do. Is there
anything you want me to look for?

considering most tests won't break or won't clearly break if flush/fua
is being dropped (even generic/388 was passing reliably, of course,
since virtual block devices aren't going to reorder writes...) maybe we
could do some print statement sanity checking...

