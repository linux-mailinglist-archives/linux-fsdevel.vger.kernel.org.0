Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF39CD5D5B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2019 10:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730232AbfJNI0D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Oct 2019 04:26:03 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:39257 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729928AbfJNI0D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Oct 2019 04:26:03 -0400
Received: by mail-io1-f67.google.com with SMTP id a1so36176952ioc.6
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Oct 2019 01:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dzjiSE/0Hpa/u2YaEx0I4w/Q55oG4EeAA+DOe/kfQpI=;
        b=NvAaWST2THpyF4Kn9wSoX+o2whIh7NEn/hw3uOSfYQN6I5Zjb67L3LF7wQkB5GvQ9J
         5jfuDUsqLN40UPKCAexpgPCIU2CH3gsQlekwOQKCFOrEWQ7ZiVHybUIB3XSycxxozVFH
         FsQjec16Q2eU/NP5AF6OusDF0wf0SsXUCy9l4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dzjiSE/0Hpa/u2YaEx0I4w/Q55oG4EeAA+DOe/kfQpI=;
        b=ilAoOoxY95REsQDcDQHE0k6qubhnGujEp5IFy6Nlny4mlqE1N5c9O/9gKVdug9El6c
         DnihmT1hmA0ckt0o+4AwkyHIZz8paclQW+1EmwtDkwPm7Tni2TZ41oPZSJzDyWWGISlS
         L2Pg9NtccLQ0Rr2Ddw2V+iyq057k4b1SG6RaMlP6DwdaVcuV+FOuzZf+PMr5RL1tr+hI
         ex7RJiZ//04ihWjbDqbJ1Ow2XrCoBqh95H2BU4B7+4IGixWl0qio4zm/Cz5N2tzWgHkV
         v9l7RljL4Ppg/250xHwXznRaNWrd4etw2DIH75TYdeLIWa4asiwGZxgV564xcC8VeHFK
         ULiA==
X-Gm-Message-State: APjAAAVbhLWVU90WtFUmdQQ5LhKRbggW3RLhTCMbFlCZClq5nxhinTsj
        FlJiXnf/l6Lq5gMci2FmIjjfKkd7P4FwblawAyaNUQ==
X-Google-Smtp-Source: APXvYqwvV5x/l2UH0XYVcrzZxXwNg2X0c+8qMB23bstSN0D8RxQO1UjkUYT5ymr3LYd3ZCIgje4SWS3yXr1cbSAev9w=
X-Received: by 2002:a5d:9d89:: with SMTP id 9mr17374751ion.63.1571041562765;
 Mon, 14 Oct 2019 01:26:02 -0700 (PDT)
MIME-Version: 1.0
References: <20191011181826.GA13861@redhat.com>
In-Reply-To: <20191011181826.GA13861@redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 14 Oct 2019 10:25:51 +0200
Message-ID: <CAJfpegv8p--fS5LeVJB2zpon1iXzqTYccyJRojd2Ef_Dv_U84w@mail.gmail.com>
Subject: Re: [PATCH] virtio_fs: Change module name to virtiofs.ko
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com,
        msys.mizuma@gmail.com, Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 11, 2019 at 8:18 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> We have been calling it virtio_fs and even file name is virtio_fs.c. Module
> name is virtio_fs.ko but when registering file system user is supposed to
> specify filesystem type as "virtiofs".
>
> Masayoshi Mizuma reported that he specified filesytem type as "virtio_fs" and
> got this warning on console.
>
>   ------------[ cut here ]------------
>   request_module fs-virtio_fs succeeded, but still no fs?
>   WARNING: CPU: 1 PID: 1234 at fs/filesystems.c:274 get_fs_type+0x12c/0x138
>   Modules linked in: ... virtio_fs fuse virtio_net net_failover ...
>   CPU: 1 PID: 1234 Comm: mount Not tainted 5.4.0-rc1 #1
>
> So looks like kernel could find the module virtio_fs.ko but could not find
> filesystem type after that.
>
> It probably is better to rename module name to virtiofs.ko so that above
> warning goes away in case user ends up specifying wrong fs name.
>
> Reported-by: Masayoshi Mizuma <msys.mizuma@gmail.com>
> Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>

Thanks, applied.

Miklos
