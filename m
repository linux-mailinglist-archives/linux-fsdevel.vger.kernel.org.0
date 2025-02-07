Return-Path: <linux-fsdevel+bounces-41264-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25DA3A2D052
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 23:14:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51D7D188BD5E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 22:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE03F1B87E2;
	Fri,  7 Feb 2025 22:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E2uuwQm/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F73842069
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Feb 2025 22:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738966466; cv=none; b=KdFCy4GorQd2AVFrjexmT4u1qZaXW6f5znQmnwSY75638L+slAH2is8UVD4Tsa35XhVXG5CWtZaAaRIbxDdY7as9ploWLyu5PwM7W5FFvsIQKv7hD+1weyVBbcyZz+M07XhrIYlSDhJsu5JSPw858mAeiOTzQE0Fxsa1ksa9OjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738966466; c=relaxed/simple;
	bh=v3E7aOAj1RolbZ+G8rpmqWsn67q8WYxDr1SczyjymHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZuObcAQTlOAFlOmpMfFfSLLRogABi3QiU0N3QSao79TRQXx2SuScrhLGKv/3ovWkESogGg0UVZYv5g9vazeMfQJ2GBqMQNmraItnBKep1Ar80MlkVIE9DJPnXq3cqOkNKsvdPF5uLlDju5HmhQjA6siBJIm4bupBIjuf2Yf/R2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E2uuwQm/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738966463;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5JQYDZ5jzno7rrMD91/odghBo6lSgHHkIDBVq0SzOmo=;
	b=E2uuwQm/mr1g3VqgOQiMVlMqFODlGZ9wQXuRE/fOVoJ0OqFQH+aANoDebiD17brTtOMy57
	WBA4r3Hfe/szKhynPjBy0Qqnd+OnP87HHrUwuczS0DhTCZwKRZoUWLDl6KR/i1Juefb442
	k2mQfP6HWtnQTETXnmNWzxc8N5q+QAA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-194-QyO-n5Z1MT68fscLH0adPg-1; Fri,
 07 Feb 2025 17:14:19 -0500
X-MC-Unique: QyO-n5Z1MT68fscLH0adPg-1
X-Mimecast-MFC-AGG-ID: QyO-n5Z1MT68fscLH0adPg
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 437711956095;
	Fri,  7 Feb 2025 22:14:16 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (unknown [10.6.23.247])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 56BCE1800360;
	Fri,  7 Feb 2025 22:14:14 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (localhost [127.0.0.1])
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.18.1/8.17.1) with ESMTPS id 517MEDga725105
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 7 Feb 2025 17:14:13 -0500
Received: (from bmarzins@localhost)
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.18.1/8.18.1/Submit) id 517MECmM725090;
	Fri, 7 Feb 2025 17:14:12 -0500
Date: Fri, 7 Feb 2025 17:14:12 -0500
From: Benjamin Marzinski <bmarzins@redhat.com>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, dm-devel@lists.linux.dev,
        linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, hch@lst.de, tytso@mit.edu,
        djwong@kernel.org, yi.zhang@huawei.com, chengzhihao1@huawei.com,
        yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [RFC PATCH v2 4/8] dm: add BLK_FEAT_WRITE_ZEROES_UNMAP support
Message-ID: <Z6aFtJzGWMNhILJW@redhat.com>
References: <20250115114637.2705887-1-yi.zhang@huaweicloud.com>
 <20250115114637.2705887-5-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250115114637.2705887-5-yi.zhang@huaweicloud.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Wed, Jan 15, 2025 at 07:46:33PM +0800, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> Set the BLK_FEAT_WRITE_ZEROES_UNMAP feature on stacking queue limits by
> default. This feature shall be disabled if any underlying device does
> not support it.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> ---
>  drivers/md/dm-table.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
> index bd8b796ae683..58cce31bcc1e 100644
> --- a/drivers/md/dm-table.c
> +++ b/drivers/md/dm-table.c
> @@ -598,7 +598,8 @@ int dm_split_args(int *argc, char ***argvp, char *input)
>  static void dm_set_stacking_limits(struct queue_limits *limits)
>  {
>  	blk_set_stacking_limits(limits);
> -	limits->features |= BLK_FEAT_IO_STAT | BLK_FEAT_NOWAIT | BLK_FEAT_POLL;
> +	limits->features |= BLK_FEAT_IO_STAT | BLK_FEAT_NOWAIT | BLK_FEAT_POLL |
> +			    BLK_FEAT_WRITE_ZEROES_UNMAP;
>  }
>  

dm_table_set_restrictions() can set limits->max_write_zeroes_sectors to
0, and it's called after dm_calculate_queue_limits(), which calls
blk_stack_limits(). Just to avoid having the BLK_FEAT_WRITE_ZEROES_UNMAP
still set while a device's max_write_zeroes_sectors is 0, it seems like
you would want to clear it as well if dm_table_set_restrictions() sets
limits->max_write_zeroes_sectors to 0.

-Ben

>  /*
> -- 
> 2.39.2
> 


