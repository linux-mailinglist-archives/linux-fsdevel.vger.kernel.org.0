Return-Path: <linux-fsdevel+bounces-27392-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C4B961371
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 18:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90F1B284765
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 16:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97BF61C93B9;
	Tue, 27 Aug 2024 16:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lmk208on"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C2F38DC7
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Aug 2024 15:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724774400; cv=none; b=lF8zGmPCtBAsd0K8JGl2k+bSKgn+FzzQLAS6/dnVrnH0gASNnulkPyxWQNjmVqzEypbD71Nw8b1zADKu/o56ZwZMqI4iyr7AepkpMqNdiUeckPC1ISWHBzlJk+ot2lq5/JNsz3iE8ni/D7+12dX0YVHhKSvfZ9vMoHLpjdDLaqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724774400; c=relaxed/simple;
	bh=DaOwdh4WKH9gXF8/LMGcwnmi8yEU+uIY+2kYd8RsxRw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ViiOGXgFYEpHkTNKz5i0oofUgR0+Nwmiqv6qcGFciYIIB9dIjwkfjHuDnSmcUMO8lW4JIMDGRrlaemKjP3EKopmkHC0w7kTt/F2QcG+wYPCQNv1ZqDxk3XYBJj11+UFZiG1Xyvxuu1FTPtjgEBV3KN5i5T5cB1THLF76+pyBE0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lmk208on; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACC16C4DE1F;
	Tue, 27 Aug 2024 15:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724774397;
	bh=DaOwdh4WKH9gXF8/LMGcwnmi8yEU+uIY+2kYd8RsxRw=;
	h=From:Subject:Date:To:Cc:From;
	b=lmk208onsQi6UzYDW0SQkAIukShqy8isFn+Xr0qPd5H2u9D32FzmH2fqFbkR480x+
	 F/W+wrv5TFWcLC/ImwLn84DfNyBzfAMjA3WNI7NCIPup6kfNyIeJwCunFsgYCp8QlH
	 p1Acml/LMl6ZId5myG6JInTvHJRvKYgaBorKFCV0GhCJ7NFCoDzl5e/DMb18j6Vj34
	 EMorsuMuGnsTY//Of4zrEBJoU/54CzNyI9SFFCsrECsfP/Hclqubl1EJwefX6EqQ0l
	 qB0qoc+7Ypm1XwjLV+oCOpZh+gzkOqEkWSBXaoO0P3URKvtYZ3POfJBqpg/lEYt4Yh
	 1tZU/1PFl3CmQ==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH v2 0/3] fs,mm: add kmem_cache_create_rcu()
Date: Tue, 27 Aug 2024 17:59:41 +0200
Message-Id: <20240827-work-kmem_cache-rcu-v2-0-7bc9c90d5eef@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAO33zWYC/zWNQQ6CMBBFr2K6tqZWLeDKexhiyjDYSUNLpoIaw
 t0tJO7mJfPfm0VCJkziupsF40SJYsig9zsBzoYnSmozC630WZW6kO/IXvoe+wdYcCgZRtlVBZ4
 uRikAI/JyYOzos1nvdebGJpQN2wBudU1dOvSUYH11lF6Rv1t/Oq6Df8rI6P04EDIGGXKrxeDz2
 ZalBaMLrBq4ZekYkEW9LMsPJzTRVswAAAA=
To: Vlastimil Babka <vbabka@suse.cz>, Jens Axboe <axboe@kernel.dk>, 
 "Paul E. McKenney" <paulmck@kernel.org>, 
 Roman Gushchin <roman.gushchin@linux.dev>, Jann Horn <jannh@google.com>, 
 Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=1258; i=brauner@kernel.org;
 h=from:subject:message-id; bh=DaOwdh4WKH9gXF8/LMGcwnmi8yEU+uIY+2kYd8RsxRw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSd/f6bo1JS3XRCudjUe+FSZnv6DugyzNt2/hPDxbPiw
 awfDppGdZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEyEYwnD//SzhYZ9LbUTMqWm
 fJt9YrbZq5knD1T9mv/ZsvX4NpUco2pGhm8SJ/03rvB+tmrXm8lRfP66SxZneL1sPLS25fmdR+v
 PCTMCAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

When a kmem cache is created with SLAB_TYPESAFE_BY_RCU the free pointer
must be located outside of the object because we don't know what part of
the memory can safely be overwritten as it may be needed to prevent
object recycling.

That has the consequence that SLAB_TYPESAFE_BY_RCU may end up adding a
new cacheline. This is the case for .e.g, struct file. After having it
shrunk down by 40 bytes and having it fit in three cachelines we still
have SLAB_TYPESAFE_BY_RCU adding a fourth cacheline because it needs to
accomodate the free pointer and is hardware cacheline aligned.

I tried to find ways to rectify this as struct file is pretty much
everywhere and having it use less memory is a good thing. So here's a
proposal.

I was hoping to get something to this effect into v6.12.

If we really want to switch to a struct to pass kmem_cache parameters I
can do the preparatory patch to convert all kmem_cache_create() and
kmem_cache_create_usercopy() callers to use a struct for initialization
of course. I can do this as a preparatory work or as follow-up work to
this series. Thoughts?

Thanks!
Christian

---
---
base-commit: 766508e7e2c5075eb744cb29b8cef6fa835b0344
change-id: 20240827-work-kmem_cache-rcu-f97e35600cc6


