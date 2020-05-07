Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E2391C9552
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 May 2020 17:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbgEGPpb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 May 2020 11:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725914AbgEGPpa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 May 2020 11:45:30 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B43EC05BD43
        for <linux-fsdevel@vger.kernel.org>; Thu,  7 May 2020 08:45:30 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id q124so2657463pgq.13
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 May 2020 08:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=NYaUg5HujR7sQmyawubmYl3hcJlxfTXuEKXFBZh5EIc=;
        b=Ss3kDmHogDZdKj41KkjFqKo8fnHPDSj2KSuSggY8NZeJYcML53gyEaOC3De8TBWgFD
         yuf3Ue9z5v7Vaa7FsC9cHzDfA+CwRr7M41isRpX4c5KEfIoPICoNXdM9e/0IL2Y8S9Je
         Is9tdNgj2qmYAdh+fWyO/3nJOzTa+aGUcdWIVGo0xdN+vdX766K1s6/woXwyb+/nyYbN
         rign7egMM/NP/46hy7V6yL7M3yylWxV3+kzkKbrWJOCG0pvOTCGSmSi8Vl+2KkZIcN84
         D3OUKtQRgVtGUfVa15GznJy0ZCl7sZEUqYzHObPBkL8k70mKDbJ0kU9fsu9O/YvcqCOC
         jz/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NYaUg5HujR7sQmyawubmYl3hcJlxfTXuEKXFBZh5EIc=;
        b=f+kzm0PkY1uS2NCfXEdFdnMRsPTb/FzLG9M/EnvTzNUC4awUbvYG6f+RTduPRyL6zR
         eDcsHVF8ULwA6E4eVRnFXLxRl5sdjdyYIJ4v0hdXjvx0TjF9951BGG3iaAndnltvvR1/
         3TgeXAx6a3jS5HjjOz85Gw559tHB13Hou36oLZjKMWfbu0sIww2SB1TfptWpuGhi9G6A
         iCAazEy9rJ2oubKVorUDjoGrq+rBZIZFYbq6G4UYQCoEQcI/U4cS3ZnOoyMQeiAXXN/k
         H7zZLvUhOdqxYTy/6Mz8CcDbCYGX75wQL1kHYcdl5i/aiXCZeFchxb9Xbw2QqsPCxavW
         rNHg==
X-Gm-Message-State: AGi0PuZiHm2rQoXPU381XpCYRmYFy5vaLeqKgvvVW0l87S+sms1+1iQy
        9YpUTKGzTOJz0/hLK+Jl+/hTdMtYoVM=
X-Google-Smtp-Source: APiQypKBENGmsna8fKffRP5V2fMNHw/Sxc/xNdBGETyIGoaWr6WO+p7BbERfqYmoehmrWiUYKA2iHg==
X-Received: by 2002:a62:764b:: with SMTP id r72mr14420954pfc.207.1588866329524;
        Thu, 07 May 2020 08:45:29 -0700 (PDT)
Received: from ?IPv6:2620:10d:c085:21e8::1239? ([2620:10d:c090:400::5:ddfe])
        by smtp.gmail.com with ESMTPSA id n9sm210681pjt.29.2020.05.07.08.45.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 May 2020 08:45:28 -0700 (PDT)
Subject: Re: [PATCH for-5.7] splice: move f_mode checks to do_{splice,tee}()
To:     Pavel Begunkov <asml.silence@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jann Horn <jannh@google.com>, io-uring@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <51b4370ef70eebf941f6cef503943d7f7de3ea4d.1588621153.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e960f9f6-76ed-5c37-286f-9f8630336520@kernel.dk>
Date:   Thu, 7 May 2020 09:45:27 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <51b4370ef70eebf941f6cef503943d7f7de3ea4d.1588621153.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/4/20 1:39 PM, Pavel Begunkov wrote:
> do_splice() is used by io_uring, as will be do_tee(). Move f_mode
> checks from sys_{splice,tee}() to do_{splice,tee}(), so they're
> enforced for io_uring as well.

Applied for 5.7, thanks.

-- 
Jens Axboe

