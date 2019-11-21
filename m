Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D2BC105A14
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2019 20:00:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbfKUTAI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Nov 2019 14:00:08 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:45576 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726774AbfKUTAI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Nov 2019 14:00:08 -0500
Received: by mail-io1-f65.google.com with SMTP id v17so4685150iol.12
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Nov 2019 11:00:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SnPj/n1gyGH0v59Wr7JbdghJQmtp3nHLjHxqakaNQHY=;
        b=v+yf4A6aRgckwfN25zrv7pKeKGK6P2XVAvXldacF+NRZh72s3fqXxw895IGgT3kpJ8
         J0OgyZgRa5EykvqtQ4nlYu2dzwJqrcPu3ygwQatG0jYJ4izFKF4YiFuO3M8eE3TAZMUa
         JaiLbU169r/mOsVmJIvi2s+I58CDBQY4tdMucTV3RV4eLage8BB3Yd75kYYyAi9ndu0n
         F4ePjwNjCbZ7yFLNqVUK78A2YqBBp0Wtv6MMpPS5g1y0FUCv0/EXWLB4B/dY/CSpTxFg
         mrO6v7iaLGZcq2pVfRo/btCriOBV1ZR8IcYvUwaaZttwkJlvUftuWYKJ9wpvxJI32QwW
         rAhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SnPj/n1gyGH0v59Wr7JbdghJQmtp3nHLjHxqakaNQHY=;
        b=E7BFkpOCOrPnRy2Vl25q7s3be5QIlYk78Ff3pVYZ1uxQ6902WBk4NRM8mW+M4BlOLf
         qm54S4J660BEX+68hwyMD4pCj+84OQwbdLZH1qPn5t2VpgIEHjveN6TA4kITSafhYF8F
         vQquJ9IGnfLW+V1K5h/EE89TalaPFnUEoksrsjICSXdAa+/0CexhVAEsDq1ugdk1E122
         vVfd6Pp7rekBoxMjkOsTQnlfFupxUa9yQ3f+/PtK+SfjN51EORqLM7gxIbQqm/Qvb9G5
         A9krWYthBUha4v0rJPrQmfyoJz5qBkc3IdsyuY1ykT1qZWQDoCMe1Ipr+8EORNPL3cpu
         icGQ==
X-Gm-Message-State: APjAAAUVkTIQiYuLRIjpcTnTD1yCDB5vOek5BgLf1lxjKoy5OzlYOUkq
        gbVMzGbE4qZk4XTQq3wh5X4E6A==
X-Google-Smtp-Source: APXvYqwRT3wSZZTVGt8hSDmQAxZRovFkX++EpdpjERq09vW/IKK+mqwWvCHPHk9lkKVR7nOrptsX6g==
X-Received: by 2002:a02:b00c:: with SMTP id p12mr4583129jah.112.1574362806304;
        Thu, 21 Nov 2019 11:00:06 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id i79sm1492127ild.6.2019.11.21.11.00.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Nov 2019 11:00:05 -0800 (PST)
Subject: Re: [PATCH v4 00/10] Fix cdrom autoclose
To:     Michal Suchanek <msuchanek@suse.de>, linux-scsi@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biggers <ebiggers@google.com>,
        "J. Bruce Fields" <bfields@redhat.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Benjamin Coddington <bcodding@redhat.com>,
        Ming Lei <ming.lei@redhat.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Hou Tao <houtao1@huawei.com>,
        Pavel Begunkov <asml.silence@gmail.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Jan Kara <jack@suse.cz>, Hannes Reinecke <hare@suse.com>,
        "Ewan D. Milne" <emilne@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>
References: <cover.1574355709.git.msuchanek@suse.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4ba670de-80d4-130e-91f3-c6e1cc9c7a47@kernel.dk>
Date:   Thu, 21 Nov 2019 12:00:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <cover.1574355709.git.msuchanek@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/21/19 10:13 AM, Michal Suchanek wrote:
> Hello,
> 
> there is cdrom autoclose feature that is supposed to close the tray,
> wait for the disc to become ready, and then open the device.
> 
> This used to work in ancient times. Then in old times there was a hack
> in util-linux which worked around the breakage which probably resulted
> from switching to scsi emulation.
> 
> Currently util-linux maintainer refuses to merge another hack on the
> basis that kernel still has the feature so it should be fixed there.
> The code needs not be replicated in every userspace utility like mount
> or dd which has no business knowing which devices are CD-roms and where
> the autoclose setting is in the kernel.

This is a lot of code/churn (and even an fops addition...) to work around
a broken hw emulation, essentially. Why aren't we just pushing vmware
to fix this?

-- 
Jens Axboe

