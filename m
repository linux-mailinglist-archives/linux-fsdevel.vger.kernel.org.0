Return-Path: <linux-fsdevel+bounces-28324-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D3709694AA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 09:06:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 241DC283492
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 07:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEAE91D678C;
	Tue,  3 Sep 2024 07:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bOi1dv62"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22ADE1D6781
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Sep 2024 07:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725347182; cv=none; b=Fx06Y7e42VvO8qTAdCwDqVgI3Tm7fjy/hcpQ4gl3jAEvX8JFss5fvnLtaAoWPmsCSzrMObt1oAs7Qnj1GrW6FQOttNHo25caa9hO7VmFeyPoRLgmTpUhhF7H3H8dlejczoEW+O/U8A7lMJxDWTf1CzZK4g3OplKma2RKVpZbh3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725347182; c=relaxed/simple;
	bh=bjHUWj3zwiZ7VL+hZYMZioDaX52ctjqetSrHFO4bhEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g7zwA1n1I3y34GDq8NQny3pe7S/uCStSjyiaDesnb2MYMkQWQJzEoTrnZVYImjqJrva2yuxzZSs3viiR8JMHcYHu3GLhuJA/JzZA00xNAMDx5Yt2bXKZW9+VXi7yPApteTelYzp+ah0mWpISYqxZE9J6Vl1K/jDzQAd1janRGYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bOi1dv62; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-53438aa64a4so5962870e87.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Sep 2024 00:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1725347178; x=1725951978; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kvtznVhKc/eAuzlMN0NV0mbNt8/nqOdK8ldVlk9CEsg=;
        b=bOi1dv62GakIqfTSUDb8x8GjxjSGG1+A9kSZDUuC45nFa7NXu4nQgAJF5PDGTvWFl+
         FB08O4ZGnv49zwvjK/W68FzxICD0a2yXx01hoPYqNCo2IfwMtxjSz3qO/0o+QtTkSsp+
         psdYVjpT8xi1JGPU41uqxoYLOVZsV2PC7xowCSjR4gxNMeAxniFILD08Ze0EOfHdAWla
         9M6WrqTgIlWdZkekSip5dCieXzlpr1J44x7cu2sC5CCk2RlIRSRj2ATSiCIN2dyfrPPZ
         o1iS4CCblF/URt2mOzpraQ6i0HBkS8+OoyupHHxeFhGmV0pVc+JI4QC7LHJREPL3icJ2
         IMVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725347178; x=1725951978;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kvtznVhKc/eAuzlMN0NV0mbNt8/nqOdK8ldVlk9CEsg=;
        b=PlG2AXUJ8bVjUQXW8UwKcKxaqI7LDene8IHMqoDsiIGMtYKgohrmED+TmxKhCdEEDp
         DsgrAjFsX3D/RDKp9ycC1zFbUBxQO/fqgObpRx0MBpT3mD+7eJaHhGDz7A8dtV3QGVre
         wHJFxYI2maz9rb9aUDzcutuDHT4evwzSRUSKQYfcYKdh1RKsBmkfX2wNvme0pi63/8r1
         GUlV1JJ8i9KZD2ZeJB/bukXbMkcIsh9YG0TdzOYHQVAAerb0NmIe77VKntlTzNZah138
         yfa8qVD3U5QHA1bMO5rpR4/VYnVDedr0I2sidmL/bk8lZreW98c83dXU0ipgc1onp4km
         Vizw==
X-Forwarded-Encrypted: i=1; AJvYcCXiCT+LT7s3ExLv6YjqIBiRClewoEsLPaVTvERazk/bOf1FZkU1ZpT7HVj/wBaT08y5cMMb3f/6l3Dx6Ln3@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8xNKiC23FkOoZyRTsGH4+X0YABrABWqJzEu6KCFdsSGxid8fv
	no/XDktxEPNVF38cXqgp+us+L2y4x00zf5g6haNcWmHpvlbqWViaQGXNcGSB25L81ow2/kCPfQ/
	4
X-Google-Smtp-Source: AGHT+IFgb9y6scjaaJ6Ac8zMHkpqw9NAXdPaozwZh5IGu1XzjDYc4UFvGDiYVT0LhEjt+nA8PFhBpA==
X-Received: by 2002:a05:6512:159a:b0:52c:e047:5c38 with SMTP id 2adb3069b0e04-53546b0401cmr8748808e87.15.1725347178053;
        Tue, 03 Sep 2024 00:06:18 -0700 (PDT)
