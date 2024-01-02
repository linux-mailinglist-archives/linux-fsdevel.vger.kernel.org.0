Return-Path: <linux-fsdevel+bounces-7137-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ABF78221BD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jan 2024 20:07:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E158BB220C3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jan 2024 19:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3957A15AE7;
	Tue,  2 Jan 2024 19:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="RhtzzfZY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E2D15AD2
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Jan 2024 19:07:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8EBAC433C7;
	Tue,  2 Jan 2024 19:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1704222469;
	bh=Iw59E51/iO+5DUxO/sh38aTGP+0SFlxEReNsCBZs/Rw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RhtzzfZYrY4Xh1PxJDa0J7p3+OZghL2tSle6h4g0tVMRnDPdsyloSbRQdZ5SP6SWK
	 B7AJMVY0l0tmFEWbLdWiGMz49ct7CGK7LbycN39CBMEj65l6WR+LALCWkix1npbAzC
	 KU1siB3xJjJhUGFBIKBhi4ZGe2WEuI4PONm0XzR4=
Date: Tue, 2 Jan 2024 11:07:49 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, Ryusuke Konishi
 <konishi.ryusuke@gmail.com>
Subject: Re: [PATCH] buffer: Fix unintended successful return
Message-Id: <20240102110749.f838d332c558082189efa7fc@linux-foundation.org>
In-Reply-To: <20240101093848.2017115-1-willy@infradead.org>
References: <20240101093848.2017115-1-willy@infradead.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  1 Jan 2024 09:38:48 +0000 "Matthew Wilcox (Oracle)" <willy@infradead.org> wrote:

> If try_to_free_buffers() succeeded and then folio_alloc_buffers()
> failed, grow_dev_folio() would return success.  This would be incorrect;
> memory allocation failure is supposed to result in a failure.  It's a
> harmless bug; the caller will simply go around the loop one more time
> and grow_dev_folio() will correctly return a failure that time.  But it
> was an unintended change and looks like a more serious bug than it is.
> 
> While I'm in here, improve the commentary about why we return success
> even though we failed.
> 
> Reported-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Cool.  I'll add

Fixes: 6d840a18773f ("buffer: return bool from grow_dev_folio()")

