Return-Path: <linux-fsdevel+bounces-68490-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D3379C5D547
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 14:25:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 385C635CC61
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 13:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D90313E2B;
	Fri, 14 Nov 2025 13:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dl0AhYmQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B221CDFD5;
	Fri, 14 Nov 2025 13:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763126300; cv=none; b=ci/xBgaVTBSZnSf4sbBE5W1ebmalWvWIJ1ixyL062QP2OP08QOWfWh0LTpFaas6z2Zsejzg93Wwj1sSXr8spdqDmpHhFO7D/aOg/2DuO2q6lHDv6ux0Ppl1VrjEfYYmBmQsU/rsaM0xWxWe9nx7epSg18iKtBY0bU+fcrRPE+wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763126300; c=relaxed/simple;
	bh=hmVNfXV6oyQABFYC6/ma7wXURuBWKP2P48qcOd0qnCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r9JYxqt/lSHtXNYS/cYIy7BMGBX2ml6j0JzkwAAzM51w629+CGfadarG5XrRatp1RaqkL6Y+Jvo7PMeLAsmQNU+6gJ26bPQcFfFGXsum1JbB6PLP5DmOP3TmqdnIa9xel7mKEveZpn34Hld5rXjP6t6S2webcKwBbviz/aCRSA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dl0AhYmQ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hmVNfXV6oyQABFYC6/ma7wXURuBWKP2P48qcOd0qnCc=; b=dl0AhYmQpaaVm92D43c89MJTqg
	15iItLJULDTf+hYKkhp4788x6bFlulpBjbCa+UeFxstvvcOvD19ohAhWrAvbv0MpmfN9dSI3JJ0gh
	RRFNwM5nkGgTaPzFRGKmWlOPTxzw2EPPdSSKURyZvuaDh/u5caoheTcBFwHmdVpFD2VJn0YlpGBR3
	iF9f2Bk8Yx1jygcopP1xvAuoGcK5kXI6FbSqLaAHw//n5e6Wo7vGXJbBBMy2nGe4dLf68Zgs11TO0
	Hx6LnTivTI4+RWBwX0FUVNgCVqL8nEvWlHKS/OK9PC4oY9SbAQh9LQOheJKSFtRiLmytwquIFBVUb
	4+XIGdlw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJtgq-00000009Mvx-12tt;
	Fri, 14 Nov 2025 13:18:12 +0000
Date: Fri, 14 Nov 2025 13:18:12 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: Dave Chinner <david@fromorbit.com>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Christoph Hellwig <hch@lst.de>,
	Christian Brauner <brauner@kernel.org>, djwong@kernel.org,
	john.g.garry@oracle.com, tytso@mit.edu, dchinner@redhat.com,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, jack@suse.cz, nilay@linux.ibm.com,
	martin.petersen@oracle.com, rostedt@goodmis.org, axboe@kernel.dk,
	linux-block@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/8] xfs: single block atomic writes for buffered IO
Message-ID: <aRcsFF5eCCsx5kYh@casper.infradead.org>
References: <cover.1762945505.git.ojaswin@linux.ibm.com>
 <aRUCqA_UpRftbgce@dread.disaster.area>
 <20251113052337.GA28533@lst.de>
 <87frai8p46.ritesh.list@gmail.com>
 <aRWzq_LpoJHwfYli@dread.disaster.area>
 <aRb0WQJi4rQQ-Zmo@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRb0WQJi4rQQ-Zmo@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>

On Fri, Nov 14, 2025 at 02:50:25PM +0530, Ojaswin Mujoo wrote:
> buffered IO. Further, many DBs support both direct IO and buffered IO
> well and it may not be fair to force them to stick to direct IO to get
> the benefits of atomic writes.

It may not be fair to force kernel developers to support a feature that
has no users.

