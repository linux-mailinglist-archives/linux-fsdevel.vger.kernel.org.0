Return-Path: <linux-fsdevel+bounces-27213-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 893AD95F98A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 21:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD79A1C221D5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 19:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 460AE19992B;
	Mon, 26 Aug 2024 19:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="L/ckrLmI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3141991AB
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Aug 2024 19:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724699887; cv=none; b=YLZ09c73zQot0SioocTSIMjmkXKwmrsBwhE08m2pDbncqU5LX377RjyNrQLheI9vzdo732DO47EXM/tMfxBN3cMYGLpHtYNUgavFwlJuAJaZrcAQuEP8gGduMHdNuBy6kNbnnUrKjg/plIEZAi/d6c/igFIn2MTHLImxg/YYAKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724699887; c=relaxed/simple;
	bh=RjoCyBPuUmwzR99UmfsOy2bs4prLnpGChJPMeAZvhHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ux0n4H4fT7HkzqT+uG4TLaQpviqqHh2dBeTc61c9gSuM8Y+evmIWOKj3Mn++kTFAbvo/YTxNNYy50ZO21JDNliJYuOs0FQMygBN4uQzNnsD8b3bG3k02H8TgCZDPwijD/l8WGaJRDAbEs4iNFkusmQSIqwhBdOhyUFhWMxpIpyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=L/ckrLmI; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a866cea40c4so539153166b.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Aug 2024 12:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724699883; x=1725304683; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xiRoHNB81Ptn4aOx86M2sFOjWxRebcIeVsDZD8ofhhk=;
        b=L/ckrLmILb4eNkczjvddaC5JtvIM8FMrKnDkzUW3dZp+/43rhA792RA6zBgMakPXQR
         1OKKRLwEF367d/taaiZN9jlMZBnsAH72jB4S+ktiM3X9cNhEnbjBt1GFQnvzV53Qh3qY
         /4azuEsMpnhQVOOcW0Anxs5ddN0pSi+enzQNinOUpOjPuYSisj0aYyWxKBqKuqWphx9R
         C7cMPYdm4Xu8QtnulkcZWCSjoRLXWNgCeJhBeh/+IZYUiFujtEe8+VCgrb3krn+flvDu
         GOX4E1rVKSS5ZYrxwzNB6bjqQfiAgmwgz/JXhoI+R6zdLm9qzcCmjduDJFDvrQLn/IuD
         qslA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724699883; x=1725304683;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xiRoHNB81Ptn4aOx86M2sFOjWxRebcIeVsDZD8ofhhk=;
        b=ZjrQV1+QyF3kbmMQoTYOSCEROM/iqBDQlyYBc6Z7M3QofA+5xB9roSiGjh+ad2U7cV
         RxP4NgmIsGwwrvgHx+DMKvt7cvGea61PDXCSwuL6ln/c688LtjkUdP6VJVH+AIllU0EE
         YicJsBUXhLb1mQGca4j/YuE614r9D0VOwtITLrgfTWwQ1Y8v4dUwMhqrcTbftuYqft/P
         u6LzSLOM4djnQmOG7mI+M9p5Y/ubP4+8yesLDCB96dtd/UHufxIWuJn1swbWH33ikG6s
         85DiuVWc8bXuHC6qFclADBXuqQW9KMkVlkiHchgcq2/HS/q3dJ6520TE2Djm84rtizbN
         HjpA==
X-Forwarded-Encrypted: i=1; AJvYcCWIaBXOqkSStz3zQJC2TFx+t/iDjrx9RYpCXgVi09w+tJMFB/NqfrKzEseloxuleyzCI1X9moVcZFLHWDpL@vger.kernel.org
X-Gm-Message-State: AOJu0YwsDBWtYBwJthz9R5qqLbEZRwHEFqF0iOnNBt4cMo774J3+oxZ8
	PVyw7wiFOvup9bd/I1hZXJGv7SarBXiyY1iI77P7UQrgr68hGIA9ae+nMVfhrQk=
X-Google-Smtp-Source: AGHT+IHrIGYU84UjYCNbDb6/WHAjCYTMtATn4QzceOzz/6tH9FwHu3qL8H4cTXqk5vNmGiA77oJtcw==
X-Received: by 2002:a17:907:f1d8:b0:a86:9ac9:f3ff with SMTP id a640c23a62f3a-a86a5198afdmr798222466b.26.1724699882968;
        Mon, 26 Aug 2024 12:18:02 -0700 (PDT)
Received: from localhost (109-81-92-122.rct.o2.cz. [109.81.92.122])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a86e5486a1esm10338066b.10.2024.08.26.12.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 12:18:02 -0700 (PDT)
Date: Mon, 26 Aug 2024 21:18:01 +0200
From: Michal Hocko <mhocko@suse.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>, Yafang Shao <laoar.shao@gmail.com>,
	Kent Overstreet <kent.overstreet@linux.dev>, jack@suse.cz,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-bcachefs@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm: drop PF_MEMALLOC_NORECLAIM
