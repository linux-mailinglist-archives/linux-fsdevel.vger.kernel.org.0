Return-Path: <linux-fsdevel+bounces-45595-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B3ECA79AA6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 05:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C41F77A36DA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 03:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FDA2198A29;
	Thu,  3 Apr 2025 03:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZXf9CJuv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1262581;
	Thu,  3 Apr 2025 03:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743652421; cv=none; b=MuW7oSwPowvS9TWQUqr2KUm42dGVQQYHyk9B7XxvzOx9MzXXFDKsknqpnPNkrqzAHvZnaz+Opz4FasSabRaz0Bgg7ZMiJdNscSniC9sxtYXXnwJClYR2pZoKXo0ho5ycec+Hs1jZhw+JyOzEmOZQ9jlKFV+Ao/JU0uD+050ET/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743652421; c=relaxed/simple;
	bh=KsxRYSkadP8sKUIJYSpYSNBgBpJHnNbRA1oUJqF+TxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XPRN4bo3X71xP4+H/SufN2QKdIrBr/6uh6q5gxASX4B+Zls7NMzRwX40fZPxXuq/SwCMImNfiCcD/nVjeC0x0qePZpa7OO9HPt1SdMkvQH7jd+AS11KbmhQry9YrivZ1HLEfyRDwi8iLVEpr2uG9hMN1zGB6GftmV57DXieOj4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZXf9CJuv; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=j98rwQL7G8di/BtMjoHWfEqONBrRzM9ADm8HabBJsPs=; b=ZXf9CJuvoUH/YE50tXTG4O7y7B
	rgnnIdzHH4ih+uy9q+Zxo+7Bycoq/fP9k7VVNa89ePhRcOL6u3/fY/0qMnMssb+xaTLwHZgMR7e6h
	tEzEDVFicwQVGYeucAIE2BgpVdl/BcTayDpYZYejpY4HgBrrT/PLkoS3ED4PbzhupuG8PrkfYXJxG
	7IH30YgiWnEqITe6xTrx6b6fNflMNeHp3uBRsfLxd/7u+hcQ/gFnxD/lZp8k53eAf42bm51EDsrgf
	Cj88ngx2F139E/LMxJ4YlS1/vMQZ8WWC9AE52UurF+GhIU1CZvYHdkahDQNrcfyee89PBN7aPll4k
	qY+38SkQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0Be4-0000000Aw2v-1G9j;
	Thu, 03 Apr 2025 03:53:36 +0000
Date: Thu, 3 Apr 2025 04:53:36 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: linux-fsdevel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
	linux-mm@kvack.org, dri-devel@lists.freedesktop.org,
	stable@vger.kernel.org, David Howells <dhowells@redhat.com>,
	v9fs@lists.linux.dev
Subject: Re: [PATCH v2 1/9] 9p: Add a migrate_folio method
Message-ID: <Z-4GQO_HcmcRqWnD@casper.infradead.org>
References: <20250402150005.2309458-1-willy@infradead.org>
 <20250402150005.2309458-2-willy@infradead.org>
 <Z-4EiVQ6klHkkMoy@codewreck.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-4EiVQ6klHkkMoy@codewreck.org>

On Thu, Apr 03, 2025 at 12:46:17PM +0900, Dominique Martinet wrote:
> Matthew Wilcox (Oracle) wrote on Wed, Apr 02, 2025 at 03:59:55PM +0100:
> > The migration code used to be able to migrate dirty 9p folios by writing
> > them back using writepage.  When the writepage method was removed,
> > we neglected to add a migrate_folio method, which means that dirty 9p
> > folios have been unmovable ever since.  This reduced our success at
> > defragmenting memory on machines which use 9p heavily.
> 
> Given I'm not in Cc of the whole series I'm lacking context but I assume
> that means I'm not supposed to take this in.

Right; I'm routing this whole series via Christian.  There's various
bits of the VFS that need to be touched as part of this series, and
it'd take forever to get it all merged by going through individual
maintainer trees.

> I won't pretend I understand folios anyway, but commit messages makes
> sense to me:
> Acked-by: Dominique Martinet <asmadeus@codewreck.org>

Thanks!  Folios aren't really that hard a concept for a filesystem
developer to understand, but dhowells has done a great job of insulating
you from even having to understand them with netfs.  All they are is
a container of one-or-more pages which maintain all the filesystem
state which used to be managed per-page.  eg dirty, writeback, locked,
offset-in-file, number-of-mappings.

There's more to it from a MM point of view, but as a filesystem
developer, that's all you really need to understand.

