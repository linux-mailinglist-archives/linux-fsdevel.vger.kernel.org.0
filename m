Return-Path: <linux-fsdevel+bounces-9941-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F2D48464A5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 00:54:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AF4528C15E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 23:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E8C047F68;
	Thu,  1 Feb 2024 23:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PXZ4ApdG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F45847F57
	for <linux-fsdevel@vger.kernel.org>; Thu,  1 Feb 2024 23:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706831673; cv=none; b=JPAnMOFx8oy8fRiD8Kb6MocswoFAYGLseU3fnKmiWTUGnaaN5VZziYsrv/9TacoOU718S4O3ytZXseP43xxhr2MbIan02Oubs53geIN3ApoSbZt+sVa9YYFYeq+Bucqlrqgwy78i4C7I4QdilGTYhFNtrhdDeiuQXssNWXOOmDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706831673; c=relaxed/simple;
	bh=t5AmDkfZg9CvwMxwUn5okSegfqZjuoUuoA4veUBSoa0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U/4+T/Y+ZQiHwRUxT57IUotJ53XmV+JBk9VBhN+UzHNcKwpY5+yHZMsHL9SDD+3WAjV/kPU2rYRAt0LWBYa4STwzADEdhNAqpxbmD6n3mEi8IniNPpNBbVSteSMlrAdbv+7ihOs+imle0HHfh5IVFrfvdeuQiqvxFUEZjT8YIgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PXZ4ApdG; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=m0v3WsdN4PJ78uDKLHWF815sCglqSPDbmqp0SnU5x4U=; b=PXZ4ApdGXrxItUTCzetq+MsFW9
	L5IBe+oHfKsQ2Nz6Pyual1kE/PRnINYCU3EL1DxwrV0ZIAuhZzdzYehDoxP67aoJcDNmE5fOZzqRF
	kVDX8LFw9a1fNWFvldEuPxZ/uIaEafBvTF3Y6v8M4jc8+5a4s/6rT7dR7Rr7ExyJk2f5m54y4PQpe
	bky5xmV0gbMWs/yNgztEgCm9JKLbjAz/0VMTXU6aCXJtSfJS/ZmPP3FeQipsZgF3RfGYE3yYzgeaI
	g4ikCSc2n6jOSEBcJMkVH7ua1V3vqj5offk7PiLZ9xlNb7nkkOHXkKFgzWb+lMiXEx6fPuzj2rFNE
	Prrnf3BA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVgt3-0000000H9ze-3oOB;
	Thu, 01 Feb 2024 23:54:29 +0000
Date: Thu, 1 Feb 2024 23:54:29 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Tony Solomonik <tony.solomonik@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v8 1/2] Add do_ftruncate that truncates a struct file
Message-ID: <ZbwvNWJQIQ0W_C9I@casper.infradead.org>
References: <20240124083301.8661-1-tony.solomonik@gmail.com>
 <20240129151507.14885-1-tony.solomonik@gmail.com>
 <20240129151507.14885-2-tony.solomonik@gmail.com>
 <20240129-freischaffend-gefeuert-18ccf4cd5f01@brauner>
 <CAD62OrETm04q5F7ef8fpB5xF_vTKEHfas5W86QEssZ2ozyg0DQ@mail.gmail.com>
 <17b4f4f0-0c33-4c6d-819e-c2e170d4b4b7@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17b4f4f0-0c33-4c6d-819e-c2e170d4b4b7@kernel.dk>

On Thu, Feb 01, 2024 at 04:20:06PM -0700, Jens Axboe wrote:
> On 1/31/24 2:14 AM, Tony Solomonik wrote:
> > Actually, I'm not quite sure anymore, @Jens Axboe
> > <mailto:axboe@kernel.dk> is there any guarantee in io_uring that the
> > file is always opened as LARGE / 64 bit? From looking at the code, it
> > simply accepts a user made fd, so the user might have not opened it as
> > LARGE on a 32bit system, which might be bad news.
> 
> Yeah, we probably want to retain that. Though it'd be a very odd case
> where an application using io_uring isn't opening "large" files by
> default, but we'd still have to ensure that it is.

Oh; my mistake.  I thought we required O_LARGEFILE when using io_uring.