Received: from localhost ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a898900f0acsm646160266b.73.2024.09.03.00.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 00:06:17 -0700 (PDT)
Date: Tue, 3 Sep 2024 09:06:17 +0200
From: Michal Hocko <mhocko@suse.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>, Yafang Shao <laoar.shao@gmail.com>,
	jack@suse.cz, Vlastimil Babka <vbabka@suse.cz>,
	Dave Chinner <dchinner@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-bcachefs@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2 v2] remove PF_MEMALLOC_NORECLAIM
Message-ID: <Zta1aZA4u8PCHQae@tiehlicka>
References: <20240902095203.1559361-1-mhocko@kernel.org>
 <ggrt5bn2lvxnnebqtzivmge3yjh3dnepqopznmjmkrcllb3b35@4vnnapwr36ur>
 <20240902145252.1d2590dbed417d223b896a00@linux-foundation.org>
 <yewfyeumr2vj3o6dqcrv6b2giuno66ki7vzib3syitrstjkksk@e2k5rx3xbt67>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yewfyeumr2vj3o6dqcrv6b2giuno66ki7vzib3syitrstjkksk@e2k5rx3xbt67>

On Mon 02-09-24 18:32:33, Kent Overstreet wrote:
> On Mon, Sep 02, 2024 at 02:52:52PM GMT, Andrew Morton wrote:
> > On Mon, 2 Sep 2024 05:53:59 -0400 Kent Overstreet <kent.overstreet@linux.dev> wrote:
> > 
> > > On Mon, Sep 02, 2024 at 11:51:48AM GMT, Michal Hocko wrote:
> > > > The previous version has been posted in [1]. Based on the review feedback
> > > > I have sent v2 of patches in the same threat but it seems that the
> > > > review has mostly settled on these patches. There is still an open
> > > > discussion on whether having a NORECLAIM allocator semantic (compare to
> > > > atomic) is worthwhile or how to deal with broken GFP_NOFAIL users but
> > > > those are not really relevant to this particular patchset as it 1)
> > > > doesn't aim to implement either of the two and 2) it aims at spreading
> > > > PF_MEMALLOC_NORECLAIM use while it doesn't have a properly defined
> > > > semantic now that it is not widely used and much harder to fix.
> > > > 
> > > > I have collected Reviewed-bys and reposting here. These patches are
> > > > touching bcachefs, VFS and core MM so I am not sure which tree to merge
> > > > this through but I guess going through Andrew makes the most sense.
> > > > 
> > > > Changes since v1;
> > > > - compile fixes
> > > > - rather than dropping PF_MEMALLOC_NORECLAIM alone reverted eab0af905bfc
> > > >   ("mm: introduce PF_MEMALLOC_NORECLAIM, PF_MEMALLOC_NOWARN") suggested
> > > >   by Matthew.
> > > 
> > > To reiterate:
> > > 
> > 
> > It would be helpful to summarize your concerns.
> > 
> > What runtime impact do you expect this change will have upon bcachefs?
> 
> For bcachefs: I try really hard to minimize tail latency and make
> performance robust in extreme scenarios - thrashing. A large part of
> that is that btree locks must be held for no longer than necessary.
> 
> We definitely don't want to recurse into other parts of the kernel,
> taking other locks (i.e. in memory reclaim) while holding btree locks;
> that's a great way to stack up (and potentially multiply) latencies.

OK, these two patches do not fail to do that. The only existing user is
turned into GFP_NOWAIT so the final code works the same way. Right?

> But gfp flags don't work with vmalloc allocations (and that's unlikely
> to change), and we require vmalloc fallbacks for e.g. btree node
> allocation. That's the big reason we want MEMALLOC_PF_NORECLAIM.

Have you even tried to reach out to vmalloc maintainers and asked for
GFP_NOWAIT support for vmalloc? Because I do not remember that. Sure
kernel page tables are have hardcoded GFP_KERNEL context which slightly
complicates that but that doesn't really mean the only potential
solution is to use a per task flag to override that. Just from top of my
head we can consider pre-allocating virtual address space for
non-sleeping allocations. Maybe there are other options that only people
deeply familiar with the vmalloc internals can see.

This requires discussions not pushing a very particular solution
through.
-- 
Michal Hocko
SUSE Labs

