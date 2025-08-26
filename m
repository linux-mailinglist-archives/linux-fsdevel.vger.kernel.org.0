Return-Path: <linux-fsdevel+bounces-59211-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB84B36334
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 15:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF3E11BC4D80
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 13:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0F134DCEC;
	Tue, 26 Aug 2025 13:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hBwOCIwF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75008312803;
	Tue, 26 Aug 2025 13:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756214426; cv=none; b=J+41U809sBaCODd8R0AkKEXUZ0QViC03AfQunIytfv39MRIKR+sjgVvIkLGUSE6phdZ2vMWrj3cP6BRD+lh93Q6fu3oB5vSR2v4NHPw+nNx55/bGScsL0+2nMkd9LytioybJ0IAM3raRxtr2+4MrcHY3/h0OXIxVoQ9ZfJh5KWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756214426; c=relaxed/simple;
	bh=jjuPapsgWGN+1Nrpf5amo90HYScgmnPUiRwCTJLjtng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QJaZfHaTf8t0mWo0N3vXPa9VvmZdl5pt1cyfnbUzKqqfvDOmIYMW4Fhu99HJq5x4b1XcndWpkqon0D24ZAwFa+TwnOqpF3tZY58dlgmvdnnwx1lflBBK8BO6m7ooyc1xVtRzBHpK3TYzIC7UaTBlS0KzrldyCBK3XHefeCbX2KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hBwOCIwF; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=08FyapFBrrTQwRGwpcVtG9uDqwyWlKXLu+km+C9VdQU=; b=hBwOCIwFJIBSYAJABpSjMN+oNy
	NNoVgkKjMTFVeUHScuDRssT9CFkFNU1WtW91Bwut1vWPBU7I6LM5S9DXewQlsE3M7CbQk4XFcyW3D
	082mDFTozH/s6Ps7tfFhe6ZLGmadeVGiRqP1Ynks+7M+FP8tynLgI3RCL+xPHrGOD3aa0iU7BITQV
	fwc4+S+7m4uLG/qiuoZv5No6IVyZIez7BNu4A6ls3rWpvzXEl69vt7IAUORis+xQhMpIdMMe9VESP
	7AyCc3jG1TWdSI2V1s+pIq1n0yHnBqyXpbHtZA4GbPq2Oo7na6Pe9J23jpelKOm5mjXaoO8kKsgbd
	FIYiLH2g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqtav-0000000C4xd-3sR2;
	Tue, 26 Aug 2025 13:20:13 +0000
Date: Tue, 26 Aug 2025 06:20:13 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jinliang Zheng <alexjlzheng@gmail.com>
Cc: hch@infradead.org, alexjlzheng@tencent.com, brauner@kernel.org,
	djwong@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	yi.zhang@huawei.com
Subject: Re: [PATCH v3 0/4] allow partial folio write with iomap_folio_state
Message-ID: <aK20jalLkbKedAz8@infradead.org>
References: <aKwuJptHVsx-Ed82@infradead.org>
 <20250825113921.2933350-1-alexjlzheng@tencent.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825113921.2933350-1-alexjlzheng@tencent.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Aug 25, 2025 at 07:39:21PM +0800, Jinliang Zheng wrote:
> Actually, I discovered this while reading (and studying) the code for large
> folios.
> 
> Given that short-writes are inherently unusual, I don't think this patchset
> will significantly improve performance in hot paths. It might help in scenarios
> with frequent memory hardware errors, but unfortunately, I haven't built a
> test scenario like that.
> 
> I'm posting this patchset just because I think we can do better in exception
> handling: if we can reduce unnecessary copying, why not?

I'm always interested in the motivation, especially for something
adding more code or doing large changes.  If it actually improves
performance it's much easier to argue for.  If it doesn't that doesn't
mean the patch is bad, but it needs to have other upsides.  I'll take
another close look, but please also add your motivation to the cover
letter and commit log for the next round.


