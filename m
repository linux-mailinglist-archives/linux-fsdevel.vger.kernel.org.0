Return-Path: <linux-fsdevel+bounces-45725-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37329A7B7F7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 08:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBEDC189C99E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 06:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C169F1891AA;
	Fri,  4 Apr 2025 06:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="q9I0lw7I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA1779F5;
	Fri,  4 Apr 2025 06:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743749247; cv=none; b=RvewG8QFVuIiPUuHcj1OUkYLAMrawSQz1NQ1k7z9WnuYXgcR20Kw1YtzZ80Csu1ZlZVdQBjYH94dpNrEX74UVpEr4MaNIrSV5m9Mk96Uc/CrKxgf1qHjjwtbP+oN5IoQsaCrdRz7myRPxUsA0TjITv5QMTuzcNn7hB60cnM9d8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743749247; c=relaxed/simple;
	bh=wUGczPF4nDVEvFeSPa2fr39N7JL0nsKKk2beuEY3k44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jI3PR0gNtUhT++3fZyW3BMZgr3qCgRcOVK+J0gbjESd1TaAY8pJsG6N8HZRZyh0QtcHYgiC6sAkha8ufCS/gbooKDvlOT4sygv6jEpplf2UEyoVamwjyPba+c7QuQ9ULyh7b5XdpkzHYwmwQ3Kx8v1MB6E/0e2AUOI+QzGu2dLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=q9I0lw7I; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=cM0ouist3dGI8ZxfJLkEixZGtZmEpGLI/sJ03lO4kyk=; b=q9I0lw7InmVjrX1AH7zPVtgdfi
	rqzcnRoHck9ZN9k8iR23AZAKVlpZ3PpEkHYOv6yW8dOXbifn7bzyaRnDKax9FsbPa4MIaILjDHOpr
	foF9Qs8M8v/0v5eAFot+Ah14t0by9Zk+SU8be3kyMO02uZeuLdYEdVeUdt8vLe88+eqfQQaPyyci1
	axoIzOgO3OO1t6eTYE4fwXvqpxeH08g5lZ3vhtoVgF4t6UpJupOJPq/dNubfeJXWw9J4Idw9dtbQw
	cVz8OAwgfdL7VT5/kHngdKjaVPXi2La1cW0z7YowNYLp2Yq6rp6tfvibPfPl+6kFajbT+4kjkDeEQ
	/c4mSeLA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0apn-0000000Av7t-0gpp;
	Fri, 04 Apr 2025 06:47:23 +0000
Date: Thu, 3 Apr 2025 23:47:23 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Andreas Hindborg <a.hindborg@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Breno Leitao <leitao@debian.org>, Joel Becker <jlbec@evilplan.org>
Subject: Re: [PATCH] MAINTAINERS: configfs: add Andreas Hindborg as maintainer
Message-ID: <Z--Ae5-C8xlUeX8t@infradead.org>
References: <bHDR61l3TdaMVptxe5z4Q_3_EsRteMfNoygbiFYZ8AzNolk9DPRCG2YDD3_kKYP6kAYel9tPGsq9J8x7gpb-ww==@protonmail.internalid>
 <Z-aDV4ae3p8_C6k7@infradead.org>
 <87frix5dk3.fsf@kernel.org>
 <20250403-sauer-himmel-df90d0e9047c@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250403-sauer-himmel-df90d0e9047c@brauner>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Apr 03, 2025 at 01:27:27PM +0200, Christian Brauner wrote:
> There's no need to get upset. Several people pointed out that Joel
> Becker retired and since he hasn't responded this felt like the right
> thing to do. Just send a patch to add him back. I see no reason to not
> have Andreas step up to maintain it.

Removing someone just because they have retired feels odd, but hey who
am I to complain.  I did reach out to him when giving maintainership
and he replied although it did indeed take a while.

