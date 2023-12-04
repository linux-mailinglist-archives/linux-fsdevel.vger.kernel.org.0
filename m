Return-Path: <linux-fsdevel+bounces-4719-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D1163802A54
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 03:32:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7157AB207BF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 02:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D716D9444
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 02:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zz2sqq8U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01153CB
	for <linux-fsdevel@vger.kernel.org>; Sun,  3 Dec 2023 18:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701657037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tJPC9DmNEur0ykkO9N98kEn1eLUMAn1MYmT0jUvM8c4=;
	b=Zz2sqq8UORu8HIOJZrBsHzPPiH8tI1dLXYyxkkP1LWA5rK3sqCedXev6girFVqisJCblS0
	qghYx2ibX8fMeAz9ASv24jrcmyxBRGDXfIkWt9j8jA34Kl8g9bNEJ6nP1H4JU0rFqUFZx2
	VUmGqpQoLpuaM68m7r8rVvnCqs0rSwI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-kyPI3YZUPXWYIekSdoIZ4Q-1; Sun, 03 Dec 2023 21:30:32 -0500
X-MC-Unique: kyPI3YZUPXWYIekSdoIZ4Q-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 384798007B3;
	Mon,  4 Dec 2023 02:30:31 +0000 (UTC)
Received: from fedora (unknown [10.72.120.8])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 1AF4A492BFE;
	Mon,  4 Dec 2023 02:30:18 +0000 (UTC)
Date: Mon, 4 Dec 2023 10:30:14 +0800
From: Ming Lei <ming.lei@redhat.com>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org,
	chandan.babu@oracle.com, dchinner@redhat.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
	linux-api@vger.kernel.org, ming.lei@redhat.com
Subject: Re: [PATCH 10/21] block: Add fops atomic write support
Message-ID: <ZW05th/c0sNbM2Zf@fedora>
References: <20230929102726.2985188-1-john.g.garry@oracle.com>
 <20230929102726.2985188-11-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230929102726.2985188-11-john.g.garry@oracle.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

On Fri, Sep 29, 2023 at 10:27:15AM +0000, John Garry wrote:
> Add support for atomic writes, as follows:
> - Ensure that the IO follows all the atomic writes rules, like must be
>   naturally aligned
> - Set REQ_ATOMIC
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  block/fops.c | 42 +++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 41 insertions(+), 1 deletion(-)
> 
> diff --git a/block/fops.c b/block/fops.c
> index acff3d5d22d4..516669ad69e5 100644
> --- a/block/fops.c
> +++ b/block/fops.c
> @@ -41,6 +41,29 @@ static bool blkdev_dio_unaligned(struct block_device *bdev, loff_t pos,
>  		!bdev_iter_is_aligned(bdev, iter);
>  }
>  
> +static bool blkdev_atomic_write_valid(struct block_device *bdev, loff_t pos,
> +			      struct iov_iter *iter)
> +{
> +	unsigned int atomic_write_unit_min_bytes =
> +			queue_atomic_write_unit_min_bytes(bdev_get_queue(bdev));
> +	unsigned int atomic_write_unit_max_bytes =
> +			queue_atomic_write_unit_max_bytes(bdev_get_queue(bdev));
> +
> +	if (!atomic_write_unit_min_bytes)
> +		return false;

The above check should have be moved to limit setting code path.

> +	if (pos % atomic_write_unit_min_bytes)
> +		return false;
> +	if (iov_iter_count(iter) % atomic_write_unit_min_bytes)
> +		return false;
> +	if (!is_power_of_2(iov_iter_count(iter)))
> +		return false;
> +	if (iov_iter_count(iter) > atomic_write_unit_max_bytes)
> +		return false;
> +	if (pos % iov_iter_count(iter))
> +		return false;

I am a bit confused about relation between atomic_write_unit_max_bytes and
atomic_write_max_bytes.

Here the max IO length is limited to be <= atomic_write_unit_max_bytes,
so looks userspace can only submit IO with write-atomic-unit naturally
aligned IO(such as, 4k, 8k, 16k, 32k, ...), but these user IOs are
allowed to be merged to big one if naturally alignment is respected and
the merged IO size is <= atomic_write_max_bytes.

Is my understanding right? If yes, I'd suggest to document the point,
and the last two checks could be change to:

	/* naturally aligned */
	if (pos % iov_iter_count(iter))
		return false;

	if (iov_iter_count(iter) > atomic_write_max_bytes)
		return false;

Thanks, 
Ming


