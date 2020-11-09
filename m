Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BCBE2AC958
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Nov 2020 00:28:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729847AbgKIX2z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Nov 2020 18:28:55 -0500
Received: from mail-wm1-f53.google.com ([209.85.128.53]:39700 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727070AbgKIX2z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Nov 2020 18:28:55 -0500
Received: by mail-wm1-f53.google.com with SMTP id s13so1198991wmh.4;
        Mon, 09 Nov 2020 15:28:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uVd85Bl4q22td+3jSMit0FtxZJ1sJtChRiPRn7GLPMw=;
        b=HmwiSpFl37ey7W+KPYX0yuTvszCkzbZPqiU2uXb6qT02LkHBR46YeEhm9srTHyhJF2
         FRS9/deJcROvz4rWp1AWoJmDeFSQbccznPh0nKBwG/zkGqXCW3fOeKxDRzDhpycI6QOo
         Xkp7YymryHYQdqkrPPqha15m0Td85ytosagMBI/DbYq0KErPYPeNriK0QKEK722VPLbZ
         0pBJObub8M+MSF+2NQuhzdhpuvBZTgdW9H22O9sbjmuPDAPRyAy5BgNFOHGYmz2bDT6Z
         2VOv+XV2Yi2cWR3JWgUzwccsUSeHdMpJthdjmXkX0NeItxwAZOEUtxCm/0Yk/mlAHsO0
         4HPA==
X-Gm-Message-State: AOAM531WI4EAudH0HhWYHlwY+eeDGMxcDgTkQF1n8zxx3HEmdg0fiyuE
        LZ/VB59ZM7ilfY22SNRc62uTFY8US70=
X-Google-Smtp-Source: ABdhPJyLfZWJAVtXVvWavay6Dkz/YKClz0bIC5QMERvUePaULd58OWlCLidmjNr2cN/ZVx4HfgINbw==
X-Received: by 2002:a7b:c2f7:: with SMTP id e23mr1575766wmk.100.1604964532362;
        Mon, 09 Nov 2020 15:28:52 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:f26a:270b:f54c:37eb? ([2601:647:4802:9070:f26a:270b:f54c:37eb])
        by smtp.gmail.com with ESMTPSA id c17sm6900728wro.19.2020.11.09.15.28.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2020 15:28:51 -0800 (PST)
Subject: Re: [PATCH 03/24] nvme: let set_capacity_revalidate_and_notify update
 the bdev size
To:     Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Justin Sanders <justin@coraid.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>,
        Minchan Kim <minchan@kernel.org>,
        Mike Snitzer <snitzer@redhat.com>, Song Liu <song@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        drbd-dev@lists.linbit.com, nbd@other.debian.org,
        ceph-devel@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20201106190337.1973127-1-hch@lst.de>
 <20201106190337.1973127-4-hch@lst.de>
 <1d06cdfa-a904-30be-f3ec-08ae2fa85cbd@suse.de>
 <20201109085340.GB27483@lst.de>
 <e79f9a96-ef53-d6ea-f6e7-e141bdd2e2d2@suse.de>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <d28042e3-3123-5dfc-d0a2-aab0012150c8@grimberg.me>
Date:   Mon, 9 Nov 2020 15:28:44 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <e79f9a96-ef53-d6ea-f6e7-e141bdd2e2d2@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


> [ .. ]
>>> Originally nvme multipath would update/change the size of the multipath
>>> device according to the underlying path devices.
>>> With this patch the size of the multipath device will _not_ change if 
>>> there
>>> is a change on the underlying devices.
>>
>> Yes, it will.  Take a close look at nvme_update_disk_info and how it is
>> called.
>>
> Okay, then: What would be the correct way of handling a size update for 
> NVMe multipath?
> Assuming we're getting an AEN for each path signalling the size change
> (or a controller reset leading to a size change).
> So if we're updating the size of the multipath device together with the 
> path device at the first AEN/reset we'll end up with the other paths 
> having a different size than the multipath device (and the path we've 
> just been updating).
> - Do we care, or cross fingers and hope for the best?
> - Shouldn't we detect the case where we won't get a size update for the 
> other paths, or, indeed, we have a genuine device size mismatch due to a 
> misconfiguration on the target?
> 
> IE shouldn't we have a flag 'size update pending' for the other paths,, 
> to take them out ouf use temporarily until the other AENs/resets have 
> been processed?

the mpath device will take the minimum size from all the paths, that is
what blk_stack_limits does. When the AEN for all the paths will arrive
the mpath size will update.

Not sure how this is different than what we have today...
