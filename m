Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64E8D2DF658
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Dec 2020 18:57:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbgLTR5n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 20 Dec 2020 12:57:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726772AbgLTR5n (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 20 Dec 2020 12:57:43 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6560BC061282
        for <linux-fsdevel@vger.kernel.org>; Sun, 20 Dec 2020 09:56:55 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id b26so8757048lff.9
        for <linux-fsdevel@vger.kernel.org>; Sun, 20 Dec 2020 09:56:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7b0gkK7KHhPn0zAFL1kzHO6kSwnlYNj5eys9b5uk2rw=;
        b=SMVUrbTSnmrB0Nxh4cqTA47ayzjD7TZ0pGasqhIK5my/U27HsopJpWZRPolSCLgXct
         EOfHJpdcCZpPJLDSzxZbpaKTMBcEAe9a8w+JG7sNePREMfvlOXVbHtpiY837q0KnhiFX
         NVj5qVDh2xyIwdudtze0eVoMej9PyBbkFMj9ZbnPtMP8gC9H3ut72bJDzebryrdEu+vU
         RG6S4KWpOckZ6O+3wa7CC3wscuax1MYXrMSNaVYwKTFYN8qhsJ1/yL6+mtCyALpaKKxA
         i8k2xsF0O1vkT626bHsBWX6vaBzzzJIGWXshV99/LzfXrNZBh3DbVFpWYwrEoPe+ypjv
         DFMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7b0gkK7KHhPn0zAFL1kzHO6kSwnlYNj5eys9b5uk2rw=;
        b=EPu573TDJodFQ2KXB80iLlwCZD30rm1GGkWNsSIc18cdVQTnQZoPHyH9MbfqbsvP0m
         UDbM0YTL5SU/NmMiZbjmg+pzEmsG9A1BKjFIPw0/WpDWYlvQFeh7PgUPOMFgpMc5ZYQf
         gcwOPTz2nh28V++SRdlYjAOjJsb/4e2pzs2JQBy6d+HZe+vkjlPgcwzVe9bKNBGeqmB0
         U7tiGmOiN7I/RCfr5MvlZrxYoc2PvDY7QLefB+0G9kTSr5yfwST81TjPdypRDbPkvWR6
         ZHGdBwOMsLLj9qCBt79RyTWxgFqxHrI7qpOIfyB46ZkBzkhCkgq21PjJ24tbh4MDPlDA
         uqgA==
X-Gm-Message-State: AOAM531DGz8b2TG8+n6DBUZOtSU2cJVzH7MxMSUhdhv1GUrzBw/ihad1
        P64trb8ifGgejh4TXmiDtkD2dkSpFQHVfUIBijK07Q==
X-Google-Smtp-Source: ABdhPJzaVhazd1F3HG5VODuP++uhv/7yUtoVoYzQQW89NkZx6JtS7/VnMpWrWMU5nPPqW+c4xEbt7oo2VNMCPYtgNrQ=
X-Received: by 2002:a05:6512:1082:: with SMTP id j2mr4983204lfg.347.1608487013528;
 Sun, 20 Dec 2020 09:56:53 -0800 (PST)
MIME-Version: 1.0
References: <20201220044608.1258123-1-shakeelb@google.com> <CAOQ4uxi4b-zXfWhLNQ+aGWn2qG3vqMCjkJnhrugc0+oER1EjUA@mail.gmail.com>
In-Reply-To: <CAOQ4uxi4b-zXfWhLNQ+aGWn2qG3vqMCjkJnhrugc0+oER1EjUA@mail.gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Sun, 20 Dec 2020 09:56:42 -0800
Message-ID: <CALvZod4oTAysAqW9aotPgx1Qx+aL91LEiR5OiMt27=e3VJ6aVQ@mail.gmail.com>
Subject: Re: [PATCH v2] inotify, memcg: account inotify instances to kmemcg
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Dec 20, 2020 at 3:32 AM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Sun, Dec 20, 2020 at 6:46 AM Shakeel Butt <shakeelb@google.com> wrote:
> >
> > Currently the fs sysctl inotify/max_user_instances is used to limit the
> > number of inotify instances on the system. For systems running multiple
> > workloads, the per-user namespace sysctl max_inotify_instances can be
> > used to further partition inotify instances. However there is no easy
> > way to set a sensible system level max limit on inotify instances and
> > further partition it between the workloads. It is much easier to charge
> > the underlying resource (i.e. memory) behind the inotify instances to
> > the memcg of the workload and let their memory limits limit the number
> > of inotify instances they can create.
> >
> > With inotify instances charged to memcg, the admin can simply set
> > max_user_instances to INT_MAX and let the memcg limits of the jobs limit
> > their inotify instances.
> >
> > Signed-off-by: Shakeel Butt <shakeelb@google.com>
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Thanks a lot.
