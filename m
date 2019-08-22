Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 167A89884E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2019 02:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728412AbfHVAJa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Aug 2019 20:09:30 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39564 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbfHVAJa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Aug 2019 20:09:30 -0400
Received: by mail-wm1-f65.google.com with SMTP id i63so3872834wmg.4;
        Wed, 21 Aug 2019 17:09:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=32/0yIVdzlJ2KJ3NplTUO5+v34KMaLLDclpZ7tzJ9aE=;
        b=XFklBSV1ROpQHezo5lCXW6jYtyDmA7+IaKiARuK6gJadBKQ6t9IsUF+lJHd3ctp6DR
         EG9mWqQgn35EdGLTGl2lsrVOh/JLzYrLDLZD4GH2jgI6l4slYeDi9js90BlNdDOxLX4l
         2l1zjaGglt+QzvERRNqy+Ftw9z7BmxC7p2/Dfm/wUzLn0bWSB+Y/9/Ja2IPFzH5b+JZL
         sn3ZbwzZLEe8ErXiSEgU4cUm5iY7/RoMaTHp3f2OOVoRr15iiHpHjqlqHSApm5jWi9dC
         j7OWRhx7f2Om+zpynK3XovyzQYaU48ZlwKJuAHQtJIqQxgyAkpKFOtxN9HOiwFkHCroJ
         0s6A==
X-Gm-Message-State: APjAAAVANRDHLtpelZYVXCO4luEWska1FhKRGHLuri9D6M30WGm+UEBu
        NWZSF7ZrUKT4zRpV3yUyrbY=
X-Google-Smtp-Source: APXvYqwuT0kmih8HKsX3ht5823hsz+gh7dNnKBV5RVKrdbL46NznsoXAK7FHnNlGyRd4vEhe81JUTw==
X-Received: by 2002:a1c:2314:: with SMTP id j20mr2598763wmj.152.1566432568173;
        Wed, 21 Aug 2019 17:09:28 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id r16sm50444348wrc.81.2019.08.21.17.09.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Aug 2019 17:09:27 -0700 (PDT)
Subject: Re: [PATCH v7 08/14] nvmet-core: allow one host per passthru-ctrl
To:     Max Gurtovoy <maxg@mellanox.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Stephen Bates <sbates@raithlin.com>, Jens Axboe <axboe@fb.com>,
        Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
References: <20190801234514.7941-1-logang@deltatee.com>
 <20190801234514.7941-9-logang@deltatee.com>
 <05a74e81-1dbd-725f-1369-5ca5c5918db1@mellanox.com>
 <a6b9db95-a7f0-d1f6-1fa2-8dc13a6aa29e@deltatee.com>
 <5717f515-e051-c420-07b7-299bcfcd1f32@mellanox.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <b0921c72-93f1-f67a-c4b3-31baeb1c39cb@grimberg.me>
Date:   Wed, 21 Aug 2019 17:09:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <5717f515-e051-c420-07b7-299bcfcd1f32@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


> I don't understand why we don't limit a regular ctrl to single access 
> and we do it for the PT ctrl.
> 
> I guess the block layer helps to sync between multiple access in 
> parallel but we can do it as well.
> 
> Also, let's say you limit the access to this subsystem to 1 user, the 
> bdev is still accessibly for local user and also you can create a 
> different subsystem that will use this device (PT and non-PT ctrl).
> 
> Sagi,
> 
> can you explain the trouble you meant and how this limitation solve it ?

Its different to emulate the controller with all its admin
commands vs. passing it through to the nvme device.. (think of format nvm)



