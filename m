Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C03A2D2C33
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Dec 2020 14:50:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729025AbgLHNuX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Dec 2020 08:50:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbgLHNuX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Dec 2020 08:50:23 -0500
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 113EFC061749;
        Tue,  8 Dec 2020 05:49:37 -0800 (PST)
Received: by mail-il1-x143.google.com with SMTP id v3so15558022ilo.5;
        Tue, 08 Dec 2020 05:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MQXYbDMPL3yLYU7/kBOYlmtMsBjUqShGbSk3HBKaf8g=;
        b=qB1tZR3lpatG/0Zal3n5vfTlz2EOHV54ihJtai6PxbNg83npjonBDrtvWxoWqKEHMn
         boRmt5oXMbD5LvNj4OeZIaYR+ST5n8gpvHjkcbEIXqJUaprLoWbQkHTTjPeAci8N94HW
         loWBBpYEAkEob3/Cv/C1sDTjjxUvN4st0YeCB3Q7TQMzPQ2R19sISFXvvnF0zyV1kyGG
         5w2kMfl/y3PE7p++iIOkxI/Zia39QDXZ+OQI8WiAlzXHgdbj92dbSCukLUIPqjMD5QM/
         rvn5FhYjVTgU4PQvs1yECbhgurO+i+oCHAWjXh/zVWbgcNWS8WRzHjBnt5RoSNZ5bFhQ
         nhvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MQXYbDMPL3yLYU7/kBOYlmtMsBjUqShGbSk3HBKaf8g=;
        b=jI0ul73ONQ1eM/zORf7+g7lsPQAkLiR5j7TpcJkcQzO7iT6wUzpmzX5RRHY9GyrYGk
         pYxzuH3Y2hZs/6+laaaAKVHfQu+se0VFgzGa/tKqvi83QHlafGlJLXYwfvjOShugFSel
         L7+vqwA3oyelO8LmT4Rzbz4NquqrmfNoSdxAwQ0aDN1nsDiA6419u4GF981NoUsifXGd
         k93boS5lvCjB30Ca/lmlLMGGwN7EwnxcRiE90whoiAYTKNF54DTdlLpLroKYGIa/+lAB
         USl+iFkF7RUtXQEU8EpFiRnnnB94ENSsOBLcN3+uGyykcqHS/ZwJPrX9sps4IrvMbyTd
         BwoA==
X-Gm-Message-State: AOAM530DViDqOMsZgqiIKOuh2R9OYTYdztqt7+6+6s8jqW/ey24LgUTq
        X1WT6fmuWmclGtmJ1a33H+BpylK/13FyybNnmTudX1Cx410=
X-Google-Smtp-Source: ABdhPJzs16Xbq9yXw4nMJe03SEuYZzH2JW3YVHgNPO0ogZUhHvZ9E49JOk1KNqGKQdSDMeXaSAPZ0uvc65/dx2fdz1w=
X-Received: by 2002:a05:6e02:14ce:: with SMTP id o14mr27386946ilk.9.1607435376411;
 Tue, 08 Dec 2020 05:49:36 -0800 (PST)
MIME-Version: 1.0
References: <20201207163255.564116-1-mszeredi@redhat.com> <20201207163255.564116-4-mszeredi@redhat.com>
In-Reply-To: <20201207163255.564116-4-mszeredi@redhat.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 8 Dec 2020 15:49:25 +0200
Message-ID: <CAOQ4uxhti+COYB3GhfMcPFwpfBRYQvr98oCO9wwS029W5e0A5g@mail.gmail.com>
Subject: Re: [PATCH v2 03/10] ovl: check privs before decoding file handle
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     "Eric W . Biederman" <ebiederm@xmission.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 7, 2020 at 6:36 PM Miklos Szeredi <mszeredi@redhat.com> wrote:
>
> CAP_DAC_READ_SEARCH is required by open_by_handle_at(2) so check it in
> ovl_decode_real_fh() as well to prevent privilege escalation for
> unprivileged overlay mounts.
>
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---
>  fs/overlayfs/namei.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
> index a6162c4076db..82a55fdb1e7a 100644
> --- a/fs/overlayfs/namei.c
> +++ b/fs/overlayfs/namei.c
> @@ -156,6 +156,9 @@ struct dentry *ovl_decode_real_fh(struct ovl_fh *fh, struct vfsmount *mnt,
>         struct dentry *real;
>         int bytes;
>
> +       if (!capable(CAP_DAC_READ_SEARCH))
> +               return NULL;
> +

If the mounter is not capable in init ns, ovl_check_origin() and
ovl_verify_index()
will not function as expected and this will break index and nfs export features.
So I think we need to also check capability in ovl_can_decode_fh(), to auto
disable those features.

Thanks,
Amir.
