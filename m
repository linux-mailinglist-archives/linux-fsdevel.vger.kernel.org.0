Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3BA142CAB7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Oct 2021 22:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239107AbhJMUO0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Oct 2021 16:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236302AbhJMUOX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Oct 2021 16:14:23 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 130ABC061746
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Oct 2021 13:12:20 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id v17so3801228qtp.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Oct 2021 13:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20210112.gappssmtp.com; s=20210112;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=2Aa4y4Us+FR2jyMccX84KTkQsvr7Mr0uoXoatsk4aIU=;
        b=oY++jyBrNzEdT1LlYyI5ambjGnFGPKL/BS9hKAHoYT2QVdBtKYcUt4dkhXLNiGgV8c
         QWCe/D1tL6HAFm5xNw9hm4UfDF7SbOJj8S7HBBrUCTlrSWa3CJyMBEPso8/Rlm5zJX2x
         N6ZU+Xd4fxl6lD5YqSEPqMlKyp+L/d9vweQaoi6FciU/izUTjZz2IbvlG4vnz/2fw/5W
         oknr1QZmUQHNQyRIMdB1eWK9j7WtBCSSgGRkgyK0dZ0JhTowcpY+gm0OkN4/Uh+4IGvA
         JIk1yyxLtMUNf7GZFjUaSY7qj0JWClp+0iHymZ3LBna8MExS4qMw9+2CpgJoL1F2vcMz
         UbtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=2Aa4y4Us+FR2jyMccX84KTkQsvr7Mr0uoXoatsk4aIU=;
        b=NT/8+0cN3k/AYqkvfV+k7EflHQNH9e/2A/cMYSUBvP/osaWZLk+42hGEl8Y94Nwgce
         NcQfsKjqTweh/1a2YC2/YE21YGovu1cVF9JElRQlyLv0cYaJmoY9CKL+lVj/SBBpMbmF
         Tl6Xvqf2unkFd8wWe/KDX/4gxVo8g+iuSIex9WFzUoKKMMsBxx+nCGYxeGiUdb0gDplA
         wXrqOpyXSawOaDMGWMiy2P6aV5mQnzif7zw7lSwyegczUwujTpRttinWV8PZTqrKqxAJ
         OEY2uEhq5/2JzQNGr2f9cavov4UD9di3YsTzAsXQts2yiqR3FfmvwcGuPctVia24BX0p
         ZITg==
X-Gm-Message-State: AOAM531ycm9r77bnI8Wldd2TfXNW/Jgk93QTj/kyAFqp3uKTXv5i2Hcv
        e7hLd5Gfl88/o3eHBm8hSRlvvxCc53KJpg==
X-Google-Smtp-Source: ABdhPJx4zdxYJSt0EevBomv3rQbbQ4b37KN/6V2YFRu2hE3Q4HWDzRT5ObF4KPkBzDyL37PZoHpsLQ==
X-Received: by 2002:a05:622a:1444:: with SMTP id v4mr1676745qtx.298.1634155938909;
        Wed, 13 Oct 2021 13:12:18 -0700 (PDT)
Received: from [192.168.39.11] ([172.58.87.41])
        by smtp.gmail.com with ESMTPSA id 101sm358957qta.17.2021.10.13.13.12.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Oct 2021 13:12:18 -0700 (PDT)
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
From:   Rob Landley <rob@landley.net>
Subject: The one and only "permission denied" in find /sys
Message-ID: <cd81a57e-e2c1-03c5-d0da-f898babf92e7@landley.net>
Date:   Wed, 13 Oct 2021 15:12:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There is exactly one directory in the whole of sysfs that a normal user can't
read (at least on my stock devuan laptop):

  $ find /sys -name potato
  find: ‘/sys/fs/pstore’: Permission denied

It's the "pstore" filesystem, it was explicitly broken by commit d7caa33687ce,
and the commit seems to say this was to fix an issue that didn't exist yet but
might someday.

Did whatever issue it was concerned about ever actually start happening? Why did
you not change the permissions on the files _in_ the directory so they weren't
world readable instead? Should /dev/shm stop being world ls-able as well?

Confused,

Rob
