Return-Path: <linux-fsdevel+bounces-16911-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 383FA8A4B69
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 11:27:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF9C6B22483
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 09:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB763FB99;
	Mon, 15 Apr 2024 09:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ug/yB1Pc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C384E3FB1D
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Apr 2024 09:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713173217; cv=none; b=iExH1vHAYt6HkTERzE1WsEXocr9ORKU/3F7MXBuWEPXcnuxmx8Tf66/4doJAJVV/g5qB/A6yYArpOymb2xlu/6/8Z9cR64chO8yUNP/bOCIEiDEFSFoJ0VJKuPYgiAPAZsADXyTRbgrb9qSoXKmD/mNBamkiOF8M8vftMwZ2x1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713173217; c=relaxed/simple;
	bh=sA5fgX9HWhMU42nF38m0dAA/l+qdQMZG3Q8ualuuI4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IsjdoiD5xIfT6Jqaa68WUVd7BxOHi85TQ9c7hMiknO8Ybp5rmczDabscEiz0LMAVWH3M0AETwQiX6G3z8DInsiyZOtBvu3RfejOZBn9Su4iWAbffdyEAEaxEBwkbC3AapU0Pebh0Om9TKQ+ybHXFlfh2MQbMIIPt9jKRC8o++2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ug/yB1Pc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713173214;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JKW7sMkNKvCDKzXl0a+7+sB/76+8oNdGXWP00zBOyoM=;
	b=Ug/yB1PcFZfr+hxdnC9WLmJL5cBmnLWoKT1VhV9m17BIlRRhSD2oy8kmhJQ/M1TTn0V6aq
	VA6c1ARm1JA7SZJgSc9ruSBRf89JWJ/E6Od9T1azo75lKS5hp340twWnCSB82hqwyX7WUE
	l+vJYGxTLRX9aKZNDusImE84y13dT/Q=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-208-b4_-Er1KM7i5HB7d0PL9cw-1; Mon, 15 Apr 2024 05:26:49 -0400
X-MC-Unique: b4_-Er1KM7i5HB7d0PL9cw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D9C35830E77;
	Mon, 15 Apr 2024 09:26:48 +0000 (UTC)
Received: from fedora (unknown [10.72.116.13])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 774E92BA;
	Mon, 15 Apr 2024 09:26:43 +0000 (UTC)
Date: Mon, 15 Apr 2024 17:26:19 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, "Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	Mike Snitzer <snitzer@kernel.org>, dm-devel@lists.linux.dev,
	Mikulas Patocka <mpatocka@redhat.com>
Subject: Re: [PATCH v2 04/34] md: port block device access to file
Message-ID: <Zhzyu6pQYkSNgvuh@fedora>
References: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
 <20240123-vfs-bdev-file-v2-4-adbd023e19cc@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123-vfs-bdev-file-v2-4-adbd023e19cc@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

Hello,

On Tue, Jan 23, 2024 at 02:26:21PM +0100, Christian Brauner wrote:
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  drivers/md/dm.c               | 23 +++++++++++++----------
>  drivers/md/md.c               | 12 ++++++------
>  drivers/md/md.h               |  2 +-
>  include/linux/device-mapper.h |  2 +-
>  4 files changed, 21 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> index 8dcabf84d866..87de5b5682ad 100644
> --- a/drivers/md/dm.c
> +++ b/drivers/md/dm.c

...

> @@ -775,7 +778,7 @@ static void close_table_device(struct table_device *td, struct mapped_device *md
>  {
>  	if (md->disk->slave_dir)
>  		bd_unlink_disk_holder(td->dm_dev.bdev, md->disk);
> -	bdev_release(td->dm_dev.bdev_handle);
> +	fput(td->dm_dev.bdev_file);

The above change caused regression on 'dmsetup remove_all'.

blkdev_release() is delayed because of fput(), so dm_lock_for_deletion
returns -EBUSY, then this dm disk is skipped in remove_all().

Force to mark DMF_DEFERRED_REMOVE might solve it, but need our device
mapper guys to check if it is safe.

Or other better solution?

thanks,
Ming


