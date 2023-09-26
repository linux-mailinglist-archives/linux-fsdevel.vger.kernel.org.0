Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8C737AEFBE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Sep 2023 17:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235114AbjIZPbk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Sep 2023 11:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233309AbjIZPbj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Sep 2023 11:31:39 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF85116
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Sep 2023 08:31:32 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-3233799e7b8so288607f8f.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Sep 2023 08:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1695742291; x=1696347091; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T3LypFaYtHoliVkeLOI3g72L1HdBJUu3/jXJAsamg5A=;
        b=hoSPGBA9t0Bqd1k0AUXU5Dfy/PIUjH7+hTwto6VZoIUTtvo7aFqSGuyedbdE9YjRTv
         L4uJ4op6OWVmfvnTmSXVFGQUUppWbPRXBR9bIrYteu8z8FTZIjXeD7+VhgcdUxPWk+9K
         /sF4KOf3GbyxtG89GEcczW5Sbs8Be/Yv1Sa5g0Sfk/fEp4tYMe6BDS9VYPxxl7pyMpm7
         y1cYjr6M/J8wvQOuH6krfjnM5RsLX4Th0SLZglYIbuQO/82AvES6Y5Nb9+8miJ5vaKSK
         D/Q4k5tFN6SHWCvbU4nVJRWzcp71MqnfWmXZcGoZJ+ozEiPNeQBJ/3SgKWmd+e6IBAYC
         +tkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695742291; x=1696347091;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T3LypFaYtHoliVkeLOI3g72L1HdBJUu3/jXJAsamg5A=;
        b=fLqoI5fCgN7R+SVELT1FHdO0s6TOAnB0MYY0scIAL/4LcC05csp0ljgef4+0pDmNKM
         tHZGbrtmUYK+aquG8og+g4ZezCdLprZiuWwQ3sEujVp1KSB+6ptDIU1sKiJKVvTpyJ3m
         npAl+OKfvUosOL//8Whn1vDae8SDlwjl0U2mwcL+fS0PBlDqhysWSH/8pMRGsl9BQ2SY
         khBOMCeoSOjJvXlt0PKj+i1Qy1CK0M0JB+s9lOMmHzkc6aB892qt2lYD87vCdv1gmN+J
         clJri6lpp7cWMYqf2jVumAbsdUj5daI/aaj3wshXUKl42twXO562CxdMdV+ARcp1JeMB
         9+1Q==
X-Gm-Message-State: AOJu0Yyx/dxWvvTlHyRzeMSmIp7M4JB9HAhMjnq1zoIaVTXzVmtFQLNz
        YIE2+FzJ5DopghD5vx92vAxMPA==
X-Google-Smtp-Source: AGHT+IGTeUxTbNN8DJwgTJrbAR8Vg+SSnTyPrqJj7sogmNw0UfQpzF4o2iK11UZAw6ZIxGfxSKacsQ==
X-Received: by 2002:a05:6000:1748:b0:323:2e5d:b7c6 with SMTP id m8-20020a056000174800b003232e5db7c6mr4061837wrf.0.1695742290949;
        Tue, 26 Sep 2023 08:31:30 -0700 (PDT)
Received: from [172.20.13.88] ([45.147.210.162])
        by smtp.gmail.com with ESMTPSA id l16-20020a5d4bd0000000b003216a068d2csm14957596wrt.24.2023.09.26.08.31.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Sep 2023 08:31:30 -0700 (PDT)
Message-ID: <1dea57e7-87d0-4ed7-9142-3a46dab73805@kernel.dk>
Date:   Tue, 26 Sep 2023 09:31:29 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] [PATCH v13 08/10] fuse: update inode size/mtime after
 passthrough write
Content-Language: en-US
To:     Amir Goldstein <amir73il@gmail.com>,
        Zhang Tianci <zhangtianci.1997@bytedance.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Daniel Rosenberg <drosen@google.com>,
        Paul Lawrence <paullawrence@google.com>,
        Alessio Balsini <balsini@android.com>,
        fuse-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>
References: <20230519125705.598234-1-amir73il@gmail.com>
 <20230519125705.598234-9-amir73il@gmail.com>
 <CAP4dvsdpJFrEJRdUQqT-0bAX3FjSVg75-07Q0qac7XCtL63F8g@mail.gmail.com>
 <CAOQ4uxh5EFz-50vBLnfd0_+4uzg6v7Vd_6Wg4yE7uYn3+i3uoQ@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAOQ4uxh5EFz-50vBLnfd0_+4uzg6v7Vd_6Wg4yE7uYn3+i3uoQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/25/23 4:43 AM, Amir Goldstein wrote:
> Jens,
> 
> Are there any IOCB flags that overlayfs (or backing_aio) need
> to set or clear, besides IOCB_DIO_CALLER_COMP, that
> would prevent calling completion from interrupt context?

There are a few flags that may get set (like WAITQ or ALLOC_CACHE), but
I think that should all work ok as-is as the former is just state in
that iocb and that is persistent (and only for the read path), and
ALLOC_CACHE should just be propagated.

> Or is the proper way to deal with this is to defer completion
> to workqueue in the common backing_aio helpers that
> I am re-factoring from overlayfs?

No, deferring to a workqueue would defeat the purpose of the flag, which
is telling you that the caller will ensure that the end_io callback will
happen from task context and need not be deferred to a workqueue. I can
take a peek at how to wire it up properly for overlayfs, have some
travel coming up in a few days.

> IIUC, that could also help overlayfs support
> IOCB_DIO_CALLER_COMP?
> 
> Is my understanding correct?

If you peek at fs.h and find the CALLER_COMP references, it'll tell you
a bit about how it works. This is new with the 6.6-rc kernel, there's a
series of patches from me that went in through the iomap tree that
hooked that up. Those commits have an explanation as well.

-- 
Jens Axboe

