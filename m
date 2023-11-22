Return-Path: <linux-fsdevel+bounces-3352-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52FFD7F3E55
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 07:50:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F39DF1F22921
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 06:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E49C123;
	Wed, 22 Nov 2023 06:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="F4wFCqWM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF6CB9
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Nov 2023 22:50:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hZ2q6EkDo0uvKktJJU2MfAPdDyljYV7S4qY0MpKwIlA=; b=F4wFCqWMc6KeoVbFfoMAz2nE+a
	Pv8pROvlUMHwhseVw3R7N++XUidq4fEYD73KrUTwonKN4rkUWlIX0VFgnKtDf5MV+EuRMq5UNFtO/
	oWVm9M/nMUlDEjVCrnk5arklBrHlEIxlRMAzeFSK43KYq/SO/j3uO9QnyTVP5YAfdED/L2Z3U3VXa
	irbSVR3/7GkuCn4eJK9sQ+mMrqySnkZId8ftkVeBY1Etxz/Tqml3KJhD5JDJWOp1KCOjzXw6Z5YXk
	u0dF+JgaPFD9cbziLmxV07MPzyXbfkudHMd5pvzb6ZewxhbFh4GdoHnqffgoNGb1KoP/a2A/VCFCi
	ebM9PK+A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r5h49-000rKk-27;
	Wed, 22 Nov 2023 06:50:29 +0000
Date: Tue, 21 Nov 2023 22:50:29 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Dave Chinner <david@fromorbit.com>
Cc: Josef Bacik <josef@toxicpanda.com>, Amir Goldstein <amir73il@gmail.com>,
	Jens Axboe <axboe@kernel.dk>,
	Christian Brauner <brauner@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: allow calling kiocb_end_write() unmatched with
 kiocb_start_write()
Message-ID: <ZV2kteeZ972k1p1W@infradead.org>
References: <20231121132551.2337431-1-amir73il@gmail.com>
 <20231121210032.GA1675377@perftesting>
 <ZV0hWVWeI6QOVfYM@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZV0hWVWeI6QOVfYM@dread.disaster.area>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Nov 22, 2023 at 08:30:01AM +1100, Dave Chinner wrote:
> I like this a lot better than an internal flag that allows
> unbalanced start/end calls to proliferate.  I find it much easier to
> read the code, determine the correct cleanup is being done and
> maintain the code in future when calls need to be properly
> paired....

Agreed.

