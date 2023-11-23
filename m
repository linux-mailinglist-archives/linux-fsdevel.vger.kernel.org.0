Return-Path: <linux-fsdevel+bounces-3511-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A937F598D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Nov 2023 08:47:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECB381F20EE2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Nov 2023 07:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1421B18647;
	Thu, 23 Nov 2023 07:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QR0nIZbC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E6CCA2
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Nov 2023 23:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=kMpCBGIKmxfwNE2ewIg0HR5tT28z5mc8DMw9iMyIRSU=; b=QR0nIZbCnFXvSWXuQdmM9zUJhI
	YSkn9flh/EUcIL8gmugGdi+ERVWwjX3SGI2EXqRZXoDTlJsmq4SrCB1lkZ8Ifl0CdtQYannRCQdI4
	IvoJSEk8LHgPZufFVcvpyCjEGBVpYQrvngGB/dJOKUAIPwqxr7Oz5dpgmp5Ddyi44bepmeYWdbuHU
	igx52wKMC560tZDi/X0c11FmJlylGBHESvn7JvMTGxfnSWTOHMEoSQzW41BmD71bWJfNiJWeqsQkK
	4HRvsUfEoyhxPaSWkSyzxBEF062xSQ8zDgcu/9sA49WEjLaoeC4Txc3uDyfgDfwHwd7DY3JBawSzw
	lAARN9bA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r64Qt-0044fi-14;
	Thu, 23 Nov 2023 07:47:31 +0000
Date: Wed, 22 Nov 2023 23:47:31 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Josef Bacik <josef@toxicpanda.com>,
	David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 05/16] splice: remove permission hook from
 iter_file_splice_write()
Message-ID: <ZV8Dk7UOLejEhzQN@infradead.org>
References: <20231122122715.2561213-1-amir73il@gmail.com>
 <20231122122715.2561213-6-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122122715.2561213-6-amir73il@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

> +ssize_t __kernel_write_iter(struct file *file, struct iov_iter *from,
> +			    loff_t *pos);
> +ssize_t do_iter_writev(struct file *file, struct iov_iter *iter, loff_t *ppos,
> +		       rwf_t flags);

So I first stumbled on the name because I kinda hate do_* functions,
especially if they are not static, and then went down a little rathole:


 - first obviously the name, based on the other functions it probably
   should be in the __kernel_* namespace unless I'm missing something.
 - second can you add a little comment when it is to be used?  Our
   maze of read and write helpers is becomeing a little too confusing
   even for someone who thought he knew the code (and wrote some if it).
 - can we just split do_iter_readv_writev instead of adding a wrapper
   Yes, that'll duplicate a little boiler plate code, but it'll make
   things much easier to follow.
(- same probably for do_loop_readv_writev, although not directly
   relevant to this series)


