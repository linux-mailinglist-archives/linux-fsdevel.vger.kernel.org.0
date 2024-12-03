Return-Path: <linux-fsdevel+bounces-36386-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC8849E2EED
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2024 23:17:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1A002814D2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2024 22:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F9420B7FB;
	Tue,  3 Dec 2024 22:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="EQk2k2kB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD6B20B7F0;
	Tue,  3 Dec 2024 22:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733264216; cv=none; b=QHcMEmK3gYyONiMftS++2qw8a5zH7i7EHabzolEluHZnq15iw/AmTVxiGCND7jeiklgAbfy/t6NOvixrGM0IT+zgtgYXhLBzaghj3TCi88SUdhxW9CLGDwjrRrLlR5RBQuzkPbbNyxC+aNJFuA1PtXteG1vT9mUHFa1Cpu2ZXug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733264216; c=relaxed/simple;
	bh=oBzlVvTuMah1WhutZPHI1W7HZDgpAB39ccyTU1ownI8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=kYkWw+CVE1U5HAiNQl9pNrT1S8tbEMAih+MHwI01BA34rsBrLzgQ9CK1YlSPDOnEaj17Z3AmAMoQ60XlzPvAhpgkLYBxPlsDS8XxVeGNd1bfXyIZCqbzZjP4GgRaIfak2zvJ9TYpZ53d531p+SxALvstwsSs9MZcb+Zheh5YULo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=EQk2k2kB; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1733264214;
	bh=oBzlVvTuMah1WhutZPHI1W7HZDgpAB39ccyTU1ownI8=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=EQk2k2kB21r1FclQzxFxsGZqsJt8oM2wOffnFeFJfSXaSiUZ+6ECrMWcwgbnCKA9t
	 k0kdVyIGSXD/HA9D93hxMXNC48xaR70kpSjLEiFV3q43jaa3OVORqw7fPK4uAiBwF1
	 fayMmAHhG1Ihx50D3FWLyqkzrOXhs5i8PqUAp7XU=
Received: by gentwo.org (Postfix, from userid 1003)
	id 1CF744069A; Tue,  3 Dec 2024 14:16:54 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id 1BE08401E0;
	Tue,  3 Dec 2024 14:16:54 -0800 (PST)
Date: Tue, 3 Dec 2024 14:16:54 -0800 (PST)
From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
To: Jens Axboe <axboe@kernel.dk>
cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org, 
    clm@meta.com, linux-kernel@vger.kernel.org, willy@infradead.org, 
    kirill@shutemov.name, bfoster@redhat.com
Subject: Re: [PATCHSET v6 0/12] Uncached buffered IO
In-Reply-To: <668f271f-dc44-49e1-b8dc-08e65e1fec23@kernel.dk>
Message-ID: <36599cce-42ba-ddfb-656f-162548fdb300@gentwo.org>
References: <20241203153232.92224-2-axboe@kernel.dk> <e31a698c-09f0-c551-3dfe-646816905e65@gentwo.org> <668f271f-dc44-49e1-b8dc-08e65e1fec23@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 3 Dec 2024, Jens Axboe wrote:

> I actually did consider using some form of temporal, as it's the only
> other name I liked. But I do think cached_uncached becomes pretty
> unwieldy. Which is why I just stuck with uncached. Yes I know it means
> different things in different circles, but probably mostly an overlap
> with deeper technical things like that. An honestly almost impossible to
> avoid overlap these days, everything has been used already :-)
>
> IOW, I think uncached is probably still the most descriptive thing out
> there, even if I'm certainly open to entertaining other names. Just not
> anything yet that has really resonated with me.

How about calling this a "transitory" page? It means fleeting, not
persistent and I think we have not used that term with a page/folio yet.




