Return-Path: <linux-fsdevel+bounces-17076-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 402A18A75C2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 22:34:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 710621C214EE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 20:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 272D239FD7;
	Tue, 16 Apr 2024 20:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ieY/hx57"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29872231C
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Apr 2024 20:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713299693; cv=none; b=Apmm5gWtOEM9C+dy7oDcPiyzIYFuh6xAwXXHL/EhOJqeHTMUV+euIJTt9+IofGUKs9NTJUvSF4MKJKWGQ7SdvZDvIvy0KKw58g+TGnddw+xCYNP0l50+MIGlW7YN/uKL4IYQWKcVXGvvH+Qf7eY2rLWeMjPXiy6bzSHZU4Xh9U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713299693; c=relaxed/simple;
	bh=j4GqYjyfZYMKCoR1MV7vDkfNuAN6ZiWzdoEcn+XTNK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZbEFAGrAx/qivo2F/fxAVxhLnQKV5mtpchAbT+Q1G6MQ3o/+m/LWkCR7IivMxQxj0pdLc6pAaHy5m4L3XgScBBh59ZnWleoZWYR5OtjxCJk3aNW33vZlOxnUjs0WIPAGfdmp6hSLuB8zQuZvdRND5ED2ZWUOp3ZSKP9yuHrxj5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ieY/hx57; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=9DeQTmM8FoZNqg2QsrAj0oLeScI3DUeKZM3w+WOh2DA=; b=ieY/hx57joU5EdwlOlrqqW2fzS
	Vh0zmd+5+y6mj5+IZKFuprw5qm9rny7BxZly+rtPy4LRTuTsL8Jko/MQVRFUe51CTHVfHjQmrsIv7
	dVf0g9iWcHYn3kMchmYjf32wgYEN2o6/a6MECpicul3POveIt+q3kQvs8CurC6vs91lSNUkVJ03kJ
	XMybyV5a0h7DuVpKiQOVNiAIwFe5ZYiShrSZEUwF8keLBL2D23ePVVDPVoXo08+nHxrhrcMc3/T5s
	6xQB/GGo5v+RlCLIgkzBR1PcOpR4Rrtnj6PDcz4rwgLXkd+hslU5kO+2DIo7Uq6mxUwpW2fklL3Nn
	B3VtDJtw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwpVv-00000001Mc1-3ICT;
	Tue, 16 Apr 2024 20:34:47 +0000
Date: Tue, 16 Apr 2024 21:34:47 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-fsdevel@vger.kernel.org, lsf-pc@lists.linux-foundation.org,
	kernel-team@fb.com
Subject: Re: [LSF/MM/BPF TOPIC] Changing how we do file system maintenance
Message-ID: <Zh7g5ws68IkJ1vo3@casper.infradead.org>
References: <20240416180414.GA2100066@perftesting>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416180414.GA2100066@perftesting>

On Tue, Apr 16, 2024 at 02:04:14PM -0400, Josef Bacik wrote:
> I would like to propose we organize ourselves more akin to the other
> large subsystems.  We are one of the few where everybody sends their
> own PR to Linus, so oftentimes the first time we're testing eachothers
> code is when we all rebase our respective trees onto -rc1.  I think
> we could benefit from getting more organized amongst ourselves, having
> a single tree we all flow into, and then have that tree flow into Linus.

This sounds like a great idea to me.  As someone who does a lot of
changes that touch a lot of filesystems, I'd benefit from this model.
It's very frustrating to be told "Oh, submit patches against tree X
which isn't included in linux-next".

A potential downside is that it increases the risk of an ntfs3 style
disaster where the code is essentially dumped on all other fs maintainers.
But I like the idea of a maintainer group which allows people to slide
in and out of the "patch pumpkin" role.  Particularly if it lets more
junior developers take a turn at wrangling patches.


