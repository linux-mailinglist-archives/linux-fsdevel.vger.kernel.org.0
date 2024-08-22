Return-Path: <linux-fsdevel+bounces-26594-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E009695A8ED
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 02:34:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAAB61C220CC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 00:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 112E379F2;
	Thu, 22 Aug 2024 00:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Wj66x4ql"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BEBC6FB6;
	Thu, 22 Aug 2024 00:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724286843; cv=none; b=ZtRnJQimPxJVXhAR6YqJt6EmGdQCRl4fx9vixuUinTbY9iHnrcGLajQG8io0JZgV4+x/EU8KEwne22e/PHhq5Qr1sPvIZfKQlgudWxszGX2nsLZqCNxexvcHNYzTsw1p86neKlNBsGZAvClSaD+gVnYg4gP/tyMSJPiTPAmsJH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724286843; c=relaxed/simple;
	bh=szcSZ/48CgMin0NbY06/woiuGMBYmaoTSNF6+ql9uZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r6h06XogoIIyfXIb2M0q8+Qdl53Rci3Yst1J7HyIBsmtuNbuiXpbnScdbGbiBDP//wE7gZiLz68Ay9L4tQckHc9Zq5fB4mVhtVHIa+iMTs/uXzRqabpGoiJbyX8dimxnFqGX0o8NA44UEJpEjXEd/4Gl/eO6+yp9UBz+LVa6K4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Wj66x4ql; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=A1uAKmh2iQcKM2S28r/q2jLRvuxYY1Jmbbw/IH9dgz4=; b=Wj66x4ql1wxP1I1Vnzk+sSoDfe
	J+XMnwokamhHjhqOCiM0ZstVFMwH5pNfQNXXRaE8ft7nM+FJFQmXRR09keApbLUU0AGl2clCsoTsN
	+cQNP6nU9Gh7pU/ATf5HzuwL4/eF95yJhaw/p1qVBOy7gKDmcUAQ008WD1RN6v5yzol6h5MJVwc1t
	EpqVkfG1k+pD+Z/hXQvPLnMY9ggyb8k40j6DRfFaR37P3oS0Xyf5P28z0wQ5cQBspKpuBPbLwGnkN
	mcWRMJHIRmk5/N32EYlxHn0wU0PXf6gElRR/fsabNj04LYlRK8EucV81Grkl9/SCuhZ5NXEEvToPu
	lE2Dnq4w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sgvm3-00000003wJC-3glj;
	Thu, 22 Aug 2024 00:33:59 +0000
Date: Thu, 22 Aug 2024 01:33:59 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, jack@suse.cz, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] vfs: avoid spurious dentry ref/unref cycle on open
Message-ID: <20240822003359.GO504335@ZenIV>
References: <20240807063350.GV5334@ZenIV>
 <CAGudoHH29otD9u8Eaxhmc19xuTK2yBdQH4jW11BoS4BzGqkvOw@mail.gmail.com>
 <20240807070552.GW5334@ZenIV>
 <CAGudoHGMF=nt=Dr+0UDVOsd4nfGRr4xC8=oeQqs=Av9s0tXXXA@mail.gmail.com>
 <20240807075218.GX5334@ZenIV>
 <CAGudoHE1dPb4m=FsTPeMBiqittNOmFrD-fJv9CmX8Nx8_=njcQ@mail.gmail.com>
 <CAGudoHFm07iqjhagt-SRFcWsnjqzOtVD4bQC86sKBFEFQRt3kA@mail.gmail.com>
 <20240807124348.GY5334@ZenIV>
 <20240807203814.GA5334@ZenIV>
 <CAGudoHHF-j5kLQpbkaFUUJYLKZiMcUUOFMW1sRtx9Y=O9WC4qw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGudoHHF-j5kLQpbkaFUUJYLKZiMcUUOFMW1sRtx9Y=O9WC4qw@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Aug 20, 2024 at 01:38:05PM +0200, Mateusz Guzik wrote:
> do you plan to submit this to next?
> 
> anything this is waiting for?
> 
> my quick skim suggests this only needs more testing (and maybe a review)

OK, let me post the current variant of that series, then we'll see
if anyone screams...

