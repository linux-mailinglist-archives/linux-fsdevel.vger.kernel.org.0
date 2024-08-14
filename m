Return-Path: <linux-fsdevel+bounces-25877-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 764F49513E4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 07:27:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2AFB1F24602
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 05:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13CFC54658;
	Wed, 14 Aug 2024 05:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Qb16q3Js"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C2C2901
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Aug 2024 05:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723613261; cv=none; b=S+Q1hQuDbIxIAoXt9iMUE1rEru5/nBDZKaPwxOrbdVvmV3dFD1Q5+H/2Uq82z3mm1cv8CdLMJueSYd7MjtY7MWvvqUxYDe0MG/JRUd0NtyKl5tX+L5WAgMIdV7dOVY8ScZr0BX10rxRVTBXri0bD3cxNxKpwRT0WKXZR5FiLPOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723613261; c=relaxed/simple;
	bh=uTmuPCBrtrBsT0S2i1XZjSDqCyaWTXay+HNddyUeA68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OOSuYh4ZIzfMSK2LzaGeBOV2VhS0wg2yjNITroXOuWM8bJ1k/YefTNriefvyH9rAI0pu59Kzm/JwxMnvzVx0QqKQho6g7Q/INoYWnsFJONT4uqrvbXG3Uknj1kNO06Dn5TYMyTbo2ltpPKjs81d9aJkEe73jP7SjGGjLsQ1tW2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Qb16q3Js; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=aevGGSQc0VDR/d6wuXp/nfXCQB1eisuqo6Ik/+jFkJw=; b=Qb16q3JsdsN7s4kWdj4ZZvXBL3
	4lf1p/6wn1Fb2JDM/kP8Q19dt9dLO+93dhZk2dD+736piFVbXEyVzCxsCizWqt8CrBrkn4ZxwHlpO
	1ztmPDoDibogaINHXfQgKvY8atxnJmFAMu+OtAf1urIm0bCNhJIu09yhzm4GV25vgFQd+ew5AH64H
	jgw2u4VwwCk1pJVthvhh1X+IxvaeIAfDnwDNZLFot5/4hRfxaOT5uFGSCn4E2bGqPngCfDfF0WqhQ
	Nvs4dFMlQMFZNwqyzLG1XlnuWgMx/t1PoSNgX6nuF5wVDJgRHFoX+QlE49bEQiRAoRvwAYsi+J5Ha
	QDL7fiJg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1se6Xq-00000005nr9-3DHe;
	Wed, 14 Aug 2024 05:27:38 +0000
Date: Tue, 13 Aug 2024 22:27:38 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, akpm@linux-foundation.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	david@fromorbit.com, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, Kent Overstreet <kent.overstreet@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH 1/2] mm: Add memalloc_nowait_{save,restore}
Message-ID: <ZrxASkumlaXWftJ8@infradead.org>
References: <20240812090525.80299-1-laoar.shao@gmail.com>
 <20240812090525.80299-2-laoar.shao@gmail.com>
 <Zrn0FlBY-kYMftK4@infradead.org>
 <CALOAHbBd2oCVKsMwcH_YGUWT5LGLWmNSUAZzRPp8j7bBaqc1PQ@mail.gmail.com>
 <ZroMalgcQFUowTLX@infradead.org>
 <CALOAHbC=fB0h-YgS9Fr6aTavhPFWKLJzzfM4huYjVaa9+97Y4g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALOAHbC=fB0h-YgS9Fr6aTavhPFWKLJzzfM4huYjVaa9+97Y4g@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

> There are already memalloc_noreclaim_{save,restore} which imply __GFP_MEMALLOC:
> 
>   memalloc_noreclaim_save - Marks implicit __GFP_MEMALLOC scope.

.. and those are horrible misnamed :(

If we can't even keep our APIs consistently name, who is supposed
to understand all this?


