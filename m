Return-Path: <linux-fsdevel+bounces-26097-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C55BD9543C5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2024 10:18:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B37E282F0B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2024 08:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D10312A177;
	Fri, 16 Aug 2024 08:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Vrf4aKPz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FB31AC8BE
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Aug 2024 08:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723796279; cv=none; b=ovOnaeq9ud+9jHcdInt71buS1m5XDyQvlSwKdwYJ+UtUPMt27NuUnE/gMqQeEj/IKdl2wuJNSNi/Cb95Qi/nW2BNatiqmH64+63oFBz9UYGLy2aaEsreBcngaLEdNX7MmM79AAH7SnhnYD4rA/qhuSSagifrHuTzZBYeOOw9o5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723796279; c=relaxed/simple;
	bh=+tOr+vFSsOH7if1OGX+2e3ehRDBb/JMPwcAtQkr3zMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V5h2jgdp6JgnFJFKXt4G3FA2ydfyVvD1S+GMFF1h8K2nNoMCM5T0MRl4CfV42gzR8MdPz1xegSpnSb4qD03fQTR+TnlFPCztOCSjG+IHb53GxAATDBpJMbCm0bw3DkVHlYI1pRRG8rt0PH51FpaTMbRzngY4GVkGbndKBnWKPFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Vrf4aKPz; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-429d2d7be1eso8716375e9.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Aug 2024 01:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1723796276; x=1724401076; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BU1tkV8X5i7PiBXUSXfeBM0LeURMRevsmU6tlpXfkvU=;
        b=Vrf4aKPz52XUD2fNwSVbwdD3PAumh0CQDpXDhiUfcvdIMg5VYpqbRQxQcxr2sACCbQ
         ai58Y6Nbew8FwgHQaM2vaRP/Z66GO5yTVM/DUnmjoEjvtXwv3tqBoK+tYq42hDQ3OPGP
         RDfAO2l7TNQUQVLlxyr19Pl1N2igG1iEQbVl2/g2kReuEhASWejR/U5l6wJsfb8te0RL
         UDW+pZhkpCD9sdBbo2ieHGPCzyuuO6UJzovzu5AZ0EXfYfsuvo3Q60XeKtz5h/QaPs/2
         X4bH+99cunyZ6z0TrznZxkP84l7QWHDdFL7p4L7KfwERq6RTlnGVfDxQo2WjnZLRQ+ry
         pL7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723796276; x=1724401076;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BU1tkV8X5i7PiBXUSXfeBM0LeURMRevsmU6tlpXfkvU=;
        b=s3jaCa2ab8t5bRa50PaaSCeGqVnIUxpEbn5y8QOxqlR9DkPavMhyS82LSATYGbYqeh
         HuW1JFF+pO/wNKRftnwtkszF0MfwHPhgbFIvB2v7BQYPOWAWvAgrNiOx2hMMJWGxWFY2
         xcmoJCdRj59elOVmjByQZ1SY7gZgpuJ5rcngVWiVk/SsGCT0UxsaDsDK/58vbik2ZUzO
         3+huZTa6L2YGIGa1O7XPooEFiJvKtLzRN0AgM5rh5ntwm7XqnhVjlgRGqt16o9kS6b3S
         1ChwaDrUvymQ3TAKYzz0TIumSlTrpBedCjEmzfbSAD7KsB+TNRlsSZs3oPJ2y+xVcbqG
         baKg==
X-Forwarded-Encrypted: i=1; AJvYcCV0PUk662nG1wa9CQ//nP23AM4GlvWCjxiAlGdianLiaSjrbGItegILHCIDEG6foCq/TfM/9D18vzVGIMIxdUqMwjcn3ykNqYMxGWEDYA==
X-Gm-Message-State: AOJu0YxpdfP7MrN8JZ/luYNhClAeCgPpE+HulPvqU6hFBBGwnXKnOd0m
	/MC7qb838Cf4emqoBXE/O/JzidWjLt8316mXG708v4I0MJHoFqgENHWv/KEnKoY=
X-Google-Smtp-Source: AGHT+IGBiSeKP399RCWUTeuQdD9KB6Ykee9ZDfpSvw2v4GqqALRmzPxInSnplvOqg+obpaH39BKWIw==
X-Received: by 2002:a05:600c:5124:b0:426:6327:5a16 with SMTP id 5b1f17b1804b1-429eda33161mr11472425e9.18.1723796276006;
        Fri, 16 Aug 2024 01:17:56 -0700 (PDT)
