Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C01832ED43E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Jan 2021 17:27:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728336AbhAGQ0w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Jan 2021 11:26:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728118AbhAGQ0v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Jan 2021 11:26:51 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D6A1C0612F4
        for <linux-fsdevel@vger.kernel.org>; Thu,  7 Jan 2021 08:26:11 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id r17so7225180ilo.11
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Jan 2021 08:26:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QIxzF2bLadsBEQs53wZwsJlvmAD1DJLG/cb78U0SHpM=;
        b=lTR4t4/m5RCDhjOGakyk/fz0/tCMcwhMcoCNu/MgEqDrWJfdVnItWQMQacd9GGJ2Yz
         cz6Lrez9rKKyEKXkS9uyaRpxuo+qSi7X34N7NoDjVaYfgosCx/VgBQI6iBGfcstXHvVX
         kwxv3oCeawJ8k9qdv7MJ5w7fOBZIFFSf31KUn4snljd8oowKRjfnUWkkoktwb77G/mEE
         Q6chWbRVDRvLvv4El4midO2TTpyWI2dpdQmctVS2sV8XM025zlR3WRQURrfRMu1J/6ha
         yH5jdvDKBLuz0aw6jaYRiZwZqaEqI0k8DP6GvvLj4rxfU39WaUN13TwrPKmZrtHXAwjS
         Ytog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QIxzF2bLadsBEQs53wZwsJlvmAD1DJLG/cb78U0SHpM=;
        b=jKEdFLqNQHZwsLWV41S+YiPPywwRndOkkh36vPCi7+86yMqZFEPXD0wzwBmQ5i2VGl
         J4dsNO3q4GNWlPF/jnJUYV0e2EhlfqxeUsDv07oypoOYMrT8C1QQEnsOUccxOSA8JOlV
         gX6N4qEx75X0OzUTcJYPioRcyPOZrhJXrd0q3fw/xnEa/gl0ptr94UEz7TzbxQgRsnQT
         uBY/g/KjTEH97fWcJml6Wo9kwFSJKoyc5uiVBLyXkmiuakNbpBQ5EhnfTMI6S/ktDSVZ
         2ZKNc4uHEwurbo0F5O/00qEduFWonEIhn2lNDbHCP5oBVnsHqSW5m20KZqw7mmV9QjSS
         ZviQ==
X-Gm-Message-State: AOAM533T+c5a13jAbL3KvYA0+XsdpiJf2efBH7QR7MMudI28T2RcUgK4
        +IJyQNVrriI/HX0h8+uBEdsRGA==
X-Google-Smtp-Source: ABdhPJyOkfS44FMzaxu0QiHKrCmj2Lkuo/V5YETM7Lw88rC8dECEOyx51VGY8skJP9arsJcI9tB+GA==
X-Received: by 2002:a92:cb43:: with SMTP id f3mr9461411ilq.50.1610036770838;
        Thu, 07 Jan 2021 08:26:10 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id p3sm3469663iol.35.2021.01.07.08.26.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jan 2021 08:26:10 -0800 (PST)
Subject: Re: [PATCH] fs: Fix freeze_bdev()/thaw_bdev() accounting of
 bd_fsfreeze_sb
To:     Christoph Hellwig <hch@lst.de>, Satya Tangirala <satyat@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201224044954.1349459-1-satyat@google.com>
 <20210107162000.GA2693@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <79b418db-d7d2-eb07-af43-b66397a05c02@kernel.dk>
Date:   Thu, 7 Jan 2021 09:26:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210107162000.GA2693@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/7/21 9:20 AM, Christoph Hellwig wrote:
> Can someone pick this up?  Maybe through Jens' block tree as that is
> where my commit this is fixing up came from.
> 
> For reference:
> 
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Applied, thanks.

-- 
Jens Axboe

