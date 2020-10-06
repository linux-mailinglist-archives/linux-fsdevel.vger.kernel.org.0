Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0B2F285313
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Oct 2020 22:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727282AbgJFU0s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Oct 2020 16:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726890AbgJFU0p (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Oct 2020 16:26:45 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CAFDC0613D3
        for <linux-fsdevel@vger.kernel.org>; Tue,  6 Oct 2020 13:26:44 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id l126so9709378pfd.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Oct 2020 13:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FLtRXByKp9+5Dg5zm+HtjjP7VdwGyvWoNTaqHuD+Iek=;
        b=PMTFpJmktM2y+80xAhEY2qscCXN0OkQwO2aWowPP4oBrtk5GNM433AxXucgeqCd1en
         GNimloI8v2m/27/SBPwHVZJQOpzT1M51WoLCz5VHPqHUg9M3SUjBmHgMEj3fz2bq+D0d
         m6Ovz1YeGlqnCk8293sFPVkT3tYXI2uctPnlnoGCxgLX7xHsc3l2iZ0aqUmmfZO9Kecc
         xz1ipzOuFuymrg0NvA6UwWu8opx0gvSTN6hnqTbvB8ce1jR5QwJe9cVCVp9LS5wNYTLC
         AROWhfoKSKzgVEfFAcLLJkOpTSeHDIoLieRxzlUWELQgF4wUb+v/Gzm3SeNBf8WJ3Jy/
         ZZ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FLtRXByKp9+5Dg5zm+HtjjP7VdwGyvWoNTaqHuD+Iek=;
        b=LQsB3RfnRdWUPIUh2ddBE5KbQo+A2sLT7wd1IOvIuFJzw7w2YDp0UPO4zb0Xy/j9AD
         e+xRH42tLeMcpOyLZw30yEb2ooCMBOdTg+HL3JF1zI2Z3YwHXMpLL+dJU1sMolAQRSVQ
         f4yNUEb2FMeF8HJmum2IX2I/2mijWx8q2mJRXNnrWoL5Xnoel/+jJyZwGXuMiCY3gOY8
         GHAWOHCvqZSfzTVhcV3Qc9hT0ITbXOhigo4afVrFRs6v9Mx13ct+o466dxH/vT85rgma
         fg/kjPCFLNzwC5Z4vMN1ETHUufrVmCYA+vjQfBp+3rHbqNVan8XFfuAPE0Q5qGe0k3lG
         cG/Q==
X-Gm-Message-State: AOAM530TRjCeXBbqUF/1+v/yu0APHWxP9f6vX6F9/0QwSDkQhoqU3vsX
        YFLDGc5NUDWEgob9+l0AzASoog==
X-Google-Smtp-Source: ABdhPJzNF0T5J5Q+RDFMijq5u0hZO3I68498NE+0aFOep3We9kKjbIyRBx5C+TFOYA73D0g+GcLpig==
X-Received: by 2002:aa7:9427:0:b029:142:2501:35df with SMTP id y7-20020aa794270000b0290142250135dfmr6377421pfo.63.1602016003917;
        Tue, 06 Oct 2020 13:26:43 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id r14sm7640pgm.7.2020.10.06.13.26.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Oct 2020 13:26:43 -0700 (PDT)
Subject: Re: [PATCH v2 0/5] io_uring: Fix async workqueue is not canceled on
 some corner case
To:     Muchun Song <songmuchun@bytedance.com>, viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Yinyin Zhu <zhuyinyin@bytedance.com>
References: <20200923114419.71218-1-songmuchun@bytedance.com>
 <CAMZfGtUFacR9GFfmySEN6EfdxVi7ZKdwTs17HrJmOL9A38J8sg@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a1488045-afd0-39c5-0b56-079fc51723d4@kernel.dk>
Date:   Tue, 6 Oct 2020 14:26:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAMZfGtUFacR9GFfmySEN6EfdxVi7ZKdwTs17HrJmOL9A38J8sg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/28/20 6:50 AM, Muchun Song wrote:
> Ping guys. This is worth fixing.

Agree - can you respin with the suggested change?

-- 
Jens Axboe

