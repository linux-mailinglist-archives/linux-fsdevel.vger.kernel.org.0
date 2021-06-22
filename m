Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6E23AFE9C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jun 2021 10:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbhFVICO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Jun 2021 04:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbhFVICN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Jun 2021 04:02:13 -0400
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFE47C061760
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Jun 2021 00:59:57 -0700 (PDT)
Received: by mail-ua1-x930.google.com with SMTP id r4so6435498uap.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Jun 2021 00:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IUabWVtZHx2dTSQcRwCN6g7MjKpZA+tpLjczy/yFwyc=;
        b=E66Oz0kswhiilzbX4KUws3nTA4yhiVCScCyXt6ang/4+2oExW+VjYJ76xVJfiQV09y
         gJFU0gspYTFqclPo+3nzmHay6r9+mvfaeS0QVQE/n4ZJ3dPogdj0HeVmCqugG78cOfls
         cdOWFUNklMvCMkvGTRAu2UIMNDzg3fKLb2Q7k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IUabWVtZHx2dTSQcRwCN6g7MjKpZA+tpLjczy/yFwyc=;
        b=PXx17H2pgSsuvXMJfDlhvoLku0Z+z/V4kQktBNGu4OMihItxzEcNw3FsnwIq5RQ4Wa
         /rsvuj387fiU92hWlYl88/gMVkqJ77oEWY0oOyhx0CsMb1xAsOx1w3Gxx5T3AsV35dLO
         +1MyZfmDT/FHSxsBB5j1FEbCan6ci/OUMdCAZP0jSSxpfokpwMjSWy2b6n6wqAC2ADp9
         51w1xTms2qqwhPyR1+gHJbiaSiIpLRy+gYSit6hMo86s8iKnfNLMXsG8A5L36aO9B/ZJ
         gsbcXOv3eCxrjR91cGt72QEen9IWGhdD362P1JTJPeug27T/ZH0pheXcxLogdx3aw13M
         zq5Q==
X-Gm-Message-State: AOAM530CF44gv3Y/gE856ex1Iw8fJ6pd4/LRZk+s8qrJ0v+uqBIjkpxC
        7Q6VwNbS7O+C9BCsqEgJEBaHVDfBbCFzJ4fS8Iw6Ug==
X-Google-Smtp-Source: ABdhPJxRbwnCrK/LmzTxr4KORMM1Sa+4VZ8zwoBNNEDw/SGcSqX1mQ8M9QJLWOkllit9Cw0A0fHoJuN9peFNXvgkTFM=
X-Received: by 2002:ab0:6448:: with SMTP id j8mr2227401uap.13.1624348797007;
 Tue, 22 Jun 2021 00:59:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210130085003.1392-1-changfengnan@vivo.com>
In-Reply-To: <20210130085003.1392-1-changfengnan@vivo.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 22 Jun 2021 09:59:46 +0200
Message-ID: <CAJfpegutK2HGYUtJOjvceULf2H=hoekNxUbcg=6Su6uteVmDLg@mail.gmail.com>
Subject: Re: [PATCH v2] fuse: use newer inode info when writeback cache is enabled
To:     Fengnan Chang <changfengnan@vivo.com>
Cc:     linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, 30 Jan 2021 at 09:50, Fengnan Chang <changfengnan@vivo.com> wrote:
>
> When writeback cache is enabled, the inode information in cached is
> considered new by default, and the inode information of lowerfs is
> stale.
> When a lower fs is mount in a different directory through different
> connection, for example PATHA and PATHB, since writeback cache is
> enabled by default, when the file is modified through PATHA, viewing the
> same file from the PATHB, PATHB will think that cached inode is newer
> than lowerfs, resulting in file size and time from under PATHA and PATHB
> is inconsistent.
> Add a judgment condition to check whether to use the info in the cache
> according to mtime.

This seems to break the fsx-linux stress test.

I suspect a better direction would be looking at whether the inode has
any files open for write (i_writecount > 0)...

Thanks,
Miklos
