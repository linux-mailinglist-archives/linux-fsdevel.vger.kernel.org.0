Return-Path: <linux-fsdevel+bounces-63786-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CF9D6BCDBA3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 17:11:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1500E50042C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 15:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E7FA2F7AD2;
	Fri, 10 Oct 2025 15:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VSVTiEF/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F482F6571
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Oct 2025 15:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760108886; cv=none; b=PZHXud2OSZnaV20oJqbNxoJ14kRr7CE8lR3P3cYJ/6/9rnGMl7pMi9tQx4vDxm1kjK8KnVG3aGnPbgNkmyRo0Id5ch2iF++GY3mq90JEbj3J65SKB4zkMeAFvCuNX80N7UYrLA1/koOcEoGUbk2z/zbv5Y6A8EaoGrTmZHhEZsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760108886; c=relaxed/simple;
	bh=uGEazi1FuTCT7oIOuAdb0635RM7kubublce5V0iTWEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=up3nOBoI11kyoZG6id70VN27GxMDbO4qvorohgRfbUc80e1o7exTtut1DYOhhZljy+tBklfDpaUIATeYTeq3ds0u+aYYjU/gDawD/7CI2vwnk2G4w1nWaix+MBGxPW5FDl4ZWd72TlyogEZa+y36W8ILB4leYyCuhb6s4Y1R2I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VSVTiEF/; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=2i4g3ZgeSbL4H/JkzCmGMfKxgVXGbJNxmdmwESlUtVY=; b=VSVTiEF/8wkXsb6fTS6tQAPXaE
	dlyJMN4IrISqYarVk2Rblau+b5kTXoGAvS0ee+ZFGONhd7hd42CFckuvsT+IsYDVPdUwfNDYsP5KI
	PwiQKhe2pNU5r0odNXjdK1xpjs51AlFgQMYAvnhc7QY0KRs4mqYGbG+WQVk8zawsofP0tP41VwIKv
	B8fjt+ogqKBXjtAlEI12bl/R61mur+u38CVzK3oo4/Y2MWaI97774ZgCiV3akgqy+pz0IrW5Xg1R4
	J9Y0mZRaukBY0MRMuLqd0sZNquWZg1Y8SDud6hiOdcjQHS/QN55sECVA8z58A6G5YVp6IFy/8HYry
	KeBk5CJg==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v7Eis-0000000Cqba-2vpV;
	Fri, 10 Oct 2025 15:07:58 +0000
Date: Fri, 10 Oct 2025 16:07:58 +0100
From: Matthew Wilcox <willy@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Joanne Koong <joannelkoong@gmail.com>,
	Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH] fuse: disable default bdi strictlimiting
Message-ID: <aOkhTlyj44bg3tI3@casper.infradead.org>
References: <20251008204133.2781356-1-joannelkoong@gmail.com>
 <CAJfpegsyHmSAYP04ot8neu_QtsCkTA2-qc2vvvLrsNLQt1aJCg@mail.gmail.com>
 <CAJnrk1anOVeNyzEe37p5H-z5UoKeccVMGBCUL_4pqzc=e2J7Ug@mail.gmail.com>
 <20251010150113.GC6174@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251010150113.GC6174@frogsfrogsfrogs>

On Fri, Oct 10, 2025 at 08:01:13AM -0700, Darrick J. Wong wrote:
> [cc willy in case he has opinions about dynamically changing the
> pagecache order range]

It's not designed for that.  mapping_set_folio_order_range() accesses
mapping->flags without any locking/atomicity, so we can overwrite
other changes to mapping->flags, like setting AS_EIO.  It really
is supposed to be "the filesystem supports folios of these sizes",
not "we've made some runtime change to the filesystem and now we'd
preefer the MM uses folios of these sizes instead of those".

