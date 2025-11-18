Return-Path: <linux-fsdevel+bounces-68827-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A8AC674FE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 06:05:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 10DD729754
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 05:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76BE12BEC27;
	Tue, 18 Nov 2025 05:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="3FLsg8oc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1852E2F5B;
	Tue, 18 Nov 2025 05:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763442329; cv=none; b=KoWukFQ+duASjNUbtoAR28PxJ5XTFjeM2LaedhBOMFEtGlo5Qka8DpSbtR0RAg4vssyN98H9xRl9Wk/0eVYEOpMKDzJgjSs7RMx3xfduZufdEfGMXJ27U5oiG7o1OlH9jYFk3xf/VPcAcrYOV4MA4MvoJK/GOPFffWhdgAphwws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763442329; c=relaxed/simple;
	bh=SHlkRhp66jJGKPW3LKbgMCk7sBsIBS9CAsVB7PG2kfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dx0+RNPHWigfMDxSPRdUHmvfEzCFMtNO1he8zKsk68AH1T+RQPC81O4yl3+FCkntdjmRdoto+1FnQqysUUKz/y6ROpbNINOR/69Iqc5p3dUDaNAjZZMF7y0uzDjN8t+ILGd48iVfJ8O9B2jKTty8ll2N7juzknDqmtcoSwH0VMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=3FLsg8oc; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=HNapumT3u3cvg+LB7F7jDnuORw7Am+MenBUILnbf34A=; b=3FLsg8oc/8SF/EtTA96c5fyT3M
	4DeoEqtENiNgzKY1vcGzYH+/o+gsVgYU3B/3LP3UZhd+MKzEpOKB4aHyZ6JSl5nMLVMLolfilj/Vn
	V4ECNZnEH02rbw4uR2hVs1d1NXUxksldq9n1m500Hw1z7sKEAIR/1xsjZeSqjddazSY9npmFNJnb2
	ZXDUGHaILXo8NljKBcWAxKr7KsiO2wixMvya3QizH2aulIcTAFYBzbkSrYd6XCnCXAlNhoqEDTJ9D
	RLqQjiyQMyp5ik7gte1/pEnIa03haz5iZNQSedAeVA7Be3cfcWM2B7AKu4l5AGe1DDZQpe06jqGK2
	wvV4Qa9Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLDu1-0000000HPKf-2dew;
	Tue, 18 Nov 2025 05:05:17 +0000
Date: Mon, 17 Nov 2025 21:05:17 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: SHAURYA RANE <ssrane_b23@ee.vjti.ac.in>, akpm@linux-foundation.org,
	shakeel.butt@linux.dev, eddyz87@gmail.com, andrii@kernel.org,
	ast@kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev,
	skhan@linuxfoundation.org, david.hunter.linux@gmail.com,
	khalid@kernel.org,
	syzbot+09b7d050e4806540153d@syzkaller.appspotmail.com
Subject: Re: [PATCH] mm/filemap: fix NULL pointer dereference in
 do_read_cache_folio()
Message-ID: <aRv-jfh0WkVZLd_d@infradead.org>
References: <20251114193729.251892-1-ssranevjti@gmail.com>
 <aReUv1kVACh3UKv-@casper.infradead.org>
 <CANNWa07Y_GPKuYNQ0ncWHGa4KX91QFosz6WGJ9P6-AJQniD3zw@mail.gmail.com>
 <aRpQ7LTZDP-Xz-Sr@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRpQ7LTZDP-Xz-Sr@casper.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Sun, Nov 16, 2025 at 10:32:12PM +0000, Matthew Wilcox wrote:
> I don't think it's necessarily all that hard to make buildid work
> for DAX.  It's probably something like:
> 
> 	if (IS_DAX(file_inode(file)))
> 		kernel_read(file, buf, count, &pos);
> 
> but that's just off the top of my head.

The code should just unconditionally use kernel_read().  Relying
on ->read_folio to just work is only something file system code and
library code called by the file systems can assume.

Something reading ELF headers has no bunsiness poking into this layer.

