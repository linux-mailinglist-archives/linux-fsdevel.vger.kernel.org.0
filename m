Return-Path: <linux-fsdevel+bounces-20901-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 787008FAAC7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 08:30:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0762728B187
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 06:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8643C140380;
	Tue,  4 Jun 2024 06:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XmOaJBCN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D488265F;
	Tue,  4 Jun 2024 06:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717482599; cv=none; b=lPFytXORno4S3q0xaHmelcP4OlTc65qJ1fN1HlX3bB4Uuw9iO24VPg2y0B5oH18QzAin6F3tkCD7Y+roiOy6equSI+DuROQ4Y29NfAD1Wmw3zh7CRxT1rJWOPIjmP4APSl3sJwYVGrjP8GiB7M423bIdRVvFGE8bru6dFJ9Pdoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717482599; c=relaxed/simple;
	bh=WuskAK9QMw2Rb7LOBaE2ncAcIhSptttUqQRlOQ8Mdw8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lviFPPfMP73KQSzaD9/9jH1FbUn0uAmUjpEyPiwnCqL2Cit5Nle78CN3wD/NZ90pwyw1UW2gj1R5+gSshndZf0KUmis5QgXjJYKkkMPx7qWsz0750XFKdr7P0uSYDH61DqWwlD/6bu3tguFcxTly/q6ZI75UM+jTg88095XK7Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XmOaJBCN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A60A5C4AF08;
	Tue,  4 Jun 2024 06:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717482599;
	bh=WuskAK9QMw2Rb7LOBaE2ncAcIhSptttUqQRlOQ8Mdw8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=XmOaJBCNNhIk3UU18TsE4jmyx7Lq7jCrOLUmJNxjqPDcCFDgQl2DmJgWeBoO5O2cy
	 hbtVw89hITlfEkLbn7HfQHjHjdjQZjHcowoB5tpg7avtohdheMiJ17HGEWrP0NXZei
	 QltPuZBue7VdCJkD9utcSgbTjV0DFdShfUCtR075TP9XMLt5aJ7lP6hAPskiJeheoH
	 6c68TGQVytiKrJkdqreOoQGp0MOMHBx47+s6j+SBYvRz4QBvPWtVhDrSfGAGlSHBn9
	 jNtKztz+66GA9ocoVqZV/4PWQhpUzXoz3Y989QMQ/jChKBqmFU0IVRf2ioegPhQyHV
	 /Tu0jucWCC6UA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 935DDC27C54;
	Tue,  4 Jun 2024 06:29:59 +0000 (UTC)
From: Joel Granados via B4 Relay <devnull+j.granados.samsung.com@kernel.org>
Date: Tue, 04 Jun 2024 08:29:20 +0200
Subject: [PATCH 2/8] mm profiling: Remove superfluous sentinel element from
 ctl_table
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240604-jag-sysctl_remset-v1-2-2df7ecdba0bd@samsung.com>
References: <20240604-jag-sysctl_remset-v1-0-2df7ecdba0bd@samsung.com>
In-Reply-To: <20240604-jag-sysctl_remset-v1-0-2df7ecdba0bd@samsung.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Suren Baghdasaryan <surenb@google.com>, 
 Kent Overstreet <kent.overstreet@linux.dev>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <keescook@chromium.org>, 
 Joel Granados <j.granados@samsung.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=862;
 i=j.granados@samsung.com; h=from:subject:message-id;
 bh=grXyma2z6K/wRopvypgEfIMP+PFHWBDb7VqNp82ood4=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGZetGLtay8GHHZfoulwDT7Cp/+NFmjaUVFeN
 K1kk9wfksxNuIkBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJmXrRiAAoJELqXzVK3
 lkFPLVQL/RZBp0EyIV+vm0gXQg6+z7wQ3w++rqI1ydJNjnUfIkWxiBXMoWjegWKgorptI5L0LL5
 QiBGzg09KK78sYzgGlTjTudseX5pEj0wPgl5NA41VUKS3+eKByodee1SAT7w/5KgDAtjOwJiCmx
 hsXoF/SogQ0PJnNF+lZgwNnSukeE3eotjMuL0fhv7BGE9TwpcF7pOGrqB8AmLn91nFXyVOWjtBj
 Y/BhWU1/R5n57AbIDkaR04pcY907qAipnMbKVrminTdDhcjrYBuoX2O3K/WsV5UGPLWxg7Pwr2+
 DKSCcd3f7cgKGvrqvuO0E1bsr+dsJj2zRAGJsSJtpfUhQ5A/KnmBUxbFb6W6IGbQVIfeAia9jys
 u3mALmKeyGRvnUkSMmH+z8yrhDmtI4Hn4lQUh9MofiwVN8fBR64dUuoxfVJhH2vHrg9PEnToAUN
 6djR12wRe1b3eoxy8lGrrPi6EMi8z7R+qmxIqSo83Up6qfK7p2AMUDkiSJY6aoyusP77KXPACI5
 0I=
X-Developer-Key: i=j.granados@samsung.com; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for j.granados@samsung.com/default with
 auth_id=70
X-Original-From: Joel Granados <j.granados@samsung.com>
Reply-To: j.granados@samsung.com

From: Joel Granados <j.granados@samsung.com>

This commit is part of a greater effort to remove all empty elements at
the end of the ctl_table arrays (sentinels) which will reduce the
overall build time size of the kernel and run time memory bloat by ~64
bytes per sentinel (further information Link :
https://lore.kernel.org/all/ZO5Yx5JFogGi%2FcBo@bombadil.infradead.org/)

Removed sentinel from memory_allocation_profiling_sysctls

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 lib/alloc_tag.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
index 11ed973ac359..7293cd54d1b1 100644
--- a/lib/alloc_tag.c
+++ b/lib/alloc_tag.c
@@ -238,7 +238,6 @@ static struct ctl_table memory_allocation_profiling_sysctls[] = {
 #endif
 		.proc_handler	= proc_do_static_key,
 	},
-	{ }
 };
 
 static int __init alloc_tag_init(void)

-- 
2.43.0



