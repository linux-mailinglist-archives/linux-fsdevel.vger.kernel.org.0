Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D86A93E2A78
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Aug 2021 14:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243631AbhHFMUb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Aug 2021 08:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240880AbhHFMUa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Aug 2021 08:20:30 -0400
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41948C061798
        for <linux-fsdevel@vger.kernel.org>; Fri,  6 Aug 2021 05:20:15 -0700 (PDT)
Received: by mail-ua1-x929.google.com with SMTP id 67so3533597uaq.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Aug 2021 05:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oiCQmjcuFhGkdG2W1lTVHnyiSQ0DlavkjF9Jf4O0LGs=;
        b=PSnpv7525v/UcC+LRlNq4ja60owqqXEJNSn8nTAhj5zd8bHJOsJGZ4GjyOyrNudAre
         NUodOg/sRzfItscJFSKUlw+q69eHED5v0QFX3wa1b3j4uCSqnAtaKspYpWYqpVm2thvT
         Ox2j1klpkQMgTij8sNIhBpKXXuDj9SSFsTV+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oiCQmjcuFhGkdG2W1lTVHnyiSQ0DlavkjF9Jf4O0LGs=;
        b=amZMPVOreekiuRWj37cjXVg3A5yl6i/ZMRFpqBmm0xexHAamWAeNaQUT0znFQL8CTo
         RUbjjQHHe+Klf3OIF537A21vICvoe0E7lrLyQu27h9jnCSL1gG9HaHWARD/CAlftsPo5
         5lQ93tZ1MhYF4ifO6DfMmW5ID7DZJsRZGWkAwPJQY/rkLfNQhMqFA+1xhenyNZuBYgjD
         6b/GKqCB4UkWhHqVp5iOKDxvOvmnI2hBjT9/CcUYUPeUSsuxmxv/xafI6Eny5e8HTh3h
         hqhNEKkLjhQZc+bDQQjwko3yAC6CyC80IhuySjJMgLMnIrsub/s6cU+wNI2wZH7Z5wbD
         8qQA==
X-Gm-Message-State: AOAM530brvrpy/r/1+JDzX3Ay5o3Komk+pFGmwT4EZAZCOhEZLTBTzMx
        EMD4PSkRomOxbqVSQH9/CSjzrOOCdiBdzkGZlmri5Q==
X-Google-Smtp-Source: ABdhPJwrfLgulh0XLge+Uu/HEb9j/NXkNu+ozFvgZ7xBgtJwqnb6PkFa0v+3In2UNMAJ0XzGqRwZ0XbSHzwmMBzAGu8=
X-Received: by 2002:ab0:5e92:: with SMTP id y18mr8056619uag.9.1628252414371;
 Fri, 06 Aug 2021 05:20:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210130085003.1392-1-changfengnan@vivo.com> <CAJfpegutK2HGYUtJOjvceULf2H=hoekNxUbcg=6Su6uteVmDLg@mail.gmail.com>
 <3e740389-9734-a959-a88a-3b1d54b59e22@vivo.com> <CAJfpegtes4CGM68Vj2GxmvK2S8D5sn4Pv_RKyXb33ye=pC+=cg@mail.gmail.com>
 <29a3623f-fb4d-2a2b-af28-26f9ef0b0764@vivo.com>
In-Reply-To: <29a3623f-fb4d-2a2b-af28-26f9ef0b0764@vivo.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 6 Aug 2021 14:20:03 +0200
Message-ID: <CAJfpeguErrcKc7CKjnp-uM9VMyUjrtjipv7KGSu5xeY9joOQxQ@mail.gmail.com>
Subject: Re: [PATCH v2] fuse: use newer inode info when writeback cache is enabled
To:     Fengnan Chang <changfengnan@vivo.com>
Cc:     linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 24 Jun 2021 at 09:42, Fengnan Chang <changfengnan@vivo.com> wrote:
>
> Hi Miklos:
>
> Thank you for the information, I have been able to reproduce the problem.
>
> The new version of the patch as below. Previous fsx test is pass now.
> Need do more test, Can you help to test new patch? or send me your test
> case, I will test this.
>
> Here is my test case, and is the problem this patch is trying to solve.
> Case A:
> mkdir /tmp/test
> passthrough_ll -ocache=always,writeback /mnt/test/
> echo "11111" > /tmp/test/fsx
> ls -l /mnt/test/tmp/test/
> echo "2222" >> /tmp/test/fsx
> ls -l /mnt/test/tmp/test/
>
> Case B:
> mkdir /tmp/test
> passthrough_ll -ocache=always,writeback /mnt/test/
> passthrough_ll -ocache=always,writeback /mnt/test2/
> echo "11111" > /tmp/test/fsx
> ls -l /mnt/test/tmp/test/
> ls -l /mnt/test2/tmp/test/
> echo "222" >> /mnt/test/tmp/test/fsx
> ls -l /mnt/test/tmp/test/
> ls -l /mnt/test2/tmp/test/

Both these testcases have the "cache=always" option, which means:
cached values (both data and metadata) are always valid; i.e. changes
will be made only through this client and not through some other
channel (like the backing filesystem or another instance).

Why is "cache=always" used?

Thanks,
Miklos
