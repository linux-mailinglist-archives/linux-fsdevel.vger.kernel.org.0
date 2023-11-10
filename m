Return-Path: <linux-fsdevel+bounces-2693-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD3027E789E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Nov 2023 05:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 682E0B21022
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Nov 2023 04:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB3CA1FDA;
	Fri, 10 Nov 2023 04:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k7+UZdqV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25234111B
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Nov 2023 04:50:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64BE6C433D9;
	Fri, 10 Nov 2023 04:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699591821;
	bh=Dow/ARQ58Q88dza+kpujGBREWyVVvC6d19gGozvfNkM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k7+UZdqVGQ8wLz3rxKNdkpo8yd5ybrlF2Ls2oOf+N8h+ZSRVc032NevkTQB3BQRj0
	 ZrBkIEoybdIJInbvKFPgTlHOo3k9eNUfmBO7xgcDQr2C3Zk1f+UALQPDo6WaIpgAZ0
	 Sma1VwBSMqqpVGoc02gWiFr5GVssNpwq+xfCJXxdfRY2VyGq4yZcX8lU1n9jUw9LT2
	 i7QlolUUMsX7yE2dgNAyDO5zX8c2e20dwn/eeqK7rfN3rVUa7me5ZSCHGXYKDI/qvU
	 kizGasya/fjPQvPtSa3OaPNVtP11nuf5+EXuV5NH+bLN7dmnMmwapJ4MIrVRz26fHv
	 S8RVJf4+u+D2A==
Date: Thu, 9 Nov 2023 20:50:19 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Hannes Reinecke <hare@suse.de>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Pankaj Raghav <p.raghav@samsung.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 7/7] buffer: Fix more functions for block size >
 PAGE_SIZE
Message-ID: <20231110045019.GB6572@sol.localdomain>
References: <20231109210608.2252323-1-willy@infradead.org>
 <20231109210608.2252323-8-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231109210608.2252323-8-willy@infradead.org>

On Thu, Nov 09, 2023 at 09:06:08PM +0000, Matthew Wilcox (Oracle) wrote:
> Replace the shift with a divide, which is probably cheaper than first
> calculating the shift.

No.  The divs are almost certainly more expensive on most CPUs, especially when
doing two of them.  On x86_64 for example, it will be two div instructions
instead of one bsr and two shr instructions.  The two divs are much more costly.
The block size is always a power of 2; we should take advantage of that.

- Eric

