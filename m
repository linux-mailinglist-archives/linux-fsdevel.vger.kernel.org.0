Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CCA16A26F6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Feb 2023 04:33:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbjBYDdf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Feb 2023 22:33:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjBYDde (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Feb 2023 22:33:34 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8DF3106
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 19:33:31 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id ee7so4999394edb.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 19:33:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=D6emmK/84159cRFlNViGvusDlD5gFIIfsUoa5uDy+co=;
        b=QH02ClObWdS4jvMlh+O8aUUUTPBFxzMq6ZZc2YNNvzr7GAUVW9Eu5Ac38LvVnsbxB2
         zEJKFVFyqZblmo2NO8AYVhrFek/FxLA8unrsXVU9+1SxEZnlU6AJqqG6oGZr/9FqFfnu
         OiDMh6HNfHjBu/x6z6L2VWS47OrAjc5NVd3Yc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D6emmK/84159cRFlNViGvusDlD5gFIIfsUoa5uDy+co=;
        b=hEJqPsX49gEtZHjyBmnyEXYY98fbL0ao0mTc4zYt/m3X01r92cs6ymoAeuNpPG3hR2
         bxe3OiTWZ2b5ElRibMvcdj13sYEPKDZTC50vJh/KlpNVadvPrP9nC++1c432Q9U9gfY1
         +qBElHOzO7HN3fLK/MevgYyl9VVDzCZRcFmLQdwsVqaYlJC/AklcXxkwi9kp9BcU6kuQ
         MCC8c8gOlzE0rldVRrN7kW7ehixgQEDAWOMvnmMyUGODAfkrh9E84kN8sa0m7ETug0Xw
         LuQu5wkOhGtUeKwkxcGLQMqwmQQVxN7+tZQru9AvjjJrsARNtjvxCUVAMvi5ygUX/8B5
         KbCQ==
X-Gm-Message-State: AO0yUKWhuPTc2AWhYE3dVXF6RYxslfUDWka++mjLYgzodK1d2cFDusNi
        U0iXgX224nRdHIGR5fTJfiP2L1xbzpFsMBKCXPQs5Q==
X-Google-Smtp-Source: AK7set/lzCTl3GLc09moCXtYsfgzK1FxL3f8Qlv7qOKezQ1q+1U/lpeFMa6rpcKCy2HZ4spusBdsaQ==
X-Received: by 2002:a17:906:d7a8:b0:8af:5752:691f with SMTP id pk8-20020a170906d7a800b008af5752691fmr23091931ejb.76.1677296010191;
        Fri, 24 Feb 2023 19:33:30 -0800 (PST)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id t22-20020a1709063e5600b008cdb0628991sm339470eji.57.2023.02.24.19.33.29
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Feb 2023 19:33:29 -0800 (PST)
Received: by mail-ed1-f43.google.com with SMTP id cy6so4932287edb.5
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 19:33:29 -0800 (PST)
X-Received: by 2002:a50:aa9e:0:b0:4ac:b616:4ba9 with SMTP id
 q30-20020a50aa9e000000b004acb6164ba9mr8454339edc.5.1677296009264; Fri, 24 Feb
 2023 19:33:29 -0800 (PST)
MIME-Version: 1.0
References: <Y/gxyQA+yKJECwyp@ZenIV>
In-Reply-To: <Y/gxyQA+yKJECwyp@ZenIV>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 24 Feb 2023 19:33:12 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiPHkYmiFY_O=7MK-vbWtLEiRP90ufugj1H1QFeiLPoVw@mail.gmail.com>
Message-ID: <CAHk-=wiPHkYmiFY_O=7MK-vbWtLEiRP90ufugj1H1QFeiLPoVw@mail.gmail.com>
Subject: Re: [git pull] vfs.git misc bits
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 23, 2023 at 7:41 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> That should cover the rest of what I had in -next; I'd been sick for
> several weeks, so a lot of pending stuff I hoped to put into -next
> is going to miss this window ;-/

Does that include the uaccess fixes for weird architectures?

I was hoping that was coming...

               Linus
