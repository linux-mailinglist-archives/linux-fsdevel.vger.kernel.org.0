Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52A8A1FE99D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jun 2020 05:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbgFRDqg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Jun 2020 23:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726853AbgFRDqg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Jun 2020 23:46:36 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1232C061755
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jun 2020 20:46:34 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id m7so1869473plt.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jun 2020 20:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4GT56k9T/ZTDoyTYqGTbPF7+FHS2XvXa9AkMU/5htfA=;
        b=oMY2V4F0GZ4EaNFR9ALy1J/WJKUSagln2jQWoKHSSHprBse0BcRSPzNRfYaFH/Q731
         fFr3LBpUu9HCzfEpKjvDWcAIETemlq6lTuejnio/7Xp/xL/U30ZNEfU+vVoF/pfZCqgu
         VtNMy1Q0XJgNGgNUGOl+il+5+JpX6aIAv78Ts+z4KYoAGdvlBSH4UBhax+YRq4sEbsGl
         AnOuJErt7wgLVMFCREjhTaraBnX4NRnUiG8Wou5+qFgLuAiXsELFs/lpvQ7RjKDo7gBU
         dq3tRXbdxivc6WsLFp5/3wMZilb0m+oNw/8o0dkFhI4b65PKbBHzEiHiNN3WkmBrTNYi
         0JHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4GT56k9T/ZTDoyTYqGTbPF7+FHS2XvXa9AkMU/5htfA=;
        b=Hfge2xXLJsn8EdhQemK0PLlYqmpcRAn9+RDZefufp16lLZuFvEq1pixK0EwqTV/e15
         Jq5a7BKiViY0HKJSgZ6xiaDuwOGhgw2c3LtU7wPCFJ4xoBI50qdXPEwJhfhpWvnIVNQT
         IuvW5LFllwFVEbJb18fG3nLvuqPa5MUIJTrvvESyXKrvxQZ7wGSwQIXdotLuEs2oGWMJ
         sLL6pFGuDUPEo7CRCCe3RdXVuAbIOmdHP4khc2BfU8zF5Kqr5vXvgK0eE/Eu9IbBhVTo
         KAvxRrjKub2uHdDaiboGqS5SZcE/tnZ74XvR0kPpo25pJwpxWq4o9QYwJvoTKU8SiFwb
         tPFQ==
X-Gm-Message-State: AOAM530ySysOIbLyCC2NExrZ6EzmypfwxwsYK3aLGkvF2b3X3J2tc/Ci
        5Er3ca93OaRlCVng/AvR7k0SsAzwKc7P4Q==
X-Google-Smtp-Source: ABdhPJxxx7EVn4Cpsblh2T7oW56MKK52snnSq2TEgJvD++4dJbPCza8tlqhrtmtxkvIWk1LQ27YFiQ==
X-Received: by 2002:a17:902:599a:: with SMTP id p26mr2120023pli.322.1592451994183;
        Wed, 17 Jun 2020 20:46:34 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id b11sm1198002pfr.58.2020.06.17.20.46.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2020 20:46:33 -0700 (PDT)
Subject: Re: [PATCH v2 0/2] loop: replace kill_bdev with invalidate_bdev
To:     Zheng Bin <zhengbin13@huawei.com>, hch@infradead.org,
        bvanassche@acm.org, jaegeuk@kernel.org, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Cc:     houtao1@huawei.com, yi.zhang@huawei.com
References: <20200530114032.125678-1-zhengbin13@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f50b771a-52c3-f8ae-9baa-1603dc83d115@kernel.dk>
Date:   Wed, 17 Jun 2020 21:46:31 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200530114032.125678-1-zhengbin13@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/30/20 5:40 AM, Zheng Bin wrote:
> v1->v2: modify comment, and make function 'kill_bdev' static
> 
> Zheng Bin (2):
>   loop: replace kill_bdev with invalidate_bdev
>   block: make function 'kill_bdev' static

This doesn't apply, so please fix that and resubmit.

-- 
Jens Axboe

