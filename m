Return-Path: <linux-fsdevel+bounces-37134-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 630C19EE051
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 08:35:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F301D18858A1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 07:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C5920ADF3;
	Thu, 12 Dec 2024 07:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="zJ6LoV72"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A6A25949C;
	Thu, 12 Dec 2024 07:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733988943; cv=none; b=q3Pa+G4OYXvVMCZCQLRA7c5Cuuk3RuoS3yX4osC4iKsCz5JVDA1mglGLYlvjEqhQOcbQpDjwwNppn1uz1siVVMar/lUFD5CtMJt3r2HKE8nD3FW77E2re1pzbqkwrsRwm7TwNq9S0AZkQCjjZqhZVUx1QKjlIaVbg22S2SHJvX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733988943; c=relaxed/simple;
	bh=3ltvJd4vSayo7oNWmuVZwsuYSzOIKQd29lGuWvmJf5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PTHfNcOCAXIhD/bkPlVAHrKSShaIRgFqPLaTHDF2HQzo9ja8GNSLhMtQKmTmGzbwzMY8lDdUaNUCmgdhjuMHRl/5L7fLNs3IDI2uF+PNchPI2A/98y7f2SyzDFvoi4Lm5BOXS6qUTgy3AifsGAMiIbewVy64GY5nBxh7pjkkILU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=zJ6LoV72; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=2IMVeQPDjRFleRhmLpYSZl9TIQWaafKA1ATOJjikNqI=; b=zJ6LoV72PBtd6AP1dC9AMezy5h
	abZs5lD9BIfXkc5BdrPU0Ji9uQ4lIgUzGWVv5lyhNJgOVauWRWQAu6PjxQLZwx1kLkulKC46NPa5i
	/lmCTm4fgARUdUNIEabH4t8z6uIwXPZHuKzTLMFUVVolgCmcpAxIl/ANuOlMjd0+ylLYjJril0bvn
	Oq4kDwcx4t5sJLOVIqK7+/Ya6wsEieimyluhQRZSehmVnJf17hQx1T1A1Dhe/MwJ8i2rfe5dmV64z
	DvuT4NM/Gnx+Bfnw7ZD3kNxOFehW981t8bzEjxGWFKT+Vt1WnAoUfAtad5zYCA7xXyh90I+F6BJdG
	ZcfVq5uA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tLdjY-0000000HAhU-3ixM;
	Thu, 12 Dec 2024 07:35:40 +0000
Date: Wed, 11 Dec 2024 23:35:40 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>,
	caiqingfu <baicaiaichibaicai@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-ext4@vger.kernel.org, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [bugzilla:219548] the kernel crashes when storing an EXT4 file
 system in a ZRAM device
Message-ID: <Z1qSTM_Eibvw0bM5@infradead.org>
References: <20241212035826.GH2091455@google.com>
 <20241212053739.GC1265540@mit.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212053739.GC1265540@mit.edu>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Dec 12, 2024 at 12:37:39AM -0500, Theodore Ts'o wrote:
> More generally, any file system which uses the buffer cache, and
> doesn't use jbd2 to control when writeback happens, I think is going
> to be at risk with a block device which requires stable writes.  The
> only way to fix this, really, is to have the buffer cache code copy
> the data to a bounce buffer, and then issue the write from the bounce
> buffer.

Should there be a pr_warn_once when using a file systems using the legacy
buffer cache interfaces on a device that requires stable pages?


