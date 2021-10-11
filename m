Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21386428DB7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Oct 2021 15:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236869AbhJKNX3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Oct 2021 09:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235346AbhJKNX2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Oct 2021 09:23:28 -0400
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA27C061570
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Oct 2021 06:21:25 -0700 (PDT)
Received: by mail-ua1-x92d.google.com with SMTP id h4so12763387uaw.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Oct 2021 06:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yZuw+G5k4EE5nQg4+lZ838nfoIOMaKPkdgIFTvIeT3Y=;
        b=i4mSoskBVC4aBafH2bUNTh2pTaphbeElYOjJwxePe8l3AX3ZrQzJG451CCjo6+Ieqq
         qeUUjwe8QCArk3HAbUQ5Z+iW+qeS9FZZzHP7dCRaLL5w2K3Y4jL3l2G8RfUXldOrDet0
         FiyhPwUQBrOFuESIHNWxbPzOAfu/gy099nywY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yZuw+G5k4EE5nQg4+lZ838nfoIOMaKPkdgIFTvIeT3Y=;
        b=p9hCFns/g4V/8bF4gMimcdBYrbR+6VXM43A+92vGMhxwkjYLh4vZY0TpYHBRvc/fJ4
         THffn7R9h/miH1jEctGhwLxrd1X8r+5ZJnjxTkWmjVU5QVwUtdQGS1hpV5HLv1P54s2W
         plmYCDIbyUUdahPTpteyRdPbacf8RA2/T8BRj47dNa2kwuQZ/R/767an95v0Lmbemw/M
         SZbvg6K3uUXM6mwhLIgVfr1JapfJ8JHV61wUjvJdSDgodVIa6gEaIZPpnlDYlzFhzber
         fQY6NmJnGdu9dIU3OLbRBfmGkZB6x0L9rDzXl5Y0LWx84TJNUGrSOL4EfopOLs5ttFmn
         NLrg==
X-Gm-Message-State: AOAM530eCa9iYooRC2PWfXG/ggPmlLaLDXBflqLtrSbjT/sdCYWW8Rdt
        9noHl7NMG3ZIH3i+L8AQHZho19zLmkTxk+oI+Nt6cw==
X-Google-Smtp-Source: ABdhPJwGWheOwbemxFqDny8FcSOMMI5ee2xKL3gi9hE8yA6cf5ZfVErzvaxTwNZYrOObIGhVrll+VlefoOYKoS/TNY8=
X-Received: by 2002:ab0:5741:: with SMTP id t1mr14380975uac.72.1633958484115;
 Mon, 11 Oct 2021 06:21:24 -0700 (PDT)
MIME-Version: 1.0
References: <20211011090240.97-1-xieyongji@bytedance.com>
In-Reply-To: <20211011090240.97-1-xieyongji@bytedance.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 11 Oct 2021 15:21:13 +0200
Message-ID: <CAJfpegvw2F_WbTAk_f92YwBn3YwqbG3Ond74DY7yvMbzeUnMKA@mail.gmail.com>
Subject: Re: [RFC] fuse: Avoid invalidating attrs if writeback_cache enabled
To:     Xie Yongji <xieyongji@bytedance.com>
Cc:     linux-fsdevel@vger.kernel.org, zhangjiachen.jaycee@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 11 Oct 2021 at 11:07, Xie Yongji <xieyongji@bytedance.com> wrote:
>
> Recently we found the performance of small direct writes is bad
> when writeback_cache enabled. This is because we need to get
> attrs from userspace in fuse_update_get_attr() on each write.
> The timeout for the attributes doesn't work since every direct write
> will invalidate the attrs in fuse_direct_IO().
>
> To fix it, this patch tries to avoid invalidating attrs if writeback_cache
> is enabled since we should trust local size/ctime/mtime in this case.

Hi,

Thanks for the patch.

Just pushed an update to
git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.gitt#for-next
(9ca3f8697158 ("fuse: selective attribute invalidation")) that should
fix this behavior.

Could you please test?

Thanks,
Miklos
