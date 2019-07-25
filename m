Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99C777578C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2019 21:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbfGYTFw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Jul 2019 15:05:52 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:35167 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbfGYTFw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Jul 2019 15:05:52 -0400
Received: by mail-ot1-f68.google.com with SMTP id j19so14313098otq.2;
        Thu, 25 Jul 2019 12:05:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Vw35ctnHAyiweCYFIr8Q5tQ1sCTMUrzhYWyZVMQ2srE=;
        b=PfoBHShhlyrT2DkUHewHf0gjDwYJ6MWQCgL3warjeUrra/7DhqZN+5v40UA2hu2Q9J
         goQvRrNZUSB6Q0H0nmF9cBD5+iZohXVb+2UxFOo5E1hR+gxkxOl5XaFP0dgPHRjcLPs1
         nSx9xplYcuBw6NB96XrgErw/vxIB+qDm6uL2srJYG0Iu2hdheYEYfA7o67orzqwmLZl8
         kY/qO38Tp15EWHneKN3SqykJCTF5qJnpAW6Tbeb4p+sxijOHZSpNRrWQwx3anEOyiZg1
         8gXj3hKuyQGJiOZAFsLDL1ssQ7KrwCu9PUeBiENubKIvaib/FMgxJxSt7htoDalXxLso
         GF+w==
X-Gm-Message-State: APjAAAWL4bIqu9CJ1/UeQIOz78or3rKv5B6BTD0/bAd2gtRY6l0AZe2j
        zkn1TuiWFiyyQn8M5rvoBag=
X-Google-Smtp-Source: APXvYqxh1xWV9l7hAx0RUdcnZmU1/Ak8tJk9mtOSSnUmKXjlKYymH3LgZ+g4WSGFfklKTPeVE93P7A==
X-Received: by 2002:a9d:7:: with SMTP id 7mr68886666ota.248.1564081550962;
        Thu, 25 Jul 2019 12:05:50 -0700 (PDT)
Received: from [192.168.1.114] (162-195-240-247.lightspeed.sntcca.sbcglobal.net. [162.195.240.247])
        by smtp.gmail.com with ESMTPSA id u16sm16785232otk.46.2019.07.25.12.05.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jul 2019 12:05:50 -0700 (PDT)
Subject: Re: [PATCH v6 02/16] chardev: introduce cdev_get_by_path()
To:     Matthew Wilcox <willy@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jens Axboe <axboe@fb.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        Stephen Bates <sbates@raithlin.com>,
        linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Max Gurtovoy <maxg@mellanox.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Christoph Hellwig <hch@lst.de>
References: <20190725172335.6825-1-logang@deltatee.com>
 <20190725172335.6825-3-logang@deltatee.com>
 <20190725174032.GA27818@kroah.com>
 <682ff89f-04e0-7a94-5aeb-895ac65ee7c9@deltatee.com>
 <20190725180816.GA32305@kroah.com>
 <da0eacb7-3738-ddf3-8c61-7ffc61aa41f4@deltatee.com>
 <20190725182701.GA11547@kroah.com>
 <20190725190024.GD30641@bombadil.infradead.org>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <27943e06-a503-162e-356b-abb9e106ab2e@grimberg.me>
Date:   Thu, 25 Jul 2019 12:05:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190725190024.GD30641@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


>>> NVMe-OF is configured using configfs. The target is specified by the
>>> user writing a path to a configfs attribute. This is the way it works
>>> today but with blkdev_get_by_path()[1]. For the passthru code, we need
>>> to get a nvme_ctrl instead of a block_device, but the principal is the same.
>>
>> Why isn't a fd being passed in there instead of a random string?
> 
> I suppose we could echo a string of the file descriptor number there,
> and look up the fd in the process' file descriptor table ...

Assuming that there is a open handle somewhere out there...

> I'll get my coat.

Grab mine too..
