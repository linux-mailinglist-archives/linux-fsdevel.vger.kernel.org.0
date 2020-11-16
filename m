Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 747202B41E1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Nov 2020 12:01:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729435AbgKPLBJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Nov 2020 06:01:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729430AbgKPLBI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Nov 2020 06:01:08 -0500
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75ACEC0613CF;
        Mon, 16 Nov 2020 03:01:08 -0800 (PST)
Received: by mail-io1-xd43.google.com with SMTP id m13so16899998ioq.9;
        Mon, 16 Nov 2020 03:01:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KhjOnb4QUN3w0CmSJ2KWQ6YBoBY/KBX+nT1jorDtw8I=;
        b=rvg0OYKhs9uQFpWyPG+DegNwZpslEgG69iKKf3s8xaBceH3iYmLl1SnYSxRlX+HkSM
         wjrdDeqgifiTRhK/XSUWtYKJB11AN2+kiyMVupDO435P6QFHnYcRZgUjMN4dvqD1R8KZ
         RZdPrupZ/dxoJthV8WfT5Pc0cKdZetraIiW8PbRbCfrb4sjalO3MyiBGlCS9gQ31jvLy
         5kU7c78tbIuyJYUdTXG9pKSS9iCko5f6SwYYbRCRcQaNFJOeuiPkI9Wlit9EjVP6OXTf
         V69T7udtVCRAwesi7kY9Pk8Afebevh5ccuZaAQxBo+YEAQRuIQ9+2kF9FwhG4aJWyA6O
         y+mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KhjOnb4QUN3w0CmSJ2KWQ6YBoBY/KBX+nT1jorDtw8I=;
        b=Jw5C999lSUGeK40qmZyqXSP4g7/1BG5oo8LRsrCpNAS0DCtuXWev0nid9M2coVY1co
         ZuiFCwwXkvX5S7qnfA8ei2MeD4yHAoKtrS636eiJ6ISm/qlzMMpiLdj8CSN56hfrZCZK
         LCV3rjkAJcCkMPHSIYdO+GJem+vCxBOAmknyqnltn/i2dqsiB3nEOyxrtfv3YzfARd/A
         Q6xO/uO/DjRZr43ZmZKk8mcv4JILeh9PYXL4b3bnCgAoytHrFqJQfc+bN/iFjjAWIQal
         M7gbZO+WMYyTlRSwzqzkaIdZGw9O6JwbC86L0XXlf8lZHIyIQfOGbYXHitZxdYbGZAXY
         afaQ==
X-Gm-Message-State: AOAM530udsNmZIxQjNVCJFpOC+IkZ1bKytjxMWlQy/5NmUnoQZFdMdIL
        g+V92Fq5HH6tiR9sAQy0bJtZOsgFyuNccnEP85w=
X-Google-Smtp-Source: ABdhPJyy3Ne/vQSURiy0qN2Iy4vLG0JPTwFkGD7Y8gBYmhHYgg/dF3ZYlvSAxDPnHWaWyjkrCdcYhgRbJ68X0VD1oQ0=
X-Received: by 2002:a02:883:: with SMTP id 125mr10148700jac.30.1605524467747;
 Mon, 16 Nov 2020 03:01:07 -0800 (PST)
MIME-Version: 1.0
References: <20201116045758.21774-1-sargun@sargun.me> <20201116045758.21774-3-sargun@sargun.me>
In-Reply-To: <20201116045758.21774-3-sargun@sargun.me>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 16 Nov 2020 13:00:56 +0200
Message-ID: <CAOQ4uxg6p1ip19U7+f2RR=k79Amzrzajc1yG3bvQ0qaiRWL5PA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] overlay: Add ovl_do_getxattr helper
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     overlayfs <linux-unionfs@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Daniel J Walsh <dwalsh@redhat.com>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 16, 2020 at 6:58 AM Sargun Dhillon <sargun@sargun.me> wrote:
>
> We already have a helper for getting xattrs from inodes, namely
> ovl_getxattr, but it doesn't allow for copying xattrs onto the current
> stack. In addition, it is not instrumented like the rest of the helpers.
>
> Signed-off-by: Sargun Dhillon <sargun@sargun.me>
> Cc: linux-fsdevel@vger.kernel.org
> Cc: linux-unionfs@vger.kernel.org
> Cc: Miklos Szeredi <miklos@szeredi.hu>
> Cc: Amir Goldstein <amir73il@gmail.com>
> ---
>  fs/overlayfs/overlayfs.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
> index 29bc1ec699e7..9eb911f243e1 100644
> --- a/fs/overlayfs/overlayfs.h
> +++ b/fs/overlayfs/overlayfs.h
> @@ -179,6 +179,15 @@ static inline int ovl_do_setxattr(struct dentry *dentry, const char *name,
>         return err;
>  }
>
> +static inline int ovl_do_getxattr(struct dentry *dentry, const char *name,
> +                                 void *value, size_t size)
> +{
> +       int err = vfs_getxattr(dentry, name, value, size);
> +       pr_debug("getxattr(%pd2, \"%s\", \"%*pE\", %zu) = %i\n",
> +                dentry, name, min((int)size, 48), value, size, err);
> +       return err;
> +}
> +

upstream already has this helper.

>  static inline int ovl_do_removexattr(struct dentry *dentry, const char *name)
>  {
>         int err = vfs_removexattr(dentry, name);
> --
> 2.25.1
>
