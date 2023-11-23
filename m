Return-Path: <linux-fsdevel+bounces-3515-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 462317F599D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Nov 2023 08:50:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77E3A1C20CB8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Nov 2023 07:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 281D61865F;
	Thu, 23 Nov 2023 07:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MkFEdA+5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD87191
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Nov 2023 23:50:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=bmx0TM7p+hBIw0oNoHs9YQvAoN9mv7mvx3pgf0NpsdU=; b=MkFEdA+5nFi/C07hevrblsU3qz
	X1CrQRaBzroObXbB5TFsuPJObAN8kuFcGbdQ1o+scQVeUMJV769T2k5MeIxGWY5f+INEQ420jGJ01
	Lyx4cmjT6ihTzQQB+L0791V1vItGMRgcj+bF2DZpn06ghuhpM8F35SQXo+xY9AgfUb7XmpbWIctMC
	lkYJxF9nIp0+zfQOv8nhrkshrLRt4OlTbq1ArLb9AT4bQsb7OQmXBvd3JiZrcOnJOOpaBgd0JAIep
	8To/SswEUtgJmypqqDW+dP2BsqnH/UEJ8ZLopMHDzjFSiZ0VopREKyxWtmd5/rAAXNxLeUJjsRQMl
	w3PxFxGg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r64Ts-0044xN-2l;
	Thu, 23 Nov 2023 07:50:36 +0000
Date: Wed, 22 Nov 2023 23:50:36 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Josef Bacik <josef@toxicpanda.com>,
	David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 10/16] fs: move file_start_write() into
 vfs_iter_write()
Message-ID: <ZV8ETIpM+wZa33B5@infradead.org>
References: <20231122122715.2561213-1-amir73il@gmail.com>
 <20231122122715.2561213-11-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122122715.2561213-11-amir73il@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Nov 22, 2023 at 02:27:09PM +0200, Amir Goldstein wrote:
> All the callers of vfs_iter_write() call file_start_write() just before
> calling vfs_iter_write() except for target_core_file's fd_do_rw().

Can you add a patch to first add it to fd_do_rw?  While this crates a
bit of churn, it has two benefits:

 - it gives us an easily backportable fix
 - it makes this patch a transformation that doesn't change behavior.

Please also cc the scsi and target lists.  It probably makes sense to
even expedite it and send it for 6.7-rc inclusion separately.
be a 6.7 candidate 

