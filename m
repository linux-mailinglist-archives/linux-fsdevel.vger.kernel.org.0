Return-Path: <linux-fsdevel+bounces-37219-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B29DB9EFADA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 19:25:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7488D289425
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 18:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC20223E92;
	Thu, 12 Dec 2024 18:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a1AfAyF/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179BA223E64
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Dec 2024 18:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734027882; cv=none; b=bKoaTwNhVnP90ohm3M0e28env9taIAfE2ZEOUwMFQ33RCvwinHWiBNpz40aH08C4LmQirvLklqdsnusHwJA/GveTn7r998iowBIZuPvwwToVZ0ZrKx2/o9ymSWae7Zu02c4YgKp6kDOMf6x23pl3lxvvbSYEXcUpAM2n/sdw5dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734027882; c=relaxed/simple;
	bh=ZZHkLQMBori6W/CAt5E5mTjgsjde/hlsBtCY2Mcvb+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dtSuMXywBA72XWmk1/e0K+7BpSQu5K9fJHu7S6PDpu12rAatJXaxc7+VkV0TJ/LSSDR+eI1lc/VC7CZrTRrmUv+vjN86OJU09VpkxkMDEDrNXKFgasbw/UBVWru5KkXBo86ckM5c9+7yQ4Ve6m7EuH1oF7zn8rCjgV1IKGmvKnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a1AfAyF/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37B43C4CED0;
	Thu, 12 Dec 2024 18:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734027881;
	bh=ZZHkLQMBori6W/CAt5E5mTjgsjde/hlsBtCY2Mcvb+A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a1AfAyF/ZyN7aIJLG9kn83A2Gzf/Uhi9DrtTIifuJL1j5wGN7txupZXwZHckKQyjt
	 Usnb1HNtvOTVmJQx8iM3glj7u3UhLPDkNoXAkXl6dvVaUG8tz6gzlCASLPOXTJIQHX
	 5Ds+EG5QTWtUtaEjQBozEZOltAisjRX/d+/Kpl4bCCaELpzP9D9U1F1xQMZ53JigNc
	 G5u+aRedwfXplM/DsB9nq+u0YnPnafm1amLsjeweqpVP7eDk1WhsTE6AhpdoEtbVOT
	 26T/FVt4USYUyBQzCYvNEMUdhxMkF44UDTD65Z1e7sLJZZnaZaFMfmBmpOWJX98Ket
	 i9OMuU37U+2aw==
Date: Thu, 12 Dec 2024 19:24:37 +0100
From: Christian Brauner <brauner@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 5/8] fs: lockless mntns lookup for nsfs
Message-ID: <20241212-kopfgeld-hinab-cd792d9b0303@brauner>
References: <20241212-work-mount-rbtree-lockless-v2-0-4fe6cef02534@kernel.org>
 <20241212-work-mount-rbtree-lockless-v2-5-4fe6cef02534@kernel.org>
 <20241212124817.GZ21636@noisy.programming.kicks-ass.net>
 <20241212-rhythmisch-seelenruhig-5a5ed7d0ba10@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241212-rhythmisch-seelenruhig-5a5ed7d0ba10@brauner>

> > This only works if the entries are inserted in order -- if not, you can
> > do something like:
> 
> If I understand your concern correctly then the entries should always be
> inserted in order. Mount namespaces are sequentially allocated
> serialized on the namespace semaphore "namespace_sem. So each mount
> namespace receives a unique 64bit sequence number. If ten mount
> namespaces are created with 1, 2, 3, ..., 10 then they are inserted into
> the rbtree in that order. And so they should be added to that list in
> the same order. That's why I kept it that simple.

Nope, you were right, I was wrong. We allocate the sequence number
before we hold the namespace semaphore. I misremembered that code.
I'll fix this up as you suggested. Thanks!

