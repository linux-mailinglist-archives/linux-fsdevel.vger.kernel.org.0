Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D75ACECF09
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Nov 2019 15:00:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbfKBOAB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 2 Nov 2019 10:00:01 -0400
Received: from mail-pf1-f169.google.com ([209.85.210.169]:40016 "EHLO
        mail-pf1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbfKBOAA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 2 Nov 2019 10:00:00 -0400
Received: by mail-pf1-f169.google.com with SMTP id r4so8922793pfl.7
        for <linux-fsdevel@vger.kernel.org>; Sat, 02 Nov 2019 07:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YkgkpM6rwpKhInhmv279J+9Kvjd52sspbeAhQDcOtxQ=;
        b=S9aQj9/adNLAAqb38APVXxuapMOnLHH5vVqCyPKn1M4oYwlYMwtW5ebeeN1kmWNDE/
         7zO3WhfUQRaTbSjvIw7cCKV43G1VLGZ7qV8LbwTCnMHJGos2TsmP+D6g0tkid2tkylPe
         hoS1JqUoDAoqW/T9C5Ji+4vVnMDBz968nf3+nc5mCLqEKlBs30ijCBcAHUFIuLslR2cg
         KeeJTlq7VwqKrE+IPRxDuDmtODPP13aWtTi+gXEwU7Cv7xDoqGCd/YH1d/NVttt1axl1
         0LdEaSOYLXtftRsuVdGeM5AtimES+WvEnmL574RDuzqxvpYfpFivzjKiRt1eQIK77CRc
         8iNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YkgkpM6rwpKhInhmv279J+9Kvjd52sspbeAhQDcOtxQ=;
        b=uHntYefZHd6xqy0dlQVln2mXJBI+tmzmASHMmynqP66hV/W+iOZJPY++WXecC0mMhW
         LD9ThHb3umDl/cN2WyBKye4TyEzv7AV+VJj4kNytJkHHkquxaWtlHxR88APplkd97fkC
         k2cKgMrND1wksp+SHrU899HLVTFn/9j4Iyg4442Ah0qjz5JQ53nKa3MGY+yOUBvUhw7Z
         7AL99i+jLjs14F4C6KaHcDQIPFtjXon3nPL/RkKdFcCHRWE4DQh/oXt33/iLFNhYRs+5
         y3CQ67jCqhHFLTayZK1Larmj1e5fsGbTo/ukjV4l0M6+OSZq9KHyPboNH3YPC/J5AoQb
         j4QQ==
X-Gm-Message-State: APjAAAXAzpqv0HyN7z8WQbAmmnj/mjeSk0kLF4YiAFEjzC+a0GvBraLZ
        UXKieLAZEsUaDjDcBsf9H5UMnQ==
X-Google-Smtp-Source: APXvYqwgSl9QBIMdqNY7ABFpVXj2TZMK5CoNaFUKtey+cS9tniBzpqSC+JdUC/67/b+V2T68w077vw==
X-Received: by 2002:a17:90a:3b0d:: with SMTP id d13mr11461726pjc.86.1572703199826;
        Sat, 02 Nov 2019 06:59:59 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id r11sm13371435pjp.14.2019.11.02.06.59.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Nov 2019 06:59:58 -0700 (PDT)
Subject: Re: [PATCH -next] io-wq: using kfree_rcu() to simplify the code
To:     YueHaibing <yuehaibing@huawei.com>, viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191102075501.38972-1-yuehaibing@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c94b1d80-fee1-1d80-9d55-693fbc49bf8a@kernel.dk>
Date:   Sat, 2 Nov 2019 07:59:56 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191102075501.38972-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/2/19 1:55 AM, YueHaibing wrote:
> The callback function of call_rcu() just calls a kfree(),
> so can use kfree_rcu() instead of call_rcu() + callback function.

Applied, thanks.

-- 
Jens Axboe

