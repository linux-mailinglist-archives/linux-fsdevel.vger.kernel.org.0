Return-Path: <linux-fsdevel+bounces-4771-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 456028036F4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 15:36:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E165E1F21232
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 14:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A4A28E08
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 14:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mFNDlUtG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E5AAE5
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Dec 2023 05:36:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Z+/H0SEHq9DPw0LqbiocXkpKaU3Cue2vvR7LcnmWwvw=; b=mFNDlUtGv6XlKT/eWdNB6IHZwE
	B49kQv9m5XCzVcvo1kUVPeHrWzSszAiEtmQqa8Ayt8/pIS1u9IP0E2+PKHDAu34ZlNfYcZlOJLow8
	aElq7siwGpg0JhgjbErIV5a9rVL32Be7r+uUaQIr81A+rwcWWVe1WqbN3MY6xkLeSrqVo+v8hDh+m
	FMW0JC/7ljTXT6QuVMXg91dRadg4G7C7Pw3qUoUSRxRlz4vRbnRG5iJue+z7f/QBKH6CLle5t1YA3
	10ccOvtc04+F2CJaoH3AcJvdj6TmgxkKfB/nMX0cGD2/JsLLU/5IsqgTGp9qitkqzXUxCDB16yUSO
	oaR42odw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rA97W-000j2h-1U; Mon, 04 Dec 2023 13:36:22 +0000
Date: Mon, 4 Dec 2023 13:36:21 +0000
From: Matthew Wilcox <willy@infradead.org>
To: John Sanpe <sanpeqf@gmail.com>
Cc: linkinjeon@kernel.org, sj1557.seo@samsung.com,
	linux-fsdevel@vger.kernel.org, Andy.Wu@sony.com,
	Wataru.Aoyama@sony.com, cpgs@samsung.com
Subject: Re: [PATCH] exfat/balloc: using hweight instead of internal logic
Message-ID: <ZW3V1fmY0R2uD6tH@casper.infradead.org>
References: <20231204022258.1297277-1-sanpeqf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231204022258.1297277-1-sanpeqf@gmail.com>

On Mon, Dec 04, 2023 at 10:22:58AM +0800, John Sanpe wrote:
> Replace the internal table lookup algorithm with the hweight
> library, which has instruction set acceleration.

This is undeniably better, but why stop here?  Instead of working one
byte at a time, you could work an entire word at a time and use
hweight_long().

Also, if you're in the mood for a second patch, free_bit[] is clearly
an open-coding of ffz().

