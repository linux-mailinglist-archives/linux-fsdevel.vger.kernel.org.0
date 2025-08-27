Return-Path: <linux-fsdevel+bounces-59383-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E449B384F5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 16:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AA84189BFE2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 14:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA85135A29D;
	Wed, 27 Aug 2025 14:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="ewQruy5/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570A22116E7;
	Wed, 27 Aug 2025 14:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756304982; cv=none; b=QUoRyF2RFSLTIfrPucRT2gRt+hScndjP7wxhzJVvHyKawa++RSY9tFO5Wo4GWQ1XENHEZDjDjoEGXDd2Pz1XNnEBlwYfnd/zHUfavwDtq2JbgVH1hYDqiN6gKLpe9bB3zyd2YyKBmJq1c8lYODhIXtJFIBy/cBFNsSEbI761m3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756304982; c=relaxed/simple;
	bh=qCgCUjyjsPmF0jdGcBEgngZAniwK2Av1gp8djUQFeNI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=f3p6aZd3mFNopypmd92IK9CFqfgnj8187AE8QU4tBt2EaP/3C/YEs098x2B7CR4kF2t7C1Zq69xeQNZQJqmNRu5eoS/MAydJz9yUstaK+BqTZ11au7C/b3Uk+Dd4FGgs2+rFyaKJtkEvusig6G3iCakwkQPm/W0y0e+RHcOhd8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=ewQruy5/; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from monopod.intra.ispras.ru (unknown [10.10.3.121])
	by mail.ispras.ru (Postfix) with ESMTPSA id B1576406B369;
	Wed, 27 Aug 2025 14:29:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru B1576406B369
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1756304976;
	bh=50xICCmFUNkQvn1uinC1kdEOBECmusxGYz4OO2607gs=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=ewQruy5/Vapje6Weh9yot3zS867fWsSkLCD1I9OZGeIU9jZfkDD5rhvkNlh1zDP6a
	 FxU+8A4iAWaal4BeKd3RDElLRhZqTJeD1sTFIcAOeOUuZ9QHJvwdE2kf/yUoGTJa1j
	 oR4/atltUzio1lxPro9EPqGS2VsrbIBciflBwLJg=
Date: Wed, 27 Aug 2025 17:29:36 +0300 (MSK)
From: Alexander Monakov <amonakov@ispras.ru>
To: Aleksa Sarai <cyphar@cyphar.com>
cc: Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
    Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
    linux-kernel@vger.kernel.org
Subject: Re: ETXTBSY window in __fput
In-Reply-To: <2025-08-27-powered-crazy-arcade-jack-Ajr33h@cyphar.com>
Message-ID: <9cdea98c-c227-7897-3001-b7e5f388352b@ispras.ru>
References: <6e60aa72-94ef-9de2-a54c-ffd91fcc4711@ispras.ru> <20250826220033.GW39973@ZenIV> <0a372029-9a31-54c3-4d8a-8a9597361955@ispras.ru> <2025-08-27-powered-crazy-arcade-jack-Ajr33h@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Wed, 27 Aug 2025, Aleksa Sarai wrote:

> On 2025-08-27, Alexander Monakov <amonakov@ispras.ru> wrote:
> > > Frankly, in such situation I would spawn a thread for that, did unshare(CLONE_FILES)
> > > in it, replaced the binary and buggered off, with parent waiting for it to complete.
> > 
> > Good to know, but it doesn't sound very efficient (and like something that could be
> > integrated in Go runtime).
> 
> Can't you create a goroutine, runtime.LockOSThread,
> unshare(CLONE_FILES), do the work, and then return -- without
> runtime.UnlockOSThread (to kill the thread and stop it from being used
> by other Go code)? Or does that not work in stdlib?

Again, with regards to Go backstory, I'm just the messenger. But were I
a Go runtime implementor, I'm afraid no, I wouldn't be able to do that,
because while the file is being written, it's done with normal I/O APIs.
The runtime has no way to look in the future and anticipate that the
file currently being written will be execve'd.

My first priority here is not to dig up alternative solutions to the
ETXTBSY problem. I'm asking about a race window in __fput.

Alexander

