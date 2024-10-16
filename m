Return-Path: <linux-fsdevel+bounces-32132-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB36B9A10F6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 19:53:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19AAF1C2371C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 17:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01437210C37;
	Wed, 16 Oct 2024 17:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="f6PtUGAN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D78A18BC23
	for <linux-fsdevel@vger.kernel.org>; Wed, 16 Oct 2024 17:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729101176; cv=none; b=b0Phc9CfEC5XPk9SLZ1vTysXztagFDgIvNFsFJciDTL6uVkf20GjK0g/LNFKGjHO66Ez/3OKtyktXjSxMd9O7pCgBDTYJXaH9J42yIs4JrcI0JQMeZ9LLF6OBXgJCUP+pUz+mY/8rH/52ARystUPnERXhfPnkLZ4g1p3WgZ+K/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729101176; c=relaxed/simple;
	bh=GJ2/U3PUlFHanYxL2mQL8wmNtTceUgDjtQt8xFnzuBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XovMFEjo6GzAmmFlyt5kSF8wyO7Ju3SevkCnP/esx5JH70mZETEERsdlnoD4XKdjDzGrKIYdkHah9FQgg+cfQPSz5Ez5dQdoRHJrNRRwOzo598+1HlDM8gBQ/o/QgXpo0XP94/xLS+TNbIt/UbSjVR41xuh6di/ijkUDuUnUYU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=f6PtUGAN; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 16 Oct 2024 10:52:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729101171;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3qEmnxdf1qUSBhAKRuNMDcudJRPSZUM0/YNJNSgZwkA=;
	b=f6PtUGANHdBtvg9CorG1ogGqmbREt38kyTWoRcYA314OI7znbKpjCVYcxOVQwbwF34mKLY
	Q09BG7zL8Esx/OgRd+QV/+IZbHQAN4FeXlYAyq2j/dqh2WGEqWrRRQRYGX2QWslsc3h/rq
	jzqWlvolFZStoo6FqIZZk5b9eUseM4M=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Joanne Koong <joannelkoong@gmail.com>, linux-fsdevel@vger.kernel.org, 
	josef@toxicpanda.com, bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com, 
	hannes@cmpxchg.org, linux-mm@kvack.org, kernel-team@meta.com
Subject: Re: [PATCH v2 2/2] fuse: remove tmp folio for writebacks and
 internal rb tree
Message-ID: <tgjnsph6wck3otk2zss326rj6ko2vftlc3r3phznswygbn3dtg@lxn7u3ojszzk>
References: <20241014182228.1941246-1-joannelkoong@gmail.com>
 <20241014182228.1941246-3-joannelkoong@gmail.com>
 <CAJfpegs+txwBQsJf8GhiKoG3VxLH+y9jh8+1YHQds11m=0U7Xw@mail.gmail.com>
 <CAJnrk1a5UaVP0qSKcuww2dhLkeUqdkri_FEyVMAuTtvv3NMu9Q@mail.gmail.com>
 <ntkzydgiju5b5y4w6hzd6of2o6jh7u2bj6ptt24erri3ujkrso@7gbjrat65mfn>
 <CAJfpeguS-xSjmH2ATTp-BmtTgT0iTk2_4EMtnoxPPcepP=BCpQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpeguS-xSjmH2ATTp-BmtTgT0iTk2_4EMtnoxPPcepP=BCpQ@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Oct 16, 2024 at 11:51:39AM GMT, Miklos Szeredi wrote:
> On Tue, 15 Oct 2024 at 21:17, Shakeel Butt <shakeel.butt@linux.dev> wrote:
> 
> > So, any operation that the fuse server can do which can cause wait on
> > writeback on the folios backed by the fuse is problematic. We know about
> > one scenario i.e. memory allocation causing reclaim which may do the
> > wait on unrelated folios which may be backed by the fuse server.
> >
> > Now there are ways fuse server can shoot itself on the foot. Like sync()
> > syscall or accessing the folios backed by itself. The quesion is should
> > we really need to protect fuse from such cases?
> 
> That's not the issue with sync(2).  The issue is that a fuse server
> can deny service to an unrelated and possibly higher privilege task by
> blocking writeback.  We really don't want that to happen.

If I understand you correctly, you are saying fuse server doing wrong
things like accessing the files it is serving is not something we need
to care about. More specifically all the operations which directly
manipulates the folios it is serving (like migration) should be ignored.
Is this correct?

