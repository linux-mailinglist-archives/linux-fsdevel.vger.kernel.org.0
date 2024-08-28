Return-Path: <linux-fsdevel+bounces-27526-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED75961E22
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 07:19:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B53C284BEA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 05:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B8B14D6EB;
	Wed, 28 Aug 2024 05:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fTy8xeLR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2D713D899;
	Wed, 28 Aug 2024 05:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724822381; cv=none; b=EYPbrG6NZZyzuZJ9HMT69qEPUNQXVUlIvspS5YTs+FJEVetpvAbQexc5E0Q6t/grecBjvFiJ5YFY5jRnQmOoPaV/Kv2B+LQT86f3adHX7laAb1GrKp6ifyfb2yag+GRsqOEuAXacWfbk1kACh3h5yHsdbsbXr55oy1LT6jFL1aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724822381; c=relaxed/simple;
	bh=p0hykdrs3IVV+/8kE0qhi2tiMBuG8rYUtoA01mWrde4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ovRrFi1xZWCI8yGhAbvmz+dWdVmb8a5yrQmgQaD5cI2yYZKSbBhGrbtWyeCTJ4j3r1GAXmS7iGlfgc9ZMahSVuK0lhknOrm+13XrbozXSbPbOb4xa4J7auBdoBrFBARALW15l3KknJpZZUNuwFQq/t49F5Y6KvJoMsNQpnz1u5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fTy8xeLR; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=tzhlQTYh2d23XWX/m13XmaXdxqBAbJc1OHnPQbZLNWA=; b=fTy8xeLRmgRAkv6z9A6zVUqKaO
	LKH/Sg0CKY0VI+8jajk2EBLMmgVW8BCMFOSsha9dAPWJxv7L4xKPVLxYfUMtm9ZYhCWY6+5eROD9Z
	0qX/QWUsf2oMM6oleEBkiwcQ2gQKiJqW3iY5btKzP7qqXOeSZxgC59+FUn4BnVmxJ7POYi+GuQpLs
	hd4FXNeZo789cUq380h/PhFrj/K0leQAt+MrhG62P+6X0wkMorXQWf0TkvfvInDll8n133UH72RRL
	AYfCPT+31ku/cx7nT2hRq2eP+aaqxx323t8P+tf8kWf6r1QXM3r1PeWFDka21x4SlaN2WZuS39STg
	h3Jz53UA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjB5k-0000000DtkO-1SMW;
	Wed, 28 Aug 2024 05:19:36 +0000
Date: Tue, 27 Aug 2024 22:19:36 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Haifeng Xu <haifeng.xu@shopee.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	tytso@mit.edu, yi.zhang@huaweicloud.com, yukuai1@huaweicloud.com,
	tj@kernel.org, linux-ext4@vger.kernel.org,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] buffer: Associate the meta bio with blkg from buffer page
Message-ID: <Zs6zaP52HRMQiWb1@infradead.org>
References: <20240828033224.146584-1-haifeng.xu@shopee.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828033224.146584-1-haifeng.xu@shopee.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Aug 28, 2024 at 11:32:24AM +0800, Haifeng Xu wrote:
> +	} else if (buffer_meta(bh)) {
> +		struct folio *folio;
> +		struct cgroup_subsys_state *memcg_css, *blkcg_css;
> +
> +		folio = page_folio(bh->b_page);
> +		memcg_css = mem_cgroup_css_from_folio(folio);
> +		if (cgroup_subsys_on_dfl(memory_cgrp_subsys) &&
> +		    cgroup_subsys_on_dfl(io_cgrp_subsys)) {
> +			blkcg_css = cgroup_e_css(memcg_css->cgroup, &io_cgrp_subsys);
> +			bio_associate_blkg_from_css(bio, blkcg_css);
> +		}

I'll leave it to people more familiar with cgroups to decide if this
is the right thing to do, but if it is the code here should go into
a helper so that other metadata bio submitters can reuse it.  That
helper also should have a good comment explaining it.


