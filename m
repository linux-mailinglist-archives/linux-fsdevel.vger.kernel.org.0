Return-Path: <linux-fsdevel+bounces-17367-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 113F88AC40E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 08:16:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A6F71C2158C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 06:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D0383FB8B;
	Mon, 22 Apr 2024 06:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tD5j+E/d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B981210EE;
	Mon, 22 Apr 2024 06:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713766565; cv=none; b=du9QIxqpIiF75Cnfr38riurxf91ChjkMxvRe/Qv+9EbGX3ck0WNwKkciZvLEoISTeVJYlb+NMgloPY+o2wpqSev7oqTaUBHFR8ACCNOIZAUZ4Bkpo5FZxKB/OWJ5RLgczoBnX3LiREWQUFD2hQpKPDHEQuAo60zzUiJOOkQKDhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713766565; c=relaxed/simple;
	bh=Vnm3CQSSE42xtmYnkCm4m+ahu64FSOQysAMoPUzvxlI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BJ6a1rQRHki7EJrPJELXrvX2AfILZx8sCEaUImK3jGxDHJ+AoP4Wnyx6MpGWaX+2ILOsk+x9FEpUyMvn9n2UYuVz/48qAezQwYlGJ8bO6ssYbXNY4Qvnzl6UYjvG8zH/xd0nVyJEQ1n8AkKCTp1ajgv02EtY1omWemerwYF9uA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tD5j+E/d; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Vnm3CQSSE42xtmYnkCm4m+ahu64FSOQysAMoPUzvxlI=; b=tD5j+E/dBd7CrTv9psF9VYuyB8
	zVXLH+qkNYlGWtthcEA+SpTCN9NZRQxowIOrkPGAUL9hhrl6AIWJ5LxeKBrxnzWrOZ8ZqVOP5LM7J
	Sp1JRUcjJdXgFVbH3xYUq+MAg/js1J11oI1lVdapvCSTtOIUSB5qoj1PqNihEhmpqflu9ZKTFlB5q
	iwR4opruXeL4Os9GjE/bw0Ow4oVLU9y2UhetUR6RKvKLXIu3rpCFJ4eN6qcVpnyrOxSIsQlGxOwXW
	/x+OCeR2ZRrI7VSo50VGUkw44jSWm0PJ67zJ2PdZ0hoUbM6XYO3HXe34xnzCh9MaK+iOXxULF9LMB
	lFe00gwA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rymy9-0000000CDxu-3VGm;
	Mon, 22 Apr 2024 06:16:01 +0000
Date: Sun, 21 Apr 2024 23:16:01 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 27/30] iomap: Remove calls to set and clear folio error
 flag
Message-ID: <ZiYAoTnn8bO26sK3@infradead.org>
References: <20240420025029.2166544-1-willy@infradead.org>
 <20240420025029.2166544-28-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240420025029.2166544-28-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Sat, Apr 20, 2024 at 03:50:22AM +0100, Matthew Wilcox (Oracle) wrote:
> The folio error flag is not checked anywhere, so we can remove the calls
> to set and clear it.

This patch on it's own looks good, but seeing this is a 27/30 I have
no chance to actually fully review it.


