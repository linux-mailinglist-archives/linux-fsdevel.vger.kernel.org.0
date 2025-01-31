Return-Path: <linux-fsdevel+bounces-40472-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85171A23A56
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2025 08:59:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FDAD1887CED
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2025 07:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D9615C15F;
	Fri, 31 Jan 2025 07:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="3OP7HRyy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464AD145A18;
	Fri, 31 Jan 2025 07:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738310379; cv=none; b=CKetBeC7gjW1YPTjE4O5m1Kuc4uu0AhIfSSUe2/j48PROcwknFF+F++D8WzPQptjA4mMK2l4D52om6UIYOxKKkiOlMK10Ep1ucW0n7xBLszrgvRj28XcyW1qBAFQ+zYoS7RXcbaRpRnu1lN8S1/pRtfD37B6Y7aP8L5ROhw9SR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738310379; c=relaxed/simple;
	bh=MrTBDtvw+yVeInA7FGcxYd/BxkKv8pwHHiPDKC2IECg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SWpdMTzoTKN9+DDXn8r0etpwXedyuRHWJyuENGM0VdJiCGoVZYpsNJThrdQutwXpjAhKY9bZdLMmwq4EGtne/E6MInjMVsVQ80BjztHwNpRWUnnsmqwVoOCSkKJQYskd24HlVKV2g+hKXWFUb10PoqqEwp/AYQBSmnVfWQure0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=3OP7HRyy; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=toTwADMrft/0k8kMqiV7tZPS1yw7Gy/Mce8djcNqk4E=; b=3OP7HRyy+2U8LtuAjoR7Ymr8wL
	utuh2gmDf+9jJFVqBjd85uW7x5JPJSe9ejd0sWAL/K6y1YZ6TsAcWqoCADek3e6F/PL8zwRPNj5TW
	41vePPYOZfJdLqp2nbsYPqtHGjQR6KT+gJ8+HiOMsa+7K5q+c/YA6V3cRyHxfKp37Emdb/eMNzrdL
	3IkuyJYHxRf43O4Uz2gXFZHQk/gIPR4sbTabbvJUNEQhBTi7nCmv9xB0jO5LQ0tRVRDhdanuAqUTi
	KYAeSITNjjmzxq7caGO1t9VckBMlTr5KANtAAwWFwNUhDbxSQMESGLQJyvozxtxfQUV2Zw4ufLh94
	kaJDdWlQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tdlw8-0000000A9QU-1Kns;
	Fri, 31 Jan 2025 07:59:36 +0000
Date: Thu, 30 Jan 2025 23:59:36 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Ted Ts'o <tytso@mit.edu>, Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 2/7] iomap: Move prefaulting out of hot write path
Message-ID: <Z5yC6EIUslDmsn9r@infradead.org>
References: <20250129181749.C229F6F3@davehans-spike.ostc.intel.com>
 <20250129181753.3927F212@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250129181753.3927F212@davehans-spike.ostc.intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Only this patch out of 7 made it to linux-xfs.  I have no way to
review the patch without the proper context.  Please make sure you
always Cc all patches to all recipients.

