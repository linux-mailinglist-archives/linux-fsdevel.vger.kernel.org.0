Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3741839FA14
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jun 2021 17:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233800AbhFHPO1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Jun 2021 11:14:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59935 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233804AbhFHPOM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Jun 2021 11:14:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623165139;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ma+Y7/rVHYJ+wDRQx2MNgyshZEcsANdp8Rhdd7Nu3l0=;
        b=Be1pwe75o1KouOvyIaHgydJ3Gpwskh0hJJS8dMCao7DVXZzBNj2CQ7k2dAFvwfISnr9OlQ
        J/WVvED34GYymrw1X9q+OKbZJ4sRvF5J4Wcc5zWXr/vFFWLNmmF3OAbk9p3TgNFLgV+gpJ
        hEXRqckKIu+YY2cQNlV7v5TAFLZIgYI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-295-BimQGKkNNpy-CMAV0RZxHg-1; Tue, 08 Jun 2021 11:12:18 -0400
X-MC-Unique: BimQGKkNNpy-CMAV0RZxHg-1
Received: by mail-wm1-f70.google.com with SMTP id v25-20020a1cf7190000b0290197a4be97b7so866384wmh.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Jun 2021 08:12:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Ma+Y7/rVHYJ+wDRQx2MNgyshZEcsANdp8Rhdd7Nu3l0=;
        b=ZZNFX0o21+4NqjiswafLyZMT1oGyr+FqoXyk39uAyZ+/vC5tH6opRn8j1pakK34q6F
         xJXKI/jr4i59+4ek8EKdp7VN5dwlYiv21f+84Iv4SfzDbH5l38AgQFud79hUwbNB80nm
         GQ3cq2DkXXTBMHsgbBY7rAmlBWEidW0ETMyu5H5VBSMB7ldyziJwrI52V+9zpYwwNde3
         y9hYfCv0Moazx2JT/Fj5HbmjkMVt0o+fLZOFrpTZx6lDRyZID/LRSOOz3193bi4zdCXK
         9Ib2yXkTvSt8Ol/qRh2VF003OkkfMcmks2QktdX3jUZGq2U5tFYRpVMyijCR4s160pUN
         rZRQ==
X-Gm-Message-State: AOAM531CNa+OUXnPga31FeCTodkTk6dfUUe54JRa4lGMu4NubZZJX5Lx
        3KAjpx9wsV+VVEpCXRr6INbD4d8Q9BM8RfcidZtZNFAZaZkp3ur3POL3P4fF41DnxMLNld0im1T
        idR1vj6USILDwjWeqeZtAnUnHLw==
X-Received: by 2002:adf:f28b:: with SMTP id k11mr22343314wro.89.1623165136964;
        Tue, 08 Jun 2021 08:12:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwAPeOeqX15noJQRyOaa2NEx/vRR2eMPJsfDOGcNDSbualMJ4uzJxyHFbfEx0XnIoGz8rW2pA==
X-Received: by 2002:adf:f28b:: with SMTP id k11mr22343295wro.89.1623165136814;
        Tue, 08 Jun 2021 08:12:16 -0700 (PDT)
Received: from dresden.str.redhat.com ([2a02:908:1e46:160:b272:8083:d5:bc7d])
        by smtp.gmail.com with ESMTPSA id f14sm19791658wry.40.2021.06.08.08.12.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jun 2021 08:12:16 -0700 (PDT)
Subject: Re: [PATCH v2 3/7] fuse: Fix infinite loop in sget_fc()
To:     Greg Kurz <groug@kaod.org>, Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        virtio-fs@redhat.com, Vivek Goyal <vgoyal@redhat.com>,
        stable@vger.kernel.org
References: <20210604161156.408496-1-groug@kaod.org>
 <20210604161156.408496-4-groug@kaod.org>
From:   Max Reitz <mreitz@redhat.com>
Message-ID: <1fc488d8-91b8-9613-8127-a8b34ddb4744@redhat.com>
Date:   Tue, 8 Jun 2021 17:12:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210604161156.408496-4-groug@kaod.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 04.06.21 18:11, Greg Kurz wrote:
> We don't set the SB_BORN flag on submounts. This is wrong as these
> superblocks are then considered as partially constructed or dying
> in the rest of the code and can break some assumptions.
>
> One such case is when you have a virtiofs filesystem with submounts
> and you try to mount it again : virtio_fs_get_tree() tries to obtain
> a superblock with sget_fc(). The logic in sget_fc() is to loop until
> it has either found an existing matching superblock with SB_BORN set
> or to create a brand new one. It is assumed that a superblock without
> SB_BORN is transient and the loop is restarted. Forgetting to set
> SB_BORN on submounts hence causes sget_fc() to retry forever.
>
> Setting SB_BORN requires special care, i.e. a write barrier for
> super_cache_count() which can check SB_BORN without taking any lock.
> We should call vfs_get_tree() to deal with that but this requires
> to have a proper ->get_tree() implementation for submounts, which
> is a bigger piece of work. Go for a simple bug fix in the meatime.
>
> Fixes: bf109c64040f ("fuse: implement crossmounts")
> Cc: mreitz@redhat.com
> Cc: stable@vger.kernel.org # v5.10+
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>   fs/fuse/dir.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)

Reviewed-by: Max Reitz <mreitz@redhat.com>

