Return-Path: <linux-fsdevel+bounces-52002-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C05ADE2BA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 06:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 310AD7AA16B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 04:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4950E1E3DE8;
	Wed, 18 Jun 2025 04:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Rnb244KX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F02199E9D;
	Wed, 18 Jun 2025 04:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750221920; cv=none; b=lUyfPt6o/imTD1ewLTnxMv30aqJ6CR2JGgdJpT2JSQqb/Sf3U65Wb9Vg4JlyGXRMelwa+O2US9GXuuHAUDXJhxlQPFxca9GBjiLzIpp9T/sI8Quqpsiyv7O/qc6LzLpYexxhSksvvjIR5gXFXf/WEQRSymr7adMLt16Wje/obCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750221920; c=relaxed/simple;
	bh=NlXquScLOsFgJsfcWObAAAO9ymPKjd+/dpLYqwQtdPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ugp8g/cpUbhPtdXCmECoDx8hVyh+YiMHL4VwXt37pOUlOZ5g3Eim0yxQs6xl4U6rjOMBfSKUQCJDixYzuIPCgrpspeLb/RTuw/0t/jsEHW+R17gQL3iHli7a8KSnpscCid+kDaZhD5QOv+1R65u2K6zYoio9lYwulVkMH8zG4Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Rnb244KX; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=eLaixHsteufpRpoqvjgfWXW5wErphod7QgSQUvmo9ac=; b=Rnb244KXYtfkm+ranQ9LtTqpAP
	Th9MOxN+C3zwABi09ufHRXZUZTInh6yF8Aifv5VeAYn4Z82wjj7iG6iPCmUia0tsgNqGZJGqqkc2e
	qwPa6dQ4rZJm8tHTn2jVzYXk/algDXU2hkGmp+QcfbNnvjEUe2NqInmRP9gpqLQYBPKqCW2ZSGW7b
	rlea+B+3sdJvss9INsjnmzpqPc8YOPb8KairUqp7SL1OIfo2LZJI/M8UW4OuUBUtv9UCXGcdVpRTR
	YaQAH4kK0UcjKUDWSD3qQUVLnkOwqPrRHBaFBAYaGF0yNTS1kaEvQB96qFlWQKJUrNFwiOlbDNJui
	CIytnXew==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uRkfl-000000092O7-21Rx;
	Wed, 18 Jun 2025 04:45:17 +0000
Date: Tue, 17 Jun 2025 21:45:17 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org,
	djwong@kernel.org, anuj1072538@gmail.com, miklos@szeredi.hu,
	brauner@kernel.org, linux-xfs@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v2 04/16] iomap: add wrapper function iomap_bio_readpage()
Message-ID: <aFJEXZgiGuszZfh6@infradead.org>
References: <20250613214642.2903225-1-joannelkoong@gmail.com>
 <20250613214642.2903225-5-joannelkoong@gmail.com>
 <aFAS9SMi1GkqFVg2@infradead.org>
 <CAJnrk1ZCeeVumEaMy+kxqqwn3n1gtSBjtCGUrT1nctjnJaKkZA@mail.gmail.com>
 <aFDxNWQtInriqLU8@infradead.org>
 <CAJnrk1ZrgXL2=7t2rCdAmBz0nNcRT0q7nBUtOUDfz2+CwCWb-A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJnrk1ZrgXL2=7t2rCdAmBz0nNcRT0q7nBUtOUDfz2+CwCWb-A@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Jun 17, 2025 at 10:20:38AM -0700, Joanne Koong wrote:
> > Ah, ok.  Are you fine with getting something that works for fuse first,
> > and then we look into !CONFIG_BLOCK environments as a next step?
> 
> I think the fuse iomap work has a hard dependency on the CONFIG_BLOCK
> work else it would break backwards compatibility for fuse (eg
> non-CONFIG_BLOCK environments wouldn't be able to compile/use fuse
> anymore)

Sure.  What I mean is that I want to do this last before getting the
series ready to merge.  I.e. don't bother with until we have something
we're all fine with on a conceptual level.

