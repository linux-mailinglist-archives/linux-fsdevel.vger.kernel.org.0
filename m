Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 309AE1E521C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 May 2020 02:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725819AbgE1AM4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 May 2020 20:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725681AbgE1AM4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 May 2020 20:12:56 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6912EC05BD1E;
        Wed, 27 May 2020 17:12:56 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id z26so12599173pfk.12;
        Wed, 27 May 2020 17:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=P8ZX6NswqYpmp7AerrBDt1jBaXqAyhSsaEu8p+L3oCE=;
        b=iKLqcWmV5z5p/JypITIwKEFX2LyCZV9tu37lGMrCJvoOrB+JBVptoFiBh5FgHaUjF0
         wOqAigXgQ4PhC/G9wWNnNPI4VG1aZsCSJZVY6Fo4s/xWgeXEeJbWGQuOn1XiZSDo2vTt
         sIVJq4JN0uOo25JAznQVs7c8LVC0xmI++cZK+XSr5f5GeVvIKF+PJRtP1bFAud4HVWQy
         3CAKwCM//8w28wWFoNKwy+qOQG5rnMDB9cjTm54fLySgkhnBeTGHJqFBHj+0Nd4qLgOe
         RfWLucbAEZOnfsQRqdxWAUaPLzN5s0ggQNbKaMWdliVyILqQk1ocXrtPe+i86S5gTbF5
         j7fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=P8ZX6NswqYpmp7AerrBDt1jBaXqAyhSsaEu8p+L3oCE=;
        b=nfRMEhBtbNZfiRmBIHFN7K/s+X4xdJmFSwqBDdvYa9rQNtMeBF9gDKSYPwkGPzfzAB
         PIbJqpqeoMn6kdJiQ6cwgfziJ4IU/bXt5inISavF443IiS8YJ5xbOs8FdToH8neMHIZf
         fXzHSjNQQadepUm7vFVcnG4G3BtQnY7042xAfFD9w+eCr0Yp9oCPU7IGkGWP5xoJ9Y3c
         MKi6F2g01e6pxdoYcliyB50uEnh2VRDcYXe3d4DuCW7xcuHwNfg8rrtYtV5NZVu2GhxK
         oKCs78CWFF1cMQb+a2CTKlLydJxdgJpvS+jHwaeyjDp2ZjYI9c5khSyX1fuJUzu245St
         jl2Q==
X-Gm-Message-State: AOAM532OViw58fl/o9Q31NKXirZoHz5r1s7dkVmQdToEkJcFP84cf9Xd
        8AJ4E8cpkJOmtGm6GiWsW1hHUz6VI2E=
X-Google-Smtp-Source: ABdhPJyybKRjHW/e8Wn8InRXBVk2d8dp4EgOWi6G1U18Odv3v3aOGhPI7vHfAxUxrSGaWJqSIn/WRg==
X-Received: by 2002:a05:6a00:134c:: with SMTP id k12mr275880pfu.313.1590624775625;
        Wed, 27 May 2020 17:12:55 -0700 (PDT)
Received: from ?IPv6:::1? ([2404:7a87:83e0:f800:295a:ef64:e071:39ab])
        by smtp.gmail.com with ESMTPSA id f136sm2915747pfa.59.2020.05.27.17.12.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 May 2020 17:12:54 -0700 (PDT)
Subject: Re: [PATCH] exfat: optimize dir-cache
To:     Sungjong Seo <sj1557.seo@samsung.com>,
        'Namjae Jeon' <linkinjeon@kernel.org>,
        "'Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp'" 
        <Kohada.Tetsuhiro@dc.mitsubishielectric.co.jp>
Cc:     "'Mori.Takahiro@ab.MitsubishiElectric.co.jp'" 
        <Mori.Takahiro@ab.mitsubishielectric.co.jp>,
        "'Motai.Hirotaka@aj.MitsubishiElectric.co.jp'" 
        <Motai.Hirotaka@aj.mitsubishielectric.co.jp>,
        'Namjae Jeon' <namjae.jeon@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CGME20200520075735epcas1p269372d222e25f3fd51b7979f5b7cdc61@epcas1p2.samsung.com>
 <20200520075641.32441-1-kohada.tetsuhiro@dc.mitsubishielectric.co.jp>
 <055a01d63306$82b13440$88139cc0$@samsung.com>
 <TY1PR01MB15784E70CEACDA05F688AE6790B10@TY1PR01MB1578.jpnprd01.prod.outlook.com>
 <CAKYAXd_oG6dc7CNiHszKmhabHd2zrN_VOaNYaWRPES=7hRu+pA@mail.gmail.com>
 <000701d63432$ace24f10$06a6ed30$@samsung.com>
From:   Tetsuhiro Kohada <kohada.t2@gmail.com>
Message-ID: <22dfcd8a-4416-e2a7-b8a7-0375660ba465@gmail.com>
Date:   Thu, 28 May 2020 09:12:52 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <000701d63432$ace24f10$06a6ed30$@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Antivirus: Avast (VPS 200527-0, 2020/05/27), Outbound message
X-Antivirus-Status: Clean
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>>>   > In order to prevent illegal accesses to bh and dentries, it would
>>> be better to check validation for num and bh.
>>>
>>>   There is no new error checking for same reason as above.
>>>
>>>   I'll try to add error checking to this v2 patch.
>>>   Or is it better to add error checking in another patch?
>> The latter:)
>> Thanks!
> 
> Yes, the latter looks better.

I will do so.

I will post additional patches for error checking, after this patch is merged into tree.
OK?



