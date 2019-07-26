Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2AF75DD1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2019 06:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726043AbfGZE3n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Jul 2019 00:29:43 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42368 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbfGZE3n (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Jul 2019 00:29:43 -0400
Received: by mail-pl1-f195.google.com with SMTP id ay6so24281363plb.9;
        Thu, 25 Jul 2019 21:29:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rIhtYBAd0ZZLe9n3b3Z0c0rQPCJrZwUCsuW99j3TPW0=;
        b=mxV7PiMoJwWfGsfJthExu2EHCQn7FkBbwSjEc5iaRGNbbiL/9osbhwaFm884EucjGy
         dTF8PEKlWrhW4rShPHy8XHGnyONrttwha9r/Gxwk8XfEzhFOkz9r9XgjJvnJsHdKjnaH
         goBBOaXer60ebpmxdW3j3dVXpEDWc2F4pHqUXcWvJhZsIl6v/aKmFKsi8QpnOakCHxSF
         Dc4p0yo2mb6JBJ4RAqn7wiHRsKbQTw+ZfvLqfW3SVRYhDsDdKEHYWxF3Dl2Ia4RQ/1dF
         WPdyUlTrfG5cM96KR1hvFEQPHNmWVNc6RNsk68TicHUN2/8r7EDCY/Tbi3XLWj1fH6k6
         OEqw==
X-Gm-Message-State: APjAAAXPH4rUDkxRP4YovkArZkiMFjz6mQWp3ytIz4WupZT9ys4a3E1k
        me+nQFZI9CdJxuildc+w/2o=
X-Google-Smtp-Source: APXvYqy6Y8TmjZHX0TeLB6uThXges+cpfWm4YHO0/c1/D3r6g01LStF4IJjmP89egICijdne4RtXQg==
X-Received: by 2002:a17:902:3081:: with SMTP id v1mr96243822plb.169.1564115382626;
        Thu, 25 Jul 2019 21:29:42 -0700 (PDT)
Received: from ?IPv6:2601:647:4800:973f:9c9c:d9b0:80ed:96d1? ([2601:647:4800:973f:9c9c:d9b0:80ed:96d1])
        by smtp.gmail.com with ESMTPSA id l44sm45186630pje.29.2019.07.25.21.29.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jul 2019 21:29:41 -0700 (PDT)
Subject: Re: [PATCH v6 02/16] chardev: introduce cdev_get_by_path()
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Logan Gunthorpe <logang@deltatee.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jens Axboe <axboe@fb.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        Stephen Bates <sbates@raithlin.com>,
        linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
        linux-fsdevel@vger.kernel.org, Max Gurtovoy <maxg@mellanox.com>,
        Christoph Hellwig <hch@lst.de>
References: <20190725172335.6825-3-logang@deltatee.com>
 <20190725174032.GA27818@kroah.com>
 <682ff89f-04e0-7a94-5aeb-895ac65ee7c9@deltatee.com>
 <20190725180816.GA32305@kroah.com>
 <da0eacb7-3738-ddf3-8c61-7ffc61aa41f4@deltatee.com>
 <20190725182701.GA11547@kroah.com>
 <20190725190024.GD30641@bombadil.infradead.org>
 <27943e06-a503-162e-356b-abb9e106ab2e@grimberg.me>
 <20190725191124.GE30641@bombadil.infradead.org>
 <425dd2ac-333d-a8c4-ce49-870c8dadf436@deltatee.com>
 <20190725235502.GJ1131@ZenIV.linux.org.uk>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <7f48a40c-6e0f-2545-a939-45fc10862dfd@grimberg.me>
Date:   Thu, 25 Jul 2019 21:29:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190725235502.GJ1131@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


>>>>>>> NVMe-OF is configured using configfs. The target is specified by the
>>>>>>> user writing a path to a configfs attribute. This is the way it works
>>>>>>> today but with blkdev_get_by_path()[1]. For the passthru code, we need
>>>>>>> to get a nvme_ctrl instead of a block_device, but the principal is the same.
>>>>>>
>>>>>> Why isn't a fd being passed in there instead of a random string?
>>>>>
>>>>> I suppose we could echo a string of the file descriptor number there,
>>>>> and look up the fd in the process' file descriptor table ...
>>>>
>>>> Assuming that there is a open handle somewhere out there...
>>
>> Yes, that would be a step backwards from an interface. The user would
>> then need a special process to open the fd and pass it through configfs.
>> They couldn't just do it with basic bash commands.
> 
> First of all, they can, but... WTF not have filp_open() done right there?
> Yes, by name.  With permission checks done.  And pick your object from the
> sodding struct file you'll get.
> 
> What's the problem?  Why do you need cdev lookups, etc., when you are
> dealing with files under your full control?  Just open them and use
> ->private_data or whatever you set in ->open() to access the damn thing.
> All there is to it...
Oh this is so much simpler. There is really no point in using anything
else. Just need to remember to compare f->f_op to what we expect to make
sure that it is indeed the same device class.
