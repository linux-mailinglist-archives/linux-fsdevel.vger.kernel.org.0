Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE651C0D1E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 May 2020 06:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728212AbgEAEOQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 May 2020 00:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726452AbgEAEOP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 May 2020 00:14:15 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61121C035494
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Apr 2020 21:14:14 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id n16so4057920pgb.7
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Apr 2020 21:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SpZmYE1xlGDv5YUeWwpXaENpO6djzIF95gIpAMiKvcQ=;
        b=tA6r6SXt3t1la2kN+V6N2VgvtAVb8ehDf6uMCAs1BkSMlrJt1Tt5hQKktqO/sroMVr
         ikSrIj8fLHtODl9SzLEGFDPguzcxJSMNExTvH3rGrejaTbqTkRwFsAKHgZrnmcG0PFmf
         lCGXmGHcXjytGo2Z9avfJmfz4aIewE61ujvx+COaAteEMDLCcX1NcOw6nkV3SoJip3GD
         LNKo7C6fTqwLON3TS6qqWjFwGcirh7a4tZQ1VF1yOpkY0Dq64QYiOwjS6YJ7jucgaV8Y
         qzF0Z27P8OOuqo7EmxVO3wrPpeXuhgynNnRJmjzmDblp6E/6iU+LhyCOdWPOI1/O81Ys
         8+bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SpZmYE1xlGDv5YUeWwpXaENpO6djzIF95gIpAMiKvcQ=;
        b=RfZNpk8cn7UCQmO4pxARxjsmq6bz2fJeaxIoa+g9Jbmq9109a5hLI7wzr46Rf3oxzE
         mH+iEoWlIPWPnBLyvCtjvNFK7+FCDDlOZH1gZwurbzS9twIMOBLHjvBFp6Iija9ZiScI
         iMVsaN7btNd/gCZjBuBaX2n9qmw4AAwE8YiDEepXu2URarEz/dwpuzF6hZJ6VCLxreYJ
         FuhMmkXUDh0pgm4SneETQxRvFlhfHwRUs/Qk0ZwkLYmxdMP0sCwP7WZi6r4Q3+8/PV+V
         kcSs9dskf+J148a+u5wnX95oIjzmJIA+swv1Ad3vZhKN0cCfldngeMoFLe3dlbRFt/Zs
         7HpQ==
X-Gm-Message-State: AGi0PubeCE8N/mj9qG6i0iNjl6CEUcJTXjFV9QbDC/GoqhCV3I2W0rdI
        7W83YanK30zVhe+zHSMti+2h3g==
X-Google-Smtp-Source: APiQypJgy1CgIoE3nhKap888MjfyWqDG3No8Dza7hofn0aWrjOQo+/NOQBbys16dCfH6auNhq+9OyQ==
X-Received: by 2002:a63:600c:: with SMTP id u12mr2317348pgb.318.1588306453685;
        Thu, 30 Apr 2020 21:14:13 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id b16sm1070422pft.191.2020.04.30.21.14.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2020 21:14:13 -0700 (PDT)
Subject: Re: [PATCH] pipe: read/write_iter() handler should check for
 IOCB_NOWAIT
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <273d8294-2508-a4c2-f96e-a6a394f94166@kernel.dk>
 <20200501035820.GH23230@ZenIV.linux.org.uk>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <210c6b72-179a-993f-1ec8-1960db107174@kernel.dk>
Date:   Thu, 30 Apr 2020 22:14:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200501035820.GH23230@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/30/20 9:58 PM, Al Viro wrote:
> On Thu, Apr 30, 2020 at 10:24:46AM -0600, Jens Axboe wrote:
>> Pipe read/write only checks for the file O_NONBLOCK flag, but we should
>> also check for IOCB_NOWAIT for whether or not we should handle this read
>> or write in a non-blocking fashion. If we don't, then we will block on
>> data or space for iocbs that explicitly asked for non-blocking
>> operation. This messes up callers that explicitly ask for non-blocking
>> operations.
> 
> Why does io_uring allow setting IOCB_NOWAIT without FMODE_NOWAIT, anyway?

To do per-io non-blocking operations. It's not practical or convenient
to flip the file flag, nor does it work if you have multiple of them
going. If pipes honor the flag for the read/write iter handlers, then
we can handle them a lot more efficiently instead of requiring async
offload.

-- 
Jens Axboe

