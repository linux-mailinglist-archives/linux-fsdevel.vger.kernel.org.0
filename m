Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4164F462D05
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Nov 2021 07:45:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234027AbhK3Gs3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Nov 2021 01:48:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238778AbhK3Gs3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Nov 2021 01:48:29 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49181C061574
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Nov 2021 22:45:10 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id e8so20074235ilu.9
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Nov 2021 22:45:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wQK3cM3KhAajpW/hm9LyHnbGdcQA2StgFgNXM6VPGqw=;
        b=DyPtjGg/t04zRGYzknl5CYQMuMxcGTfbnwHKuyow0D82cW5z46TFcXwwJB+JD52NwA
         24GPNQmHMFBVdp2bNELqVOXSMNqE71k/35z7MLFsEjZv2+sYPEwKQW0t9AhJ6aFwMK3v
         4uisG4S631dSPUt+1qspWvAC79bLc/vuAdjoia4OaMUMVznWld4SJNx4PSAgPpKNa4RF
         Vb/nhAstO+Rq3Fya5dcc+J0k4TZGTqsMQK3z60LZ/Q4VnWX+edQzbrskkEgD9TJ/zDyH
         rMdec922jdlNU24Q8zoYCiW4Ah1hhIL0GwSr0krC0ih2Bm5OCzo2AqLsaSxqPszWJbxv
         xZtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wQK3cM3KhAajpW/hm9LyHnbGdcQA2StgFgNXM6VPGqw=;
        b=C2lgilry2sFHHvR+y97kHKNAvWBlyUge2j5rpI9gjePc7ESaDpEx5b7Nnu8FzQ454D
         ueDpncLtUq8tucijsPNEdmoUCsi03fgZJKzQTn2n4hA5eOtJjgD7hXJv1cGFjwIgA7FD
         yCjbnTPG0K1r+JDCSbFapmznQYQtiX0QFkbJruOfMWmg2G2I8sS78xw142engXj17+0v
         7QMAN/cWkYkaRscxGsnxqV8ICYGosahY9vIlgmFyTdaK+sHwuXHJpL3E9li/5qhJwd1s
         PT2O7bNhOwCprlesmcUyiG2mylr63WmOdrmJV52vpxD4WGvHyD1Lo2EOkzCQCGGLV5jQ
         zyHw==
X-Gm-Message-State: AOAM531O/4tmHacNVPIOoQIXmVrN/B/FwY8Wj7I7rvI+enjl033dn2bH
        qA8EWkU/I6uSlFnoYyruv6CkVLOUC92eVfn7ebg=
X-Google-Smtp-Source: ABdhPJzL8F63aqMf8TS20jlfjFDKOl+o12Jvid6/FMSeHodMMDJCVnUWX1RJ2PjHsUa4Jt0ga3wqBY7tGBK3rAld1/8=
X-Received: by 2002:a92:c88e:: with SMTP id w14mr51043150ilo.24.1638254709786;
 Mon, 29 Nov 2021 22:45:09 -0800 (PST)
MIME-Version: 1.0
References: <20211123114227.3124056-1-brauner@kernel.org> <20211123114227.3124056-4-brauner@kernel.org>
In-Reply-To: <20211123114227.3124056-4-brauner@kernel.org>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 30 Nov 2021 08:44:58 +0200
Message-ID: <CAOQ4uxgdwn8QSAHoubd7ZOWWn7hBoTu2naXdjv0fffEVQaMNGA@mail.gmail.com>
Subject: Re: [PATCH 03/10] fs: tweak fsuidgid_has_mapping()
To:     Christian Brauner <brauner@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Seth Forshee <sforshee@digitalocean.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 23, 2021 at 3:29 PM Christian Brauner <brauner@kernel.org> wrote:
>
> From: Christian Brauner <christian.brauner@ubuntu.com>
>
> If the caller's fs{g,u}id aren't mapped in the mount's idmapping we can
> return early and skip the check whether the mapped fs{g,u}id also have a
> mapping in the filesystem's idmapping. If the fs{g,u}id aren't mapped in
> the mount's idmapping they consequently can't be mapped in the
> filesystem's idmapping. So there's no point in checking that.
>
> Cc: Seth Forshee <sforshee@digitalocean.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> CC: linux-fsdevel@vger.kernel.org
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> ---
Reviewed-by: Amir Goldstein <amir73il@gmail.com>

>  include/linux/fs.h | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index eb69e8b035fa..161b5936094e 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1695,10 +1695,18 @@ static inline void inode_fsgid_set(struct inode *inode,
>  static inline bool fsuidgid_has_mapping(struct super_block *sb,
>                                         struct user_namespace *mnt_userns)
>  {
> -       struct user_namespace *s_user_ns = sb->s_user_ns;
> +       struct user_namespace *fs_userns = sb->s_user_ns;
> +       kuid_t kuid;
> +       kgid_t kgid;
>
> -       return kuid_has_mapping(s_user_ns, mapped_fsuid(mnt_userns)) &&
> -              kgid_has_mapping(s_user_ns, mapped_fsgid(mnt_userns));
> +       kuid = mapped_fsuid(mnt_userns);
> +       if (!uid_valid(kuid))
> +               return false;
> +       kgid = mapped_fsgid(mnt_userns);
> +       if (!gid_valid(kgid))
> +               return false;
> +       return kuid_has_mapping(fs_userns, kuid) &&
> +              kgid_has_mapping(fs_userns, kgid);
>  }
>
>  extern struct timespec64 current_time(struct inode *inode);
> --
> 2.30.2
>
