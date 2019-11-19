Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C49410120C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2019 04:15:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727629AbfKSDP0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Nov 2019 22:15:26 -0500
Received: from mail-pg1-f173.google.com ([209.85.215.173]:39935 "EHLO
        mail-pg1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727403AbfKSDPY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Nov 2019 22:15:24 -0500
Received: by mail-pg1-f173.google.com with SMTP id 29so10622127pgm.6
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Nov 2019 19:15:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bH6OLsChq8B4WKZCYOfbbfHHWXx5dkcLTpl8Z48ELMU=;
        b=obijPTVfPqbQjXb8wUyaih7dcb6kS+xNNWHqdnXMjVNeT1lcYOCBOpyxgxorkDBHvn
         52yXfwMHEdrjKBQqD/PZpLZf89S6PrZF8AKptIXTtlkjVMwLRRwa/rB2wlILsWAZrmJU
         VqcGRPjmMU7IChjMma2IJNz7RsrozxK95g+XHnPhyi1qPT+D/RbOlahyxJ9g+6eNoDKQ
         APbpkdpBCxg52Ud5pnv/6IwqPJcEr/X4ZNk4IliqiSxFFjLhkuML1heqKWIztz0UYeq6
         WepOivB5v6/3HSHNnc5M/LLE/HCZtlkFdR7SDsX3Lpz6x7YORZ0d2WK56btNP7gUHvpS
         L7Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bH6OLsChq8B4WKZCYOfbbfHHWXx5dkcLTpl8Z48ELMU=;
        b=jhPKFtFiLiZi+5x6upb84+CQcZKalUJlivUBoXU7mKrt5sZOn17nNC2ig4sL0ymsV4
         uvSKtacvCPvCHYMB4GkA4ZY3pbktIvRe1i1Q5pHDCb2RILzBtC1PIBzW0ND8zJZ05v/B
         H5bJfAEaKyCeONJzVA0sUpyT68/6obGgSXAfcOwDYL5cmWV8Ywr3QCFSvy2OiMrpGtdq
         SRW0xyogGhV7OoaboHBpd12udVMX6n93MfRgPWHKdaAhR64nTeq0KeGt6KG4cKF/UMSY
         s3i8S654gIZE185zIxC/VRduB6EoYqy2XLk0qzzsm6hcTEc8obA5JFmQDuWG7sLLDl6Z
         Gkxg==
X-Gm-Message-State: APjAAAXZlWtddsrdh4UwCpA4XrIbmot/LxXTZAXsNi6GORCPmxc4Ye6O
        UQNtvMOjbbIHpni/eAitceBnRw==
X-Google-Smtp-Source: APXvYqyiN/c0l7XM+isQKPQTt9x2vwfNw9PIhgFIu/fFIV1jIOFt0Uko/Pd18EjD1a52tcohw6pFSg==
X-Received: by 2002:a63:f716:: with SMTP id x22mr2927463pgh.351.1574133322366;
        Mon, 18 Nov 2019 19:15:22 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id 23sm21319175pgw.8.2019.11.18.19.15.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Nov 2019 19:15:21 -0800 (PST)
Subject: Re: INFO: task hung in io_wq_destroy
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     syzbot <syzbot+0f1cc17f85154f400465@syzkaller.appspotmail.com>,
        andriy.shevchenko@linux.intel.com, davem@davemloft.net,
        f.fainelli@gmail.com, gregkh@linuxfoundation.org,
        idosch@mellanox.com, kimbrownkd@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, petrm@mellanox.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        viro@zeniv.linux.org.uk, wanghai26@huawei.com,
        yuehaibing@huawei.com
References: <000000000000f86a4f0595fdb152@google.com>
 <f1a79e81-b41f-ba48-9bf3-aeae708f73ba@kernel.dk>
 <20191119022330.GC3147@sol.localdomain>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <bc52115c-3951-54c6-7810-86797d8c4644@kernel.dk>
Date:   Mon, 18 Nov 2019 20:15:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191119022330.GC3147@sol.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/18/19 7:23 PM, Eric Biggers wrote:
> Hi Jens,
> 
> On Mon, Oct 28, 2019 at 03:00:08PM -0600, Jens Axboe wrote:
>> This is fixed in my for-next branch for a few days at least, unfortunately
>> linux-next is still on the old one. Next version should be better.
> 
> This is still occurring on linux-next.  Here's a report on next-20191115 from
> https://syzkaller.appspot.com/text?tag=CrashReport&x=16fa3d1ce00000

Hmm, I'll take a look. Looking at the reproducer, it's got a massive
sleep at the end. I take it this triggers before that time actually
passes? Because that's around 11.5 days of sleep.

No luck reproducing this so far, I'll try on linux-next.

-- 
Jens Axboe

