Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34C041908CE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Mar 2020 10:14:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727164AbgCXJOt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Mar 2020 05:14:49 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:43118 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726413AbgCXJOs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Mar 2020 05:14:48 -0400
Received: by mail-il1-f193.google.com with SMTP id g15so6901326ilj.10
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Mar 2020 02:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=idRBFZHevxncnQX6Z0RjeW2nH+FIN4Tl94zjLZQFZrk=;
        b=mawpFpcXkLQaAgJmcSHYiaUUaN/PAdffqBO4dJiT8nAxzFbDbDXk3TDb8xCX9tWZKz
         z+PHUwNPLt9qXYrkRBZjErlGk8KKSSRx7y52Oi5nolOZptX/2lwvsDFU6KSPr8m/YJvf
         t/kWo/O/F6xhlHhkW1q7KcerhtMh3QBgQKAqE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=idRBFZHevxncnQX6Z0RjeW2nH+FIN4Tl94zjLZQFZrk=;
        b=GrlWrX4uwMNv6B0Xb/G6Uhh2CKeXOrUeqSZHpICUNIhDRoOZ9amD1N21vLp0asZCtO
         8SmA+n+0fm4uUGOEG6eGaVHxrlVjr13mwAyL702gDOSGdVIRcIUbY1DBf29JAA0dIbsB
         Vb2FG5eUzbXAg/gxebY7ICDnFKoaTADI7z/HWIScoc3ZXbxJXXNhFccpN2EUpymmpicx
         ZlHMv2CMwc9asfl6U4Kd+OfJWSMFjcT3uQe/e2Yhmno657hMDdXLenLnO4OOVol+zwTq
         kJ4ug5pe1OjUZIw2Ux2OV9msM1WDRPZ/NGhb1YH0rtzGm0TSTzd+QA2y0res26tygwBm
         2Nog==
X-Gm-Message-State: ANhLgQ1SCmcPjzQc/2KhseQ627c42PhFoW3YodHttDYNrksQZxSC3cQS
        PWQD4gS4RFXpW/1SyEHpjb9/HftAWpKrsZmKd2Zqhg==
X-Google-Smtp-Source: ADFU+vv/EtqL1xia+pVcJK+M1JWBTeuYDj7tqnHlidtENeeEMrC1eM8+C/FvCnEi+Ji50mb/A4rgY0zFHyU7tOxKawQ=
X-Received: by 2002:a92:9fd0:: with SMTP id z77mr25847759ilk.257.1585041287116;
 Tue, 24 Mar 2020 02:14:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200324075017.545209-1-hch@lst.de>
In-Reply-To: <20200324075017.545209-1-hch@lst.de>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 24 Mar 2020 10:14:36 +0100
Message-ID: <CAJfpegvt=BSHg1ZYeqzpToqbvuo1RrK5o0Gnxq-dzwM6XZ9drA@mail.gmail.com>
Subject: Re: [PATCH] fs: move the posix_acl_fix_xattr_{to_from}_user out of
 xattr code
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 24, 2020 at 8:50 AM Christoph Hellwig <hch@lst.de> wrote:
>
> There is no excuse to ever perform actions related to a specific handler
> directly from the generic xattr code as we have handler that understand
> the specific data in given attrs.  As a nice sideeffect this removes
> tons of pointless boilerplate code.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>
> Changes since v1:
>  - fix up file systems that have their own ACL xattr handlers
>
>  fs/9p/acl.c                     |  4 +--
>  fs/overlayfs/dir.c              |  2 +-
>  fs/overlayfs/super.c            |  2 +-
>  fs/posix_acl.c                  | 62 ++-------------------------------
>  fs/xattr.c                      |  8 +----
>  include/linux/posix_acl_xattr.h | 12 -------
>  6 files changed, 7 insertions(+), 83 deletions(-)
>
> diff --git a/fs/9p/acl.c b/fs/9p/acl.c
> index 6261719f6f2a..f3455ba2a84d 100644
> --- a/fs/9p/acl.c
> +++ b/fs/9p/acl.c
> @@ -232,7 +232,7 @@ static int v9fs_xattr_get_acl(const struct xattr_handler *handler,
>                 return PTR_ERR(acl);
>         if (acl == NULL)
>                 return -ENODATA;
> -       error = posix_acl_to_xattr(&init_user_ns, acl, buffer, size);
> +       error = posix_acl_to_xattr(current_user_ns(), acl, buffer, size);

Okay, but the uncached cache is still broken.  It needs the xattr to
be converted to acl (posix_acl_to_xattr(&init_user_ns, ...)) then back
to xattr here.

>         posix_acl_release(acl);
>
>         return error;
> @@ -262,7 +262,7 @@ static int v9fs_xattr_set_acl(const struct xattr_handler *handler,
>                 return -EPERM;
>         if (value) {
>                 /* update the cached acl value */
> -               acl = posix_acl_from_xattr(&init_user_ns, value, size);
> +               acl = posix_acl_from_xattr(current_user_ns(), value, size);

Same in this function.

Thanks,
Miklos
