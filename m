Return-Path: <linux-fsdevel+bounces-45842-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F20AA7D8B9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 10:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB7A3178681
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 08:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E338A228CA9;
	Mon,  7 Apr 2025 08:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="psEsFESo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226AF2253B2;
	Mon,  7 Apr 2025 08:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744016072; cv=none; b=V5FS3DumCfJeX9wmGkV+94UTGIUeuEscuYOg147Omv6hZKMShQiNajPzU3suQtl7UdSYEG7nVatqL7PjY1I4/UEIQ5jouyENhnHJLwhpflzR0KlNExTKsy+pzgPCiuOzDxmaVxye3M5kSaFMvXBcCBLvCnekFHI+ZSPQYsF2KM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744016072; c=relaxed/simple;
	bh=D9Qp9Xpod5vQ2c1K9oZQsiA4c+t8QgQMAbQ+ppm1yWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wv/703yJMjTqIbTi2joAb+a+9goz5rOcpwRpFi8YkFH6Edsb695Zj7zrbVh1fS6XsN28m08T624KpUzfhFv8LjhesR1Rsy5MwQ8V6SBNz7J4i3XZFnq59A0X8LvB2kpaauvb4PISOvp5et1YCc97NwcfKDE7n7f85gu4T5Sg2PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=psEsFESo; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=HF58+EBZsTkT38Oxh6SEKfNEVcs2K9eImbrdbf6EQd8=; b=psEsFESoo8z4BcWL9/cytZUkdU
	egKQZrZ6FXFrDdqSluxTSxfwnswJgX77bTuZqfTKsxsaaJCAXQutxak1THhz0gRWfMl4fQ7okgH9Y
	TFYgGGVi2Kkg035mAxOl8VK8+9c+gJXSwLj9/vP6bjyz8kL86eA9MmYC+k3vAwg43fUn+6yygzTcw
	PiVAafZSVsPowyrp3i8W4AEthzESQnX86iZxVNB+1h74KrIWgzX//ZE/b8TBReUtV7stJtybAC059
	S/On8M/u3BcJnBzOq4DuuH6Tqe/GBKcZwxjmZpo0rTKqSYcasrxKDtGojiKSL+rHXJlSDxPi6Sux3
	xwtHO8Xw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u1iFR-0000000H5aC-20X1;
	Mon, 07 Apr 2025 08:54:29 +0000
Date: Mon, 7 Apr 2025 01:54:29 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, brauner@kernel.org,
	viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] fs: make generic_fillattr() tail-callable and utilize
 it in ext2/ext4
Message-ID: <Z_OSxRO4b7OduCTx@infradead.org>
References: <20250401165252.1124215-1-mjguzik@gmail.com>
 <Z--ZdiXwzCBskXQK@infradead.org>
 <CAGudoHFcUBdZUBDFqWs4aLQfXyN4781-g-8x0mfBWwEMrTFQUg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGudoHFcUBdZUBDFqWs4aLQfXyN4781-g-8x0mfBWwEMrTFQUg@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Apr 04, 2025 at 10:14:32PM +0200, Mateusz Guzik wrote:
> Callers don't need to check it because it is guaranteed to be 0. Also
> returning 0 vs returning nothing makes virtually no difference to
> anyone.

Nom the return value very clearly states it can return something else
with your patch, and people will sooner or later do that.

Let's stop these silly things that just create nasty landmines for no
reason at all.

> As for general context, there are several small slowdowns when issuing
> fstat() and I'm tackling them bit by bit (and yes, tail calling vs
> returning to the caller and that caller exiting is a small
> optimization).

Please prove that it makes a difference.  And if it does do the
changes in a sane way by keeping the helper as is except for marking
it as inline candidate and a special _tail helper below that inlines
it.

But the bar for such micro-optimizations should be high, and so far you
have no managed to provide any rationale for it.