Received: from localhost (109-81-92-77.rct.o2.cz. [109.81.92.77])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ed658651sm16281245e9.26.2024.08.16.01.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 01:17:55 -0700 (PDT)
Date: Fri, 16 Aug 2024 10:17:54 +0200
From: Michal Hocko <mhocko@suse.com>
To: Yafang Shao <laoar.shao@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Hellwig <hch@infradead.org>, akpm@linux-foundation.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	david@fromorbit.com, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, Kent Overstreet <kent.overstreet@linux.dev>
Subject: [PATCH] mm: document risk of PF_MEMALLOC_NORECLAIM
Message-ID: <Zr8LMv89fkfpmBlO@tiehlicka>
References: <20240812090525.80299-2-laoar.shao@gmail.com>
 <Zrn0FlBY-kYMftK4@infradead.org>
 <CALOAHbBd2oCVKsMwcH_YGUWT5LGLWmNSUAZzRPp8j7bBaqc1PQ@mail.gmail.com>
 <Zrxfy-F1ZkvQdhNR@tiehlicka>
 <CALOAHbCLPLpi39-HVVJvUj=qVcNFcQz=3cd95wFpKZzUntCtdw@mail.gmail.com>
 <ZrymePQHzTHaUIch@tiehlicka>
 <CALOAHbDw5_hFGsQGYpmaW2KPXi8TxnxPQg4z7G3GCyuJWWywpQ@mail.gmail.com>
 <Zr2eiFOT--CV5YsR@tiehlicka>
 <CALOAHbCnWDPnErCDOWaPo6vc__G56wzmX-j=bGrwAx6J26DgJg@mail.gmail.com>
 <Zr2liCOFDqPiNk6_@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zr2liCOFDqPiNk6_@tiehlicka>

Andrew, could you merge the following before PF_MEMALLOC_NORECLAIM can
be removed from the tree altogether please? For the full context the 
email thread starts here: https://lore.kernel.org/all/20240812090525.80299-1-laoar.shao@gmail.com/T/#u
--- 
From f17d36975ec343d9388aa6dbf9ca8d1b58ed09ce Mon Sep 17 00:00:00 2001
From: Michal Hocko <mhocko@suse.com>
Date: Fri, 16 Aug 2024 10:10:00 +0200
Subject: [PATCH] mm: document risk of PF_MEMALLOC_NORECLAIM

PF_MEMALLOC_NORECLAIM has been added even when it was pointed out [1]
that such a allocation contex is inherently unsafe if the context
doesn't fully control all allocations called from this context. Any
potential __GFP_NOFAIL request from withing PF_MEMALLOC_NORECLAIM
context would BUG_ON if the allocation would fail.

[1] https://lore.kernel.org/all/ZcM0xtlKbAOFjv5n@tiehlicka/

Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 include/linux/sched.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index f8d150343d42..0c9061d2a8bd 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1657,7 +1657,12 @@ extern struct pid *cad_pid;
 						 * I am cleaning dirty pages from some other bdi. */
 #define PF_KTHREAD		0x00200000	/* I am a kernel thread */
 #define PF_RANDOMIZE		0x00400000	/* Randomize virtual address space */
-#define PF_MEMALLOC_NORECLAIM	0x00800000	/* All allocation requests will clear __GFP_DIRECT_RECLAIM */
+#define PF_MEMALLOC_NORECLAIM	0x00800000	/* All allocation requests will clear __GFP_DIRECT_RECLAIM.
+						 * This is inherently unsafe unless the context fully controls
+						 * all allocations used. Any potential __GFP_NOFAIL nested allocation
+						 * could BUG_ON as the page allocator doesn't support non-sleeping
+						 * __GFP_NOFAIL requests.
+						 */
 #define PF_MEMALLOC_NOWARN	0x01000000	/* All allocation requests will inherit __GFP_NOWARN */
 #define PF__HOLE__02000000	0x02000000
 #define PF_NO_SETAFFINITY	0x04000000	/* Userland is not allowed to meddle with cpus_mask */
-- 
2.46.0

-- 
2.46.0

