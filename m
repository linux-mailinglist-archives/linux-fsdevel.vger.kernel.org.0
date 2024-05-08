Return-Path: <linux-fsdevel+bounces-19090-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0638BFC89
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 13:45:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F4F71F25355
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 11:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D62839E5;
	Wed,  8 May 2024 11:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="e+mJJGj4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A1329CF0;
	Wed,  8 May 2024 11:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715168641; cv=none; b=LavrtYvE3M9LO/Tmhd+7O4smTSRYGl0bk9OSx9L3z368rfMT9GS5/gPVVkHxOMjPQf4TDNfNNZbC0uCQH4hg+rt5Nv8NqL6WiFGehBMVGbzTevh/gVWm4sYjL9qvk0eb1TAreBtHh4IjKnv0ojLRvgBGG/l33UksNYuEwKy2cqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715168641; c=relaxed/simple;
	bh=viXOb41qTU9kWx0jThG0vI6lZipWc8gTwUonH6gZKFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=abziByhi3V7bafd9pgdr89FStoH8vYjr6yhCdelcx26hxxjUn9EtJMsC8X0MnC/TBlsR3CA2+ExvmdnPDIb5M4wG7+l3K5GN/Mn72r0GITlh/8cut7I2g7Y/vq4kY8Mxg6f5lx5/uwCmx0wCDrsjBOlFZPqQUlybhFuKaI3/jZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=e+mJJGj4; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M+v3H/nU/QJaIsBDguqkHxM6WbQlkmb4bw266jdl3Fc=; b=e+mJJGj4aLIe/+J6T8Hm4+D3wG
	dyPXbxOshBzcbT5w6a/ZDQtrLhtnu8pElcQqvUMeusU2QeTH4c833WnqnsYtpPrE1o5ZXqZOa6UPF
	CzJcW8TM9dGnylZOaJb9UFQ2CNQ5+LFWek8+83dctv2ea9YWy71nLx/Dbt16P3Ett8zqCGCmf17iL
	XbxvL+mYFlVuPDlI8e45hn27rDGgkQFLF2bsIErgyit3zD6BeGTKcxBiFKhO/5JmzYL04CfiuP7g+
	3KLIG97lILq3GUl0Fa5uwm6mf8KCvDt3P2odVsrHnpXuyiarOYl2EOHha8RgjN1oEM60BBMWNwPsc
	D/A2+QrA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4fiE-0000000FJie-2SkA;
	Wed, 08 May 2024 11:43:54 +0000
Date: Wed, 8 May 2024 04:43:54 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: Christoph Hellwig <hch@infradead.org>, hch@lst.de, willy@infradead.org,
	mcgrof@kernel.org, akpm@linux-foundation.org, brauner@kernel.org,
	chandan.babu@oracle.com, david@fromorbit.com, djwong@kernel.org,
	gost.dev@samsung.com, hare@suse.de, john.g.garry@oracle.com,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-xfs@vger.kernel.org, p.raghav@samsung.com,
	ritesh.list@gmail.com, ziy@nvidia.com
Subject: Re: [RFC] iomap: use huge zero folio in iomap_dio_zero
Message-ID: <Zjtlep7rySFJFcik@infradead.org>
References: <20240503095353.3798063-8-mcgrof@kernel.org>
 <20240507145811.52987-1-kernel@pankajraghav.com>
 <ZjpSx7SBvzQI4oRV@infradead.org>
 <20240508113949.pwyeavrc2rrwsxw2@quentin>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240508113949.pwyeavrc2rrwsxw2@quentin>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, May 08, 2024 at 11:39:49AM +0000, Pankaj Raghav (Samsung) wrote:
> At the moment, we can get a reference to the huge zero folio only through
> the mm interface. 
> 
> Even if change the lower level interface to return THP, it can still fail
> at the mount time and we will need the fallback right?

Well, that's why I suggest doing it at mount time.  Asking for it deep
down in the write code is certainly going to be a bit problematic.


