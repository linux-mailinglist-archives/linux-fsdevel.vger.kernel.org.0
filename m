Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE5E539FA02
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jun 2021 17:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233807AbhFHPKe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Jun 2021 11:10:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54976 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233763AbhFHPKe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Jun 2021 11:10:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623164921;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5hU1CMqJ4P0JXH4l8c0cSd/V5cHxhvWTupYmzCD3I2c=;
        b=eHKYetZzBvkRk5/U4/7DzBGz19n0at81HsLEzRpYZiePqQ4bQRKlCBrmKwwfGCu/Cf4KGa
        +nFVQayPnVgamHujB/wkNM3QjgYeGJ0dGxnLZV884TZ8Mi+2L9SrOR3d6DSRinUbNxcyNW
        Z9PoNKaeJCK1ZEUU1oD9h07pzbB44Eo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-8o7YCo4qOSqcCisDR4pUQg-1; Tue, 08 Jun 2021 11:08:39 -0400
X-MC-Unique: 8o7YCo4qOSqcCisDR4pUQg-1
Received: by mail-wr1-f71.google.com with SMTP id u5-20020adf9e050000b029010df603f280so9567433wre.18
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Jun 2021 08:08:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=5hU1CMqJ4P0JXH4l8c0cSd/V5cHxhvWTupYmzCD3I2c=;
        b=U4YrZyEjDU5nn38GctSksSI2bZw6B/hyTJF2WxLlSpPkFbZ0BqLnLqoI9k0F5SpTnO
         ewu+LMMb6y2BD/vB6aCQTDJXub3RxiQkxqxvIEOcT3DgI+naPgJYjdoXaP/R3prHbp2t
         tN5xHHxcggj67BMtouPzrLcQ0VUwmM+gTyl0hgYiei6i4QNEFeUYTW2/k5c95R41VpFj
         766HS+LJphohZJJQ8riAeiq+wyqXEz4btala1M+tD0d7wIYvuXtcAYwpjhhZfnfrELUa
         Do1G99q2vhf9rIDpBOZyyTIllE0Q5l3eoUVDANKx2ydurjI/jd86coh7J3QYfr1Xii/g
         uOiQ==
X-Gm-Message-State: AOAM531k+3t0zKgwBrb+zme5TpNIOjk94St4HR8Qx4QvXJwokdQyhfe2
        3Q5wM4ukZ2ptNmpH1+XvUgw4zZhtHktGn+hlT2Nh2ShbzDIiOiKqY536Jo71dX6UgmzA18Lj/FN
        yW+Y46D5MHJ52yrQA4LCzCH5WTQ==
X-Received: by 2002:a1c:7c13:: with SMTP id x19mr4818692wmc.96.1623164918482;
        Tue, 08 Jun 2021 08:08:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJziiUeOeVRaBQHznAWmWWEt/KVEstO5XqQa3xElfZkGfdt3L++vaw8Vnidve53mT64ljzbqQA==
X-Received: by 2002:a1c:7c13:: with SMTP id x19mr4818667wmc.96.1623164918286;
        Tue, 08 Jun 2021 08:08:38 -0700 (PDT)
Received: from dresden.str.redhat.com ([2a02:908:1e46:160:b272:8083:d5:bc7d])
        by smtp.gmail.com with ESMTPSA id n1sm10560444wms.18.2021.06.08.08.08.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jun 2021 08:08:37 -0700 (PDT)
Subject: Re: [PATCH v2 2/7] fuse: Fix crash if superblock of submount gets
 killed early
To:     Greg Kurz <groug@kaod.org>, Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        virtio-fs@redhat.com, Vivek Goyal <vgoyal@redhat.com>
References: <20210604161156.408496-1-groug@kaod.org>
 <20210604161156.408496-3-groug@kaod.org>
From:   Max Reitz <mreitz@redhat.com>
Message-ID: <0daa30dc-ea49-dbe3-eac5-4b47dceb54eb@redhat.com>
Date:   Tue, 8 Jun 2021 17:08:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210604161156.408496-3-groug@kaod.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 04.06.21 18:11, Greg Kurz wrote:
> As soon as fuse_dentry_automount() does up_write(&sb->s_umount), the
> superblock can theoretically be killed. If this happens before the
> submount was added to the &fc->mounts list, fuse_mount_remove() later
> crashes in list_del_init() because it assumes the submount to be
> already there.
>
> Add the submount before dropping sb->s_umount to fix the inconsistency.
> It is okay to nest fc->killsb under sb->s_umount, we already do this
> on the ->kill_sb() path.
>
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>   fs/fuse/dir.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>

