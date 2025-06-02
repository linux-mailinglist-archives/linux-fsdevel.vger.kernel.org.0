Return-Path: <linux-fsdevel+bounces-50286-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7758DACA90D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 07:38:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB3017A90F5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 05:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A76B9188A0E;
	Mon,  2 Jun 2025 05:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oVCpeUjQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D653F49620;
	Mon,  2 Jun 2025 05:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748842689; cv=none; b=JqFVTFNWeK8++OzbZiH/UHI9qoAH6Y6KJnDwHwO8oiaHTVCQSLS4fk2dWxjgrWIe27Y9nenIrQgu0hnRWaYLThv6F9+bykluNG+trS0duRM+9SZI4NEfF/mbhPzyH8NLN3apNECqtKF46/Jv2W34MDDXTUiA9Oeu1EfPOFUz6HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748842689; c=relaxed/simple;
	bh=zeVbyjEAnVoVMDMpIp4YEgz9/e3C0hxnp+7Mi2Au7ik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DXaTBu+3B7vkCgFbiR8i/rFa+wb+PcC+3XXqgQ1KzYA5BiKdrril1cJ4DjjLbkqNwukmjNfZOZhxVolAASHZeimkr7JD+2WOvwu2VGhtWa4c/hXn7SnIWVfeVKWicCqxTvAzs0v4oigRXX5ZRpW+RAaxplAjEQv9M1aN92sZb+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oVCpeUjQ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Z1Qs0EfJoik11zifvOVUAv4VJ4xFrYTwdWLAEsLF+Vg=; b=oVCpeUjQ70+FuTy639XuF2lvec
	tJn00w+2y9n8twgu4Snu7/jUobdHYsflTqABJIwHvAHwxDecsx+AqzHpxRGV8rqnxV9Y4Iqf2WBJd
	aGjg3Lzlw3ZneWn3Pq/kyAB3RryxxRdiWK35QRTxZgO7Kskd5KxzVhEeO23Gg5wA+KiNRD8Wvi9Lf
	MJEKcMMNutiZFVthoIwkNccpLeEAIdmTQ6FDqhL2m45f3fzd5Lf4EPvWdeZQFHtg1ox1qSeivAfu5
	cBtNo7Cc70vS/nYwViSPc/4Qp6fpLhxDQtJManb5ZBiwEwhf4XiaVOhIL9dwLFn/SlJxZx7+tTM6E
	8gky2Z9Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uLxs7-00000006lXa-2525;
	Mon, 02 Jun 2025 05:38:07 +0000
Date: Sun, 1 Jun 2025 22:38:07 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Dave Chinner <david@fromorbit.com>
Cc: Yafang Shao <laoar.shao@gmail.com>,
	Christian Brauner <brauner@kernel.org>, djwong@kernel.org,
	cem@kernel.org, linux-xfs@vger.kernel.org,
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [QUESTION] xfs, iomap: Handle writeback errors to prevent silent
 data corruption
Message-ID: <aD04v9dczhgGxS3K@infradead.org>
References: <CALOAHbDm7-byF8DCg1JH5rb4Yi8FBtrsicojrPvYq8AND=e6hQ@mail.gmail.com>
 <aDfkTiTNH1UPKvC7@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aDfkTiTNH1UPKvC7@dread.disaster.area>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, May 29, 2025 at 02:36:30PM +1000, Dave Chinner wrote:
> In these situations writeback could fail for several attempts before
> the storage timed out and came back online. Then the next write
> retry would succeed, and everything would be good. Linux never gave
> us a specific IO error for this case, so we just had to retry on EIO
> and hope that the storage came back eventually.

Linux has had differenciated I/O error codes for quite a while.  But
more importantly dm-multipath doesn't just return errors to the upper
layer during failover, but is instead expected to queue the I/O up
until it either has a working path or an internal timeout passed.

In other words, write errors in Linux are in general expected to be
persistent, modulo explicit failfast requests like REQ_NOWAIT.

Which also leaves me a bit puzzled what the XFS metadata retries are
actually trying to solve, especially without even having a corresponding
data I/O version.


