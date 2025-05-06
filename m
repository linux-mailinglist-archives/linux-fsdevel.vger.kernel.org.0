Return-Path: <linux-fsdevel+bounces-48210-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2A0AABFD0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 11:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C7FD5084DE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 09:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C87152749FA;
	Tue,  6 May 2025 09:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TA8PIWaJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB508272E5E
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 May 2025 09:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746524224; cv=none; b=U6dnSvByUeOfcsZuR3k0tg6w06W/QAgGfIjVy4b47yX0Qo9KZTsTr98ltTVHjVknhC0fjvWLPxUJEvCFLAZ5bFPHB7wsNuz6NkRLlgZqDmg7ocbH4SmHvKY92zJsubd+M3jok6U6RvVXHvaO0WRF0eJKAu/uq0Fnna8meStcgw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746524224; c=relaxed/simple;
	bh=qOiexQ/2jI3FvkKxeohCrO+0mQDIzwCnfLrg1HFKBdI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Q9xwlPgaaKGWJkurFfMiSdiQm9LeB4nnVOe4D6xoCdUCtNwy2LtNTA902Hx+ZUq8LicdOYmYsa5QaRMxp0ThwGM2y8KfoypOwHHekmKJeoyYkFm8ZNImEWm0C1zn0YfmjvqsSAKpC1Rm8Jn7UNWNei2Kj6EddR/i1sDR441+lM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TA8PIWaJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746524221;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UAL94wTpvtO/Lxptme/YwkD4oR3pyZDYuyoU5rE6q7w=;
	b=TA8PIWaJckzy4F7D2eu0SJZCSrxSLMttEpOJxVEoeGZY3SnWMV2AguFeanq9ZLx42J4u0m
	PfX6yoFbqFVCplnWN11X39mUDr2nkZ884BxjBlZsOXBzwk0X0FMTv1aVDKHfB5G33rmV6y
	HVXia6/lqoNCM44DGFszfgsx4bPaZaQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-677-3EIRxZwJPc-7FI1rkdaFGQ-1; Tue,
 06 May 2025 05:36:57 -0400
X-MC-Unique: 3EIRxZwJPc-7FI1rkdaFGQ-1
X-Mimecast-MFC-AGG-ID: 3EIRxZwJPc-7FI1rkdaFGQ_1746524214
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 11AD218009A4;
	Tue,  6 May 2025 09:36:54 +0000 (UTC)
Received: from [10.22.80.45] (unknown [10.22.80.45])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D07601956096;
	Tue,  6 May 2025 09:36:45 +0000 (UTC)
Date: Tue, 6 May 2025 11:36:39 +0200 (CEST)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Christoph Hellwig <hch@lst.de>
cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
    "Md. Haris Iqbal" <haris.iqbal@ionos.com>, 
    Jack Wang <jinpu.wang@ionos.com>, Coly Li <colyli@kernel.org>, 
    Kent Overstreet <kent.overstreet@linux.dev>, 
    Mike Snitzer <snitzer@kernel.org>, Chris Mason <clm@fb.com>, 
    Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
    Andreas Gruenbacher <agruenba@redhat.com>, 
    Carlos Maiolino <cem@kernel.org>, Damien Le Moal <dlemoal@kernel.org>, 
    Naohiro Aota <naohiro.aota@wdc.com>, Johannes Thumshirn <jth@kernel.org>, 
    "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, 
    slava@dubeyko.com, glaubitz@physik.fu-berlin.de, frank.li@vivo.com, 
    linux-bcache@vger.kernel.org, dm-devel@lists.linux.dev, 
    linux-btrfs@vger.kernel.org, gfs2@lists.linux.dev, 
    linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, 
    linux-pm@vger.kernel.org, Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH 13/19] dm-bufio: use bio_add_virt_nofail
In-Reply-To: <20250430212159.2865803-14-hch@lst.de>
Message-ID: <c3120875-2f14-19ec-504b-4ea55279a386@redhat.com>
References: <20250430212159.2865803-1-hch@lst.de> <20250430212159.2865803-14-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17



On Wed, 30 Apr 2025, Christoph Hellwig wrote:

> Convert the __bio_add_page(..., virt_to_page(), ...) pattern to the
> bio_add_virt_nofail helper implementing it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Acked-by: Mikulas Patocka <mpatocka@redhat.com>

> ---
>  drivers/md/dm-bufio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/md/dm-bufio.c b/drivers/md/dm-bufio.c
> index 9c8ed65cd87e..e82cd5dc83ce 100644
> --- a/drivers/md/dm-bufio.c
> +++ b/drivers/md/dm-bufio.c
> @@ -1362,7 +1362,7 @@ static void use_bio(struct dm_buffer *b, enum req_op op, sector_t sector,
>  	ptr = (char *)b->data + offset;
>  	len = n_sectors << SECTOR_SHIFT;
>  
> -	__bio_add_page(bio, virt_to_page(ptr), len, offset_in_page(ptr));
> +	bio_add_virt_nofail(bio, ptr, len);
>  
>  	submit_bio(bio);
>  }
> -- 
> 2.47.2
> 
> 


