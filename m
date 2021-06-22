Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3668F3B089C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jun 2021 17:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232101AbhFVPWC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Jun 2021 11:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232161AbhFVPWC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Jun 2021 11:22:02 -0400
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87923C061574
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Jun 2021 08:19:46 -0700 (PDT)
Received: by mail-ua1-x931.google.com with SMTP id a14so1048582uan.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Jun 2021 08:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+1rMSC6bfyssiBC2lFevCKq4BZR29aW1MU41M50I5as=;
        b=U4s6uhp+Zsn+MRmOlmTJwRl6LHm4vOPvk1Ua3EyTPpDOxfUSbrx/4gG7pMc4cre7mg
         cr0+kpyljYl8k+BcGFTS3ojGF+4W0g2TOTrTBGQcrMb1yYYA6v4NureH2QrvG9cI0qzT
         qug45fKilhH8fZHh/fnHEtIFVZntQLAJFe6IE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+1rMSC6bfyssiBC2lFevCKq4BZR29aW1MU41M50I5as=;
        b=L0ErVia7h/2oUQJmt0ylxq/TdxY6U0N5NZy8wZ2OYRJN6XuRU9wj3irwFvyyfWR7f/
         1hhXVvAWJP/PmDEsS7mIfZtqehgf7JOGVIw74eXAcjgSpq7eCXkew/+hxJjvUJ3yyTuc
         SEWwAaUVN0EqCdp4LVPfom+ZvaxznqOgfu+Y551A1H7XBEPJnZHn4C3JZNbzdVailp1q
         hR79qX0TLkJOwXHbnPPEMygwdr2QDE5YO7Zy9CshFdf6MzjvCZk8LXqUSXNyUdfaMlMD
         iGDs+xaV0/IdwpEZz5jRmqCUP4RQ2p262uYdCTJ4z8pJSUZlViGopiCJeoMJ2oKwSqYH
         OHYA==
X-Gm-Message-State: AOAM532vNBkZZxd6UGqXfZqJfZDzJNggu26ClFQtTqQGRxWbRcyeqIEA
        tqSfeqA+7DlJUliConXyBxY43xSXWmRu+j40IltQCw==
X-Google-Smtp-Source: ABdhPJxjSsFY+ZqSiCzxHg4KHDvzazgJIaykUjwy4KYJDdsjbD8bvHcEWuYzuYwH8Qqd5AZRarScDPBjE5CUo978YIg=
X-Received: by 2002:ab0:2690:: with SMTP id t16mr4198951uao.9.1624375185694;
 Tue, 22 Jun 2021 08:19:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210130085003.1392-1-changfengnan@vivo.com> <CAJfpegutK2HGYUtJOjvceULf2H=hoekNxUbcg=6Su6uteVmDLg@mail.gmail.com>
 <3e740389-9734-a959-a88a-3b1d54b59e22@vivo.com>
In-Reply-To: <3e740389-9734-a959-a88a-3b1d54b59e22@vivo.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 22 Jun 2021 17:19:35 +0200
Message-ID: <CAJfpegtes4CGM68Vj2GxmvK2S8D5sn4Pv_RKyXb33ye=pC+=cg@mail.gmail.com>
Subject: Re: [PATCH v2] fuse: use newer inode info when writeback cache is enabled
To:     Fengnan Chang <changfengnan@vivo.com>
Cc:     linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 22 Jun 2021 at 14:25, Fengnan Chang <changfengnan@vivo.com> wrote:
>
> Unh, it seems i_writecount not work.
> If we modify file through lowerfs, i_writecount won't change, but the
> size already changed.
> For example:
> echo "111" > /lowerfs/test
> ls -l /upper/test
> echo "2222" >> /lowerfs/test
> ls -l /upper/test
>
> So, can you describe your test enviroment? including kernel version and
> fsx parameters, I will check it.

linux-5.13-rc5 + patch
mkdir /tmp/test
libfuse/example/passthrough_ll -ocache=always,writeback /mnt/fuse/
fsx-linux -N 1000000 /mnt/fuse/tmp/test/fsx

Thanks,
Miklos
