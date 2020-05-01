Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1CC1C1C56
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 May 2020 19:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730128AbgEARyi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 May 2020 13:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729291AbgEARyi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 May 2020 13:54:38 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2168C061A0C
        for <linux-fsdevel@vger.kernel.org>; Fri,  1 May 2020 10:54:36 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id i19so5591799ioh.12
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 May 2020 10:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Uhch7fSB/7Ki1vYFi3Z0iSi1LX7KXkljEn4AyEBquZE=;
        b=Nx7BXMoSRhrWDV3OPwFEVATv5EIqod9Ke6TsglxqcaGtC5ZebrOKW3kUTkIyjnrbcv
         drFHpu/isCG0aTZ9FZXSEf0Z54ZWsTcJlUx1ZlPTt8Nk9CchbeugUMSdwFQfMH9GYZ/P
         Z5tf9J4N5cJ/CQHjxrLNoNQeGKHlS0Cjmoe+0+YCR5LqTlIgEzCyld0X4zHtA6qPLERc
         Foi3m/rwrIOXx23Ap+0gIWMeZfh33maZDqF/jrVORJwzHr/jyja9Qf9om/FUQkeiZmfc
         SACzicfCTmKby6ww6lOeYtQNXhgfaYUMydg++Oy9fy8YV+Wy3vfn6C3YzNAC9crGLKpu
         Hvhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Uhch7fSB/7Ki1vYFi3Z0iSi1LX7KXkljEn4AyEBquZE=;
        b=DqXhA/1P1onLZ7iNpxM4rKHfTmvPxsIRl3iHsp+JpEl2JAQSajk7QGyewIYDtjXTOB
         9lZObwthG4kmlPKWlYMfYnHGbVLg22vNaa3KFDBsF5xy6KeIywasvwGyrA/YIbsNHwbD
         tJwE+ZQ4Jp245VP6P5xmyr6caXlqntPAOuolkJwahnJ0llvMsY7DG37yicdkRwoBl+EZ
         BJZRDlklHgTysX60L75lVhcoq0BwV8Y40mh22BKEpvcBv7qUympCpqjL6Y4jorPYSXH9
         NJ8HCFmX4XwqzyxM0Zrk+DciNAP6rYNn2kekWguyvBYasGCqfUhSs5Ck058lpLgFZVcs
         tQ9A==
X-Gm-Message-State: AGi0PubF15k6RVE7YIfd5gqBvdLVAb73H3AevumvPzEGOf87S8u40Ont
        pVpSlWGoxfpMrzaUOnwRKSa1hw==
X-Google-Smtp-Source: APiQypJNFnYwbuS2xi8dA49XKVMcqRvoptJd8A3fVr/x8ct+Ixbn3LW9/DAsNtU6s1SUh3SiapWMQg==
X-Received: by 2002:a02:c9cb:: with SMTP id c11mr4064657jap.93.1588355676393;
        Fri, 01 May 2020 10:54:36 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id k3sm1510390ilf.67.2020.05.01.10.54.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 May 2020 10:54:35 -0700 (PDT)
Subject: Re: [PATCH v3] eventfd: convert to f_op->read_iter()
From:   Jens Axboe <axboe@kernel.dk>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <4037e867-af74-6a11-a501-7e5b804beec5@kernel.dk>
Message-ID: <222126cc-0eb5-31b1-2a31-ef1ff2b24f72@kernel.dk>
Date:   Fri, 1 May 2020 11:54:35 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <4037e867-af74-6a11-a501-7e5b804beec5@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/1/20 11:53 AM, Jens Axboe wrote:
> eventfd is using ->read() as it's file_operations read handler, but
> this prevents passing in information about whether a given IO operation
> is blocking or not. We can only use the file flags for that. To support
> async (-EAGAIN/poll based) retries for io_uring, we need ->read_iter()
> support. Convert eventfd to using ->read_iter().

Attached the wrong patch, forgot to update it... See 3b posting. I ran
this through my io_uring related eventfd testing, and it looks good.

-- 
Jens Axboe

