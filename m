Return-Path: <linux-fsdevel+bounces-13170-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 515E086C310
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 09:06:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8A921F23B8C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 08:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9095482E6;
	Thu, 29 Feb 2024 08:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="k9kAYZtl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B83482C7
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Feb 2024 08:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709193978; cv=none; b=Tf9VNfi38vF4tnM2ic86Xe6L8JPA2c8jo3T2BTpKyrOjHN7ypD2Uc37dXudcZbr5izKOJcFj/atjPCgnWOlHrmrROWkyEzwpfomwegjK7QmtIV4EuwMZyjntbJmT+7/wAIwccd/qb1drLyMsPUQpFx+EVE16rozmd25eQpdzcrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709193978; c=relaxed/simple;
	bh=m0XrheJmi0yCd4Q9b60Flxg7aWj3n2Ug4giN8sS/HsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iJNF+sSJX2JTTwH8JgUIRX/sEs69g7J7N7RDuLdaVx0rQIsLSjc7ZgLTYFdgZVG8IP3pXrDvuzd6ujZK7P7H2zUFU3rva1fhSQY0uyHpWhh4ESub3wnBg1guZvsz/nkGmj2ilXgo3Zq7HBSByv1y959krWLD1i16PwYf1soyQ6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=k9kAYZtl; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 29 Feb 2024 03:06:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709193974;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2IUr9mklGoFWz7rsD/yzLzfpi5IZx6YmcOp3XpaUrMk=;
	b=k9kAYZtlfdRZV778z4PLfwCp/4c0NFUQ1U7h+G0RNm74sKy31gOwmPZK0lCbnTALZ0ywR6
	FtdHALDJddzJbVdS8n+kCoLN/2TqhdLWsc6gs+nSCQxo34bndVgCqureKmOukQ3lSCDoK2
	eS2x1vsNP1j7wPTFT6KC9NJ+8H7jKvM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	david@fromorbit.com, mcgrof@kernel.org, hch@lst.de, willy@infradead.org
Subject: Re: [PATCH 2/2] bcachefs: Buffered write path now can avoid the
 inode lock
Message-ID: <iwzhtano4iwbyzpjfgqksfwyfqavohay3ylivegh5gohevnegp@3oigaa2gml2y>
References: <20240229063010.68754-1-kent.overstreet@linux.dev>
 <20240229063010.68754-3-kent.overstreet@linux.dev>
 <CAHk-=whf9HsM6BP3L4EYONCjGawAV=X0aBDoUHXkND4fpqB2Ww@mail.gmail.com>
 <CAHk-=wg96Rt-SuUeRb-xev1KdwqX0GLFjf2=qnRsyLimx6-xzw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wg96Rt-SuUeRb-xev1KdwqX0GLFjf2=qnRsyLimx6-xzw@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Feb 28, 2024 at 11:27:05PM -0800, Linus Torvalds wrote:
> On Wed, 28 Feb 2024 at 23:20, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> >
> >  - take the lock exclusively if O_APPEND or if it *looks* like you
> > might extend the file size.
> >
> >  - otherwise, take the shared lock, and THEN RE-CHECK. The file size
> > might have changed, so now you need to double-check that you're really
> > not going to extend the size of the file, and if you are, you need to
> > go back and take the inode lock exclusively after all.
> 
> Same goes for the suid/sgid checks. You need to take the inode lock
> shared to even have the i_mode be stable, and at that point you might
> decide "oh, I need to clear suid/sgid after all" and have to go drop
> the lock and retake it for exclusive access after all.

Do we though? Yes i_mode can change mid write, but if userspace issues a
chmod() while we're in a write() - the end result has to be consistent
with either "chmod(); write();" or 'write(); chmod();"; meaning as long
as there's been a barrier in the syscall path so that we can't have seen
a value of i_mode from before the chmod returned we're good.

