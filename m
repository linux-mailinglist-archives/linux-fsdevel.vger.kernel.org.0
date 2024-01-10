Return-Path: <linux-fsdevel+bounces-7703-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24965829A8C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 13:46:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B33D1C22A80
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 12:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E9F047F7B;
	Wed, 10 Jan 2024 12:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MHbm5jIZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D150482C4
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jan 2024 12:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ZwuGgkYdN9tsT92z3jDz5U22Na1Jhpriny2hXlL3r5g=; b=MHbm5jIZwN9GSjmhiApHPu4L5i
	ys7nC1OphE5NvdJJ/ylVLVBhR7DXSt6SsCHSkkIqYV6ggS7HU1nrfsF3ofiZ5omAeOgrTPEdYl0o0
	KcTSjh+Hm1//rt6/nocoEqePvQG61l7GVF+KQF3tKWDNC6AXcGX9KsHHHNDm8jL0AdAMCDXm7DAyg
	UgIWICaBXQRerUC6clm+Eb7ruoIeIowX5Kf1jcuKegfPmhFisbPeTCpv2TXwgTpZtl1v/9DBiLClO
	Fcq6a7LP7JNIFBAPycUJYGQSdiwT0zzctTmtZqJKzog/EOaZ21qJGoNm1zNfYYK5tfpPyaoC8qXb3
	YTQQ1AUA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rNXyO-00BQty-5g; Wed, 10 Jan 2024 12:46:20 +0000
Date: Wed, 10 Jan 2024 12:46:20 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [RFC][PATCH] fsnotify: optimize the case of no access event
 watchers
Message-ID: <ZZ6RnO0b4AIFOY7p@casper.infradead.org>
References: <20240109194818.91465-1-amir73il@gmail.com>
 <91797c50-d7fc-4f58-b52a-e95823b3df52@kernel.dk>
 <2cf86f5f-58a1-4f5c-8016-b92cb24d88f1@kernel.dk>
 <CAOQ4uxjtKJ_uiP3hEdTbCh5NNExD5S3+m0oEgB2VjhnD2BrvPw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjtKJ_uiP3hEdTbCh5NNExD5S3+m0oEgB2VjhnD2BrvPw@mail.gmail.com>

On Wed, Jan 10, 2024 at 11:08:17AM +0200, Amir Goldstein wrote:
> My thoughts are that the optimization is clearly a win, but do we
> really want to waste a full long in super_block for counting access
> event watchers that may never exist?

Would it make more sense for it to be global, and perhaps even use the
static key infrastructure to enable/disable fsnotify?