Message-ID: <ZszU6dTOJYmujMPd@tiehlicka>
References: <20240826085347.1152675-1-mhocko@kernel.org>
 <20240826085347.1152675-3-mhocko@kernel.org>
 <ZsyKQSesqc5rDFmg@casper.infradead.org>
 <ZsyyqxSv3-IbaAAO@tiehlicka>
 <ZszAI7oYsh7FvGgg@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZszAI7oYsh7FvGgg@casper.infradead.org>

On Mon 26-08-24 18:49:23, Matthew Wilcox wrote:
> On Mon, Aug 26, 2024 at 06:51:55PM +0200, Michal Hocko wrote:
[...]
> > If a plan revert is preferably, I will go with it.
> 
> There aren't any other users of PF_MEMALLOC_NOWARN and it definitely
> seems like something you want at a callsite rather than blanket for every
> allocation below this point.  We don't seem to have many PF_ flags left,
> so let's not keep it around if there's no immediate plans for it.

Good point. What about this?
--- 
From 923cd429d4b1a3520c93bcf46611ae74a3158865 Mon Sep 17 00:00:00 2001
From: Michal Hocko <mhocko@suse.com>
Date: Mon, 26 Aug 2024 21:15:02 +0200
Subject: [PATCH] Revert "mm: introduce PF_MEMALLOC_NORECLAIM,
 PF_MEMALLOC_NOWARN"

This reverts commit eab0af905bfc3e9c05da2ca163d76a1513159aa4.

There is no existing user of those flags. PF_MEMALLOC_NOWARN is
dangerous because a nested allocation context can use GFP_NOFAIL which
could cause unexpected failure. Such a code would be hard to maintain
because it could be deeper in the call chain.

PF_MEMALLOC_NORECLAIM has been added even when it was pointed out [1]
that such a allocation contex is inherently unsafe if the context
doesn't fully control all allocations called from this context.

While PF_MEMALLOC_NOWARN is not dangerous the way PF_MEMALLOC_NORECLAIM
is it doesn't have any user and as Matthew has pointed out we are
running out of those flags so better reclaim it without any real users.

[1] https://lore.kernel.org/all/ZcM0xtlKbAOFjv5n@tiehlicka/

Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 include/linux/sched.h    |  4 ++--
 include/linux/sched/mm.h | 17 ++++-------------
 2 files changed, 6 insertions(+), 15 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index f8d150343d42..731ff1078c9e 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1657,8 +1657,8 @@ extern struct pid *cad_pid;
 						 * I am cleaning dirty pages from some other bdi. */
 #define PF_KTHREAD		0x00200000	/* I am a kernel thread */
 #define PF_RANDOMIZE		0x00400000	/* Randomize virtual address space */
-#define PF_MEMALLOC_NORECLAIM	0x00800000	/* All allocation requests will clear __GFP_DIRECT_RECLAIM */
-#define PF_MEMALLOC_NOWARN	0x01000000	/* All allocation requests will inherit __GFP_NOWARN */
+#define PF__HOLE__00800000	0x00800000
+#define PF__HOLE__01000000	0x01000000
 #define PF__HOLE__02000000	0x02000000
 #define PF_NO_SETAFFINITY	0x04000000	/* Userland is not allowed to meddle with cpus_mask */
 #define PF_MCE_EARLY		0x08000000      /* Early kill for mce process policy */
diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index 91546493c43d..07c4fde32827 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -258,25 +258,16 @@ static inline gfp_t current_gfp_context(gfp_t flags)
 {
 	unsigned int pflags = READ_ONCE(current->flags);
 
-	if (unlikely(pflags & (PF_MEMALLOC_NOIO |
-			       PF_MEMALLOC_NOFS |
-			       PF_MEMALLOC_NORECLAIM |
-			       PF_MEMALLOC_NOWARN |
-			       PF_MEMALLOC_PIN))) {
+	if (unlikely(pflags & (PF_MEMALLOC_NOIO | PF_MEMALLOC_NOFS | PF_MEMALLOC_PIN))) {
 		/*
-		 * Stronger flags before weaker flags:
-		 * NORECLAIM implies NOIO, which in turn implies NOFS
+		 * NOIO implies both NOIO and NOFS and it is a weaker context
+		 * so always make sure it makes precedence
 		 */
-		if (pflags & PF_MEMALLOC_NORECLAIM)
-			flags &= ~__GFP_DIRECT_RECLAIM;
-		else if (pflags & PF_MEMALLOC_NOIO)
+		if (pflags & PF_MEMALLOC_NOIO)
 			flags &= ~(__GFP_IO | __GFP_FS);
 		else if (pflags & PF_MEMALLOC_NOFS)
 			flags &= ~__GFP_FS;
 
-		if (pflags & PF_MEMALLOC_NOWARN)
-			flags |= __GFP_NOWARN;
-
 		if (pflags & PF_MEMALLOC_PIN)
 			flags &= ~__GFP_MOVABLE;
 	}
-- 
2.46.0


-- 
Michal Hocko
SUSE Labs

