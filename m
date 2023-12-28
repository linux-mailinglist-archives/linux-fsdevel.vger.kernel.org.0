Return-Path: <linux-fsdevel+bounces-6989-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A4081F555
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Dec 2023 08:12:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 540EA1C20F84
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Dec 2023 07:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AABE63D2;
	Thu, 28 Dec 2023 07:12:13 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E3063AB;
	Thu, 28 Dec 2023 07:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8131768B05; Thu, 28 Dec 2023 08:12:06 +0100 (CET)
Date: Thu, 28 Dec 2023 08:12:06 +0100
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Daejun Park <daejun7.park@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v8 06/19] block, fs: Propagate write hints to the block
 device inode
Message-ID: <20231228071206.GA13770@lst.de>
References: <20231219000815.2739120-1-bvanassche@acm.org> <20231219000815.2739120-7-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231219000815.2739120-7-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Dec 18, 2023 at 04:07:39PM -0800, Bart Van Assche wrote:
> Write hints applied with F_SET_RW_HINT on a block device affect the
> shmem inode only. Propagate these hints to the block device inode
> because that is the inode used when writing back dirty pages.

What shmem inode?

> @@ -317,6 +318,9 @@ static long fcntl_set_rw_hint(struct file *file, unsigned int cmd,
>  
>  	inode_lock(inode);
>  	inode->i_write_hint = hint;
> +	apply_whint = inode->i_fop->apply_whint;
> +	if (apply_whint)
> +		apply_whint(file, hint);

Setting the hint in file->f_mapping->inode is the right thing here,
not adding a method.


