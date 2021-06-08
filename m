Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53DD039FA97
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jun 2021 17:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232250AbhFHP1z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Jun 2021 11:27:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50802 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233162AbhFHP10 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Jun 2021 11:27:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623165932;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Br1rr7QBQj6YS5zJZEG2ZfZMvTHbAXZUz7RdIVHg2ZE=;
        b=QlwGOHE77Gmj7GZS2CnyKE1OXoaP/lB3tdU4QUGzCW6KtwWReNgwCU935RCVfaFKxl1Lq/
        0aJgI3IF9j1lC3u3TReCkMNzpCA+cTATwIFxyz7A5lbocfn2CGrl3qmGCOhxoNfrMVP6zN
        W+jVzI/gU7BKBGWAJAiEQavot7IJ7cI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-276-xz9k_o5HNGuSQan4zYZwrg-1; Tue, 08 Jun 2021 11:25:31 -0400
X-MC-Unique: xz9k_o5HNGuSQan4zYZwrg-1
Received: by mail-wr1-f70.google.com with SMTP id f22-20020a5d58f60000b029011634e39889so9564665wrd.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Jun 2021 08:25:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Br1rr7QBQj6YS5zJZEG2ZfZMvTHbAXZUz7RdIVHg2ZE=;
        b=jy7/NVaHZUglMiJUCvwUADzmfVtkYjwHu2kQWAurW4GAw8yKMQqZ8q8gbH3X9rBCOD
         cF0D5ae6n00v/Frmmas+wclZ/EbIjJCnQzcmLD/h9lsbjTnRek9LqORNTl/oadY8AAkE
         iOHrbW6ubM9ZRFqRESHVlZcbZpIUWV3Wtstr5J/v82KvoDDxYtLV5kul8Gnya8yi67gM
         cSqRHQcRnRkEYQm/7Ns/Tq+hPuFCqrOzGuwJuBJcC8/gq8x02O5Xq4CcL6BTsvfrqyIu
         pII8u9HdHCK+gfmVghlDBytzyuF92aQTZ2Hx1cE+Z7T80ktZYrGeM0g7e3DViIAN+VAp
         R4+A==
X-Gm-Message-State: AOAM531BP4EIrox/4hDDzOwWBiGMU4hhLQDj7jNIm6LLqMMSSHu176el
        /7ugOtX/4psg6+O08CKsoaMbWPCoLoVO36JVm2a45st4PHZjHLJqGzCQjLXL37EjyuqDtW4DhoX
        5WiBxOHwE7cHJ7bG5Pe/fL3gcWg==
X-Received: by 2002:adf:f207:: with SMTP id p7mr17509462wro.275.1623165930407;
        Tue, 08 Jun 2021 08:25:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwmC1Lyls5BEV3cQOjm5iHNO4inyBWR7jW6utYjAybKyvaHNOJsr9hBv2b5dFrZgWVD7tUMVA==
X-Received: by 2002:adf:f207:: with SMTP id p7mr17509455wro.275.1623165930303;
        Tue, 08 Jun 2021 08:25:30 -0700 (PDT)
Received: from dresden.str.redhat.com ([2a02:908:1e46:160:b272:8083:d5:bc7d])
        by smtp.gmail.com with ESMTPSA id b188sm4379485wmh.18.2021.06.08.08.25.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jun 2021 08:25:30 -0700 (PDT)
Subject: Re: [PATCH v2 4/7] fuse: Add dedicated filesystem context ops for
 submounts
To:     Greg Kurz <groug@kaod.org>, Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        virtio-fs@redhat.com, Vivek Goyal <vgoyal@redhat.com>
References: <20210604161156.408496-1-groug@kaod.org>
 <20210604161156.408496-5-groug@kaod.org>
From:   Max Reitz <mreitz@redhat.com>
Message-ID: <233b722a-4794-6905-f9d9-c0445ae24812@redhat.com>
Date:   Tue, 8 Jun 2021 17:25:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210604161156.408496-5-groug@kaod.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 04.06.21 18:11, Greg Kurz wrote:
> The creation of a submount is open-coded in fuse_dentry_automount().
> This brings a lot of complexity and we recently had to fix bugs
> because we weren't setting SB_BORN or because we were unlocking
> sb->s_umount before sb was fully configured. Most of these could
> have been avoided by using the mount API instead of open-coding.
>
> Basically, this means coming up with a proper ->get_tree()
> implementation for submounts and call vfs_get_tree(), or better
> fc_mount().
>
> The creation of the superblock for submounts is quite different from
> the root mount. Especially, it doesn't require to allocate a FUSE
> filesystem context, nor to parse parameters.
>
> Introduce a dedicated context ops for submounts to make this clear.
> This is just a placeholder for now, fuse_get_tree_submount() will
> be populated in a subsequent patch.
>
> Only visible change is that we stop allocating/freeing a useless FUSE
> filesystem context with submounts.
>
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>   fs/fuse/fuse_i.h    |  5 +++++
>   fs/fuse/inode.c     | 16 ++++++++++++++++
>   fs/fuse/virtio_fs.c |  3 +++
>   3 files changed, 24 insertions(+)

Reviewed-by: Max Reitz <mreitz@redhat.com>

