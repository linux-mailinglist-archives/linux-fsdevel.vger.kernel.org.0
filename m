Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10E194416B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2019 18:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731236AbfFMQOQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jun 2019 12:14:16 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:36965 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731194AbfFMIma (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jun 2019 04:42:30 -0400
Received: by mail-yb1-f195.google.com with SMTP id v144so1730962ybb.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Jun 2019 01:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zjpXrdhZdWSVnzo1hcCmpdYCRukSqJAaG4+HlfSu5wc=;
        b=Dww8Mp6DzN1GHQieAdQBJBXrZ6Dx9lwUFAyjoSpdOPjDv5aHFyXKPRFuPFDadk3F4N
         PlAxkpCqcbhb6+yKQ3k3gDZlgZ8ltdDU3HqW0ffCqnxdaRQN/wD1YadQA77Sbb051t1M
         u3hZk++QD/VFEeZiQvaXESGohxYVWpUChsQd0zFYnswawNr2oKOBEv9Rc5HGkHPQ3Rs6
         wP+KYkzy8EYouMLVbEHXfV8pMIxqWa3daudYkLkiEWCCTSBX6kXfjntbprtvsFputU3m
         DNZBzUHcvlxbDEeq+ZdSCnZORxSBGGAQFGxDcZryNZn+8w1MabKJ9e5hOwV6uOAdegLT
         n3XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zjpXrdhZdWSVnzo1hcCmpdYCRukSqJAaG4+HlfSu5wc=;
        b=ZN2kBoCmMABEeCC2/S8+97lnSm8E/+/JIpk5jRaEfcq2IOQT7CcBvI/9P0QjlmgNoT
         LPWQbFs1GL4Ux8P5ChHoKm6xl25HCocdGREsJMJupV5QXUxeE60wwDGk29oCMVcyiEG2
         qZ+ok4/XUGmPXafmxLvRswQV3JsT7TVDjVrJ6gl+dfCtlI4Z3+tpcP3MEYnlcusnmfEk
         tGR6g57Marqr1zl16TmPiazgUxMLh67sJcQxn2m7cn1CFg0g2omD/Qqin0Yg7Hc+Xml3
         0CHT9/qCdHfH+4G2Yh1WZxUbIWeP8eKDTa7xSmxz4HMAG/V+Wp3ei68NTkSI/1+pEdIE
         bLCw==
X-Gm-Message-State: APjAAAVPVWQ2No5b3kVsIALwp50HNUwQwVNzWU+g0eNFYP/mNsWJC5XA
        Gpao6qWfHw+NEX/xBf4nWltGcQ==
X-Google-Smtp-Source: APXvYqw6HbzBIcjkNiK7Q0GLBBoGGfFaDqjTHwqIkqQaT8YYX/nxFXa9ac5Nsx5wzsq/aODUxFvBaA==
X-Received: by 2002:a25:320b:: with SMTP id y11mr14886649yby.92.1560415350170;
        Thu, 13 Jun 2019 01:42:30 -0700 (PDT)
Received: from [172.20.10.3] (mobile-166-172-57-221.mycingular.net. [166.172.57.221])
        by smtp.gmail.com with ESMTPSA id 84sm769447ywp.45.2019.06.13.01.42.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 01:42:29 -0700 (PDT)
Subject: Re: [PATCH] io_uring: fix memory leak of UNIX domain socket inode
To:     Eric Biggers <ebiggers@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     davem@davemloft.net, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+111cb28d9f583693aefa@syzkaller.appspotmail.com>
References: <0000000000005bc340058983fe8e@google.com>
 <20190612215843.91294-1-ebiggers@kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c8afa475-8ed9-e8ee-c66a-270bea7efad5@kernel.dk>
Date:   Thu, 13 Jun 2019 02:40:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190612215843.91294-1-ebiggers@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/12/19 3:58 PM, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Opening and closing an io_uring instance leaks a UNIX domain socket
> inode.  This is because the ->file of the io_uring instance's internal
> UNIX domain socket is set to point to the io_uring file, but then
> sock_release() sees the non-NULL ->file and assumes the inode reference
> is held by the file so doesn't call iput().  That's not the case here,
> since the reference is still meant to be held by the socket; the actual
> inode of the io_uring file is different.
> 
> Fix this leak by NULL-ing out ->file before releasing the socket.

Thanks, applied.

-- 
Jens Axboe

