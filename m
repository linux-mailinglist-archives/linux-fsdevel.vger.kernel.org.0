Return-Path: <linux-fsdevel+bounces-21379-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F93F903093
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 07:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6EB81F27424
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 05:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE7F17B51A;
	Tue, 11 Jun 2024 05:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="4iRpIfn/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC598178CC1;
	Tue, 11 Jun 2024 05:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718083237; cv=none; b=aeAincvsaw4hw2v1B84H0S6K8/AueQq75W6iACKaQEgKl++J/3DNb9Ix/Dm/vlVj89b08MiORda+0KAxOtCsJs1hsP8nMGK6l5X+fqBPqdxsv30fouXoJLJLBXL0HHXzJI3xfpnjQgh6CfJXJjD57BQMeCGfti+xpwWGasfKGhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718083237; c=relaxed/simple;
	bh=ZOUeS/PR2L/uW+xmI1S+bIdUmqKIstkjRfWtLDTdo5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cqZs8NUPMub5QcCFtkS8p82dcRaJaylCjO/9nK2VfIwhCVxhRU3ZMopRoYS3aZ7mN+kwz4c3AIxqeJ972iZg8SLk4KC4xINu6J7BLzLVz+NoVOqxIvHb9dXt6hdHhco8b1MfStI20L8Tw/fa+F39zjDzeNIcSHQLLJFvgY9mmQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=4iRpIfn/; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Bju2IWg2b3ngXQXJYtweoQU0NbygugkuJZTn5GHJegs=; b=4iRpIfn/MpEKpUPbH7KhBNKlHt
	YDdCClNS4oO4JkxIRPiuXJmZXgpjCII610Wbryjt2AOuSbddOM9JQ24zM4PKkiyGZ49z7SHISytcs
	pTgg9/I4wWwwapkglwufUbmr0qoL1L3ljX7hObjnmpl9SXQFhEA2aQBUcb9Mc7+bC3bEYC8niDse+
	IpmBv/26u2m4WB0Ib8uBqHVBxKOcRJIxknxzCkhAD9L+7xfGN1JwboKVtfVei812wk7ptsWN2ckn2
	8zr21EErCtTqaIk5HpA8nSFk/6TdbtEZolO6kCRTmK7RnTk3Cd6++QpbVjyMEP7l/UY871k8XewZu
	D7scP1Gg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGtvm-00000007RPg-2UTv;
	Tue, 11 Jun 2024 05:20:26 +0000
Date: Mon, 10 Jun 2024 22:20:26 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, brauner@kernel.org,
	viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
	josef@toxicpanda.com
Subject: Re: [PATCH v2 1/2] vfs: add rcu-based find_inode variants for iget
 ops
Message-ID: <ZmfemrY9ZPnvmocu@infradead.org>
References: <20240610195828.474370-1-mjguzik@gmail.com>
 <20240610195828.474370-2-mjguzik@gmail.com>
 <ZmfZukP3a2atzQma@infradead.org>
 <CAGudoHE12-7c0kmVpKz8HyBeHt8jX8hOQ7zQxZNJ0Re7FF8r6g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGudoHE12-7c0kmVpKz8HyBeHt8jX8hOQ7zQxZNJ0Re7FF8r6g@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Jun 11, 2024 at 07:17:41AM +0200, Mateusz Guzik wrote:
> 
> I agree, but this is me just copying and modifying an existing line.
> 
> include/linux/fs.h is chock full of extern-prefixed func declarations,
> on top of that some name the arguments while the rest does not.
> 
> Someone(tm) should definitely clean it up, but I'm not interested in
> bikeshedding about it.

No one asked you to clean the mess up, but don't add any in changed
or added lines.  Without that:

Nacked-by: Christoph Hellwig <hch@lst.de>


