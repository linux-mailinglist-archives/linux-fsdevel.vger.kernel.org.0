Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78ED275783
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2019 21:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbfGYTCt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Jul 2019 15:02:49 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:42920 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbfGYTCt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Jul 2019 15:02:49 -0400
Received: by mail-oi1-f194.google.com with SMTP id s184so38449963oie.9;
        Thu, 25 Jul 2019 12:02:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=y/lTIw6bVEla4w+tYy+il+kwWC5SN/IC6++JTH0QKCo=;
        b=PJoCok8QV2e46x2XG1QqtuQQstlZ11HOZ2gucwQK1IezRv2Zqhl4IrFNaaRgbT6cqf
         JK1vncfKI8QT3n6cT0pkDaYOMXc2ytkS0hl45YEGt4X7ZvjnnZTCkw8enTp1doB87mru
         X7Skqm/Nuqq7nhIHrm7ZZsyxxw/++ZZR4Zdkvj7nQ8bm8NiYviCRsisqa7A05Fr6IRV/
         M12KVjkEQy2O7sjpWRmByUvKbNspmcyB8hwEtY3/O2vxuO3l0diYAEAM+OKEyOdRR1Hd
         ev7s5FoHmFAtDQYbdFxxV1bN/MvIfSsJzW9bqgPJ83eZX1CGe1M/uKye0nArJSi7KnsQ
         hApA==
X-Gm-Message-State: APjAAAX9XL2rraFXO0LV/MVZfA5hvQy93H6Tjt9ArUyAwHLpDvPNQqW+
        CIy+3sTbn19IpfADjjdZfYQ=
X-Google-Smtp-Source: APXvYqzIpG+WlfbxIbSb9LlcTd3JD9DVuRkzugImR9DbDnonCa38Ce1KoYRVxInrHY006f71VNok+g==
X-Received: by 2002:aca:90d:: with SMTP id 13mr46807463oij.126.1564081368153;
        Thu, 25 Jul 2019 12:02:48 -0700 (PDT)
Received: from [192.168.1.114] (162-195-240-247.lightspeed.sntcca.sbcglobal.net. [162.195.240.247])
        by smtp.gmail.com with ESMTPSA id p2sm16744895otl.59.2019.07.25.12.02.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jul 2019 12:02:47 -0700 (PDT)
Subject: Re: [PATCH v6 02/16] chardev: introduce cdev_get_by_path()
To:     Logan Gunthorpe <logang@deltatee.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Stephen Bates <sbates@raithlin.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
References: <20190725172335.6825-1-logang@deltatee.com>
 <20190725172335.6825-3-logang@deltatee.com>
 <20190725174032.GA27818@kroah.com>
 <682ff89f-04e0-7a94-5aeb-895ac65ee7c9@deltatee.com>
 <20190725180816.GA32305@kroah.com>
 <da0eacb7-3738-ddf3-8c61-7ffc61aa41f4@deltatee.com>
 <20190725182701.GA11547@kroah.com>
 <a3262a7f-b78e-05ba-cda3-a7587946bd91@deltatee.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <5951e0f5-cc90-f3de-0083-088fecfd43bb@grimberg.me>
Date:   Thu, 25 Jul 2019 12:02:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <a3262a7f-b78e-05ba-cda3-a7587946bd91@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


>>>> Why do you have a "string" within the kernel and are not using the
>>>> normal open() call from userspace on the character device node on the
>>>> filesystem in your namespace/mount/whatever?
>>>
>>> NVMe-OF is configured using configfs. The target is specified by the
>>> user writing a path to a configfs attribute. This is the way it works
>>> today but with blkdev_get_by_path()[1]. For the passthru code, we need
>>> to get a nvme_ctrl instead of a block_device, but the principal is the same.
>>
>> Why isn't a fd being passed in there instead of a random string?
> 
> I wouldn't know the answer to this but I assume because once we decided
> to use configfs, there was no way for the user to pass the kernel an fd.

That's definitely not changing. But this is not different than how we
use the block device or file configuration, this just happen to need the
nvme controller chardev now to issue I/O.
