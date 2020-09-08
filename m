Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEF6A26161D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Sep 2020 19:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732089AbgIHRD4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Sep 2020 13:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732034AbgIHRCv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Sep 2020 13:02:51 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EDD8C061573
        for <linux-fsdevel@vger.kernel.org>; Tue,  8 Sep 2020 10:02:50 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id h4so89707ioe.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Sep 2020 10:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6r8oY7P5aaaNjTS2Z3JuHAo/BodSW0G0Qz3+9SCpdcA=;
        b=Fc5KlT/QgmDUw9wewiSXZGEfR0knpYXatiwTcFvCBfuTglDqwe97Xqfk0+3x8rqwqz
         +7tuFM8H7/+AmHKFAaAgiLJ6SRjQRhYk33odBKaz/HYiH3Ner4l978qk7J5fVRCppZat
         NzbCVkM8xF0xtOByqvqkwhwdQxGZyDDDgP822eVuJM4gG0Hcg8eiv1RslZap/Bek1+wl
         Zo6pLSrd6Y9goqQPOoDIZfkmRDiwu8LSP2FkQezPzvHh4k3BUYgvl+MCayPCGDN/ggRH
         EbcMddlY2Qg8dVmq7IG0F2iCUIwDUoScipcAw4Y7Ul6q0kcLqRY/IS7Ixd4PLxrKKOK1
         TsFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6r8oY7P5aaaNjTS2Z3JuHAo/BodSW0G0Qz3+9SCpdcA=;
        b=tiZSzxpHy6mCqvWuWXtm20mHPV3gouNkdUB0FcEALDf6i6rBNSFiFi0G7wphMm7f2A
         LeE2Kn3C5mFg5rfTvmqtO8JgzLykVei3FceWf4QgxYXHWqVO1gl69vYi+wILl6e+OswH
         MwaMq16mvnkHJ/mGakl2Oqi3YzDU5hnUpG3i0hYeMMCrIcf3+vr5VJDryN/tCWgU0fd0
         40pxjJk0E1z+T8InYLWBVaeCRQi/uQkGdOvAidMKeEspjEpFOCaBE/lWBQAQKKSlZrUr
         T5rZhC6YJDlLGrxwLTWsCYVL5CzbFAZHvlK6jsB6pXV8CK5AG4ki3+esHxAolbczpJ9/
         bDVw==
X-Gm-Message-State: AOAM531S6+Pk6MUUmMFYIycnwQsacvijtZ3i1lzh223HeLhclTKVFVoN
        SU/QH+eQ/2ojlmg03DO7Y9ypkQ==
X-Google-Smtp-Source: ABdhPJwKYohUKj3l/8T5Uy0NjpVMb531t2l/rRzat+mZoQM4CjOho16dsxnLDc/YijlCusjH4qO8bQ==
X-Received: by 2002:a02:9986:: with SMTP id a6mr23301374jal.28.1599584569815;
        Tue, 08 Sep 2020 10:02:49 -0700 (PDT)
Received: from [192.168.1.10] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id i14sm10669430ilb.28.2020.09.08.10.02.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Sep 2020 10:02:49 -0700 (PDT)
Subject: Re: [PATCH for-next] io_uring: return EBADFD when ring isn't in the
 right state
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     io-uring@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200908165242.124957-1-sgarzare@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6e119be3-d9a3-06ea-1c76-4201816dde46@kernel.dk>
Date:   Tue, 8 Sep 2020 11:02:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200908165242.124957-1-sgarzare@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/8/20 10:52 AM, Stefano Garzarella wrote:
> This patch uniforms the returned error (EBADFD) when the ring state
> (enabled/disabled) is not the expected one.
> 
> The changes affect io_uring_enter() and io_uring_register() syscalls.

I added a Fixes line:

Fixes: 7ec3d1dd9378 ("io_uring: allow disabling rings during the creation")

and applied it, thanks!

> https://github.com/stefano-garzarella/liburing (branch: fix-disabled-ring-error)

I'll check and pull that one too.

-- 
Jens Axboe

