Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B76A742EC4F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Oct 2021 10:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234301AbhJOIaW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Oct 2021 04:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234347AbhJOIaV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Oct 2021 04:30:21 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38ABDC061753;
        Fri, 15 Oct 2021 01:28:15 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id 187so7747620pfc.10;
        Fri, 15 Oct 2021 01:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=0aqBuWR/hjYtneqE/EKmSXtyBEhLi33Qu/EPQ3pbTwk=;
        b=JNv/uNihnC9ZTKvWuE+dOSpWNoWgeykFPIeW60bQOwVPpbG3xspXVY0q6prlpAwCdi
         mXLeWr1Wv+JVdxp5kR/6lVDN83tGSveA81mEakrlOb+4j789IWch2QFR17EJTEQnOUvy
         bCEUASIoVm4zTzXsouTG8xdIL8Uri3dHoYOggLO54e/3VPNTcdyr8IMXujz+p3/WNTlK
         BoMoQcfQQk9fW5kRVqqyCUGMLAfCLt0L1wvBz070Hqoo3ak1YpnpUMWBpTGhZivHUQru
         800WLa65auzYDemxZFJkyIO3qY1VHe/9ZsGIM7ADvmf6Iof2Qcm/hXq4fbUcca3KYjYR
         touA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=0aqBuWR/hjYtneqE/EKmSXtyBEhLi33Qu/EPQ3pbTwk=;
        b=z1dmOMw6nwkIPf117MckPHtfFyW4f7JMdEHcfHJDHjrl5gBKcMQucTz5E+k9jTluSu
         3pCVnNzvcAR+BlOhIEdwP7Rm7sOivXWSyrozlIs+joO5vjfCN5Ez8ryF95PNiuKbsqtz
         XERB9HPgyH5ETsXINKuCZq23o14v+GjC7gOJhEBx98pzBqv8fr4ymH1w0EectDgh/KnE
         ePiymd4+FZW60GcAmP8A/h1F72XuD5qWLBxpkDeQPBA4OUf32RbgPoO03l2RpRA6CSwH
         rTRu+xfLV61GQkbToCOY3RSn6Q7JDUsAIub0Obox29h28Piac0d58Cz1+25CmljhqxI3
         39Cg==
X-Gm-Message-State: AOAM533D07z0VKEZM4N3xufMV8E07+97u3XWYsbgHjj8mPhRI0zDTrXm
        b47BcCrxVkPdrGQQGps119ZpaDcnXa2r55B0
X-Google-Smtp-Source: ABdhPJyxrCEVpejQ4OJkevuwlmPh1MUAOadDoiEQ7vhRA8mDXeGHPS8knVE5utP08N831l8WtS3gdw==
X-Received: by 2002:a05:6a00:17a9:b0:44c:b95f:50a4 with SMTP id s41-20020a056a0017a900b0044cb95f50a4mr10189283pfg.6.1634286494401;
        Fri, 15 Oct 2021 01:28:14 -0700 (PDT)
Received: from [172.18.2.138] ([137.59.101.13])
        by smtp.gmail.com with ESMTPSA id k14sm4320162pga.65.2021.10.15.01.28.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Oct 2021 01:28:14 -0700 (PDT)
Subject: Re: [PATCH] fs: inode: use queue_rcu_work() instead of call_rcu()
To:     Christoph Hellwig <hch@infradead.org>
Cc:     willy@infradead.org, akpm@linux-foundation.org,
        sunhao.th@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211015080216.4871-1-qiang.zhang1211@gmail.com>
 <YWk195naAMYhh3EV@infradead.org>
From:   Zqiang <qiang.zhang1211@gmail.com>
Message-ID: <bcc1c2ec-e3f9-34b2-659e-b71fd149f677@gmail.com>
Date:   Fri, 15 Oct 2021 16:28:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YWk195naAMYhh3EV@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 2021/10/15 下午4:04, Christoph Hellwig wrote:
> NAK.
>
> 1. We need to sort ounderlying issue first as I already said _twice_.
> 2. this has a major penality on all file systems

This problem report by sunhao,  the log

https://drive.google.com/file/d/1M5oyA_IcWSDB2XpnoX8SDmKJA3JhKltz/view?usp=sharing

but I can not find useful information, not sure if it is related to the loop device driver.
are you mean There is a problem about inode lifetime ?

Thanks
Zqiang

