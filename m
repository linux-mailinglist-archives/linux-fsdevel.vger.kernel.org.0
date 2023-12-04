Return-Path: <linux-fsdevel+bounces-4752-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 603188030A5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 11:39:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17BDF1F2107B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 10:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C5F1224C9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 10:39:42 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE3085
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Dec 2023 00:39:55 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1404568AFE; Mon,  4 Dec 2023 09:39:53 +0100 (CET)
Date: Mon, 4 Dec 2023 09:39:52 +0100
From: Christoph Hellwig <hch@lst.de>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>, Christoph Hellwig <hch@lst.de>,
	Jan Kara <jack@suse.cz>, David Howells <dhowells@redhat.com>,
	Jens Axboe <axboe@kernel.dk>, Miklos Szeredi <miklos@szeredi.hu>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] fs: use do_splice_direct() for nfsd/ksmbd
 server-side-copy
Message-ID: <20231204083952.GD32438@lst.de>
References: <20231130141624.3338942-1-amir73il@gmail.com> <20231130141624.3338942-4-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130141624.3338942-4-amir73il@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Nov 30, 2023 at 04:16:24PM +0200, Amir Goldstein wrote:
> nfsd/ksmbd call vfs_copy_file_range() with flag COPY_FILE_SPLICE to
> perform kernel copy between two files on any two filesystems.
> 
> Splicing input file, while holding file_start_write() on the output file
> which is on a different sb, posses a risk for fanotify related deadlocks.
> 
> We only need to call splice_file_range() from within the context of
> ->copy_file_range() filesystem methods with file_start_write() held.
> 
> To avoid the possible deadlocks, always use do_splice_direct() instead of
> splice_file_range() for the kernel copy fallback in vfs_copy_file_range()
> without holding file_start_write().

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

(although I wish do_splice_direct had a better name like
vfs_splice_direct, espcially before growing more users)


