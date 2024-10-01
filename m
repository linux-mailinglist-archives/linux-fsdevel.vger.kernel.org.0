Return-Path: <linux-fsdevel+bounces-30432-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 587A598B3EB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 07:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 177E928310B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 05:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D08B31BBBC0;
	Tue,  1 Oct 2024 05:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rnaXq/TM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39AC436AF8;
	Tue,  1 Oct 2024 05:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727761980; cv=none; b=II80Qv5AvAyQt+qPavxie1F4sHRTr2yBvIKUHknq6daKMDYk7/Gf6rNOggM3okXVU5BkyNL47ZVU2XNc6pIXVrjI1TSf0hisAIcx4b9nDSoX58VFSY9WH8C6PdxOV/EI3mSQTuhWTsBCVCHBpckzjDLpe0TIb4zGmISoAv01Lps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727761980; c=relaxed/simple;
	bh=0+CPOfnmHYHeRC7eu59dVaMtF89w2IqUByfrozk8r2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mYHAl6mW7VJnarvhj+nq4bhdZ1KjAjy35PlGeyZFW6QKo7srpCybexbVn+lhQ6Bh/8Rt8bb9UdYZ6xWZ14eTd/buKpc75LdGoQRhpQTi3Pe7DMTeYpseosneKN71J53Aihq7gXc0443rHPASh9UjoeugdBHMD08eJyajoZorY4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rnaXq/TM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EC9EC4CEC6;
	Tue,  1 Oct 2024 05:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727761978;
	bh=0+CPOfnmHYHeRC7eu59dVaMtF89w2IqUByfrozk8r2o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rnaXq/TMSwK1Y1WfiSZKejaMZfKjmUA95eg1Qb+tz2KdQbp4x35JzjHNavKTKpV6+
	 ANIEOQdJ8bzLhZBJJOfGoxR51LZti9avkhLo/Ksi/MlDm2hPZNbw0LqFJFA5qlEAO0
	 sQC6Iv9w0ypEA4wsD+z4Bcuwk1bIHEu9Q9htl3P/lBCQXOiMaicGBUZvBCLCQpJXf1
	 2p+O3a7i9Zd4hNKDBk/4zWJOoiPx6UzJo2KuhabWmtqZGeYJ0hT4Fv1/QhDYCg8OIP
	 amdhGLJUq7U8DQDICTaaYFtu8taij1xBdK478Uda0+FFuip+WET4XSKjf1nJAaPbM8
	 dYoP6Z2fM2UOQ==
Date: Tue, 1 Oct 2024 08:52:54 +0300
From: Leon Romanovsky <leon@kernel.org>
To: David Howells <dhowells@redhat.com>,
	Christian Brauner <brauner@kernel.org>
Cc: Omar Sandoval <osandov@osandov.com>, linux-fsdevel@vger.kernel.org,
	Al Viro <viro@zeniv.linux.org.uk>, kernel-team@fb.com,
	v9fs@lists.linux.dev, Manu Bretelle <chantr4@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: Re: [PATCH] iov_iter: fix advancing slot in iter_folioq_get_pages()
Message-ID: <20241001055254.GC459313@unreal>
References: <cbaf141ba6c0e2e209717d02746584072844841a.1727722269.git.osandov@fb.com>
 <3011076.1727727002@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3011076.1727727002@warthog.procyon.org.uk>

On Mon, Sep 30, 2024 at 09:10:02PM +0100, David Howells wrote:
> Omar Sandoval <osandov@osandov.com> wrote:
> 
> > From: Omar Sandoval <osandov@fb.com>
> > 
> > iter_folioq_get_pages() decides to advance to the next folioq slot when
> > it has reached the end of the current folio. However, it is checking
> > offset, which is the beginning of the current part, instead of
> > iov_offset, which is adjusted to the end of the current part, so it
> > doesn't advance the slot when it's supposed to. As a result, on the next
> > iteration, we'll use the same folio with an out-of-bounds offset and
> > return an unrelated page.
> > 
> > This manifested as various crashes and other failures in 9pfs in drgn's
> > VM testing setup and BPF CI.
> > 
> > Fixes: db0aa2e9566f ("mm: Define struct folio_queue and ITER_FOLIOQ to handle a sequence of folios")
> > Link: https://lore.kernel.org/linux-fsdevel/20240923183432.1876750-1-chantr4@gmail.com/
> > Tested-by: Manu Bretelle <chantr4@gmail.com>
> > Signed-off-by: Omar Sandoval <osandov@fb.com>
> 
> Thanks for finding that!  That would explain why I didn't see it with afs or
> cifs - both of those pass the iterator directly to the socket rather than
> pulling the pages out of it.  I'm not sure how I managed to do things like run
> xfstests to completion and git clone and build a kernel without encountering
> the bug.
> 
> Christian: Can you add this to vfs.fixes and tag it:
> 
> Acked-by: David Howells <dhowells@redhat.com>
> Tested-by: Eduard Zingerman <eddyz87@gmail.com>

It worked for me too.

Tested-by: Leon Romanovsky <leon@kernel.org>

Thanks

