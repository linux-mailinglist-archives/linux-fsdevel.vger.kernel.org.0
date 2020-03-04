Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52CC9179499
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2020 17:11:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729838AbgCDQLK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Mar 2020 11:11:10 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:37771 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729823AbgCDQLK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Mar 2020 11:11:10 -0500
Received: by mail-io1-f66.google.com with SMTP id c17so3003090ioc.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Mar 2020 08:11:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hMEhfSBOuHBIl6yeEV5DUSKkA5QymXhcDODBiotx5S4=;
        b=M6T8IJrP2imFH0Yrd72S712RTyLiBCBZZIWukQqQGCNrzxUDeKQu+PKXQBiP9CDW2H
         mlHwDsX+W9ASgLJqXkUJnHsYp6dMv5PNAIM+ZT80/uVANpT/Tbmh4N59WO3elb0FAsQC
         gfqYvlbSsf1UyETpTERI2GLvpo1mqkHwGPlGk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hMEhfSBOuHBIl6yeEV5DUSKkA5QymXhcDODBiotx5S4=;
        b=fhUw4A2hYCi1+aqpScUaR0/34qS4UiNBR/0Z5t6oN7/nS7EK9W/xBtGLyGGPfgLcSL
         HbjnhE1WfCgj3lYZo3YeM3b+IYMWaeox3u9PIyscMNMs9m9oeNV/PFPSttU79uYKtjcP
         F8WTAdhx1PC8+m8HJWFjvgqmble+a7W+HzCinZ29QjIugj6aWiH7jjjaYIjaSpdnTuZX
         uNJOYWWkCUWnJ9aGYe/iLl8ae7ArNpKz8wY2ElKxwftKUzzNhKKZ/2GjCDZL+suBSEWR
         XYEdE+34BhtVKzsrc7KiPiQ15mAD6BFeoRj/vhXamq4zkaLYjL+9c/ND6x2wOfQGcLQt
         OiQg==
X-Gm-Message-State: ANhLgQ0C1/geto/ZQlH73Wiqg9spVKpXnv80JOlqjox3QVujSNzvM6RV
        D4saYLHFh9DH3DCMX5qCo0M6udRwk7OSGnxS+1wf/Q==
X-Google-Smtp-Source: ADFU+vv3dF1eDGfu6HnlNnsm2H3QO09qbn9v3Km2uZitDG2c+ztP3h8bSrNDMa2kQSpJfI9anLFWwxmDff5HPQtsH5U=
X-Received: by 2002:a6b:f409:: with SMTP id i9mr2669177iog.212.1583338269532;
 Wed, 04 Mar 2020 08:11:09 -0800 (PST)
MIME-Version: 1.0
References: <158230810644.2185128.16726948836367716086.stgit@warthog.procyon.org.uk>
 <158230818859.2185128.8921928947340497977.stgit@warthog.procyon.org.uk>
In-Reply-To: <158230818859.2185128.8921928947340497977.stgit@warthog.procyon.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 4 Mar 2020 17:10:58 +0100
Message-ID: <CAJfpeguyyC=E51gJ3EkQjLsqjZ8Mt35Eu7f9cQtBJaTFEcxoRg@mail.gmail.com>
Subject: Re: [PATCH 10/17] fsinfo: Allow mount information to be queried [ver #17]
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 21, 2020 at 7:03 PM David Howells <dhowells@redhat.com> wrote:
 +
> +/*
> + * Return information about the submounts relative to path.
> + */
> +int fsinfo_generic_mount_children(struct path *path, struct fsinfo_context *ctx)
> +{
> +       struct fsinfo_mount_child record;
> +       struct mount *m, *child;
> +
> +       if (!path->mnt)
> +               return -ENODATA;
> +
> +       m = real_mount(path->mnt);
> +
> +       rcu_read_lock();
> +       list_for_each_entry_rcu(child, &m->mnt_mounts, mnt_child) {

mnt_mounts is not using _rcu primitives, so why is this rcu safe?

Thanks,
Miklos
