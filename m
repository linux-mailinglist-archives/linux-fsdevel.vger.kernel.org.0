Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFCF4165E6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2019 16:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbfEGOkY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 May 2019 10:40:24 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:35793 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbfEGOkX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 May 2019 10:40:23 -0400
Received: by mail-it1-f194.google.com with SMTP id l140so26132371itb.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 May 2019 07:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pyUWJ7Av0oOOQv/K8zAkAH27VXW6ZvjzZBAYlwzk+JE=;
        b=vBtODXdTWcIG/JPMk+dA4ixPAxlwSNtAyglnXqNFbDVizPQtGACV2Dll63v5OjjGiQ
         LRMpe/QxIH0zU001EYHDPygTnbPvpfumBr5cAEo2MHtD5RysnGg6lAIV0Y4K5fAFoI+u
         d8NvDxdZZXS75b8WtD4sY84mEROLXOtJJxxskHgCI+fi0VS0i2PwLKWXbs+PQWXxDkrp
         x1LDjNji6QBo++s6Q8z45oNUvqyb5DzOV65aaBFnU8XwLyKoDCjJER0xVxJuKUHZlJ+W
         wbnnxw/EVJ6vp42bxS/mEQGpVGHHAIuvM8IA28ovJ+vaOd3vRIdSG/hIcrkvlaN55fbx
         c/zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pyUWJ7Av0oOOQv/K8zAkAH27VXW6ZvjzZBAYlwzk+JE=;
        b=ujzU5zpq6ESo/8ihWn9szsgedWxwf7edrrTLbjY40mwV03otV2gALIHNq633gkkkkH
         2okSOLR7P7Rp8dDmdLjaqejfzXB2dgCyXeQJLx+EMYun4+6FEpybUafBa08tQORC3Rax
         wJqCX3rRS4bqz7UrXJtRtkiTefihy9p/m3CaVgG+8IiNPFrmsblBY8JCt1hr1+4hFbiB
         aU6HsgukeDFH5yoJa4nNE0qYDSFfxxi4VIWDlbYx1OAWbZ4EV+5+4l4QNVZsw77gzDYE
         H5wZciSnCm/HiYpGkhBCC1MOFibz2OlGWPklEb+TONHlze4BeNujy/di5eWYle0ViTmX
         nWKQ==
X-Gm-Message-State: APjAAAVc4zxsoRnlv65zReWmuhKfbSR96ngoMtldQhTFwPaLGFeBrby6
        87aS+AxD48H+vadCj9ruPvhtMQRBdVuC/A==
X-Google-Smtp-Source: APXvYqygnd5gN2lgBy59l/EECQ9yWQVuYS8cn5GwiG4j1FbyVT3fYCrSVoCoDyfAdugCkoKOsmjq8w==
X-Received: by 2002:a24:2b50:: with SMTP id h77mr8216956ita.63.1557240022990;
        Tue, 07 May 2019 07:40:22 -0700 (PDT)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id j8sm5927365itk.0.2019.05.07.07.40.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 07:40:22 -0700 (PDT)
Subject: Re: [PATCH] io_uring: use cpu_online() to check p->sq_thread_cpu
 instead of cpu_possible()
To:     Shenghui Wang <shhuiw@foxmail.com>, viro@zeniv.linux.org.uk,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     jmoyer@redhat.com
References: <20190507080016.1945-1-shhuiw@foxmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <2d1a6bf3-d329-5552-7ae5-20ba727bb39e@kernel.dk>
Date:   Tue, 7 May 2019 08:40:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190507080016.1945-1-shhuiw@foxmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/7/19 2:00 AM, Shenghui Wang wrote:
> This issue is found by running liburing/test/io_uring_setup test.
> 
> When test run, the testcase "attempt to bind to invalid cpu" would not
> pass with messages like:
>    io_uring_setup(1, 0xbfc2f7c8), \
> flags: IORING_SETUP_SQPOLL|IORING_SETUP_SQ_AFF, \
> resv: 0x00000000 0x00000000 0x00000000 0x00000000 0x00000000, \
> sq_thread_cpu: 2
>    expected -1, got 3
>    FAIL
> 
> On my system, there is:
>    CPU(s) possible : 0-3
>    CPU(s) online   : 0-1
>    CPU(s) offline  : 2-3
>    CPU(s) present  : 0-1
> 
> The sq_thread_cpu 2 is offline on my system, so the bind should fail.
> But cpu_possible() will pass the check. We shouldn't be able to bind
> to an offline cpu. Use cpu_online() to do the check.
> 
> After the change, the testcase run as expected: EINVAL will be returned
> for cpu offlined.

Applied, thanks.

-- 
Jens Axboe

