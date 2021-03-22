Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2B0343759
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Mar 2021 04:23:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbhCVDWy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 21 Mar 2021 23:22:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43083 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229548AbhCVDWe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 21 Mar 2021 23:22:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616383354;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7CxCPTphkLxAAe7WrRHdqu9Vis3F0z32vdPzkrtEuSY=;
        b=GufCd1dNYOpqWzTuuAu+4dB+N1OaMWECKmPEss8gbicA7XrI+CZc/1FjqAvbFgB7Sw4ZZy
        R7f4SvkY/V3DyLXyoCDDti6uNyfl41DBy5rKRAXyFz9ur5qeuXbgHcgrl1FKhcMzhUAVEf
        712+K/mbmtpy8iqkBl8qlAVK0HUIkEw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250-iZsFkDiAOR6s_9WODNEMaw-1; Sun, 21 Mar 2021 23:22:32 -0400
X-MC-Unique: iZsFkDiAOR6s_9WODNEMaw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 646D8180FCA8;
        Mon, 22 Mar 2021 03:22:30 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-188.pek2.redhat.com [10.72.13.188])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 046675F9C9;
        Mon, 22 Mar 2021 03:22:16 +0000 (UTC)
Subject: Re: [PATCH 1/3] virtio_ring: always warn when descriptor chain
 exceeds queue size
To:     Connor Kuehl <ckuehl@redhat.com>, virtio-fs@redhat.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, stefanha@redhat.com,
        vgoyal@redhat.com, miklos@szeredi.hu, mst@redhat.com
References: <20210318135223.1342795-1-ckuehl@redhat.com>
 <20210318135223.1342795-2-ckuehl@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <fa4988fa-a671-0abf-f922-6b362faf10d5@redhat.com>
Date:   Mon, 22 Mar 2021 11:22:15 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210318135223.1342795-2-ckuehl@redhat.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


ÔÚ 2021/3/18 ÏÂÎç9:52, Connor Kuehl Ð´µÀ:
>  From section 2.6.5.3.1 (Driver Requirements: Indirect Descriptors)
> of the virtio spec:
>
>    "A driver MUST NOT create a descriptor chain longer than the Queue
>    Size of the device."
>
> This text suggests that the warning should trigger even if
> indirect descriptors are in use.


So I think at least the commit log needs some tweak.

For split virtqueue. We had:

2.6.5.2 Driver Requirements: The Virtqueue Descriptor Table

Drivers MUST NOT add a descriptor chain longer than 2^32 bytes in total; 
this implies that loops in the descriptor chain are forbidden!

2.6.5.3.1 Driver Requirements: Indirect Descriptors

A driver MUST NOT create a descriptor chain longer than the Queue Size 
of the device.

If I understand the spec correctly, the check is only needed for a 
single indirect descriptor table?

For packed virtqueue. We had:

2.7.17 Driver Requirements: Scatter-Gather Support

A driver MUST NOT create a descriptor list longer than allowed by the 
device.

A driver MUST NOT create a descriptor list longer than the Queue Size.

2.7.19 Driver Requirements: Indirect Descriptors

A driver MUST NOT create a descriptor chain longer than allowed by the 
device.

So it looks to me the packed part is fine.

Note that if I understand the spec correctly 2.7.17 implies 2.7.19.

Thanks


>
> Reported-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Connor Kuehl <ckuehl@redhat.com>
> ---
>   drivers/virtio/virtio_ring.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 71e16b53e9c1..1bc290f9ba13 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -444,11 +444,12 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
>   
>   	head = vq->free_head;
>   
> +	WARN_ON_ONCE(total_sg > vq->split.vring.num);
> +
>   	if (virtqueue_use_indirect(_vq, total_sg))
>   		desc = alloc_indirect_split(_vq, total_sg, gfp);
>   	else {
>   		desc = NULL;
> -		WARN_ON_ONCE(total_sg > vq->split.vring.num && !vq->indirect);
>   	}
>   
>   	if (desc) {
> @@ -1118,6 +1119,8 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
>   
>   	BUG_ON(total_sg == 0);
>   
> +	WARN_ON_ONCE(total_sg > vq->packed.vring.num);
> +
>   	if (virtqueue_use_indirect(_vq, total_sg))
>   		return virtqueue_add_indirect_packed(vq, sgs, total_sg,
>   				out_sgs, in_sgs, data, gfp);
> @@ -1125,8 +1128,6 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
>   	head = vq->packed.next_avail_idx;
>   	avail_used_flags = vq->packed.avail_used_flags;
>   
> -	WARN_ON_ONCE(total_sg > vq->packed.vring.num && !vq->indirect);
> -
>   	desc = vq->packed.vring.desc;
>   	i = head;
>   	descs_used = total_sg;

