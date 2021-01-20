Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8653F2FD3DB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Jan 2021 16:23:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387726AbhATPXG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Jan 2021 10:23:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388178AbhATPJn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Jan 2021 10:09:43 -0500
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C96C061793
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Jan 2021 07:09:06 -0800 (PST)
Received: by mail-vs1-xe34.google.com with SMTP id f22so4743359vsk.11
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Jan 2021 07:09:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J62/J/XAou8PPpMjptVAh595wK8zuN47tW6YivACb7g=;
        b=OfRbWIubxlxgLCcsHqbz9LwPT3gkD3ESK6NBQ7MWo1wulug7Z1X4vpjlbY/d8VIdUC
         lYz8M3B14Nn4CpafRYpyhqkorfXnKAfp2XPodHkgA9hS1y84zHJ7rV9pX+++85eK22M9
         bKTchAZJ+wB5smg9s0G+HEy2TlfTt42QDOocY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J62/J/XAou8PPpMjptVAh595wK8zuN47tW6YivACb7g=;
        b=bjKdDDzU93w05FAC64biVN4msktNh3RbaBkZKK7fKZ08OftdjxJWop0dHz8yzJ4TVC
         ePkzqNV3KLfSzNksrAJ3+o8k8dBS2zDgrUMXl3GgJjEtt07UqDCYt1CWXiL5Ope6KLKq
         COqQlV/YvYgPDuBFccuodWyQM4757YvVE5ExciLMJLStB7T9b/J47x8fh63dqYLqMkUT
         KrDTHjlZxoyOrDl1izfv0HS0VNDTLfjFh9H1xpxLal1OeGPZ+XQvvq414dam4x0mOhLl
         GNHba+yjrdkpedJcfzIviMiVWGfaWYXS2pMuVQzP8xSKA+bJiH7E2ztCUUwhNIwGRonx
         /Ezg==
X-Gm-Message-State: AOAM530zmEqGRujEaE362EQIvivB8zRKKoaU7ZmPUWlCV/Hvc0Kuly10
        66WYGRBISdNQOQnX9YGDldZ2O5UXw+A4pi5v9LRB6A==
X-Google-Smtp-Source: ABdhPJyL8DZfH4426aeReArAsYtr4ShME3vG0GcZmg75V2ocaT9ah7XkNI+SEMx/OLns92YbF0aFV3Pp+yJszLUIlO0=
X-Received: by 2002:a67:f991:: with SMTP id b17mr6900762vsq.0.1611155345960;
 Wed, 20 Jan 2021 07:09:05 -0800 (PST)
MIME-Version: 1.0
References: <20210108001043.12683-1-sargun@sargun.me>
In-Reply-To: <20210108001043.12683-1-sargun@sargun.me>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 20 Jan 2021 16:08:55 +0100
Message-ID: <CAJfpegvm0o=rF7SJHQgkWZ-MdDkjLrnTcUunQiq8L9GT6==q1A@mail.gmail.com>
Subject: Re: [PATCH v4] overlay: Implement volatile-specific fsync error behaviour
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     overlayfs <linux-unionfs@vger.kernel.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Daniel J Walsh <dwalsh@redhat.com>,
        linux-fsdevel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Chengguang Xu <cgxu519@mykernel.net>,
        Christoph Hellwig <hch@lst.de>, NeilBrown <neilb@suse.com>,
        Jan Kara <jack@suse.cz>, stable <stable@vger.kernel.org>,
        Jeff Layton <jlayton@redhat.com>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 8, 2021 at 1:10 AM Sargun Dhillon <sargun@sargun.me> wrote:
>
> Overlayfs's volatile option allows the user to bypass all forced sync calls
> to the upperdir filesystem. This comes at the cost of safety. We can never
> ensure that the user's data is intact, but we can make a best effort to
> expose whether or not the data is likely to be in a bad state.
>
> The best way to handle this in the time being is that if an overlayfs's
> upperdir experiences an error after a volatile mount occurs, that error
> will be returned on fsync, fdatasync, sync, and syncfs. This is
> contradictory to the traditional behaviour of VFS which fails the call
> once, and only raises an error if a subsequent fsync error has occurred,
> and been raised by the filesystem.
>
> One awkward aspect of the patch is that we have to manually set the
> superblock's errseq_t after the sync_fs callback as opposed to just
> returning an error from syncfs. This is because the call chain looks
> something like this:
>
> sys_syncfs ->
>         sync_filesystem ->
>                 __sync_filesystem ->
>                         /* The return value is ignored here
>                         sb->s_op->sync_fs(sb)
>                         _sync_blockdev
>                 /* Where the VFS fetches the error to raise to userspace */
>                 errseq_check_and_advance
>
> Because of this we call errseq_set every time the sync_fs callback occurs.
> Due to the nature of this seen / unseen dichotomy, if the upperdir is an
> inconsistent state at the initial mount time, overlayfs will refuse to
> mount, as overlayfs cannot get a snapshot of the upperdir's errseq that
> will increment on error until the user calls syncfs.

Thanks, this makes sense.  Queued for v4.11.

Miklos
