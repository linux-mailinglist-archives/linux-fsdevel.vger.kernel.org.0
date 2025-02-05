Return-Path: <linux-fsdevel+bounces-40972-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F871A29A0A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 20:22:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B07B6163537
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 19:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E72961FECCE;
	Wed,  5 Feb 2025 19:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D5BUfGP2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531B138F82
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Feb 2025 19:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738783366; cv=none; b=H+CKu14Ur2imF6BVJEGZ83GmyrmgT1kfJhqbwvR47YuMZ8vqaDRYBckyws84kqAPJFyJ7QTWUZEVCvYwoyKqveHXiIGO4gENayX9dtdCbM0qqEJuMHhgFH1sLARkfoY7R9TwjcGZVE9s6yF/7z5tKgcEVRoKPhLM3JgytEaWXxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738783366; c=relaxed/simple;
	bh=AZJ+5H+7pZAjHth2evw+ihco8ZiF2H+Vxf73iWhg7uo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VzCRsaS93XV6ylymQeD5uykkq7X5LNdNzXJPF7W0CwWpp0Vwxm0HsduUUhDcWme/4H/VwSSIton7r3N+1m8fzymBQLrFPisIm6qBba037w9wfZWzY2r1Zq60BllLuBUmOdgX8/vvp8UggZdeyZoXgtUn1NI/qHDXSYVwwfN5Xxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D5BUfGP2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69EA2C4CED1;
	Wed,  5 Feb 2025 19:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738783365;
	bh=AZJ+5H+7pZAjHth2evw+ihco8ZiF2H+Vxf73iWhg7uo=;
	h=Date:From:To:Cc:Subject:From;
	b=D5BUfGP2jWwgtJdakmdP0Dsxlr4Sw96qM/fmBdWuDth25IU5oDlLwb5iEiZuY29nB
	 fCFpTE+qBoPYPWS0fVZxueQe6Zbs0Bw6I6xrTu9jhyw9CSq7aqtRldEruwpzWeKnlM
	 ONBXY4ObV7sG8YCHXLLBMHiFQE6x1IPRNBufgYKfmatVYcUmTVW44dAhmHBpFO40bX
	 Ig45BK/BLTOtGFQ2WwvEn8PaG4It3JJekTuNKgx8h1wPhIBcG4pwKsDBHCz8B68QXH
	 INr0Tdrme/m/Gs7w0elVIIh49ydfLUZCOrTwk+hZ4hWjteUVIcAVz1kndUG4pw+1Qh
	 cXnOxFQxIQVEg==
Date: Wed, 5 Feb 2025 11:22:43 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: linux-fsdevel@vger.kernel.org, linux-mm <linux-mm@kvack.org>
Cc: lsf-pc@lists.linux-foundation.org, Theodore Ts'o <tytso@mit.edu>,
	Dave Chinner <david@fromorbit.com>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	John Garry <john.g.garry@oracle.com>, Jens Axboe <axboe@kernel.dk>,
	Matthew Wilcox <willy@infradead.org>, mcgrof@kernel.org
Subject: [LSF/MM/BPF TOPIC] buffered IO atomic writes
Message-ID: <Z6O6g4pCu-pXJql5@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On v6.13 XFS got atomics write support through LBS. We have validated the
value of large atomics on databases and provided initial automation
for it through kdevops [0]. This requires direct IO today and there
are impressive confirmed results with it such as the ones Theodore Ts'o had
hinted at last year's LSFMM such as 3x-5x TPS variability gains. However the
results we have observed for buffered IO in PostgreSQL are even more
impressive: 14x-18x in TPS variability gains.

At least year's LSFMM we discused atomic buffered IO support, and if my
memory serves me correctly the conclusions where:

a) The PostgreSQL need for buffered IO due to lack of Direct IO is observed
   as a PostgreSQL mis-feature. So it is not a reason to add buffered IO
   atomic support

b) Near-writehrough buffered IO support would be good

c) Parallelizing writeback would be good

In so far as a) is concerned WiredTiger db is an example database which
although it supports both direct IO and buffered IO it strongly perfers
buffered IO. And so its an example of database which its users do
explicitly prefer buffered IO.

In so far as b) we now have RWF_DONTCACHE merged on v6.14-rc1. Will that
suffice? If not what are we missing?

And with regards to c) Kundan has suggested he's been working on parallelizing
writeback and its a sugested topic for LSFMM [1].

We have not re-tested PostgreSQL atomics benefits with RWF_DONTCACHE and
parallelizing writeback, however I suspect that may improve results even
further. So it seems to be a good time to ask, what else do we need for
buffered IO atomics?

[0] https://github.com/linux-kdevops/kdevops/blob/main/docs/sysbench/sysbench.md
[1] https://lore.kernel.org/all/20250129102627.161448-1-kundan.kumar@samsung.com/

  Luis

