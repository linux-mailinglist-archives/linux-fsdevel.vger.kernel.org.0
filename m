Return-Path: <linux-fsdevel+bounces-4749-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6FEA80309B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 11:39:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71DE5280A49
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 10:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A8EF9EF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 10:39:28 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2016ECB
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Dec 2023 00:37:37 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5551D68AFE; Mon,  4 Dec 2023 09:37:33 +0100 (CET)
Date: Mon, 4 Dec 2023 09:37:33 +0100
From: Christoph Hellwig <hch@lst.de>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>, Christoph Hellwig <hch@lst.de>,
	Jan Kara <jack@suse.cz>, David Howells <dhowells@redhat.com>,
	Jens Axboe <axboe@kernel.dk>, Miklos Szeredi <miklos@szeredi.hu>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] fs: fork splice_file_range() from
 do_splice_direct()
Message-ID: <20231204083733.GA32438@lst.de>
References: <20231130141624.3338942-1-amir73il@gmail.com> <20231130141624.3338942-2-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130141624.3338942-2-amir73il@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

>  		put_rd_wr_caps(src_ci, src_got, dst_ci, dst_got);
> -		ret = do_splice_direct(src_file, &src_off, dst_file,
> -				       &dst_off, src_objlen, flags);
> +		ret = splice_file_range(src_file, &src_off, dst_file, &dst_off,
> +					src_objlen);

Shouldb't ceph be switched to use generic_copy_file_range?
That does the capping of the size which we want, and doesn't update
the file offsets, which would require recalculation in the ceph code.

But this could avoid another exported API as splice_file_range could
simply be folded into generic_copy_file_range which should reduce
confusion.  And splice really is a mess for so many different layers
of the onion being exposed.  I've been wanting to reduce some of that
for a while but haven't found a really nice way yet.


