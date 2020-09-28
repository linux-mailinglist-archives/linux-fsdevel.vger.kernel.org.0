Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73C3427AF92
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Sep 2020 16:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbgI1OCN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Sep 2020 10:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726348AbgI1OCN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Sep 2020 10:02:13 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4543C061755;
        Mon, 28 Sep 2020 07:02:12 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id h9so1007571ybm.4;
        Mon, 28 Sep 2020 07:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=dkyo8YCHgnrpbLgoEtVwNnrBxmfXSOu3Lqhnq9hqnlU=;
        b=kGyWZIIp5KWHAGEvNGD57Jds877X3K30zUvrXMhCc2uGut7+7RFaiCu90WSaeaNwOM
         d8wtBroD9M2FLfLJdOrX/buE+n96izF0nKrSYXOuIg6OD30rVF14YzFKy8rpxvtT5Fjk
         wVE53d3XHzGKunmib6ALKFy3VbutjolaGRb0Kr0zY3Pf4JPGuXQ1QOxRKshk7MeOoQzt
         FJBVuUd8GPQW3kWzHpxa5R4FccXnumytkjL2sU2AujF1pG1E3jQlVH8EBYl4WZS1yVm3
         MWf0+CX7hQrPHpucd/4SyLLvlbXEAyiM7lMJ7MtJNCfTiUoMCauZpOEnhTELypeC8B8M
         WI/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=dkyo8YCHgnrpbLgoEtVwNnrBxmfXSOu3Lqhnq9hqnlU=;
        b=Y9xd0z5iRnCVBASnEcvxv4+cpNclNjb0SNnhmhdz8vmLYAxrwBnVkA2CPD2JAtPn0X
         nVrb9SoTfkU1+BBl8MrmvdO/oEUh9YUaXM4l0seiAcKgZ6dhc7jJnPzsnx4b+qFjNTVE
         GaBUabEp3/nfVaoXMUmHuyE7ZFvhvVHQmmH2FSh3CY+K7S/7fauWrvjJI5xiX+DKogTt
         5nB7VGjXsqnJ7ZeTPopMW0dlM8X1DmLch7VIwL1V84cLiUkvya3zZFFcNA+rtUsvT6Tx
         It6RYmpv6JPyEdzoGam2Ar8X4Hq7SBR5KpPTiqHRySzbpBdRQIPMSKp5TvMKb651ePNj
         UNqw==
X-Gm-Message-State: AOAM530CoWOE6Gl9utvh8n8OPsT9yHxnPIylQ3pU/Rmqc1oeBShkFNef
        45NklKyLABj99KTDjqHCi1UcHwrxoEqDRCvPoKNKeqAi4t1xaw==
X-Google-Smtp-Source: ABdhPJzjyxAmAQJq3yUMV41ZaU6Jib4Hra0UERJdaARNie1e5vycnV4dot72wEdcHL/iFF2THt+3kbIbKOzP/jul6kE=
X-Received: by 2002:a25:b219:: with SMTP id i25mr2027503ybj.52.1601301731841;
 Mon, 28 Sep 2020 07:02:11 -0700 (PDT)
MIME-Version: 1.0
From:   Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Date:   Mon, 28 Sep 2020 17:02:50 +0300
Message-ID: <CACE9dm_eypZ4wn8PpYYCYNuM501_M-8pH7by=U-6hOmJCwuxig@mail.gmail.com>
Subject: Mount options may be silently discarded
To:     linux-fsdevel@vger.kernel.org
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

"copy_mount_options" function came to my eyes.
It splits copy into 2 pieces - over page boundaries.
I wonder what is the real reason for doing this?
Original comment was that we need exact bytes and some user memcpy
functions  do not return correct number on page fault.

But how would all other cases work?

https://elixir.bootlin.com/linux/latest/source/fs/namespace.c#L3075

if (size != PAGE_SIZE) {
       if (copy_from_user(copy + size, data + size, PAGE_SIZE - size))
            memset(copy + size, 0, PAGE_SIZE - size);
}

This looks like some options may be just discarded?
What if it is an important security option?

Why it does not return EFAULT, but just memset?

-- 
Thanks,
Dmitry
