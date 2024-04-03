Return-Path: <linux-fsdevel+bounces-16086-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36286897BD5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Apr 2024 00:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF9911F28C3F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 22:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 000D3156C61;
	Wed,  3 Apr 2024 22:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="o2SyvooU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A28156871;
	Wed,  3 Apr 2024 22:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712185071; cv=none; b=D1oZ5F7EBsmV92BZd0BhnyjTByv9vybYysQLyWjZnbaodKoDuvieeWCptqFHYxCdlno7jBPaoMJhEbeCTQ6LwDFhorU51QQ/U/ROffdq/XRFrSryhser5NpojtDXeLNMKqhctWvnSQq4vK8FeATSqtxEnKtcSrjZLDhEuXPPmbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712185071; c=relaxed/simple;
	bh=GdJ01PLvlUXO2n1nMDCRGXdWiRPjGHJisvsRdsLX798=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ulcx3BhCfKhNOf5yieYQ8sek/DToN2X7tCZVNd1NxGYuAv4TCFmnxUN1bAvAeR7IRvQhceH1SyOv0NxUm6kIB026IavRdu4WfaDOi2Vj7CkFLAxKXGxwQWpYVCVsdjD+bykl1c1QMFd6YiVFA8Xps7bm9/Xmcj+acsWkxiA82w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=o2SyvooU; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=CbWk5huEObmhcA5g7RS6q+JrWme5Jfa+v58vnxeLScA=; b=o2SyvooUZ3RyKcf/A0OloFojZu
	jTEW+zYs/9y+bXLfkWyE0ezuyrexew06OqIWb0wvmInMbTEsN84Lu8Gk6hQzJ95XaCcOgoJVvhEUX
	wluc/kCDcy8r6RRX3iKsi+1EfyvOi6VikZZlkfrgOu9Uky+bAZ8TjVB8cLWpmbp2D3OPMaxhesglM
	jxVSkV/9m1GR/D6UZJmp2CbdirwKrPdg16n2SyzmGlchvsilJ6ZYBeyeN4HaUuUIIcgUitqsl5y0r
	NHbv2dWHdv+o5IvdxGYay9wPBcIyeqt/7jSbdXKuIPWTgXxYNyRcMi8rN74+Oey+8fs9cFU/gPg/U
	mi79J3XQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rs9YB-005ByQ-0W;
	Wed, 03 Apr 2024 22:57:47 +0000
Date: Wed, 3 Apr 2024 23:57:47 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] signalfd: convert to ->read_iter()
Message-ID: <20240403225747.GO538574@ZenIV>
References: <20240403140446.1623931-1-axboe@kernel.dk>
 <20240403140446.1623931-4-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403140446.1623931-4-axboe@kernel.dk>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Apr 03, 2024 at 08:02:54AM -0600, Jens Axboe wrote:
> Rather than use the older style ->read() hook, use ->read_iter() so that
> signalfd can support both O_NONBLOCK and IOCB_NOWAIT for non-blocking
> read attempts.
> 
> Split the fd setup into two parts, so that signalfd can mark the file
> mode with FMODE_NOWAIT before installing it into the process table.

Same issue with copy_to_iter() calling conventions; what's more, userland
really does not expect partial copies here, so it might be worth adding

static inline
bool copy_to_iter_full(void *addr, size_t bytes, struct iov_iter *i)
{
        size_t copied = copy_to_iter(addr, bytes, i);
	if (likely(copied == bytes))
		return true;
	iov_iter_revert(i, copied);
	return false;
}

to include/linux/uio.h for the sake of those suckers.  Then
they could go for
        return copy_to_iter_full(&new, sizeof(new), to) ? sizeof(new) : -EFAULT;
and similar in other two.

NOTE: the userland ABI is somewhat sucky here - if the buffer goes
unmapped (or r/o) at the offset that is *not* a multiple of
sizeof(struct signalfd_siginfo), you get an event quietly lost.
Not sure what can be done with that - it is a user-visible ABI.

