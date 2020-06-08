Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE6C1F130D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jun 2020 08:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728955AbgFHGrX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Jun 2020 02:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728872AbgFHGrX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Jun 2020 02:47:23 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E45DCC08C5C3;
        Sun,  7 Jun 2020 23:47:22 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id 18so15633051iln.9;
        Sun, 07 Jun 2020 23:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=pONzFk++nzpoY/RlOuAifK82h6omdI4pj0fMHoXEfWo=;
        b=cTc+qpP/ayXColow+A1AXbro5tg9sS1A9bwHxwX4dENllksIRKfcU+4vjvZaoTJ7Vz
         FizzKOjqzoYkCeuPg2TibQuuaetCTtrIWgTLxrxJawc5U8OoCBOYoVttYBgx4R1m6LAI
         2m40oBrP6nUIEKjcCEiFYNAU4wUzwUQ/Ai6kxarluox69xUiEo/q8yEus9rJCpzYh0cQ
         Jj1ReGdn/SqebNBOUFyybAR1J90IBx7grHtrRLoosfOzKy7/uTibs2077fzdBRp1Wk89
         cACBoP2KSo8GgnwzY/Oec8lmDeJcu5nHKaIiqkIJs9oTq/Hv2y6jJJX9PdyOvfSaE9lK
         eFqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=pONzFk++nzpoY/RlOuAifK82h6omdI4pj0fMHoXEfWo=;
        b=Hp3idkpaZ/u4ij/YpUBk2fXWIcKIeJNLe+lkM5XcN7/Dda8HI63x4jO5ikkh1mx/21
         Bn64gP1p22Ar2Jnd4OkRQ5SXbcU50JwAMJNX7+PZDwcyQuJ/Dw9KkGQD0v7uYFwKTpxo
         Ad1ZfYyBP1DjrDUSWrirN97Mr+VLfKN5jkjTuzo1eyJv+KUH5BFZUxxXUX7lnEnl+Fdh
         zC5q5AhVTSSXArmf2xzoAOKh4pB6CCPWQk+iqAok3cHxrvju1Npc8PmTOHqZ/CFnyuux
         gOIqo9x5JZ8FcmraWk1C4UePyF1GxCfkua3sLoyDPvIskw9YP0R68fqtfJ1QPWD0uaM3
         /AMA==
X-Gm-Message-State: AOAM533GfyXlJdhNUxPJ9ESucHi0WLjy+VERRPp+1qnVHrk3vr/m1wAq
        MXjUPt8J1lzbJCbmthR++WrPIwANNVWuFre5pH3eR4pEJFI=
X-Google-Smtp-Source: ABdhPJy9CbSNGhv1Le/5MU88gv8hNYpr1HXAFyg11tQlYzXrFyoBcRhTQVbkzMXS7kc0hih2cj5OAhix/RHETBNQq4M=
X-Received: by 2002:a92:3646:: with SMTP id d6mr21207544ilf.255.1591598842273;
 Sun, 07 Jun 2020 23:47:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200608020557.31668-1-yanaijie@huawei.com> <20200608061502.GB17366@lst.de>
In-Reply-To: <20200608061502.GB17366@lst.de>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Mon, 8 Jun 2020 08:47:11 +0200
Message-ID: <CA+icZUUks4oJGJLhiRLTJTzyNxfsT_TZQ12MMvBVLXSaR8t0zA@mail.gmail.com>
Subject: Re: [PATCH v4] block: Fix use-after-free in blkdev_get()
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jason Yan <yanaijie@huawei.com>, viro@zeniv.linux.org.uk,
        axboe@kernel.dk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>, Jan Kara <jack@suse.cz>,
        Hulk Robot <hulkci@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 8, 2020 at 8:18 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Looks good,
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
>
> Can you dig into the history for a proper fixes tag?

[ CC Dan ]

Dan gave the hint for the Fixes: tag in reply to the first patch:

> The Fixes tag is a good idea though:
>
> Fixes: 89e524c04fa9 ("loop: Fix mount(2) failure due to race with LOOP_SET_FD")

> It broke last July.  Before that, we used to check if __blkdev_get()
> failed before dereferencing "bdev".

- Sedat -
