Return-Path: <linux-fsdevel+bounces-28291-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF2A968F3A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 23:53:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24412B22543
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 21:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A774B187344;
	Mon,  2 Sep 2024 21:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="xyjS5qj+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00A2154C1D;
	Mon,  2 Sep 2024 21:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725313973; cv=none; b=oFkVuFUZr+99XdDiOGmnrYwMwuqcNq9cD3B59AgMRKUmDgRZ6Lfd/XB05K4DkPC2eWueR3Gf5gGrNvI8I2cRJRq03eGKJmRjQfIE81+Wenu8eJqGl5udYO38ced2x5G5d5SErdbIfMRTpu6FNXjMEw7P+5/KfzvgMg360dZ+WoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725313973; c=relaxed/simple;
	bh=24vqQSqoLckxgOVc8ARaONcxfqOIrm8KRgBa6hQ2Oqo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=TO82/ICMSC2Fy/te6l9xsF08/JMU7vV5XvXmt0jix0avewPNEMp92cef2wpLDMVV7KPk4Zasw3vzjFdtBJJLAQ5UZ8m7xjJz9SbA6CONhamKym0so3idMs7EfDEMo4FrvSEQDY4e5teKdEi0GfnWfUZ52Rsq6MU9U7/eK7Sl2Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=xyjS5qj+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99BB1C4CEC2;
	Mon,  2 Sep 2024 21:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1725313973;
	bh=24vqQSqoLckxgOVc8ARaONcxfqOIrm8KRgBa6hQ2Oqo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=xyjS5qj+O9H9mLCb46Pxw6v5dZusoW34qbCw/sihCiKqAsUL8CD2fpVpRkZ4B5exf
	 TIcWChX6RQMCiyuwVSR4QE+JBJo+XmSmQjLte2kb4ldiKto3+o+GhC+dkb5TDCTGXd
	 zJzlQKETOLTZt7dM7CSNCxppvoXXsQICuD4u/IwE=
Date: Mon, 2 Sep 2024 14:52:52 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Michal Hocko <mhocko@kernel.org>, Christoph Hellwig <hch@lst.de>, Yafang
 Shao <laoar.shao@gmail.com>, jack@suse.cz, Vlastimil Babka
 <vbabka@suse.cz>, Dave Chinner <dchinner@redhat.com>, Christian Brauner
 <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Paul Moore
 <paul@paul-moore.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn"
 <serge@hallyn.com>, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-bcachefs@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2 v2] remove PF_MEMALLOC_NORECLAIM
Message-Id: <20240902145252.1d2590dbed417d223b896a00@linux-foundation.org>
In-Reply-To: <ggrt5bn2lvxnnebqtzivmge3yjh3dnepqopznmjmkrcllb3b35@4vnnapwr36ur>
References: <20240902095203.1559361-1-mhocko@kernel.org>
	<ggrt5bn2lvxnnebqtzivmge3yjh3dnepqopznmjmkrcllb3b35@4vnnapwr36ur>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 2 Sep 2024 05:53:59 -0400 Kent Overstreet <kent.overstreet@linux.dev> wrote:

> On Mon, Sep 02, 2024 at 11:51:48AM GMT, Michal Hocko wrote:
> > The previous version has been posted in [1]. Based on the review feedback
> > I have sent v2 of patches in the same threat but it seems that the
> > review has mostly settled on these patches. There is still an open
> > discussion on whether having a NORECLAIM allocator semantic (compare to
> > atomic) is worthwhile or how to deal with broken GFP_NOFAIL users but
> > those are not really relevant to this particular patchset as it 1)
> > doesn't aim to implement either of the two and 2) it aims at spreading
> > PF_MEMALLOC_NORECLAIM use while it doesn't have a properly defined
> > semantic now that it is not widely used and much harder to fix.
> > 
> > I have collected Reviewed-bys and reposting here. These patches are
> > touching bcachefs, VFS and core MM so I am not sure which tree to merge
> > this through but I guess going through Andrew makes the most sense.
> > 
> > Changes since v1;
> > - compile fixes
> > - rather than dropping PF_MEMALLOC_NORECLAIM alone reverted eab0af905bfc
> >   ("mm: introduce PF_MEMALLOC_NORECLAIM, PF_MEMALLOC_NOWARN") suggested
> >   by Matthew.
> 
> To reiterate:
> 

It would be helpful to summarize your concerns.

What runtime impact do you expect this change will have upon bcachefs?

