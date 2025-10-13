Return-Path: <linux-fsdevel+bounces-63897-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C0E0BD14FC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 05:07:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDF6D3BC540
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 03:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D41923D7F4;
	Mon, 13 Oct 2025 03:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ExRx4wfI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8BD14A8B
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Oct 2025 03:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760324819; cv=none; b=Z64FNsbXVcdhslWGi3gf81DLtMTv2iX0oeNayyr0+s+WOJjIPkdjhoe+DIqqhFEC34FweLMdPHgYwZFhEBK+d4sORV8iSlhu2uAuwdqC0WiSM4pr5GJjoEHiVgrk0Q3zld+D9EhRYBUvuJHsHXi2LN9+CdafkNLOe8Upy8tOjBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760324819; c=relaxed/simple;
	bh=pHRWdEAeCBoVoLDTIJQ03rwnqI5wif/n2lDsx/XxwGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jfkLXvP5u7URs3DGnKaNuHI0mVVorjEL2dVFLfzkobl33ywNM1SKjxCB6igtUtzbmrZ65yzDY2kzb0eaL50qu3RK1xlGbD4KAj00jShezdUPNnHveBkW3/+nbG54GgIa4Un9pa7cQ4AMOCHOsgZMLkTtfm52UpOGoViqPmH8thw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ExRx4wfI; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=NYwbcopOyG0wR3ALGD2iwl/CsXKE4nsPpsbrLoRyVgw=; b=ExRx4wfIjT/CWlxZZkuHtzHnhg
	P5f1HjLLnQNkS8O/ykKnT0Q/Wfaw7IqRjTyVZ4fIpk5wHv4k2C+L71H/Wr6bIL5fS6rg1c0O39wge
	EMTPAA3gYJdwSo8ZVe/V8Mw0vzlR0BaRmqkJR64a7B6NkLITaS9Z60oqAgRZspLUxbHn5Hhype3O9
	YjsZ5W48v8ubDwt+sxE3Mha0RYtcL/9wceC9iK8i7CD+kJ48kr10W11FwR3D1N4FKaj9GwOUUcmeQ
	ZBzdKwigQ2tmHRO8bNyy1aiIxHfWWZeWD+3RmnnqWd32QzfLLPmAD5cm1nWtfGen8K+0LekSWz+v5
	Rvk88ERA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v88tl-0000000C9Jt-3jIk;
	Mon, 13 Oct 2025 03:06:57 +0000
Date: Sun, 12 Oct 2025 20:06:57 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: brauner@kernel.org, djwong@kernel.org, hch@infradead.org,
	bfoster@redhat.com, linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH v1 5/9] iomap: simplify when reads can be skipped for
 writes
Message-ID: <aOxs0SPQ8neKRCFF@infradead.org>
References: <20251009225611.3744728-1-joannelkoong@gmail.com>
 <20251009225611.3744728-6-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009225611.3744728-6-joannelkoong@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

>  		if (!(iter->flags & IOMAP_UNSHARE) &&
> +		    (from <= poff && to >= poff + plen))

No need for the inner braces on the new line.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


