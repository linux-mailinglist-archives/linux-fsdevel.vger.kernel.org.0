Return-Path: <linux-fsdevel+bounces-62424-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34473B9296F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 20:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37F21189F6A5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 18:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 417FA3191D8;
	Mon, 22 Sep 2025 18:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cR/Su+Bo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775F2C2FB
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Sep 2025 18:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758565436; cv=none; b=o9myUzzMa7PwmiN/RjxAzhml0P+0WlErGTuvHd9QmarqGavXmImlObNVmDiEx4VEr/EpOQxYbqTQd161F6QVeNydZZ9rLmtqh50S/XddqOjUNuaasUIXBEkpLWJ1z+3buaKHFsHzh+S1xPNn+KUACMLZhSnDg/Z21r62P4y7GjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758565436; c=relaxed/simple;
	bh=f7h+2kIPPGffC5WpgYV5AOsgPN3AvRlAsxKBLptZshw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ww9S5Q2GwQgFkAAi3gBGENQ3pk/4tM1DLvsHzqjvvR2MZKUbiJq6lBpv+hcd04MEoga/MaDb2ks4P8V6Y3WHaYn5Y0kr1XJDJ8ao5Q2G8ntiXOLokWCkEvknCkXIZbnnfwMVJaINE1sE0aNntG2soYRgRrom5KIewliNOHq6Obw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cR/Su+Bo; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=fsuHm/4YoYZlZ8NKfdCG1RN2fXbZEUoPkgM9krdlACE=; b=cR/Su+BoaHdy5deL5sfSC3+y/e
	rLTtRXepVl9/umsIdiQfd5GbgpBiqX5zmFupkP6R+J7v7bJO1DewoJVxaDn6/Hv3jgx7qMlmNgxGn
	qzrQy19lAx8gi0oOPPIBzqxJ1SeRLRYyi4zwkr5uBo0cFoSLI1TkyrJh1Abssn5N9kEccUc0jlMbg
	qN7PrtNIDNqWXwtg8vzRR0sgnkfiq8vDQvyYJ73Uw0egwcg9uRr1OooHCsYVM2GvoLIBX1CaIz205
	SeONPMgl45+ERP8sGsW7QKmXQDeiUbWYf+Onlwz4lbcWO++djGx5nFwx8s/bpMvnfMLNoA/WAj056
	oBO5Kwog==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0lCd-0000000BF2j-0VGC;
	Mon, 22 Sep 2025 18:23:55 +0000
Date: Mon, 22 Sep 2025 11:23:55 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: brauner@kernel.org, bfoster@redhat.com, hch@infradead.org,
	djwong@kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] iomap: simplify iomap_iter_advance()
Message-ID: <aNGUO8lNnFkDEt5Y@infradead.org>
References: <20250919214250.4144807-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919214250.4144807-1-joannelkoong@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Sep 19, 2025 at 02:42:50PM -0700, Joanne Koong wrote:
> Most callers of iomap_iter_advance() do not need the remaining length
> returned. Get rid of the extra iomap_length() call that
> iomap_iter_advance() does.

>  6 files changed, 35 insertions(+), 47 deletions(-)

This ended up beeing a pretty nice sinmplification, nice!

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

