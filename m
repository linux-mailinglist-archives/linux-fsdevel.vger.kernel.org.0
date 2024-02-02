Return-Path: <linux-fsdevel+bounces-10016-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C111847095
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 13:45:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22DA11C26F1A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 12:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFEC7441B;
	Fri,  2 Feb 2024 12:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SlpCS/bd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6139523F
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 Feb 2024 12:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706877896; cv=none; b=aCQiYSpR1tlzQE+VIHbGRhBpIe72U4KZ4uRYtBIc2I5vzRfiXof+TdZ1matwNfrvwN1bXDSSPxyw85GOA+3dEJbPYg12Rkipg6BgNRbpKdj5XtIA/+nzPtGCBNMzAsBsiACUrYcFVx5BDZh5X1aM2PaxU0cKeQ4RGEZGz0xkc6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706877896; c=relaxed/simple;
	bh=iAMyylB9rli65tBTcI5eOUMbvYFx/y0l+kjXQPY2KUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aozlNq6q4hQoHqkeZuXXIHopBYxfV/dX+Q7ibDfsraHQ++y7Y4zG2mOCNuxdyaqFH6224wV6Ao1TBLYCwsMSzkAVjZnRtDjinRbyg26l7LlwMA/LqLa3LbZO9r529J/hxNVJFQ+ofmkE/N15kmDsTOfxKc76MPbCGmY9dx3/0Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SlpCS/bd; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 2 Feb 2024 07:44:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706877891;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+4SlfiygKKU71t9L+sMrkvrsvHoKpZtEQA/tb9zLLPM=;
	b=SlpCS/bdhzDa+bf30mWqy7EztHUGK+oQiaKSEL8XdbHHEhVxax1L9Yfg0nPZph92WHuU+3
	ovtfsAt/P0rcm2fDuJudu2fhA9sLWyEE595ZQOCEyhEye8t70SRcuSv447t2m8kccSoW4R
	vSTkTA5DePn9KJzo3h0SzgjxpkHnIgQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: David Howells <dhowells@redhat.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, lsf-pc@lists.linux-foundation.org, 
	Matthew Wilcox <willy@infradead.org>, dwmw2@infradead.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org
Subject: Re: [LSF/MM/BPF TOPIC] Replacing TASK_(UN)INTERRUPTIBLE with regions
 of uninterruptibility
Message-ID: <5s7h6lemzjmpsqv57vodupeumkmjqga74sso27nrwgxpg2aq2g@qn72mescc5k3>
References: <CAJfpegu6v1fRAyLvFLOPUSAhx5aAGvPGjBWv-TDQjugqjUA_hQ@mail.gmail.com>
 <2701318.1706863882@warthog.procyon.org.uk>
 <CAJfpegtOiiBqhFeFBbuaY=TaS2xMafLOES=LHdNx8BhwUz7aCg@mail.gmail.com>
 <2704767.1706869832@warthog.procyon.org.uk>
 <2751706.1706872935@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2751706.1706872935@warthog.procyon.org.uk>
X-Migadu-Flow: FLOW_OUT

On Fri, Feb 02, 2024 at 11:22:15AM +0000, David Howells wrote:
> Miklos Szeredi <miklos@szeredi.hu> wrote:
> 
> > Just making inode_lock() interruptible would break everything.
> 
> Why?  Obviously, you'd need to check the result of the inode_lock(), which I
> didn't put in my very rough example code, but why would taking the lock at the
> front of a vfs op like mkdir be a problem?

Existing callers don't check for errors, so
maybe-interruptible-depending-on-context has to be a new function.

> > For overlayfs it doesn't really make sense, but for network fs and
> > fuse I guess it could be interesting.
> 
> But overlayfs calls down into other filesystems - and those might be, say,
> network filesystems that want to be interruptible.

yup, and our interruptible vs. non interruptible stuff has always been a
wacky patchwork

