Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0544727DF92
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Sep 2020 06:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725788AbgI3EgK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Sep 2020 00:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbgI3EgJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Sep 2020 00:36:09 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AC42C0613D0
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Sep 2020 21:36:09 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id e5so302980ilr.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Sep 2020 21:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T1aa/+Iyk5V9x9EGc/B3ToDnogl7jgNiyHzotNGV3ew=;
        b=ZdSDHne7Q0M8HvyMu6+o4cguPWzzhen9CQx4Guc14IMEkK142ZpIJEgIW8QgBeyLBp
         zZvPO4elsyEIKzvbjNzyxhyhR1qCm+0dWk4mcZoeltAz1wzgJ5x+dt7sqxWNjJ4Qf/Fk
         MMAErv0wsdw07SY/+C6vh87cS7rd8wpxxpwGONeOYfDz8biri3Jqq5dWhMyIblqvHnfJ
         QDZZLM3JFYrTzBjqlgB8+NFfy664wbn4f2E6ODW2vdh8rcq0lYNiEmZJS+o+OZFNlLTv
         ASS4nVZFb8HLtzufl7dMopwHYS1lg0YAU+fmQ1fa6CCo0LZvIomv2Dsp8I/BqHEUEeJW
         QOEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T1aa/+Iyk5V9x9EGc/B3ToDnogl7jgNiyHzotNGV3ew=;
        b=pI64orROyLyL8m2Dt/ovyqCNEmnjGXMaDAAdYpwiGjHtPJhCiUNNMSYBOJO14VbsDt
         Q4LUXa+dhokLn92HSpSSvbsQiEq3p3g9Tn21jghmaxShP10qfC358I+iwZPcbrOe7uXj
         HG+Wo4pQa8DZfx4aJIHtCGGtrbcgnIU0NKvmqcdv7opmXKQxnMXF6knsCGYB5kTqEjzy
         RL9sUC9/BnWW2SkapuJjUSUzWBma8rp6eilMRY6f1ojQ3qvYCOUbxU8OVmiljGPcDdYv
         OchxAU0qvvWQ87vbn5yOxRL8QT/YeXrnD4JtTWqVFXCkWodWQVRt9ab7nHXmsgJmsGkq
         qv+Q==
X-Gm-Message-State: AOAM532oohiP2eFZWEUxOpBuQ7Ik5Q+ZBS236YUJ97QUDeodZgtlgq/T
        TJzz/BOtiw1zruIHi065GiB2gsW77EfNkUWEmfQ=
X-Google-Smtp-Source: ABdhPJyDuz7TP9AEp7HTIHNPosyeOL9y2Gq7s3j51hGYDldmajH3ZV1OWjkLXGkprLdcvndSvy4o1DWYB7J96OyHBFE=
X-Received: by 2002:a92:6403:: with SMTP id y3mr562280ilb.72.1601440568771;
 Tue, 29 Sep 2020 21:36:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200929185015.GG220516@redhat.com>
In-Reply-To: <20200929185015.GG220516@redhat.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 30 Sep 2020 07:35:57 +0300
Message-ID: <CAOQ4uxgMeWF_vitenBY6_N3Eu-ix92q8AO5ckDAF+SVxHTBXXw@mail.gmail.com>
Subject: Re: [RFC PATCH] fuse: update attributes on read() only on timeout
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Linux fsdevel mailing list <linux-fsdevel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        virtio-fs-list <virtio-fs@redhat.com>,
        Brian Foster <bfoster@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 29, 2020 at 9:52 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> Following commit added a flag to invalidate guest page cache automatically.
>
> 72d0d248ca823 fuse: add FUSE_AUTO_INVAL_DATA init flag
>
> Idea seemed to be that for network file systmes if client A modifies
> the file, then client B should be able to detect that mtime of file
> change and invalidate its own cache and fetch new data from server.
>
> There are few questions/issues with this method.
>
> How soon client B able to detect that file has changed. Should it
> first GETATTR from server for every READ and compare mtime. That
> will be much stronger cache coherency but very slow because every
> READ will first be preceeded by a GETATTR.
>
> Or should this be driven by inode timeout. That is if inode cached attrs
> (including mtime) have timed out, we fetch new mtime from server and
> invalidate cache based on that.
>
> Current logic calls fuse_update_attr() on every READ. But that method
> will result in GETATTR only if either attrs have timedout or if cached
> attrs have been invalidated.
>
> If client B is only doing READs (and not WRITEs), then attrs should be
> valid for inode timeout interval. And that means client B will detect
> mtime change only after timeout interval.
>
> But if client B is also doing WRITE, then once WRITE completes, we
> invalidate cached attrs. That means next READ will force GETATTR()
> and invalidate page cache. In this case client B will detect the
> change by client A much sooner but it can't differentiate between
> its own WRITEs and by another client WRITE. So every WRITE followed
> by READ will result in GETATTR, followed by page cache invalidation
> and performance suffers in mixed read/write workloads.
>
> I am assuming that intent of auto_inval_data is to detect changes
> by another client but it can take up to "inode timeout" seconds
> to detect that change. (And it does not guarantee an immidiate change
> detection).
>
> If above assumption is acceptable, then I am proposing this patch
> which will update attrs on READ only if attrs have timed out. This
> means every second we will do a GETATTR and invalidate page cache.
>
> This is also suboptimal because only if client B is writing, our
> cache is still valid but we will still invalidate it after 1 second.
> But we don't have a good mechanism to differentiate between our own
> changes and another client's changes. So this is probably second
> best method to reduce the extent of issue.
>

I was under the impression that virtiofs in now in the stage of stabilizing the
"all changes are from this client and no local changes on server" use case.
Is that the case? I remember you also had an idea to communicate that this
is the use case on connection setup time for SB_NOSEC which did not happen.

If that is the case, why use auto_inval_data at all for virtiofs and not
explicit_inval_data?
Is that because you do want to allow local changes on the server?

I wonder out loud if this change of behavior you proposed is a good opportunity
to introduce some of the verbs from SMB oplocks / NFS delegations into the
FUSE protocol in order to allow finer grained control over per-file
(and later also
per-directory) caching behavior.

Thanks,
Amir.
