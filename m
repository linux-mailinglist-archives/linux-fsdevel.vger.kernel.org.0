Return-Path: <linux-fsdevel+bounces-17089-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD5CB8A7956
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 01:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D7411F2308F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 23:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA61413AA2F;
	Tue, 16 Apr 2024 23:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="M4K2OJqY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD1B8120A;
	Tue, 16 Apr 2024 23:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713311270; cv=none; b=cCq4YFUFT4D+ACFgMphl9HsATml7maEiyEfXrt4dyYGYiV3u412kb1t6dRgsL4IkiP1HRpJseDvJJXal9PDJRPmGEStY2B7nJKvqfaQ94Jtk4Cuh72s2SSmrNDWGmk88+7tTS0NxUwaEY9Z1d37FPRKXa9Ep3tv+YP0BgH7Lq+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713311270; c=relaxed/simple;
	bh=E4qYFQ4yil4wjHYS1/FW8CyzUVA6B3zphOzoFqD0+Zc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MxzxavVyYeRpsTuEm9yxG+mMleqVEkxpIKKCXX+B5Ygk+E3mC/tACn5+7l7UhIVcpKAJ/jw9Let8lBivNMsNujt1uLJ91KWvORyyqEB/EiOaQIZOn55GWBOvXGXHdh4YZwVkw65wpCx9cJTB4JgB6kkPPtbq907yJmeDZq0jc7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=M4K2OJqY; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3K/Zre2nKGfZWOLPiTr4t34e4XEIjZU4FnWCkwGAALc=; b=M4K2OJqYinTDuMeFDthK89IYPy
	8Qm71W5jSfevyx77FK9P4EUC09ED28zNXDuRd0wC0MvHV9Lc/9tcPHwZBgnzpo2ykOiXGu0tuEiLb
	CQsvnJYfS3W+fDu246WDFNjVgThOeWFsbufFxCxHkqCJx2xRZiPnmXDQXLYeEYcT4d36Tjc0Qi4ab
	2jOAn2nub3iz/R/oeJ42UGiJoGfBip63JB7zLt0KNOyb6bPG+2XIt1WO5jqLDMOhIoYa1fyLP4Hcw
	bNYSSoODi045Au4bTMjj+oocZ18mRicu0115QNR/zfSzDo8fVssM6atJvHJeltwubp8iZwAo/FQgX
	Zb04R/eQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwsWe-00000001g3j-3FGG;
	Tue, 16 Apr 2024 23:47:44 +0000
Date: Wed, 17 Apr 2024 00:47:44 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 8/8] doc: Split buffer.rst out of api-summary.rst
Message-ID: <Zh8OIIv0SVgYRz5Y@casper.infradead.org>
References: <20240416031754.4076917-1-willy@infradead.org>
 <20240416031754.4076917-9-willy@infradead.org>
 <5b1938bc-e675-4f1c-810b-dd91f6915f1d@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b1938bc-e675-4f1c-810b-dd91f6915f1d@infradead.org>

On Tue, Apr 16, 2024 at 03:18:59PM -0700, Randy Dunlap wrote:
> On 4/15/24 8:17 PM, Matthew Wilcox (Oracle) wrote:
> > Buffer heads are no longer a generic filesystem API but an optional
> > filesystem support library.  Make the documentation structure reflect
> > that, and include the fine documentation kept in buffer_head.h.
> > We could give a better overview of what buffer heads are all about,
> > but my enthusiasm for documenting it is limited.
> > 
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > ---
> >  Documentation/filesystems/api-summary.rst | 3 ---
> >  Documentation/filesystems/index.rst       | 1 +

... where did my buffer.rst go to?  I'll figure it out later/tomorrow
and send a new 8/8.

> >  2 files changed, 1 insertion(+), 3 deletions(-)
> > 
> > diff --git a/Documentation/filesystems/api-summary.rst b/Documentation/filesystems/api-summary.rst
> > index 98db2ea5fa12..cc5cc7f3fbd8 100644
> > --- a/Documentation/filesystems/api-summary.rst
> > +++ b/Documentation/filesystems/api-summary.rst
> > @@ -56,9 +56,6 @@ Other Functions
> >  .. kernel-doc:: fs/namei.c
> >     :export:
> >  
> > -.. kernel-doc:: fs/buffer.c
> > -   :export:
> > -
> >  .. kernel-doc:: block/bio.c
> >     :export:
> >  
> > diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
> > index 1f9b4c905a6a..8f5c1ee02e2f 100644
> > --- a/Documentation/filesystems/index.rst
> > +++ b/Documentation/filesystems/index.rst
> > @@ -50,6 +50,7 @@ filesystem implementations.
> >  .. toctree::
> >     :maxdepth: 2
> >  
> > +   buffer
> 
> This causes:
> 
> Documentation/filesystems/index.rst:50: WARNING: toctree contains reference to nonexisting document 'filesystems/buffer'
> 
> 
> >     journalling
> >     fscrypt
> >     fsverity
> 
> -- 
> #Randy
> https://people.kernel.org/tglx/notes-about-netiquette
> https://subspace.kernel.org/etiquette.html

