Return-Path: <linux-fsdevel+bounces-51834-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B67ADC0E7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 06:39:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 593143B7F1E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 04:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A57C121B9DE;
	Tue, 17 Jun 2025 04:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QRc0zTpY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C51202990;
	Tue, 17 Jun 2025 04:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750135098; cv=none; b=kGMJZjB021YIkLmEcH+ofDN+YB76Aq5Hw9p/DsmukTmEF3G9rZ4OJSMhz2vPCePgH1am6swnHbodP6/Owu1I+WQFpnlMOIOGUvqkcjbtzv/j++Rm03e9nWzKC8SBkHjBqOSxvpIjbdpaoHKws7muXdu62uVa7PWdpB/4mKPi99M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750135098; c=relaxed/simple;
	bh=jpjRpPeFBQhW1uQABpHLCZUbgZ29mofWc067MbcJxNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IhuK3z+MQMTZ+qLf0NI0/wZdWTwsuqRPJI2M5n2RUGIjyPbGF5sqxwgU4Jrq9cSjmkO9yLNM3LgF4biQhAgpbH0tbvEEgex4J6/+GSlQTX1jecjh3DAgqgx59fWxJoCimKXH009F/5EaxHmaPzrFwQa+zlSjWxltR33JYI4uwT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QRc0zTpY; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4OZd2T0pPLAW2VfkNnEJjXe7X+GGpxE4zdk3JGC6rxc=; b=QRc0zTpYMBS2Ym3F+F5BEZbnku
	JbgkLB5kMIlpdwEFcMqxwdbFZQyPk8kBXfoSTap+uyYSjgWXG5x++hEklEFaXEBUNLa1QX98aNVTK
	3bDURg54kwCrLusJg+XDh42yvnW9a6lvUEukv8QnNjBsIjJP72ExKqVC6T3B1/orXJ6cnxmv4dP6o
	oDu2e7kAMJ7Vm0Uc/yhSoufQIiJOaM5HtfPjmVBqBnuQCa/qLZkb9SaMo6NcTYB+gULciyjIe2hxy
	ut9WoRHp5o611ca+owMD3UVso6j/u2MftaDNymrZ3oaCL9WYgwwfExKu3H9sbu+OiVyUxvjMybYDM
	iryl5x3g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uRO5N-00000006BDF-41Sh;
	Tue, 17 Jun 2025 04:38:13 +0000
Date: Mon, 16 Jun 2025 21:38:13 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org,
	djwong@kernel.org, anuj1072538@gmail.com, miklos@szeredi.hu,
	brauner@kernel.org, linux-xfs@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v2 04/16] iomap: add wrapper function iomap_bio_readpage()
Message-ID: <aFDxNWQtInriqLU8@infradead.org>
References: <20250613214642.2903225-1-joannelkoong@gmail.com>
 <20250613214642.2903225-5-joannelkoong@gmail.com>
 <aFAS9SMi1GkqFVg2@infradead.org>
 <CAJnrk1ZCeeVumEaMy+kxqqwn3n1gtSBjtCGUrT1nctjnJaKkZA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJnrk1ZCeeVumEaMy+kxqqwn3n1gtSBjtCGUrT1nctjnJaKkZA@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Jun 16, 2025 at 12:18:21PM -0700, Joanne Koong wrote:
> Nothing in this series uses the iomap read path, but fuse might be
> used in environments where CONFIG_BLOCK isn't set. What I'm trying to
> do with this patch is move the logic in iomap readpage that's block /
> bio dependent out of buffered-io.c and gate that behind a #ifdef
> CONFIG_BLOCK check so that fuse can use buffered-io.c without breaking
> compilation for non-CONFIG_BLOCK environments

Ah, ok.  Are you fine with getting something that works for fuse first,
and then we look into !CONFIG_BLOCK environments as a next step?

